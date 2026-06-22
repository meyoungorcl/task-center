prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.0'
,p_default_workspace_id=>7097755211213275
,p_default_application_id=>12892
,p_default_id_offset=>22892313204588023
,p_default_owner=>'WKSP_DBAPPDEV'
);
end;
/
 
prompt APPLICATION 12892 - Task Center
--
-- Application Export:
--   Application:     12892
--   Name:            Task Center
--   Date and Time:   23:40 Wednesday June 3, 2026
--   Exported By:     WKSP_DBAPPDEV
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PAGE: 40
--     PAGE: 41
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     746020101855378
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/pages/delete_00040
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>40);
end;
/
prompt --application/pages/page_00040
begin
wwv_flow_imp_page.create_page(
 p_id=>40
,p_name=>'Email Schedules'
,p_alias=>'EMAIL-SCHEDULES'
,p_step_title=>'Email Schedules'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'25'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40510590349901205)
,p_plug_name=>'Daily Team Member Task Summary'
,p_static_id=>'daily-summary-controls'
,p_parent_plug_id=>wwv_flow_imp.id(40520886906990472)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'tsk_daily_email_pkg.selected_schedule_is(:P40_EMAIL_SCHEDULE_ID, ''DAILY_MEMBER_STATUS'')'
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40510661912901205)
,p_plug_name=>'Daily Email Preview'
,p_static_id=>'daily-summary-email-preview'
,p_parent_plug_id=>wwv_flow_imp.id(40520886906990472)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_team_member_id tsk_team_members.team_member_id%type;',
'begin',
'    l_team_member_id := :P40_PREVIEW_MEMBER_ID;',
'',
'    if l_team_member_id is null then',
'        select min(team_member_id)',
'          into l_team_member_id',
'          from (',
'              select tm.team_member_id',
'                from tsk_team_members tm',
'                join tsk_users u',
'                  on u.user_id = tm.user_id',
'                join tsk_email_schedules es',
'                  on es.team_id = tm.team_id',
'               where es.email_schedule_id = :P40_EMAIL_SCHEDULE_ID',
'                 and tm.active_yn = ''Y''',
'                 and u.active_yn = ''Y''',
'                 and (',
'                         not exists (',
'                             select 1',
'                               from tsk_email_recipients er',
'                              where er.email_schedule_id = es.email_schedule_id',
'                                and er.active_yn = ''Y''',
'                                and er.team_member_id is not null',
'                         )',
'                      or exists (',
'                             select 1',
'                               from tsk_email_recipients er',
'                              where er.email_schedule_id = es.email_schedule_id',
'                                and er.team_member_id = tm.team_member_id',
'                                and er.active_yn = ''Y''',
'                         )',
'                     )',
'              union all',
'              select tm.team_member_id',
'                from tsk_team_members tm',
'                join tsk_users u',
'                  on u.user_id = tm.user_id',
'               where :P40_EMAIL_SCHEDULE_ID is null',
'                 and tm.active_yn = ''Y''',
'                 and u.active_yn = ''Y''',
'          );',
'    end if;',
'',
'    return tsk_daily_email_pkg.member_email_html(l_team_member_id);',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P40_EMAIL_SCHEDULE_ID,P40_PREVIEW_MEMBER_ID'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'tsk_daily_email_pkg.selected_schedule_is(:P40_EMAIL_SCHEDULE_ID, ''DAILY_MEMBER_STATUS'')'
,p_plug_display_when_cond2=>'PLSQL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(9994001001)
,p_plug_name=>'Daily Unassigned Task Submitter Reminder'
,p_static_id=>'unassigned-submitter-controls'
,p_parent_plug_id=>wwv_flow_imp.id(40520886906990472)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'tsk_daily_email_pkg.selected_schedule_is(:P40_EMAIL_SCHEDULE_ID, ''DAILY_UNASSIGNED_SUBMITTER'')'
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(9994001002)
,p_plug_name=>'Submitter Reminder Preview'
,p_static_id=>'unassigned-submitter-email-preview'
,p_parent_plug_id=>wwv_flow_imp.id(40520886906990472)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    return tsk_daily_email_pkg.unassigned_submitter_reminder_html(',
'        :P40_EMAIL_SCHEDULE_ID,',
'        :P40_PREVIEW_SUBMITTER_MEMBER_ID',
'    );',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P40_EMAIL_SCHEDULE_ID,P40_PREVIEW_SUBMITTER_MEMBER_ID'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'tsk_daily_email_pkg.selected_schedule_is(:P40_EMAIL_SCHEDULE_ID, ''DAILY_UNASSIGNED_SUBMITTER'')'
,p_plug_display_when_cond2=>'PLSQL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40520886906990472)
,p_plug_name=>'Email Preview'
,p_static_id=>'email-preview-panel'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>8
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(40519927025990471)
,p_name=>'Email Schedules'
,p_static_id=>'email-schedule-list'
,p_template=>4073835273271169698
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--inline:t-Report--stretch'
,p_grid_column_span=>4
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with selected_schedule as (',
'    select coalesce(',
'               max(to_number(:P40_EMAIL_SCHEDULE_ID)),',
'               min(email_schedule_id)',
'           ) as email_schedule_id',
'      from tsk_email_schedules',
')',
'select null as schedule_card,',
'       es.email_schedule_id,',
'       es.schedule_name,',
'       es.schedule_code,',
'       t.team_name,',
'       es.enabled_yn,',
'       case',
'           when es.send_at is not null',
'           then to_char(es.send_at, ''Dy, Mon DD YYYY HH24:MI'')',
'           else lpad(es.send_hour, 2, ''0'') || '':'' || lpad(es.send_minute, 2, ''0'')',
'       end as send_time,',
'       case',
'           when es.email_schedule_id = ss.email_schedule_id',
'           then ''#2563eb''',
'           else ''var(--ut-component-border-color)''',
'       end as card_border_color,',
'       case',
'           when es.email_schedule_id = ss.email_schedule_id',
'           then ''var(--ut-component-highlight-background-color)''',
'           else ''transparent''',
'       end as card_background,',
'       apex_page.get_url(',
'           p_page => 40,',
'           p_items => ''P40_EMAIL_SCHEDULE_ID'',',
'           p_values => es.email_schedule_id',
'       ) as preview_url,',
'       apex_page.get_url(',
'           p_page => 41,',
'           p_clear_cache => ''41'',',
'           p_items => ''P41_EMAIL_SCHEDULE_ID'',',
'           p_values => es.email_schedule_id',
'       ) as edit_url',
'  from tsk_email_schedules es',
'  join tsk_teams t',
'    on t.team_id = es.team_id',
'  cross join selected_schedule ss',
' order by case es.schedule_code',
'              when ''DAILY_MEMBER_STATUS'' then 1',
'              when ''DAILY_UNASSIGNED_SUBMITTER'' then 2',
'              when ''MONTHLY_TEAM_PROGRESS'' then 3',
'              when ''WEEKLY_TEAM_SUMMARY'' then 4',
'              else 9',
'          end,',
'          es.schedule_name'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P40_EMAIL_SCHEDULE_ID'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No email schedules found.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40760348761299785)
,p_query_column_id=>9
,p_column_alias=>'CARD_BACKGROUND'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40760267454299785)
,p_query_column_id=>8
,p_column_alias=>'CARD_BORDER_COLOR'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520778538990472)
,p_query_column_id=>11
,p_column_alias=>'EDIT_URL'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520203198990472)
,p_query_column_id=>2
,p_column_alias=>'EMAIL_SCHEDULE_ID'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520532559990472)
,p_query_column_id=>6
,p_column_alias=>'ENABLED_YN'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40760487702299785)
,p_query_column_id=>10
,p_column_alias=>'PREVIEW_URL'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520066178990472)
,p_query_column_id=>1
,p_column_alias=>'SCHEDULE_CARD'
,p_column_display_sequence=>10
,p_column_heading=>' '
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div style="padding:14px 12px;margin-bottom:10px;border:1px solid #CARD_BORDER_COLOR#;border-left:4px solid #CARD_BORDER_COLOR#;border-radius:8px;background:#CARD_BACKGROUND#;color:inherit">',
'  <div style="display:flex;gap:10px;align-items:flex-start;justify-content:space-between">',
'    <a href="#PREVIEW_URL#" style="flex:1;text-decoration:none;color:inherit">',
'      <div style="font-weight:700">#SCHEDULE_NAME#</div>',
'      <div style="font-size:.82rem;color:var(--ut-component-text-muted-color)">#TEAM_NAME# &#8226; #SEND_TIME# &#8226; Enabled #ENABLED_YN#</div>',
'    </a>',
'    <a href="#EDIT_URL#" class="t-Button t-Button--small t-Button--noLabel t-Button--icon" title="Edit #SCHEDULE_NAME#" aria-label="Edit #SCHEDULE_NAME#"><span class="t-Icon fa fa-edit" aria-hidden="true"></span></a>',
'  </div>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520369400990472)
,p_query_column_id=>4
,p_column_alias=>'SCHEDULE_CODE'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520292308990472)
,p_query_column_id=>3
,p_column_alias=>'SCHEDULE_NAME'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520709429990472)
,p_query_column_id=>7
,p_column_alias=>'SEND_TIME'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(40520455896990472)
,p_query_column_id=>5
,p_column_alias=>'TEAM_NAME'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40520945272990473)
,p_plug_name=>'Monthly Team Progress Summary'
,p_static_id=>'monthly-summary-controls'
,p_parent_plug_id=>wwv_flow_imp.id(40520886906990472)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'tsk_daily_email_pkg.selected_schedule_is(:P40_EMAIL_SCHEDULE_ID, ''MONTHLY_TEAM_PROGRESS'')'
,p_plug_display_when_cond2=>'PLSQL'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40521106198990473)
,p_plug_name=>'Monthly Email Preview'
,p_static_id=>'monthly-summary-email-preview'
,p_parent_plug_id=>wwv_flow_imp.id(40520886906990472)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>60
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_team_id tsk_teams.team_id%type;',
'begin',
'    l_team_id := :P40_PREVIEW_TEAM_ID;',
'',
'    if l_team_id is null then',
'        select coalesce(',
'                   (',
'                       select team_id',
'                         from tsk_email_schedules',
'                        where email_schedule_id = :P40_EMAIL_SCHEDULE_ID',
'                   ),',
'                   (',
'                       select min(team_id)',
'                         from tsk_teams',
'                        where active_yn = ''Y''',
'                   )',
'               )',
'          into l_team_id',
'          from dual;',
'    end if;',
'',
'    return tsk_daily_email_pkg.monthly_team_html(l_team_id);',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_ajax_items_to_submit=>'P40_EMAIL_SCHEDULE_ID,P40_PREVIEW_TEAM_ID'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'tsk_daily_email_pkg.selected_schedule_is(:P40_EMAIL_SCHEDULE_ID, ''MONTHLY_TEAM_PROGRESS'')'
,p_plug_display_when_cond2=>'PLSQL'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(27092317204589024)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40519927025990471)
,p_button_name=>'EMAIL_LOG'
,p_static_id=>'email-log'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Email Log'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:42:&SESSION.::&DEBUG.:42::'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40760524895299787)
,p_name=>'P40_EMAIL_SCHEDULE_ID'
,p_item_sequence=>5
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40510860282901207)
,p_name=>'P40_PREVIEW_MEMBER_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40510590349901205)
,p_prompt=>'Preview Recipient'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.display_name || '' ('' || u.email || '')'' as display_value,',
'       tm.team_member_id as return_value',
'  from tsk_team_members tm',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
' where tm.active_yn = ''Y''',
'   and u.active_yn = ''Y''',
'   and tm.team_id = coalesce(',
'           (',
'               select team_id',
'                 from tsk_email_schedules',
'                where email_schedule_id = :P40_EMAIL_SCHEDULE_ID',
'           ),',
'           tm.team_id',
'       )',
'   and (',
'           :P40_EMAIL_SCHEDULE_ID is null',
'        or not exists (',
'               select 1',
'                 from tsk_email_recipients er',
'                where er.email_schedule_id = :P40_EMAIL_SCHEDULE_ID',
'                  and er.active_yn = ''Y''',
'                  and er.team_member_id is not null',
'           )',
'        or exists (',
'               select 1',
'                 from tsk_email_recipients er',
'                where er.email_schedule_id = :P40_EMAIL_SCHEDULE_ID',
'                  and er.team_member_id = tm.team_member_id',
'                  and er.active_yn = ''Y''',
'           )',
'       )',
' order by u.display_name'))
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'infinite_scroll', 'Y',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9994001003)
,p_name=>'P40_PREVIEW_SUBMITTER_MEMBER_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(9994001001)
,p_prompt=>'Preview Submitter'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select display_name || '' ('' || recipient_email || '')'' as display_value,',
'       team_member_id as return_value',
'  from (',
'        select max(display_name) as display_name,',
'               recipient_email,',
'               min(team_member_id) as team_member_id',
'          from (',
'                select distinct',
'                       t.task_id,',
'                       coalesce(',
'                           case when u_submitter.active_yn = ''Y'' then u_submitter.email end,',
'                           case when u_created.active_yn = ''Y'' then u_created.email end',
'                       ) as recipient_email,',
'                       coalesce(',
'                           case when u_submitter.active_yn = ''Y'' then u_submitter.display_name end,',
'                           case when u_created.active_yn = ''Y'' then u_created.display_name end,',
'                           t.created_by',
'                       ) as display_name,',
'                       coalesce(',
'                           case when u_submitter.active_yn = ''Y'' then tm_submitter.team_member_id end,',
'                           case when u_created.active_yn = ''Y'' then tm_created.team_member_id end',
'                       ) as team_member_id',
'                  from tsk_tasks t',
'                  join tsk_statuses st',
'                    on st.status_id = t.status_id',
'                  join tsk_email_schedules es',
'                    on es.team_id = t.team_id',
'                  left join tsk_team_members tm_submitter',
'                    on tm_submitter.team_member_id = t.created_by_member_id',
'                  left join tsk_users u_submitter',
'                    on u_submitter.user_id = tm_submitter.user_id',
'                  left join tsk_users u_created',
'                    on lower(u_created.email) = lower(t.created_by)',
'                  left join tsk_team_members tm_created',
'                    on tm_created.user_id = u_created.user_id',
'                   and tm_created.team_id = t.team_id',
'                   and tm_created.active_yn = ''Y''',
'                 where es.email_schedule_id = :P40_EMAIL_SCHEDULE_ID',
'                   and st.is_done_yn = ''N''',
'                   and not exists (',
'                           select 1',
'                             from tsk_task_assignees ta',
'                            where ta.task_id = t.task_id',
'                              and ta.active_yn = ''Y''',
'                       )',
'               )',
'         where recipient_email is not null',
'           and team_member_id is not null',
'         group by recipient_email',
'       )',
' order by display_name'))
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'infinite_scroll', 'Y',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40521185555990473)
,p_name=>'P40_PREVIEW_TEAM_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40520945272990473)
,p_prompt=>'Preview Team'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_ONE'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select team_name as display_value,',
'       team_id as return_value',
'  from tsk_teams',
' where active_yn = ''Y''',
' order by team_name'))
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'infinite_scroll', 'Y',
  'match_type', 'CONTAINS',
  'min_chars', '0')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40521218465990473)
