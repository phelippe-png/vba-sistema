object formCadastrarPonto: TformCadastrarPonto
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 479
  ClientWidth = 732
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Product Sans'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    732
    479)
  PixelsPerInch = 96
  TextHeight = 14
  object lblTime: TLabel
    Left = 8
    Top = 45
    Width = 88
    Height = 37
    Caption = 'Tempo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 6
    Width = 181
    Height = 34
    Caption = 'Registrar Ponto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 140
    Top = 229
    Width = 151
    Height = 25
    Caption = 'Informe seu CPF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAviso: TLabel
    Left = 140
    Top = 310
    Width = 4
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -20
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 682
    Top = 1
    Width = 60
    Height = 41
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -31
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    OnClick = Panel1Click
  end
  object edtCPF: TEdit
    Left = 140
    Top = 253
    Width = 346
    Height = 50
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Product Sans'
    Font.Style = []
    MaxLength = 14
    ParentFont = False
    TabOrder = 1
    OnChange = edtCPFChange
    OnKeyDown = edtCPFKeyDown
    OnKeyPress = edtCPFKeyPress
  end
  object btnConfirmar: TPanel
    Left = 488
    Top = 253
    Width = 105
    Height = 50
    Cursor = crHandPoint
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'Confirmar'
    Color = 489483
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -17
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    OnClick = btnConfirmarClick
  end
  object btnObservacoes: TPanel
    Left = 576
    Top = 440
    Width = 148
    Height = 31
    Cursor = crHandPoint
    Anchors = [akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'Aplicar observa'#231#245'es'
    Color = 12615680
    DragCursor = crDefault
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    OnClick = btnObservacoesClick
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 672
    Top = 168
  end
end
