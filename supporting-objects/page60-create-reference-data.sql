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
prompt --application/pages/delete_00060
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>60);
end;
/
prompt --application/pages/delete_00061
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>61);
end;
/
prompt --application/pages/page_00060
begin
wwv_flow_imp_page.create_page(
 p_id=>60
,p_name=>'Reference Data'
,p_alias=>'REFERENCE-DATA'
,p_step_title=>'Reference Data'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6100006000003001)
,p_plug_name=>'Reference Data Title'
,p_static_id=>'reference-data-title'
,p_title=>'Reference Data'
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
 p_id=>wwv_flow_imp.id(6100006000003002)
,p_plug_name=>'Reference Data Actions'
,p_static_id=>'reference-data-actions'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>2127905476394690047
,p_plug_display_sequence=>5
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39329548844332677)
,p_plug_name=>'Reference Data'
,p_static_id=>'reference-data'
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders'
,p_plug_template=>2102002977963900996
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select apex_page.get_url(',
'           p_page => 61,',
'           p_clear_cache => ''61'',',
'           p_items => ''P61_REF_TYPE,P61_REF_ID'',',
'           p_values => ''STATUS,'' || status_id',
'       ) edit_url,',
'       ''STATUS'' ref_type,',
'       status_id ref_id,',
'       status_code code,',
'       status_name name,',
'       display_seq,',
'       active_yn,',
'       is_open_yn flag_1,',
'       is_done_yn flag_2',
'  from tsk_statuses',
'union all',
'select apex_page.get_url(',
'           p_page => 61,',
'           p_clear_cache => ''61'',',
'           p_items => ''P61_REF_TYPE,P61_REF_ID'',',
'           p_values => ''TASK_TYPE,'' || type_id',
'       ) edit_url,',
'       ''TASK_TYPE'' ref_type,',
'       type_id ref_id,',
'       type_code code,',
'       type_name name,',
'       display_seq,',
'       active_yn,',
'       cast(null as varchar2(1)) flag_1,',
'       cast(null as varchar2(1)) flag_2',
'  from tsk_task_types',
'union all',
'select apex_page.get_url(',
'           p_page => 61,',
'           p_clear_cache => ''61'',',
'           p_items => ''P61_REF_TYPE,P61_REF_ID'',',
'           p_values => ''COMPLEXITY,'' || complexity_id',
'       ) edit_url,',
'       ''COMPLEXITY'' ref_type,',
'       complexity_id ref_id,',
'       complexity_code code,',
'       complexity_name name,',
'       display_seq,',
'       active_yn,',
'       to_char(complexity_weight) flag_1,',
'       cast(null as varchar2(1)) flag_2',
'  from tsk_complexities'))
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(39329637901332677)
,p_no_data_found_message=>'No reference data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_detail_link=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:P61_REF_TYPE,P61_REF_ID:#REF_TYPE#,#REF_ID#'
,p_detail_link_text=>'<span role="img" aria-label="Edit" class="fa fa-edit" title="Edit"></span>'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_internal_uid=>16437324696744654
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(6100006000004001)
,p_db_column_name=>'EDIT_URL'
,p_display_order=>5
,p_column_identifier=>'H'
,p_column_label=>' '
,p_column_html_expression=>'<a href="#EDIT_URL#" class="t-Button t-Button--noLabel t-Button--icon t-Button--tiny" title="Edit reference data" aria-label="Edit reference data"><span class="fa fa-edit" aria-hidden="true"></span></a>'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(6100006000004002)
,p_db_column_name=>'REF_ID'
,p_display_order=>6
,p_column_identifier=>'I'
,p_column_label=>'Reference Id'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39330138027332678)
,p_db_column_name=>'ACTIVE_YN'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Active'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39329882334332678)
,p_db_column_name=>'CODE'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Code'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39330056411332678)
,p_db_column_name=>'DISPLAY_SEQ'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Seq'
,p_column_type=>'NUMBER'
,p_heading_alignment=>'RIGHT'
,p_column_alignment=>'RIGHT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39330281815332678)
,p_db_column_name=>'FLAG_1'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Flag 1'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39330364587332679)
,p_db_column_name=>'FLAG_2'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Flag 2'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39330000678332678)
,p_db_column_name=>'NAME'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(39329760961332677)
,p_db_column_name=>'REF_TYPE'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Type'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
,p_available_clientside=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(39402962489652653)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'primary'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'REF_TYPE:CODE:NAME:DISPLAY_SEQ:ACTIVE_YN:FLAG_1:FLAG_2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6100006000001001)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(6100006000003002)
,p_button_name=>'ADD_STATUS'
,p_static_id=>'add-status'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Status'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:P61_REF_TYPE:STATUS'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6100006000001002)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(6100006000003002)
,p_button_name=>'ADD_TASK_TYPE'
,p_static_id=>'add-task-type'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Task Type'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:P61_REF_TYPE:TASK_TYPE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6100006000001003)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(6100006000003002)
,p_button_name=>'ADD_COMPLEXITY'
,p_static_id=>'add-complexity'
,p_show_as_disabled=>false
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add Complexity'
,p_button_position=>'NEXT'
,p_button_redirect_url=>'f?p=&APP_ID.:61:&SESSION.::&DEBUG.:61:P61_REF_TYPE:COMPLEXITY'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6100006000002001)
,p_name=>'Refresh on Reference Data Dialog Close'
,p_static_id=>'refresh-on-reference-data-dialog-close'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(39329548844332677)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6100006000002002)
,p_event_id=>wwv_flow_imp.id(6100006000002001)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-reference-data'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39329548844332677)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
end;
/
prompt --application/pages/page_00061
begin
wwv_flow_imp_page.create_page(
 p_id=>61
,p_name=>'Create Reference Data'
,p_alias=>'CREATE-REFERENCE-DATA'
,p_page_mode=>'MODAL'
,p_step_title=>'Create Reference Data'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_step_template=>1662662927374504442
,p_page_template_options=>'#DEFAULT#:js-dialog-class-t-Drawer--pullOutEnd'
,p_dialog_chained=>'N'
,p_dialog_resizable=>'Y'
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(6100006100001001)
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
 p_id=>wwv_flow_imp.id(6100006100001002)
,p_plug_name=>'Reference Data'
,p_static_id=>'reference-data-form'
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
 p_id=>wwv_flow_imp.id(6100006100002001)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(6100006100001001)
,p_button_name=>'CANCEL'
,p_static_id=>'cancel'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6100006100002002)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(6100006100001001)
,p_button_name=>'CREATE'
,p_static_id=>'create'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create Reference Data'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P61_REF_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6100006100002003)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(6100006100001001)
,p_button_name=>'SAVE'
,p_static_id=>'save'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save Reference Data'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P61_REF_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(6100006100002004)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(6100006100001001)
,p_button_name=>'DELETE'
,p_static_id=>'delete'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Delete Reference Data'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P61_REF_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003001)
,p_name=>'P61_REF_TYPE'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_item_default=>'TASK_TYPE'
,p_prompt=>'Reference Type'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Status;STATUS,Task Type;TASK_TYPE,Complexity;COMPLEXITY'
,p_cHeight=>1
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003009)
,p_name=>'P61_REF_ID'
,p_item_sequence=>15
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003002)
,p_name=>'P61_NAME'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_prompt=>'Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
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
 p_id=>wwv_flow_imp.id(6100006100003003)
