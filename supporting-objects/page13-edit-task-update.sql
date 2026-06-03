prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback

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
-- Page Export:
--   Application:     12892
--   Page:            13
--   Name:            Edit Task Update
--

prompt --application/pages/delete_00013
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>13);
end;
/

prompt --application/pages/page_00013
begin
wwv_flow_imp_page.create_page(
 p_id=>13
,p_name=>'Edit Task Update'
,p_alias=>'EDIT-TASK-UPDATE'
,p_page_mode=>'MODAL'
,p_step_title=>'Edit Task Update'
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
 p_id=>wwv_flow_imp.id(9990001300000101)
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
 p_id=>wwv_flow_imp.id(9990001300000102)
,p_plug_name=>'Edit Update'
,p_static_id=>'edit-update'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(9990001300000201)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(9990001300000101)
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
 p_id=>wwv_flow_imp.id(9990001300000202)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(9990001300000101)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save Update'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9990001300000301)
,p_name=>'P13_TASK_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(9990001300000102)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9990001300000302)
,p_name=>'P13_UPDATE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(9990001300000102)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9990001300000303)
,p_name=>'P13_UPDATE_TEXT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(9990001300000102)
,p_prompt=>'Update'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_cMaxlength=>4000
,p_cHeight=>12
,p_colspan=>12
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'N',
  'format', 'MARKDOWN')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(9990001300000401)
,p_name=>'Cancel Dialog'
,p_static_id=>'cancel-dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(9990001300000201)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9990001300000402)
,p_event_id=>wwv_flow_imp.id(9990001300000401)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-dialog-cancel'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9990001300000501)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Update'
,p_static_id=>'load-update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select dbms_lob.substr(update_text, 4000, 1)',
'      into :P13_UPDATE_TEXT',
'      from tsk_task_updates',
'     where update_id = :P13_UPDATE_ID',
'       and task_id = :P13_TASK_ID;',
'exception',
'    when no_data_found then',
'        raise_application_error(-20001, ''The selected update was not found.'');',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9990001300000502)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Update'
,p_static_id=>'save-update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_update_text varchar2(4000) := trim(:P13_UPDATE_TEXT);',
'begin',
'    if l_update_text is null then',
'        raise_application_error(-20001, ''Enter update text before saving.'');',
'    end if;',
'',
'    update tsk_task_updates',
'       set update_text = l_update_text',
'     where update_id = :P13_UPDATE_ID',
'       and task_id = :P13_TASK_ID;',
'',
'    if sql%rowcount = 0 then',
'        raise_application_error(-20001, ''The selected update was not found.'');',
'    end if;',
'',
'    insert into tsk_change_log (',
'        entity_name,',
'        entity_pk,',
'        task_id,',
'        change_action,',
'        change_note,',
'        changed_by',
'    ) values (',
'        ''TASK_UPDATE'',',
'        :P13_UPDATE_ID,',
'        :P13_TASK_ID,',
'        ''UPDATE'',',
'        ''Update edited: '' || l_update_text,',
'        :APP_USER',
'    );',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(9990001300000202)
,p_process_success_message=>'Update saved'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9990001300000503)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_static_id=>'close-dialog'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'show_success_messages', 'Y')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(9990001300000202)
);
end;
/

prompt --application/end_environment
begin
wwv_flow_imp.import_end;
end;
/
