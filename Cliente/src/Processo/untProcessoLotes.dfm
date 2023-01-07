object untProcesso: TuntProcesso
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Calcular Tempos'
  ClientHeight = 364
  ClientWidth = 671
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 364
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = -94
    ExplicitTop = -147
    ExplicitWidth = 765
    ExplicitHeight = 511
    DesignSize = (
      671
      364)
    object Label8: TLabel
      Left = 525
      Top = 310
      Width = 126
      Height = 30
      Alignment = taCenter
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      Caption = 'Total Minutos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object lblTotal: TLabel
      Left = 620
      Top = 334
      Width = 31
      Height = 21
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
    end
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 645
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 739
      DesignSize = (
        645
        38)
      object lblTitle: TLabel
        Left = 0
        Top = 10
        Width = 125
        Height = 21
        Caption = 'Calcular Tempos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnDelete: TPanel
        Left = 552
        Top = 6
        Width = 86
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'EXCLUIR'
        Color = clMaroon
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object btnAdd: TPanel
        Left = 459
        Top = 6
        Width = 87
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'ADICIONAR'
        Color = 620302
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        OnClick = btnAddClick
      end
    end
    object pnlContainer: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 47
      Width = 645
      Height = 258
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        645
        258)
      object DBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 645
        Height = 258
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        Color = clBtnHighlight
        Ctl3D = True
        DrawingStyle = gdsGradient
        GradientEndColor = clMedGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgMultiSelect, dgTitleHotTrack]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object pnlSearch: TPanel
        AlignWithMargins = True
        Left = -2
        Top = 0
        Width = 650
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 4210688
        ParentBackground = False
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      Left = 99
      Top = 320
      Width = 126
      Height = 30
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = 'GERAR RELAT'#211'RIO'
      Color = 33023
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnExit: TPanel
      Left = 13
      Top = 320
      Width = 80
      Height = 30
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = 'SAIR'
      Color = clRed
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
  end
end
