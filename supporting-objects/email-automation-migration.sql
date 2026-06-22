set define off verify off feedback on
whenever sqlerror exit sql.sqlcode rollback

prompt Migrating Task Center email schedules to APEX Automation

create or replace package tsk_email_automation_pkg as
    procedure run_due_schedules;
end tsk_email_automation_pkg;
/

create or replace package body tsk_email_automation_pkg as

    c_workspace constant varchar2(30) := 'DBAPPDEV';

    procedure set_apex_context is
    begin
        apex_util.set_security_group_id(
            apex_util.find_security_group_id(p_workspace => c_workspace)
        );
    end set_apex_context;

    function phoenix_now return timestamp is
    begin
        return cast(systimestamp at time zone 'America/Phoenix' as timestamp);
    end phoenix_now;

    function already_ran (
        p_email_schedule_id in number,
        p_period_start      in date
    ) return boolean is
        l_count number;
    begin
        select count(*)
          into l_count
          from tsk_email_log
         where email_schedule_id = p_email_schedule_id
           and run_period_start = p_period_start;

        return l_count > 0;
    end already_ran;

    procedure send_monthly_schedule (
        p_email_schedule_id in number
    ) is
        l_subject varchar2(500);
        l_body    clob;
        l_error   varchar2(4000);
    begin
        for s in (
            select email_schedule_id,
                   team_id,
                   recipients_scope
              from tsk_email_schedules
             where email_schedule_id = p_email_schedule_id
               and schedule_code = 'MONTHLY_TEAM_PROGRESS'
               and enabled_yn = 'Y'
        ) loop
            l_subject := tsk_daily_email_pkg.monthly_team_subject(s.team_id);
            l_body := tsk_daily_email_pkg.monthly_team_html(s.team_id);

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
    end send_monthly_schedule;

    procedure run_due_schedules is
        l_now             timestamp := phoenix_now;
        l_today           date := trunc(cast(phoenix_now as date));
        l_hour            number;
        l_minute          number;
        l_first_run_at    timestamp;
        l_scheduled_at    timestamp;
        l_month_start     date;
        l_month_day       number;
        l_last_month_day  number;
    begin
        set_apex_context;

        for s in (
            select email_schedule_id,
                   schedule_code,
                   send_hour,
                   send_minute,
                   send_at
              from tsk_email_schedules
             where schedule_code in ('DAILY_MEMBER_STATUS','DAILY_UNASSIGNED_SUBMITTER')
               and enabled_yn = 'Y'
        ) loop
            l_hour := coalesce(to_number(to_char(s.send_at, 'HH24')), s.send_hour, 8);
            l_minute := coalesce(to_number(to_char(s.send_at, 'MI')), s.send_minute, 0);
            l_first_run_at := s.send_at;
            l_scheduled_at := cast(l_today as timestamp) + numtodsinterval(l_hour, 'HOUR') + numtodsinterval(l_minute, 'MINUTE');

            if l_now >= l_scheduled_at
               and (l_first_run_at is null or l_now >= l_first_run_at)
               and not already_ran(s.email_schedule_id, l_today)
            then
                if s.schedule_code = 'DAILY_UNASSIGNED_SUBMITTER' then
                    tsk_daily_email_pkg.send_unassigned_submitter_reminders(s.email_schedule_id);
                else
                    tsk_daily_email_pkg.send_daily_schedule(s.email_schedule_id);
                end if;
            end if;
        end loop;

        l_month_start := trunc(cast(l_now as date), 'MM');
        l_last_month_day := to_number(to_char(last_day(l_month_start), 'DD'));

        for s in (
            select email_schedule_id,
                   send_hour,
                   send_minute,
                   nvl(weekly_day_number, 1) as monthly_day_number
              from tsk_email_schedules
             where schedule_code = 'MONTHLY_TEAM_PROGRESS'
               and enabled_yn = 'Y'
        ) loop
            l_month_day := least(greatest(s.monthly_day_number, 1), l_last_month_day);
            l_scheduled_at := cast(l_month_start + (l_month_day - 1) as timestamp)
                              + numtodsinterval(nvl(s.send_hour, 8), 'HOUR')
                              + numtodsinterval(nvl(s.send_minute, 0), 'MINUTE');

            if l_now >= l_scheduled_at
               and not already_ran(s.email_schedule_id, add_months(l_month_start, -1))
            then
                send_monthly_schedule(s.email_schedule_id);
            end if;
        end loop;
    end run_due_schedules;

end tsk_email_automation_pkg;
/

begin
    for j in (
        select job_name
          from user_scheduler_jobs
         where job_name in ('TSK_DAILY_MEMBER_EMAIL_JOB', 'TSK_MONTHLY_TEAM_EMAIL_JOB')
    ) loop
        begin
            dbms_scheduler.drop_job(j.job_name, force => true);
        exception
            when others then
                null;
        end;
    end loop;
end;
/

begin
    wwv_flow_imp.import_begin(
        p_version_yyyy_mm_dd     => '2026.03.30',
        p_release                => '26.1.0',
        p_default_workspace_id   => 7097755211213275,
        p_default_application_id => 12892,
        p_default_id_offset      => 0,
        p_default_owner          => 'WKSP_DBAPPDEV'
    );
end;
/

declare
    l_count number;
begin
    select count(*)
      into l_count
      from apex_appl_automations
     where application_id = 12892
       and static_id = 'task-center-email-schedule-runner';

    if l_count = 0 then
        wwv_flow_imp_shared.create_automation(
            p_id=>wwv_flow_imp.id(9990004100001001),
            p_name=>'Task Center Email Schedule Runner',
            p_static_id=>'task-center-email-schedule-runner',
            p_trigger_type=>'POLLING',
            p_polling_interval=>'FREQ=MINUTELY;INTERVAL=5',
            p_polling_status=>'ACTIVE',
            p_result_type=>'ALWAYS',
            p_location=>'LOCAL',
            p_use_local_sync_table=>false,
            p_include_rowid_column=>false,
            p_commit_each_row=>false,
            p_error_handling_type=>'ABORT',
            p_comment=>'Runs Task Center email schedules from TSK_EMAIL_SCHEDULES. Enable or disable this automation in APEX.'
        );

        wwv_flow_imp_shared.create_automation_action(
            p_id=>wwv_flow_imp.id(9990004100001002),
            p_automation_id=>wwv_flow_imp.id(9990004100001001),
            p_name=>'Send Due Email Schedules',
            p_static_id=>'send-due-email-schedules',
            p_execution_sequence=>10,
            p_action_type=>'NATIVE_PLSQL',
            p_action_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
                'begin',
                '    tsk_email_automation_pkg.run_due_schedules;',
                'end;'
            )),
            p_action_clob_language=>'PLSQL',
            p_location=>'LOCAL',
            p_stop_execution_on_error=>true
        );
    end if;
end;
/

begin
    wwv_flow_imp.import_end;
end;
/

commit;

prompt Task Center email schedules now use APEX Automation.
