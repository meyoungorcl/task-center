set serveroutput on
set feedback on

declare
    l_archive_status_id   tsk_statuses.status_id%type;
    l_completed_status_id tsk_statuses.status_id%type;
    l_changed_count       number;
begin
    select status_id
      into l_archive_status_id
      from tsk_statuses
     where status_code = 'ARCHIVE';

    select status_id
      into l_completed_status_id
      from tsk_statuses
     where status_code = 'COMPLETED';

    update tsk_tasks
       set status_id = l_completed_status_id
     where status_id = l_archive_status_id;

    l_changed_count := sql%rowcount;

    dbms_output.put_line('Archive status id: ' || l_archive_status_id);
    dbms_output.put_line('Completed status id: ' || l_completed_status_id);
    dbms_output.put_line('Tasks changed from Archive to Completed: ' || l_changed_count);
end;
/

commit;
