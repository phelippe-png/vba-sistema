object formFuncionarios: TformFuncionarios
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Funcion'#225'rios'
  ClientHeight = 533
  ClientWidth = 878
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 878
    Height = 533
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      878
      533)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 852
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 11
        Width = 95
        Height = 20
        Caption = 'Funcion'#225'rios'
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
      Width = 852
      Height = 473
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        852
        473)
      object Label1: TLabel
        Left = 142
        Top = 13
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
      object Label3: TLabel
        Left = 14
        Top = 13
        Width = 59
        Height = 16
        Caption = 'Filtrar por:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edSearch: TEdit
        Left = 142
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
      end
      object Panel6: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 874
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
        Width = 823
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 2
      end
      object btnSelect: TPanel
        Left = 492
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
        Left = 585
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
      end
      object btnEdit: TPanel
        Left = 671
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
        Left = 757
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
      object dbgFuncionarios: TDBGrid
        Left = 14
        Top = 71
        Width = 823
        Height = 400
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
        OnDrawColumnCell = dbgFuncionariosDrawColumnCell
        OnDblClick = dbgFuncionariosDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cpf'
            Title.Caption = 'CPF'
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
            FieldName = 'sexo'
            Title.Caption = 'Sexo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dt_nascimento'
            Title.Caption = 'Data Nascimento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dt_admissao'
            Title.Caption = 'Data Admiss'#227'o'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'dt_demissao'
            Title.Caption = 'Data Demiss'#227'o'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'funcao'
            Title.Caption = 'Fun'#231#227'o'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'salario'
            Title.Caption = 'Sal'#225'rio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Title.Caption = 'E-mail'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'status'
            Title.Caption = 'Status'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ativo'
            Visible = False
          end>
      end
      object cbFiltro: TComboBox
        Left = 14
        Top = 32
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
        TabOrder = 8
        Text = 'C'#243'digo'
        Items.Strings = (
          'C'#243'digo'
          'CPF'
          'Nome'
          '')
      end
    end
  end
end
