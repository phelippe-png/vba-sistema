object formContasPagar: TformContasPagar
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Contas a Pagar'
  ClientHeight = 492
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 870
    Height = 492
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      870
      492)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 844
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 11
        Width = 114
        Height = 20
        Caption = 'Contas a Pagar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlContainer: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 47
      Width = 844
      Height = 378
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        844
        378)
      object Label3: TLabel
        Left = 14
        Top = 10
        Width = 371
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 281
        Top = 10
        Width = 123
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Data de Vencimento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 419
        Top = 10
        Width = 110
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 684
        Top = 68
        Width = 145
        Height = 17
        Alignment = taCenter
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Filtros'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlSearch: TPanel
        AlignWithMargins = True
        Left = -3
        Top = 0
        Width = 850
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 4210688
        ParentBackground = False
        TabOrder = 0
      end
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 14
        Top = 65
        Width = 815
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 1
      end
      object btnDelete: TPanel
        Left = 562
        Top = 17
        Width = 86
        Height = 33
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Excluir'
        Color = clGrayText
        DragCursor = crDefault
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        OnClick = btnDeleteClick
      end
      object btnEdit: TPanel
        Left = 654
        Top = 17
        Width = 86
        Height = 33
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Editar'
        Color = clGrayText
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
        OnClick = btnEditClick
      end
      object btnSave: TPanel
        Left = 746
        Top = 17
        Width = 83
        Height = 33
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Salvar'
        Color = 620302
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = btnSaveClick
      end
      object edDescricao: TEdit
        Left = 14
        Top = 29
        Width = 251
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edValorTotal: TEdit
        Left = 419
        Top = 29
        Width = 110
        Height = 25
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = '0,00'
        OnChange = edValorTotalChange
      end
      object edDataVenc: TDateTimePicker
        Left = 281
        Top = 29
        Width = 123
        Height = 25
        Anchors = [akTop, akRight]
        Date = 44825.000000000000000000
        Time = 0.770528842593194000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object GroupBox1: TGroupBox
        Left = 684
        Top = 87
        Width = 145
        Height = 138
        Anchors = [akTop, akRight]
        TabOrder = 8
        DesignSize = (
          145
          138)
        object Label13: TLabel
          Left = 3
          Top = 4
          Width = 24
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'M'#234's'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Product Sans'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbFiltroMeses: TComboBox
          Left = 3
          Top = 22
          Width = 139
          Height = 25
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Product Sans'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 0
          Text = 'Janeiro'
          OnChange = cbFiltroMesesChange
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
        object Panel3: TPanel
          Left = 3
          Top = 58
          Width = 145
          Height = 73
          BevelOuter = bvNone
          TabOrder = 1
          object rgFiltro: TRadioGroup
            Left = -7
            Top = -20
            Width = 185
            Height = 102
            Items.Strings = (
              'Todos'
              'Contas pagas'
              'Contas n'#227'o pagas')
            TabOrder = 0
            OnClick = rgFiltroClick
          end
        end
      end
      object btnInserirValor: TPanel
        Left = 690
        Top = 230
        Width = 133
        Height = 33
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Inserir Valor Pago'
        Color = clGrayText
        DragCursor = crDefault
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 9
        OnClick = btnInserirValorClick
      end
      object btnConfirmar: TPanel
        Left = 690
        Top = 267
        Width = 133
        Height = 33
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Confirmar Pagamento'
        Color = clGrayText
        DragCursor = crDefault
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 10
        OnClick = btnConfirmarClick
      end
      object dbgContasPagar: TDBGrid
        Left = 14
        Top = 66
        Width = 660
        Height = 312
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        GradientEndColor = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgMultiSelect]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Product Sans'
        TitleFont.Style = [fsBold]
        Touch.ParentTabletOptions = False
        Touch.TabletOptions = [toPressAndHold, toSmoothScrolling]
        OnCellClick = dbgContasPagarCellClick
        OnDrawColumnCell = dbgContasPagarDrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'situacao'
            Title.Caption = 'Situa'#231#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Title.Caption = 'Descri'#231#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_venc'
            Title.Caption = 'Data Vencimento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_total'
            Title.Caption = 'Valor Total'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_pago'
            Title.Caption = 'Valor Pago'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'total_pagar'
            Title.Caption = 'Total Pagar'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'pago'
            Visible = False
          end>
      end
    end
    object pnlValues: TPanel
      Left = 10
      Top = 427
      Width = 850
      Height = 55
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        850
        55)
      object Label7: TLabel
        Left = 498
        Top = 10
        Width = 86
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 735
        Top = 10
        Width = 107
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Total a Pagar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
      end
      object lblValorTotal: TLabel
        Left = 530
        Top = 34
        Width = 54
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalPagar: TLabel
        Left = 788
        Top = 34
        Width = 54
        Height = 19
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 582
        Top = 10
        Width = 123
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Total Pago'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblTotalPago: TLabel
        Left = 610
        Top = 34
        Width = 95
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
    end
  end
end
