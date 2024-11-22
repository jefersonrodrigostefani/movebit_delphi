object dtm_geral: Tdtm_geral
  Height = 466
  Width = 565
  PixelsPerInch = 120
  object qry_pesquisa: TFDQuery
    Connection = dtm_banco.FDConnection
    Left = 80
    Top = 40
  end
  object qry_psq_ranking: TFDQuery
    Connection = dtm_banco.FDConnection
    Left = 232
    Top = 40
  end
end
