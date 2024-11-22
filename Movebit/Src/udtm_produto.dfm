object dtm_produto: Tdtm_produto
  Height = 486
  Width = 553
  PixelsPerInch = 120
  object qry_psq_produto: TFDQuery
    Connection = dtm_banco.FDConnection
    Left = 80
    Top = 48
  end
  object qry_cad_produto: TFDQuery
    Connection = dtm_banco.FDConnection
    UpdateOptions.AssignedValues = [uvCheckRequired, uvCheckReadOnly]
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    Left = 80
    Top = 168
  end
end