,p_name=>'Refresh Daily Email Preview'
,p_static_id=>'refresh-daily-email-preview'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_PREVIEW_MEMBER_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40521398590990473)
,p_event_id=>wwv_flow_imp.id(40521218465990473)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-preview'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40510661912901205)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(9994001004)
,p_name=>'Refresh Unassigned Submitter Email Preview'
,p_static_id=>'refresh-unassigned-submitter-email-preview'
,p_event_sequence=>15
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_PREVIEW_SUBMITTER_MEMBER_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9994001005)
,p_event_id=>wwv_flow_imp.id(9994001004)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-preview'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(9994001002)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40521451150990474)
,p_name=>'Refresh Monthly Email Preview'
,p_static_id=>'refresh-monthly-email-preview'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P40_PREVIEW_TEAM_ID'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40521562393990474)
,p_event_id=>wwv_flow_imp.id(40521451150990474)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-preview'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40521106198990473)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40521709445990474)
,p_name=>'Refresh on Schedule Dialog Close'
,p_static_id=>'refresh-on-schedule-dialog-close'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(40519927025990471)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40521839370990474)
,p_event_id=>wwv_flow_imp.id(40521709445990474)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-daily-preview'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40510661912901205)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9994001006)
,p_event_id=>wwv_flow_imp.id(40521709445990474)
,p_event_result=>'TRUE'
,p_action_sequence=>25
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-unassigned-submitter-preview'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(9994001002)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40521933413990474)
,p_event_id=>wwv_flow_imp.id(40521709445990474)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-monthly-preview'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40521106198990473)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40521732694990474)
,p_event_id=>wwv_flow_imp.id(40521709445990474)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-schedules'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(40519927025990471)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/delete_00041
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>41);
end;
/
prompt --application/pages/page_00041
begin
wwv_flow_imp_page.create_page(
 p_id=>41
,p_name=>'Email Schedule'
,p_alias=>'EMAIL-SCHEDULE'
,p_page_mode=>'MODAL'
,p_step_title=>'Email Schedule'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1662662927374504442
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_dialog_chained=>'N'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40517621470990468)
,p_plug_name=>'Buttons'
,p_static_id=>'buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>20
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(40517771865990468)
,p_plug_name=>'Schedule Parameters'
,p_static_id=>'email-schedule-form'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_EMAIL_SCHEDULES'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40519088330990470)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(40517621470990468)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(40519120462990470)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(40517621470990468)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(32882317304588024)
,p_button_sequence=>15
,p_button_plug_id=>wwv_flow_imp.id(40517621470990468)
,p_button_name=>'SEND_NOW'
,p_static_id=>'send-now'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Send Now'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>':P41_SCHEDULE_CODE in (''DAILY_MEMBER_STATUS'',''DAILY_UNASSIGNED_SUBMITTER'')'
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40517846087990468)
,p_name=>'P41_EMAIL_SCHEDULE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_source=>'EMAIL_SCHEDULE_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518167321990469)
,p_name=>'P41_ENABLED_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Enabled'
,p_source=>'ENABLED_YN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518679671990469)
,p_name=>'P41_INCLUDE_ASSIGNED_TASKS_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Include Assigned Tasks'
,p_source=>'INCLUDE_ASSIGNED_TASKS_YN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518952882990470)
,p_name=>'P41_INCLUDE_COMMENTS_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Include Comments'
,p_source=>'INCLUDE_COMMENTS_YN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518879975990470)
,p_name=>'P41_INCLUDE_OVERDUE_TASKS_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Include Overdue Tasks'
,p_source=>'INCLUDE_OVERDUE_TASKS_YN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518715310990470)
,p_name=>'P41_INCLUDE_TASK_UPDATES_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Include Task Updates'
,p_source=>'INCLUDE_TASK_UPDATES_YN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518236577990469)
,p_name=>'P41_RECIPIENTS_SCOPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Recipients'
,p_source=>'RECIPIENTS_SCOPE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Team Members;TEAM_MEMBERS,Team Leads;TEAM_LEADS,Managers;MANAGERS,Custom;CUSTOM'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_display_when=>':P41_SCHEDULE_CODE not in (''DAILY_MEMBER_STATUS'',''DAILY_UNASSIGNED_SUBMITTER'')'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518069370990469)
,p_name=>'P41_SCHEDULE_CODE'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Schedule Code'
,p_source=>'SCHEDULE_CODE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>50
,p_colspan=>12
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40517951951990468)
,p_name=>'P41_SCHEDULE_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Schedule Name'
,p_source=>'SCHEDULE_NAME'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>200
,p_colspan=>12
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(32882317304588026)
,p_name=>'P41_SEND_AT'
,p_source_data_type=>'TIMESTAMP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Send Date and Time'
,p_format_mask=>'YYYY-MM-DD HH24:MI'
,p_source=>'SEND_AT'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_colspan=>12
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'Y',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518402784990469)
,p_name=>'P41_SEND_HOUR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>65
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_source=>'SEND_HOUR'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518468043990469)
,p_name=>'P41_SEND_MINUTE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_source=>'SEND_MINUTE'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40756483225260128)
,p_name=>'P41_TEAM_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>25
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_source=>'TEAM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40756524521260128)
,p_name=>'P41_TEAM_MEMBER_IDS'
,p_item_sequence=>55
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Team Members to Email'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_MANY'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.display_name || '' ('' || u.email || '')'' as display_value,',
'       tm.team_member_id as return_value',
'  from tsk_team_members tm',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
' where tm.active_yn = ''Y''',
'   and u.active_yn = ''Y''',
'   and tm.team_id = :P41_TEAM_ID',
' order by u.display_name'))
,p_colspan=>12
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'infinite_scroll', 'Y',
  'match_type', 'CONTAINS',
  'min_chars', '0',
  'use_defaults', 'Y')).to_clob
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40518581134990469)
,p_name=>'P41_WEEKLY_DAY_NUMBER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_item_source_plug_id=>wwv_flow_imp.id(40517771865990468)
,p_prompt=>'Day Number'
,p_source=>'WEEKLY_DAY_NUMBER'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_colspan=>4
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(40519231512990470)
,p_name=>'Cancel Dialog'
,p_static_id=>'cancel-dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(40519088330990470)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(40519346817990470)
,p_event_id=>wwv_flow_imp.id(40519231512990470)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-dialog-cancel'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40519462842990470)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_static_id=>'close-dialog'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'show_success_messages', 'Y')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE,SEND_NOW'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>17627149638402447
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40519545369990470)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(40517771865990468)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Email Schedule'
,p_static_id=>'initialize-form-email-schedule-form'
,p_internal_uid=>17627232165402447
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40756659681260130)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Team Member Recipients'
,p_static_id=>'load-team-member-recipients'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select listagg(team_member_id, '':'') within group (order by team_member_id)',
'      into :P41_TEAM_MEMBER_IDS',
'      from tsk_email_recipients',
'     where email_schedule_id = :P41_EMAIL_SCHEDULE_ID',
'       and active_yn = ''Y''',
'       and team_member_id is not null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>17864346476672107
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40519688945990470)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(40517771865990468)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Email Schedule'
,p_static_id=>'process-form-email-schedule-form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>17627375741402447
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40756792553260130)
,p_process_sequence=>15
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Team Member Recipients'
,p_static_id=>'save-team-member-recipients'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    update tsk_email_recipients',
'       set active_yn = ''N''',
'     where email_schedule_id = :P41_EMAIL_SCHEDULE_ID;',
'',
'    for r in (',
'        select distinct to_number(column_value) as team_member_id',
'          from table(apex_string.split(:P41_TEAM_MEMBER_IDS, '':''))',
'         where regexp_like(column_value, ''^[0-9]+$'')',
'    ) loop',
'        merge into tsk_email_recipients dst',
'        using (',
'            select :P41_EMAIL_SCHEDULE_ID as email_schedule_id,',
'                   r.team_member_id as team_member_id',
'              from dual',
'        ) src',
'        on (',
'            dst.email_schedule_id = src.email_schedule_id',
'            and dst.team_member_id = src.team_member_id',
'        )',
'        when matched then',
'            update set active_yn = ''Y''',
'        when not matched then',
'            insert (',
'                email_schedule_id,',
'                team_member_id,',
'                active_yn,',
'                created_by',
'            ) values (',
'                src.email_schedule_id,',
'                src.team_member_id,',
'                ''Y'',',
'                :APP_USER',
'            );',
'    end loop;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE,SEND_NOW'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>17864479348672107
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882317304588025)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send Daily Email Now'
,p_static_id=>'send-daily-email-now'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P41_SCHEDULE_CODE = ''DAILY_UNASSIGNED_SUBMITTER'' then',
'        tsk_daily_email_pkg.send_unassigned_submitter_reminders(:P41_EMAIL_SCHEDULE_ID);',
'    else',
'        tsk_daily_email_pkg.send_daily_schedule(:P41_EMAIL_SCHEDULE_ID);',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SEND_NOW'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>'Email queued'
,p_internal_uid=>9990004100000002
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(40525040198003872)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Sync Email Automation'
,p_static_id=>'sync-email-automation'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE,SEND_NOW'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>17632726993415849
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
