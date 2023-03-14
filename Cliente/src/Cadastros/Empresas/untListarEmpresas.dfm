object formListarEmpresas: TformListarEmpresas
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Empresas'
  ClientHeight = 511
  ClientWidth = 765
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 765
    Height = 511
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      765
      511)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 739
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 10
        Width = 74
        Height = 20
        Caption = 'Empresas'
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
      Width = 739
      Height = 451
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        739
        451)
      object Label1: TLabel
        Left = 14
        Top = 10
        Width = 57
        Height = 17
        Caption = 'Pesquisar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edSearch: TEdit
        Left = 14
        Top = 31
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
      object pnlSearch: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 733
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
        Width = 710
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 2
      end
      object btnSelect: TPanel
        Left = 376
        Top = 20
        Width = 90
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
        Left = 472
        Top = 20
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
        Left = 558
        Top = 20
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
        Left = 644
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
      object dbgEmpresas: TDBGrid
        Left = 14
        Top = 71
        Width = 710
        Height = 380
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
        OnDblClick = dbgEmpresasDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'razaosocial'
            Title.Caption = 'Raz'#227'o Social'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nomefantasia'
            Title.Caption = 'Nome Fantasia'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cpf_cnpj'
            Title.Caption = 'CPF/CNPJ'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'insc_estadual'
            Title.Caption = 'Insc. Estadual'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Title.Caption = 'Telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Title.Caption = 'CEP'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'logradouro'
            Title.Caption = 'Logradouro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'numero'
            Title.Caption = 'N'#250'mero'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'bairro'
            Title.Caption = 'Bairro'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Title.Caption = 'Cidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'uf'
            Title.Caption = 'Estado'
            Visible = True
          end>
      end
    end
  end
end
