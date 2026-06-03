set define off
set sqlblanklines on
whenever sqlerror exit sql.sqlcode rollback

prompt Upserting Task Center tasks from report create and update.csv
prompt Source file: /Users/MEYOUNG/Documents/appdev Tasks/report create and update.csv
prompt CSV rows: 12; matched existing tasks: 8; new inserts: 4

/*
Match rule:
  TSK_TASKS.EXTERNAL_REFERENCE = 'APPDEV_XLSX_ID:' || CSV.ID

CSV mappings:
  New Requirement -> New Feature
  Modify Application -> Enhancement
  Modify Database -> Enhancement
  VibeHub -> Vibe Hub
  Ask TOM - Tech Session Catalog -> AskTOM Catalog

Rows matched in the current database:
  CSV ID 3521: update TASK_ID 2938
  CSV ID 3527: update TASK_ID 2940
  CSV ID 3524: update TASK_ID 3041
  CSV ID 3268: update TASK_ID 3058
  CSV ID 3463: update TASK_ID 3011
  CSV ID 3741: insert new task
  CSV ID 3742: insert new task
  CSV ID 3743: insert new task
  CSV ID 3744: insert new task
  CSV ID 3641: update TASK_ID 3066
  CSV ID 3721: update TASK_ID 3068
  CSV ID 3701: update TASK_ID 3072
*/

declare
    l_missing varchar2(32767);
