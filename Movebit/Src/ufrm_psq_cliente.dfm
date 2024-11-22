inherited frm_psq_cliente: Tfrm_psq_cliente
  Caption = 'frm_psq_cliente'
  TextHeight = 16
  inherited pnl_btn_frm: TPanel
    inherited cmb_psq_reg: TComboBox
      ItemIndex = 1
      Text = 'Descri'#231#227'o'
      OnChange = cmb_psq_regChange
      Items.Strings = (
        'C'#243'digo'
        'Descri'#231#227'o')
    end
    inherited edt_psq_reg: TEdit
      OnChange = edt_psq_regChange
    end
  end
  inherited dbg_psq_reg: TDBGrid
    ParentFont = False
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CD_CLIENTE'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NM_CLIENTE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 350
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IN_CLIENTE'
        Title.Alignment = taCenter
        Title.Caption = 'Status'
        Width = 100
        Visible = True
      end>
  end
  inherited dts_psq_reg: TDataSource
    DataSet = dtm_cliente.qry_psq_cliente
  end
end
