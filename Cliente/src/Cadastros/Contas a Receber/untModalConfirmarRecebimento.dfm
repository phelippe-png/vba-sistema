object formConfirmarRecebimento: TformConfirmarRecebimento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Confirmar Recebimento'
  ClientHeight = 217
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    450
    217)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 32
    Width = 441
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = 'Informe a data de recebimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 80
    Top = 112
    Width = 187
    Height = 17
    Caption = 'Valor a confirmar recebimento:  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblValorReceber: TLabel
    Left = 263
    Top = 112
    Width = 28
    Height = 17
    Caption = 'valor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
  end
  object edDataRecebimento: TDateTimePicker
    Left = 80
    Top = 78
    Width = 281
    Height = 28
    BevelOuter = bvSpace
    BiDiMode = bdLeftToRight
    Date = 44893.000000000000000000
    Time = 0.956934814814303500
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Product Sans'
    Font.Style = []
    ImeMode = imKata
    ParentBiDiMode = False
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
  end
  object btnInsert: TPanel
    Left = 362
    Top = 179
    Width = 80
    Height = 30
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Inserir'
    Color = clGreen
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    OnClick = btnInsertClick
  end
  object btnCancel: TPanel
    Left = 276
    Top = 179
    Width = 80
    Height = 30
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Cancelar'
    Color = clMaroon
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
