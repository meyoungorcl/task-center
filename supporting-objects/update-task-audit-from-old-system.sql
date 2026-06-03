-- Updates TSK_TASKS audit columns from:
-- Original file:
-- /Users/MEYOUNG/Documents/appdev Tasks/all_tasks_from_old system.csv
--
-- SQLcl LOAD splits paths that contain spaces, so the script first copies the
-- CSV to /private/tmp/all_tasks_from_old_system.csv and loads from there.
--
-- Match key:
--   'APPDEV_XLSX_ID:' || CSV.ID -> TSK_TASKS.EXTERNAL_REFERENCE
--
-- The TSK_TASKS audit triggers are disabled only during the update, then
-- re-enabled before this script exits.

set define off
set serveroutput on size unlimited
whenever sqlerror exit failure rollback

begin
    execute immediate q'[
        create global temporary table tsk_task_audit_csv_stage (
            id           varchar2(255),
            priority     varchar2(255),
            application  varchar2(255),
            details      clob,
            assigned_to  varchar2(255),
            status       varchar2(255),
            jira         varchar2(1000),
            notes        clob,
            created_by   varchar2(255),
            created      varchar2(100),
            updated_by   varchar2(255),
            updated      varchar2(100),
            due_date     varchar2(100),
            title        varchar2(1000),
            type         varchar2(255),
            release      varchar2(255)
        ) on commit preserve rows
    ]';
exception
    when others then
        if sqlcode != -955 then
            raise;
        end if;
end;
/

truncate table tsk_task_audit_csv_stage;

host cp "/Users/MEYOUNG/Documents/appdev Tasks/all_tasks_from_old system.csv" /private/tmp/all_tasks_from_old_system.csv

load tsk_task_audit_csv_stage /private/tmp/all_tasks_from_old_system.csv

column metric format a45
column value format 999999

select 'CSV rows staged' metric, count(*) value
  from tsk_task_audit_csv_stage
union all
select 'Distinct CSV external references', count(distinct id)
  from tsk_task_audit_csv_stage
union all
select 'Matched TSK_TASKS rows', count(*)
  from tsk_tasks t
 where exists (
           select 1
             from tsk_task_audit_csv_stage s
            where 'APPDEV_XLSX_ID:' || s.id = t.external_reference
       )
union all
select 'CSV rows with no matching task', count(*)
  from tsk_task_audit_csv_stage s
 where not exists (
           select 1
             from tsk_tasks t
            where t.external_reference = 'APPDEV_XLSX_ID:' || s.id
       )
union all
select 'Matched rows with audit differences', count(*)
  from tsk_tasks t
  join tsk_task_audit_csv_stage s
    on 'APPDEV_XLSX_ID:' || s.id = t.external_reference
 where nvl(t.created_by, chr(0)) != nvl(s.created_by, chr(0))
    or nvl(t.updated_by, chr(0)) != nvl(s.updated_by, chr(0))
    or t.created_at != to_timestamp(s.created, 'DD-MON-RR HH.MI.SS.FF AM', 'NLS_DATE_LANGUAGE=American')
    or t.updated_at != to_timestamp(s.updated, 'DD-MON-RR HH.MI.SS.FF AM', 'NLS_DATE_LANGUAGE=American');

declare
    l_updated_count number := 0;
begin
    execute immediate 'alter trigger TSK_TASKS_AUD disable';
    execute immediate 'alter trigger TSK_TASKS_BIU disable';

    begin
        update tsk_tasks t
           set (created_at, created_by, updated_at, updated_by) = (
                   select to_timestamp(s.created, 'DD-MON-RR HH.MI.SS.FF AM', 'NLS_DATE_LANGUAGE=American'),
                          s.created_by,
                          to_timestamp(s.updated, 'DD-MON-RR HH.MI.SS.FF AM', 'NLS_DATE_LANGUAGE=American'),
                          s.updated_by
                     from tsk_task_audit_csv_stage s
                    where 'APPDEV_XLSX_ID:' || s.id = t.external_reference
               )
         where exists (
                   select 1
                     from tsk_task_audit_csv_stage s
                    where 'APPDEV_XLSX_ID:' || s.id = t.external_reference
               );

        l_updated_count := sql%rowcount;
        dbms_output.put_line('Updated TSK_TASKS audit rows: ' || l_updated_count);
        commit;

        execute immediate 'alter trigger TSK_TASKS_AUD enable';
        execute immediate 'alter trigger TSK_TASKS_BIU enable';
    exception
        when others then
            rollback;
            begin
                execute immediate 'alter trigger TSK_TASKS_AUD enable';
            exception
                when others then null;
            end;
            begin
                execute immediate 'alter trigger TSK_TASKS_BIU enable';
            exception
                when others then null;
            end;
            raise;
    end;
end;
/

select trigger_name, status
  from user_triggers
 where table_name = 'TSK_TASKS'
 order by trigger_name;

select count(*) as unmatched_csv_rows
  from tsk_task_audit_csv_stage s
 where not exists (
           select 1
             from tsk_tasks t
            where t.external_reference = 'APPDEV_XLSX_ID:' || s.id
       );
