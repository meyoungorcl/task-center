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
--   Date and Time:   22:43 Tuesday June 2, 2026
--   Exported By:     WKSP_DBAPPDEV
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 10
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     746020101855378
--

begin
null;
end;
/
prompt --application/pages/delete_00010
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10);
end;
/
prompt --application/pages/page_00010
begin
wwv_flow_imp_page.create_page(
 p_id=>10
,p_name=>'Tasks'
,p_alias=>'TASKS'
,p_step_title=>'Tasks'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'22'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(16570805728055037)
,p_plug_name=>'Filters'
,p_static_id=>'task-filters'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>3
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_plug_source_type=>'NATIVE_FACETED_SEARCH'
,p_filtered_region_id=>wwv_flow_imp.id(16446023522744663)
,p_landmark_label=>'Filters'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'batch_facet_search', 'N',
  'compact_numbers_threshold', '10000',
  'current_facets_selector', '#active_facets',
  'display_chart_for_top_n_values', '10',
  'show_charts', 'Y',
  'show_current_facets', 'E',
  'show_total_row_count', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17097769352590544)
,p_name=>'P10_AGING'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Aging'
,p_source=>'AGING_BUCKET'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16571209336055037)
,p_name=>'P10_APPLICATION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Application'
,p_source=>'APPLICATION_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>10
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(4200001000000101)
,p_name=>'P10_LAST_UPDATED'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>75
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Last Updated'
,p_source=>'LAST_UPDATED_FACET'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC2:Last Day;Last Day,Last Week;Last Week,Last Month;Last Month'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>false
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
,p_multi_value_trim_space=>false
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16912672987239604)
,p_name=>'P10_MY_TASKS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>15
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'My Tasks'
,p_source=>'MY_TASKS_YN'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:My Tasks;Y'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16912753305239605)
,p_name=>'P10_OVERDUE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Overdue'
,p_source=>'OVERDUE_YN'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov=>'STATIC:Overdue;Y'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16571493368055038)
,p_name=>'P10_PRIORITY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Priority'
,p_source=>'PRIORITY_CODE'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16570901484055037)
,p_name=>'P10_SEARCH'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Search'
,p_source=>'TASK_KEY,TITLE,TEAM_NAME,TEAM_MEMBER,TYPE_NAME,APPLICATION_NAME,STATUS_NAME,PRIORITY_CODE,ASSIGNEES,TOPIC_GROUPS'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_SEARCH'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'input_field', 'FACET',
  'search_type', 'ROW')).to_clob
