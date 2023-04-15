unit untCadastrarProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, untListarEmpresas, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, untListarLotes, Datasnap.DBClient, functions,
  Vcl.Imaging.pngimage, untclasseproducao, System.JSON, IdHTTP, DataSet.Serialize,
  BancoFuncoes, System.Generics.Collections, FireDAC.Comp.Client;

type
  TformCadastrarProducao = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    dbgLotesProducao: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    pnlBtnAddLotes: TPanel;
    Label3: TLabel;
    pickerInicio: TDateTimePicker;
    pickerFinal: TDateTimePicker;
    btnCancel: TPanel;
    btnSave: TPanel;
    Label7: TLabel;
    lblRazao: TLabel;
    lblFantasia: TLabel;
    Label6: TLabel;
    pnlBtnDelLotes: TPanel;
    ImageList1: TImageList;
    Label8: TLabel;
    lblValorTotal: TLabel;
    lblTempo: TLabel;
    Label11: TLabel;
    btnBuscarEmpresa: TImage;
    Label5: TLabel;
    Label9: TLabel;
    lblLotesProduzir: TLabel;
    Label13: TLabel;
    quantTotal: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    quantProduzir: TLabel;
    Label4: TLabel;
    Panel5: TPanel;
    Label10: TLabel;
    Panel6: TPanel;
    Label12: TLabel;
    Panel7: TPanel;
    Label14: TLabel;
    lblStatus: TLabel;
    Label17: TLabel;
    Panel8: TPanel;
    Label18: TLabel;
    Panel9: TPanel;
    btnAddLotes: TImage;
    btnDelLotes: TImage;
    procedure btnAddLotesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure dbgLotesProducaoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnDelLotesClick(Sender: TObject);
    procedure dbgLotesProducaoDblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    idProducao: integer;
    idEmpresa: integer;
    empresa: string;
    untEmpresas: TformListarEmpresas;
    untLotes: TformListarLotes;
    classProducao: TProducao;
    resultadoQuantidade: integer;
    resultadoQuantidadeProduzir: integer;
    resultadoValor: Currency;
    resultadoTempo: Double;
    arrayLotesAdicionados: TJSONArray;
    arrayLotesExcluidos: TJSONArray;
    arrayLotesConcluidos: TJSONArray;
    vFDMLotes: TFDMemTable;

    vObject: TJSONObject;


    procedure calcularValores;
    procedure inserirStatus;
    procedure verificarStatus;
    procedure configurarDataSet;
  public
    editar: boolean;
    vStatus: string;

    procedure carregarDados(vDicDados: TDictionary<String, Variant>);
    procedure removerIndexArray;
  end;

var
  formCadastrarProducao: TformCadastrarProducao;

implementation

{$R *.dfm}

procedure TformCadastrarProducao.btnBuscarEmpresaClick(Sender: TObject);
var
  vModalEmpresas: TformListarEmpresas;
begin
  try
    vModalEmpresas := TformListarEmpresas.Create(Self);
    with vModalEmpresas do
    begin
      mudarEstadoDBGrid := true;
      BorderStyle := bsSingle;
      Align := alNone;
      esconderColunas := true;
      ShowModal;

      if selecionado then
      begin
        idEmpresa := dbgEmpresas.DataSource.DataSet.FieldByName('id').AsInteger;
        empresa := dbgEmpresas.DataSource.DataSet.FieldByName('razaosocial').AsString;
        lblRazao.Caption := dbgEmpresas.DataSource.DataSet.FieldByName('razaosocial').AsString;
        lblFantasia.Caption := dbgEmpresas.DataSource.DataSet.FieldByName('nomefantasia').AsString;
      end;
    end;
  finally
    vModalEmpresas.Destroy;
  end;
end;

procedure TformCadastrarProducao.inserirStatus;
begin
  with dbgLotesProducao.DataSource.DataSet do
  begin
    First;
    while not Eof do
    begin
      if vStatus = 'EM ABERTO' then
      begin
        Edit;
        FieldByName('status').AsString := 'AGUARDANDO';
        Post;
      end;

      if (FieldByName('finalizado').AsBoolean) and (vStatus <> 'EM ABERTO') then
      begin
        Edit;
        FieldByName('status').AsString := 'CONCLUÍDO';
        Post;
      end;

      if (FieldByName('finalizado').AsBoolean = false) and (vStatus <> 'EM ABERTO') then
      begin
        Edit;
        FieldByName('status').AsString := 'EM PRODUÇÃO';
        Post;
      end;

      Next;
    end;
  end;
