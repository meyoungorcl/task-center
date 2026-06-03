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
,p_default_application_id=>132
,p_default_id_offset=>0
,p_default_owner=>'WKSP_DBAPPDEV'
);
end;
/
 
prompt APPLICATION 132 - Task Center
--
-- Application Export:
--   Application:     132
--   Name:            Task Center
--   Date and Time:   23:03 Tuesday June 2, 2026
--   Exported By:     WKSP_DBAPPDEV
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 70
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     746020101855378
--

begin
null;
end;
/
prompt --application/pages/delete_00070
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>70);
end;
/
prompt --application/pages/page_00070
begin
wwv_flow_imp_page.create_page(
 p_id=>70
,p_name=>'Team Member Dashboard'
,p_alias=>'TEAM-MEMBER-DASHBOARD'
,p_step_title=>'Team Member Dashboard'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17622742692368190)
,p_plug_name=>'My Dashboard Left'
,p_static_id=>'my-dashboard-left'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>4
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17603845200145400)
,p_plug_name=>'Tasks by Priority'
,p_static_id=>'my-open-tasks-by-priority'
,p_parent_plug_id=>wwv_flow_imp.id(17622742692368190)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(17603992282145401)
,p_region_id=>wwv_flow_imp.id(17603845200145400)
,p_chart_type=>'donut'
,p_title=>'Tasks by Priority'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17604090716145401)
,p_chart_id=>wwv_flow_imp.id(17603992282145401)
,p_static_id=>'my-open-tasks-by-priority'
,p_seq=>10
,p_name=>'Tasks by Priority'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select v.priority_code as label,',
'       count(distinct v.task_id) as value,',
'       apex_page.get_url(',
'           p_page => 70,',
'           p_clear_cache => ''70'',',
'           p_items => ''P70_PRIORITY'',',
'           p_values => v.priority_code',
'       ) as link',
'  from tsk_v_task_list v',
'  join tsk_task_assignees ta',
'    on ta.task_id = v.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where nvl(v.is_done_yn, ''N'') = ''N''',
'   and (',
'           lower(u.username) = lower(:APP_USER)',
'        or lower(u.email) = lower(:APP_USER)',
'       )',
' group by v.priority_code',
' order by case v.priority_code',
'              when ''CRITICAL'' then 1',
'              when ''HIGH'' then 2',
'              when ''MEDIUM'' then 3',
'              when ''LOW'' then 4',
'              else 5',
'          end'))
,p_series_type=>'donut'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'LABEL'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(17602347411145399)
,p_name=>'My Task Overview'
,p_static_id=>'my-task-overview'
,p_parent_plug_id=>wwv_flow_imp.id(17622742692368190)
,p_template=>4073835273271169698
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--inline:t-Report--stretch'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with my_tasks as (',
'    select distinct v.task_id,',
'           v.status_code,',
'           v.overdue_yn,',
'           v.is_done_yn',
'      from tsk_v_task_list v',
'      join tsk_task_assignees ta',
'        on ta.task_id = v.task_id',
'       and ta.active_yn = ''Y''',
'      join tsk_team_members tm',
'        on tm.team_member_id = ta.team_member_id',
'       and tm.active_yn = ''Y''',
'      join tsk_users u',
'        on u.user_id = tm.user_id',
'       and u.active_yn = ''Y''',
'     where lower(u.username) = lower(:APP_USER)',
'        or lower(u.email) = lower(:APP_USER)',
')',
'select null as card_layout,',
'       count(*) as total_tasks,',
'       sum(case when nvl(is_done_yn, ''N'') = ''N'' then 1 else 0 end) as open_tasks,',
'       sum(case when status_code = ''IN_PROGRESS'' then 1 else 0 end) as in_progress_tasks,',
'       sum(case when status_code = ''COMPLETED'' then 1 else 0 end) as completed_tasks,',
'       sum(case when status_code = ''ARCHIVE'' then 1 else 0 end) as archive_tasks,',
'       sum(case when overdue_yn = ''Y'' and nvl(is_done_yn, ''N'') = ''N'' then 1 else 0 end) as overdue_tasks,',
'       apex_page.get_url(p_page => 70, p_clear_cache => ''70'', p_items => ''P70_SCOPE'', p_values => ''ALL'') as total_tasks_url,',
'       apex_page.get_url(p_page => 70, p_clear_cache => ''70'', p_items => ''P70_STATUS'', p_values => ''In Progress'') as in_progress_tasks_url,',
'       apex_page.get_url(p_page => 70, p_clear_cache => ''70'', p_items => ''P70_STATUS'', p_values => ''Completed'') as completed_tasks_url,',
'       apex_page.get_url(p_page => 70, p_clear_cache => ''70'', p_items => ''P70_STATUS'', p_values => ''Archive'') as archive_tasks_url,',
'       apex_page.get_url(p_page => 70, p_clear_cache => ''70'', p_items => ''P70_OVERDUE'', p_values => ''Y'') as overdue_tasks_url,',
'       apex_page.get_url(p_page => 70, p_clear_cache => ''70'', p_items => ''P70_SCOPE'', p_values => ''OPEN'') as open_tasks_url',
'  from my_tasks'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No assigned tasks found.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990007000000201)
,p_query_column_id=>12
,p_column_alias=>'ARCHIVE_TASKS'
,p_column_display_sequence=>55
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990007000000202)
,p_query_column_id=>13
,p_column_alias=>'ARCHIVE_TASKS_URL'
,p_column_display_sequence=>95
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17602445800145400)
,p_query_column_id=>1
,p_column_alias=>'CARD_LAYOUT'
,p_column_display_sequence=>10
,p_column_heading=>' '
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(130px,1fr));gap:10px">',
'  <a href="#TOTAL_TASKS_URL#" style="padding:12px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-clipboard-list u-info-text"></span> <b style="font-size:1.45rem">#TOTAL_TASKS'
||'#</b><br>Total Assigned</a>',
'  <a href="#OPEN_TASKS_URL#" style="padding:12px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-list-ul u-warning-text"></span> <b style="font-size:1.45rem">#OPEN_TASKS#</b><'
||'br>Open Tasks</a>',
'  <a href="#IN_PROGRESS_TASKS_URL#" style="padding:12px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-refresh" style="color:#2563eb" aria-hidden="true"></span> <b style="fon'
||'t-size:1.45rem">#IN_PROGRESS_TASKS#</b><br>In Progress</a>',
'  <a href="#COMPLETED_TASKS_URL#" style="padding:12px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-check-circle u-success-text"></span> <b style="font-size:1.45rem">#COMPLE'
||'TED_TASKS#</b><br>Completed</a>',
'  <a href="#ARCHIVE_TASKS_URL#" style="padding:12px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-archive" style="color:#64748b" aria-hidden="true"></span> <b style="font-si'
||'ze:1.45rem">#ARCHIVE_TASKS#</b><br>Archive</a>',
'  <a href="#OVERDUE_TASKS_URL#" style="padding:12px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-exclamation-circle u-danger-text"></span> <b style="font-size:1.45rem">#OVE'
||'RDUE_TASKS#</b><br>Overdue</a>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17602892493145400)
,p_query_column_id=>5
,p_column_alias=>'COMPLETED_TASKS'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17603275469145400)
,p_query_column_id=>9
,p_column_alias=>'COMPLETED_TASKS_URL'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17602740921145400)
,p_query_column_id=>4
,p_column_alias=>'IN_PROGRESS_TASKS'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17603181958145400)
,p_query_column_id=>8
,p_column_alias=>'IN_PROGRESS_TASKS_URL'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17602676766145400)
,p_query_column_id=>3
,p_column_alias=>'OPEN_TASKS'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17603448262145400)
,p_query_column_id=>11
,p_column_alias=>'OPEN_TASKS_URL'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17602959084145400)
,p_query_column_id=>6
,p_column_alias=>'OVERDUE_TASKS'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17603357715145400)
,p_query_column_id=>10
,p_column_alias=>'OVERDUE_TASKS_URL'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17602567127145400)
,p_query_column_id=>2
,p_column_alias=>'TOTAL_TASKS'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17603078918145400)
,p_query_column_id=>7
,p_column_alias=>'TOTAL_TASKS_URL'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17603505431145400)
,p_plug_name=>'My Tasks by Status'
,p_static_id=>'my-tasks-by-status'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_grid_column_span=>6
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'1 = 0'
,p_plug_display_when_cond2=>'PLSQL'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(17603680348145400)
,p_region_id=>wwv_flow_imp.id(17603505431145400)
,p_chart_type=>'donut'
,p_title=>'My Tasks by Status'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17603733589145400)
,p_chart_id=>wwv_flow_imp.id(17603680348145400)
,p_static_id=>'my-tasks-by-status'
,p_seq=>10
,p_name=>'My Tasks by Status'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select v.status_name as label,',
'       count(distinct v.task_id) as value,',
'       apex_page.get_url(',
'           p_page => 70,',
'           p_clear_cache => ''70'',',
'           p_items => ''P70_STATUS'',',
'           p_values => v.status_name',
'       ) as link',
'  from tsk_v_task_list v',
'  join tsk_task_assignees ta',
'    on ta.task_id = v.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where lower(u.username) = lower(:APP_USER)',
'    or lower(u.email) = lower(:APP_USER)',
' group by v.status_name',
' order by v.status_name'))
,p_series_type=>'donut'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'LABEL'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(9990007000000401)
,p_plug_name=>'Tasks Due by Week'
,p_static_id=>'my-tasks-due-by-week'
,p_parent_plug_id=>wwv_flow_imp.id(17622742692368190)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(9990007000000402)
,p_region_id=>wwv_flow_imp.id(9990007000000401)
,p_chart_type=>'bar'
,p_title=>'Tasks Due by Week'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(9990007000000403)
,p_chart_id=>wwv_flow_imp.id(9990007000000402)
,p_static_id=>'my-tasks-due-by-week'
,p_seq=>10
,p_name=>'Tasks Due'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Week of '' || to_char(trunc(v.due_date, ''IW''), ''YYYY-MM-DD'') as label,',
'       count(distinct v.task_id) as value,',
'       apex_page.get_url(',
'           p_page => 70,',
'           p_clear_cache => ''70'',',
'           p_items => ''P70_DUE_WEEK'',',
'           p_values => to_char(trunc(v.due_date, ''IW''), ''YYYY-MM-DD'')',
'       ) as link,',
'       trunc(v.due_date, ''IW'') as sort_date',
'  from tsk_v_task_list v',
'  join tsk_task_assignees ta',
'    on ta.task_id = v.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where nvl(v.is_done_yn, ''N'') = ''N''',
'   and v.due_date is not null',
'   and v.due_date >= trunc(sysdate)',
'   and (',
'           lower(u.username) = lower(:APP_USER)',
'        or lower(u.email) = lower(:APP_USER)',
'       )',
' group by trunc(v.due_date, ''IW'')',
' order by sort_date'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'LABEL'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(9990007000000404)
,p_chart_id=>wwv_flow_imp.id(9990007000000402)
,p_static_id=>'x'
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'off'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(9990007000000405)
,p_chart_id=>wwv_flow_imp.id(9990007000000402)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(17604158273145401)
,p_name=>'Recommended Work'
,p_static_id=>'recommended-work'
,p_template=>4073835273271169698
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>8
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select v.task_id,',
'       apex_page.get_url(',
'           p_page => 12,',
'           p_items => ''P12_TASK_ID'',',
'           p_values => v.task_id',
'       ) as task_url,',
'       v.task_key,',
'       v.title,',
'       v.priority_code,',
'       v.due_date,',
'       case',
'           when v.due_date < trunc(sysdate) then ''Overdue''',
'           when v.due_date = trunc(sysdate) then ''Due Today''',
'           when v.due_date <= trunc(sysdate) + 7 then ''Due This Week''',
'           else ''Upcoming''',
'       end as due_window,',
'       v.status_name,',
'       v.application_name,',
'       v.type_name,',
'       v.percent_complete,',
'       (',
'           select count(*)',
'             from tsk_task_updates tu',
'            where tu.task_id = v.task_id',
'       ) as update_count,',
'       (',
'           select listagg(tg.topic_name, '', '') within group (order by tg.topic_name)',
'             from tsk_task_topic_groups ttg',
'             join tsk_topic_groups tg',
'               on tg.topic_group_id = ttg.topic_group_id',
'            where ttg.task_id = v.task_id',
'       ) as topic_groups,',
'       cast(v.updated_at as date) as last_updated',
'  from tsk_v_task_list v',
'  join tsk_task_assignees ta',
'    on ta.task_id = v.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where (',
'           lower(u.username) = lower(:APP_USER)',
'        or lower(u.email) = lower(:APP_USER)',
'       )',
'   and (:P70_STATUS is null or v.status_name = :P70_STATUS)',
'   and (:P70_PRIORITY is null or v.priority_code = :P70_PRIORITY)',
'   and (:P70_OVERDUE is null or v.overdue_yn = :P70_OVERDUE)',
'   and (',
'           :P70_DUE_WEEK is null',
'        or (',
'            v.due_date >= trunc(sysdate)',
'            and v.due_date >= to_date(',
'                case',
'                    when regexp_like(:P70_DUE_WEEK, ''^\d{4}-\d{2}-\d{2}$'') then :P70_DUE_WEEK',
'                end,',
'                ''YYYY-MM-DD''',
'            )',
'            and v.due_date < to_date(',
'                case',
'                    when regexp_like(:P70_DUE_WEEK, ''^\d{4}-\d{2}-\d{2}$'') then :P70_DUE_WEEK',
'                end,',
'                ''YYYY-MM-DD''',
'            ) + 7)',
'       )',
'   and (',
'           :P70_SCOPE = ''ALL''',
'        or :P70_STATUS is not null',
'        or nvl(v.is_done_yn, ''N'') = ''N''',
'       )',
' order by v.updated_at desc nulls last,',
'          v.task_key'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>20
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No open assigned tasks found.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17605045837145401)
,p_query_column_id=>9
,p_column_alias=>'APPLICATION_NAME'
,p_column_display_sequence=>70
,p_column_heading=>'Application'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604710148145401)
,p_query_column_id=>6
,p_column_alias=>'DUE_DATE'
,p_column_display_sequence=>40
,p_column_heading=>'Due Date'
,p_column_format=>'DD-MON-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604863431145401)
,p_query_column_id=>7
,p_column_alias=>'DUE_WINDOW'
,p_column_display_sequence=>50
,p_column_heading=>'Due Window'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990007000000103)
,p_query_column_id=>14
,p_column_alias=>'LAST_UPDATED'
,p_column_display_sequence=>45
,p_column_heading=>'Last Updated'
,p_column_format=>'DD-MON-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17605286519145402)
,p_query_column_id=>11
,p_column_alias=>'PERCENT_COMPLETE'
,p_column_display_sequence=>90
,p_column_heading=>'Complete %'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604682780145401)
,p_query_column_id=>5
,p_column_alias=>'PRIORITY_CODE'
,p_column_display_sequence=>30
,p_column_heading=>'Priority'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604957357145401)
,p_query_column_id=>8
,p_column_alias=>'STATUS_NAME'
,p_column_display_sequence=>60
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604242641145401)
,p_query_column_id=>1
,p_column_alias=>'TASK_ID'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604414964145401)
,p_query_column_id=>3
,p_column_alias=>'TASK_KEY'
,p_column_display_sequence=>10
,p_column_heading=>'Task'
,p_column_html_expression=>'<a href="#TASK_URL#">#TASK_KEY#</a>'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604380087145401)
,p_query_column_id=>2
,p_column_alias=>'TASK_URL'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17604582030145401)
,p_query_column_id=>4
,p_column_alias=>'TITLE'
,p_column_display_sequence=>20
,p_column_heading=>'Title'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990007000000101)
,p_query_column_id=>13
,p_column_alias=>'TOPIC_GROUPS'
,p_column_display_sequence=>85
,p_column_heading=>'Topic Groups'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17605193997145402)
,p_query_column_id=>10
,p_column_alias=>'TYPE_NAME'
,p_column_display_sequence=>80
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990007000000102)
,p_query_column_id=>12
,p_column_alias=>'UPDATE_COUNT'
,p_column_display_sequence=>95
,p_column_heading=>'Updates'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17602220355145399)
,p_plug_name=>'Team Member Dashboard Title'
,p_static_id=>'team-member-dashboard-title'
,p_title=>'&P70_PAGE_TITLE.'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(9990007000000201)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(17604158273145401)
,p_button_name=>'CREATE_TASK'
,p_static_id=>'create-task'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create Task'
,p_button_position=>'EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:11:&SESSION.::&DEBUG.:11::'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9990007000000406)
,p_name=>'P70_DUE_WEEK'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(17602220355145399)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17615235004259490)
,p_name=>'P70_OVERDUE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(17602220355145399)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17611867204237496)
,p_name=>'P70_PAGE_TITLE'
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(17602220355145399)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17608676601199511)
,p_name=>'P70_PRIORITY'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(17602220355145399)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17615111521259489)
,p_name=>'P70_SCOPE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(17602220355145399)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17608523803199511)
,p_name=>'P70_STATUS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(17602220355145399)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17611958954237496)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Page Title'
,p_static_id=>'set-page-title'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select u.display_name || ''''''s Tasks''',
'      into :P70_PAGE_TITLE',
'      from tsk_users u',
'     where u.active_yn = ''Y''',
'       and (',
'               lower(u.username) = lower(:APP_USER)',
'            or lower(u.email) = lower(:APP_USER)',
'           )',
'     fetch first 1 row only;',
'exception',
'    when no_data_found then',
'        :P70_PAGE_TITLE := :APP_USER || ''''''s Tasks'';',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>17611958954237496
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
