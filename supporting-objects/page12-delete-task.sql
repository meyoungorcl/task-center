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
--   Date and Time:   17:44 Wednesday June 3, 2026
--   Exported By:     WKSP_DBAPPDEV
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 12
--   Manifest End
--   Version:         26.1.0
--   Instance ID:     746020101855378
--

begin
null;
end;
/
prompt --application/pages/delete_00012
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>12);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_imp_page.create_page(
 p_id=>12
,p_name=>'Task Details'
,p_alias=>'TASK-DETAILS'
,p_step_title=>'Task Details'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.jQuery(() => {',
'    const sizeEditUpdateDialog = () => {',
'        const region = apex.jQuery("#edit-update-dialog, #R9990001200000201").first();',
'        const dialog = region.closest(".ui-dialog");',
'        if (dialog.length) {',
'            dialog.css({',
'                width: "min(960px, calc(100vw - 2rem))",',
'                maxWidth: "calc(100vw - 2rem)"',
'            });',
'            region.css("width", "100%");',
'            dialog.position({ my: "center", at: "center", of: window });',
'        }',
'    };',
'',
'    const setEditUpdateText = (value) => {',
'        const item = apex.item("P12_EDIT_UPDATE_TEXT");',
'        if (item && item.setValue) {',
'            item.setValue(value || "", null, true);',
'        } else {',
'            $s("P12_EDIT_UPDATE_TEXT", value || "");',
'        }',
'    };',
'',
'    const showEditUpdateDialog = () => {',
'        const region = apex.jQuery("#edit-update-dialog, #R9990001200000201").first();',
'        try {',
'            apex.theme.openRegion("edit-update-dialog");',
'        } catch (ignore) {',
'            try {',
'                apex.theme.openRegion(region.attr("id"));',
'            } catch (ignoreNested) {',
'                if (region.data("ui-dialog")) {',
'                    region.dialog("open");',
'                } else {',
'                    region.show();',
'                }',
'            }',
'        }',
'    };',
'',
'    const openEditUpdateDialog = (updateId, updateText) => {',
'        $s("P12_EDIT_UPDATE_ID", updateId);',
'        setEditUpdateText(updateText);',
'        showEditUpdateDialog();',
'        setTimeout(() => {',
'            setEditUpdateText(updateText);',
'            sizeEditUpdateDialog();',
'        }, 0);',
'    };',
'',
'    window.taskCenterEditUpdate = (link) => {',
'        openEditUpdateDialog(',
'            link.getAttribute("data-update-id"),',
'            link.getAttribute("data-update-text") || ""',
'        );',
'        return false;',
'    };',
'',
'    apex.jQuery(document).on("click", "a.js-edit-update", function(event) {',
'        event.preventDefault();',
'        window.taskCenterEditUpdate(this);',
'    });',
'',
'    if ($v("P12_EDIT_UPDATE_ID")) {',
'        const dialog = apex.jQuery("#edit-update-dialog, #R9990001200000201").first();',
'        if (dialog.length) {',
'            showEditUpdateDialog();',
'            dialog.attr("aria-modal", "true");',
'            setTimeout(sizeEditUpdateDialog, 0);',
'        }',
'    }',
'',
'    apex.jQuery(window).on("resize", () => {',
'        if ($v("P12_EDIT_UPDATE_ID")) {',
'            sizeEditUpdateDialog();',
'        }',
'    });',
'});'))
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'02'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39415053882090019)
,p_plug_name=>'Activity'
,p_static_id=>'activity'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_grid_column_span=>5
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39945129144807892)
,p_plug_name=>'Audit'
,p_static_id=>'audit'
,p_parent_plug_id=>wwv_flow_imp.id(32882314404588024)
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2665811232373458102
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39428389657194211)
,p_plug_name=>'Breadcrumb'
,p_static_id=>'breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>2532939663579242476
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_menu_id=>wwv_flow_imp.id(39327696407332675)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>4073839682315169711
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39416353206090021)
,p_plug_name=>'Change Log'
,p_static_id=>'change-log'
,p_parent_plug_id=>wwv_flow_imp.id(32882314404588024)
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_plug_template=>2665811232373458102
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'BELOW'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select change_id,',
'       apex_string.get_initials(nvl(changed_by, ''System'')) as user_initials,',
'       ''u-color-'' || ora_hash(nvl(changed_by, ''System''), 45) as user_css_class,',
'       nvl(changed_by, ''System'') as user_name,',
'       initcap(replace(change_action, ''_'', '' '')) || '': '' ||',
'           coalesce(change_note, field_name || '' changed'', new_value) as comment_text,',
'       changed_at as comment_date',
'  from tsk_change_log',
' where task_id = :P12_TASK_ID',
' order by changed_at desc'))
,p_template_component_type=>'REPORT'
,p_lazy_loading=>false
,p_plug_source_type=>'TMPL_THEME_42$COMMENTS'
,p_ajax_items_to_submit=>'P12_TASK_ID'
,p_plug_query_num_rows=>15
,p_plug_query_num_rows_type=>'SET'
,p_plug_query_no_data_found=>'No changes'
,p_no_data_found_icon_classes=>'fa-comments-o fa-lg'
,p_show_total_row_count=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'APPLY_THEME_COLORS', 'N',
  'COMMENT_DATE', 'COMMENT_DATE',
  'COMMENT_TEXT', 'COMMENT_TEXT',
  'DISPLAY_AVATAR', 'N',
  'STYLE', 't-Comments--chat',
  'USER_NAME', 'USER_NAME')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39891536439153148)
