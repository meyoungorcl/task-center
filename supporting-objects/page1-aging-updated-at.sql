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
,p_default_id_offset=>0
,p_default_owner=>'WKSP_DBAPPDEV'
);
end;
/
 
prompt APPLICATION 12892 - Task Center
--
-- Application Export:
--   Application:     12892
--   Name:            Task Center
--   Date and Time:   22:37 Tuesday June 2, 2026
--   Exported By:     WKSP_DBAPPDEV
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 1
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     746020101855378
--

begin
null;
end;
/
prompt --application/pages/delete_00001
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>1);
end;
/
prompt --application/pages/page_00001
begin
wwv_flow_imp_page.create_page(
 p_id=>1
,p_name=>'Dashboard'
,p_alias=>'HOME'
,p_step_title=>'Dashboard'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'13'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(16551867018817547)
,p_plug_name=>'Dashboard'
,p_static_id=>'dashboard-title'
,p_title=>'Task Center Dashboard'
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17104470511658143)
,p_plug_name=>'Task Aging'
,p_static_id=>'task-aging'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>80
,p_plug_grid_column_span=>6
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(17104558706658143)
,p_region_id=>wwv_flow_imp.id(17104470511658143)
,p_chart_type=>'bar'
,p_title=>'Not Started / In Progress Task Aging by User'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17104713207658144)
,p_chart_id=>wwv_flow_imp.id(17104558706658143)
,p_static_id=>'one-to-three-months'
,p_seq=>20
,p_name=>'1-3 Months'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as label,',
'       count(*) as value,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_AGING'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',1-3 Months''',
'       ) as link',
'  from tsk_tasks t',
'  left join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code in (''NOT_STARTED'', ''IN_PROGRESS'')',
'   and t.updated_at < add_months(systimestamp, -1)',
'   and t.updated_at >= add_months(systimestamp, -3)',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17104842408658144)
,p_chart_id=>wwv_flow_imp.id(17104558706658143)
,p_static_id=>'over-three-months'
,p_seq=>30
,p_name=>'Over 3 Months'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as label,',
'       count(*) as value,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_AGING'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',Over 3 Months''',
'       ) as link',
'  from tsk_tasks t',
'  left join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code in (''NOT_STARTED'', ''IN_PROGRESS'')',
'   and t.updated_at < add_months(systimestamp, -3)',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17104627327658143)
,p_chart_id=>wwv_flow_imp.id(17104558706658143)
,p_static_id=>'under-one-month'
,p_seq=>10
,p_name=>'Last 1 Month'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as label,',
'       count(*) as value,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_AGING'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',Last 1 Month''',
'       ) as link',
'  from tsk_tasks t',
'  left join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code in (''NOT_STARTED'', ''IN_PROGRESS'')',
'   and t.updated_at >= add_months(systimestamp, -1)',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(17104961736658144)
,p_chart_id=>wwv_flow_imp.id(17104558706658143)
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
 p_id=>wwv_flow_imp.id(17105024156658144)
