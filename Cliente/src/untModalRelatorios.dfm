object formModalRelatorios: TformModalRelatorios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar relat'#243'rio'
  ClientHeight = 263
  ClientWidth = 504
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
  object CardPanel1: TCardPanel
    Left = 0
    Top = 0
    Width = 504
    Height = 209
    Align = alTop
    ActiveCard = cardControlePagamento
    BevelOuter = bvNone
    Caption = 'CardPanel1'
    TabOrder = 0
    object cardContasPagar: TCard
      Left = 0
      Top = 0
      Width = 504
      Height = 209
      Caption = 'relatorioContasPagar'
      CardIndex = 0
      TabOrder = 0
      DesignSize = (
        504
        209)
      object Label4: TLabel
        Left = 0
        Top = 5
        Width = 504
        Height = 29
        Alignment = taCenter
        AutoSize = False
        Caption = 'Selecione os filtros para gera'#231#227'o do relat'#243'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 18
        Top = 32
        Width = 145
        Height = 21
        AutoSize = False
        Caption = 'Contas a Pagar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlContainer: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 56
        Width = 504
        Height = 168
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clBtnHighlight
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          504
          168)
        object Label2: TLabel
          Left = 9
          Top = 79
          Width = 52
          Height = 16
          Caption = 'Data final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 9
          Top = 32
          Width = 61
          Height = 16
          Caption = 'Data inicial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 138
          Top = 32
          Width = 23
          Height = 16
          Caption = 'M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Panel6: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 526
          Height = 2
          Anchors = [akLeft, akTop, akRight]
          BevelOuter = bvNone
          Color = 4210688
          ParentBackground = False
          TabOrder = 0
        end
        object cbFiltroMesesContasPagar: TComboBox
          Left = 138
          Top = 48
          Width = 145
          Height = 24
          Style = csDropDownList
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Janeiro'
          Items.Strings = (
            'Janeiro'
            'Fevereiro'
            'Mar'#231'o'
            'Abril'
            'Maio'
            'Junho'
            'Julho'
            'Agosto'
            'Setembro'
            'Outubro'
            'Novembro'
            'Dezembro')
        end
        object dataFinalContasPagar: TDateTimePicker
          Left = 9
          Top = 95
          Width = 105
          Height = 24
          Date = 44888.000000000000000000
          Time = 0.868065324073541000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object dataInicialContasPagar: TDateTimePicker
          Left = 9
          Top = 48
          Width = 105
          Height = 24
          BiDiMode = bdLeftToRight
          Date = 44888.000000000000000000
          Time = 0.868065324073541000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 3
        end
        object Panel1: TPanel
          Left = 323
          Top = 2
          Width = 153
          Height = 81
          BevelOuter = bvNone
          TabOrder = 4
          object rgSituacoesContasPagar: TRadioGroup
            Left = -5
            Top = -7
            Width = 161
            Height = 90
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'Todos'
              'Pagos'
              'N'#227'o pagos'
              'Em dia'
              'A vencer'
              'Vencidos')
            TabOrder = 0
            StyleElements = [seFont, seClient]
          end
        end
        object rbDataContasPagar: TRadioButton
          Left = 9
          Top = 8
          Width = 113
          Height = 17
          Caption = 'Filtrar por data'
          Checked = True
          TabOrder = 5
          TabStop = True
          OnClick = rbDataContasPagarClick
        end
        object rbMesContasPagar: TRadioButton
          Left = 138
          Top = 8
          Width = 113
          Height = 17
          Caption = 'Filtrar por m'#234's'
          TabOrder = 6
          OnClick = rbMesContasPagarClick
        end
      end
    end
    object cardContasReceber: TCard
      Left = 0
      Top = 0
      Width = 504
      Height = 209
      Caption = 'relatorioContasReceber'
      CardIndex = 1
      TabOrder = 1
      DesignSize = (
        504
        209)
      object Label5: TLabel
        Left = 0
        Top = 3
        Width = 504
        Height = 29
        Alignment = taCenter
        AutoSize = False
        Caption = 'Selecione os filtros para gera'#231#227'o do relat'#243'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 18
        Top = 29
        Width = 145
        Height = 21
        AutoSize = False
        Caption = 'Contas a Receber'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 51
        Width = 504
        Height = 168
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clBtnHighlight
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          504
          168)
        object Label7: TLabel
          Left = 9
          Top = 79
          Width = 52
          Height = 16
          Caption = 'Data final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 9
          Top = 32
          Width = 61
          Height = 16
          Caption = 'Data inicial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 178
          Top = 32
          Width = 23
          Height = 16
          Caption = 'M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 526
          Height = 2
          Anchors = [akLeft, akTop, akRight]
          BevelOuter = bvNone
          Color = 4210688
          ParentBackground = False
          TabOrder = 0
        end
        object cbFiltroMesContasReceber: TComboBox
          Left = 178
          Top = 48
          Width = 145
          Height = 24
          Style = csDropDownList
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Janeiro'
          Items.Strings = (
            'Janeiro'
            'Fevereiro'
            'Mar'#231'o'
            'Abril'
            'Maio'
            'Junho'
            'Julho'
            'Agosto'
            'Setembro'
            'Outubro'
            'Novembro'
            'Dezembro')
        end
        object dataFinalContasReceber: TDateTimePicker
          Left = 9
          Top = 95
          Width = 105
          Height = 24
          Date = 44888.000000000000000000
          Time = 0.868065324073541000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object dataInicialContasReceber: TDateTimePicker
          Left = 9
          Top = 48
          Width = 105
          Height = 24
          BiDiMode = bdLeftToRight
          Date = 44888.000000000000000000
          Time = 0.868065324073541000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 3
        end
        object Panel5: TPanel
          Left = 384
          Top = 2
          Width = 78
          Height = 81
          BevelOuter = bvNone
          TabOrder = 4
          object rgContasReceber: TRadioGroup
            Left = -5
            Top = -7
            Width = 161
            Height = 90
            ItemIndex = 0
            Items.Strings = (
              'Todos'
              'Recebidos'
              'A receber')
            TabOrder = 0
            StyleElements = [seFont, seClient]
          end
        end
        object rbDataContasReceber: TRadioButton
          Left = 9
          Top = 8
          Width = 113
          Height = 17
          Caption = 'Filtrar por data'
          Checked = True
          TabOrder = 5
          TabStop = True
          OnClick = rbDataContasReceberClick
        end
        object rbMesContasReceber: TRadioButton
          Left = 178
          Top = 8
          Width = 113
          Height = 17
          Caption = 'Filtrar por m'#234's'
          TabOrder = 6
          OnClick = rbMesContasReceberClick
        end
      end
    end
    object cardControleProducao: TCard
      Left = 0
      Top = 0
      Width = 504
      Height = 209
      Caption = 'relatorioControleProducao'
      CardIndex = 2
      TabOrder = 2
      DesignSize = (
        504
        209)
      object Label11: TLabel
        Left = 0
        Top = 5
        Width = 504
        Height = 29
        Alignment = taCenter
        AutoSize = False
        Caption = 'Selecione os filtros para gera'#231#227'o do relat'#243'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 18
        Top = 32
        Width = 175
        Height = 21
        AutoSize = False
        Caption = 'Controle de Produ'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Panel7: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 58
        Width = 504
        Height = 168
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clBtnHighlight
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          504
          168)
        object Label13: TLabel
          Left = 7
          Top = 79
          Width = 52
          Height = 16
          Caption = 'Data final'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 7
          Top = 32
          Width = 61
          Height = 16
          Caption = 'Data inicial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 129
          Top = 32
          Width = 23
          Height = 16
          Caption = 'M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 409
          Top = 8
          Width = 36
          Height = 16
          Alignment = taCenter
          Caption = 'Status'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 258
          Top = 31
          Width = 66
          Height = 20
          Alignment = taCenter
          Caption = 'Empresa'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object btnBuscarEmpresa: TImage
          Left = 328
          Top = 30
          Width = 23
          Height = 23
          Cursor = crHandPoint
          Center = True
          Enabled = False
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
            00100804000000B5FA37EA0000000273424954080855EC460400000009704859
            73000003E3000003E3013C487B630000001974455874536F6674776172650077
            77772E696E6B73636170652E6F72679BEE3C1A0000012C4944415478DA75D14F
            28844118C7F1EFB8509652BB9693C346A1780FBC6752928BC392DC3729C79556
            29FF0E28B988B6B40717CA4AEB808BC8C58D62C36589E396C31E44A11EF37AD7
            F4EE5BFBBB4C3DF39967A66794E0448599A21B8B3CD7EC4B0613E50015254990
            02B78469A1825D26A56080EAE19C3726E4B0D86B9328A732580404C812C2929C
            A7ED3631629272C13069E2B28E27AA96275EA5CB05CB246893474AA28E182020
            DF0E48EB1BABE4CB07D688D3EC5CAB5862960EC9FAC031FD543BC71443649893
            C592ED20395EC472DF50C90D116CB933DB8A3D46199183FF39D85CF1C1343BF2
            A90BED6CD0CBB344BC93EC2345133F3CD040BD2EE4F544572561805E6A18FFFB
            8B778DB6B8E70C9B059937C01F55C7059DCCC84A19A049884B5A192B0B3469E4
            84E42F7E945FC2E0B0294F0000000049454E44AE426082}
          Proportional = True
          OnClick = btnBuscarEmpresaClick
        end
        object lblTituloRazao: TLabel
          Left = 258
          Top = 51
          Width = 71
          Height = 16
          Alignment = taCenter
          Caption = 'Raz'#227'o Social:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblTituloFantasia: TLabel
          Left = 258
          Top = 81
          Width = 86
          Height = 16
          Alignment = taCenter
          Caption = 'Nome Fantasia:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblRazao: TLabel
          Left = 268
          Top = 64
          Width = 92
          Height = 16
          Alignment = taCenter
          Caption = 'N'#227'o selecionado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object lblFantasia: TLabel
          Left = 268
          Top = 94
          Width = 92
          Height = 16
          Alignment = taCenter
          Caption = 'N'#227'o selecionado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Panel8: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 526
          Height = 2
          Anchors = [akLeft, akTop, akRight]
          BevelOuter = bvNone
          Color = 4210688
          ParentBackground = False
          TabOrder = 0
        end
        object cbFiltroMesProducao: TComboBox
          Left = 129
          Top = 48
          Width = 113
          Height = 24
          Style = csDropDownList
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Janeiro'
          Items.Strings = (
            'Janeiro'
            'Fevereiro'
            'Mar'#231'o'
            'Abril'
            'Maio'
            'Junho'
            'Julho'
            'Agosto'
            'Setembro'
            'Outubro'
            'Novembro'
            'Dezembro')
        end
        object dataFinalProducao: TDateTimePicker
          Left = 7
          Top = 95
          Width = 105
          Height = 24
          Date = 44888.000000000000000000
          Time = 0.868065324073541000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object dataInicialProducao: TDateTimePicker
          Left = 7
          Top = 48
          Width = 105
          Height = 24
          BiDiMode = bdLeftToRight
          Date = 44888.000000000000000000
          Time = 0.868065324073541000
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 3
        end
        object Panel9: TPanel
          Left = 409
          Top = 18
          Width = 84
          Height = 81
          BevelOuter = bvNone
          TabOrder = 4
          object rgStatusProducao: TRadioGroup
            Left = -5
            Top = -7
            Width = 161
            Height = 90
            ItemIndex = 0
            Items.Strings = (
              'Todos'
              'Em aberto'
              'Em produ'#231#227'o'
              'Finalizado')
            TabOrder = 0
            StyleElements = [seFont, seClient]
          end
        end
        object rbDataProducao: TRadioButton
          Left = 7
          Top = 8
          Width = 113
          Height = 17
          Caption = 'Filtrar por data'
          Checked = True
          TabOrder = 5
          TabStop = True
          OnClick = rbDataProducaoClick
        end
        object rbMesProducao: TRadioButton
          Left = 129
          Top = 8
          Width = 113
          Height = 17
          Caption = 'Filtrar por m'#234's'
          TabOrder = 6
          OnClick = rbMesProducaoClick
        end
        object Panel10: TPanel
          Left = 251
          Top = 8
          Width = 1
          Height = 137
          BevelOuter = bvNone
          Color = 13816530
          ParentBackground = False
          TabOrder = 7
        end
        object ckbEmpresaProducao: TCheckBox
          Left = 258
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Por empresa'
          TabOrder = 8
          OnClick = ckbEmpresaProducaoClick
        end
      end
    end
    object cardControlePagamento: TCard
      Left = 0
      Top = 0
      Width = 504
      Height = 209
      Caption = 'relatorioControlePagamento'
      CardIndex = 3
      TabOrder = 3
      DesignSize = (
        504
        209)
      object Label18: TLabel
        Left = 0
        Top = 1
        Width = 504
        Height = 29
        Alignment = taCenter
        AutoSize = False
        Caption = 'Selecione os filtros para gera'#231#227'o do relat'#243'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 18
        Top = 28
        Width = 207
        Height = 21
        AutoSize = False
        Caption = 'Controle de Pagamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Panel11: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 50
        Width = 251
        Height = 159
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clBtnHighlight
        ParentBackground = False
        TabOrder = 0
        object lblFuncionario: TLabel
          Left = 4
          Top = 5
          Width = 101
          Height = 21
          Caption = 'Funcion'#225'rio: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object pnlBtnBuscarEmpresa: TPanel
          Left = 105
          Top = 6
          Width = 20
          Height = 20
          Cursor = crHandPoint
          BevelOuter = bvNone
          Color = clSilver
          DragCursor = crDefault
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -15
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object btnBuscarFuncionario: TImage
            Left = 0
            Top = 0
            Width = 20
            Height = 20
            Cursor = crHandPoint
            Align = alClient
            Center = True
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
              00100804000000B5FA37EA0000000273424954080855EC460400000009704859
              73000003E3000003E3013C487B630000001974455874536F6674776172650077
              77772E696E6B73636170652E6F72679BEE3C1A0000012C4944415478DA75D14F
              28844118C7F1EFB8509652BB9693C346A1780FBC6752928BC392DC3729C79556
              29FF0E28B988B6B40717CA4AEB808BC8C58D62C36589E396C31E44A11EF37AD7
              F4EE5BFBBB4C3DF39967A66794E0448599A21B8B3CD7EC4B0613E50015254990
              02B78469A1825D26A56080EAE19C3726E4B0D86B9328A732580404C812C2929C
              A7ED3631629272C13069E2B28E27AA96275EA5CB05CB246893474AA28E182020
              DF0E48EB1BABE4CB07D688D3EC5CAB5862960EC9FAC031FD543BC71443649893
              C592ED20395EC472DF50C90D116CB933DB8A3D46199183FF39D85CF1C1343BF2
              A90BED6CD0CBB344BC93EC2345133F3CD040BD2EE4F544572561805E6A18FFFB
              8B778DB6B8E70C9B059937C01F55C7059DCCC84A19A049884B5A192B0B3469E4
              84E42F7E945FC2E0B0294F0000000049454E44AE426082}
            Proportional = True
            OnClick = btnBuscarFuncionarioClick
            ExplicitLeft = -40
            ExplicitTop = -40
            ExplicitWidth = 105
            ExplicitHeight = 105
          end
        end
      end
      object Panel13: TPanel
        AlignWithMargins = True
        Left = 253
        Top = 50
        Width = 251
        Height = 159
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clBtnHighlight
        ParentBackground = False
        TabOrder = 1
        object Label22: TLabel
          Left = 4
          Top = 1
          Width = 48
          Height = 16
          Caption = 'M'#234's/ano'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object dtpMesAnoPagamento: TDatePicker
          Left = 4
          Top = 17
          Width = 117
          Date = 45063.000000000000000000
          DateFormat = 'MM/yyyy'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          TabOrder = 0
        end
        object ckbFiltrarPorMesAno: TCheckBox
          Left = 58
          Top = 0
          Width = 119
          Height = 17
          Caption = 'Ativar'
          TabOrder = 1
          OnClick = ckbFiltrarPorMesAnoClick
        end
      end
      object Panel14: TPanel
        AlignWithMargins = True
        Left = -4
        Top = 48
        Width = 600
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 4210688
        ParentBackground = False
        TabOrder = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 301
    Top = 219
    Width = 74
    Height = 38
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = 'Cancelar'
    Color = clMaroon
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
  end
  object btnGerar: TPanel
    Left = 381
    Top = 219
    Width = 118
    Height = 38
    Cursor = crHandPoint
    BevelOuter = bvNone
    Caption = 'Gerar Relat'#243'rio'
    Color = clTeal
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = btnGerarClick
  end
end
