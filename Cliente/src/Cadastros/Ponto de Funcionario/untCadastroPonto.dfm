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
  DesignSize = (
    732
    479)
  PixelsPerInch = 96
  TextHeight = 14
  object lblTime: TLabel
    Left = 8
    Top = 45
    Width = 88
    Height = 35
    Caption = 'Tempo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 6
    Width = 184
    Height = 33
    Caption = 'Registrar Ponto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 129
    Top = 217
    Width = 146
    Height = 24
    Caption = 'Informe seu CPF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnObservacoes: TSpeedButton
    Left = 600
    Top = 440
    Width = 124
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Observa'#231#245'es'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 289
    Top = 301
    Width = 6
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 532
    Top = 242
    Width = 70
    Height = 48
    Anchors = [akTop, akRight]
    Caption = 'Inserir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Product Sans'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object Panel1: TPanel
    Left = 664
    Top = 8
    Width = 60
    Height = 41
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -31
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Panel1Click
  end
  object edtCPF: TEdit
    Left = 129
    Top = 242
    Width = 400
    Height = 48
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 14
    ParentFont = False
    TabOrder = 1
    OnChange = edtCPFChange
    OnKeyPress = edtCPFKeyPress
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 672
    Top = 168
  end
end
