object uSistemaPrincipal: TuSistemaPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 188
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    559
    188)
  PixelsPerInch = 96
  TextHeight = 13
  object btnbaixar: TSpeedButton
    Left = 352
    Top = 151
    Width = 97
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Baixar'
    OnClick = btnbaixarClick
    ExplicitLeft = 447
  end
  object SpeedButton3: TSpeedButton
    Left = 455
    Top = 151
    Width = 97
    Height = 27
    Anchors = [akTop, akRight]
    Caption = 'Fechar'
    OnClick = SpeedButton3Click
    ExplicitLeft = 550
  end
  object lblStatus: TLabel
    Left = 8
    Top = 88
    Width = 5
    Height = 18
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblPorcentDownload: TLabel
    Left = 546
    Top = 88
    Width = 5
    Height = 18
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 632
  end
  object pbProgresso: TProgressBar
    Left = 8
    Top = 112
    Width = 544
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 559
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      559
      73)
    object Label1: TLabel
      Left = 0
      Top = 18
      Width = 550
      Height = 41
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 'Atualizador do Sistema'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 645
    end
  end
  object saveDlg: TSaveDialog
    Left = 152
    Top = 144
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 96
    Top = 144
  end
  object HTTP: TIdHTTP
    OnWork = HTTPWork
    OnWorkBegin = HTTPWorkBegin
    OnWorkEnd = HTTPWorkEnd
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 32
    Top = 144
  end
end
