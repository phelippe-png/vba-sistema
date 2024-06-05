object formCadastrarEmpresa: TformCadastrarEmpresa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Empresa'
  ClientHeight = 447
  ClientWidth = 529
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 529
    Height = 389
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
      Width = 479
      Height = 206
      Align = alTop
      Caption = 'Dados da Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Panel5: TPanel
        Left = 2
        Top = 18
        Width = 475
        Height = 186
        Align = alClient
        BevelOuter = bvNone
        Padding.Left = 15
        Padding.Right = 15
        TabOrder = 0
        object Label2: TLabel
          Left = 24
          Top = 8
          Width = 68
          Height = 16
          Caption = 'Raz'#227'o Social'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 24
          Top = 122
          Width = 58
          Height = 16
          Caption = 'CPF/CNPJ'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 24
          Top = 64
          Width = 83
          Height = 16
          Caption = 'Nome Fantasia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 169
          Top = 122
          Width = 101
          Height = 16
          Caption = 'Inscri'#231#227'o Estadual'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 321
          Top = 122
          Width = 49
          Height = 16
          Caption = 'Telefone'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edRazao: TEdit
          Left = 24
          Top = 25
          Width = 425
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edFantasia: TEdit
          Left = 24
          Top = 83
          Width = 425
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edCPF_CNPJ: TEdit
          Left = 24
          Top = 141
          Width = 128
          Height = 24
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 18
          NumbersOnly = True
          ParentFont = False
          TabOrder = 2
          OnChange = edCPF_CNPJChange
          OnKeyPress = edCPF_CNPJKeyPress
        end
        object edIE: TEdit
          Left = 169
          Top = 141
          Width = 136
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 3
        end
        object edTelefone: TEdit
          Left = 321
          Top = 141
          Width = 128
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 15
          NumbersOnly = True
          ParentFont = False
          TabOrder = 4
          OnChange = edTelefoneChange
          OnKeyPress = edTelefoneKeyPress
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 25
      Top = 221
      Width = 479
      Height = 140
      Align = alTop
      Caption = 'Endere'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Panel1: TPanel
        Left = 2
        Top = 18
        Width = 475
        Height = 120
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label10: TLabel
          Left = 235
          Top = 61
          Width = 38
          Height = 16
          Caption = 'Estado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 24
          Top = 61
          Width = 34
          Height = 16
          Caption = 'Bairro'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 24
          Top = 7
          Width = 23
          Height = 16
          Caption = 'CEP'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 137
          Top = 7
          Width = 64
          Height = 16
          Caption = 'Logradouro'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 368
          Top = 7
          Width = 46
          Height = 16
          Caption = 'N'#250'mero'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 311
          Top = 61
          Width = 39
          Height = 16
          Caption = 'Cidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edLogradouro: TEdit
          Left = 137
          Top = 26
          Width = 225
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edNumero: TEdit
          Left = 368
          Top = 26
          Width = 81
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 2
        end
        object edBairro: TEdit
          Left = 24
          Top = 80
          Width = 201
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object edCEP: TEdit
          Left = 24
          Top = 26
          Width = 105
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 10
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          OnChange = edCEPChange
          OnKeyPress = edCEPKeyPress
        end
        object cbUF: TComboBox
          Left = 235
          Top = 80
          Width = 67
          Height = 24
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnSelect = cbUFSelect
        end
        object cbCidade: TComboBox
          Left = 311
          Top = 80
          Width = 138
          Height = 24
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 389
    Width = 529
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
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object btnSave: TPanel
      Left = 416
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
      Font.Height = -16
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
      OnMouseEnter = btnSaveMouseEnter
      OnMouseLeave = btnSaveMouseLeave
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
  end
end