,p_chart_id=>wwv_flow_imp.id(17104558706658143)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(16551901283817547)
,p_name=>'Task Overview'
,p_static_id=>'task-overview'
,p_template=>4073835273271169698
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--inline:t-Report--stretch'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null as card_layout,',
'       count(*) as total_tasks,',
'       sum(case when status_code = ''IN_PROGRESS'' then 1 else 0 end) as in_progress_tasks,',
'       sum(case when status_code = ''COMPLETED'' then 1 else 0 end) as completed_tasks,',
'       sum(case when overdue_yn = ''Y'' then 1 else 0 end) as overdue_tasks,',
'       sum(case when status_code = ''NOT_STARTED'' then 1 else 0 end) as not_started_tasks,',
'       sum(case when status_code = ''IN_REVIEW'' then 1 else 0 end) as in_review_tasks,',
'       sum(case when status_code = ''BLOCKED'' then 1 else 0 end) as blocked_tasks,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'') as total_tasks_url,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_STATUS'', p_values => ''In Progress'') as in_progress_tasks_url,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_STATUS'', p_values => ''Completed'') as completed_tasks_url,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_OVERDUE'', p_values => ''Y'') as overdue_tasks_url,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_STATUS'', p_values => ''Not Started'') as not_started_tasks_url,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_STATUS'', p_values => ''In Review'') as in_review_tasks_url,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_STATUS'', p_values => ''Blocked'') as blocked_tasks_url,',
'       sum(case when status_code = ''BACKLOG'' then 1 else 0 end) as backlog_tasks,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_STATUS'', p_values => ''Backlog'') as backlog_tasks_url,',
'       sum(case when status_code = ''ARCHIVE'' then 1 else 0 end) as archive_tasks,',
'       apex_page.get_url(p_page => 10, p_clear_cache => ''10'', p_items => ''P10_STATUS'', p_values => ''Archive'') as archive_tasks_url',
'  from tsk_v_task_list'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No task overview data found.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990000100000101)
,p_query_column_id=>18
,p_column_alias=>'ARCHIVE_TASKS'
,p_column_display_sequence=>180
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990000100000102)
,p_query_column_id=>19
,p_column_alias=>'ARCHIVE_TASKS_URL'
,p_column_display_sequence=>190
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17031939723015386)
,p_query_column_id=>16
,p_column_alias=>'BACKLOG_TASKS'
,p_column_display_sequence=>160
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17032071512015386)
,p_query_column_id=>17
,p_column_alias=>'BACKLOG_TASKS_URL'
,p_column_display_sequence=>170
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16560927559908525)
,p_query_column_id=>8
,p_column_alias=>'BLOCKED_TASKS'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16912133344239599)
,p_query_column_id=>15
,p_column_alias=>'BLOCKED_TASKS_URL'
,p_column_display_sequence=>150
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16897637997186397)
,p_query_column_id=>1
,p_column_alias=>'CARD_LAYOUT'
,p_column_display_sequence=>10
,p_column_heading=>' '
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(160px,1fr));gap:12px">',
'  <a href="#TOTAL_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-clipboard-list u-info-text"></span> <b style="font-size:1.7rem">#TOTAL_TASKS#'
||'</b><br>Total Tasks</a>',
'  <a href="#IN_PROGRESS_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-refresh" style="color:#2563eb" aria-hidden="true"></span> <b style="fon'
||'t-size:1.7rem">#IN_PROGRESS_TASKS#</b><br>In Progress</a>',
'  <a href="#BACKLOG_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-list-ul u-info-text"></span> <b style="font-size:1.7rem">#BACKLOG_TASKS#</b'
||'><br>Backlog</a>',
'  <a href="#COMPLETED_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-check-circle u-success-text"></span> <b style="font-size:1.7rem">#COMPLET'
||'ED_TASKS#</b><br>Completed</a>',
'  <a href="#OVERDUE_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-exclamation-circle u-danger-text"></span> <b style="font-size:1.7rem">#OVER'
||'DUE_TASKS#</b><br>Overdue</a>',
'  <a href="#NOT_STARTED_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-hourglass-start" style="color:#f5b400" aria-hidden="true"></span> <b st'
||'yle="font-size:1.7rem">#NOT_STARTED_TASKS#</b><br>Not Started</a>',
'  <a href="#IN_REVIEW_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-search u-warning-text"></span> <b style="font-size:1.7rem">#IN_REVIEW_TAS'
||'KS#</b><br>In Review</a>',
'  <a href="#BLOCKED_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-ban u-warning-text"></span> <b style="font-size:1.7rem">#BLOCKED_TASKS#</b>'
||'<br>Blocked</a>',
'  <a href="#ARCHIVE_TASKS_URL#" style="padding:16px;border:1px solid var(--ut-component-border-color);border-radius:8px;text-decoration:none;color:inherit"><span class="fa fa-archive" style="color:#64748b" aria-hidden="true"></span> <b style="font-si'
||'ze:1.7rem">#ARCHIVE_TASKS#</b><br>Archive</a>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16560517090908525)
,p_query_column_id=>4
,p_column_alias=>'COMPLETED_TASKS'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16911746220239599)
,p_query_column_id=>11
,p_column_alias=>'COMPLETED_TASKS_URL'
,p_column_display_sequence=>110
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16560420371908525)
,p_query_column_id=>3
,p_column_alias=>'IN_PROGRESS_TASKS'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16911683569239599)
,p_query_column_id=>10
,p_column_alias=>'IN_PROGRESS_TASKS_URL'
,p_column_display_sequence=>100
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16560875492908525)
,p_query_column_id=>7
,p_column_alias=>'IN_REVIEW_TASKS'
,p_column_display_sequence=>70
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16912070710239599)
,p_query_column_id=>14
,p_column_alias=>'IN_REVIEW_TASKS_URL'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16560784242908525)
,p_query_column_id=>6
,p_column_alias=>'NOT_STARTED_TASKS'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16911944720239599)
,p_query_column_id=>13
,p_column_alias=>'NOT_STARTED_TASKS_URL'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16560691052908525)
,p_query_column_id=>5
,p_column_alias=>'OVERDUE_TASKS'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16911886972239599)
,p_query_column_id=>12
,p_column_alias=>'OVERDUE_TASKS_URL'
,p_column_display_sequence=>120
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16560312159908524)
,p_query_column_id=>2
,p_column_alias=>'TOTAL_TASKS'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16911580143239599)
,p_query_column_id=>9
,p_column_alias=>'TOTAL_TASKS_URL'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(16554661107817552)
,p_plug_name=>'Tasks by Application'
,p_static_id=>'tasks-by-application'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>6
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(16554705376817552)
,p_region_id=>wwv_flow_imp.id(16554661107817552)
,p_chart_type=>'bar'
,p_title=>'Tasks by Application'
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
 p_id=>wwv_flow_imp.id(16554851967817553)