,p_fc_show_chart=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16571364816055038)
,p_name=>'P10_STATUS'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Status'
,p_source=>'STATUS_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16571001972055037)
,p_name=>'P10_TEAM_MEMBER'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Assignee'
,p_source=>'ASSIGNEE_FACET'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>10
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
,p_multi_value_trim_space=>false
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9990001000000101)
,p_name=>'P10_TOPIC_GROUP'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>35
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Topic Group'
,p_source=>'TOPIC_GROUP_FACET'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>10
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
,p_multi_value_trim_space=>false
,p_fc_filter_combination=>'OR'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16571154131055037)
,p_name=>'P10_TYPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(16570805728055037)
,p_prompt=>'Type'
,p_source=>'TYPE_NAME'
,p_source_type=>'FACET_COLUMN'
,p_display_as=>'NATIVE_CHECKBOX'
,p_lov_sort_direction=>'ASC'
,p_fc_show_label=>true
,p_fc_collapsible=>false
,p_fc_compute_counts=>true
,p_fc_show_counts=>true
,p_fc_zero_count_entries=>'H'
,p_fc_show_more_count=>10
,p_fc_filter_values=>false
,p_fc_sort_by_top_counts=>true
,p_fc_show_selected_first=>false
,p_fc_show_chart=>true
,p_fc_initial_chart=>false
,p_fc_actions_filter=>true
,p_fc_display_as=>'INLINE'
,p_fc_exclude_allowed=>false
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(16446023522744663)
,p_name=>'Tasks'
,p_static_id=>'tasks'
,p_template=>4073835273271169698
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--stretch:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_grid_column_span=>9
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
'       v.team_name,',
'       nvl(owner_u.display_name, ''Unassigned'') as team_member,',
'       v.title,',
'       v.type_name,',
'       v.application_name,',
'       v.complexity_name,',
'       v.status_name,',
'       v.priority_code,',
'       v.due_date,',
'       v.percent_complete,',
'       case',
'           when st.status_code in (''NOT_STARTED'', ''IN_PROGRESS'')',
'                and t.updated_at >= add_months(systimestamp, -1)',
'           then ''Last 1 Month''',
'           when st.status_code in (''NOT_STARTED'', ''IN_PROGRESS'')',
'                and t.updated_at < add_months(systimestamp, -1)',
'                and t.updated_at >= add_months(systimestamp, -3)',
'           then ''1-3 Months''',
'           when st.status_code in (''NOT_STARTED'', ''IN_PROGRESS'')',
'                and t.updated_at < add_months(systimestamp, -3)',
'           then ''Over 3 Months''',
'       end as aging_bucket,',
'       (',
'           select count(*)',
'             from tsk_task_updates tu',
'            where tu.task_id = v.task_id',
'       ) as update_count,',
'       v.assignees,',
'       (',
'           select listagg(display_name, '':'') within group (order by display_name)',
'             from (',
'                      select u.display_name',
'                        from tsk_task_assignees ta',
'                        join tsk_team_members tm',
'                          on tm.team_member_id = ta.team_member_id',
'                        join tsk_users u',
'                          on u.user_id = tm.user_id',
'                       where ta.task_id = v.task_id',
'                         and ta.active_yn = ''Y''',
'                         and tm.active_yn = ''Y''',
'                         and u.active_yn = ''Y''',
'                       group by u.display_name',
'                  )',
'       ) as assignee_facet,',
'       v.overdue_yn,',
'       case',
'           when exists (',
'               select 1',
'                 from tsk_task_assignees my_ta',
'                 join tsk_team_members my_tm',
'                   on my_tm.team_member_id = my_ta.team_member_id',
'                 join tsk_users my_u',
'                   on my_u.user_id = my_tm.user_id',
'                where my_ta.task_id = v.task_id',
'                  and my_ta.active_yn = ''Y''',
'                  and my_tm.active_yn = ''Y''',
'                  and (',
'                      lower(my_u.email) = lower(:APP_USER)',
'                      or lower(my_u.username) = lower(:APP_USER)',
'                  )',
'           )',
'           then ''Y''',
'           else ''N''',
'       end as my_tasks_yn,',
'       (',
'           select listagg(tg.topic_name, '', '') within group (order by tg.topic_name)',
'             from tsk_task_topic_groups ttg',
'             join tsk_topic_groups tg',
'               on tg.topic_group_id = ttg.topic_group_id',
'            where ttg.task_id = v.task_id',
'       ) as topic_groups,',
'       (',
'           select listagg(topic_name, '':'') within group (order by topic_name)',
'             from (',
'                      select tg.topic_name',
'                        from tsk_task_topic_groups ttg',
'                        join tsk_topic_groups tg',
'                          on tg.topic_group_id = ttg.topic_group_id',
'                       where ttg.task_id = v.task_id',
'                       group by tg.topic_name',
'                  )',
'       ) as topic_group_facet,',
'       cast(v.updated_at as date) as last_updated,',
'       case',
'           when cast(v.updated_at as date) >= sysdate - 1',
'           then ''Last Day:Last Week:Last Month''',
'           when cast(v.updated_at as date) >= sysdate - 7',
'           then ''Last Week:Last Month''',
'           when cast(v.updated_at as date) >= add_months(sysdate, -1)',
'           then ''Last Month''',
'       end as last_updated_facet',
'  from tsk_v_task_list v',
'  left join tsk_tasks t',
'    on t.task_id = v.task_id',
'  left join tsk_statuses st',
'    on st.status_id = t.status_id',
'  left join tsk_team_members owner_tm',
'    on owner_tm.team_member_id = t.owner_member_id',
'  left join tsk_users owner_u',
'    on owner_u.user_id = owner_tm.user_id',
' order by v.updated_at desc nulls last, v.task_key'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>20
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No tasks found.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17097628206590542)
,p_query_column_id=>18
,p_column_alias=>'AGING_BUCKET'
,p_column_display_sequence=>125
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570055650055036)
,p_query_column_id=>8
,p_column_alias=>'APPLICATION_NAME'
,p_column_display_sequence=>60
,p_column_heading=>'Application'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570687681055037)
,p_query_column_id=>14
,p_column_alias=>'ASSIGNEES'
,p_column_display_sequence=>35
,p_column_heading=>'Assignees'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17127932771796776)
,p_query_column_id=>19
,p_column_alias=>'ASSIGNEE_FACET'
,p_column_display_sequence=>36
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570152920055036)
,p_query_column_id=>9
,p_column_alias=>'COMPLEXITY_NAME'
,p_column_display_sequence=>70
,p_column_heading=>'Complexity'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570424857055037)
,p_query_column_id=>12
,p_column_alias=>'DUE_DATE'
,p_column_display_sequence=>15
,p_column_heading=>'Due Date'
,p_column_format=>'DD-MON-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4200001000000201)
,p_query_column_id=>22
,p_column_alias=>'LAST_UPDATED'
,p_column_display_sequence=>25
,p_column_heading=>'Last Updated'
,p_column_format=>'DD-MON-YYYY'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(4200001000000202)
,p_query_column_id=>23
,p_column_alias=>'LAST_UPDATED_FACET'
,p_column_display_sequence=>145
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16912535248239604)
,p_query_column_id=>16
,p_column_alias=>'MY_TASKS_YN'
,p_column_display_sequence=>140
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570749826055037)
,p_query_column_id=>15
,p_column_alias=>'OVERDUE_YN'
,p_column_display_sequence=>130
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570527041055037)
,p_query_column_id=>13
,p_column_alias=>'PERCENT_COMPLETE'
,p_column_display_sequence=>110
,p_column_heading=>'Complete %'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570304716055036)
,p_query_column_id=>11
,p_column_alias=>'PRIORITY_CODE'
,p_column_display_sequence=>90
,p_column_heading=>'Priority'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16570225427055036)
,p_query_column_id=>10
,p_column_alias=>'STATUS_NAME'
,p_column_display_sequence=>80
,p_column_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16569357263055035)
,p_query_column_id=>1
,p_column_alias=>'TASK_ID'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16569508958055036)
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
 p_id=>wwv_flow_imp.id(16569453622055035)
