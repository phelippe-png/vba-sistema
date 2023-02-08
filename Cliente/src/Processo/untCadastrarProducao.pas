unit untCadastrarProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, untListarEmpresas, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, untListarLotes, Datasnap.DBClient, functions,
  Vcl.Imaging.pngimage, untclasseproducao, System.JSON, IdHTTP, DataSet.Serialize;

type
  TformCadastrarProducao = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid: TDBGrid;
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
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnDelLotesClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;

    idProducao: integer;
    idEmpresa: integer;
    empresa: string;
    functions: TFunctions;
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

    procedure calcularValores;
    procedure editarTitlesDBGrid;
    procedure inserirStatus;
    procedure verificarStatus;
  public
    editar: boolean;
    status: (emCadastramento, emAberto, emProducao, finalizado);

    procedure carregarDados(jsonDados: TJSONObject);
    procedure removerIndexArray;
  end;

var
  formCadastrarProducao: TformCadastrarProducao;

implementation

{$R *.dfm}

procedure TformCadastrarProducao.btnBuscarEmpresaClick(Sender: TObject);
begin
  untEmpresas := TformListarEmpresas.Create(Self);
  untEmpresas.mudarEstadoDBGrid := true;
  untEmpresas.BorderStyle := bsSingle;
  untEmpresas.Align := alNone;
  untEmpresas.esconderColunas := true;
  untEmpresas.ShowModal;

  if untEmpresas.selecionado then
  begin
    idEmpresa := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;
    empresa := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('razaosocial').AsString;
    lblRazao.Caption := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('razaosocial').AsString;
    lblFantasia.Caption := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('nomefantasia').AsString;
  end;
end;

procedure TformCadastrarProducao.inserirStatus;
begin
  ClientDataSet.First;
  while not ClientDataSet.Eof do
  begin
    if status = emAberto then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('status').AsString := 'AGUARDANDO';
      ClientDataSet.Post;
    end;

    if (ClientDataSet.FieldByName('finalizado').AsBoolean) and (status <> emAberto) then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('status').AsString := 'CONCLUÍDO';
      ClientDataSet.Post;
    end;

    if (ClientDataSet.FieldByName('finalizado').AsBoolean = false) and (status <> emAberto) then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('status').AsString := 'EM PRODUÇÃO';
      ClientDataSet.Post;
    end;

    ClientDataSet.Next;
  end;
end;

procedure TformCadastrarProducao.removerIndexArray;
var
  I: Integer;
begin
  for I := 0 to arrayLotesAdicionados.Count - 1 do
  begin
    if arrayLotesAdicionados.Get(I).GetValue<integer>('id_lote') = ClientDataSet.FieldByName('id_lote').AsInteger then
    begin
      arrayLotesAdicionados.Remove(I);
      break;
    end;
  end;

  for I := 0 to arrayLotesConcluidos.Count - 1 do
  begin
    if arrayLotesConcluidos.Get(I).GetValue<integer>('id_lote') = ClientDataSet.FieldByName('id_lote').AsInteger then
    begin
      arrayLotesConcluidos.Remove(I);
      break;
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

  if ClientDataSet.RecordCount = 0 then
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

  try
    classProducao.enviarDadosProducao;

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
      classProducao.valorLote := StrToCurr(FormatCurr('###,###,##0.00', arrayLotesConcluidos.Get(I).GetValue<currency>('valor')).Replace('.', ''));
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
  except
    Application.MessageBox('Erro ao cadastrar produção!', 'Erro', MB_ICONERROR + MB_OK);
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

  ClientDataSet.First;
  for I := 0 to ClientDataSet.RecordCount - 1 do
  begin
    resultadoQuantidade := resultadoQuantidade + ClientDataSet.FieldByName('quantidade').AsInteger;
    resultadoValor := resultadoValor + ClientDataSet.FieldByName('valor_total').AsCurrency;
    resultadoTempo := resultadoTempo + ClientDataSet.FieldByName('tempo_total').AsFloat;

    if (ClientDataSet.FieldByName('finalizado').AsBoolean = false) and
      (ClientDataSet.FieldByName('status').AsString <> 'CONCLUÍDO') then
    begin
      resultadoQuantidadeProduzir := resultadoQuantidadeProduzir + ClientDataSet.FieldByName('quantidade').AsInteger;
      lotesProduzir := lotesProduzir + 1;
    end;

    ClientDataSet.Next;
  end;

  quantTotal.Caption := IntToStr(resultadoQuantidade);
  quantProduzir.Caption := IntToStr(resultadoQuantidadeProduzir);
  lblValorTotal.Caption := FormatCurr('R$ ###,###,##0.00', resultadoValor);
  lblTempo.Caption := FormatFloat('###,###,##0.000', resultadoTempo);
  lblLotesProduzir.Caption := lotesProduzir.ToString + '/' + ClientDataSet.RecordCount.ToString;
