object dtm_cliente: Tdtm_cliente
  Height = 455
  Width = 616
  PixelsPerInch = 120
  object qry_psq_cliente: TFDQuery
    Connection = dtm_banco.FDConnection
    Left = 80
    Top = 72
  end
  object qry_cad_cliente: TFDQuery
    Connection = dtm_banco.FDConnection
    UpdateOptions.AssignedValues = [uvCheckRequired, uvCheckReadOnly]
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'SELECT T1.CD_CLIENTE,'
      '       T1.NM_CLIENTE,'
      '       T1.AP_CLIENTE,'
      '       T1.TP_CLIENTE,'
      '       T1.ED_CLIENTE,'
      '       T1.IN_CLIENTE'
      'FROM CLIENTE T1'
      'WHERE 1=1'
      '  AND T1.CD_CLIENTE = :CD_CLIENTE')
    Left = 80
    Top = 176
    ParamData = <
      item
        Name = 'CD_CLIENTE'
        ParamType = ptInput
      end>
  end
end
