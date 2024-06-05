object formPagamentosAnteriores: TformPagamentosAnteriores
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Pagamentos Anteriores'
  ClientHeight = 517
  ClientWidth = 985
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
    Width = 985
    Height = 517
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      985
      517)
    object Label1: TLabel
      Left = 259
      Top = 260
      Width = 123
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Observa'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 896
      Top = 469
      Width = 84
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Valor Pago'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 827
      Top = 375
      Width = 153
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Data de Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 631
      Top = 269
      Width = 146
      Height = 17
      Cursor = crHandPoint
      Anchors = [akRight, akBottom]
      Caption = 'Observa'#231#245'es detalhadas'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      OnClick = Label8Click
    end
    object Label9: TLabel
      Left = 934
      Top = 422
      Width = 46
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Faltas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDataPagamento: TLabel
      Left = 863
      Top = 395
      Width = 117
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'N'#195'O DEFINIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object lblFaltas: TLabel
      Left = 863
      Top = 440
      Width = 117
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'N'#195'O DEFINIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object lblValorPago: TLabel
      Left = 863
      Top = 488
      Width = 117
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'N'#195'O DEFINIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 929
      Top = 332
      Width = 51
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 863
      Top = 350
      Width = 117
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'N'#195'O DEFINIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 3
      Top = 11
      Width = 140
      Height = 19
      Caption = 'Filtrar com o ano de:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cvCalendarioPagAnterior: TCalendarView
      Left = 0
      Top = 260
      Width = 254
      Height = 257
      Anchors = [akLeft, akBottom]
      Date = 45050.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Product Sans'
      Font.Style = []
      HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      HeaderInfo.DaysOfWeekFont.Color = clWindowText
      HeaderInfo.DaysOfWeekFont.Height = -13
      HeaderInfo.DaysOfWeekFont.Name = 'Product Sans'
      HeaderInfo.DaysOfWeekFont.Style = []
      HeaderInfo.Font.Charset = DEFAULT_CHARSET
      HeaderInfo.Font.Color = clWindowText
      HeaderInfo.Font.Height = -20
      HeaderInfo.Font.Name = 'Product Sans'
      HeaderInfo.Font.Style = []
      OnChange = cvCalendarioPagAnteriorChange
      OnDrawDayItem = cvCalendarioPagAnteriorDrawDayItem
      ParentFont = False
      TabOrder = 0
    end
    object dbgPagamentosAnteriores: TDBGrid
      Left = 3
      Top = 40
      Width = 979
      Height = 204
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgMultiSelect]
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Product Sans'
      TitleFont.Style = [fsBold]
      OnCellClick = dbgPagamentosAnterioresCellClick
      OnDrawColumnCell = dbgPagamentosAnterioresDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'numero_mes'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'mes'
          Title.Caption = 'M'#234's'
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
          FieldName = 'valor_pago'
          Title.Caption = 'Valor Pagamento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'faltas'
          Title.Caption = 'Faltas'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status'
          Title.Caption = 'Status'
          Visible = True
        end>
    end
    object mmObservacaoPagAnterior: TMemo
      Left = 259
      Top = 287
      Width = 518
      Height = 230
      Anchors = [akLeft, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object Panel7: TPanel
      AlignWithMargins = True
      Left = -100
      Top = 252
      Width = 2005
      Height = 1
      Anchors = [akLeft, akRight, akBottom]
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 3
    end
    object btnConfirmarPagamento: TPanel
      Left = 814
      Top = 259
      Width = 166
      Height = 38
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Confirmar pagamento'
      Color = 10658466
      DragCursor = crDefault
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      OnClick = btnConfirmarPagamentoClick
    end
    object dtpFiltroAno: TDatePicker
      Left = 149
      Top = 4
      Width = 73
      Date = 45067.000000000000000000
      DateFormat = 'yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      TabOrder = 5
      OnChange = dtpFiltroAnoChange
    end
  end
end
