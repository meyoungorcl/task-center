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
--   Date and Time:   21:26 Tuesday June 2, 2026
--   Exported By:     WKSP_DBAPPDEV
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 11
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     746020101855378
--

begin
null;
end;
/
prompt --application/pages/delete_00011
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>11);
end;
/
prompt --application/pages/page_00011
begin
wwv_flow_imp_page.create_page(
 p_id=>11
,p_name=>'Task'
,p_alias=>'TASK'
,p_page_mode=>'MODAL'
,p_step_title=>'Task'
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
 p_id=>wwv_flow_imp.id(16506095381047760)
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
 p_id=>wwv_flow_imp.id(16506118818047760)
,p_plug_name=>'Task'
,p_static_id=>'task-form'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_TASKS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'i:u'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(16507525813047762)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(16506095381047760)
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
 p_id=>wwv_flow_imp.id(16507626179047762)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(16506095381047760)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create Task'
,p_button_position=>'NEXT'
,p_button_condition=>'P11_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(16507700142047762)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(16506095381047760)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Apply Changes'
,p_button_position=>'NEXT'
,p_button_condition=>'P11_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16507171511047761)
,p_name=>'P11_APPLICATION_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Application'
,p_source=>'APPLICATION_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select application_name as display_value,',
'       application_id as return_value',
'  from tsk_applications',
' where active_yn = ''Y''',
' order by application_name'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17119015588731543)
,p_name=>'P11_ASSIGNEES'
,p_item_sequence=>75
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Assignees'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_SELECT_MANY'
,p_placeholder=>'Not Assigned'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select u.display_name as display_value,',
'       tm.team_member_id as return_value',
'  from tsk_team_members tm',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
' where tm.active_yn = ''Y''',
'   and u.active_yn = ''Y''',
'   and (:P11_TEAM_ID is null or tm.team_id = :P11_TEAM_ID)',
' order by u.display_name'))
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
 p_id=>wwv_flow_imp.id(16507040036047761)
,p_name=>'P11_COMPLEXITY_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Complexity'
,p_source=>'COMPLEXITY_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select complexity_name as display_value,',
'       complexity_id as return_value',
'  from tsk_complexities',
' where active_yn = ''Y''',
' order by display_seq, complexity_name'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506583630047760)
,p_name=>'P11_DESCRIPTION'
,p_source_data_type=>'CLOB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Description'
,p_source=>'DESCRIPTION'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'N',
  'format', 'MARKDOWN')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506980891047761)
,p_name=>'P11_DUE_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Due Date'
,p_source=>'DUE_DATE'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16507327854047762)
,p_name=>'P11_ESTIMATED_HOURS'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Estimated Hours'
,p_source=>'ESTIMATED_HOURS'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>20
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16507406376047762)
,p_name=>'P11_EXTERNAL_REFERENCE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_source=>'EXTERNAL_REFERENCE'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16507268025047761)
,p_name=>'P11_OWNER_MEMBER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>115
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_source=>'OWNER_MEMBER_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17021178927843943)
,p_name=>'P11_PRIORITY_CODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Priority'
,p_source=>'PRIORITY_CODE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Low;LOW,Medium;MEDIUM,High;HIGH,Critical;CRITICAL'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506717731047761)
,p_name=>'P11_START_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Start Date'
,p_source=>'START_DATE'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'display_as', 'POPUP',
  'max_date', 'NONE',
  'min_date', 'NONE',
  'multiple_months', 'N',
  'show_time', 'N',
  'use_defaults', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506843763047761)
,p_name=>'P11_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Status'
,p_source=>'STATUS_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select status_name as display_value,',
'       status_id as return_value',
'  from tsk_statuses',
' where active_yn = ''Y''',
' order by display_seq, status_name'))
,p_lov_display_null=>'NO'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506252694047760)
,p_name=>'P11_TASK_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_source=>'TASK_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506330784047760)
,p_name=>'P11_TEAM_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_source=>'TEAM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506411207047760)
,p_name=>'P11_TITLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Title'
,p_source=>'TITLE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cMaxlength=>255
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
 p_id=>wwv_flow_imp.id(9990008000000101)
