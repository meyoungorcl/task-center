set define off
set sqlblanklines on

prompt Adding UPDATED_AT to TSK_TASK_UPDATES

declare
    l_column_count number;
begin
    select count(*)
      into l_column_count
      from user_tab_columns
     where table_name = 'TSK_TASK_UPDATES'
       and column_name = 'UPDATED_AT';

    if l_column_count = 0 then
        execute immediate 'alter table tsk_task_updates add updated_at timestamp default systimestamp';
    end if;
end;
/

update tsk_task_updates
   set updated_at = created_at
 where updated_at != created_at
    or updated_at is null;

declare
    l_nullable user_tab_columns.nullable%type;
begin
    select nullable
      into l_nullable
      from user_tab_columns
     where table_name = 'TSK_TASK_UPDATES'
       and column_name = 'UPDATED_AT';

    if l_nullable = 'Y' then
        execute immediate 'alter table tsk_task_updates modify updated_at not null';
    end if;
end;
/

create or replace trigger tsk_task_updates_biu
before insert or update on tsk_task_updates
for each row
begin
    if inserting then
        :new.created_at := coalesce(:new.created_at, systimestamp);
        :new.created_by := coalesce(:new.created_by, tsk_app_user());
        :new.updated_at := :new.created_at;
    else
        :new.updated_at := systimestamp;
    end if;
end;
/

alter trigger tsk_task_updates_biu enable
/

declare
    procedure drop_index_if_exists(p_index_name in varchar2) is
        l_count number;
    begin
        select count(*)
          into l_count
          from user_indexes
         where index_name = upper(p_index_name);

        if l_count > 0 then
            execute immediate 'drop index ' || p_index_name;
        end if;
    end;
begin
    drop_index_if_exists('TSK_TASK_UPDATES_I01');
    drop_index_if_exists('TSK_TASK_UPDATES_I02');
end;
/

create index tsk_task_updates_i01 on tsk_task_updates (task_id, updated_at)
/

create index tsk_task_updates_i02 on tsk_task_updates (team_member_id, updated_at)
/

prompt TSK_TASK_UPDATES UPDATED_AT migration complete
