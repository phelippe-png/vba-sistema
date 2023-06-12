object formPagamentos: TformPagamentos
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  ClientHeight = 522
  ClientWidth = 747
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 522
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      747
      522)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 721
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 10
        Width = 206
        Height = 20
        Caption = 'Pagamento de Funcion'#225'rios'
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
      Width = 721
      Height = 462
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        721
        462)
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
      end
      object pnlSearch: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 0
        Width = 715
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
        Width = 692
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 2
      end
      object btnSelect: TPanel
        Left = 616
        Top = 21
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
      object dbgPagamentos: TDBGrid
        Left = 14
        Top = 71
        Width = 692
        Height = 391
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgMultiSelect]
        ParentFont = False
        TabOrder = 4
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Product Sans'
        TitleFont.Style = [fsBold]
        OnDrawColumnCell = dbgPagamentosDrawColumnCell
        OnDblClick = dbgPagamentosDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Funcion'#225'rio'
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
            FieldName = 'salario'
            Title.Caption = 'Sal'#225'rio'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data_pagamento'
            Title.Caption = 'Data Pagamento'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status_descricao'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Product Sans'
            Font.Style = [fsBold]
            Title.Caption = 'Status'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
            Title.Caption = 'Status'
            Visible = False
          end>
      end
    end
  end
end
