object formListarLotes: TformListarLotes
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 503
  ClientWidth = 898
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 898
    Height = 503
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      898
      503)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 872
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 11
        Width = 41
        Height = 20
        Caption = 'Lotes'
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
      Width = 872
      Height = 443
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        872
        443)
      object Label1: TLabel
        Left = 14
        Top = 10
        Width = 54
        Height = 16
        Caption = 'Pesquisar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 488
        Top = 11
        Width = 287
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'Filtrar pelo m'#234's de:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 359
        Top = 11
        Width = 287
        Height = 16
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'Filtrar por:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edSearch: TEdit
        Left = 14
        Top = 28
        Width = 339
        Height = 27
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = edSearchChange
      end
      object Panel6: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 894
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 4210688
        ParentBackground = False
        TabOrder = 1
      end
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 14
        Top = 70
        Width = 843
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 2
      end
      object btnSelect: TPanel
        Left = 684
        Top = 20
        Width = 87
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Selecionar'
        Color = clOlive
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnClick = btnSelectClick
      end
      object btnDelete: TPanel
        Left = 777
        Top = 125
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Excluir'
        Color = clMaroon
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = btnDeleteClick
      end
      object btnEdit: TPanel
        Left = 777
        Top = 89
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Editar'
        Color = 7893767
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
        OnClick = btnEditClick
      end
      object btnAdd: TPanel
        Left = 777
        Top = 20
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Novo'
        Color = 620302
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 6
        OnClick = btnAddClick
      end
      object dbgLotes: TDBGrid
        Left = 14
        Top = 71
        Width = 747
        Height = 370
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgMultiSelect]
        ParentFont = False
        TabOrder = 7
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Product Sans'
        TitleFont.Style = [fsBold]
        OnDblClick = dbgLotesDblClick
        Columns = <
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
            FieldName = 'codigo'
            Title.Caption = 'C'#243'digo'
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
            FieldName = 'quantidade'
            Title.Caption = 'Quantidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor_unit'
            Title.Caption = 'Valor Unit'#225'rio'
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
            FieldName = 'tempo_min'
            Title.Caption = 'Tempo Min.'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tempo_total'
            Title.Caption = 'Tempo Total'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_entrada'
            Title.Caption = 'Data Entrada'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'pago'
            Visible = False
          end>
      end
      object cbFiltroMeses: TComboBox
        Left = 488
        Top = 29
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
        TabOrder = 8
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
      object cbFiltro: TComboBox
        Left = 359
        Top = 29
        Width = 122
        Height = 25
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 9
        Text = 'C'#243'digo'
        OnChange = cbFiltroChange
        Items.Strings = (
          'C'#243'digo'
          'OP'
          'Descri'#231#227'o'
          'Empresa')
      end
    end
  end
end
