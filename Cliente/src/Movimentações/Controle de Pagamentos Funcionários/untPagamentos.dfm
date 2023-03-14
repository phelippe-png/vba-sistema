object formControlePagamentos: TformControlePagamentos
  Left = 0
  Top = 0
  Caption = 'Controle de Pagamentos'
  ClientHeight = 392
  ClientWidth = 864
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 74
    Height = 18
    Caption = 'Pesquisar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 88
    Top = 8
    Width = 23
    Height = 22
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 126
    Height = 24
    Caption = 'Funcion'#225'rio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 86
    Width = 83
    Height = 24
    Caption = 'Salario: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 344
    Top = 337
    Width = 185
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Edit1'
  end
  object Panel4: TPanel
    Left = 624
    Top = 192
    Width = 240
    Height = 192
    TabOrder = 1
  end
  object btnSave: TPanel
    Left = 763
    Top = 8
    Width = 93
    Height = 38
    Cursor = crHandPoint
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
    TabOrder = 2
  end
  object btnCancel: TPanel
    Left = 763
    Top = 52
    Width = 93
    Height = 38
    Cursor = crHandPoint
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
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 8
    Top = 128
    Width = 297
    Height = 256
    BevelOuter = bvNone
    TabOrder = 4
    object Panel2: TPanel
      Left = 0
      Top = 81
      Width = 297
      Height = 81
      Align = alTop
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 297
      Height = 81
      Align = alTop
      TabOrder = 1
    end
  end
end
