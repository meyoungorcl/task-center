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
--   Date and Time:   20:50 Tuesday June 2, 2026
--   Exported By:     WKSP_DBAPPDEV
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 41
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     746020101855378
--

begin
null;
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
 p_id=>wwv_flow_imp.id(17625308266402445)
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
 p_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626775126402447)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(17625308266402445)
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
 p_id=>wwv_flow_imp.id(17626807258402447)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(17625308266402445)
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
 p_id=>wwv_flow_imp.id(9990004100000001)
,p_button_sequence=>15
,p_button_plug_id=>wwv_flow_imp.id(17625308266402445)
,p_button_name=>'SEND_NOW'
,p_static_id=>'send-now'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Send Now'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>':P41_SCHEDULE_CODE = ''DAILY_MEMBER_STATUS'''
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'EXPRESSION'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17625532883402445)
,p_name=>'P41_EMAIL_SCHEDULE_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_source=>'EMAIL_SCHEDULE_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17625854117402446)
,p_name=>'P41_ENABLED_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626366467402446)
,p_name=>'P41_INCLUDE_ASSIGNED_TASKS_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626639678402447)
,p_name=>'P41_INCLUDE_COMMENTS_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626566771402447)
,p_name=>'P41_INCLUDE_OVERDUE_TASKS_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626402106402447)
,p_name=>'P41_INCLUDE_TASK_UPDATES_YN'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17625923373402446)
,p_name=>'P41_RECIPIENTS_SCOPE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_prompt=>'Recipients'
,p_source=>'RECIPIENTS_SCOPE'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Team Members;TEAM_MEMBERS,Team Leads;TEAM_LEADS,Managers;MANAGERS,Custom;CUSTOM'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_alignment=>'LEFT-CENTER'
,p_display_when=>':P41_SCHEDULE_CODE <> ''DAILY_MEMBER_STATUS'''
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
 p_id=>wwv_flow_imp.id(17625756166402446)
,p_name=>'P41_SCHEDULE_CODE'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17625638747402445)
,p_name=>'P41_SCHEDULE_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(9990004100000003)
,p_name=>'P41_SEND_AT'
,p_source_data_type=>'TIMESTAMP'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626089580402446)
,p_name=>'P41_SEND_HOUR'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>65
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_source=>'SEND_HOUR'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17626154839402446)
,p_name=>'P41_SEND_MINUTE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_source=>'SEND_MINUTE'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17864170020672105)
,p_name=>'P41_TEAM_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>25
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_source=>'TEAM_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(17864211316672105)
,p_name=>'P41_TEAM_MEMBER_IDS'
,p_item_sequence=>55
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626267930402446)
,p_name=>'P41_WEEKLY_DAY_NUMBER'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(17625458661402445)
,p_item_source_plug_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17626918308402447)
,p_name=>'Cancel Dialog'
,p_static_id=>'cancel-dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(17626775126402447)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(17627033613402447)
,p_event_id=>wwv_flow_imp.id(17626918308402447)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-dialog-cancel'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17627149638402447)
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
 p_id=>wwv_flow_imp.id(17627232165402447)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(17625458661402445)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Email Schedule'
,p_static_id=>'initialize-form-email-schedule-form'
,p_internal_uid=>17627232165402447
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17864346476672107)
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
 p_id=>wwv_flow_imp.id(17627375741402447)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(17625458661402445)
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
 p_id=>wwv_flow_imp.id(17864479348672107)
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
 p_id=>wwv_flow_imp.id(9990004100000002)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send Daily Email Now'
,p_static_id=>'send-daily-email-now'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    tsk_daily_email_pkg.send_daily_schedule(:P41_EMAIL_SCHEDULE_ID);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SEND_NOW'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_process_success_message=>'Daily email queued'
,p_internal_uid=>9990004100000002
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(17632726993415849)
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