,p_name=>'P61_CODE'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_prompt=>'Code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>60
,p_cMaxlength=>100
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Use a unique uppercase code such as TASK or NEW_FEATURE.'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003004)
,p_name=>'P61_DISPLAY_SEQ'
,p_is_required=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_item_default=>'10'
,p_prompt=>'Display Sequence'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003005)
,p_name=>'P61_ACTIVE_YN'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_item_default=>'Y'
,p_prompt=>'Active'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003006)
,p_name=>'P61_IS_OPEN_YN'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_item_default=>'Y'
,p_prompt=>'Open Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Used only when Reference Type is Status.'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003007)
,p_name=>'P61_IS_DONE_YN'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_item_default=>'N'
,p_prompt=>'Done Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC2:Yes;Y,No;N'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Used only when Reference Type is Status.'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'execute_validations', 'N',
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(6100006100003008)
,p_name=>'P61_COMPLEXITY_WEIGHT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(6100006100001002)
,p_item_default=>'1'
,p_prompt=>'Complexity Weight'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'Used only when Reference Type is Complexity.'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(6100006100004001)
,p_name=>'Cancel Dialog'
,p_static_id=>'cancel-dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(6100006100002001)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(6100006100004002)
,p_event_id=>wwv_flow_imp.id(6100006100004001)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'native-dialog-cancel'
,p_action=>'NATIVE_DIALOG_CANCEL'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(6100006100005003)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Reference Data'
,p_static_id=>'load-reference-data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P61_REF_ID is null then',
'        return;',
'    end if;',
'',
'    if :P61_REF_TYPE = ''STATUS'' then',
'        select status_name,',
'               status_code,',
'               display_seq,',
'               active_yn,',
'               is_open_yn,',
'               is_done_yn,',
'               null',
'          into :P61_NAME,',
'               :P61_CODE,',
'               :P61_DISPLAY_SEQ,',
'               :P61_ACTIVE_YN,',
'               :P61_IS_OPEN_YN,',
'               :P61_IS_DONE_YN,',
'               :P61_COMPLEXITY_WEIGHT',
'          from tsk_statuses',
'         where status_id = to_number(:P61_REF_ID);',
'    elsif :P61_REF_TYPE = ''TASK_TYPE'' then',
'        select type_name,',
'               type_code,',
'               display_seq,',
'               active_yn,',
'               null,',
'               null,',
'               null',
'          into :P61_NAME,',
'               :P61_CODE,',
'               :P61_DISPLAY_SEQ,',
'               :P61_ACTIVE_YN,',
'               :P61_IS_OPEN_YN,',
'               :P61_IS_DONE_YN,',
'               :P61_COMPLEXITY_WEIGHT',
'          from tsk_task_types',
'         where type_id = to_number(:P61_REF_ID);',
'    elsif :P61_REF_TYPE = ''COMPLEXITY'' then',
'        select complexity_name,',
'               complexity_code,',
'               display_seq,',
'               active_yn,',
'               null,',
'               null,',
'               complexity_weight',
'          into :P61_NAME,',
'               :P61_CODE,',
'               :P61_DISPLAY_SEQ,',
'               :P61_ACTIVE_YN,',
'               :P61_IS_OPEN_YN,',
'               :P61_IS_DONE_YN,',
'               :P61_COMPLEXITY_WEIGHT',
'          from tsk_complexities',
'         where complexity_id = to_number(:P61_REF_ID);',
'    else',
'        raise_application_error(-20000, ''Select a valid reference type.'');',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>6100006100005003
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(6100006100005001)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Reference Data'
,p_static_id=>'create-reference-data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_code varchar2(100) := upper(regexp_replace(trim(:P61_CODE), ''[^[:alnum:]]+'', ''_''));',
'    l_name varchar2(255) := trim(:P61_NAME);',
'begin',
'    if l_code is null or l_name is null then',
'        raise_application_error(-20000, ''Name and Code are required.'');',
'    end if;',
'',
'    if :P61_REF_TYPE = ''STATUS'' then',
'        insert into tsk_statuses (',
'            status_code,',
'            status_name,',
'            is_open_yn,',
'            is_done_yn,',
'            display_seq,',
'            active_yn',
'        ) values (',
'            l_code,',
'            l_name,',
'            nvl(:P61_IS_OPEN_YN, ''Y''),',
'            nvl(:P61_IS_DONE_YN, ''N''),',
'            to_number(:P61_DISPLAY_SEQ),',
'            nvl(:P61_ACTIVE_YN, ''Y'')',
'        );',
'    elsif :P61_REF_TYPE = ''TASK_TYPE'' then',
'        insert into tsk_task_types (',
'            type_code,',
'            type_name,',
'            display_seq,',
'            active_yn',
'        ) values (',
'            l_code,',
'            l_name,',
'            to_number(:P61_DISPLAY_SEQ),',
'            nvl(:P61_ACTIVE_YN, ''Y'')',
'        );',
'    elsif :P61_REF_TYPE = ''COMPLEXITY'' then',
'        insert into tsk_complexities (',
'            complexity_code,',
'            complexity_name,',
'            complexity_weight,',
'            display_seq,',
'            active_yn',
'        ) values (',
'            l_code,',
'            l_name,',
'            nvl(to_number(:P61_COMPLEXITY_WEIGHT), 1),',
'            to_number(:P61_DISPLAY_SEQ),',
'            nvl(:P61_ACTIVE_YN, ''Y'')',
'        );',
'    else',
'        raise_application_error(-20000, ''Select a valid reference type.'');',
'    end if;',
'exception',
'    when dup_val_on_index then',
'        raise_application_error(-20001, ''A reference data value with this code already exists.'');',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(6100006100002002)
,p_internal_uid=>6100006100005001
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(6100006100005004)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Reference Data'
,p_static_id=>'save-reference-data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_code varchar2(100) := upper(regexp_replace(trim(:P61_CODE), ''[^[:alnum:]]+'', ''_''));',
'    l_name varchar2(255) := trim(:P61_NAME);',
'begin',
'    if :P61_REF_ID is null then',
'        raise_application_error(-20000, ''Select a reference data row to update.'');',
'    end if;',
'',
'    if l_code is null or l_name is null then',
'        raise_application_error(-20000, ''Name and Code are required.'');',
'    end if;',
'',
'    if :P61_REF_TYPE = ''STATUS'' then',
'        update tsk_statuses',
'           set status_code = l_code,',
'               status_name = l_name,',
'               is_open_yn = nvl(:P61_IS_OPEN_YN, ''Y''),',
'               is_done_yn = nvl(:P61_IS_DONE_YN, ''N''),',
'               display_seq = to_number(:P61_DISPLAY_SEQ),',
'               active_yn = nvl(:P61_ACTIVE_YN, ''Y'')',
'         where status_id = to_number(:P61_REF_ID);',
'    elsif :P61_REF_TYPE = ''TASK_TYPE'' then',
'        update tsk_task_types',
'           set type_code = l_code,',
'               type_name = l_name,',
'               display_seq = to_number(:P61_DISPLAY_SEQ),',
'               active_yn = nvl(:P61_ACTIVE_YN, ''Y'')',
'         where type_id = to_number(:P61_REF_ID);',
'    elsif :P61_REF_TYPE = ''COMPLEXITY'' then',
'        update tsk_complexities',
'           set complexity_code = l_code,',
'               complexity_name = l_name,',
'               complexity_weight = nvl(to_number(:P61_COMPLEXITY_WEIGHT), 1),',
'               display_seq = to_number(:P61_DISPLAY_SEQ),',
'               active_yn = nvl(:P61_ACTIVE_YN, ''Y'')',
'         where complexity_id = to_number(:P61_REF_ID);',
'    else',
'        raise_application_error(-20000, ''Select a valid reference type.'');',
'    end if;',
'',
'    if sql%rowcount = 0 then',
'        raise_application_error(-20002, ''The selected reference data row no longer exists.'');',
'    end if;',
'exception',
'    when dup_val_on_index then',
'        raise_application_error(-20001, ''A reference data value with this code already exists.'');',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(6100006100002003)
,p_internal_uid=>6100006100005004
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(6100006100005005)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete Reference Data'
,p_static_id=>'delete-reference-data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P61_REF_ID is null then',
'        raise_application_error(-20000, ''Select a reference data row to delete.'');',
'    end if;',
'',
'    if :P61_REF_TYPE = ''STATUS'' then',
'        delete from tsk_statuses',
'         where status_id = to_number(:P61_REF_ID);',
'    elsif :P61_REF_TYPE = ''TASK_TYPE'' then',
'        delete from tsk_task_types',
'         where type_id = to_number(:P61_REF_ID);',
'    elsif :P61_REF_TYPE = ''COMPLEXITY'' then',
'        delete from tsk_complexities',
'         where complexity_id = to_number(:P61_REF_ID);',
'    else',
'        raise_application_error(-20000, ''Select a valid reference type.'');',
'    end if;',
'',
'    if sql%rowcount = 0 then',
'        raise_application_error(-20002, ''The selected reference data row no longer exists.'');',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(6100006100002004)
,p_internal_uid=>6100006100005005
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(6100006100005002)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close Dialog'
,p_static_id=>'close-dialog'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'CREATE,SAVE,DELETE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>6100006100005002
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
