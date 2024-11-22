inherited frm_cad_cliente: Tfrm_cad_cliente
  ClientHeight = 333
  ClientWidth = 632
  ExplicitWidth = 650
  ExplicitHeight = 380
  TextHeight = 16
  inherited pnl_frm_cad: TPanel
    Width = 632
    Height = 283
    ParentCtl3D = False
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
      Top = 83
      Width = 42
      Height = 16
      Caption = 'Nome'
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
      Top = 115
      Width = 54
      Height = 16
      Caption = 'Apelido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object lbl_tpo_reg: TLabel
      Left = 24
      Top = 54
      Width = 86
      Height = 16
      Caption = 'Tipo Pessoa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object lbl_end_reg: TLabel
      Left = 24
      Top = 181
      Width = 68
      Height = 16
      Caption = 'Endere'#231'o'
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
      Top = 242
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
    object lbl_tel_reg: TLabel
      Left = 24
      Top = 211
      Width = 62
      Height = 16
      Caption = 'Telefone'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = []
    end
    object lbl_doc_reg: TLabel
      Left = 24
      Top = 147
      Width = 28
      Height = 16
      Caption = 'CPF'
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
      DataField = 'CD_CLIENTE'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 0
      StyleElements = []
    end
    object edt_nom_reg: TDBEdit
      Left = 144
      Top = 81
      Width = 449
      Height = 22
      Ctl3D = False
      DataField = 'NM_CLIENTE'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 2
      StyleElements = []
    end
    object edt_ape_reg: TDBEdit
      Left = 144
      Top = 112
      Width = 449
      Height = 22
      Ctl3D = False
      DataField = 'AP_CLIENTE'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 3
      StyleElements = []
    end
    object cmb_tpo_reg: TDBComboBox
      Left = 144
      Top = 50
      Width = 153
      Height = 24
      Style = csDropDownList
      Ctl3D = False
      DataField = 'TP_CLIENTE'
      DataSource = dts_cad_reg
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica')
      ParentCtl3D = False
      TabOrder = 1
      StyleElements = []
      OnChange = cmb_tpo_regChange
    end
    object edt_end_reg: TDBEdit
      Left = 144
      Top = 178
      Width = 449
      Height = 22
      Ctl3D = False
      DataField = 'ED_CLIENTE'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 5
      StyleElements = []
    end
    object cmb_atv_reg: TDBComboBox
      Left = 144
      Top = 238
      Width = 153
      Height = 24
      Style = csDropDownList
      Ctl3D = False
      DataField = 'IN_CLIENTE'
      DataSource = dts_cad_reg
      Items.Strings = (
        'Ativo'
        'Inativo')
      ParentCtl3D = False
      TabOrder = 7
      StyleElements = []
    end
    object edt_tel_reg: TDBEdit
      Left = 144
      Top = 208
      Width = 153
      Height = 22
      Ctl3D = False
      DataField = 'FN_CLIENTE'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 6
      StyleElements = []
    end
    object edt_doc_reg: TDBEdit
      Left = 144
      Top = 144
      Width = 153
      Height = 22
      Ctl3D = False
      DataField = 'NR_CLIENTE'
      DataSource = dts_cad_reg
      ParentCtl3D = False
      TabOrder = 4
      StyleElements = []
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
    DataSet = dtm_cliente.qry_cad_cliente
    Left = 528
    Top = 16
  end
end