,p_name=>'CHANGE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CHANGE_ID'
,p_data_type=>'NUMBER'
,p_display_sequence=>10
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
,p_available_clientside=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39892112520153149)
,p_name=>'COMMENT_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENT_DATE'
,p_data_type=>'DATE'
,p_display_sequence=>60
,p_format_mask=>'SINCE'
,p_is_group=>false
,p_use_as_row_header=>true
,p_is_primary_key=>false
,p_available_clientside=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39891967891153149)
,p_name=>'COMMENT_TEXT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'COMMENT_TEXT'
,p_data_type=>'VARCHAR2'
,p_display_sequence=>50
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
,p_available_clientside=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39891736882153148)
,p_name=>'USER_CSS_CLASS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_CSS_CLASS'
,p_data_type=>'VARCHAR2'
,p_display_sequence=>30
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
,p_available_clientside=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39891710518153148)
,p_name=>'USER_INITIALS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_INITIALS'
,p_data_type=>'VARCHAR2'
,p_display_sequence=>20
,p_is_group=>false
,p_use_as_row_header=>false
,p_is_primary_key=>false
,p_available_clientside=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39891827729153149)
,p_name=>'USER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'USER_NAME'
,p_data_type=>'VARCHAR2'
,p_display_sequence=>40
,p_is_group=>false
,p_use_as_row_header=>true
,p_is_primary_key=>false
,p_available_clientside=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(32882314404588224)
,p_plug_name=>'Edit Update'
,p_static_id=>'edit-update-dialog'
,p_parent_plug_id=>wwv_flow_imp.id(39415053882090019)
,p_region_template_options=>'#DEFAULT#:js-dialog-autoheight'
,p_plug_template=>2674150083631647148
,p_plug_display_sequence=>25
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(32882314404588024)
,p_plug_name=>'Task Detail Column'
,p_static_id=>'task-detail-column'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>10
,p_plug_grid_column_span=>7
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39414927310090019)
,p_plug_name=>'Task Details'
,p_static_id=>'task-details'
,p_parent_plug_id=>wwv_flow_imp.id(32882314404588024)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_query_type=>'TABLE'
,p_query_table=>'TSK_TASKS'
,p_include_rowid_column=>false
,p_is_editable=>true
,p_edit_operations=>'u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39927975489645006)
,p_plug_name=>'Files'
,p_static_id=>'task-files'
,p_parent_plug_id=>wwv_flow_imp.id(39415053882090019)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(39928065697645007)
,p_name=>'Attached Files'
,p_static_id=>'task-files-list'
,p_parent_plug_id=>wwv_flow_imp.id(39927975489645006)
,p_template=>4502917002193490937
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--inline:t-Report--rowHighlight'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select file_id,',
'       nvl(file_display_name, file_name) as file_display_name,',
'       file_description,',
'       file_name,',
'       mime_type,',
'       file_size,',
'       uploaded_by,',
'       uploaded_at,',
'       apex_page.get_url(',
'           p_page => 12,',
'           p_request => ''DOWNLOAD_FILE'',',
'           p_items => ''P12_TASK_ID,P12_FILE_ID'',',
'           p_values => :P12_TASK_ID || '','' || file_id',
'       ) as download_url,',
'       apex_page.get_url(',
'           p_page => 12,',
'           p_request => ''DELETE_FILE'',',
'           p_items => ''P12_TASK_ID,P12_FILE_ID'',',
'           p_values => :P12_TASK_ID || '','' || file_id',
'       ) as delete_url',
'  from tsk_task_files',
' where task_id = :P12_TASK_ID',
' order by uploaded_at desc, file_name'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P12_TASK_ID'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No files attached'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928863194645007)
,p_query_column_id=>10
,p_column_alias=>'DELETE_URL'
,p_column_display_sequence=>100
,p_column_heading=>' '
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="#DELETE_URL#" title="Delete file" aria-label="Delete file" onclick="return confirm(''Delete this file?'');">',
'  <span class="fa fa-trash-o u-danger-text" aria-hidden="true"></span>',
'</a>'))
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928785052645007)
,p_query_column_id=>9
,p_column_alias=>'DOWNLOAD_URL'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39935773645701432)
,p_query_column_id=>3
,p_column_alias=>'FILE_DESCRIPTION'
,p_column_display_sequence=>40
,p_column_heading=>'Description'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39935685056701432)
,p_query_column_id=>2
,p_column_alias=>'FILE_DISPLAY_NAME'
,p_column_display_sequence=>30
,p_column_heading=>'File'
,p_column_html_expression=>'<a href="#DOWNLOAD_URL#" title="Download #FILE_NAME#"><span class="fa fa-download" aria-hidden="true"></span> #FILE_DISPLAY_NAME#</a>'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928140241645007)
,p_query_column_id=>1
,p_column_alias=>'FILE_ID'
,p_column_display_sequence=>10
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928221978645007)
,p_query_column_id=>4
,p_column_alias=>'FILE_NAME'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928467622645007)
,p_query_column_id=>6
,p_column_alias=>'FILE_SIZE'
,p_column_display_sequence=>60
,p_column_heading=>'Size'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928360195645007)
,p_query_column_id=>5
,p_column_alias=>'MIME_TYPE'
,p_column_display_sequence=>50
,p_column_heading=>'Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928649874645007)
,p_query_column_id=>8
,p_column_alias=>'UPLOADED_AT'
,p_column_display_sequence=>80
,p_column_heading=>'Uploaded'
,p_column_format=>'SINCE'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39928588463645007)
,p_query_column_id=>7
,p_column_alias=>'UPLOADED_BY'
,p_column_display_sequence=>70
,p_column_heading=>'Uploaded By'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39415814538090021)
,p_plug_name=>'Updates / Comments'
,p_static_id=>'update-entry'
,p_parent_plug_id=>wwv_flow_imp.id(39415053882090019)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(39415963578090021)
,p_name=>'Recent Updates'
,p_static_id=>'updates'
,p_parent_plug_id=>wwv_flow_imp.id(39415053882090019)
,p_template=>2665811232373458102
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--inline:t-Report--stretch'
,p_display_point=>'SUB_REGIONS'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select null as update_card,',
'       tu.update_id,',
'       apex_string.get_initials(nvl(u.display_name, tu.created_by)) as user_initials,',
'       ''u-color-'' || ora_hash(nvl(u.display_name, tu.created_by), 45) as user_css_class,',
'       nvl(u.display_name, tu.created_by) as user_name,',
'       case',
'           when regexp_like(',
'                    dbms_lob.substr(tu.update_text, 4000, 1),',
'                    ''<(p|ul|ol|li|div|span|br|strong|em|s|h[1-6])([[:space:]>])'',',
'                    ''i''',
'                )',
'           then dbms_lob.substr(tu.update_text, 4000, 1)',
'           else dbms_lob.substr(',
'                    apex_markdown.to_html(to_clob(dbms_lob.substr(tu.update_text, 4000, 1))),',
'                    4000,',
'                    1',
'                )',
'       end as comment_text,',
'       apex_escape.html_attribute(dbms_lob.substr(tu.update_text, 4000, 1)) as edit_text_attr,',
'       tu.updated_at as comment_date,',
'       apex_page.get_url(',
'           p_page => 13,',
'           p_items => ''P13_TASK_ID,P13_UPDATE_ID'',',
'           p_values => :P12_TASK_ID || '','' || tu.update_id',
'       ) as edit_url,',
'       apex_page.get_url(',
'           p_page => 12,',
'           p_request => ''DELETE_UPDATE'',',
'           p_items => ''P12_TASK_ID,P12_DELETE_UPDATE_ID'',',
'           p_values => :P12_TASK_ID || '','' || tu.update_id',
'       ) as delete_url',
'  from tsk_task_updates tu',
'  left join tsk_team_members tm',
'    on tm.team_member_id = tu.team_member_id',
'  left join tsk_users u',
'    on u.user_id = tm.user_id',
' where tu.task_id = :P12_TASK_ID',
' order by tu.updated_at desc nulls last,',
'          tu.update_id desc'))
,p_ajax_enabled=>'Y'
,p_ajax_items_to_submit=>'P12_TASK_ID'
,p_lazy_loading=>false
,p_query_row_template=>2540130677583398057
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No updates'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39891425085153148)
,p_query_column_id=>8
,p_column_alias=>'COMMENT_DATE'
,p_column_display_sequence=>70
,p_default_sort_column_sequence=>1
,p_default_sort_dir=>'desc'
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39891314200153148)
,p_query_column_id=>6
,p_column_alias=>'COMMENT_TEXT'
,p_column_display_sequence=>60
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(32882314404588236)
,p_query_column_id=>10
,p_column_alias=>'DELETE_URL'
,p_column_display_sequence=>90
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(32882314404588249)
,p_query_column_id=>7
,p_column_alias=>'EDIT_TEXT_ATTR'
,p_column_display_sequence=>75
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(32882314404588237)
,p_query_column_id=>9
,p_column_alias=>'EDIT_URL'
,p_column_display_sequence=>80
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(32882314404588235)
,p_query_column_id=>1
,p_column_alias=>'UPDATE_CARD'
,p_column_display_sequence=>10
,p_column_heading=>' '
,p_column_html_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div style="border:1px solid var(--ut-component-border-color);border-radius:8px;padding:12px;margin-bottom:10px;background:var(--ut-component-background-color)">',
'  <div style="display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:8px">',
'    <div style="font-weight:700">#USER_NAME#</div>',
'    <div style="white-space:nowrap;color:var(--ut-component-text-muted-color);font-size:.82rem">#COMMENT_DATE#</div>',
'  </div>',
'  <div style="color:var(--ut-component-text-default-color)">#COMMENT_TEXT!RAW#</div>',
'  <div style="margin-top:8px;display:flex;gap:8px;justify-content:flex-end">',
'    <a href="#EDIT_URL#" class="t-Button t-Button--noLabel t-Button--icon t-Button--tiny" title="Edit update" aria-label="Edit update" aria-haspopup="dialog"><span cl'
||'ass="fa fa-edit" aria-hidden="true"></span></a>',
'    <a href="#DELETE_URL#" class="t-Button t-Button--noLabel t-Button--icon t-Button--tiny" title="Delete update" aria-label="Delete update" onclick="return confirm(''Delete this update?'');"><span class="fa fa-trash-o u-danger-text" aria-hidden="true"'
||'></span></a>',
'  </div>',
'</div>'))
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(32882314404588238)
,p_query_column_id=>2
,p_column_alias=>'UPDATE_ID'
,p_column_display_sequence=>20
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39891129188153148)
,p_query_column_id=>4
,p_column_alias=>'USER_CSS_CLASS'
,p_column_display_sequence=>40
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39891043942153148)
,p_query_column_id=>3
,p_column_alias=>'USER_INITIALS'
,p_column_display_sequence=>30
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(39891255096153148)
,p_query_column_id=>5
,p_column_alias=>'USER_NAME'
,p_column_display_sequence=>50
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(32882314404588228)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(32882314404588224)
,p_button_name=>'CANCEL_EDIT_UPDATE'
,p_static_id=>'cancel-edit-update'
,p_show_as_disabled=>false
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(32882314404588924)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_button_name=>'DELETE_TASK'
,p_static_id=>'delete-task'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Delete'
,p_button_position=>'EDIT'
,p_button_execute_validations=>'N'
,p_confirm_message=>'Delete this task and all related updates, files, topic groups, and assignees?'
,p_confirm_style=>'danger'
,p_button_condition=>'P12_TASK_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_button_css_classes=>'u-danger'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39418132403090025)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(39415814538090021)
,p_button_name=>'POST_UPDATE'
,p_static_id=>'post-update'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Post'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>3
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39429682555194215)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_button_name=>'SAVE_TASK'
,p_static_id=>'save-task'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_position=>'EDIT'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(32882314404588229)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(32882314404588224)
,p_button_name=>'SAVE_UPDATE'
,p_static_id=>'save-update'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save Update'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(39929133519645010)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(39927975489645006)
,p_button_name=>'UPLOAD_FILE'
,p_static_id=>'upload-file'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>4073839297780169708
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add File'
,p_button_css_classes=>'u-margin-top-lg'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39428997017194214)
,p_name=>'P12_APPLICATION_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39966902989982623)
,p_name=>'P12_ASSIGNEES'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
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
'   and (:P12_TEAM_ID is null or tm.team_id = :P12_TEAM_ID)',
' order by u.display_name'))
,p_colspan=>6
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
 p_id=>wwv_flow_imp.id(9990001200001001)