,p_name=>'P11_TOPIC_GROUP_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>118
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Topic Group'
,p_source=>'TOPIC_GROUP_ID'
,p_display_as=>'NATIVE_COMBOBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select topic_name as display_value,',
'       topic_group_id as return_value',
'  from tsk_topic_groups',
' where active_yn = ''Y''',
'    or topic_group_id = :P11_TOPIC_GROUP_ID',
' order by topic_name'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'- No topic -'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'infinite_scroll', 'Y',
  'manual_entries_item', 'P11_TOPIC_GROUP_MANUAL',
  'match_type', 'CONTAINS',
  'min_chars', '0',
  'use_cache', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9990001100001001)
,p_name=>'P11_TOPIC_GROUP_MANUAL'
,p_item_sequence=>119
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(16506675350047761)
,p_name=>'P11_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_item_source_plug_id=>wwv_flow_imp.id(16506118818047760)
,p_prompt=>'Task Type'
,p_source=>'TYPE_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select type_name as display_value,',
'       type_id as return_value',
'  from tsk_task_types',
' order by type_name'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(16507855412047762)
,p_name=>'Cancel Dialog'
,p_static_id=>'cancel-dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(16507525813047762)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(16507937285047762)
,p_event_id=>wwv_flow_imp.id(16507855412047762)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-dialog-cancel'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17119101707731545)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Assign and Email Assignees'
,p_static_id=>'assign-and-email-assignees'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_assignee_names varchar2(32767);',
'    l_task_url       varchar2(4000);',
'    l_email_count    pls_integer := 0;',
'begin',
'    if :P11_ASSIGNEES is null then',
'        return;',
'    end if;',
'',
'    l_task_url := apex_mail.get_instance_url ||',
'                  apex_page.get_url(',
'                      p_application => :APP_ID,',
'                      p_page        => 12,',
'                      p_session     => 0,',
'                      p_clear_cache => ''12'',',
'                      p_items       => ''P12_TASK_ID'',',
'                      p_values      => :P11_TASK_ID,',
'                      p_plain_url   => true',
'                  );',
'',
'    for m in (',
'        select distinct to_number(s.column_value) as team_member_id,',
'               u.display_name,',
'               u.email,',
'               tm.role_name',
'          from table(apex_string.split(:P11_ASSIGNEES, '':'')) s',
'          join tsk_team_members tm',
'            on tm.team_member_id = to_number(s.column_value)',
'          join tsk_users u',
'            on u.user_id = tm.user_id',
'         where regexp_like(s.column_value, ''^[0-9]+$'')',
'           and tm.active_yn = ''Y''',
'           and u.active_yn = ''Y''',
'    ) loop',
'        insert into tsk_task_assignees (',
'            task_id,',
'            team_member_id,',
'            assignment_role,',
'            allocated_pct',
'        )',
'        select :P11_TASK_ID,',
'               m.team_member_id,',
'               m.role_name,',
'               null',
'          from dual',
'         where not exists (',
'                 select 1',
'                   from tsk_task_assignees ta',
'                  where ta.task_id = :P11_TASK_ID',
'                    and ta.team_member_id = m.team_member_id',
'               );',
'',
'        l_assignee_names :=',
'            case',
'                when l_assignee_names is null then m.display_name',
'                else l_assignee_names || '', '' || m.display_name',
'            end;',
'',
'        if m.email is not null then',
'            apex_mail.send(',
'                p_to        => m.email,',
'                p_from      => ''no-reply@oracle.com'',',
'                p_subj      => ''Task assigned: '' || :P11_TITLE,',
'                p_body      => ''You have been assigned a task in Task Center.'' || chr(10) || chr(10) ||',
'                               ''Task: '' || :P11_TITLE || chr(10) ||',
'                               ''Due Date: '' || :P11_DUE_DATE || chr(10) ||',
'                               ''Open Task: '' || l_task_url,',
'                p_body_html => ''<p>You have been assigned a task in Task Center.</p>'' ||',
'                               ''<p><strong>Task:</strong> '' || apex_escape.html(:P11_TITLE) || ''<br>'' ||',
'                               ''<strong>Due Date:</strong> '' || apex_escape.html(:P11_DUE_DATE) || ''</p>'' ||',
'                               ''<p><a href="'' || apex_escape.html_attribute(l_task_url) || ''">Open Task</a></p>''',
'            );',
'',
'            l_email_count := l_email_count + 1;',
'        end if;',
'    end loop;',
'',
'    if l_assignee_names is not null then',
'        insert into tsk_change_log (',
'            entity_name,',
'            entity_pk,',
'            task_id,',
'            change_action,',
'            change_note,',
'            changed_by',
'        ) values (',
'            ''TASK'',',
'            :P11_TASK_ID,',
'            :P11_TASK_ID,',
'            ''ASSIGN'',',
'            ''Task assigned to: '' || l_assignee_names,',
'            :APP_USER',
'        );',
'    end if;',
'',
'    if l_email_count > 0 then',
'        apex_mail.push_queue;',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(16507626179047762)
,p_internal_uid=>17119101707731545
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(16508086056047762)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_static_id=>'close-dialog'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'show_success_messages', 'Y')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>16508086056047762
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17012946050782725)
,p_process_sequence=>20
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Default New Task Values'
,p_static_id=>'default-new-task-values'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P11_TEAM_ID is null then',
'        select team_id',
'          into :P11_TEAM_ID',
'          from tsk_teams',
'         where upper(team_name) = ''APPLICATION DEVELOPMENT''',
'           and active_yn = ''Y''',
'         fetch first 1 row only;',
'    end if;',
'',
'    if :P11_STATUS_ID is null then',
'        select status_id',
'          into :P11_STATUS_ID',
'          from tsk_statuses',
'         where status_code = ''NOT_STARTED''',
'           and active_yn = ''Y''',
'         fetch first 1 row only;',
'    end if;',
'',
'    if :P11_OWNER_MEMBER_ID is null then',
'        select min(tm.team_member_id)',
'          into :P11_OWNER_MEMBER_ID',
'          from tsk_team_members tm',
'          join tsk_users u',
'            on u.user_id = tm.user_id',
'          join tsk_teams t',
'            on t.team_id = tm.team_id',
'         where tm.active_yn = ''Y''',
'           and u.active_yn = ''Y''',
'           and t.active_yn = ''Y''',
'           and (',
'               lower(u.username) = lower(:APP_USER)',
'               or lower(u.email) = lower(:APP_USER)',
'           );',
'    end if;',
'exception',
'    when no_data_found then',
'        null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'P11_TASK_ID'
,p_process_when_type=>'ITEM_IS_NULL'
,p_internal_uid=>17012946050782725
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(16508110050047762)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(16506118818047760)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Task'
,p_static_id=>'initialize-form-task-form'
,p_internal_uid=>16508110050047762
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9990001100001002)
,p_process_sequence=>5
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Manual Topic'
,p_static_id=>'create-manual-topic'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_topic_name tsk_topic_groups.topic_name%type := trim(:P11_TOPIC_GROUP_MANUAL);',
'begin',
'    if l_topic_name is not null then',
'        begin',
'            insert into tsk_topic_groups (',
'                topic_name,',
'                active_yn',
'            ) values (',
'                l_topic_name,',
'                ''Y''',
'            )',
'            returning topic_group_id into :P11_TOPIC_GROUP_ID;',
'        exception',
'            when dup_val_on_index then',
'                select topic_group_id',
'                  into :P11_TOPIC_GROUP_ID',
'                  from tsk_topic_groups',
'                 where upper(topic_name) = upper(l_topic_name)',
'                 fetch first 1 row only;',
'',
'                update tsk_topic_groups',
'                   set active_yn = ''Y''',
'                 where topic_group_id = :P11_TOPIC_GROUP_ID;',
'        end;',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>9990001100001002
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(16508280552047762)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(16506118818047760)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Task'
,p_static_id=>'process-form-task-form'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>16508280552047762
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
