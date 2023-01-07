unit untProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, untCadastrarProducao, Datasnap.DBClient, IdHTTP, DataSet.Serialize,
  functions, System.JSON, Vcl.Buttons, relatorioControleProducao,
  untClasseProducao;

type
  TformListarProducoes = class(TForm)
    Panel1: TPanel;
    pnlHeader: TPanel;
    lblTitle: TLabel;
    btnAdd: TPanel;
    pnlContainer: TPanel;
    line: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Label4: TLabel;
    lblQuantidade: TLabel;
    Label8: TLabel;
    lblValorTotal: TLabel;
    lblTempo: TLabel;
    Label11: TLabel;
    DBGrid: TDBGrid;
    Panel5: TPanel;
    cbFiltroMesProducao: TComboBox;
    Label15: TLabel;
    btnVisualizar: TPanel;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Panel5Click(Sender: TObject);
    procedure cbFiltroMesProducaoChange(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    formCadastrar: TformCadastrarProducao;
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    functions: TFunctions;
    classeProducao: TProducao;

    procedure SQL;
    procedure inserirSituacao;
    procedure editarTitlesDBGrid;
    procedure verificarStatus;
    procedure calcularValores;
  public
    { Public declarations }
  end;

var
  formListarProducoes: TformListarProducoes;

implementation

{$R *.dfm}

procedure TformListarProducoes.btnAddClick(Sender: TObject);
begin
  try
    formCadastrar := TformCadastrarProducao.Create(Self);
    formCadastrar.ShowModal;
  finally
    SQL;
    calcularValores;
  end;
end;

procedure TformListarProducoes.calcularValores;
var
  resultadoQuantProduzir: integer;
  resultadoValorTotal: currency;
  resultadoTempoProduzir: double;
  I: Integer;
begin
  resultadoQuantProduzir := 0;
  resultadoValorTotal := 0;
  resultadoTempoProduzir := 0;

  ClientDataSet.First;
  for I := 0 to ClientDataSet.RecordCount - 1 do
  begin
    if ClientDataSet.FieldByName('status').AsString <> 'FINALIZADO' then
    begin
      resultadoQuantProduzir := resultadoQuantProduzir + ClientDataSet.FieldByName('quantidade_produzir').AsInteger;
      resultadoTempoProduzir := resultadoValorTotal + ClientDataSet.FieldByName('valor_total').AsCurrency;
    end;

    resultadoValorTotal := resultadoValorTotal + ClientDataSet.FieldByName('valor_total').AsCurrency;

    ClientDataSet.Next;
  end;

  lblQuantidade.Caption := resultadoQuantProduzir.ToString;
  lblValorTotal.Caption := FormatCurr('R$ ###,###,##0.00', resultadoValorTotal);
  lblTempo.Caption := FormatFloat('###,###,##0.000', resultadoTempoProduzir);
end;

procedure TformListarProducoes.cbFiltroMesProducaoChange(Sender: TObject);
begin
  ClientDataSet.Filtered := false;
  ClientDataSet.Filter := 'month(data_inicio) = ' + IntToStr(cbFiltroMesProducao.ItemIndex + 1);
  ClientDataSet.Filtered := true;

  calcularValores;
  inserirSituacao;
end;

procedure TformListarProducoes.DBGridDblClick(Sender: TObject);
begin
  btnVisualizarClick(Self);
end;

procedure TformListarProducoes.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  bcolor: TColor;
  SCapt: string;
begin
  if ClientDataSet.RecordCount = 0 then
    exit;

  if Column.FieldName = 'situacao' then
  begin
    DBGrid.Canvas.Font.Style := [fsBold];
    dbgrid.Canvas.Font.Color := clWhite;
  end;

  if (ClientDataSet.FieldByName('data_final').AsDateTime > Date) and (Column.FieldName = 'situacao') then
    DBGrid.Canvas.Brush.Color := $00FF9135;

  if (ClientDataSet.FieldByName('data_final').AsDateTime < Date) and (Column.FieldName = 'situacao') then
    DBGrid.Canvas.Brush.Color := $002D2DFF;

  if (ClientDataSet.FieldByName('data_final').AsDateTime = Date) and (Column.FieldName = 'situacao') then
    DBGrid.Canvas.Brush.Color := clWebOrange;

  if (ClientDataSet.FieldByName('status').AsString = 'FINALIZADO') and (Column.FieldName = 'situacao') then
    DBGrid.Canvas.Brush.Color := clGreen;

  DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TformListarProducoes.editarTitlesDBGrid;
begin
  DBGrid.Columns.Items[1].Visible := false;
  DBGrid.Columns.Items[2].Visible := false;

  DBGrid.Columns.Items[0].Title.Caption := 'Situação';
  DBGrid.Columns.Items[3].Title.Caption := 'Empresa';
  DBGrid.Columns.Items[4].Title.Caption := 'Data de Início';
  DBGrid.Columns.Items[5].Title.Caption := 'Data Final';
  DBGrid.Columns.Items[6].Title.Caption := 'Status';
  DBGrid.Columns.Items[7].Title.Caption := 'Quantidade Total';
  DBGrid.Columns.Items[8].Title.Caption := 'Quantidade a Produzir';
  DBGrid.Columns.Items[9].Title.Caption := 'Valor Total';
  DBGrid.Columns.Items[10].Title.Caption := 'Tempo Total';

  functions.redimensionarGrid(DBGrid);
end;

procedure TformListarProducoes.FormCreate(Sender: TObject);
begin
  classeProducao := TProducao.Create;
  DataSource := TDataSource.Create(Self);
  functions := TFunctions.Create;

  ClientDataSet := TClientDataSet.Create(Self);
  ClientDataSet.FieldDefs.Add('situacao', ftString, 20);
  ClientDataSet.FieldDefs.Add('id', ftInteger);
  ClientDataSet.FieldDefs.Add('id_empresa', ftInteger);
  ClientDataSet.FieldDefs.Add('empresa', ftString, 50);
  ClientDataSet.FieldDefs.Add('data_inicio', ftDate);
  ClientDataSet.FieldDefs.Add('data_final', ftDate);
  ClientDataSet.FieldDefs.Add('status', ftString, 20);
  ClientDataSet.FieldDefs.Add('quantidade_total', ftInteger);
  ClientDataSet.FieldDefs.Add('quantidade_produzir', ftInteger);
  ClientDataSet.FieldDefs.Add('valor_total', ftCurrency);
  ClientDataSet.FieldDefs.Add('tempo_total', ftFloat);
  ClientDataSet.CreateDataSet;

  DataSource.DataSet := ClientDataSet;
  DBGrid.DataSource := DataSource;

  SQL;

  inserirSituacao;
  editarTitlesDBGrid;
  calcularValores;
  cbFiltroMesProducaoChange(Self);
end;

procedure TformListarProducoes.inserirSituacao;
begin
  ClientDataSet.First;

  while not ClientDataSet.Eof do
  begin
    if ClientDataSet.FieldByName('data_final').AsDateTime > Date then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'EM DIA';
      ClientDataSet.Post;
    end;
  
    if ClientDataSet.FieldByName('data_final').AsDateTime < Date then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'EM ATRASO';
      ClientDataSet.Post;
    end;

    if ClientDataSet.FieldByName('data_final').AsDateTime = Date then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'ÚLTIMO DIA';
      ClientDataSet.Post;
    end;

    if ClientDataSet.FieldByName('status').AsString = 'FINALIZADO' then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'FINALIZADO';
      ClientDataSet.Post;
    end;

    ClientDataSet.Next;
  end;
end;

procedure TformListarProducoes.btnVisualizarClick(Sender: TObject);
var
  jsonDados: TJSONObject;
begin
  try
    if ClientDataSet.RecordCount = 0 then
      exit;

    formCadastrar := TformCadastrarProducao.Create(Self);

    jsonDados := TJSONObject.Create;
    jsonDados.AddPair('id', ClientDataSet.FieldByName('id').AsString);
    jsonDados.AddPair('id_empresa', ClientDataSet.FieldByName('id_empresa').AsString);
    jsonDados.AddPair('data_inicio', DateToStr(ClientDataSet.FieldByName('data_inicio').AsDateTime));
    jsonDados.AddPair('data_final', DateToStr(ClientDataSet.FieldByName('data_final').AsDateTime));

    verificarStatus;
    formCadastrar.carregarDados(jsonDados);
    formCadastrar.ShowModal;
  finally
    SQL;
    calcularValores;
  end;
end;

procedure TformListarProducoes.Panel2Click(Sender: TObject);
begin
  try
    if Application.MessageBox('Deseja realmente excluir a produção?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
      exit;

    classeProducao.coluna := 'id_producao';
    classeProducao.excluirCorpoProducao(ClientDataSet.FieldByName('id').AsInteger);
    classeProducao.excluirProducao(ClientDataSet.FieldByName('id').AsInteger);

    Application.MessageBox('Produção excluida com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);
  finally
    SQL;
    calcularValores;
  end;
end;

procedure TformListarProducoes.Panel5Click(Sender: TObject);
var
  stream: TStream;
  jsonRequest, jsonValorLote: TJSONObject;
  jsonResponse: TJSONArray;
  responseDados: string;
  I: Integer;
begin
  try
    if ClientDataSet.FieldByName('status').AsString = 'EM ABERTO' then
    begin
      if Application.MessageBox('Deseja iniciar a produção?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_YES then
      begin
        classeProducao.idProducao := ClientDataSet.FieldByName('id').AsInteger;
        classeProducao.status := 'EM PRODUÇÃO';
        classeProducao.alterarStatusProducao;
      end;
    end;

    if ClientDataSet.FieldByName('status').AsString = 'EM PRODUÇÃO' then
    begin
      if Application.MessageBox('ATENÇÃO: Todos os lotes incluídos nessa produção serão finalizados!' + sLineBreak +
        'Deseja realmente finalizar a produção?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_YES then
      begin
        classeProducao.idProducao := ClientDataSet.FieldByName('id').AsInteger;
        classeProducao.status := 'FINALIZADO';
        classeProducao.alterarStatusProducao;

        responseDados := functions.buscarDados(ClientDataSet.FieldByName('id').AsInteger, 'tab_controleproducao_corpo',
          'id_producao', 'array', 'http://localhost:9000/producoes/producao');

        jsonResponse := TJSONArray.Create;
        jsonResponse := TJSONObject.ParseJSONValue(responseDados) as TJSONArray;

        for I := 0 to jsonResponse.Count - 1 do
        begin
          responseDados := functions.buscarDados(jsonResponse.Get(I).GetValue<integer>('idLote'),
          'tab_lotes', 'id', 'object', 'http://localhost:9000/lotes/lote');

          jsonValorLote := TJSONObject.Create;
          jsonValorLote := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

          classeProducao.idCorpoProducao := jsonResponse.Get(I).GetValue<integer>('id');
          classeProducao.idLote := jsonResponse.Get(I).GetValue<integer>('idLote');
          classeProducao.valorLote := jsonValorLote.GetValue<currency>('valorTotal');

          classeProducao.enviarDadosContasReceber;
        end;
      end;
    end;

    SQL;
    calcularValores;
  except
    Application.MessageBox('Erro ao alterar status da produção!', 'Atenção', MB_ICONWARNING + MB_OK);
  end;
end;

procedure TformListarProducoes.SQL;
var
  stream: TStream;
begin
  ClientDataSet.EmptyDataSet;
  stream := TStringStream.Create('tab_controleproducao');

  ClientDataSet.LoadFromJSON(functions.httpRequest(get, 'http://localhost:9000/producoes', stream));

  inserirSituacao;
end;

procedure TformListarProducoes.verificarStatus;
begin
  if ClientDataSet.FieldByName('status').AsString = 'EM ABERTO' then
    formCadastrar.status := emAberto;

  if ClientDataSet.FieldByName('status').AsString = 'EM PRODUÇÃO' then
    formCadastrar.status := emProducao;

  if ClientDataSet.FieldByName('status').AsString = 'FINALIZADO' then
    formCadastrar.status := finalizado;
end;

end.