,p_chart_id=>wwv_flow_imp.id(16554705376817552)
,p_static_id=>'tasks-by-application'
,p_seq=>10
,p_name=>'Tasks by Application'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select application_name as LABEL,',
'       sum(task_count) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_APPLICATION'',',
'           p_values => application_name',
'       ) as LINK',
'  from tsk_v_tasks_by_application',
' group by application_name',
' order by sum(task_count) desc, application_name'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(16554900064817553)
,p_chart_id=>wwv_flow_imp.id(16554705376817552)
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
 p_id=>wwv_flow_imp.id(16555030813817553)
,p_chart_id=>wwv_flow_imp.id(16554705376817552)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(16552211414817547)
,p_plug_name=>'Tasks by Status'
,p_static_id=>'tasks-by-status'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>30
,p_plug_grid_column_span=>6
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(16552392990817548)
,p_region_id=>wwv_flow_imp.id(16552211414817547)
,p_chart_type=>'donut'
,p_title=>'Tasks by Status'
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
 p_id=>wwv_flow_imp.id(16552454634817548)
,p_chart_id=>wwv_flow_imp.id(16552392990817548)
,p_static_id=>'tasks-by-status'
,p_seq=>10
,p_name=>'Tasks by Status'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select status_name as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_STATUS'',',
'           p_values => status_name',
'       ) as LINK',
'  from tsk_v_task_list',
' group by status_name',
' order by status_name'))
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
 p_id=>wwv_flow_imp.id(16552550375817550)
,p_plug_name=>'Tasks by Type'
,p_static_id=>'tasks-by-type'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>6
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(16552620398817550)
,p_region_id=>wwv_flow_imp.id(16552550375817550)
,p_chart_type=>'donut'
,p_title=>'Tasks by Type'
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
 p_id=>wwv_flow_imp.id(16552715868817550)
,p_chart_id=>wwv_flow_imp.id(16552620398817550)
,p_static_id=>'tasks-by-type'
,p_seq=>10
,p_name=>'Tasks by Type'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select type_name as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TYPE'',',
'           p_values => type_name',
'       ) as LINK',
'  from tsk_v_task_list',
' group by type_name',
' order by type_name'))
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
 p_id=>wwv_flow_imp.id(17365652674602248)