,p_query_column_id=>2
,p_column_alias=>'TASK_URL'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16569709795055036)
,p_query_column_id=>5
,p_column_alias=>'TEAM_MEMBER'
,p_column_display_sequence=>150
,p_column_heading=>'Submitted by'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16569663919055036)
,p_query_column_id=>4
,p_column_alias=>'TEAM_NAME'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16569855645055036)
,p_query_column_id=>6
,p_column_alias=>'TITLE'
,p_column_display_sequence=>40
,p_column_heading=>'Title'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990001000000102)
,p_query_column_id=>20
,p_column_alias=>'TOPIC_GROUPS'
,p_column_display_sequence=>45
,p_column_heading=>'Topic Groups'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(9990001000000103)
,p_query_column_id=>21
,p_column_alias=>'TOPIC_GROUP_FACET'
,p_column_display_sequence=>46
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(16569998031055036)
,p_query_column_id=>7
,p_column_alias=>'TYPE_NAME'
,p_column_display_sequence=>50
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(17089851792515114)
,p_query_column_id=>17
,p_column_alias=>'UPDATE_COUNT'
,p_column_display_sequence=>120
,p_column_heading=>'Updates'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(17376456735658600)
,p_plug_name=>'Tasks Title'
,p_static_id=>'tasks-title'
,p_title=>'Tasks'
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
 p_id=>wwv_flow_imp.id(16505127581047759)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(16446023522744663)
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
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(16505222581047759)
,p_name=>'Refresh on Task Dialog Close'
,p_static_id=>'refresh-on-task-dialog-close'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(16446023522744663)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(16505343767047759)
,p_event_id=>wwv_flow_imp.id(16505222581047759)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-tasks'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(16446023522744663)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
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
