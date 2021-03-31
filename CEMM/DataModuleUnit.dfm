object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 457
  Width = 319
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrDefault
    Left = 88
    Top = 10
  end
  object con_1: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      
        'Database=D:\Dev\varcoded\ConanExiles\Conan-Exiles-Mod-Manager\CE' +
        'MM\Win32\Debug\cemm.sfp'
      'DateTimeFormat=DateTime'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    UpdateTransaction = Transaction_1
    Left = 32
    Top = 8
  end
  object query_mods: TFDQuery
    Connection = con_1
    Transaction = Transaction_1
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
  object Query_test: TFDQuery
    Connection = con_1
    Transaction = Transaction_1
    SQL.Strings = (
      'select * from test')
    Left = 240
    Top = 224
  end
  object ds_query_test: TDataSource
    AutoEdit = False
    DataSet = Query_test
    Left = 232
    Top = 288
  end
end
