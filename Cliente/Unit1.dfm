object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 522
  ClientWidth = 770
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 770
    Height = 455
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 15
    Padding.Top = 15
    Padding.Right = 15
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = -11
    ExplicitWidth = 765
    ExplicitHeight = 444
    object Panel2: TPanel
      Left = 15
      Top = 113
      Width = 740
      Height = 342
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel2'
      Padding.Top = 15
      TabOrder = 0
      ExplicitWidth = 735
      ExplicitHeight = 331
      object DBGrid: TDBGrid
        Left = 0
        Top = 15
        Width = 740
        Height = 327
        Align = alClient
        BiDiMode = bdLeftToRight
        BorderStyle = bsNone
        DrawingStyle = gdsGradient
        GradientStartColor = clCream
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ImeMode = imOpen
        Options = [dgTitles, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgMultiSelect, dgTitleHotTrack]
        ParentBiDiMode = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object pnlSearch: TPanel
      AlignWithMargins = True
      Left = 18
      Top = 18
      Width = 734
      Height = 92
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Padding.Right = 30
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 729
      object Label2: TLabel
        Left = 47
        Top = 23
        Width = 73
        Height = 40
        Caption = 'Lotes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Panel9: TPanel
        Left = 202
        Top = 0
        Width = 296
        Height = 92
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 197
        object Label1: TLabel
          Left = 0
          Top = 18
          Width = 47
          Height = 20
          Caption = 'Buscar'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edSearch: TEdit
          Left = 0
          Top = 44
          Width = 290
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object Panel10: TPanel
        Left = 498
        Top = 0
        Width = 206
        Height = 92
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 493
        object cbSearchType: TComboBox
          Left = 16
          Top = 44
          Width = 190
          Height = 25
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          Text = 'Buscar por:'
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 455
    Width = 770
    Height = 67
    Align = alBottom
    BevelOuter = bvNone
    Color = clMenu
    Padding.Right = 35
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = -11
    ExplicitTop = 416
    ExplicitWidth = 765
    DesignSize = (
      770
      67)
    object btnEdit: TPanel
      Left = 534
      Top = 15
      Width = 93
      Height = 39
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Editar'
      Color = 7893767
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 529
    end
    object btnDelete: TPanel
      Left = 427
      Top = 15
      Width = 93
      Height = 39
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Excluir'
      Color = clMaroon
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 422
    end
    object btnAdd: TPanel
      Left = 642
      Top = 15
      Width = 93
      Height = 39
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Adicionar'
      Color = 620302
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 637
    end
    object pnlExit: TPanel
      Left = 35
      Top = 15
      Width = 93
      Height = 39
      Cursor = crHandPoint
      BevelOuter = bvNone
      Color = 3553279
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      object btnExit: TSpeedButton
        Left = 0
        Top = 0
        Width = 93
        Height = 39
        Align = alClient
        Caption = 'Sair'
        Flat = True
        ExplicitLeft = 32
        ExplicitTop = 8
        ExplicitWidth = 23
        ExplicitHeight = 22
      end
    end
  end
end
