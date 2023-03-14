object formModal: TformModal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Informar Valor Pago'
  ClientHeight = 206
  ClientWidth = 384
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
    384
    206)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = -3
    Top = 24
    Width = 390
    Height = 30
    Alignment = taCenter
    AutoSize = False
    Caption = 'Informe o valor pago'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 39
    Top = 109
    Width = 73
    Height = 19
    Caption = 'Valor Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblValorTotal: TLabel
    Left = 39
    Top = 125
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'valor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 155
    Top = 109
    Width = 74
    Height = 19
    Caption = 'Valor Pago'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblValorPago: TLabel
    Left = 156
    Top = 125
    Width = 72
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'valor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 257
    Top = 109
    Width = 89
    Height = 19
    Caption = 'Total a Pagar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalPagar: TLabel
    Left = 257
    Top = 125
    Width = 90
    Height = 23
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'valor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
  end
  object edValor: TEdit
    Left = 65
    Top = 73
    Width = 255
    Height = 27
    Alignment = taRightJustify
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = '0,00'
    OnChange = edValorChange
  end
  object btnCancel: TPanel
    Left = 210
    Top = 169
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
    TabOrder = 1
    OnClick = btnCancelClick
    OnMouseEnter = btnCancelMouseEnter
    OnMouseLeave = btnCancelMouseLeave
  end
  object btnInsert: TPanel
    Left = 296
    Top = 169
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
    TabOrder = 2
    OnClick = btnInsertClick
    OnMouseEnter = btnInsertMouseEnter
    OnMouseLeave = btnInsertMouseLeave
  end
end
