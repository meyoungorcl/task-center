set define off
set serveroutput on

declare
    l_completed_status_id tsk_statuses.status_id%type;
    l_archive_status_id   tsk_statuses.status_id%type;
    l_archived_count      pls_integer;
begin
    merge into tsk_statuses dst
    using (
        select 7 as status_id,
               'ARCHIVE' as status_code,
               'Archive' as status_name,
               'N' as is_open_yn,
               'Y' as is_done_yn,
               60 as display_seq,
               'Y' as active_yn
          from dual
    ) src
    on (dst.status_code = src.status_code)
    when matched then
        update set dst.status_name = src.status_name,
                   dst.is_open_yn = src.is_open_yn,
                   dst.is_done_yn = src.is_done_yn,
                   dst.display_seq = src.display_seq,
                   dst.active_yn = src.active_yn
    when not matched then
        insert (
            status_id,
            status_code,
            status_name,
            is_open_yn,
            is_done_yn,
            display_seq,
            active_yn
        ) values (
            src.status_id,
            src.status_code,
            src.status_name,
            src.is_open_yn,
            src.is_done_yn,
            src.display_seq,
            src.active_yn
        );

    select status_id
      into l_completed_status_id
      from tsk_statuses
     where status_code = 'COMPLETED';

    select status_id
      into l_archive_status_id
      from tsk_statuses
     where status_code = 'ARCHIVE';

    update tsk_tasks
       set status_id = l_archive_status_id
     where status_id = l_completed_status_id
       and completed_date <= date '2025-12-31';

    l_archived_count := sql%rowcount;

    commit;

    dbms_output.put_line('Archived tasks: ' || l_archived_count);
end;
/