end;

procedure TformCadastrarProducao.removerIndexArray;
var
  I: Integer;
begin
  with dbgLotesProducao.DataSource.DataSet do
  begin
    for I := 0 to arrayLotesAdicionados.Count - 1 do
    begin
      if arrayLotesAdicionados.Get(I).GetValue<integer>('id_lote') = FieldByName('id_lote').AsInteger then
      begin
        arrayLotesAdicionados.Remove(I);
        break;
      end;
    end;

    for I := 0 to arrayLotesConcluidos.Count - 1 do
    begin
      if arrayLotesConcluidos.Get(I).GetValue<integer>('id_lote') = FieldByName('id_lote').AsInteger then
      begin
        arrayLotesConcluidos.Remove(I);
        break;
      end;
    end;
  end;
end;

procedure TformCadastrarProducao.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformCadastrarProducao.btnSaveClick(Sender: TObject);
var
  I: Integer;
  s: string;
begin
  with dbgLotesProducao.DataSource.DataSet do
  begin
    if idEmpresa = 0 then
    begin
      Application.MessageBox('Selecione uma empresa!', 'Atenção', MB_ICONWARNING + MB_OK);
      exit;
    end;

    if pickerFinal.Date < pickerInicio.Date then
    begin
      Application.MessageBox('As datas informadas são inválidas!', 'Atenção', MB_ICONWARNING + MB_OK);
      exit;
    end;

    if RecordCount = 0 then
    begin
      Application.MessageBox('Selecione pelo menos um lote na produção!', 'Atenção', MB_ICONWARNING + MB_OK);
      exit;
    end;

    classProducao.idProducao := idProducao;
    classProducao.idEmpresa := idEmpresa;
    classProducao.empresa := empresa;
    classProducao.dataInicio := pickerInicio.Date;
    classProducao.dataFinal := pickerFinal.Date;
    classProducao.quantidadeTotal := resultadoQuantidade;
    classProducao.quantidadeProduzir := resultadoQuantidadeProduzir;
    classProducao.valorTotal := resultadoValor;
    classProducao.tempoTotal := resultadoTempo;

    if classProducao.modo = 'editar' then
      classProducao.enviarDadosProducao
    else
      classProducao.idProducao := classProducao.enviarDadosProducao;

    for I := 0 to arrayLotesAdicionados.Count - 1 do
    begin
      classProducao.modo := 'adicionar';
      classProducao.idLote := arrayLotesAdicionados.Get(I).GetValue<integer>('id_lote');
      classProducao.finalizado := arrayLotesAdicionados.Get(I).GetValue<boolean>('finalizado');
      classProducao.enviarDadosCorpoProducao;
    end;

    for I := 0 to arrayLotesConcluidos.Count - 1 do
    begin
      classProducao.modo := 'editar';
      classProducao.idLote := arrayLotesConcluidos.Get(I).GetValue<integer>('id_lote');
      classProducao.finalizado := true;
      classProducao.idCorpoProducao := arrayLotesConcluidos.Get(I).GetValue<integer>('id_corpoproducao');
      classProducao.valorLote := arrayLotesConcluidos.Get(I).GetValue<currency>('valor');
      classProducao.enviarDadosCorpoProducao;
      classProducao.enviarDadosContasReceber;
    end;

    for I := 0 to arrayLotesExcluidos.Count - 1 do
    begin
      classProducao.modo := 'excluir';
