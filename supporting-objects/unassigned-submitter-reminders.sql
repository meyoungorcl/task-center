set define off
set serveroutput on
whenever sqlerror exit sql.sqlcode rollback
begin
  execute immediate 'alter table tsk_email_schedules drop constraint tsk_email_schedules_code_ck';
exception
  when others then
    if sqlcode != -2443 then
      raise;
    end if;
end;
/
alter table tsk_email_schedules add constraint tsk_email_schedules_code_ck check (schedule_code in ('DAILY_MEMBER_STATUS','DAILY_UNASSIGNED_SUBMITTER','WEEKLY_TEAM_SUMMARY','MONTHLY_TEAM_PROGRESS')) enable;
merge into tsk_email_schedules dst
using (
  select 7 as email_schedule_id,
         1 as team_id,
         'DAILY_UNASSIGNED_SUBMITTER' as schedule_code,
         'Daily Unassigned Task Submitter Reminder' as schedule_name,
         'Y' as enabled_yn,
         8 as send_hour,
         0 as send_minute,
         'TEAM_MEMBERS' as recipients_scope
    from dual
) src
on (dst.schedule_code = src.schedule_code)
when matched then update set
  dst.team_id = src.team_id,
  dst.schedule_name = src.schedule_name,
  dst.enabled_yn = src.enabled_yn,
  dst.send_hour = src.send_hour,
  dst.send_minute = src.send_minute,
  dst.recipients_scope = src.recipients_scope,
  dst.updated_at = systimestamp,
  dst.updated_by = coalesce(sys_context('APEX$SESSION','APP_USER'), user)
when not matched then insert (
  email_schedule_id, team_id, schedule_code, schedule_name, enabled_yn,
  send_hour, send_minute, weekly_day_number, recipients_scope,
  include_assigned_tasks_yn, include_task_updates_yn, include_overdue_tasks_yn, include_comments_yn,
  created_at, created_by, updated_at, updated_by, send_at
) values (
  src.email_schedule_id, src.team_id, src.schedule_code, src.schedule_name, src.enabled_yn,
  src.send_hour, src.send_minute, null, src.recipients_scope,
  'Y', 'Y', 'Y', 'Y',
  systimestamp, coalesce(sys_context('APEX$SESSION','APP_USER'), user),
  systimestamp, coalesce(sys_context('APEX$SESSION','APP_USER'), user), null
);
commit;
  CREATE OR REPLACE EDITIONABLE PACKAGE "TSK_DAILY_EMAIL_PKG" as
    function member_email_subject (
        p_team_member_id in number,
        p_run_date       in date default trunc(sysdate)
    ) return varchar2;

    function member_email_html (
        p_team_member_id in number,
        p_run_date       in date default trunc(sysdate)
    ) return clob;

    function monthly_team_subject (
        p_team_id  in number,
        p_run_date in date default trunc(sysdate)
    ) return varchar2;

    function monthly_team_html (
        p_team_id  in number,
        p_run_date in date default trunc(sysdate)
    ) return clob;

    function selected_schedule_is (
        p_email_schedule_id in number,
        p_schedule_code     in varchar2
    ) return boolean;

    function unassigned_submitter_reminder_html (
        p_email_schedule_id in number,
        p_team_member_id    in number default null,
        p_run_date          in date default trunc(sysdate)
    ) return clob;

    procedure send_daily_summaries;
    procedure send_daily_schedule (
        p_email_schedule_id in number
    );
    procedure send_unassigned_submitter_reminders (
        p_email_schedule_id in number
    );
    procedure send_monthly_summaries;
    procedure sync_scheduler_jobs;
end tsk_daily_email_pkg;