end;

procedure TformCadastrarProducao.carregarDados(jsonDados: TJSONObject);
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

  idEmpresa := jsonDados.GetValue<integer>('id_empresa');
  responseDados := functions.buscarDados(idEmpresa, 'tab_empresas', 'id', 'object', 'http://localhost:9000/empresas/empresa');
  jsonDadosEmpresa := TJSONObject.Create;
  jsonDadosEmpresa := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

  idProducao := jsonDados.GetValue<integer>('id');
  responseDados := functions.buscarDados(idProducao, 'tab_controleproducao_corpo', 'id_producao', 'array', 'http://localhost:9000/producoes/producao');;
  jsonCorpoProducao := TJSONArray.Create;
  jsonCorpoProducao := TJSONObject.ParseJSONValue(responseDados) as TJSONArray;

  idEmpresa := jsonDados.GetValue<integer>('id_empresa');
  empresa := jsonDadosEmpresa.GetValue<string>('razaosocial');

  lblRazao.Caption := jsonDadosEmpresa.GetValue<string>('razaosocial');
  lblFantasia.Caption := jsonDadosEmpresa.GetValue<string>('nomefantasia');
  pickerInicio.Date := StrToDate(jsonDados.GetValue<string>('data_inicio'));
  pickerFinal.Date := StrToDate(jsonDados.GetValue<string>('data_final'));

  jsonLote := TJSONObject.Create;
  for I := 0 to jsonCorpoProducao.Count - 1 do
  begin
    idLote := jsonCorpoProducao.Get(I).GetValue<integer>('idLote');
    idCorpoProducao := jsonCorpoProducao.Get(I).GetValue<integer>('id');
    finalizado := jsonCorpoProducao.Get(I).GetValue<boolean>('finalizado');

    responseDados := functions.buscarDados(idLote, 'tab_lotes', 'id', 'object', 'http://localhost:9000/lotes/lote');
    jsonLote := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

    ClientDataSet.Append;
    ClientDataSet.FieldByName('id_corpoproducao').AsInteger := idCorpoProducao;
    ClientDataSet.FieldByName('id_lote').AsInteger := jsonLote.GetValue<integer>('id');
    ClientDataSet.FieldByName('op').AsInteger := jsonLote.GetValue<integer>('op');
    ClientDataSet.FieldByName('descricao').AsString := jsonLote.GetValue<string>('descricao');
    ClientDataSet.FieldByName('quantidade').AsInteger := jsonLote.GetValue<integer>('quantidade');
    ClientDataSet.FieldByName('valor_unit').AsCurrency := jsonLote.GetValue<currency>('valorUnit');
    ClientDataSet.FieldByName('valor_total').AsCurrency := jsonLote.GetValue<currency>('valorTotal');
    ClientDataSet.FieldByName('tempo_min').AsFloat := jsonLote.GetValue<Double>('tempoMin');
    ClientDataSet.FieldByName('tempo_total').AsFloat := jsonLote.GetValue<Double>('tempoTotal');
    ClientDataSet.FieldByName('finalizado').AsBoolean := finalizado;
    ClientDataSet.Post;
  end;

  calcularValores;
  inserirStatus;
  functions.redimensionarGrid(DBGrid);
end;

procedure TformCadastrarProducao.DBGridDblClick(Sender: TObject);
var
  jsonLote: TJSONObject;
  I: Integer;
  bookmarkCDS: TBookmark;
begin
  bookmarkCDS := ClientDataSet.Bookmark;

  if (ClientDataSet.FieldByName('id_corpoproducao').AsInteger <> 0) and (ClientDataSet.FieldByName('finalizado').AsBoolean) then
    exit;

  if (ClientDataSet.FieldByName('status').AsString = 'ADICIONADO') or (ClientDataSet.FieldByName('status').AsString = 'AGUARDANDO') then
    exit;

  if ClientDataSet.FieldByName('status').AsString = 'EM PRODUÇÃO' then
  begin
    ClientDataSet.Edit;
    ClientDataSet.FieldByName('status').AsString := 'CONCLUÍDO';
    ClientDataSet.Post;
  end
  else if ClientDataSet.FieldByName('status').AsString = 'CONCLUÍDO' then
  begin
    ClientDataSet.Edit;
    ClientDataSet.FieldByName('status').AsString := 'EM PRODUÇÃO';
    ClientDataSet.Post;
  end;

  calcularValores;
  ClientDataSet.Bookmark := bookmarkCDS;

  for I := 0 to arrayLotesConcluidos.Count - 1 do
  begin
    if arrayLotesConcluidos.Get(I).GetValue<integer>('id_lote') = ClientDataSet.FieldByName('id_lote').AsInteger then
    begin
      arrayLotesConcluidos.Remove(I);
      exit;
    end;
  end;

  jsonLote := TJSONObject.Create;
  jsonLote.AddPair('id_corpoproducao', ClientDataSet.FieldByName('id_corpoproducao').AsString);
  jsonLote.AddPair('id_lote', ClientDataSet.FieldByName('id_lote').AsString);
  jsonLote.AddPair('valor', CurrToStr(ClientDataSet.FieldByName('valor_total').AsCurrency).Replace(',', '.'));
  arrayLotesConcluidos.Add(jsonLote);
