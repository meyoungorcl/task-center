set define off verify off feedback on
whenever sqlerror exit sql.sqlcode rollback

prompt Adding page 12 audit display-only items

begin
    wwv_flow_imp.import_begin(
        p_version_yyyy_mm_dd    => '2026.03.30',
        p_release               => '26.1.0',
        p_default_workspace_id  => 7097755211213275,
        p_default_application_id=> 132,
        p_default_id_offset     => 0,
        p_default_owner         => 'WKSP_DBAPPDEV'
    );
end;
/

declare
    function item_exists(p_item_name in varchar2) return boolean is
        l_count number;
    begin
        select count(*)
          into l_count
          from apex_application_page_items
         where application_id = 132
           and page_id = 12
           and item_name = p_item_name;

        return l_count > 0;
    end;
begin
    if not item_exists('P12_CREATED_AT') then
        wwv_flow_imp_page.create_page_item(
            p_flow_step_id=>12,
            p_name=>'P12_CREATED_AT',
            p_source_data_type=>'TIMESTAMP',
            p_is_query_only=>true,
            p_item_sequence=>30,
            p_item_plug_id=>wwv_flow_imp.id(17052815940219869),
            p_item_source_plug_id=>wwv_flow_imp.id(16522614105501996),
            p_prompt=>'Created At',
            p_source=>'CREATED_AT',
            p_display_as=>'NATIVE_DISPLAY_ONLY',
            p_format_mask=>'DD-MON-YYYY HH24:MI',
            p_colspan=>6,
            p_field_template=>1610598304472262251,
            p_item_template_options=>'#DEFAULT#',
            p_is_persistent=>'N',
            p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
                'based_on', 'VALUE',
                'format', 'PLAIN',
                'send_on_page_submit', 'N',
                'show_line_breaks', 'Y')).to_clob
        );
    end if;

    if not item_exists('P12_CREATED_BY') then
        wwv_flow_imp_page.create_page_item(
            p_flow_step_id=>12,
            p_name=>'P12_CREATED_BY',
            p_source_data_type=>'VARCHAR2',
            p_is_query_only=>true,
            p_item_sequence=>40,
            p_item_plug_id=>wwv_flow_imp.id(17052815940219869),
            p_item_source_plug_id=>wwv_flow_imp.id(16522614105501996),
            p_prompt=>'Created By',
            p_source=>'CREATED_BY',
            p_display_as=>'NATIVE_DISPLAY_ONLY',
            p_begin_on_new_line=>'N',
            p_colspan=>6,
            p_field_template=>1610598304472262251,
            p_item_template_options=>'#DEFAULT#',
            p_is_persistent=>'N',
            p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
                'based_on', 'VALUE',
                'format', 'PLAIN',
                'send_on_page_submit', 'N',
                'show_line_breaks', 'Y')).to_clob
        );
    end if;

    if not item_exists('P12_UPDATED_AT') then
        wwv_flow_imp_page.create_page_item(
            p_flow_step_id=>12,
            p_name=>'P12_UPDATED_AT',
            p_source_data_type=>'TIMESTAMP',
            p_is_query_only=>true,
            p_item_sequence=>50,
            p_item_plug_id=>wwv_flow_imp.id(17052815940219869),
            p_item_source_plug_id=>wwv_flow_imp.id(16522614105501996),
            p_prompt=>'Updated At',
            p_source=>'UPDATED_AT',
            p_display_as=>'NATIVE_DISPLAY_ONLY',
            p_format_mask=>'DD-MON-YYYY HH24:MI',
            p_colspan=>6,
            p_field_template=>1610598304472262251,
            p_item_template_options=>'#DEFAULT#',
            p_is_persistent=>'N',
            p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
                'based_on', 'VALUE',
                'format', 'PLAIN',
                'send_on_page_submit', 'N',
                'show_line_breaks', 'Y')).to_clob
        );
    end if;

    if not item_exists('P12_UPDATED_BY') then
        wwv_flow_imp_page.create_page_item(
            p_flow_step_id=>12,
            p_name=>'P12_UPDATED_BY',
            p_source_data_type=>'VARCHAR2',
            p_is_query_only=>true,
            p_item_sequence=>60,
            p_item_plug_id=>wwv_flow_imp.id(17052815940219869),
            p_item_source_plug_id=>wwv_flow_imp.id(16522614105501996),
            p_prompt=>'Updated By',
            p_source=>'UPDATED_BY',
            p_display_as=>'NATIVE_DISPLAY_ONLY',
            p_begin_on_new_line=>'N',
            p_colspan=>6,
            p_field_template=>1610598304472262251,
            p_item_template_options=>'#DEFAULT#',
            p_is_persistent=>'N',
            p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
                'based_on', 'VALUE',
                'format', 'PLAIN',
                'send_on_page_submit', 'N',
                'show_line_breaks', 'Y')).to_clob
        );
    end if;
end;
/

begin
    wwv_flow_imp.import_end;
end;
/

commit;

prompt Page 12 audit display-only items complete.