,p_name=>'P12_TOPIC_GROUP_MANUAL'
,p_item_sequence=>76
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39428828852194214)
,p_name=>'P12_COMPLEXITY_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
,p_begin_on_new_line=>'N'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41604044141539198)
,p_name=>'P12_CREATED_AT'
,p_source_data_type=>'TIMESTAMP'
,p_is_query_only=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(39945129144807892)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Created At'
,p_format_mask=>'DD-MON-YYYY HH24:MI'
,p_source=>'CREATED_AT'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>6
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41604122811539198)
,p_name=>'P12_CREATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(39945129144807892)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Created By'
,p_source=>'CREATED_BY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(32882314404588225)
,p_name=>'P12_DELETE_UPDATE_ID'
,p_item_sequence=>5
,p_item_plug_id=>wwv_flow_imp.id(32882314404588224)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39417713505090024)
,p_name=>'P12_DESCRIPTION'
,p_source_data_type=>'CLOB'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
 p_id=>wwv_flow_imp.id(39417669039090024)
,p_name=>'P12_DUE_DATE'
,p_source_data_type=>'DATE'
,p_is_required=>true
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
 p_id=>wwv_flow_imp.id(32882314404588226)
,p_name=>'P12_EDIT_UPDATE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(32882314404588224)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(32882314404588227)
,p_name=>'P12_EDIT_UPDATE_TEXT'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(32882314404588224)
,p_prompt=>'Update'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_cMaxlength=>4000
,p_cHeight=>7
,p_colspan=>12
,p_field_alignment=>'LEFT-CENTER'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'N',
  'format', 'MARKDOWN')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39429259119194215)
,p_name=>'P12_ESTIMATED_HOURS'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
 p_id=>wwv_flow_imp.id(39429448834194215)
,p_name=>'P12_EXTERNAL_REFERENCE'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(39945129144807892)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'External Reference'
,p_source=>'EXTERNAL_REFERENCE'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39935963743701435)
,p_name=>'P12_FILE_DESCRIPTION'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(39927975489645006)
,p_prompt=>'Description'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cMaxlength=>4000
,p_cHeight=>3
,p_colspan=>12
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'auto_height', 'N',
  'character_counter', 'N',
  'resizable', 'Y',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39935827774701435)
