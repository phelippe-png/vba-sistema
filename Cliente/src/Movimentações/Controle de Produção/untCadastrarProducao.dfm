object formCadastrarProducao: TformCadastrarProducao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Controle de Produ'#231#227'o'
  ClientHeight = 501
  ClientWidth = 860
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 860
    Height = 432
    Align = alClient
    BevelOuter = bvNone
    Color = cl3DLight
    Padding.Left = 25
    Padding.Top = 15
    Padding.Right = 25
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      860
      432)
    object Label1: TLabel
      Left = 254
      Top = 13
      Width = 86
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Data de In'#237'cio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 13
      Top = 9
      Width = 69
      Height = 20
      Caption = 'Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 410
      Top = 13
      Width = 120
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Data de Finaliza'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 18
      Top = 30
      Width = 75
      Height = 17
      Caption = 'Raz'#227'o Social:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object lblRazao: TLabel
      Left = 96
      Top = 30
      Width = 122
      Height = 19
      Caption = 'N'#227'o selecionado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFantasia: TLabel
      Left = 110
      Top = 44
      Width = 122
      Height = 19
      Caption = 'N'#227'o selecionado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 18
      Top = 44
      Width = 89
      Height = 17
      Caption = 'Nome Fantasia:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object btnBuscarEmpresa: TImage
      Left = 75
      Top = 4
      Width = 30
      Height = 30
      Cursor = crHandPoint
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
        00100804000000B5FA37EA0000000273424954080855EC460400000009704859
        73000003E3000003E3013C487B630000001974455874536F6674776172650077
        77772E696E6B73636170652E6F72679BEE3C1A0000012C4944415478DA75D14F
        28844118C7F1EFB8509652BB9693C346A1780FBC6752928BC392DC3729C79556
        29FF0E28B988B6B40717CA4AEB808BC8C58D62C36589E396C31E44A11EF37AD7
        F4EE5BFBBB4C3DF39967A66794E0448599A21B8B3CD7EC4B0613E50015254990
        02B78469A1825D26A56080EAE19C3726E4B0D86B9328A732580404C812C2929C
        A7ED3631629272C13069E2B28E27AA96275EA5CB05CB246893474AA28E182020
        DF0E48EB1BABE4CB07D688D3EC5CAB5862960EC9FAC031FD543BC71443649893
        C592ED20395EC472DF50C90D116CB933DB8A3D46199183FF39D85CF1C1343BF2
        A90BED6CD0CBB344BC93EC2345133F3CD040BD2EE4F544572561805E6A18FFFB
        8B778DB6B8E70C9B059937C01F55C7059DCCC84A19A049884B5A192B0B3469E4
        84E42F7E945FC2E0B0294F0000000049454E44AE426082}
      Proportional = True
      OnClick = btnBuscarEmpresaClick
    end
    object Label5: TLabel
      Left = 28
      Top = 100
      Width = 55
      Height = 26
      Caption = 'Lotes'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 739
      Top = 98
      Width = 91
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Lotes a Produzir'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object lblLotesProduzir: TLabel
      Left = 808
      Top = 112
      Width = 22
      Height = 17
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '0/0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 385
      Top = 107
      Width = 97
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Lotes Conclu'#237'dos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 523
      Top = 107
      Width = 164
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Lotes Conclu'#237'dos(em edi'#231#227'o)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 230
      Top = 107
      Width = 109
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Lotes em Produ'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 615
      Top = 13
      Width = 39
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Status'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblStatus: TLabel
      Left = 615
      Top = 28
      Width = 114
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Em cadastramento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMenuHighlight
      Font.Height = -12
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label17: TLabel
      Left = 310
      Top = 86
      Width = 104
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Lotes Adicionados'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 450
      Top = 86
      Width = 161
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Lotes Aguardando Produ'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object dbgLotesProducao: TDBGrid
      Left = 25
      Top = 130
      Width = 810
      Height = 302
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgMultiSelect]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Product Sans'
      TitleFont.Style = [fsBold]
      OnDrawColumnCell = dbgLotesProducaoDrawColumnCell
      OnDblClick = dbgLotesProducaoDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'status'
          Title.Caption = 'Status'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id_corpoproducao'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'id_lote'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'op'
          Title.Caption = 'OP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Descri'#231#227'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Title.Caption = 'Quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_unit'
          Title.Caption = 'Valor Unit'#225'rio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_total'
          Title.Caption = 'Valor Total'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tempo_min'
          Title.Caption = 'Tempo Minutos'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tempo_total'
          Title.Caption = 'Tempo Total'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'finalizado'
          Visible = False
        end>
    end
    object pnlBtnAddLotes: TPanel
      Left = 88
      Top = 98
      Width = 30
      Height = 30
      Cursor = crHandPoint
      BevelOuter = bvNone
      Color = 489483
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object btnAddLotes: TImage
        Left = 0
        Top = 0
        Width = 30
        Height = 30
        Cursor = crHandPoint
        Align = alClient
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
          00101004000000E56AEBA90000000467414D410000B18F0BFC61050000000262
          4B47440000AA8D23320000000970485973000000600000006000F06B42CF0000
          000774494D4507E60A1C171B0202E7BDFA0000007E4944415478DA6364C001FE
          33C801C93D509E330323C363ACEA18711B900924A74179594085D34935200F48
          4E84F2F2810A270D5B0320A1ED06C44C68525E40EC0F656F04E26D68F2FF8078
          17C8805B40862A0379E016C8809B40861A9906DC0419200B64B893E9859D8321
          1606B3011467265002DB0D663130B8E2CCCE00ECC934F96CE300E60000002574
          455874646174653A63726561746500323032322D31302D32385432333A32373A
          30322B30303A3030910F804E0000002574455874646174653A6D6F6469667900
          323032322D31302D32385432333A32373A30322B30303A3030E05238F2000000
          2874455874646174653A74696D657374616D7000323032322D31302D32385432
          333A32373A30322B30303A3030B747192D0000000049454E44AE426082}
        Proportional = True
        OnClick = btnAddLotesClick
        ExplicitLeft = -1
        ExplicitTop = -4
      end
    end
    object pickerInicio: TDateTimePicker
      Left = 254
      Top = 30
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Date = 44862.000000000000000000
      Time = 0.792653842589061200
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object pickerFinal: TDateTimePicker
      Left = 410
      Top = 30
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Date = 44862.000000000000000000
      Time = 0.792653842589061200
      Font.Charset = EASTEUROPE_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object btnCancel: TPanel
      Left = 777
      Top = 45
      Width = 74
      Height = 30
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Cancelar'
      Color = clRed
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
      OnClick = btnCancelClick
    end
    object btnSave: TPanel
      Left = 777
      Top = 9
      Width = 74
      Height = 30
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Caption = 'Salvar'
      Color = 489483
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -15
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 5
      OnClick = btnSaveClick
    end
    object pnlBtnDelLotes: TPanel
      Left = 123
      Top = 98
      Width = 30
      Height = 30
      Cursor = crHandPoint
      BevelOuter = bvNone
      Color = clRed
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
      object btnDelLotes: TImage
        Left = 0
        Top = 0
        Width = 30
        Height = 30
        Cursor = crHandPoint
        Align = alClient
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
          001810040000001AEE29300000000467414D410000B18F0BFC61050000000262
          4B47440000AA8D23320000000970485973000000600000006000F06B42CF0000
          000774494D4507E60A1C17233743CBC5220000020C4944415478DAB5963F6853
          411CC7EF39288A832543023AE8D23F88A0080E4ECD60078558217448A1A43838
          D421B683162C8982438318C4C9C5D0D23A145A5AB15B313874525A2BE26044D2
          828882A1526802429E9F7BEFC10B31EFDD4F82079F1FBFDFFBDDFDBE777977F7
          62A9FFDC2C49275B45B1A7E180F7A4011F18FCA373015B0D6097E1704BA60609
          0AAC752AF0027B066E3B913F6C1ADEE35D9509D82A823D0747A1BBA9CB0D6FF6
          AB2D43AF78AB78DAF4AC0C7BB049E19FAD02F3D894F13795B5E7141E0E5A410E
          7A21EF658EC0F180425F61DFF327E03364DBAFC0172A622F9388FED39C6D55C1
          961837DAFE1DF81D1F61C7481C6A5A99726614E4BBFD76B145E25B268129EC7D
          A55FACA5EADE2ED21D1321BE3E1FBF9D7196BA6712B8897D023192DF894B5EC7
          7888DF8557850CF16393807EFB73D043F29350E014DE174813CF9804F4FE7E09
          1748BE110AE8DDB70183C42B26818BD875B8E45C03328138DE2BE8277E6D12E8
          C37E8424C945A1C035BC25384BBC65128861BFC17592CF840269A59CF3739278
          DB24A0F77F1DC64916840219BC021C23FE152EE08AE8E39F2799139E831CDE5D
          3848DC9008E83B66C13995EE89B5F1AB21BE9EFD087EE4AF5A01026FB1159249
          2569369B415F9096F3D5130964BD254FC23B43F9F3F0001E52EC8E5440BFE859
          1812ADC0FDA4A628569309F8422794BE3282BBE94F6899EC4E600DD1BF8A4EDA
          1FD27ABC19FEF31F9E0000002574455874646174653A63726561746500323032
          322D31302D32385432333A33353A35352B30303A3030D933BF59000000257445
          5874646174653A6D6F6469667900323032322D31302D32385432333A33353A35
          352B30303A3030A86E07E50000002874455874646174653A74696D657374616D
          7000323032322D31302D32385432333A33353A35352B30303A3030FF7B263A00
          00000049454E44AE426082}
        Proportional = True
        OnClick = btnDelLotesClick
      end
    end
    object Panel5: TPanel
      Left = 366
      Top = 109
      Width = 13
      Height = 13
      BevelOuter = bvLowered
      Color = clGreen
      ParentBackground = False
      TabOrder = 7
    end
    object Panel6: TPanel
      Left = 504
      Top = 109
      Width = 13
      Height = 13
      BevelOuter = bvLowered
      Color = 10405376
      ParentBackground = False
      TabOrder = 8
    end
    object Panel7: TPanel
      Left = 211
      Top = 109
      Width = 13
      Height = 12
      BevelOuter = bvLowered
      Color = 41960
      ParentBackground = False
      TabOrder = 9
    end
    object Panel8: TPanel
      Left = 291
      Top = 88
      Width = 13
      Height = 13
      BevelOuter = bvLowered
      Color = 8454143
      ParentBackground = False
      TabOrder = 10
    end
    object Panel9: TPanel
      Left = 431
      Top = 88
      Width = 13
      Height = 13
      BevelOuter = bvLowered
      Color = 16751176
      ParentBackground = False
      TabOrder = 11
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 432
    Width = 860
    Height = 69
    Align = alBottom
    BevelOuter = bvNone
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Padding.Left = 20
    Padding.Right = 20
    Padding.Bottom = 20
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      860
      69)
    object Label8: TLabel
      Left = 362
      Top = 11
      Width = 86
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Valor Total'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object lblValorTotal: TLabel
      Left = 381
      Top = 34
      Width = 67
      Height = 21
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
      Caption = 'R$ 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTempo: TLabel
      Left = 789
      Top = 34
      Width = 41
      Height = 21
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 630
      Top = 11
      Width = 200
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Tempo Total em Minutos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 30
      Top = 5
      Width = 98
      Height = 24
      Caption = 'Quantidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object quantTotal: TLabel
      Left = 80
      Top = 24
      Width = 13
      Height = 24
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 39
      Top = 27
      Width = 42
      Height = 20
      Caption = 'Total: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 39
      Top = 43
      Width = 82
      Height = 20
      Caption = 'A Produzir: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Product Sans'
      Font.Style = []
      ParentFont = False
    end
    object quantProduzir: TLabel
      Left = 120
      Top = 41
      Width = 13
      Height = 24
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Product Sans'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object ImageList1: TImageList
    ColorDepth = cd16Bit
    DrawingStyle = dsTransparent
    Left = 816
    Top = 80
    Bitmap = {
      494C010101000800040010001000FFFFFFFF1110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      000000000000000000000000000000000000000000000000000000000000630C
      7B6F7B6F630C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000630C8C318C318C318C318C31D65A
      FF7FFF7FD65A8C318C318C318C318C31630C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B6FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B6FFF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F7B6F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000630C8C318C318C318C318C31D65A
      FF7FFF7FD65A8C318C318C318C318C31630C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD35
      FF7FFF7FAD350000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000630C
      7B6F7B6F630C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