/


  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "TSK_DAILY_EMAIL_PKG" as

    c_workspace constant varchar2(30) := 'DBAPPDEV';

    c_app_id    constant number := 12892;


    procedure set_apex_context is

    begin

        apex_util.set_security_group_id(

            apex_util.find_security_group_id(p_workspace => c_workspace)

        );

    end set_apex_context;


    function selected_schedule_is (

        p_email_schedule_id in number,

        p_schedule_code     in varchar2

    ) return boolean is

        l_count number;

    begin

        select count(*)

          into l_count

          from tsk_email_schedules

         where email_schedule_id = coalesce(

                   p_email_schedule_id,

                   (select min(email_schedule_id) from tsk_email_schedules)

               )

           and schedule_code = p_schedule_code;


        return l_count > 0;

    end selected_schedule_is;


    function task_url (

        p_task_id in number

    ) return varchar2 is

    begin

        return apex_mail.get_instance_url ||

               apex_page.get_url(

                   p_application => c_app_id,

                   p_page        => 12,

                   p_session     => 0,

                   p_clear_cache => '12',

                   p_items       => 'P12_TASK_ID',

                   p_values      => p_task_id,

                   p_plain_url   => true

               );

    end task_url;


    function html_href (

        p_url in varchar2

    ) return varchar2 is

    begin

        return replace(

                   replace(

                       replace(

                           replace(p_url, '&', '&amp;'),

                           '"', '&quot;'

                       ),

                       '<', '&lt;'

                   ),

                   '>', '&gt;'

               );

    end html_href;


    function member_email_subject (

        p_team_member_id in number,

        p_run_date       in date default trunc(sysdate)

    ) return varchar2 is

        l_display_name tsk_users.display_name%type;

    begin

        select u.display_name

          into l_display_name

          from tsk_team_members tm

          join tsk_users u

            on u.user_id = tm.user_id

         where tm.team_member_id = p_team_member_id;


        return 'Daily Task Summary for ' || l_display_name || ' - ' ||

               to_char(p_run_date, 'Mon DD, YYYY');

    exception

        when no_data_found then

            return 'Daily Task Summary - ' || to_char(p_run_date, 'Mon DD, YYYY');

    end member_email_subject;


    function member_email_html (

        p_team_member_id in number,

        p_run_date       in date default trunc(sysdate)

    ) return clob is

        l_html clob;

        l_summary tsk_v_daily_member_email%rowtype;

        l_has_due_tasks boolean := false;

        l_has_missing_due_tasks boolean := false;

    begin

        set_apex_context;


        select *

          into l_summary

          from tsk_v_daily_member_email

         where team_member_id = p_team_member_id;


        l_html :=

            '<div style="font-family:Arial,sans-serif;color:#172033;line-height:1.45">' ||

            '<h2 style="margin:0 0 4px">Daily Task Summary</h2>' ||

            '<div style="color:#5f6b7a;margin-bottom:18px">' ||

            apex_escape.html(l_summary.display_name) || ' &#8226; ' ||

            apex_escape.html(l_summary.team_name) || ' &#8226; ' ||

            to_char(p_run_date, 'Dy, Mon DD, YYYY') ||

            '</div>' ||

            '<table role="presentation" style="border-collapse:collapse;margin-bottom:18px;width:100%"><tr>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || l_summary.open_tasks || '</strong><br>Open</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || l_summary.in_progress_tasks || '</strong><br>In Progress</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || l_summary.due_today_tasks || '</strong><br>Due Today</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong style="color:#b42318">' || l_summary.overdue_tasks || '</strong><br>Overdue</td>' ||

            '</tr></table>' ||

            '<h3 style="margin:0 0 10px">Not Started or In Progress With Due Dates</h3>';


        for r in (

            select v.task_id,

                   v.task_key,

                   v.title,

                   v.status_code,

                   v.status_name,

                   v.priority_code,

                   v.due_date,

                   v.overdue_yn,

                   v.application_name,

                   v.type_name,

                   v.complexity_name,

                   v.percent_complete,

                   regexp_replace(dbms_lob.substr(t.description, 500, 1), '<[^>]+>', ' ') as description_text,

                   (

                       select regexp_replace(dbms_lob.substr(tu.update_text, 500, 1), '<[^>]+>', ' ')

                         from tsk_task_updates tu

                        where tu.task_id = v.task_id

                        order by tu.created_at desc

                        fetch first 1 row only

                   ) as last_update

              from tsk_v_task_list v

              join tsk_tasks t

                on t.task_id = v.task_id

              join tsk_task_assignees ta

                on ta.task_id = v.task_id

               and ta.active_yn = 'Y'

             where ta.team_member_id = p_team_member_id

               and v.status_code in ('NOT_STARTED', 'IN_PROGRESS')

               and v.due_date is not null

             order by case when v.overdue_yn = 'Y' then 0 else 1 end,

                      case upper(v.priority_code)

                          when 'CRITICAL' then 1

                          when 'HIGH' then 2

                          when 'MEDIUM' then 3

                          when 'LOW' then 4

                          else 5

                      end,

                      v.due_date nulls last,

                      v.task_key

             fetch first 15 rows only

        ) loop

            l_has_due_tasks := true;

            l_html := l_html ||

                '<div style="border:1px solid #d8dee8;border-radius:6px;padding:12px;margin:0 0 10px">' ||

                '<div style="font-size:15px;font-weight:700;margin-bottom:4px">' ||

                '<a style="color:#0f62fe;text-decoration:none" href="' ||

                html_href(task_url(r.task_id)) || '">' ||

                apex_escape.html(r.task_key) || '</a> ' ||

                apex_escape.html(r.title) ||

                '</div>' ||

                '<div style="color:#5f6b7a;margin-bottom:8px">' ||

                apex_escape.html(r.priority_code) || ' priority &#8226; ' ||

                apex_escape.html(r.status_name) || ' &#8226; Due ' ||

                coalesce(to_char(r.due_date, 'Mon DD, YYYY'), 'No due date') ||

                case when r.overdue_yn = 'Y' then ' <span style="color:#b42318;font-weight:700">(Overdue)</span>' end ||

                '</div>' ||

                '<div style="margin-bottom:6px">' ||

                '<strong>Application:</strong> ' || apex_escape.html(coalesce(r.application_name, 'Unassigned')) ||

                ' &#8226; <strong>Type:</strong> ' || apex_escape.html(r.type_name) ||

                ' &#8226; <strong>Complexity:</strong> ' || apex_escape.html(coalesce(r.complexity_name, 'Not set')) ||

                ' &#8226; <strong>Complete:</strong> ' || r.percent_complete || '%' ||

                '</div>';


            if r.description_text is not null then

                l_html := l_html ||

                    '<div style="color:#344054;margin-bottom:6px"><strong>Details:</strong> ' ||

                    apex_escape.html(r.description_text) || '</div>';

            end if;


            if r.last_update is not null then

                l_html := l_html ||

                    '<div style="color:#344054"><strong>Last update:</strong> ' ||

                    apex_escape.html(r.last_update) || '</div>';

            end if;


            l_html := l_html || '</div>';

        end loop;


        if not l_has_due_tasks then

            l_html := l_html ||

                '<div style="border:1px solid #d8dee8;border-radius:6px;padding:12px">' ||

                'No not started or in progress assigned tasks have due dates.</div>';

        end if;


        l_html := l_html ||

            '<h3 style="margin:18px 0 10px">Not Started or In Progress Without Due Dates</h3>';


        for r in (

            select v.task_id,

                   v.task_key,

                   v.title,

                   v.status_code,

                   v.status_name,

                   v.priority_code,

                   v.due_date,

                   v.overdue_yn,

                   v.application_name,

                   v.type_name,

                   v.complexity_name,

                   v.percent_complete,

                   regexp_replace(dbms_lob.substr(t.description, 500, 1), '<[^>]+>', ' ') as description_text,

                   (

                       select regexp_replace(dbms_lob.substr(tu.update_text, 500, 1), '<[^>]+>', ' ')

                         from tsk_task_updates tu

                        where tu.task_id = v.task_id

                        order by tu.created_at desc

                        fetch first 1 row only

                   ) as last_update

              from tsk_v_task_list v

              join tsk_tasks t

                on t.task_id = v.task_id

              join tsk_task_assignees ta

                on ta.task_id = v.task_id

               and ta.active_yn = 'Y'

             where ta.team_member_id = p_team_member_id

               and v.status_code in ('NOT_STARTED', 'IN_PROGRESS')

               and v.due_date is null

             order by case upper(v.priority_code)

                          when 'CRITICAL' then 1

                          when 'HIGH' then 2

                          when 'MEDIUM' then 3

                          when 'LOW' then 4

                          else 5

                      end,

                      v.task_key

             fetch first 15 rows only

        ) loop

            l_has_missing_due_tasks := true;

            l_html := l_html ||

                '<div style="border:1px solid #d8dee8;border-radius:6px;padding:12px;margin:0 0 10px">' ||

                '<div style="font-size:15px;font-weight:700;margin-bottom:4px">' ||

                '<a style="color:#0f62fe;text-decoration:none" href="' ||

                html_href(task_url(r.task_id)) || '">' ||

                apex_escape.html(r.task_key) || '</a> ' ||

                apex_escape.html(r.title) ||

                '</div>' ||

                '<div style="color:#5f6b7a;margin-bottom:8px">' ||

                apex_escape.html(r.priority_code) || ' priority &#8226; ' ||

                apex_escape.html(r.status_name) || ' &#8226; ' ||

                '<span style="color:#b42318;font-weight:700">No due date</span>' ||

                '</div>' ||

                '<div style="margin-bottom:6px">' ||

                '<strong>Application:</strong> ' || apex_escape.html(coalesce(r.application_name, 'Unassigned')) ||

                ' &#8226; <strong>Type:</strong> ' || apex_escape.html(r.type_name) ||

                ' &#8226; <strong>Complexity:</strong> ' || apex_escape.html(coalesce(r.complexity_name, 'Not set')) ||

                ' &#8226; <strong>Complete:</strong> ' || r.percent_complete || '%' ||

                '</div>';


            if r.description_text is not null then

                l_html := l_html ||

                    '<div style="color:#344054;margin-bottom:6px"><strong>Details:</strong> ' ||

                    apex_escape.html(r.description_text) || '</div>';

            end if;


            if r.last_update is not null then

                l_html := l_html ||

                    '<div style="color:#344054"><strong>Last update:</strong> ' ||

                    apex_escape.html(r.last_update) || '</div>';

            end if;


            l_html := l_html || '</div>';

        end loop;


        if not l_has_missing_due_tasks then

            l_html := l_html ||

                '<div style="border:1px solid #d8dee8;border-radius:6px;padding:12px">' ||

                'No not started or in progress assigned tasks are missing due dates.</div>';

        end if;


        return l_html ||

            '<div style="color:#5f6b7a;margin-top:18px;font-size:12px">Generated by Task Center.</div>' ||

            '</div>';

    exception

        when no_data_found then

            return '<div>No active team member was found for this preview.</div>';

    end member_email_html;


    function monthly_team_subject (

        p_team_id  in number,

        p_run_date in date default trunc(sysdate)

    ) return varchar2 is

        l_team_name tsk_teams.team_name%type;

    begin

        select team_name

          into l_team_name

          from tsk_teams

         where team_id = p_team_id;


        return 'Monthly Team Progress for ' || l_team_name || ' - ' ||

               to_char(add_months(trunc(p_run_date, 'MM'), -1), 'Month YYYY');

    exception

        when no_data_found then

            return 'Monthly Team Progress - ' ||

                   to_char(add_months(trunc(p_run_date, 'MM'), -1), 'Month YYYY');

    end monthly_team_subject;


    function monthly_team_html (

        p_team_id  in number,

        p_run_date in date default trunc(sysdate)

    ) return clob is

        l_html            clob;

        l_team_name       tsk_teams.team_name%type;

        l_period_start    date := add_months(trunc(p_run_date, 'MM'), -1);

        l_period_end      date := trunc(p_run_date, 'MM');

        l_total_tasks     number;

        l_created_month   number;

        l_completed_month number;

        l_open_tasks      number;

        l_overdue_tasks   number;

        l_avg_complete    number;

    begin

        set_apex_context;


        select team_name

          into l_team_name

          from tsk_teams

         where team_id = p_team_id;


        select count(*),

               sum(case when t.created_at >= cast(l_period_start as timestamp)

                         and t.created_at < cast(l_period_end as timestamp) then 1 else 0 end),

               sum(case when t.completed_date >= l_period_start

                         and t.completed_date < l_period_end then 1 else 0 end),

               sum(case when nvl(st.is_done_yn, 'N') = 'N' then 1 else 0 end),

               sum(case when t.due_date < trunc(sysdate)

                         and nvl(st.is_done_yn, 'N') = 'N' then 1 else 0 end),

               round(avg(t.percent_complete))

          into l_total_tasks,

               l_created_month,

               l_completed_month,

               l_open_tasks,

               l_overdue_tasks,

               l_avg_complete

          from tsk_tasks t

          left join tsk_statuses st

            on st.status_id = t.status_id

         where t.team_id = p_team_id;


        l_html :=

            '<div style="font-family:Arial,sans-serif;color:#172033;line-height:1.45">' ||

            '<h2 style="margin:0 0 4px">Monthly Team Progress</h2>' ||

            '<div style="color:#5f6b7a;margin-bottom:18px">' ||

            apex_escape.html(l_team_name) || ' &#8226; ' ||

            to_char(l_period_start, 'Mon DD, YYYY') || ' - ' ||

            to_char(l_period_end - 1, 'Mon DD, YYYY') ||

            '</div>' ||

            '<table role="presentation" style="border-collapse:collapse;margin-bottom:18px;width:100%"><tr>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || l_total_tasks || '</strong><br>Total Tasks</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || l_created_month || '</strong><br>Created</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || l_completed_month || '</strong><br>Completed</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || l_open_tasks || '</strong><br>Open</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong style="color:#b42318">' || l_overdue_tasks || '</strong><br>Overdue</td>' ||

            '<td style="padding:10px;border:1px solid #d8dee8"><strong>' || nvl(l_avg_complete, 0) || '%</strong><br>Avg Complete</td>' ||

            '</tr></table>' ||

            '<h3 style="margin:0 0 10px">Progress by Status</h3>' ||

            '<table style="border-collapse:collapse;width:100%;margin-bottom:18px">' ||

            '<tr><th align="left" style="border-bottom:1px solid #d8dee8;padding:8px">Status</th>' ||

            '<th align="right" style="border-bottom:1px solid #d8dee8;padding:8px">Tasks</th></tr>';


        for r in (

            select nvl(st.status_name, 'No Status') status_name,

                   count(*) task_count

              from tsk_tasks t

              left join tsk_statuses st

                on st.status_id = t.status_id

             where t.team_id = p_team_id

             group by nvl(st.status_name, 'No Status'), nvl(st.display_seq, 999)

             order by nvl(st.display_seq, 999), nvl(st.status_name, 'No Status')

        ) loop

            l_html := l_html ||

                '<tr><td style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                apex_escape.html(r.status_name) ||

                '</td><td align="right" style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                r.task_count || '</td></tr>';

        end loop;


        l_html := l_html ||

            '</table><h3 style="margin:0 0 10px">Progress by Team Member</h3>' ||

            '<table style="border-collapse:collapse;width:100%;margin-bottom:18px">' ||

            '<tr><th align="left" style="border-bottom:1px solid #d8dee8;padding:8px">Team Member</th>' ||

            '<th align="right" style="border-bottom:1px solid #d8dee8;padding:8px">Open</th>' ||

            '<th align="right" style="border-bottom:1px solid #d8dee8;padding:8px">Completed This Month</th>' ||

            '<th align="right" style="border-bottom:1px solid #d8dee8;padding:8px">Overdue</th></tr>';


        for r in (

            select u.display_name,

                   count(distinct case when nvl(st.is_done_yn, 'N') = 'N' then t.task_id end) open_tasks,

                   count(distinct case when t.completed_date >= l_period_start

                                         and t.completed_date < l_period_end then t.task_id end) completed_month,

                   count(distinct case when t.due_date < trunc(sysdate)

                                         and nvl(st.is_done_yn, 'N') = 'N' then t.task_id end) overdue_tasks

              from tsk_team_members tm

              join tsk_users u

                on u.user_id = tm.user_id

              left join tsk_task_assignees ta

                on ta.team_member_id = tm.team_member_id

               and ta.active_yn = 'Y'

              left join tsk_tasks t

                on t.task_id = ta.task_id

              left join tsk_statuses st

                on st.status_id = t.status_id

             where tm.team_id = p_team_id

               and tm.active_yn = 'Y'

               and u.active_yn = 'Y'

             group by u.display_name

             order by u.display_name

        ) loop

            l_html := l_html ||

                '<tr><td style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                apex_escape.html(r.display_name) ||

                '</td><td align="right" style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                r.open_tasks ||

                '</td><td align="right" style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                r.completed_month ||

                '</td><td align="right" style="border-bottom:1px solid #eef2f7;padding:8px;color:#b42318">' ||

                r.overdue_tasks || '</td></tr>';

        end loop;


        l_html := l_html ||

            '</table><h3 style="margin:0 0 10px">Tasks by Application</h3>' ||

            '<table style="border-collapse:collapse;width:100%">' ||

            '<tr><th align="left" style="border-bottom:1px solid #d8dee8;padding:8px">Application</th>' ||

            '<th align="right" style="border-bottom:1px solid #d8dee8;padding:8px">Open</th>' ||

            '<th align="right" style="border-bottom:1px solid #d8dee8;padding:8px">Completed This Month</th></tr>';


        for r in (

            select nvl(a.application_name, 'Unassigned') application_name,

                   count(case when nvl(st.is_done_yn, 'N') = 'N' then 1 end) open_tasks,

                   count(case when t.completed_date >= l_period_start

                                and t.completed_date < l_period_end then 1 end) completed_month

              from tsk_tasks t

              left join tsk_applications a

                on a.application_id = t.application_id

              left join tsk_statuses st

                on st.status_id = t.status_id

             where t.team_id = p_team_id

             group by nvl(a.application_name, 'Unassigned')

             order by nvl(a.application_name, 'Unassigned')

        ) loop

            l_html := l_html ||

                '<tr><td style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                apex_escape.html(r.application_name) ||

                '</td><td align="right" style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                r.open_tasks ||

                '</td><td align="right" style="border-bottom:1px solid #eef2f7;padding:8px">' ||

                r.completed_month || '</td></tr>';

        end loop;


        return l_html ||

            '</table><div style="color:#5f6b7a;margin-top:18px;font-size:12px">Generated by Task Center.</div>' ||

            '</div>';

    exception

        when no_data_found then

            return '<div>No active team was found for this preview.</div>';

    end monthly_team_html;


    procedure queue_daily_schedule (

        p_email_schedule_id in number

    ) is

        l_subject varchar2(500);

        l_body    clob;

        l_error   varchar2(4000);

    begin

        for s in (

            select email_schedule_id,

                   team_id

              from tsk_email_schedules

             where email_schedule_id = p_email_schedule_id

               and schedule_code = 'DAILY_MEMBER_STATUS'

        ) loop

            for m in (

                select tm.team_member_id,

                       u.email

                  from tsk_team_members tm

                  join tsk_users u

                    on u.user_id = tm.user_id

                 where tm.team_id = s.team_id

                   and tm.active_yn = 'Y'

                   and u.active_yn = 'Y'

                   and u.email is not null

                   and (

                           not exists (

                               select 1

                                 from tsk_email_recipients er

                                where er.email_schedule_id = s.email_schedule_id

                                  and er.active_yn = 'Y'

                                  and er.team_member_id is not null

                           )

                        or exists (

                                   select 1

                                     from tsk_email_recipients er

                                    where er.email_schedule_id = s.email_schedule_id

                                      and er.team_member_id = tm.team_member_id

                                      and er.active_yn = 'Y'

                               )

                       )

            ) loop

                begin

                    l_subject := member_email_subject(m.team_member_id);

                    l_body := member_email_html(m.team_member_id);


                    apex_mail.send(

                        p_to        => m.email,

                        p_from      => 'no-reply@oracle.com',

                        p_subj      => l_subject,

                        p_body      => 'Open Task Center to view your daily task summary.',

                        p_body_html => dbms_lob.substr(l_body, 32767, 1)

                    );


                    insert into tsk_email_log (

                        email_schedule_id,

                        team_id,

                        team_member_id,

                        recipient_email,

                        email_subject,

                        email_body,

                        status_code,

                        run_period_start,

                        run_period_end

                    ) values (

                        s.email_schedule_id,

                        s.team_id,

                        m.team_member_id,

                        m.email,

                        l_subject,

                        l_body,

                        'QUEUED',

                        trunc(sysdate),

                        trunc(sysdate) + 1 - (1 / 86400)

                    );

                exception

                    when others then

                        l_error := sqlerrm;

                        insert into tsk_email_log (

                            email_schedule_id,

                            team_id,

                            team_member_id,

                            recipient_email,

                            email_subject,

                            email_body,

                            status_code,

                            run_period_start,

                            run_period_end,

                            error_message

                        ) values (

                            s.email_schedule_id,

                            s.team_id,

                            m.team_member_id,

                            m.email,

                            l_subject,

                            l_body,

                            'FAILED',

                            trunc(sysdate),

                            trunc(sysdate) + 1 - (1 / 86400),

                            l_error

                        );

                end;

            end loop;

        end loop;


    end queue_daily_schedule;


    function unassigned_submitter_reminder_html (

        p_email_schedule_id in number,

        p_team_member_id    in number default null,

        p_run_date          in date default trunc(sysdate)

    ) return clob is

        l_email_schedule_id tsk_email_schedules.email_schedule_id%type;

        l_team_id           tsk_email_schedules.team_id%type;

        l_recipient_email   tsk_users.email%type;

        l_display_name      tsk_users.display_name%type;

        l_team_member_id    tsk_team_members.team_member_id%type;

        l_task_count        number := 0;

        l_rendered_count    number := 0;

        l_html              clob;

    begin

        set_apex_context;


        select email_schedule_id,

               team_id

          into l_email_schedule_id,

               l_team_id

          from (

                select email_schedule_id,

                       team_id

                  from tsk_email_schedules

                 where schedule_code = 'DAILY_UNASSIGNED_SUBMITTER'

                   and email_schedule_id = coalesce(p_email_schedule_id, email_schedule_id)

                 order by email_schedule_id

               )

         where rownum = 1;


        if p_team_member_id is not null then

            select tm.team_member_id,

                   u.email,

                   u.display_name

              into l_team_member_id,

                   l_recipient_email,

                   l_display_name

              from tsk_team_members tm

              join tsk_users u

                on u.user_id = tm.user_id

             where tm.team_member_id = p_team_member_id;

        else

            select recipient_email,

                   display_name,

                   team_member_id,

                   task_count

              into l_recipient_email,

                   l_display_name,

                   l_team_member_id,

                   l_task_count

              from (

                    select recipient_email,

                           max(display_name) as display_name,

                           min(team_member_id) as team_member_id,

                           count(*) as task_count

                      from (

                            select distinct

                                   t.task_id,

                                   coalesce(

                                       case when u_submitter.active_yn = 'Y' then u_submitter.email end,

                                       case when u_created.active_yn = 'Y' then u_created.email end

                                   ) as recipient_email,

                                   coalesce(

                                       case when u_submitter.active_yn = 'Y' then u_submitter.display_name end,

                                       case when u_created.active_yn = 'Y' then u_created.display_name end,

                                       t.created_by

                                   ) as display_name,

                                   coalesce(

                                       case when u_submitter.active_yn = 'Y' then tm_submitter.team_member_id end,

                                       case when u_created.active_yn = 'Y' then tm_created.team_member_id end

                                   ) as team_member_id

                              from tsk_tasks t

                              join tsk_statuses st

                                on st.status_id = t.status_id

                              left join tsk_team_members tm_submitter

                                on tm_submitter.team_member_id = t.created_by_member_id

                              left join tsk_users u_submitter

                                on u_submitter.user_id = tm_submitter.user_id

                              left join tsk_users u_created

                                on lower(u_created.email) = lower(t.created_by)

                              left join tsk_team_members tm_created

                                on tm_created.user_id = u_created.user_id

                               and tm_created.team_id = t.team_id

                               and tm_created.active_yn = 'Y'

                             where t.team_id = l_team_id

                               and st.status_code in ('NOT_STARTED', 'IN_PROGRESS')

                               and not exists (

                                       select 1

                                         from tsk_task_assignees ta

                                        where ta.task_id = t.task_id

                                          and ta.active_yn = 'Y'

                                   )

                           )

                     where recipient_email is not null

                     group by recipient_email

                     order by display_name

                   )

             where rownum = 1;

        end if;


        if l_task_count = 0 and l_recipient_email is not null then

            select count(distinct t.task_id)

              into l_task_count

              from tsk_tasks t

              join tsk_statuses st

                on st.status_id = t.status_id

              left join tsk_team_members tm_submitter

                on tm_submitter.team_member_id = t.created_by_member_id

              left join tsk_users u_submitter

                on u_submitter.user_id = tm_submitter.user_id

              left join tsk_users u_created

                on lower(u_created.email) = lower(t.created_by)

             where t.team_id = l_team_id

               and st.status_code in ('NOT_STARTED', 'IN_PROGRESS')

               and not exists (

                       select 1

                         from tsk_task_assignees ta

                        where ta.task_id = t.task_id

                          and ta.active_yn = 'Y'

                   )

               and lower(

                       coalesce(

                           case when u_submitter.active_yn = 'Y' then u_submitter.email end,

                           case when u_created.active_yn = 'Y' then u_created.email end

                       )

                   ) = lower(l_recipient_email);

        end if;


        l_html :=

            '<div style="font-family:Arial,sans-serif;color:#172033;line-height:1.45">' ||

            '<h2 style="margin:0 0 4px">Unassigned Task Reminder</h2>' ||

            '<div style="color:#5f6b7a;margin-bottom:18px">' ||

            apex_escape.html(coalesce(l_display_name, 'Task Submitter')) || ' &#8226; ' ||

            to_char(p_run_date, 'Dy, Mon DD, YYYY') ||

            '</div>';


        if l_task_count = 0 then

            return l_html ||

                   '<p>No open unassigned tasks were found for this schedule.</p>' ||

                   '<div style="color:#5f6b7a;margin-top:18px;font-size:12px">Generated by Task Center.</div>' ||

                   '</div>';

        end if;


        l_html := l_html ||

            '<p>The following open tasks were submitted by you and do not currently have an active assignee.</p>';


        for r in (

            select task_id,

                   task_key,

                   title,

                   status_name,

                   priority_code,

                   due_date,

                   created_at,

                   updated_at,

                   application_name,

                   type_name,

                   overdue_yn

              from (

                    select distinct

                           v.task_id,

                           v.task_key,

                           v.title,

                           v.status_name,

                           v.priority_code,

                           v.due_date,

                           v.created_at,

                           v.updated_at,

                           v.application_name,

                           v.type_name,

                           v.overdue_yn

                      from tsk_v_task_list v

                      join tsk_tasks t

                        on t.task_id = v.task_id

                      join tsk_statuses st

                        on st.status_id = t.status_id

                      left join tsk_team_members tm_submitter

                        on tm_submitter.team_member_id = t.created_by_member_id

                      left join tsk_users u_submitter

                        on u_submitter.user_id = tm_submitter.user_id

                      left join tsk_users u_created

                        on lower(u_created.email) = lower(t.created_by)

                     where t.team_id = l_team_id

                       and st.status_code in ('NOT_STARTED', 'IN_PROGRESS')

                       and not exists (

                               select 1

                                 from tsk_task_assignees ta

                                where ta.task_id = t.task_id

                                  and ta.active_yn = 'Y'

                           )

                       and lower(

                               coalesce(

                                   case when u_submitter.active_yn = 'Y' then u_submitter.email end,

                                   case when u_created.active_yn = 'Y' then u_created.email end

                               )

                           ) = lower(l_recipient_email)

                   )

             order by case when overdue_yn = 'Y' then 0 else 1 end,

                      due_date nulls last,

                      priority_code,

                      task_key

             fetch first 25 rows only

        ) loop

            l_rendered_count := l_rendered_count + 1;

            l_html := l_html ||

                '<div style="border:1px solid #d8dee8;border-radius:6px;padding:12px;margin:0 0 10px">' ||

                '<div style="font-size:15px;font-weight:700;margin-bottom:4px">' ||

                '<a style="color:#0f62fe;text-decoration:none" href="' ||

                html_href(task_url(r.task_id)) || '">' ||

                apex_escape.html(r.task_key) || '</a> ' ||

                apex_escape.html(r.title) ||

                '</div>' ||

                '<div style="color:#5f6b7a;margin-bottom:8px">' ||

                apex_escape.html(r.priority_code) || ' priority &#8226; ' ||

                apex_escape.html(r.status_name) || ' &#8226; ' ||

                case

                    when r.due_date is not null then 'Due ' || to_char(r.due_date, 'Mon DD, YYYY')

                    else '<span style="color:#b42318;font-weight:700">No due date</span>'

                end ||

                case when r.overdue_yn = 'Y' then ' <span style="color:#b42318;font-weight:700">(Overdue)</span>' end ||

                '</div>' ||

                '<div><strong>Application:</strong> ' ||

                apex_escape.html(coalesce(r.application_name, 'Unassigned')) ||

                ' &#8226; <strong>Type:</strong> ' ||

                apex_escape.html(r.type_name) ||

                '</div>' ||

                '<div style="color:#5f6b7a;margin-top:6px"><strong>Created:</strong> ' ||

                to_char(cast(r.created_at as date), 'Mon DD, YYYY') ||

                ' &#8226; <strong>Last Updated:</strong> ' ||

                to_char(cast(r.updated_at as date), 'Mon DD, YYYY') ||

                '</div>' ||

                '</div>';

        end loop;


        if l_task_count > l_rendered_count then

            l_html := l_html ||

                '<div style="color:#5f6b7a;margin-top:8px">' ||

                'Only the first 25 unassigned tasks are shown in this email.' ||

                '</div>';

        end if;


        return l_html ||

               '<div style="color:#5f6b7a;margin-top:18px;font-size:12px">Generated by Task Center.</div>' ||

               '</div>';

    exception

        when no_data_found then

            return '<div style="font-family:Arial,sans-serif;color:#172033;line-height:1.45">' ||

                   '<h2 style="margin:0 0 4px">Unassigned Task Reminder</h2>' ||

                   '<p>No open unassigned tasks were found for this schedule.</p>' ||

                   '<div style="color:#5f6b7a;margin-top:18px;font-size:12px">Generated by Task Center.</div>' ||

                   '</div>';

    end unassigned_submitter_reminder_html;


    procedure queue_unassigned_submitter_reminders (

        p_email_schedule_id in number

    ) is

        l_subject varchar2(500);

        l_body    clob;

        l_error   varchar2(4000);

        l_count   number;

    begin

        for s in (

            select email_schedule_id,

                   team_id

              from tsk_email_schedules

             where email_schedule_id = p_email_schedule_id

               and schedule_code = 'DAILY_UNASSIGNED_SUBMITTER'

        ) loop

            for m in (

                select recipient_email,

                       max(display_name) as display_name,

                       min(team_member_id) as team_member_id,

                       count(*) as task_count

                  from (

                        select distinct

                               t.task_id,

                               coalesce(

                                   case when u_submitter.active_yn = 'Y' then u_submitter.email end,

                                   case when u_created.active_yn = 'Y' then u_created.email end

                               ) as recipient_email,

                               coalesce(

                                   case when u_submitter.active_yn = 'Y' then u_submitter.display_name end,

                                   case when u_created.active_yn = 'Y' then u_created.display_name end,

                                   t.created_by

                               ) as display_name,

                               coalesce(

                                   case when u_submitter.active_yn = 'Y' then tm_submitter.team_member_id end,

                                   case when u_created.active_yn = 'Y' then tm_created.team_member_id end

                               ) as team_member_id

                          from tsk_tasks t

                          join tsk_statuses st

                            on st.status_id = t.status_id

                          left join tsk_team_members tm_submitter

                            on tm_submitter.team_member_id = t.created_by_member_id

                          left join tsk_users u_submitter

                            on u_submitter.user_id = tm_submitter.user_id

                          left join tsk_users u_created

                            on lower(u_created.email) = lower(t.created_by)

                          left join tsk_team_members tm_created

                            on tm_created.user_id = u_created.user_id

                           and tm_created.team_id = t.team_id

                           and tm_created.active_yn = 'Y'

                         where t.team_id = s.team_id

                           and st.status_code in ('NOT_STARTED', 'IN_PROGRESS')

                           and not exists (

                                   select 1

                                     from tsk_task_assignees ta

                                    where ta.task_id = t.task_id

                                      and ta.active_yn = 'Y'

                               )

                       )

                 where recipient_email is not null

                 group by recipient_email

            ) loop

                begin

                    l_subject :=

                        'Unassigned Task Reminder - ' ||

                        m.task_count ||

                        case when m.task_count = 1 then ' task needs' else ' tasks need' end ||

                        ' an assignee';

                    l_body :=

                        '<div style="font-family:Arial,sans-serif;color:#172033;line-height:1.45">' ||

                        '<h2 style="margin:0 0 4px">Unassigned Task Reminder</h2>' ||

                        '<div style="color:#5f6b7a;margin-bottom:18px">' ||

                        apex_escape.html(m.display_name) || ' &#8226; ' ||

                        to_char(trunc(sysdate), 'Dy, Mon DD, YYYY') ||

                        '</div>' ||

                        '<p>The following open tasks were submitted by you and do not currently have an active assignee.</p>';

                    l_count := 0;

                    for r in (

                        select task_id,

                               task_key,

                               title,

                               status_name,

                               priority_code,

                               due_date,

                               created_at,

                               updated_at,

                               application_name,

                               type_name,

                               overdue_yn

                          from (

                                select distinct

                                       v.task_id,

                                       v.task_key,

                                       v.title,

                                       v.status_name,

                                       v.priority_code,

                                       v.due_date,

                                       v.created_at,

                                       v.updated_at,

                                       v.application_name,

                                       v.type_name,

                                       v.overdue_yn

                                  from tsk_v_task_list v

                                  join tsk_tasks t

                                    on t.task_id = v.task_id

                                  join tsk_statuses st

                                    on st.status_id = t.status_id

                                  left join tsk_team_members tm_submitter

                                    on tm_submitter.team_member_id = t.created_by_member_id

                                  left join tsk_users u_submitter

                                    on u_submitter.user_id = tm_submitter.user_id

                                  left join tsk_users u_created

                                    on lower(u_created.email) = lower(t.created_by)

                                 where t.team_id = s.team_id

                                   and st.status_code in ('NOT_STARTED', 'IN_PROGRESS')

                                   and not exists (

                                           select 1

                                             from tsk_task_assignees ta

                                            where ta.task_id = t.task_id

                                              and ta.active_yn = 'Y'

                                       )

                                   and lower(

                                           coalesce(

                                               case when u_submitter.active_yn = 'Y' then u_submitter.email end,

                                               case when u_created.active_yn = 'Y' then u_created.email end

                                           )

                                       ) = lower(m.recipient_email)

                               )

                         order by case when overdue_yn = 'Y' then 0 else 1 end,

                                  due_date nulls last,

                                  priority_code,

                                  task_key

                         fetch first 25 rows only

                    ) loop

                        l_count := l_count + 1;

                        l_body := l_body ||

                            '<div style="border:1px solid #d8dee8;border-radius:6px;padding:12px;margin:0 0 10px">' ||

                            '<div style="font-size:15px;font-weight:700;margin-bottom:4px">' ||

                            '<a style="color:#0f62fe;text-decoration:none" href="' ||

                            html_href(task_url(r.task_id)) || '">' ||

                            apex_escape.html(r.task_key) || '</a> ' ||

                            apex_escape.html(r.title) ||

                            '</div>' ||

                            '<div style="color:#5f6b7a;margin-bottom:8px">' ||

                            apex_escape.html(r.priority_code) || ' priority &#8226; ' ||

                            apex_escape.html(r.status_name) || ' &#8226; ' ||

                            case

                                when r.due_date is not null then 'Due ' || to_char(r.due_date, 'Mon DD, YYYY')

                                else '<span style="color:#b42318;font-weight:700">No due date</span>'

                            end ||

                            case when r.overdue_yn = 'Y' then ' <span style="color:#b42318;font-weight:700">(Overdue)</span>' end ||

                            '</div>' ||

                            '<div><strong>Application:</strong> ' ||

                            apex_escape.html(coalesce(r.application_name, 'Unassigned')) ||

                            ' &#8226; <strong>Type:</strong> ' ||

                            apex_escape.html(r.type_name) ||

                            '</div>' ||

                            '<div style="color:#5f6b7a;margin-top:6px"><strong>Created:</strong> ' ||

                            to_char(cast(r.created_at as date), 'Mon DD, YYYY') ||

                            ' &#8226; <strong>Last Updated:</strong> ' ||

                            to_char(cast(r.updated_at as date), 'Mon DD, YYYY') ||

                            '</div>' ||

                            '</div>';

                    end loop;

                    if m.task_count > l_count then

                        l_body := l_body ||

                            '<div style="color:#5f6b7a;margin-top:8px">' ||

                            'Only the first 25 unassigned tasks are shown in this email.' ||

                            '</div>';

                    end if;

                    l_body := l_body ||

                        '<div style="color:#5f6b7a;margin-top:18px;font-size:12px">Generated by Task Center.</div>' ||

                        '</div>';

                    apex_mail.send(

                        p_to        => m.recipient_email,

                        p_from      => 'no-reply@oracle.com',

                        p_subj      => l_subject,

                        p_body      => 'Open Task Center to review tasks you submitted that do not have an assignee.',

                        p_body_html => dbms_lob.substr(l_body, 32767, 1)

                    );

                    insert into tsk_email_log (

                        email_schedule_id,

                        team_id,

                        team_member_id,

                        recipient_email,

                        email_subject,

                        email_body,

                        status_code,

                        run_period_start,

                        run_period_end

                    ) values (

                        s.email_schedule_id,

                        s.team_id,

                        m.team_member_id,

                        m.recipient_email,

                        l_subject,

                        l_body,

                        'QUEUED',

                        trunc(sysdate),

                        trunc(sysdate) + 1 - (1 / 86400)

                    );

                exception

                    when others then

                        l_error := sqlerrm;

                        insert into tsk_email_log (

                            email_schedule_id,

                            team_id,

                            team_member_id,

                            recipient_email,

                            email_subject,

                            email_body,

                            status_code,

                            run_period_start,

                            run_period_end,

                            error_message

                        ) values (

                            s.email_schedule_id,

                            s.team_id,

                            m.team_member_id,

                            m.recipient_email,

                            l_subject,

                            l_body,

                            'FAILED',

                            trunc(sysdate),

                            trunc(sysdate) + 1 - (1 / 86400),

                            l_error

                        );

                end;

            end loop;

        end loop;

    end queue_unassigned_submitter_reminders;


    procedure send_unassigned_submitter_reminders (

        p_email_schedule_id in number

    ) is

    begin

        set_apex_context;

        queue_unassigned_submitter_reminders(p_email_schedule_id);

        apex_mail.push_queue;

        commit;

    end send_unassigned_submitter_reminders;


    procedure send_daily_schedule (

        p_email_schedule_id in number

    ) is

    begin

        set_apex_context;

        queue_daily_schedule(p_email_schedule_id);

        apex_mail.push_queue;

        commit;

    end send_daily_schedule;


    procedure send_daily_summaries is

    begin

        set_apex_context;


        for s in (

            select email_schedule_id

              from tsk_email_schedules

             where schedule_code = 'DAILY_MEMBER_STATUS'

               and enabled_yn = 'Y'

        ) loop

            queue_daily_schedule(s.email_schedule_id);

        end loop;


        apex_mail.push_queue;

        commit;

    end send_daily_summaries;


    procedure send_monthly_summaries is

        l_subject varchar2(500);

        l_body    clob;

        l_error   varchar2(4000);

    begin

        set_apex_context;


        for s in (

            select email_schedule_id,

                   team_id,

                   recipients_scope

              from tsk_email_schedules

             where schedule_code = 'MONTHLY_TEAM_PROGRESS'

               and enabled_yn = 'Y'

        ) loop

            l_subject := monthly_team_subject(s.team_id);

            l_body := monthly_team_html(s.team_id);


            for m in (

                select tm.team_member_id,

                       u.email

                  from tsk_team_members tm

                  join tsk_users u

                    on u.user_id = tm.user_id

                 where tm.team_id = s.team_id

                   and tm.active_yn = 'Y'

                   and u.active_yn = 'Y'

                   and u.email is not null

                   and (

                           s.recipients_scope = 'TEAM_MEMBERS'

                        or (s.recipients_scope = 'TEAM_LEADS' and upper(nvl(tm.role_name, '')) like '%LEAD%')

                        or (s.recipients_scope = 'MANAGERS' and upper(nvl(tm.role_name, '')) like '%MANAGER%')

                        or (

                               s.recipients_scope = 'CUSTOM'

                           and exists (

                                   select 1

                                     from tsk_email_recipients er

                                    where er.email_schedule_id = s.email_schedule_id

                                      and er.team_member_id = tm.team_member_id

                                      and er.active_yn = 'Y'

                               )

                           )

                       )

            ) loop

                begin

                    apex_mail.send(

                        p_to        => m.email,

                        p_from      => 'no-reply@oracle.com',

                        p_subj      => l_subject,

                        p_body      => 'Open Task Center to view your monthly team progress summary.',

                        p_body_html => dbms_lob.substr(l_body, 32767, 1)

                    );


                    insert into tsk_email_log (

                        email_schedule_id,

                        team_id,

                        team_member_id,

                        recipient_email,

                        email_subject,

                        email_body,

                        status_code,

                        run_period_start,

                        run_period_end

                    ) values (

                        s.email_schedule_id,

                        s.team_id,

                        m.team_member_id,

                        m.email,

                        l_subject,

                        l_body,

                        'QUEUED',

                        add_months(trunc(sysdate, 'MM'), -1),

                        trunc(sysdate, 'MM') - (1 / 86400)

                    );

                exception

                    when others then

                        l_error := sqlerrm;

                        insert into tsk_email_log (

                            email_schedule_id,

                            team_id,

                            team_member_id,

                            recipient_email,

                            email_subject,

                            email_body,

                            status_code,

                            run_period_start,

                            run_period_end,

                            error_message

                        ) values (

                            s.email_schedule_id,

                            s.team_id,

                            m.team_member_id,

                            m.email,

                            l_subject,

                            l_body,

                            'FAILED',

                            add_months(trunc(sysdate, 'MM'), -1),

                            trunc(sysdate, 'MM') - (1 / 86400),

                            l_error

                        );

                end;

            end loop;

        end loop;


        apex_mail.push_queue;

        commit;

    end send_monthly_summaries;


    procedure sync_scheduler_jobs is
    begin
        null;
    end sync_scheduler_jobs;

end tsk_daily_email_pkg;

/
show errors package tsk_daily_email_pkg
show errors package body tsk_daily_email_pkg
exit
