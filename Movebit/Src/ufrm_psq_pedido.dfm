inherited frm_psq_pedido: Tfrm_psq_pedido
  TextHeight = 16
  inherited pnl_btn_frm: TPanel
    inherited cmb_psq_reg: TComboBox
      Width = 161
      ItemIndex = 1
      Text = 'Descri'#231#227'o do Pedido'
      OnChange = cmb_psq_regChange
      Items.Strings = (
        'N'#186' do Pedido'
        'Descri'#231#227'o do Pedido')
      ExplicitWidth = 161
    end
    inherited edt_psq_reg: TEdit
      Left = 575
      OnChange = edt_psq_regChange
      ExplicitLeft = 575
    end
  end
  inherited dbg_psq_reg: TDBGrid
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NR_PEDIDO'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' do Pedido'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Verdana'
        Title.Font.Style = [fsBold]
        Width = 125
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DT_PEDIDO'
        Title.Alignment = taCenter
        Title.Caption = 'Data do Pedido'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Verdana'
        Title.Font.Style = [fsBold]
        Width = 125
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NM_PEDIDO'
        Title.Caption = 'Descri'#231#227'o do Pedido'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Verdana'
        Title.Font.Style = [fsBold]
        Width = 350
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QT_PEDIDO'
        Title.Alignment = taCenter
        Title.Caption = 'Qtde do Pedido'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Verdana'
        Title.Font.Style = [fsBold]
        Width = 125
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VL_PEDIDO'
        Title.Alignment = taCenter
        Title.Caption = 'Valor do Pedido'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Verdana'
        Title.Font.Style = [fsBold]
        Width = 125
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IN_PEDIDO'
        Title.Alignment = taCenter
        Title.Caption = 'Status'
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Verdana'
        Title.Font.Style = [fsBold]
        Width = 100
        Visible = True
      end>
  end
  inherited dts_psq_reg: TDataSource
    DataSet = dtm_pedido.qry_psq_pedido
  end
end
