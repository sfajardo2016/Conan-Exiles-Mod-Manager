object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 336
  Width = 275
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrDefault
    Left = 88
    Top = 10
  end
  object con_1: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      
        'Database=D:\dev\varcoded\TestsXE6\ConanSP Tools\CECTv1.1\Win32\D' +
        'ebug\cect.sfp'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object query_mods: TFDQuery
    Connection = con_1
    SQL.Strings = (
      'select * from mods'
      'order by modname')
    Left = 24
    Top = 72
  end
  object ds_query_mods: TDataSource
    AutoEdit = False
    DataSet = query_mods
    Left = 16
    Top = 136
  end
  object query_INI: TFDQuery
    Connection = con_1
    Transaction = Transaction_1
    Left = 32
    Top = 248
  end
  object Transaction_1: TFDTransaction
    Connection = con_1
    Left = 32
    Top = 192
  end
  object query_modset: TFDQuery
    Connection = con_1
    SQL.Strings = (
      'select * from modset')
    Left = 104
    Top = 72
  end
  object ds_query_modset: TDataSource
    AutoEdit = False
    DataSet = query_modset
    Left = 104
    Top = 128
  end
  object Query_settings: TFDQuery
    Connection = con_1
    SQL.Strings = (
      'select * from settings order by value')
    Left = 176
    Top = 72
  end
end
