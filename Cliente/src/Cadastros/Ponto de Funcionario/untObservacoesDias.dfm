object formObservacoesDias: TformObservacoesDias
  Left = 0
  Top = 0
  Caption = 'Observa'#231#245'es dos dias de trabalho'
  ClientHeight = 367
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Product Sans'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    622
    367)
  PixelsPerInch = 96
  TextHeight = 19
  object lblFuncionario: TLabel
    Left = 171
    Top = 8
    Width = 363
    Height = 70
    AutoSize = False
    Caption = 'Selecionar funcion'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -17
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object btnBuscarFuncionario: TSpeedButton
    Left = 6
    Top = 5
    Width = 159
    Height = 29
    Cursor = crHandPoint
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    Caption = 'Buscar funcion'#225'rio'
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFE6E6E6303030989898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA292929000000A7A7A7FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEEEE2F2F
      2F000000878787FFFFFFFFFFFFFFFFFFFFFFFFF2F2F28C8C8C57575727272733
      33335D5D5DC7C7C7F2F2F23636360000007F7F7FFFFFFFFFFFFFFFFFFFFFFFFF
      BCBCBC1F1F1F0000000404042E2E2E1616160000000000001717170000007777
      77FFFFFFFFFFFFFFFFFFFFFFFFC9C9C90303030D0D0D979797F6F6F6FFFFFFFF
      FFFFD4D4D4414141000000222222FFFFFFFFFFFFFFFFFFFFFFFFF8F8F82A2A2A
      070707D1D1D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE575757000000ABAB
      ABFFFFFFFFFFFFFFFFFFB0B0B0000000818181FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFEBEBEB0F0F0F2F2F2FFFFFFFFFFFFFFFFFFF7C7C7C000000
      D2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4A4A4A0404
      04F9F9F9FFFFFFFFFFFF545454010101F9F9F9FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF737373000000DBDBDBFFFFFFFFFFFF787878000000
      D6D6D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4E4E4E0606
      06FAFAFAFFFFFFFFFFFFABABAB0000008D8D8DFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF1F1F1141414333333FFFFFFFFFFFFFFFFFFF3F3F3202020
      0B0B0BDBDBDBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6464640000009C9C
      9CFFFFFFFFFFFFFFFFFFFFFFFFBFBFBF010101151515ADADADFFFFFFFFFFFFFF
      FFFFE8E8E8535353000000494949FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      ACACAC1414140000001010103F3F3F2828280202020000005A5A5AEFEFEFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8E87474743F3F3F0F0F0F26
      2626595959AFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ParentFont = False
    OnClick = btnBuscarFuncionarioClick
  end
  object btnSave: TPanel
    Left = 540
    Top = 5
    Width = 74
    Height = 30
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Salvar'
    Color = 489483
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TPanel
    Left = 540
    Top = 39
    Width = 74
    Height = 30
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Cancelar'
    Color = clRed
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object sbxContainerObservacao: TScrollBox
    Left = 0
    Top = 85
    Width = 623
    Height = 308
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clWindow
    ParentColor = False
    TabOrder = 2
    DesignSize = (
      623
      308)
    object cvCalendario: TCalendarView
      Left = 359
      Top = -1
      Width = 263
      Height = 283
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      BorderStyle = bsNone
      Date = 45032.000000000000000000
      FocusedColor = 14803425
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Product Sans'
      Font.Style = []
      HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      HeaderInfo.DaysOfWeekFont.Color = clWindowText
      HeaderInfo.DaysOfWeekFont.Height = -13
      HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      HeaderInfo.DaysOfWeekFont.Style = []
      HeaderInfo.Font.Charset = DEFAULT_CHARSET
      HeaderInfo.Font.Color = clWindowText
      HeaderInfo.Font.Height = -20
      HeaderInfo.Font.Name = 'Product Sans'
      HeaderInfo.Font.Style = []
      HeaderInfo.HighlightFontColor = clTeal
      HighlightColor = clTeal
      HighlightToday = False
      OnChange = cvCalendarioChange
      OnClick = cvCalendarioClick
      OnDrawDayItem = cvCalendarioDrawDayItem
      ParentFont = False
      SelectionColor = clTeal
      TabOrder = 0
    end
    object mmObservacao: TMemo
      Left = -3
      Top = 0
      Width = 353
      Height = 283
      BevelInner = bvNone
      BorderStyle = bsNone
      Color = 14342874
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object btnSalvarObservacao: TPanel
    Left = 8
    Top = 53
    Width = 137
    Height = 26
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Salvar observa'#231#227'o'
    Color = 10658466
    DragCursor = crDefault
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    OnClick = btnSalvarObservacaoClick
  end
end