begin
    with raw_src as (
select '3521' as source_id,
       'APPDEV_XLSX_ID:3521' as external_reference,
       'VibeHub: Hide ratings system' as title,
       to_clob(q'~<p>Hide ratings system on Cards, Edit and View screens. Keep it aside for future. Replace with create date or update date.</p>~') as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.01.597611000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3527' as source_id,
       'APPDEV_XLSX_ID:3527' as external_reference,
       'ACE: Add country code to countries table and sync with ref_countries' as title,
       to_clob(q'~<p>using ref_countries as source:</p><ul><li>add country_cd to ace.countries and map it to ref_countries</li><li>map ace.ace_countries.country_code to ref_countries</li></ul>~') as description,
       'Enhancement' as type_name,
       'Completed' as status_name,
       'ACE' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/23/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.49.44.909917000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3524' as source_id,
       'APPDEV_XLSX_ID:3524' as external_reference,
       'VibeDemos: Re-Create demos in VibeHub from Vijay''s REST dump' as title,
       to_clob(q'~<p style="margin-left:0;"># Get token<br>TOKEN=$(curl -s -X POST "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token</span></a>" -u "V6AlKFkoTV5iVkRomg3ezQ..:7bfRQsaFnKbwhtzcFAOHwQ.." -d "grant_type=client_credentials" | jq -r '.access_token')<br><br># Usage log<br>curl -s -H "Authorization: Bearer $TOKEN" "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_usage_log/?limit=500"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_usage_log/?limit=500</span></a>" | jq '.items'<br><br># Skill files<br>curl -s -H "Authorization: Bearer $TOKEN" "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_skill_files/?limit=500"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_skill_files/?limit=500</span></a>" | jq '.items'</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:36 PM]</p><p style="margin-left:0;">the 2 tables have a view which order by id or laogged timings.&nbsp; -- you need a scheduler job what will create tiles in vibe code hub. -- The link is DB&nbsp; before migration. -- Once you are done with testing, i can provide you the prod DN Ords.</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:36 PM]</p><p style="margin-left:0;">also, you want to access the DN directly, let me know.</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">client_id: &nbsp; &nbsp; V6AlKFkoTV5iVkRomg3ezQ.. client_secret: 7bfRQsaFnKbwhtzcFAOHwQ..</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">get token -- curl -X POST \ &nbsp;<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token</span></a> \ &nbsp;-d "grant_type=client_credentials" \ &nbsp;-u "V6AlKFkoTV5iVkRomg3ezQ..:7bfRQsaFnKbwhtzcFAOHwQ.."</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">then call end point.</p>~') as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.11.182127000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3268' as source_id,
       'APPDEV_XLSX_ID:3268' as external_reference,
       'DBUS move to APEXADB - Get the App re-configured' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       to_date('03/27/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('16-MAR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.49.23.164494000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3463' as source_id,
       'APPDEV_XLSX_ID:3463' as external_reference,
       'Vibehub: Get domain name & implement redirect' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Backlog' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('07-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.36.273798000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3741' as source_id,
       'APPDEV_XLSX_ID:3741' as external_reference,
       'DBUS: WKSP_TAS schema sync up in Dev from Prod' as title,
       to_clob(q'~<p>Created the request:&nbsp;</p><p><a href="https://jira-sd.mc1.oracleiaas.com/browse/DSODBTOOLS-1321">https://jira-sd.mc1.oracleiaas.com/browse/DSODBTOOLS-1321</a></p><p>&nbsp;</p>~') as description,
       'Enhancement' as type_name,
       'Not Started' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 03.56.28.513626000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 03.56.28.513721000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3742' as source_id,
       'APPDEV_XLSX_ID:3742' as external_reference,
       'DBUS: PM Digest testing / Turn on in new system' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'In Progress' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 03.57.03.111872000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 03.57.03.111924000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3743' as source_id,
       'APPDEV_XLSX_ID:3743' as external_reference,
       'DBUS: Log all forward requests to the new site on APEXADB' as title,
       to_clob(q'~<p>Create a table to log who and what the URL and URL params were when people hit the old site.</p>~') as description,
       'New Feature' as type_name,
       'Not Started' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 04.37.35.629982000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.37.35.630035000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3744' as source_id,
       'APPDEV_XLSX_ID:3744' as external_reference,
       'Taxonomy Sync back to APEX.ORACLECORP.COM' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'In Progress' as status_name,
       'Product Taxonomy' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 04.48.47.188819000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.48.47.188868000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3641' as source_id,
       'APPDEV_XLSX_ID:3641' as external_reference,
       'Create REST API for the TAS_ASSETS Table with OAuth ( Capture Blob columns as well)' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'database.us' as application_name,
       'manoj.sundar@oracle.com' as owner_email,
       'manoj.sundar@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('12-MAY-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MANOJ.SUNDAR@ORACLE.COM' as created_by,
       to_timestamp('28-MAY-26 09.12.48.594682000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MANOJ.SUNDAR@ORACLE.COM' as updated_by
  from dual
union all
select '3721' as source_id,
       'APPDEV_XLSX_ID:3721' as external_reference,
       'Investigate why Join button doesn''t show on page 3' as title,
       to_clob(q'~<p>Per slack, Investigate why Join button doesn't show on page 3</p>~') as description,
       'Bug' as type_name,
       'Not Started' as status_name,
       'AskTOM Catalog' as application_name,
       'manoj.sundar@oracle.com' as owner_email,
       'marcie.young@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('28-MAY-26 02.08.46.845426000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MARCIE.YOUNG@ORACLE.COM' as created_by,
       to_timestamp('28-MAY-26 02.08.46.845532000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MARCIE.YOUNG@ORACLE.COM' as updated_by
  from dual
union all
select '3701' as source_id,
       'APPDEV_XLSX_ID:3701' as external_reference,
       'Add additional things to the store/session Rainfocus API' as title,
       to_clob(q'~<div class="ck-content"><p>Need to be able to include the following additional info when running the /session/store</p><figure class="table"><table><tbody><tr><td>CP</td><td>RF Column</td><td>RF Value</td></tr><tr><td>&nbsp;</td><td>Content Area</td><td>Oracle AI Database</td></tr><tr><td>Job Roles (multiple)&nbsp;</td><td>Job Role</td><td>Values from CP</td></tr><tr><td>Key Areas (multiple)</td><td>Areas of Interest</td><td>Values from CP</td></tr><tr><td>Level (one)&nbsp;</td><td>Content Level</td><td>Value from CP</td></tr><tr><td>Industry (one)</td><td>Industry</td><td>Non-Industry Specific</td></tr><tr><td>Org</td><td>Session Allocations</td><td>Oracle Database or Tech-DB</td></tr></tbody></table></figure></div>~') as description,
       'New Feature' as type_name,
       'Not Started' as status_name,
       'Conference Planner' as application_name,
       'zackary.rice@oracle.com' as owner_email,
       'marcie.young@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('27-MAY-26 08.56.51.023620000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MARCIE.YOUNG@ORACLE.COM' as created_by,
       to_timestamp('27-MAY-26 08.56.51.023681000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MARCIE.YOUNG@ORACLE.COM' as updated_by
  from dual
),
member_lookup as (
    select lower(u.email) as email,
           min(tm.team_member_id) as team_member_id
      from tsk_team_members tm
      join tsk_users u
        on u.user_id = tm.user_id
     group by lower(u.email)
),
src as (
    select r.*,
           st.status_id,
           st.status_code,
           ty.type_id,
           app.application_id,
           coalesce(app.owner_team_id, owner_tm.team_id, creator_tm.team_id, 1) as team_id,
           owner_tm.team_member_id as owner_member_id,
           creator_tm.team_member_id as created_by_member_id
      from raw_src r
      left join tsk_statuses st
        on upper(st.status_name) = upper(r.status_name)
      left join tsk_task_types ty
        on upper(ty.type_name) = upper(r.type_name)
      left join tsk_applications app
        on upper(app.application_name) = upper(r.application_name)
      left join member_lookup owner_ml
        on owner_ml.email = lower(r.owner_email)
      left join tsk_team_members owner_tm
        on owner_tm.team_member_id = owner_ml.team_member_id
      left join member_lookup creator_ml
        on creator_ml.email = lower(r.created_by_email)
      left join tsk_team_members creator_tm
        on creator_tm.team_member_id = creator_ml.team_member_id
)
    select listagg(msg, chr(10)) within group (order by msg)
      into l_missing
      from (
            select external_reference || ': missing status "' || status_name || '"' as msg
              from src
             where status_id is null
            union all
            select external_reference || ': missing task type "' || type_name || '"'
              from src
             where type_id is null
            union all
            select external_reference || ': missing application "' || application_name || '"'
              from src
             where application_id is null
            union all
            select external_reference || ': missing assigned-to member "' || owner_email || '"'
              from src
             where owner_member_id is null
            union all
            select external_reference || ': missing created-by member "' || created_by_email || '"'
              from src
             where created_by_member_id is null
           );

    if l_missing is not null then
        raise_application_error(-20000, 'Cannot upsert CSV tasks because reference data is missing:' || chr(10) || l_missing);
    end if;
end;
/

merge into tsk_tasks dst
using (
    with raw_src as (
select '3521' as source_id,
       'APPDEV_XLSX_ID:3521' as external_reference,
       'VibeHub: Hide ratings system' as title,
       to_clob(q'~<p>Hide ratings system on Cards, Edit and View screens. Keep it aside for future. Replace with create date or update date.</p>~') as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.01.597611000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3527' as source_id,
       'APPDEV_XLSX_ID:3527' as external_reference,
       'ACE: Add country code to countries table and sync with ref_countries' as title,
       to_clob(q'~<p>using ref_countries as source:</p><ul><li>add country_cd to ace.countries and map it to ref_countries</li><li>map ace.ace_countries.country_code to ref_countries</li></ul>~') as description,
       'Enhancement' as type_name,
       'Completed' as status_name,
       'ACE' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/23/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.49.44.909917000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3524' as source_id,
       'APPDEV_XLSX_ID:3524' as external_reference,
       'VibeDemos: Re-Create demos in VibeHub from Vijay''s REST dump' as title,
       to_clob(q'~<p style="margin-left:0;"># Get token<br>TOKEN=$(curl -s -X POST "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token</span></a>" -u "V6AlKFkoTV5iVkRomg3ezQ..:7bfRQsaFnKbwhtzcFAOHwQ.." -d "grant_type=client_credentials" | jq -r '.access_token')<br><br># Usage log<br>curl -s -H "Authorization: Bearer $TOKEN" "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_usage_log/?limit=500"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_usage_log/?limit=500</span></a>" | jq '.items'<br><br># Skill files<br>curl -s -H "Authorization: Bearer $TOKEN" "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_skill_files/?limit=500"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_skill_files/?limit=500</span></a>" | jq '.items'</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:36 PM]</p><p style="margin-left:0;">the 2 tables have a view which order by id or laogged timings.&nbsp; -- you need a scheduler job what will create tiles in vibe code hub. -- The link is DB&nbsp; before migration. -- Once you are done with testing, i can provide you the prod DN Ords.</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:36 PM]</p><p style="margin-left:0;">also, you want to access the DN directly, let me know.</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">client_id: &nbsp; &nbsp; V6AlKFkoTV5iVkRomg3ezQ.. client_secret: 7bfRQsaFnKbwhtzcFAOHwQ..</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">get token -- curl -X POST \ &nbsp;<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token</span></a> \ &nbsp;-d "grant_type=client_credentials" \ &nbsp;-u "V6AlKFkoTV5iVkRomg3ezQ..:7bfRQsaFnKbwhtzcFAOHwQ.."</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">then call end point.</p>~') as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.11.182127000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3268' as source_id,
       'APPDEV_XLSX_ID:3268' as external_reference,
       'DBUS move to APEXADB - Get the App re-configured' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       to_date('03/27/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('16-MAR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.49.23.164494000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3463' as source_id,
       'APPDEV_XLSX_ID:3463' as external_reference,
       'Vibehub: Get domain name & implement redirect' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Backlog' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('07-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.36.273798000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3741' as source_id,
       'APPDEV_XLSX_ID:3741' as external_reference,
       'DBUS: WKSP_TAS schema sync up in Dev from Prod' as title,
       to_clob(q'~<p>Created the request:&nbsp;</p><p><a href="https://jira-sd.mc1.oracleiaas.com/browse/DSODBTOOLS-1321">https://jira-sd.mc1.oracleiaas.com/browse/DSODBTOOLS-1321</a></p><p>&nbsp;</p>~') as description,
       'Enhancement' as type_name,
       'Not Started' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 03.56.28.513626000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 03.56.28.513721000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3742' as source_id,
       'APPDEV_XLSX_ID:3742' as external_reference,
       'DBUS: PM Digest testing / Turn on in new system' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'In Progress' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 03.57.03.111872000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 03.57.03.111924000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3743' as source_id,
       'APPDEV_XLSX_ID:3743' as external_reference,
       'DBUS: Log all forward requests to the new site on APEXADB' as title,
       to_clob(q'~<p>Create a table to log who and what the URL and URL params were when people hit the old site.</p>~') as description,
       'New Feature' as type_name,
       'Not Started' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 04.37.35.629982000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.37.35.630035000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3744' as source_id,
       'APPDEV_XLSX_ID:3744' as external_reference,
       'Taxonomy Sync back to APEX.ORACLECORP.COM' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'In Progress' as status_name,
       'Product Taxonomy' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 04.48.47.188819000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.48.47.188868000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3641' as source_id,
       'APPDEV_XLSX_ID:3641' as external_reference,
       'Create REST API for the TAS_ASSETS Table with OAuth ( Capture Blob columns as well)' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'database.us' as application_name,
       'manoj.sundar@oracle.com' as owner_email,
       'manoj.sundar@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('12-MAY-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MANOJ.SUNDAR@ORACLE.COM' as created_by,
       to_timestamp('28-MAY-26 09.12.48.594682000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MANOJ.SUNDAR@ORACLE.COM' as updated_by
  from dual
union all
select '3721' as source_id,
       'APPDEV_XLSX_ID:3721' as external_reference,
       'Investigate why Join button doesn''t show on page 3' as title,
       to_clob(q'~<p>Per slack, Investigate why Join button doesn't show on page 3</p>~') as description,
       'Bug' as type_name,
       'Not Started' as status_name,
       'AskTOM Catalog' as application_name,
       'manoj.sundar@oracle.com' as owner_email,
       'marcie.young@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('28-MAY-26 02.08.46.845426000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MARCIE.YOUNG@ORACLE.COM' as created_by,
       to_timestamp('28-MAY-26 02.08.46.845532000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MARCIE.YOUNG@ORACLE.COM' as updated_by
  from dual
union all
select '3701' as source_id,
       'APPDEV_XLSX_ID:3701' as external_reference,
       'Add additional things to the store/session Rainfocus API' as title,
       to_clob(q'~<div class="ck-content"><p>Need to be able to include the following additional info when running the /session/store</p><figure class="table"><table><tbody><tr><td>CP</td><td>RF Column</td><td>RF Value</td></tr><tr><td>&nbsp;</td><td>Content Area</td><td>Oracle AI Database</td></tr><tr><td>Job Roles (multiple)&nbsp;</td><td>Job Role</td><td>Values from CP</td></tr><tr><td>Key Areas (multiple)</td><td>Areas of Interest</td><td>Values from CP</td></tr><tr><td>Level (one)&nbsp;</td><td>Content Level</td><td>Value from CP</td></tr><tr><td>Industry (one)</td><td>Industry</td><td>Non-Industry Specific</td></tr><tr><td>Org</td><td>Session Allocations</td><td>Oracle Database or Tech-DB</td></tr></tbody></table></figure></div>~') as description,
       'New Feature' as type_name,
       'Not Started' as status_name,
       'Conference Planner' as application_name,
       'zackary.rice@oracle.com' as owner_email,
       'marcie.young@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('27-MAY-26 08.56.51.023620000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MARCIE.YOUNG@ORACLE.COM' as created_by,
       to_timestamp('27-MAY-26 08.56.51.023681000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MARCIE.YOUNG@ORACLE.COM' as updated_by
  from dual
),
member_lookup as (
    select lower(u.email) as email,
           min(tm.team_member_id) as team_member_id
      from tsk_team_members tm
      join tsk_users u
        on u.user_id = tm.user_id
     group by lower(u.email)
),
src as (
    select r.*,
           st.status_id,
           st.status_code,
           ty.type_id,
           app.application_id,
           coalesce(app.owner_team_id, owner_tm.team_id, creator_tm.team_id, 1) as team_id,
           owner_tm.team_member_id as owner_member_id,
           creator_tm.team_member_id as created_by_member_id
      from raw_src r
      left join tsk_statuses st
        on upper(st.status_name) = upper(r.status_name)
      left join tsk_task_types ty
        on upper(ty.type_name) = upper(r.type_name)
      left join tsk_applications app
        on upper(app.application_name) = upper(r.application_name)
      left join member_lookup owner_ml
        on owner_ml.email = lower(r.owner_email)
      left join tsk_team_members owner_tm
        on owner_tm.team_member_id = owner_ml.team_member_id
      left join member_lookup creator_ml
        on creator_ml.email = lower(r.created_by_email)
      left join tsk_team_members creator_tm
        on creator_tm.team_member_id = creator_ml.team_member_id
)
    select *
      from src
) src
on (dst.external_reference = src.external_reference)
when matched then update set
    dst.team_id              = src.team_id,
    dst.title                = src.title,
    dst.description          = src.description,
    dst.type_id              = src.type_id,
    dst.status_id            = src.status_id,
    dst.application_id       = src.application_id,
    dst.owner_member_id      = src.owner_member_id,
    dst.created_by_member_id = src.created_by_member_id,
    dst.priority_code        = src.priority_code,
    dst.due_date             = src.due_date,
    dst.completed_date       = case when src.status_code = 'COMPLETED' then trunc(cast(src.updated_at as date)) else null end,
    dst.percent_complete     = case when src.status_code = 'COMPLETED' then 100 else least(nvl(dst.percent_complete, 0), 99) end,
    dst.created_at           = src.created_at,
    dst.created_by           = src.created_by,
    dst.updated_at           = src.updated_at,
    dst.updated_by           = src.updated_by
when not matched then insert (
    team_id,
    title,
    description,
    type_id,
    status_id,
    application_id,
    owner_member_id,
    created_by_member_id,
    priority_code,
    due_date,
    completed_date,
    percent_complete,
    external_reference,
    created_at,
    created_by,
    updated_at,
    updated_by
) values (
    src.team_id,
    src.title,
    src.description,
    src.type_id,
    src.status_id,
    src.application_id,
    src.owner_member_id,
    src.created_by_member_id,
    src.priority_code,
    src.due_date,
    case when src.status_code = 'COMPLETED' then trunc(cast(src.updated_at as date)) else null end,
    case when src.status_code = 'COMPLETED' then 100 else 0 end,
    src.external_reference,
    src.created_at,
    src.created_by,
    src.updated_at,
    src.updated_by
);

merge into tsk_task_assignees dst
using (
    with raw_src as (
select '3521' as source_id,
       'APPDEV_XLSX_ID:3521' as external_reference,
       'VibeHub: Hide ratings system' as title,
       to_clob(q'~<p>Hide ratings system on Cards, Edit and View screens. Keep it aside for future. Replace with create date or update date.</p>~') as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.01.597611000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3527' as source_id,
       'APPDEV_XLSX_ID:3527' as external_reference,
       'ACE: Add country code to countries table and sync with ref_countries' as title,
       to_clob(q'~<p>using ref_countries as source:</p><ul><li>add country_cd to ace.countries and map it to ref_countries</li><li>map ace.ace_countries.country_code to ref_countries</li></ul>~') as description,
       'Enhancement' as type_name,
       'Completed' as status_name,
       'ACE' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/23/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.49.44.909917000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3524' as source_id,
       'APPDEV_XLSX_ID:3524' as external_reference,
       'VibeDemos: Re-Create demos in VibeHub from Vijay''s REST dump' as title,
       to_clob(q'~<p style="margin-left:0;"># Get token<br>TOKEN=$(curl -s -X POST "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token</span></a>" -u "V6AlKFkoTV5iVkRomg3ezQ..:7bfRQsaFnKbwhtzcFAOHwQ.." -d "grant_type=client_credentials" | jq -r '.access_token')<br><br># Usage log<br>curl -s -H "Authorization: Bearer $TOKEN" "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_usage_log/?limit=500"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_usage_log/?limit=500</span></a>" | jq '.items'<br><br># Skill files<br>curl -s -H "Authorization: Bearer $TOKEN" "<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_skill_files/?limit=500"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/shared_skill_files/?limit=500</span></a>" | jq '.items'</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:36 PM]</p><p style="margin-left:0;">the 2 tables have a view which order by id or laogged timings.&nbsp; -- you need a scheduler job what will create tiles in vibe code hub. -- The link is DB&nbsp; before migration. -- Once you are done with testing, i can provide you the prod DN Ords.</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:36 PM]</p><p style="margin-left:0;">also, you want to access the DN directly, let me know.</p><p style="margin-left:0;"><br>&nbsp;</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">client_id: &nbsp; &nbsp; V6AlKFkoTV5iVkRomg3ezQ.. client_secret: 7bfRQsaFnKbwhtzcFAOHwQ..</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">get token -- curl -X POST \ &nbsp;<a href="https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token"><span style="color:inherit;">https://bk8uwrvkgqzvi2h-vbjson.adb.us-phoenix-1.oraclecloudapps.com/ords/skillstracker/oauth/token</span></a> \ &nbsp;-d "grant_type=client_credentials" \ &nbsp;-u "V6AlKFkoTV5iVkRomg3ezQ..:7bfRQsaFnKbwhtzcFAOHwQ.."</p><p style="margin-left:0;">[9:37 PM]</p><p style="margin-left:0;">then call end point.</p>~') as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('22-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.11.182127000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3268' as source_id,
       'APPDEV_XLSX_ID:3268' as external_reference,
       'DBUS move to APEXADB - Get the App re-configured' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       to_date('03/27/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('16-MAR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.49.23.164494000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3463' as source_id,
       'APPDEV_XLSX_ID:3463' as external_reference,
       'Vibehub: Get domain name & implement redirect' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Backlog' as status_name,
       'Vibe Hub' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       to_date('04/30/2026', 'MM/DD/YYYY') as due_date,
       to_timestamp('07-APR-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.50.36.273798000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3741' as source_id,
       'APPDEV_XLSX_ID:3741' as external_reference,
       'DBUS: WKSP_TAS schema sync up in Dev from Prod' as title,
       to_clob(q'~<p>Created the request:&nbsp;</p><p><a href="https://jira-sd.mc1.oracleiaas.com/browse/DSODBTOOLS-1321">https://jira-sd.mc1.oracleiaas.com/browse/DSODBTOOLS-1321</a></p><p>&nbsp;</p>~') as description,
       'Enhancement' as type_name,
       'Not Started' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 03.56.28.513626000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 03.56.28.513721000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3742' as source_id,
       'APPDEV_XLSX_ID:3742' as external_reference,
       'DBUS: PM Digest testing / Turn on in new system' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'In Progress' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 03.57.03.111872000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 03.57.03.111924000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3743' as source_id,
       'APPDEV_XLSX_ID:3743' as external_reference,
       'DBUS: Log all forward requests to the new site on APEXADB' as title,
       to_clob(q'~<p>Create a table to log who and what the URL and URL params were when people hit the old site.</p>~') as description,
       'New Feature' as type_name,
       'Not Started' as status_name,
       'database.us' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'MEDIUM' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 04.37.35.629982000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.37.35.630035000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3744' as source_id,
       'APPDEV_XLSX_ID:3744' as external_reference,
       'Taxonomy Sync back to APEX.ORACLECORP.COM' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'In Progress' as status_name,
       'Product Taxonomy' as application_name,
       'maqsood.alam@oracle.com' as owner_email,
       'maqsood.alam@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('29-MAY-26 04.48.47.188819000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MAQSOOD.ALAM@ORACLE.COM' as created_by,
       to_timestamp('29-MAY-26 04.48.47.188868000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MAQSOOD.ALAM@ORACLE.COM' as updated_by
  from dual
union all
select '3641' as source_id,
       'APPDEV_XLSX_ID:3641' as external_reference,
       'Create REST API for the TAS_ASSETS Table with OAuth ( Capture Blob columns as well)' as title,
       to_clob(null) as description,
       'New Feature' as type_name,
       'Completed' as status_name,
       'database.us' as application_name,
       'manoj.sundar@oracle.com' as owner_email,
       'manoj.sundar@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('12-MAY-26 12.00.00.000000000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MANOJ.SUNDAR@ORACLE.COM' as created_by,
       to_timestamp('28-MAY-26 09.12.48.594682000 AM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MANOJ.SUNDAR@ORACLE.COM' as updated_by
  from dual
union all
select '3721' as source_id,
       'APPDEV_XLSX_ID:3721' as external_reference,
       'Investigate why Join button doesn''t show on page 3' as title,
       to_clob(q'~<p>Per slack, Investigate why Join button doesn't show on page 3</p>~') as description,
       'Bug' as type_name,
       'Not Started' as status_name,
       'AskTOM Catalog' as application_name,
       'manoj.sundar@oracle.com' as owner_email,
       'marcie.young@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('28-MAY-26 02.08.46.845426000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MARCIE.YOUNG@ORACLE.COM' as created_by,
       to_timestamp('28-MAY-26 02.08.46.845532000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MARCIE.YOUNG@ORACLE.COM' as updated_by
  from dual
union all
select '3701' as source_id,
       'APPDEV_XLSX_ID:3701' as external_reference,
       'Add additional things to the store/session Rainfocus API' as title,
       to_clob(q'~<div class="ck-content"><p>Need to be able to include the following additional info when running the /session/store</p><figure class="table"><table><tbody><tr><td>CP</td><td>RF Column</td><td>RF Value</td></tr><tr><td>&nbsp;</td><td>Content Area</td><td>Oracle AI Database</td></tr><tr><td>Job Roles (multiple)&nbsp;</td><td>Job Role</td><td>Values from CP</td></tr><tr><td>Key Areas (multiple)</td><td>Areas of Interest</td><td>Values from CP</td></tr><tr><td>Level (one)&nbsp;</td><td>Content Level</td><td>Value from CP</td></tr><tr><td>Industry (one)</td><td>Industry</td><td>Non-Industry Specific</td></tr><tr><td>Org</td><td>Session Allocations</td><td>Oracle Database or Tech-DB</td></tr></tbody></table></figure></div>~') as description,
       'New Feature' as type_name,
       'Not Started' as status_name,
       'Conference Planner' as application_name,
       'zackary.rice@oracle.com' as owner_email,
       'marcie.young@oracle.com' as created_by_email,
       'HIGH' as priority_code,
       null as due_date,
       to_timestamp('27-MAY-26 08.56.51.023620000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as created_at,
       'MARCIE.YOUNG@ORACLE.COM' as created_by,
       to_timestamp('27-MAY-26 08.56.51.023681000 PM', 'DD-MON-RR HH.MI.SSXFF AM') as updated_at,
       'MARCIE.YOUNG@ORACLE.COM' as updated_by
  from dual
),
member_lookup as (
    select lower(u.email) as email,
           min(tm.team_member_id) as team_member_id
      from tsk_team_members tm
      join tsk_users u
        on u.user_id = tm.user_id
     group by lower(u.email)
),
src as (
    select r.*,
           st.status_id,
           st.status_code,
           ty.type_id,
           app.application_id,
           coalesce(app.owner_team_id, owner_tm.team_id, creator_tm.team_id, 1) as team_id,
           owner_tm.team_member_id as owner_member_id,
           creator_tm.team_member_id as created_by_member_id
      from raw_src r
      left join tsk_statuses st
        on upper(st.status_name) = upper(r.status_name)
      left join tsk_task_types ty
        on upper(ty.type_name) = upper(r.type_name)
      left join tsk_applications app
        on upper(app.application_name) = upper(r.application_name)
      left join member_lookup owner_ml
        on owner_ml.email = lower(r.owner_email)
      left join tsk_team_members owner_tm
        on owner_tm.team_member_id = owner_ml.team_member_id
      left join member_lookup creator_ml
        on creator_ml.email = lower(r.created_by_email)
      left join tsk_team_members creator_tm
        on creator_tm.team_member_id = creator_ml.team_member_id
)
    select t.task_id,
           src.owner_member_id as team_member_id,
           trunc(cast(src.created_at as date)) as assigned_on,
           src.created_by,
           src.updated_by
      from src
      join tsk_tasks t
        on t.external_reference = src.external_reference
     where src.owner_member_id is not null
) src
on (
    dst.task_id = src.task_id
    and dst.team_member_id = src.team_member_id
    and dst.active_yn = 'Y'
)
when matched then update set
    dst.assignment_role = 'Owner',
    dst.allocated_pct   = 100,
    dst.updated_by      = src.updated_by
when not matched then insert (
    task_id,
    team_member_id,
    assignment_role,
    allocated_pct,
    active_yn,
    assigned_on,
    created_by,
    updated_by
) values (
    src.task_id,
    src.team_member_id,
    'Owner',
    100,
    'Y',
    src.assigned_on,
    src.created_by,
    src.updated_by
);

commit;

prompt Task upsert complete.
