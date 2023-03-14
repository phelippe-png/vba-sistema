object formListarProducoes: TformListarProducoes
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Form3'
  ClientHeight = 525
  ClientWidth = 878
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
    Width = 878
    Height = 525
    Align = alClient
    BevelOuter = bvNone
    Color = cl3DLight
    Padding.Left = 10
    Padding.Right = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      878
      525)
    object pnlHeader: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 852
      Height = 43
      Align = alTop
      BevelOuter = bvNone
      Color = cl3DLight
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        852
        43)
      object lblTitle: TLabel
        Left = 0
        Top = 11
        Width = 163
        Height = 20
        Caption = 'Controle de Produ'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 194
        Top = 0
        Width = 37
        Height = 16
        Caption = 'Filtrar:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnAdd: TPanel
        Left = 767
        Top = 6
        Width = 87
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Adicionar'
        Color = 620302
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = btnAddClick
      end
      object Panel2: TPanel
        Left = 451
        Top = 6
        Width = 87
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Excluir'
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
        OnClick = Panel2Click
      end
      object Panel5: TPanel
        Left = 647
        Top = 6
        Width = 114
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Alterar Status'
        Color = clOlive
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        OnClick = Panel5Click
      end
      object cbFiltroMesProducao: TComboBox
        Left = 194
        Top = 16
        Width = 159
        Height = 24
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Product Sans'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 3
        Text = 'Janeiro'
        OnChange = cbFiltroMesProducaoChange
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
      object btnVisualizar: TPanel
        Left = 544
        Top = 6
        Width = 97
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Visualizar'
        Color = clNavy
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = btnVisualizarClick
      end
    end
    object pnlContainer: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 47
      Width = 852
      Height = 420
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        852
        420)
      object line: TPanel
        AlignWithMargins = True
        Left = -2
        Top = 0
        Width = 857
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 4210688
        ParentBackground = False
        TabOrder = 0
      end
      object dbgProducao: TDBGrid
        Left = 0
        Top = 2
        Width = 852
        Height = 408
        Hint = 'Clique duas vezes para visualizar'
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        GradientEndColor = clSilver
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Product Sans'
        TitleFont.Style = [fsBold]
        Touch.ParentTabletOptions = False
        Touch.TabletOptions = [toPressAndHold, toSmoothScrolling]
        OnDrawColumnCell = dbgProducaoDrawColumnCell
        OnDblClick = dbgProducaoDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'situacao'
            Title.Caption = 'Situa'#231#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'id_empresa'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'empresa'
            Title.Caption = 'Empresa'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_inicio'
            Title.Caption = 'Data Inicio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_final'
            Title.Caption = 'Data Final'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
            Title.Caption = 'Status'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade_total'
            Title.Caption = 'Quantidade Total'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade_produzir'
            Title.Caption = 'Quantidade Produzir'
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
            FieldName = 'tempo_total'
            Title.Caption = 'Tempo Total'
            Visible = True
          end>
      end
    end
    object Panel4: TPanel
      Left = 10
      Top = 456
      Width = 858
      Height = 69
      Align = alBottom
      BevelOuter = bvNone
      Color = cl3DLight
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
      TabOrder = 2
      DesignSize = (
        858
        69)
      object Label4: TLabel
        Left = 6
        Top = 11
        Width = 228
        Height = 24
        Caption = 'Quantidade Total a Produzir'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
      end
      object lblQuantidade: TLabel
        Left = 221
        Top = 34
        Width = 13
        Height = 24
        Alignment = taRightJustify
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 393
        Top = 11
        Width = 86
        Height = 24
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblValorTotal: TLabel
        Left = 408
        Top = 34
        Width = 71
        Height = 24
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblTempo: TLabel
        Left = 808
        Top = 34
        Width = 44
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 666
        Top = 11
        Width = 186
        Height = 24
        Anchors = [akTop, akRight]
        Caption = 'Tempo Total a Produzir'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