,p_plug_name=>'Tasks by Priority by User'
,p_static_id=>'tasks-priority-by-user'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>6
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(17365783319602248)
,p_region_id=>wwv_flow_imp.id(17365652674602248)
,p_chart_type=>'bar'
,p_title=>'Tasks by Priority by User'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17365857874602248)
,p_chart_id=>wwv_flow_imp.id(17365783319602248)
,p_static_id=>'priority-critical'
,p_seq=>10
,p_name=>'Critical'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.display_name as label,',
'       count(distinct t.task_id) as value,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_PRIORITY'',',
'           p_values => u.display_name || '',CRITICAL''',
'       ) as link',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'   and nvl(s.is_done_yn, ''N'') = ''N''',
'  join tsk_task_assignees ta',
'    on ta.task_id = t.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where t.priority_code = ''CRITICAL''',
' group by u.display_name',
' order by u.display_name'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17365912614602248)
,p_chart_id=>wwv_flow_imp.id(17365783319602248)
,p_static_id=>'priority-high'
,p_seq=>20
,p_name=>'High'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.display_name as label,',
'       count(distinct t.task_id) as value,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_PRIORITY'',',
'           p_values => u.display_name || '',HIGH''',
'       ) as link',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'   and nvl(s.is_done_yn, ''N'') = ''N''',
'  join tsk_task_assignees ta',
'    on ta.task_id = t.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where t.priority_code = ''HIGH''',
' group by u.display_name',
' order by u.display_name'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17366180449602248)
,p_chart_id=>wwv_flow_imp.id(17365783319602248)
,p_static_id=>'priority-low'
,p_seq=>40
,p_name=>'Low'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.display_name as label,',
'       count(distinct t.task_id) as value,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_PRIORITY'',',
'           p_values => u.display_name || '',LOW''',
'       ) as link',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'   and nvl(s.is_done_yn, ''N'') = ''N''',
'  join tsk_task_assignees ta',
'    on ta.task_id = t.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where t.priority_code = ''LOW''',
' group by u.display_name',
' order by u.display_name'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17366080936602248)
,p_chart_id=>wwv_flow_imp.id(17365783319602248)
,p_static_id=>'priority-medium'
,p_seq=>30
,p_name=>'Medium'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.display_name as label,',
'       count(distinct t.task_id) as value,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_PRIORITY'',',
'           p_values => u.display_name || '',MEDIUM''',
'       ) as link',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'   and nvl(s.is_done_yn, ''N'') = ''N''',
'  join tsk_task_assignees ta',
'    on ta.task_id = t.task_id',
'   and ta.active_yn = ''Y''',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'   and tm.active_yn = ''Y''',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
'   and u.active_yn = ''Y''',
' where t.priority_code = ''MEDIUM''',
' group by u.display_name',
' order by u.display_name'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(17366228314602248)
,p_chart_id=>wwv_flow_imp.id(17365783319602248)
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
 p_id=>wwv_flow_imp.id(17366345391602248)
