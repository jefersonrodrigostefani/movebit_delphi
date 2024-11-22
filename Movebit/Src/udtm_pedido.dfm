object dtm_pedido: Tdtm_pedido
  Height = 462
  Width = 581
  PixelsPerInch = 120
  object qry_psq_pedido: TFDQuery
    Connection = dtm_banco.FDConnection
    Left = 144
    Top = 48
  end
  object qry_cad_pedido: TFDQuery
    Connection = dtm_banco.FDConnection
    Left = 144
    Top = 160
  end
  object cds_cad_pedido: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 312
    Top = 136
  end
end