//      classProducao.idLote := arrayLotesExcluidos.Get(I).GetValue<integer>('id_lote');
//      classProducao.idCorpoProducao := arrayLotesExcluidos.Get(I).GetValue<integer>('id_corpoproducao');
      classProducao.excluirCorpoProducao(arrayLotesExcluidos.Get(I).GetValue<integer>('id_corpoproducao'));
    end;

    if not editar then
      Application.MessageBox('Cadastro efetuado com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK)
    else
      Application.MessageBox('Alteração efetuada com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);

    Self.Close;
  end;
end;

procedure TformCadastrarProducao.calcularValores;
var
  I: Integer;
  lotesProduzir, quantidadeLotes: integer;
begin
  resultadoQuantidade := 0;
  resultadoValor := 0;
  resultadoTempo := 0;
  resultadoQuantidadeProduzir := 0;
  lotesProduzir := 0;
  quantidadeLotes := 0;

  with vFDMLotes do
  begin
    First;
    for I := 0 to RecordCount - 1 do
    begin
      resultadoQuantidade := resultadoQuantidade + FieldByName('quantidade').AsInteger;
      resultadoValor := resultadoValor + FieldByName('valor_total').AsCurrency;
      resultadoTempo := resultadoTempo + FieldByName('tempo_total').AsFloat;

      if (FieldByName('finalizado').AsBoolean = false) and
        (FieldByName('status').AsString <> 'CONCLUÍDO') then
      begin
        resultadoQuantidadeProduzir := resultadoQuantidadeProduzir + FieldByName('quantidade').AsInteger;
        lotesProduzir := lotesProduzir + 1;
      end;

      Next;
    end;

    quantTotal.Caption := IntToStr(resultadoQuantidade);
    quantProduzir.Caption := IntToStr(resultadoQuantidadeProduzir);
    lblValorTotal.Caption := FormatCurr('R$ ###,###,##0.00', resultadoValor);
    lblTempo.Caption := FormatFloat('###,###,##0.000', resultadoTempo);
    lblLotesProduzir.Caption := lotesProduzir.ToString + '/' + RecordCount.ToString;
  end;
end;

procedure TformCadastrarProducao.carregarDados(vDicDados: TDictionary<String, Variant>);
var
  idLote: integer;
  idCorpoProducao: integer;
  finalizado: boolean;

  responseDados: string;
  jsonDadosEmpresa: TJSONObject;
  jsonCorpoProducao: TJSONArray;
  jsonLote: TJSONObject;
  I: Integer;
begin
  editar := true;
  classProducao.modo := 'editar';
  verificarStatus;

  with BDBuscarRegistros('tab_empresas', EmptyStr, EmptyStr,
  ' id = ' + vDicDados.Items['id_empresa'], EmptyStr, EmptyStr, -1, 'fdqBuscarEmpresa') do
  begin
    idEmpresa := FieldByName('id').AsInteger;
    lblRazao.Caption := FieldByName('razaosocial').AsString;
    lblFantasia.Caption := FieldByName('nomefantasia').AsString;
  end;

  pickerInicio.Date := StrToDate(vDicDados.Items['data_inicio']);
  pickerFinal.Date := StrToDate(vDicDados.Items['data_final']);

  idProducao := vDicDados.Items['id'];
  with BDBuscarRegistros('tab_controleproducao_corpo', EmptyStr, EmptyStr,
  ' id_producao = ' + vDicDados.Items['id'], EmptyStr, EmptyStr, -1, 'fdqBuscaControleProducao') do
  begin
    while not Eof do
    begin
      idLote := FieldByName('id_lote').AsInteger;
      idCorpoProducao := FieldByName('id').AsInteger;
      finalizado := FieldByName('finalizado').AsBoolean;

      with BDBuscarRegistros('tab_lotes', EmptyStr, EmptyStr,
      ' id = ' + idLote.ToString, EmptyStr, EmptyStr, -1, 'fdqBuscarLote') do
      begin
        vFDMLotes.Append;
        vFDMLotes.FieldByName('id_corpoproducao').AsInteger := idCorpoProducao;
        vFDMLotes.FieldByName('id_lote').AsInteger := FieldByName('id').AsInteger;
        vFDMLotes.FieldByName('op').AsInteger := FieldByName('op').AsInteger;
        vFDMLotes.FieldByName('descricao').AsString := FieldByName('descricao').AsString;
        vFDMLotes.FieldByName('quantidade').AsInteger := FieldByName('quantidade').AsInteger;
        vFDMLotes.FieldByName('valor_unit').AsCurrency := FieldByName('valor_unit').AsCurrency;
        vFDMLotes.FieldByName('valor_total').AsCurrency := FieldByName('valor_total').AsCurrency;
        vFDMLotes.FieldByName('tempo_min').AsFloat := FieldByName('tempo_min').AsFloat;
        vFDMLotes.FieldByName('tempo_total').AsFloat := FieldByName('tempo_total').AsFloat;
        vFDMLotes.FieldByName('finalizado').AsBoolean := finalizado;
        vFDMLotes.Post;
      end;

      Next;
    end;
  end;

  calcularValores;
  inserirStatus;
  SISDBGridResizeColumns(dbgLotesProducao);
end;

procedure TformCadastrarProducao.configurarDataSet;
begin
  with vFDMLotes do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('status', ftString, 100);
    FieldDefs.Add('id_corpoproducao', ftInteger);
    FieldDefs.Add('id_lote', ftInteger);
    FieldDefs.Add('op', ftInteger);
    FieldDefs.Add('descricao', ftString, 100);
    FieldDefs.Add('quantidade', ftInteger);
    FieldDefs.Add('valor_unit', ftCurrency);
    FieldDefs.Add('valor_total', ftCurrency);
    FieldDefs.Add('tempo_min', ftFloat);
    FieldDefs.Add('tempo_total', ftCurrency);
    FieldDefs.Add('finalizado', ftBoolean);
    CreateDataSet;
  end;
end;

procedure TformCadastrarProducao.dbgLotesProducaoDblClick(Sender: TObject);
var
  jsonLote: TJSONObject;
  I: Integer;
  bookmarkCDS: TBookmark;
begin
  with dbgLotesProducao, DataSource.DataSet do
  begin
    bookmarkCDS := Bookmark;

    if (FieldByName('id_corpoproducao').AsInteger <> 0) and (FieldByName('finalizado').AsBoolean) then
      exit;

    if (FieldByName('status').AsString = 'ADICIONADO') or (FieldByName('status').AsString = 'AGUARDANDO') then
      exit;

    if FieldByName('status').AsString = 'EM PRODUÇÃO' then
    begin
      Edit;
      FieldByName('status').AsString := 'CONCLUÍDO';
      Post;
    end
    else if FieldByName('status').AsString = 'CONCLUÍDO' then
    begin
      Edit;
      FieldByName('status').AsString := 'EM PRODUÇÃO';
      Post;
    end;

    calcularValores;
    Bookmark := bookmarkCDS;

    for I := 0 to arrayLotesConcluidos.Count - 1 do
    begin
      if arrayLotesConcluidos.Get(I).GetValue<integer>('id_lote') = FieldByName('id_lote').AsInteger then
      begin
        arrayLotesConcluidos.Remove(I);
        exit;
      end;
    end;

    jsonLote := TJSONObject.Create;
    jsonLote.AddPair('id_corpoproducao', FieldByName('id_corpoproducao').AsString);
    jsonLote.AddPair('id_lote', FieldByName('id_lote').AsString);
    jsonLote.AddPair('valor', CurrToStr(FieldByName('valor_total').AsCurrency).Replace(',', '.'));
    arrayLotesConcluidos.Add(jsonLote);
  end;
end;

procedure TformCadastrarProducao.dbgLotesProducaoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbgLotesProducao, DataSource.DataSet do
  begin
    if (FieldByName('status').AsString = 'ADICIONADO') and (Column.FieldName = 'status') then
      Canvas.Brush.Color := $0080FFFF;

    if (FieldByName('status').AsString = 'AGUARDANDO') and (Column.FieldName = 'status') then
      Canvas.Brush.Color := $00FF9A48;

    if (FieldByName('status').AsString = 'EM PRODUÇÃO') and (Column.FieldName = 'status') then
      Canvas.Brush.Color := $0000A3E8;

    if (FieldByName('status').AsString = 'CONCLUÍDO') and (Column.FieldName = 'status') then
      Canvas.Brush.Color := $009EC600;

    if (FieldByName('finalizado').AsBoolean) and (Column.FieldName = 'status') then
      dbgLotesProducao.Canvas.Brush.Color := clGreen;
  end;

  dbgLotesProducao.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TformCadastrarProducao.FormCreate(Sender: TObject);
begin
  classProducao := TProducao.Create;

  arrayLotesAdicionados := TJSONArray.Create;
  arrayLotesConcluidos := TJSONArray.Create;
  arrayLotesExcluidos := TJSONArray.Create;

  pickerInicio.Date := now;
  pickerFinal.Date := now;

  dbgLotesProducao.DataSource := BDCriarOuRetornarDataSource('DSLotesProducao', Self);
  vFDMLotes := BDCriarOuRetornarFDMemTable('FDMLotesProducao', Self);
  dbgLotesProducao.DataSource.DataSet := vFDMLotes;

  configurarDataSet;
end;

procedure TformCadastrarProducao.btnAddLotesClick(Sender: TObject);
var
  I: Integer;
  resultadoTempo: Double;
  jsonLote: TJSONObject;
  idLote: integer;
  vModalLotes: TformListarLotes;
begin
  vModalLotes := TformListarLotes.Create(Self);
  with vModalLotes, vFDMLotes do
  begin
    esconderColunas := true;

    First;
    for I := 0 to RecordCount - 1 do
    begin
      notFilter := notFilter + FieldByName('id_lote').AsString;
      if I < RecordCount - 1 then
        notFilter := notFilter + ', ';
      Next;
    end;

    vModalLotes.BorderStyle := bsSingle;
    vModalLotes.Align := alNone;
    vModalLotes.btnSelect.Visible := true;
    vModalLotes.selecionar := true;
    vModalLotes.cbFiltroMesesChange(self);
    vModalLotes.ShowModal;

    if lib then
    begin
      idLote := dbgLotes.DataSource.DataSet.FieldByName('id').AsInteger;

      if Locate('id_lote', idLote, []) then
      begin
        Application.MessageBox('Lote já adicionado na produção!', 'Atenção', MB_ICONWARNING + MB_OK);
        exit;
      end;

      for I := 0 to Pred(vModalLotes.dbgLotes.SelectedRows.Count) do
      begin
        dbgLotes.DataSource.DataSet.Bookmark := dbgLotes.SelectedRows.Items[I];

        Append;
        FieldByName('status').AsString := 'ADICIONADO';
        FieldByName('id_lote').AsInteger := dbgLotes.DataSource.DataSet.FieldByName('id').AsInteger;
        FieldByName('op').AsInteger := dbgLotes.DataSource.DataSet.FieldByName('op').AsInteger;
        FieldByName('descricao').AsString := dbgLotes.DataSource.DataSet.FieldByName('descricao').AsString;
        FieldByName('quantidade').AsInteger := dbgLotes.DataSource.DataSet.FieldByName('quantidade').AsInteger;
        FieldByName('valor_unit').AsCurrency := dbgLotes.DataSource.DataSet.FieldByName('valor_unit').AsCurrency;
        FieldByName('valor_total').AsCurrency := dbgLotes.DataSource.DataSet.FieldByName('valor_total').AsCurrency;
        FieldByName('tempo_min').AsFloat := dbgLotes.DataSource.DataSet.FieldByName('tempo_min').AsFloat;
        FieldByName('tempo_total').AsFloat := dbgLotes.DataSource.DataSet.FieldByName('tempo_total').AsFloat;
        FieldByName('finalizado').AsBoolean := false;
        Post;

        jsonLote := TJSONObject.Create;
        jsonLote.AddPair('id_lote', IntToStr(dbgLotes.DataSource.DataSet.FieldByName('id').AsInteger));
        jsonLote.AddPair('finalizado', TJSONBool.Create(false));
        arrayLotesAdicionados.Add(jsonLote);
      end;

      calcularValores;
      SISDBGridResizeColumns(dbgLotesProducao);
      notFilter := '';
    end;
  end;
end;

procedure TformCadastrarProducao.btnDelLotesClick(Sender: TObject);
var
  I: Integer;
  jsonLote: TJSONObject;
  s: string;
begin
  with dbgLotesProducao, DataSource.DataSet do
  begin
    if SelectedRows.Count > 0 then
    begin
      for I := 0 to SelectedRows.Count - 1 do
      begin
        Bookmark := SelectedRows.Items[I];

        removerIndexArray;

        if FieldByName('id_corpoproducao').AsInteger <> 0 then
        begin
          jsonLote := TJSONObject.Create;
          jsonLote.AddPair('id_lote', FieldByName('id_lote').AsString);
          jsonLote.AddPair('id_corpoproducao', FieldByName('id_corpoproducao').AsString);
          arrayLotesExcluidos.Add(jsonLote);
        end;

        Delete;
      end;
    end;
  end;

  calcularValores;
end;

procedure TformCadastrarProducao.verificarStatus;
begin
  lblStatus.Caption := 'Em Cadastramento';

  if vStatus = 'EM ABERTO' then
  begin
    lblStatus.Caption := 'Em Aberto';
    btnBuscarEmpresa.Enabled := false;
  end;

  if vStatus = 'EM PRODUÇÃO' then
  begin
    lblStatus.Caption := 'Em Produção';
    btnBuscarEmpresa.Enabled := false;
  end;

  if vStatus = 'FINALIZADO' then
  begin
    lblStatus.Caption := 'Finalizado';

    btnBuscarEmpresa.Enabled := false;
    btnAddLotes.Enabled := false;
    btnDelLotes.Enabled := false;
    btnSave.Enabled := false;

    pnlBtnAddLotes.Color := clGrayText;
    pnlBtnDelLotes.Color := clGrayText;
    btnSave.Color := clGrayText;
  end;
end;

end.