,p_chart_id=>wwv_flow_imp.id(17365783319602248)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(16564476632998657)
,p_plug_name=>'Team Member by Status'
,p_static_id=>'team-member-by-status'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>60
,p_plug_grid_column_span=>6
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(16564528615998657)
,p_region_id=>wwv_flow_imp.id(16564476632998657)
,p_chart_type=>'bar'
,p_title=>'Team Member by Status'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'horizontal'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(17032162830015387)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
,p_static_id=>'backlog'
,p_seq=>5
,p_name=>'Backlog'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_STATUS'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',Backlog''',
'       ) as LINK',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code = ''BACKLOG''',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(16564925248998657)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
,p_static_id=>'blocked'
,p_seq=>40
,p_name=>'Blocked'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_STATUS'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',Blocked''',
'       ) as LINK',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code = ''BLOCKED''',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(16565091350998658)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
,p_static_id=>'completed'
,p_seq=>50
,p_name=>'Completed'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_STATUS'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',Completed''',
'       ) as LINK',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code = ''COMPLETED''',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(16564772569998657)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
,p_static_id=>'in-progress'
,p_seq=>20
,p_name=>'In Progress'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_STATUS'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',In Progress''',
'       ) as LINK',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code = ''IN_PROGRESS''',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(16564892153998657)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
,p_static_id=>'in-review'
,p_seq=>30
,p_name=>'In Review'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_STATUS'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',In Review''',
'       ) as LINK',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code = ''IN_REVIEW''',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(16564607345998657)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
,p_static_id=>'not-started'
,p_seq=>10
,p_name=>'Not Started'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select nvl(u.display_name, ''Unassigned'') as LABEL,',
'       count(*) as VALUE,',
'       apex_page.get_url(',
'           p_page => 10,',
'           p_clear_cache => ''10'',',
'           p_items => ''P10_TEAM_MEMBER,P10_STATUS'',',
'           p_values => nvl(u.display_name, ''Unassigned'') || '',Not Started''',
'       ) as LINK',
'  from tsk_tasks t',
'  join tsk_statuses s',
'    on s.status_id = t.status_id',
'  left join tsk_team_members tm',
'    on tm.team_member_id = t.owner_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where s.status_code = ''NOT_STARTED''',
' group by nvl(u.display_name, ''Unassigned'')',
' order by nvl(u.display_name, ''Unassigned'')'))
,p_series_type=>'bar'
,p_items_value_column_name=>'VALUE'
,p_items_label_column_name=>'LABEL'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
,p_link_target=>'&LINK.'
,p_link_target_type=>'REDIRECT_URL'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(16565132751998658)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
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
 p_id=>wwv_flow_imp.id(16565297198998658)
,p_chart_id=>wwv_flow_imp.id(16564528615998657)
,p_static_id=>'y'
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(16552816998817550)
,p_name=>'Upcoming Due Dates'
,p_static_id=>'upcoming-due-dates'
,p_template=>4073835273271169698
,p_display_sequence=>50
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select task_id,',
'       due_date,',
'       task_key,',
'       title,',
'       status_name,',
'       priority_code,',
'       team_name,',
'       application_name,',
'       assignees,',
'       apex_page.get_url(',
'           p_page => 12,',
'           p_items => ''P12_TASK_ID'',',
'           p_values => task_id',
'       ) as task_url',
'  from tsk_v_task_list',
' where due_date is not null',
'   and due_date >= trunc(sysdate)',
'   and nvl(is_done_yn, ''N'') = ''N''',
' order by due_date, priority_code desc, task_key',
' fetch first 15 rows only'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No upcoming due dates.'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16553561791817550)
,p_query_column_id=>7
,p_column_alias=>'APPLICATION_NAME'
,p_column_display_sequence=>70
,p_column_heading=>'Application'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16553602634817550)
,p_query_column_id=>8
,p_column_alias=>'ASSIGNEES'
,p_column_display_sequence=>80
,p_column_heading=>'Assignees'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16552914391817550)
,p_query_column_id=>1
,p_column_alias=>'DUE_DATE'
,p_column_display_sequence=>10
,p_column_heading=>'Due Date'
,p_column_format=>'DD-MON-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16553363734817550)
,p_query_column_id=>5
,p_column_alias=>'PRIORITY_CODE'
,p_column_display_sequence=>50
,p_column_heading=>'Priority'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16553231862817550)
,p_query_column_id=>4
,p_column_alias=>'STATUS_NAME'
,p_column_display_sequence=>40
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17083463659456184)
,p_query_column_id=>10
,p_column_alias=>'TASK_ID'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16553068338817550)
,p_query_column_id=>2
,p_column_alias=>'TASK_KEY'
,p_column_display_sequence=>20
,p_column_heading=>'Task'
,p_column_html_expression=>'<a href="#TASK_URL#">#TASK_KEY#</a>'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17067785291327663)
,p_query_column_id=>9
,p_column_alias=>'TASK_URL'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16553475010817550)
,p_query_column_id=>6
,p_column_alias=>'TEAM_NAME'
,p_column_display_sequence=>60
,p_column_heading=>'Team'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16553174157817550)
,p_query_column_id=>3
,p_column_alias=>'TITLE'
,p_column_display_sequence=>30
,p_column_heading=>'Title'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
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