,p_name=>'P12_FILE_DISPLAY_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39927975489645006)
,p_prompt=>'Name'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cMaxlength=>255
,p_colspan=>12
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
 p_id=>wwv_flow_imp.id(39928929504645009)
,p_name=>'P12_FILE_ID'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'N')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39429043226194214)
,p_name=>'P12_OWNER_MEMBER_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_source=>'OWNER_MEMBER_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39429339099194215)
,p_name=>'P12_PERCENT_COMPLETE'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Complete %'
,p_source=>'PERCENT_COMPLETE'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>20
,p_begin_on_new_line=>'N'
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'number_alignment', 'left',
  'virtual_keyboard', 'decimal')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39428733896194214)
,p_name=>'P12_PRIORITY_CODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
 p_id=>wwv_flow_imp.id(39429185582194214)
,p_name=>'P12_START_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
 p_id=>wwv_flow_imp.id(39428696955194214)
,p_name=>'P12_STATUS_ID'
,p_source_data_type=>'NUMBER'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
 p_id=>wwv_flow_imp.id(39948309911829868)
,p_name=>'P12_SUBMITTED_BY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39945129144807892)
,p_prompt=>'Submitted By'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>6
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39929055520645010)
,p_name=>'P12_TASK_FILE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(39927975489645006)
,p_prompt=>'Add file'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_FILE'
,p_colspan=>10
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_protection_level=>'S'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_multiple_files', 'N',
  'display_as', 'INLINE',
  'purge_file_at', 'REQUEST',
  'storage_type', 'APEX_APPLICATION_TEMP_FILES')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39416988302090022)
,p_name=>'P12_TASK_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_source=>'TASK_ID'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'B'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'value_protected', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39417077752090022)
,p_name=>'P12_TASK_KEY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Task ID'
,p_source=>'TASK_KEY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39428447718194213)
,p_name=>'P12_TEAM_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Team'
,p_source=>'TEAM_ID'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select team_name as display_value,',
'       team_id as return_value',
'  from tsk_teams',
' order by team_name'))
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
 p_id=>wwv_flow_imp.id(39417119222090023)
,p_name=>'P12_TITLE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Title'
,p_source=>'TITLE'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cMaxlength=>255
,p_colspan=>12
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
 p_id=>wwv_flow_imp.id(32882314404588324)
,p_name=>'P12_TOPIC_GROUP_IDS'
,p_item_sequence=>75
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Topic Groups'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_COMBOBOX'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select topic_name as display_value,',
'       topic_group_id as return_value',
'  from tsk_topic_groups',
' where active_yn = ''Y''',
'    or exists (',
'           select 1',
'             from tsk_task_topic_groups ttg',
'            where ttg.task_id = :P12_TASK_ID',
'              and ttg.topic_group_id = tsk_topic_groups.topic_group_id',
'       )',
' order by topic_name'))
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_help_text=>'You can select an existing topic group or type a new topic group name. The new topic group will be added to the topic group list for future tasks.'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'case_sensitive', 'N',
  'fetch_on_search', 'N',
  'infinite_scroll', 'Y',
  'manual_entries_item', 'P12_TOPIC_GROUP_MANUAL',
  'match_type', 'CONTAINS',
  'min_chars', '0',
  'multi_selection', 'Y',
  'use_cache', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39428590486194213)
,p_name=>'P12_TYPE_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
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
,p_field_template=>1610598484065263269
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'page_action_on_selection', 'NONE')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41604237520539199)
,p_name=>'P12_UPDATED_AT'
,p_source_data_type=>'TIMESTAMP'
,p_is_query_only=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(39945129144807892)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Updated At'
,p_format_mask=>'DD-MON-YYYY HH24:MI'
,p_source=>'UPDATED_AT'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_colspan=>6
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41604360515539199)
,p_name=>'P12_UPDATED_BY'
,p_source_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(39945129144807892)
,p_item_source_plug_id=>wwv_flow_imp.id(39414927310090019)
,p_prompt=>'Updated By'
,p_source=>'UPDATED_BY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'based_on', 'VALUE',
  'format', 'PLAIN',
  'send_on_page_submit', 'N',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39417828968090024)
,p_name=>'P12_UPDATE_TEXT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(39415814538090021)
,p_prompt=>'Add an update'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_RICH_TEXT_EDITOR'
,p_colspan=>9
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'allow_custom_html', 'N',
  'format', 'MARKDOWN')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(32882314404588230)