end;

procedure TformCadastrarProducao.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (ClientDataSet.FieldByName('status').AsString = 'ADICIONADO') and (Column.FieldName = 'status') then
  begin
    DBGrid.Canvas.Brush.Color := $0080FFFF;
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if (ClientDataSet.FieldByName('status').AsString = 'AGUARDANDO') and (Column.FieldName = 'status') then
  begin
    DBGrid.Canvas.Brush.Color := $00FF9A48;
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if (ClientDataSet.FieldByName('status').AsString = 'EM PRODUÇÃO') and (Column.FieldName = 'status') then
  begin
    DBGrid.Canvas.Brush.Color := $0000A3E8;
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if (ClientDataSet.FieldByName('status').AsString = 'CONCLUÍDO') and (Column.FieldName = 'status') then
  begin
    DBGrid.Canvas.Brush.Color := $009EC600;
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
  end;

  if (ClientDataSet.FieldByName('finalizado').AsBoolean) and (Column.FieldName = 'status') then
  begin
    DBGrid.Canvas.Brush.Color := clGreen;
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
  end;
end;

procedure TformCadastrarProducao.editarTitlesDBGrid;
begin
  DBGrid.Columns.Items[0].Title.Caption := 'Status';
  DBGrid.Columns.Items[1].Title.Caption := 'OP';
  DBGrid.Columns.Items[2].Title.Caption := 'Descrição';
  DBGrid.Columns.Items[3].Title.Caption := 'Quantidade';
  DBGrid.Columns.Items[4].Title.Caption := 'Valor Unitário';
  DBGrid.Columns.Items[5].Title.Caption := 'Valor Total';
  DBGrid.Columns.Items[6].Title.Caption := 'Tempo Minutos';
  DBGrid.Columns.Items[7].Title.Caption := 'Tempo Total';
  functions.redimensionarGrid(DBGrid);
end;

procedure TformCadastrarProducao.FormCreate(Sender: TObject);
begin
  functions := TFunctions.Create;
  classProducao := TProducao.Create;

  arrayLotesAdicionados := TJSONArray.Create;
  arrayLotesConcluidos := TJSONArray.Create;
  arrayLotesExcluidos := TJSONArray.Create;
  arrayLotesConcluidos := TJSONArray.Create;

  ClientDataSet := TClientDataSet.Create(Self);
  ClientDataSet.FieldDefs.Add('status', ftString, 20);
  ClientDataSet.FieldDefs.Add('id_corpoproducao', ftInteger);
  ClientDataSet.FieldDefs.Add('id_lote', ftInteger);
  ClientDataSet.FieldDefs.Add('op', ftInteger);
  ClientDataSet.FieldDefs.Add('descricao', ftString, 40);
  ClientDataSet.FieldDefs.Add('quantidade', ftInteger);
  ClientDataSet.FieldDefs.Add('valor_unit', ftCurrency);
  ClientDataSet.FieldDefs.Add('valor_total', ftCurrency);
  ClientDataSet.FieldDefs.Add('tempo_min', ftFloat);
  ClientDataSet.FieldDefs.Add('tempo_total', ftFloat);
  ClientDataSet.FieldDefs.Add('finalizado', ftBoolean);
  ClientDataSet.CreateDataSet;

  DataSource := TDataSource.Create(Self);
  DataSource.DataSet := ClientDataSet;

  DBGrid.DataSource := DataSource;

  ClientDataSet.FieldByName('id_lote').Visible := false;
  ClientDataSet.FieldByName('id_corpoproducao').Visible := false;
  ClientDataSet.FieldByName('finalizado').Visible := false;

  editarTitlesDBGrid;
  calcularValores;

  pickerInicio.Date := now;
  pickerFinal.Date := now;
end;

