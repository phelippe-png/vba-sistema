object formControlePagamentos: TformControlePagamentos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Controle de Pagamento'
  ClientHeight = 571
  ClientWidth = 994
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
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 994
    Height = 571
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      994
      571)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 968
      Height = 50
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        968
        50)
      object lblFuncionario: TLabel
        Left = 1
        Top = -2
        Width = 117
        Height = 25
        Caption = 'Funcion'#225'rio: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDataOcorrencia: TLabel
        Left = 1
        Top = 23
        Width = 220
        Height = 25
        Caption = 'M'#234's/ano de ocorr'#234'ncia: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnConfirmarPagamento: TPanel
        Left = 687
        Top = 3
        Width = 177
        Height = 38
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Confirmar pagamento'
        Color = 489483
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = btnConfirmarPagamentoClick
      end
      object btnCancel: TPanel
        Left = 870
        Top = 3
        Width = 93
        Height = 38
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Cancelar'
        Color = clRed
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        OnClick = btnCancelClick
      end
    end
    object pnlContainer: TPanel
      AlignWithMargins = True
      Left = 14
      Top = 50
      Width = 968
      Height = 511
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        968
        511)
      object Label2: TLabel
        Left = 338
        Top = 238
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
        ExplicitTop = 231
      end
      object Label7: TLabel
        Left = 818
        Top = 246
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
        OnClick = Label7Click
        ExplicitLeft = 751
        ExplicitTop = 239
      end
      object lblSalario: TLabel
        Left = 3
        Top = 5
        Width = 69
        Height = 25
        Caption = 'Sal'#225'rio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnAlterarSalario: TSpeedButton
        Left = 78
        Top = 7
        Width = 23
        Height = 22
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Product Sans'
        Font.Style = []
        Glyph.Data = {
          E6040000424DE604000000000000360000002800000014000000140000000100
          180000000000B0040000C40E0000C40E00000000000000000000F5F5F5C9C9C9
          F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5C5C50000002D2D2D67
          6767ABABABDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F42929297C7C7C7D7D7D4040
          403C3C3C636363AEAEAEFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE646464828282FFFFFFF0F0F0C4C4C4
          3F3F3F000000747474FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFA8A8A8424242F2F2F2FFFFFFB8B8B810101098
          9898252525646464FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFDCDCDC3C3C3CC7C7C7B8B8B8000000C9C9C9FFFFFFFAFA
          FA131313646464FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF5E5E5E414141111111C9C9C9FFFFFFFFFFFFFFFFFFFAFAFA
          1C1C1C6A6A6AFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFA9A9A9000000989898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF34
          34346A6A6AFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FBFBFB6E6E6E232323F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D7D73636
          36696969FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF5F5F5F111111F7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF1C1C1C
          646464FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF5F5F5F191919DCDCDCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFA13131364
          6464FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          666666323232D6D6D6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFA1C1C1C6B6B
          6BFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB67
          6767333333DFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E2E23737376D6D6D
          FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC6666
          661C1C1CFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFF4F4F42C2C2C0000007F7F7FFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF606060
          151515FBFBFBFFFFFFFFFFFFFFFFFF1313135A5A5ACFCFCF1A1A1AE1E1E1FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6060601D
          1D1DE3E3E3F4F4F41313135E5E5EFFFFFFFFFFFF2E2E2EB5B5B5FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6868683838
          382D2D2D5A5A5AFFFFFFFFFFFFB3B3B3202020E8E8E8FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC6A6A6A000000
          D4D4D4FFFFFFB2B2B2292929979797FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB7B7B7B1A1A1A31
          3131212121989898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCDCAFAFAFE6E6
          E6FFFFFFFFFFFFFFFFFF}
        ParentFont = False
        OnClick = btnAlterarSalarioClick
      end
      object pnlLine: TPanel
        AlignWithMargins = True
        Left = -20
        Top = 1
        Width = 1067
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 4210688
        ParentBackground = False
        TabOrder = 0
      end
      object cvCalendarioPagAtual: TCalendarView
        Left = 3
        Top = 235
        Width = 329
        Height = 273
        Anchors = [akLeft, akBottom]
        Date = 45046.000000000000000000
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
        OnChange = cvCalendarioPagAtualChange
        OnDrawDayItem = cvCalendarioPagAtualDrawDayItem
        ParentFont = False
        TabOrder = 1
      end
      object mmObservacao: TMemo
        Left = 338
        Top = 261
        Width = 626
        Height = 247
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
      object Panel5: TPanel
        Left = 3
        Top = 34
        Width = 336
        Height = 193
        Anchors = [akLeft, akTop, akBottom]
        BevelOuter = bvNone
        TabOrder = 3
        object Panel1: TPanel
          Left = 335
          Top = 1
          Width = 1
          Height = 191
          Align = alRight
          TabOrder = 0
          Visible = False
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 336
          Height = 1
          Align = alTop
          TabOrder = 1
          Visible = False
        end
        object Panel3: TPanel
          Left = 0
          Top = 1
          Width = 1
          Height = 191
          Align = alLeft
          TabOrder = 2
          Visible = False
        end
        object Panel4: TPanel
          Left = 0
          Top = 192
          Width = 336
          Height = 1
          Align = alBottom
          TabOrder = 3
          Visible = False
        end
        object sbxBeneficios: TScrollBox
          Left = 1
          Top = 1
          Width = 334
          Height = 191
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          ParentColor = False
          TabOrder = 4
          OnMouseWheelDown = sbxBeneficiosMouseWheelDown
          OnMouseWheelUp = sbxBeneficiosMouseWheelUp
        end
      end
      object btnPagamentosAnteriores: TPanel
        Left = 686
        Top = 9
        Width = 276
        Height = 38
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Verificar pagamentos anteriores'
        Color = 12615680
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Product Sans'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = btnPagamentosAnterioresClick
      end
    end
  end
end
