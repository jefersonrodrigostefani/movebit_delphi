inherited frm_cad_produto: Tfrm_cad_produto
  ClientHeight = 333
  ClientWidth = 632
  ExplicitWidth = 650
  ExplicitHeight = 380
  TextHeight = 16
  inherited pnl_frm_cad: TPanel
    Width = 632
    Height = 283
    ExplicitWidth = 632
    ExplicitHeight = 283
    object lbl_cid_reg: TLabel
      Left = 24
      Top = 24
      Width = 50
      Height = 16
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object lbl_nom_reg: TLabel
      Left = 24
      Top = 56
      Width = 71
      Height = 16
      Caption = 'Descri'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object lbl_ape_reg: TLabel
      Left = 24
      Top = 88
      Width = 44
      Height = 16
      Caption = 'Marca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object lbl_atv_reg: TLabel
      Left = 24
      Top = 149
      Width = 47
      Height = 16
      Caption = 'Status'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object lbl_vlr_reg: TLabel
      Left = 24
      Top = 118
      Width = 63
      Height = 16
      Caption = 'Pre'#231'o R$'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object edt_cid_reg: TDBEdit
      Left = 144
      Top = 21
      Width = 75
      Height = 22
      TabStop = False
      Color = clSilver
      Ctl3D = False
      DataField = 'CD_PRODUTO'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      StyleElements = []
    end
    object edt_nom_reg: TDBEdit
      Left = 144
      Top = 54
      Width = 449
      Height = 22
      Ctl3D = False
      DataField = 'NM_PRODUTO'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 1
      StyleElements = []
    end
    object edt_ape_reg: TDBEdit
      Left = 144
      Top = 85
      Width = 449
      Height = 22
      Ctl3D = False
      DataField = 'AP_PRODUTO'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 2
      StyleElements = []
    end
    object cmb_atv_reg: TDBComboBox
      Left = 144
      Top = 145
      Width = 121
      Height = 24
      Style = csDropDownList
      Ctl3D = False
      DataField = 'IN_PRODUTO'
      DataSource = dts_cad_reg
      Items.Strings = (
        'Ativo'
        'Inativo')
      ParentCtl3D = False
      TabOrder = 4
      StyleElements = []
    end
    object edt_vlr_reg: TDBEdit
      Left = 144
      Top = 115
      Width = 121
      Height = 22
      Ctl3D = False
      DataField = 'VL_PRODUTO'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 3
      StyleElements = []
      OnKeyPress = edt_vlr_regKeyPress
    end
  end
  inherited pnl_btn_cad: TPanel
    Top = 283
    Width = 632
    ExplicitTop = 283
    ExplicitWidth = 632
    inherited btn_add_reg: TSpeedButton
      Left = 360
      ExplicitLeft = 360
    end
    inherited btn_cnc_reg: TSpeedButton
      Left = 489
      ExplicitLeft = 489
    end
  end
  object dts_cad_reg: TDataSource
    DataSet = dtm_produto.qry_cad_produto
    Left = 496
    Top = 336
  end
end
