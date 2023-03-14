object formContasReceber: TformContasReceber
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Contas a Receber'
  ClientHeight = 532
  ClientWidth = 857
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
    Width = 857
    Height = 532
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      857
      532)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 831
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 11
        Width = 133
        Height = 20
        Caption = 'Contas a Receber'
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
      Left = 14
      Top = 47
      Width = 831
      Height = 418
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        831
        418)
      object Label13: TLabel
        Left = 14
        Top = 9
        Width = 143
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'Filtrar pelo m'#234's de:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlSearch: TPanel
        AlignWithMargins = True
        Left = -3
        Top = 0
        Width = 837
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
        Width = 802
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 1
      end
      object btnDelete: TPanel
        Left = 552
        Top = 17
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Excluir'
        Color = clGrayText
        DragCursor = crDefault
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
      object btnConfirmar: TPanel
        Left = 638
        Top = 17
        Width = 178
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Confirmar Recebimento'
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
        OnClick = btnConfirmarClick
      end
      object cbFiltroMeses: TComboBox
        Left = 14
        Top = 28
        Width = 145
        Height = 25
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 4
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
      object dbgContasReceber: TDBGrid
        Left = 14
        Top = 66
        Width = 802
        Height = 352
        Hint = 'Clique duas vezes para editar'
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
        TabOrder = 5
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Product Sans'
        TitleFont.Style = [fsBold]
        Touch.ParentTabletOptions = False
        Touch.TabletOptions = [toPressAndHold, toSmoothScrolling]
        OnCellClick = dbgContasReceberCellClick
        OnDrawColumnCell = dbgContasReceberDrawColumnCell
        OnDblClick = dbgContasReceberDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'id_lote'
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
            FieldName = 'op'
            Title.Caption = 'OP'
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
            FieldName = 'empresa'
            Title.Caption = 'Empresa'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'previsao_recebimento'
            Title.Caption = 'Previsao Recebimento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_recebimento'
            Title.Caption = 'Data Recebimento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Title.Caption = 'Valor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'recebido'
            Visible = False
          end>
      end
      object Panel2: TPanel
        Left = 165
        Top = 3
        Width = 180
        Height = 57
        BevelOuter = bvNone
        TabOrder = 6
        object rgFiltros: TRadioGroup
          Left = -2
          Top = -13
          Width = 185
          Height = 75
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Product Sans'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Todos'
            'Contas recebidas'
            'Contas a receber')
          ParentFont = False
          TabOrder = 0
          OnClick = rgFiltrosClick
        end
      end
    end
    object pnlValues: TPanel
      Left = 10
      Top = 467
      Width = 837
      Height = 55
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        837
        55)
      object Label9: TLabel
        Left = 702
        Top = 9
        Width = 127
        Height = 24
        Anchors = [akTop, akRight]
        Caption = 'Total a Receber'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalReceber: TLabel
        Left = 775
        Top = 32
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
    end
  end
end
