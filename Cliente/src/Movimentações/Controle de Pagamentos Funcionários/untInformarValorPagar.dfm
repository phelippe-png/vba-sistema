object formInformarValorPagar: TformInformarValorPagar
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Valor do Pagamento'
  ClientHeight = 202
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    482
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object lblFuncionario: TLabel
    Left = 8
    Top = 8
    Width = 90
    Height = 19
    Caption = 'Funcion'#225'rio: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblMesAno: TLabel
    Left = 8
    Top = 33
    Width = 40
    Height = 19
    Caption = 'Data: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 88
    Top = 68
    Width = 208
    Height = 19
    Caption = 'Informe o valor do pagamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnCancel: TPanel
    Left = 288
    Top = 159
    Width = 90
    Height = 35
    Cursor = crHandPoint
    Anchors = [akRight, akBottom]
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
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object btnConfirmar: TPanel
    Left = 384
    Top = 159
    Width = 90
    Height = 35
    Cursor = crHandPoint
    Anchors = [akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'Confirmar'
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
    OnClick = btnConfirmarClick
  end
  object edtValorPagar: TEdit
    Left = 88
    Top = 87
    Width = 306
    Height = 29
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Product Sans'
    Font.Style = []
    MaxLength = 14
    ParentFont = False
    TabOrder = 2
    Text = '0,00'
    OnChange = edtValorPagarChange
  end
end
