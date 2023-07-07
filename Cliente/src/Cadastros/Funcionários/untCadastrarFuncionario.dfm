object formCadastrarFuncionario: TformCadastrarFuncionario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Funcion'#225'rio'
  ClientHeight = 535
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 483
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Product Sans'
    Font.Style = []
    Padding.Left = 25
    Padding.Top = 15
    Padding.Right = 25
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 25
      Top = 217
      Width = 400
      Height = 244
      Caption = 'Benef'#237'cios'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Panel1: TPanel
        Left = 2
        Top = 18
        Width = 396
        Height = 224
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 3
          Width = 57
          Height = 16
          Caption = 'Descri'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 257
          Top = 3
          Width = 28
          Height = 16
          Caption = 'Valor'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnAdicionarBeneficio: TSpeedButton
          Left = 359
          Top = 19
          Width = 24
          Height = 24
          Flat = True
          OnClick = btnAdicionarBeneficioClick
        end
        object edtDescricaoBeneficios: TEdit
          Left = 16
          Top = 19
          Width = 235
          Height = 24
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 35
          ParentFont = False
          TabOrder = 0
        end
        object edtValorBeneficios: TEdit
          Left = 257
          Top = 19
          Width = 101
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 8
          NumbersOnly = True
          ParentFont = False
          TabOrder = 1
          OnChange = edtValorBeneficiosChange
        end
        object sbxBeneficios: TScrollBox
          Left = 0
          Top = 48
          Width = 396
          Height = 176
          Align = alBottom
          BevelInner = bvLowered
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clBtnFace
          ParentColor = False
          TabOrder = 2
          OnMouseWheelDown = sbxBeneficiosMouseWheelDown
          OnMouseWheelUp = sbxBeneficiosMouseWheelUp
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 25
      Top = 15
      Width = 850
      Height = 202
      Align = alTop
      Caption = 'Dados Pessoais'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Panel5: TPanel
        Left = 2
        Top = 18
        Width = 846
        Height = 182
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Edit11: TEdit
          Left = 16
          Top = 25
          Width = 369
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
        end
        object Edit12: TEdit
          Left = 391
          Top = 25
          Width = 121
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object Edit13: TEdit
          Left = 518
          Top = 25
          Width = 121
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object Edit14: TEdit
          Left = 518
          Top = 80
          Width = 275
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object Edit15: TEdit
          Left = 16
          Top = 80
          Width = 369
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 4
        end
        object Edit16: TEdit
          Left = 391
          Top = 80
          Width = 121
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object DateTimePicker7: TDateTimePicker
          Left = 645
          Top = 25
          Width = 148
          Height = 24
          Date = 44811.000000000000000000
          Time = 0.664087673612812100
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object DateTimePicker8: TDateTimePicker
          Left = 16
          Top = 137
          Width = 180
          Height = 24
          Date = 44811.000000000000000000
          Time = 0.664087673612812100
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object DateTimePicker9: TDateTimePicker
          Left = 205
          Top = 137
          Width = 180
          Height = 24
          Date = 44811.000000000000000000
          Time = 0.664087673612812100
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object ComboBox3: TComboBox
          Left = 391
          Top = 137
          Width = 145
          Height = 24
          TabOrder = 9
          Text = 'ComboBox1'
        end
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 846
          Height = 182
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 10
          object Label29: TLabel
            Left = 16
            Top = 8
            Width = 34
            Height = 16
            Caption = 'Nome'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label30: TLabel
            Left = 391
            Top = 8
            Width = 23
            Height = 16
            Caption = 'CPF'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label31: TLabel
            Left = 550
            Top = 8
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
          object Label32: TLabel
            Left = 550
            Top = 63
            Width = 35
            Height = 16
            Caption = 'E-mail'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label33: TLabel
            Left = 16
            Top = 63
            Width = 41
            Height = 16
            Caption = 'Fun'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label34: TLabel
            Left = 391
            Top = 63
            Width = 37
            Height = 16
            Caption = 'Sal'#225'rio'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label35: TLabel
            Left = 702
            Top = 8
            Width = 114
            Height = 16
            Caption = 'Data de Nascimento'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label36: TLabel
            Left = 391
            Top = 120
            Width = 84
            Height = 16
            Caption = 'Data Admiss'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label37: TLabel
            Left = 517
            Top = 120
            Width = 84
            Height = 16
            Caption = 'Data Demiss'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label38: TLabel
            Left = 642
            Top = 120
            Width = 27
            Height = 16
            Caption = 'Sexo'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label10: TLabel
            Left = 738
            Top = 121
            Width = 36
            Height = 16
            Caption = 'Status'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label14: TLabel
            Left = 16
            Top = 120
            Width = 76
            Height = 16
            Caption = 'Nome da M'#227'e'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edtNome: TEdit
            Left = 16
            Top = 25
            Width = 369
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 0
          end
          object edtCPF: TEdit
            Left = 391
            Top = 25
            Width = 153
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            MaxLength = 14
            NumbersOnly = True
            ParentFont = False
            TabOrder = 1
            OnChange = edtCPFChange
            OnKeyPress = edtCPFKeyPress
          end
          object edtTelefone: TEdit
            Left = 550
            Top = 25
            Width = 146
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            MaxLength = 15
            NumbersOnly = True
            ParentFont = False
            TabOrder = 2
            OnChange = edtTelefoneChange
            OnKeyPress = edtTelefoneKeyPress
          end
          object edtEmail: TEdit
            Left = 550
            Top = 80
            Width = 273
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 6
          end
          object edtFuncao: TEdit
            Left = 16
            Top = 80
            Width = 369
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            MaxLength = 50
            ParentFont = False
            TabOrder = 4
          end
          object edtSalario: TEdit
            Left = 391
            Top = 80
            Width = 153
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            MaxLength = 14
            NumbersOnly = True
            ParentFont = False
            TabOrder = 5
            OnChange = edtSalarioChange
          end
          object dtpNascimento: TDateTimePicker
            Left = 702
            Top = 25
            Width = 121
            Height = 24
            Date = 44811.000000000000000000
            Time = 0.664087673612812100
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object dtpAdmissao: TDateTimePicker
            Left = 391
            Top = 137
            Width = 120
            Height = 24
            Date = 44811.000000000000000000
            Time = 0.664087673612812100
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object dtpDemissao: TDateTimePicker
            Left = 517
            Top = 137
            Width = 120
            Height = 24
            Date = 44811.000000000000000000
            Time = 0.664087673612812100
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object cbxSexo: TComboBox
            Left = 642
            Top = 137
            Width = 90
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 10
            Text = 'Masculino'
            Items.Strings = (
              'Masculino'
              'Feminino')
          end
          object cbxStatus: TComboBox
            Left = 738
            Top = 137
            Width = 85
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            Text = 'Ativo'
            OnChange = cbxStatusChange
            Items.Strings = (
              'Ativo'
              'Bloqueado')
          end
          object edtNomeMae: TEdit
            Left = 16
            Top = 137
            Width = 369
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Product Sans'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 7
          end
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 439
      Top = 217
      Width = 436
      Height = 244
      Caption = 'Endere'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Panel4: TPanel
        Left = 2
        Top = 18
        Width = 432
        Height = 224
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Left = 14
          Top = 3
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
        object Label4: TLabel
          Left = 117
          Top = 3
          Width = 54
          Height = 16
          Caption = 'Endere'#231'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 14
          Top = 59
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
        object Label6: TLabel
          Left = 117
          Top = 59
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
        object Label8: TLabel
          Left = 14
          Top = 170
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
        object Label7: TLabel
          Left = 14
          Top = 115
          Width = 81
          Height = 16
          Caption = 'Complemento'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 95
          Top = 170
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
        object edtCEP: TEdit
          Left = 14
          Top = 19
          Width = 97
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
          OnChange = edtCEPChange
          OnExit = edtCEPExit
          OnKeyPress = edtCEPKeyPress
        end
        object edtEndereco: TEdit
          Left = 117
          Top = 19
          Width = 292
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 1
        end
        object edtNumero: TEdit
          Left = 14
          Top = 75
          Width = 97
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
        end
        object edtBairro: TEdit
          Left = 117
          Top = 75
          Width = 292
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 3
        end
        object cbxEstado: TComboBox
          Left = 14
          Top = 186
          Width = 75
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnChange = cbxEstadoChange
        end
        object edtComplemento: TEdit
          Left = 14
          Top = 131
          Width = 395
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 4
        end
        object cbxCidade: TComboBox
          Left = 95
          Top = 186
          Width = 314
          Height = 24
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = cbxCidadeChange
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 483
    Width = 900
    Height = 52
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Product Sans'
    Font.Style = []
    Padding.Left = 20
    Padding.Right = 20
    Padding.Bottom = 12
    ParentFont = False
    TabOrder = 1
    object btnSave: TPanel
      Left = 787
      Top = 0
      Width = 93
      Height = 40
      Cursor = crHandPoint
      Align = alRight
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
      Left = 20
      Top = 0
      Width = 93
      Height = 40
      Cursor = crHandPoint
      Align = alLeft
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
  end
end