,p_name=>'Cancel Edit Update'
,p_static_id=>'cancel-edit-update'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(32882314404588228)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(32882314404588231)
,p_event_id=>wwv_flow_imp.id(32882314404588230)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'close-edit-update-dialog'
,p_action=>'NATIVE_CLOSE_REGION'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(32882314404588224)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(39418220358090025)
,p_name=>'Refresh on Task Dialog Close'
,p_static_id=>'refresh-on-task-dialog-close'
,p_event_sequence=>10
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(39414927310090019)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39418616330090025)
,p_event_id=>wwv_flow_imp.id(39418220358090025)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-change-log'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39416353206090021)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(39418339255090025)
,p_event_id=>wwv_flow_imp.id(39418220358090025)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-task-details'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39414927310090019)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(9990001200000920)
,p_name=>'Refresh on Update Dialog Close'
,p_static_id=>'refresh-on-update-dialog-close'
,p_event_sequence=>20
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(39415963578090021)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9990001200000921)
,p_event_id=>wwv_flow_imp.id(9990001200000920)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-updates-after-edit'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39415963578090021)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9990001200000922)
,p_event_id=>wwv_flow_imp.id(9990001200000920)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_static_id=>'refresh-change-log-after-edit'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39416353206090021)
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'maintain_pagination', 'N')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39929400197645011)
,p_process_sequence=>15
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete File'
,p_static_id=>'delete-file'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_file_name tsk_task_files.file_name%type;',
'begin',
'    select nvl(file_display_name, file_name)',
'      into l_file_name',
'      from tsk_task_files',
'     where file_id = :P12_FILE_ID',
'       and task_id = :P12_TASK_ID;',
'',
'    delete from tsk_task_files',
'     where file_id = :P12_FILE_ID',
'       and task_id = :P12_TASK_ID;',
'',
'    insert into tsk_change_log (',
'        entity_name,',
'        entity_pk,',
'        task_id,',
'        change_action,',
'        change_note,',
'        changed_by',
'    ) values (',
'        ''TASK_FILE'',',
'        :P12_FILE_ID,',
'        :P12_TASK_ID,',
'        ''REMOVE'',',
'        ''File deleted: '' || l_file_name,',
'        :APP_USER',
'    );',
'',
'    :P12_FILE_ID := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'DELETE_FILE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'File deleted'
,p_internal_uid=>17037086993056988
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882314404588925)
,p_process_sequence=>5
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete Task'
,p_static_id=>'delete-task'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_task_key          tsk_tasks.task_key%type;',
'    l_title             tsk_tasks.title%type;',
'    l_update_count      pls_integer := 0;',
'    l_file_count        pls_integer := 0;',
'    l_topic_count       pls_integer := 0;',
'    l_assignee_count    pls_integer := 0;',
'    l_change_log_count  pls_integer := 0;',
'begin',
'    select task_key,',
'           title',
'      into l_task_key,',
'           l_title',
'      from tsk_tasks',
'     where task_id = :P12_TASK_ID',
'       for update;',
'',
'    delete from tsk_task_updates',
'     where task_id = :P12_TASK_ID;',
'    l_update_count := sql%rowcount;',
'',
'    delete from tsk_task_files',
'     where task_id = :P12_TASK_ID;',
'    l_file_count := sql%rowcount;',
'',
'    delete from tsk_task_topic_groups',
'     where task_id = :P12_TASK_ID;',
'    l_topic_count := sql%rowcount;',
'',
'    delete from tsk_task_assignees',
'     where task_id = :P12_TASK_ID;',
'    l_assignee_count := sql%rowcount;',
'',
'    delete from tsk_change_log',
'     where task_id = :P12_TASK_ID;',
'    l_change_log_count := sql%rowcount;',
'',
'    delete from tsk_tasks',
'     where task_id = :P12_TASK_ID;',
'',
'    if sql%rowcount = 0 then',
'        raise_application_error(-20001, ''The selected task was not found.'');',
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
'        ''TASK'',',
'        :P12_TASK_ID,',
'        null,',
'        ''DELETE'',',
'        ''Task deleted: '' || l_task_key || '' - '' || l_title ||',
'            ''. Removed '' || l_update_count || '' updates, '' ||',
'            l_file_count || '' files, '' ||',
'            l_topic_count || '' topic group associations, '' ||',
'            l_assignee_count || '' assignee associations, and '' ||',
'            l_change_log_count || '' audit entries.'',',
'        :APP_USER',
'    );',
'',
'    commit;',
'    apex_application.g_print_success_message := ''Task deleted'';',
'    apex_util.redirect_url(',
'        apex_page.get_url(',
'            p_page => 10,',
'            p_clear_cache => ''10''',
'        )',
'    );',
'    apex_application.stop_apex_engine;',
'exception',
'    when apex_application.e_stop_apex_engine then',
'        raise;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(32882314404588924)
,p_internal_uid=>9990001200000902
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882314404588232)
,p_process_sequence=>16
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete Update'
,p_static_id=>'delete-update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_update_text varchar2(4000);',
'begin',
'    select dbms_lob.substr(update_text, 4000, 1)',
'      into l_update_text',
'      from tsk_task_updates',
'     where update_id = :P12_DELETE_UPDATE_ID',
'       and task_id = :P12_TASK_ID;',
'',
'    delete from tsk_task_updates',
'     where update_id = :P12_DELETE_UPDATE_ID',
'       and task_id = :P12_TASK_ID;',
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
'        :P12_DELETE_UPDATE_ID,',
'        :P12_TASK_ID,',
'        ''DELETE'',',
'        ''Update deleted: '' || l_update_text,',
'        :APP_USER',
'    );',
'',
'    :P12_DELETE_UPDATE_ID := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'DELETE_UPDATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_process_success_message=>'Update deleted'
,p_internal_uid=>9990001200000209
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39929273891645010)
,p_process_sequence=>1
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Download File'
,p_static_id=>'download-file'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_blob      blob;',
'    l_file_name tsk_task_files.file_name%type;',
'    l_mime_type tsk_task_files.mime_type%type;',
'begin',
'    select file_blob,',
'           file_name,',
'           mime_type',
'      into l_blob,',
'           l_file_name,',
'           l_mime_type',
'      from tsk_task_files',
'     where file_id = :P12_FILE_ID',
'       and task_id = :P12_TASK_ID;',
'',
'    owa_util.mime_header(nvl(l_mime_type, ''application/octet-stream''), false);',
'    htp.p(''Content-length: '' || dbms_lob.getlength(l_blob));',
'    htp.p(''Content-Disposition: attachment; filename="'' || replace(l_file_name, ''"'', '''') || ''"'');',
'    owa_util.http_header_close;',
'    wpg_docload.download_file(l_blob);',
'    apex_application.stop_apex_engine;',
'exception',
'    when apex_application.e_stop_apex_engine then',
'        raise;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'DOWNLOAD_FILE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>17036960687056987
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39429905494194216)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(39414927310090019)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form Task Details'
,p_static_id=>'initialize-form-task-details'
,p_internal_uid=>16537592289606193
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9990001200000930)
,p_process_sequence=>11
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Default Task Status'
,p_static_id=>'default-task-status'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P12_STATUS_ID is null then',
'        select status_id',
'          into :P12_STATUS_ID',
'          from tsk_statuses',
'         where status_code = ''NOT_STARTED''',
'           and active_yn = ''Y''',
'         fetch first 1 row only;',
'    end if;',
'exception',
'    when no_data_found then',
'        null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>9990001200000930
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882314404588233)
,p_process_sequence=>17
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Load Update for Edit'
,p_static_id=>'load-update-for-edit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select dbms_lob.substr(update_text, 4000, 1)',
'      into :P12_EDIT_UPDATE_TEXT',
'      from tsk_task_updates',
'     where update_id = :P12_EDIT_UPDATE_ID',
'       and task_id = :P12_TASK_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'EDIT_UPDATE'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>9990001200000210
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39430015335194216)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Log Task Details Update'
,p_static_id=>'log-task-details-update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'insert into tsk_change_log (',
'    entity_name,',
'    entity_pk,',
'    task_id,',
'    change_action,',
'    change_note,',
'    changed_by',
') values (',
'    ''TASK'',',
'    :P12_TASK_ID,',
'    :P12_TASK_ID,',
'    ''UPDATE'',',
'    ''Task details updated'',',
'    :APP_USER',
');'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(39429682555194215)
,p_process_success_message=>'Task saved'
,p_internal_uid=>16537702130606193
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39418753071090025)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Post Update'
,p_static_id=>'post-update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_team_member_id tsk_team_members.team_member_id%type;',
'    l_update_text varchar2(4000) := trim(:P12_UPDATE_TEXT);',
'begin',
'    if l_update_text is null then',
'        raise_application_error(-20001, ''Enter an update before posting.'');',
'    end if;',
'',
'    begin',
'        select min(tm.team_member_id)',
'          into l_team_member_id',
'          from tsk_team_members tm',
'          join tsk_users u',
'            on u.user_id = tm.user_id',
'          join tsk_tasks t',
'            on t.team_id = tm.team_id',
'         where t.task_id = :P12_TASK_ID',
'           and tm.active_yn = ''Y''',
'           and u.active_yn = ''Y''',
'           and (lower(u.username) = lower(:APP_USER)',
'                or lower(u.email) = lower(:APP_USER));',
'    exception',
'        when no_data_found then',
'            l_team_member_id := null;',
'    end;',
'',
'    insert into tsk_task_updates (',
'        task_id,',
'        team_member_id,',
'        update_type,',
'        update_text',
'    ) values (',
'        :P12_TASK_ID,',
'        l_team_member_id,',
'        ''COMMENT'',',
'        l_update_text',
'    );',
'',
'    insert into tsk_change_log (',
'        entity_name,',
'        entity_pk,',
'        task_id,',
'        change_action,',
'        change_note,',
'        changed_by',
'    ) values (',
'        ''TASK'',',
'        :P12_TASK_ID,',
'        :P12_TASK_ID,',
'        ''COMMENT'',',
'        l_update_text,',
'        :APP_USER',
'    );',
'',
'    :P12_UPDATE_TEXT := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(39418132403090025)
,p_process_success_message=>'Update posted'
,p_internal_uid=>16526439866502002
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39429954115194216)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(39414927310090019)
,p_process_type=>'NATIVE_FORM_DML'
,p_process_name=>'Process form Task Details'
,p_static_id=>'process-form-task-details'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'lock_row', 'Y',
  'prevent_lost_updates', 'Y',
  'return_primary_keys_after_insert', 'Y',
  'target_type', 'REGION_SOURCE')).to_clob
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>16537640910606193
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882314404588933)
,p_process_sequence=>6
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Require Update Before Complete'
,p_static_id=>'require-update-before-complete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_is_done_yn      tsk_statuses.is_done_yn%type;',
'    l_update_count    pls_integer;',
'    l_post_update_yn  varchar2(1) := ''N'';',
'begin',
'    select nvl(max(is_done_yn), ''N'')',
'      into l_is_done_yn',
'      from tsk_statuses',
'     where status_id = :P12_STATUS_ID;',
'',
'    if l_is_done_yn = ''Y'' then',
'        select count(*)',
'          into l_update_count',
'          from tsk_task_updates',
'         where task_id = :P12_TASK_ID;',
'',
'        if :REQUEST = ''POST_UPDATE''',
'           and nullif(trim(:P12_UPDATE_TEXT), '''') is not null then',
'            l_post_update_yn := ''Y'';',
'        end if;',
'',
'        if l_update_count = 0 and l_post_update_yn = ''N'' then',
'            raise_application_error(-20001, ''Add at least one update before completing this task.'');',
'        end if;',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE_TASK,POST_UPDATE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>9990001200000910
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882314404588234)
,p_process_sequence=>45
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Update'
,p_static_id=>'save-update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_update_text varchar2(4000) := trim(:P12_EDIT_UPDATE_TEXT);',
'begin',
'    if :P12_EDIT_UPDATE_ID is null then',
'        raise_application_error(-20001, ''Select an update to edit.'');',
'    end if;',
'',
'    if l_update_text is null then',
'        raise_application_error(-20001, ''Enter update text before saving.'');',
'    end if;',
'',
'    update tsk_task_updates',
'       set update_text = l_update_text',
'     where update_id = :P12_EDIT_UPDATE_ID',
'       and task_id = :P12_TASK_ID;',
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
'        :P12_EDIT_UPDATE_ID,',
'        :P12_TASK_ID,',
'        ''UPDATE'',',
'        ''Update edited: '' || l_update_text,',
'        :APP_USER',
'    );',
'',
'    :P12_EDIT_UPDATE_ID := null;',
'    :P12_EDIT_UPDATE_TEXT := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(32882314404588229)
,p_process_success_message=>'Update saved'
,p_internal_uid=>9990001200000211
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39948368524829870)
,p_process_sequence=>12
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Audit Display Values'
,p_static_id=>'set-audit-display-values'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    select u.display_name',
'      into :P12_SUBMITTED_BY',
'      from tsk_team_members tm',
'      join tsk_users u',
'        on u.user_id = tm.user_id',
'     where tm.team_member_id = :P12_OWNER_MEMBER_ID;',
'exception',
'    when no_data_found then',
'        :P12_SUBMITTED_BY := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>17056055320241847
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39966939888982626)
,p_process_sequence=>13
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Current Assignees'
,p_static_id=>'set-current-assignees'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select listagg(ta.team_member_id, '':'') within group (order by u.display_name)',
'  into :P12_ASSIGNEES',
'  from tsk_task_assignees ta',
'  join tsk_team_members tm',
'    on tm.team_member_id = ta.team_member_id',
'  join tsk_users u',
'    on u.user_id = tm.user_id',
' where ta.task_id = :P12_TASK_ID',
'   and ta.active_yn = ''Y'';'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>17074626684394603
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882314404588325)
,p_process_sequence=>14
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Current Topic Groups'
,p_static_id=>'set-current-topic-groups'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select listagg(ttg.topic_group_id, '':'') within group (order by tg.topic_name)',
'  into :P12_TOPIC_GROUP_IDS',
'  from tsk_task_topic_groups ttg',
'  join tsk_topic_groups tg',
'    on tg.topic_group_id = ttg.topic_group_id',
' where ttg.task_id = :P12_TASK_ID;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>9990001200000302
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39967098755982627)
,p_process_sequence=>15
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Sync Assignees'
,p_static_id=>'sync-assignees'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'                declare',
'                    l_added_count   pls_integer := 0;',
'                    l_removed_count pls_integer := 0;',
'                    l_previous_assignee_ids varchar2(32767);',
'                    l_previous_assignees varchar2(32767);',
'                    l_new_assignees      varchar2(32767);',
'                    l_task_title         tsk_tasks.title%type;',
'                    l_task_key           tsk_tasks.task_key%type;',
'                    l_task_url           varchar2(4000);',
'                begin',
'                    select listagg(u.display_name, '', '') within group (order by u.display_name)',
'                      into l_previous_assignees',
'                      from tsk_task_assignees ta',
'                      join tsk_team_members tm',
'                        on tm.team_member_id = ta.team_member_id',
'                      join tsk_users u',
'                        on u.user_id = tm.user_id',
'                     where ta.task_id = :P12_TASK_ID',
'                       and ta.active_yn = ''Y''',
'                       and tm.active_yn = ''Y''',
'                       and u.active_yn = ''Y'';',
'                ',
'                    select listagg(ta.team_member_id, '':'') within group (order by ta.team_member_id)',
'                      into l_previous_assignee_ids',
'                      from tsk_task_assignees ta',
'                     where ta.task_id = :P12_TASK_ID',
'                       and ta.active_yn = ''Y'';',
'                ',
'                    select listagg(u.display_name, '', '') within group (order by u.display_name)',
'                      into l_new_assignees',
'                      from (',
'                            select distinct to_number(column_value) as team_member_id',
'                              from table(apex_string.split(nvl(:P12_ASSIGNEES, ''~''), '':''))',
'                             where regexp_like(column_value, ''^[0-9]+$'')',
'                           ) s',
'                      join tsk_team_members tm',
'                        on tm.team_member_id = s.team_member_id',
'                      join tsk_users u',
'                        on u.user_id = tm.user_id',
'                     where tm.active_yn = ''Y''',
'                       and u.active_yn = ''Y'';',
'                ',
'                    select task_key,',
'                           title',
'                      into l_task_key,',
'                           l_task_title',
'                      from tsk_tasks',
'                     where task_id = :P12_TASK_ID;',
'                ',
'                    l_task_url := apex_mail.get_instance_url ||',
'                                  apex_page.get_url(',
'                                      p_application => :APP_ID,',
'                                      p_page        => 12,',
'                                      p_session     => 0,',
'                                      p_clear_cache => ''12'',',
'                                      p_items       => ''P12_TASK_ID'',',
'                                      p_values      => :P12_TASK_ID,',
'                                      p_plain_url   => true',
'                                  );',
'                ',
'                    update tsk_task_assignees ta',
'                       set active_yn = ''N'',',
'                           unassigned_on = trunc(sysdate),',
'                           updated_at = systimestamp,',
'                           updated_by = :APP_USER',
'                     where ta.task_id = :P12_TASK_ID',
'                       and ta.active_yn = ''Y''',
'                       and not exists (',
'                               select 1',
'                                 from table(apex_string.split(nvl(:P12_ASSIGNEES, ''~''), '':'')) s',
'                                where s.column_value = to_char(ta.team_member_id)',
'                           );',
'                ',
'                    l_removed_count := sql%rowcount;',
'                ',
'                    for m in (',
'                        select distinct to_number(column_value) as team_member_id',
'                          from table(apex_string.split(:P12_ASSIGNEES, '':''))',
'                         where regexp_like(column_value, ''^[0-9]+$'')',
'                    ) loop',
'                        update tsk_task_assignees',
'                           set active_yn = ''Y'',',
'                               unassigned_on = null,',
'                               updated_at = systimestamp,',
'                               updated_by = :APP_USER',
'                         where task_id = :P12_TASK_ID',
'                           and team_member_id = m.team_member_id',
'                           and active_yn = ''N'';',
'                ',
'                        if sql%rowcount = 0 then',
'                            insert into tsk_task_assignees (',
'                                task_id,',
'                                team_member_id,',
'                                assignment_role,',
'                                allocated_pct',
'                            )',
'                            select :P12_TASK_ID,',
'                                   tm.team_member_id,',
'                                   tm.role_name,',
'                                   null',
'                              from tsk_team_members tm',
'                             where tm.team_member_id = m.team_member_id',
'                               and not exists (',
'                                       select 1',
'                                         from tsk_task_assignees ta',
'                                        where ta.task_id = :P12_TASK_ID',
'                                          and ta.team_member_id = m.team_member_id',
'                                   );',
'                ',
'                            l_added_count := l_added_count + sql%rowcount;',
'                        else',
'                            l_added_count := l_added_count + sql%rowcount;',
'                        end if;',
'                    end loop;',
'                ',
'                    if l_added_count > 0 or l_removed_count > 0 then',
'                        insert into tsk_change_log (',
'                            entity_name,',
'                            entity_pk,',
'                            task_id,',
'                            change_action,',
'                            change_note,',
'                            changed_by',
'                        ) values (',
'                            ''TASK'',',
'                            :P12_TASK_ID,',
'                            :P12_TASK_ID,',
'                            ''UPDATE'',',
'                            ''Assignees updated: '' || l_added_count || '' added, '' || l_removed_count || '' removed'',',
'                            :APP_USER',
'                        );',
'                ',
'                        if nvl(l_previous_assignees, ''Not Assigned'') <> nvl(l_new_assignees, ''Not Assigned'') then',
'                            for r in (',
'                                select distinct u.email,',
'                                       u.display_name',
'                                  from (',
'                                        select distinct to_number(column_value) as team_member_id',
'                                          from table(apex_string.split(nvl(l_previous_assignee_ids, ''~''), '':''))',
'                                         where regexp_like(column_value, ''^[0-9]+$'')',
'                                        union',
'                                        select distinct to_number(column_value) as team_member_id',
'                                          from table(apex_string.split(nvl(:P12_ASSIGNEES, ''~''), '':''))',
'                                         where regexp_like(column_value, ''^[0-9]+$'')',
'                                       ) recipients',
'                                  join tsk_team_members tm',
'                                    on tm.team_member_id = recipients.team_member_id',
'                                  join tsk_users u',
'                                    on u.user_id = tm.user_id',
'                                 where tm.active_yn = ''Y''',
'                                   and u.active_yn = ''Y''',
'                                   and u.email is not null',
'                            ) loop',
'                                apex_mail.send(',
'                                    p_to        => r.email,',
'                                    p_from      => ''no-reply@oracle.com'',',
'                                    p_subj      => ''Task has been reassigned'',',
'                                    p_body      => ''The task "'' || l_task_title || ''" has been reassigned from '' ||',
'                                                   nvl(l_previous_assignees, ''Not Assigned'') ||',
'                                                   '' to '' || nvl(l_new_assignees, ''Not Assigned'') || ''.'' ||',
'                                                   chr(10) || chr(10) ||',
'                                                   ''Open Task: '' || l_task_url,',
'                                    p_body_html => ''<div style="font-family:Arial,sans-serif;color:#172033;line-height:1.45">'' ||',
'                                                   ''<p>The task <a href="'' || apex_escape.html_attribute(l_task_url) || ''">'' ||',
'                                                   apex_escape.html(l_task_key || '' - '' || l_task_title) ||',
'                                                   ''</a> has been reassigned from <strong>'' ||',
'                                                   apex_escape.html(nvl(l_previous_assignees, ''Not Assigned'')) ||',
'                                                   ''</strong> to <strong>'' ||',
'                                                   apex_escape.html(nvl(l_new_assignees, ''Not Assigned'')) ||',
'                                                   ''</strong>.</p>'' ||',
'                                                   ''<p><a href="'' || apex_escape.html_attribute(l_task_url) || ''">Open Task</a></p>'' ||',
'                                                   ''</div>''',
'                                );',
'                            end loop;',
'                ',
'                            apex_mail.push_queue;',
'                        end if;',
'                    end if;',
'                end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE_TASK,POST_UPDATE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>17074785551394604
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9990001200001002)
,p_process_sequence=>14
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Create Manual Topics'
,p_static_id=>'create-manual-topics'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_topic_group_id tsk_topic_groups.topic_group_id%type;',
'    l_topic_ids      varchar2(32767) := :P12_TOPIC_GROUP_IDS;',
'begin',
'    for manual_topic in (',
'        select distinct trim(column_value) as topic_name',
'          from table(apex_string.split(:P12_TOPIC_GROUP_MANUAL, '':''))',
'         where trim(column_value) is not null',
'    ) loop',
'        begin',
'            insert into tsk_topic_groups (',
'                topic_name,',
'                active_yn',
'            ) values (',
'                manual_topic.topic_name,',
'                ''Y''',
'            )',
'            returning topic_group_id into l_topic_group_id;',
'        exception',
'            when dup_val_on_index then',
'                select topic_group_id',
'                  into l_topic_group_id',
'                  from tsk_topic_groups',
'                 where upper(topic_name) = upper(manual_topic.topic_name)',
'                 fetch first 1 row only;',
'',
'                update tsk_topic_groups',
'                   set active_yn = ''Y''',
'                 where topic_group_id = l_topic_group_id;',
'        end;',
'',
'        if instr('':'' || nvl(l_topic_ids, '''') || '':'', '':'' || l_topic_group_id || '':'') = 0 then',
'            l_topic_ids :=',
'                case',
'                    when l_topic_ids is null then to_char(l_topic_group_id)',
'                    else l_topic_ids || '':'' || l_topic_group_id',
'                end;',
'        end if;',
'    end loop;',
'',
'    :P12_TOPIC_GROUP_IDS := l_topic_ids;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE_TASK,POST_UPDATE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>9990001200001002
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(32882314404588326)
,p_process_sequence=>16
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Sync Topic Groups'
,p_static_id=>'sync-topic-groups'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_added_count   pls_integer := 0;',
'    l_removed_count pls_integer := 0;',
'    l_primary_topic_group_id tsk_topic_groups.topic_group_id%type;',
'begin',
'    delete from tsk_task_topic_groups ttg',
'     where ttg.task_id = :P12_TASK_ID',
'       and not exists (',
'               select 1',
'                 from table(apex_string.split(nvl(:P12_TOPIC_GROUP_IDS, ''~''), '':'')) s',
'                where s.column_value = to_char(ttg.topic_group_id)',
'           );',
'',
'    l_removed_count := sql%rowcount;',
'',
'    for tg in (',
'        select distinct to_number(column_value) as topic_group_id',
'          from table(apex_string.split(:P12_TOPIC_GROUP_IDS, '':''))',
'         where regexp_like(column_value, ''^[0-9]+$'')',
'    ) loop',
'        insert into tsk_task_topic_groups (',
'            task_id,',
'            topic_group_id',
'        )',
'        select :P12_TASK_ID,',
'               tg.topic_group_id',
'          from dual',
'         where not exists (',
'                   select 1',
'                     from tsk_task_topic_groups existing',
'                    where existing.task_id = :P12_TASK_ID',
'                      and existing.topic_group_id = tg.topic_group_id',
'               );',
'',
'        l_added_count := l_added_count + sql%rowcount;',
'    end loop;',
'',
'    select min(to_number(column_value))',
'      into l_primary_topic_group_id',
'      from table(apex_string.split(:P12_TOPIC_GROUP_IDS, '':''))',
'     where regexp_like(column_value, ''^[0-9]+$'');',
'',
'    update tsk_tasks',
'       set topic_group_id = l_primary_topic_group_id',
'     where task_id = :P12_TASK_ID;',
'',
'    if l_added_count > 0 or l_removed_count > 0 then',
'        insert into tsk_change_log (',
'            entity_name,',
'            entity_pk,',
'            task_id,',
'            change_action,',
'            change_note,',
'            changed_by',
'        ) values (',
'            ''TASK'',',
'            :P12_TASK_ID,',
'            :P12_TASK_ID,',
'            ''UPDATE'',',
'            ''Topic groups updated: '' || l_added_count || '' added, '' || l_removed_count || '' removed'',',
'            :APP_USER',
'        );',
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'SAVE_TASK,POST_UPDATE'
,p_process_when_type=>'REQUEST_IN_CONDITION'
,p_internal_uid=>9990001200000303
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(39929452759645011)
,p_process_sequence=>25
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Upload File'
,p_static_id=>'upload-file'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    l_file_count pls_integer := 0;',
'    l_file_id    tsk_task_files.file_id%type;',
'    l_file_name  tsk_task_files.file_name%type;',
'begin',
'    if :P12_TASK_FILE is null then',
'        raise_application_error(-20001, ''Choose a file before adding it.'');',
'    end if;',
'',
'    for f in (',
'        select name,',
'               filename,',
'               mime_type,',
'               blob_content',
'          from apex_application_temp_files',
'         where name in (',
'                   select column_value',
'                     from table(apex_string.split(:P12_TASK_FILE, '':''))',
'               )',
'    ) loop',
'        l_file_name := coalesce(nullif(trim(:P12_FILE_DISPLAY_NAME), ''''), f.filename);',
'',
'        insert into tsk_task_files (',
'            task_id,',
'            file_display_name,',
'            file_description,',
'            file_name,',
'            mime_type,',
'            file_blob,',
'            file_size,',
'            uploaded_by,',
'            updated_by',
'        ) values (',
'            :P12_TASK_ID,',
'            nullif(trim(:P12_FILE_DISPLAY_NAME), ''''),',
'            :P12_FILE_DESCRIPTION,',
'            f.filename,',
'            f.mime_type,',
'            f.blob_content,',
'            dbms_lob.getlength(f.blob_content),',
'            :APP_USER,',
'            :APP_USER',
'        )',
'        returning file_id',
'             into l_file_id;',
'',
'        insert into tsk_change_log (',
'            entity_name,',
'            entity_pk,',
'            task_id,',
'            change_action,',
'            change_note,',
'            changed_by',
'        ) values (',
'            ''TASK_FILE'',',
'            l_file_id,',
'            :P12_TASK_ID,',
'            ''UPDATE'',',
'            ''File added: '' || l_file_name,',
'            :APP_USER',
'        );',
'',
'        delete from apex_application_temp_files',
'         where name = f.name;',
'',
'        l_file_count := l_file_count + 1;',
'    end loop;',
'',
'    if l_file_count = 0 then',
'        raise_application_error(-20001, ''The selected file was not found in temporary storage.'');',
'    end if;',
'',
'    :P12_TASK_FILE := null;',
'    :P12_FILE_DISPLAY_NAME := null;',
'    :P12_FILE_DESCRIPTION := null;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(39929133519645010)
,p_process_success_message=>'File added'
,p_internal_uid=>17037139555056988
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
