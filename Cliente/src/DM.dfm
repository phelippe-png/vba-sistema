object SisDataModule: TSisDataModule
  OldCreateOrder = False
  Height = 150
  Width = 215
  object fdConnection: TFDConnection
    Params.Strings = (
      'Database=vba_db'
      'User_Name=postgres'
      'Password=vba8312'
      'Server=127.0.0.1'
      'DriverID=PG')
    Left = 88
    Top = 40
  end
end
