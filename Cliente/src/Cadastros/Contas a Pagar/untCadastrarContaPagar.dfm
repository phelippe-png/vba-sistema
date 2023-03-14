object formCadastrarConta: TformCadastrarConta
  Left = 0
  Top = 0
  Caption = 'Adicionar Conta a Pagar'
  ClientHeight = 243
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 540
    Height = 185
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 25
    Padding.Top = 15
    Padding.Right = 25
    ParentBackground = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 25
      Top = 15
      Width = 490
      Height = 154
      Align = alTop
      Caption = 'Dados do Lote'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Panel1: TPanel
        Left = 2
        Top = 17
        Width = 486
        Height = 135
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Left = 16
          Top = 6
          Width = 49
          Height = 13
          Caption = 'Descri'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 16
          Top = 66
          Width = 104
          Height = 13
          Caption = 'Data de Vencimento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 272
          Top = 66
          Width = 54
          Height = 13
          Caption = 'Valor Total'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edDescricao: TEdit
          Left = 16
          Top = 25
          Width = 457
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edDataEnt: TDateTimePicker
          Left = 16
          Top = 83
          Width = 178
          Height = 23
          Date = 44811.000000000000000000
          Time = 0.664087673612812100
          TabOrder = 1
        end
        object edValorTotal: TEdit
          Left = 272
          Top = 83
          Width = 105
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 185
    Width = 540
    Height = 58
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Padding.Left = 20
    Padding.Right = 20
    Padding.Bottom = 20
    ParentFont = False
    TabOrder = 1
    object btnSave: TPanel
      Left = 427
      Top = 0
      Width = 93
      Height = 38
      Cursor = crHandPoint
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Salvar'
      Color = 489483
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object btnCancel: TPanel
      Left = 20
      Top = 0
      Width = 93
      Height = 38
      Cursor = crHandPoint
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Cancelar'
      Color = clRed
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
  end
end
