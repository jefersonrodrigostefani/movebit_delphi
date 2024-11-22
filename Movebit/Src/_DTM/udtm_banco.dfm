object dtm_banco: Tdtm_banco
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 358
  Width = 446
  PixelsPerInch = 120
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 184
    Top = 48
  end
  object FDTransaction: TFDTransaction
    Options.Isolation = xiReadCommitted
    Connection = FDConnection
    Left = 184
    Top = 136
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 184
    Top = 232
  end
end