procedure TformCadastrarProducao.btnAddLotesClick(Sender: TObject);
var
  I: Integer;
  resultadoTempo: Double;
  jsonLote: TJSONObject;
  idLote: integer;
begin
  untLotes := TformListarLotes.Create(Self);
  untLotes.esconderColunas := true;

  ClientDataSet.First;
  for I := 0 to ClientDataSet.RecordCount - 1 do
  begin
    untLotes.notFilter := untLotes.notFilter + ClientDataSet.FieldByName('id_lote').AsString;

    if I < ClientDataSet.RecordCount - 1 then
      untLotes.notFilter := untLotes.notFilter + ', ';

    ClientDataSet.Next;
  end;

  untLotes.BorderStyle := bsSingle;
  untLotes.Align := alNone;
  untLotes.btnSelect.Visible := true;
  untLotes.selecionar := true;
  untLotes.cbFiltroMesesChange(self);
  untLotes.ShowModal;

  if untLotes.lib then
  begin
    idLote := untLotes.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;

    if ClientDataSet.Locate('id_lote', idLote, []) then
    begin
      Application.MessageBox('Lote já adicionado na produção!', 'Atenção', MB_ICONWARNING + MB_OK);
      exit;
    end;

    for I := 0 to untLotes.DBGrid.SelectedRows.Count - 1 do
    begin
      untLotes.DBGrid.DataSource.DataSet.Bookmark := untLotes.DBGrid.SelectedRows.Items[I];

      ClientDataSet.Append;
      ClientDataSet.FieldByName('status').AsString := 'ADICIONADO';
      ClientDataSet.FieldByName('id_lote').AsInteger := untLotes.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;
      ClientDataSet.FieldByName('op').AsInteger := untLotes.DBGrid.DataSource.DataSet.FieldByName('op').AsInteger;
      ClientDataSet.FieldByName('descricao').AsString := untLotes.DBGrid.DataSource.DataSet.FieldByName('descricao').AsString;
      ClientDataSet.FieldByName('quantidade').AsInteger := untLotes.DBGrid.DataSource.DataSet.FieldByName('quantidade').AsInteger;
      ClientDataSet.FieldByName('valor_unit').AsCurrency := untLotes.DBGrid.DataSource.DataSet.FieldByName('valor_unit').AsCurrency;
      ClientDataSet.FieldByName('valor_total').AsCurrency := untLotes.DBGrid.DataSource.DataSet.FieldByName('valor_total').AsCurrency;
      ClientDataSet.FieldByName('tempo_min').AsFloat := untLotes.DBGrid.DataSource.DataSet.FieldByName('tempo_min').AsFloat;
      ClientDataSet.FieldByName('tempo_total').AsFloat := untLotes.DBGrid.DataSource.DataSet.FieldByName('tempo_total').AsFloat;
      ClientDataSet.FieldByName('finalizado').AsBoolean := false;
      ClientDataSet.Post;

      jsonLote := TJSONObject.Create;
      jsonLote.AddPair('id_lote', IntToStr(untLotes.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger));
      jsonLote.AddPair('finalizado', TJSONBool.Create(false));
      arrayLotesAdicionados.Add(jsonLote);
    end;

    calcularValores;
    functions.redimensionarGrid(DBGrid);
    untLotes.notFilter := '';
  end;
end;

procedure TformCadastrarProducao.btnDelLotesClick(Sender: TObject);
var
  I: Integer;
  jsonLote: TJSONObject;
  s: string;
begin
  if DBGrid.SelectedRows.Count > 0 then
  begin
    for I := 0 to DBGrid.SelectedRows.Count - 1 do
    begin
      ClientDataSet.Bookmark := DBGrid.SelectedRows.Items[I];

      removerIndexArray;

      if ClientDataSet.FieldByName('id_corpoproducao').AsInteger <> 0 then
      begin
        jsonLote := TJSONObject.Create;
        jsonLote.AddPair('id_lote', ClientDataSet.FieldByName('id_lote').AsString);
        jsonLote.AddPair('id_corpoproducao', ClientDataSet.FieldByName('id_corpoproducao').AsString);
        arrayLotesExcluidos.Add(jsonLote);
      end;

      DBGrid.DataSource.DataSet.Delete;
    end;
  end;

  calcularValores;
end;

procedure TformCadastrarProducao.verificarStatus;
begin
  if status = emCadastramento then
    lblStatus.Caption := 'Em Cadastramento';

  if status = emAberto then
  begin
    lblStatus.Caption := 'Em Aberto';
    btnBuscarEmpresa.Enabled := false;
  end;

  if status = emProducao then
  begin
    lblStatus.Caption := 'Em Produção';
    btnBuscarEmpresa.Enabled := false;
  end;

  if status = finalizado then
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
