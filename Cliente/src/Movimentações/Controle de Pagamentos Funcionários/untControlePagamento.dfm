object formControlePagamentos: TformControlePagamentos
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Controle de Pagamentos'
  ClientHeight = 526
  ClientWidth = 880
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    880
    526)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 66
    Height = 19
    Caption = 'Pesquisar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnProcurarFuncionario: TSpeedButton
    Left = 80
    Top = 8
    Width = 23
    Height = 22
    OnClick = btnProcurarFuncionarioClick
  end
  object lblFuncionario: TLabel
    Left = 8
    Top = 56
    Width = 113
    Height = 25
    Caption = 'Funcion'#225'rio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSalario: TLabel
    Left = 8
    Top = 86
    Width = 73
    Height = 25
    Caption = 'Salario: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 196
    Width = 97
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Benef'#237'cios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 325
    Top = 353
    Width = 93
    Height = 16
    Caption = 'Valor antecipado'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 325
    Top = 404
    Width = 68
    Height = 16
    Caption = 'Observa'#231#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnSave: TPanel
    Left = 779
    Top = 8
    Width = 93
    Height = 38
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Confirmar'
    Color = 489483
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object btnCancel: TPanel
    Left = 779
    Top = 52
    Width = 93
    Height = 38
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Cancelar'
    Color = clRed
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object Panel5: TPanel
    Left = 0
    Top = 220
    Width = 320
    Height = 306
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    TabOrder = 2
    object Panel1: TPanel
      Left = 319
      Top = 1
      Width = 1
      Height = 304
      Align = alRight
      TabOrder = 0
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 320
      Height = 1
      Align = alTop
      TabOrder = 1
    end
    object Panel3: TPanel
      Left = 0
      Top = 1
      Width = 1
      Height = 304
      Align = alLeft
      TabOrder = 2
    end
    object Panel4: TPanel
      Left = 0
      Top = 305
      Width = 320
      Height = 1
      Align = alBottom
      TabOrder = 3
    end
    object sbxBeneficios: TScrollBox
      Left = 1
      Top = 1
      Width = 318
      Height = 304
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      TabOrder = 4
    end
  end
  object edSearch: TEdit
    Left = 325
    Top = 371
    Width = 263
    Height = 27
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 325
    Top = 422
    Width = 263
    Height = 97
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object cvwCalendario: TCalendarView
    Left = 595
    Top = 228
    Width = 285
    Height = 298
    Anchors = [akRight, akBottom]
    BorderStyle = bsNone
    Date = 45007.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Product Sans'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -13
    HeaderInfo.DaysOfWeekFont.Name = 'Product Sans'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -20
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    HighlightColor = clGray
    OnDrawDayItem = cvwCalendarioDrawDayItem
    ParentFont = False
    TabOrder = 5
  end
end
