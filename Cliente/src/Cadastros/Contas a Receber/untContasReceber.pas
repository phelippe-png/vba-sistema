unit untContasReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.CheckLst, Datasnap.DBClient,
  functions, System.JSON, IdHTTP, DataSet.Serialize,
  untModalConfirmarRecebimento, untClasseContasReceber;

type
  TformContasReceber = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label13: TLabel;
    pnlSearch: TPanel;
    Panel5: TPanel;
    btnDelete: TPanel;
    btnConfirmar: TPanel;
    cbFiltroMeses: TComboBox;
    DBGrid: TDBGrid;
    pnlValues: TPanel;
    Label9: TLabel;
    lblTotalReceber: TLabel;
    Panel2: TPanel;
    rgFiltros: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cbFiltroMesesChange(Sender: TObject);
    procedure rgFiltrosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    ClientDataSet: TClientDataSet;
    DataSource: TDataSource;
    functions: TFunctions;
    classeContasReceber: TContasReceber;

    procedure SQL;
    procedure editarTitlesDBGrid;
    procedure inserirSituacao;
    procedure filtrarContas;
    procedure calcularTotais;
  public
    { Public declarations }
  end;

var
  formContasReceber: TformContasReceber;

implementation

{$R *.dfm}

procedure TformContasReceber.btnConfirmarClick(Sender: TObject);
var
  modalConfirmacao: TformConfirmarRecebimento;
  valor: currency;
begin
  try
    valor := ClientDataSet.FieldByName('valor').AsCurrency;

    modalConfirmacao := TformConfirmarRecebimento.Create(self);
    modalConfirmacao.idContaReceber := ClientDataSet.FieldByName('id').AsInteger;
    modalConfirmacao.lblValorReceber.Caption := FormatCurr('R$ ###,###,##0.00', valor);
    modalConfirmacao.ShowModal;
  finally
    SQL;
    filtrarContas;
  end;
end;

procedure TformContasReceber.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir a conta?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
    exit;

  try
    classeContasReceber.idContaReceber := ClientDataSet.FieldByName('id').AsInteger;
    classeContasReceber.excluirConta;

    Application.MessageBox('Conta excluída com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);
    SQL;
    filtrarContas;
  except
    Application.MessageBox('Erro ao excluir conta!', 'Erro', MB_ICONERROR + MB_OK);
  end;
end;

procedure TformContasReceber.calcularTotais;
var
  resultadoTotal: currency;
begin
  resultadoTotal := 0;

  ClientDataSet.First;
  while not ClientDataSet.Eof do
  begin
    if ClientDataSet.FieldByName('recebido').AsBoolean = false then
      resultadoTotal := resultadoTotal + ClientDataSet.FieldByName('valor').AsCurrency;

    ClientDataSet.Next;
  end;

  lblTotalReceber.Caption := FormatCurr('R$ ###,###,##0.00', resultadoTotal);
end;

procedure TformContasReceber.cbFiltroMesesChange(Sender: TObject);
begin
  filtrarContas;
  inserirSituacao;
end;

procedure TformContasReceber.DBGridCellClick(Column: TColumn);
begin
  if ClientDataSet.FieldByName('recebido').AsBoolean then
  begin
    btnConfirmar.Color := clGrayText;
    btnConfirmar.Enabled := false;
  end;

  if (ClientDataSet.FieldByName('recebido').AsBoolean = false) and (ClientDataSet.RecordCount > 0) then
  begin
    btnConfirmar.Color := $0009770E;
    btnConfirmar.Enabled := true;
  end;

  if DBGrid.SelectedRows.Count = 1 then
  begin
    btnDelete.Color := clMaroon;
    btnDelete.Enabled := true;
  end
  else
  begin
    btnDelete.Color := clGrayText;
    btnDelete.Enabled := false;
  end;
end;

procedure TformContasReceber.DBGridDblClick(Sender: TObject);
begin
  if (ClientDataSet.FieldByName('recebido').AsBoolean = false) and (ClientDataSet.RecordCount > 0) then
    btnConfirmarClick(Self);
end;

procedure TformContasReceber.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName <> 'situacao') or (ClientDataSet.RecordCount = 0) then
    exit;

  if Column.FieldName = 'situacao' then
  begin
    DBGrid.Canvas.Font.Style := [fsBold];
    DBGrid.Canvas.Font.Color := clWhite;
    Column.Field.Alignment := taCenter;
  end;

  if ClientDataSet.FieldByName('recebido').AsBoolean = true then
    DBGrid.Canvas.Brush.Color := clGreen;

  if ClientDataSet.FieldByName('recebido').AsBoolean = false then
    DBGrid.Canvas.Brush.Color := $005959FF;

  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TformContasReceber.editarTitlesDBGrid;
var
  I: Integer;
begin
  for I := 0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns.Items[I].FieldName = 'situacao' then
      DBGrid.Columns.Items[I].Title.Caption := 'Situação';

    if DBGrid.Columns.Items[I].FieldName = 'op' then
      DBGrid.Columns.Items[I].Title.Caption := 'OP';

    if DBGrid.Columns.Items[I].FieldName = 'descricao' then
      DBGrid.Columns.Items[I].Title.Caption := 'Descrição';

    if DBGrid.Columns.Items[I].FieldName = 'empresa' then
      DBGrid.Columns.Items[I].Title.Caption := 'Empresa';

    if DBGrid.Columns.Items[I].FieldName = 'previsao_recebimento' then
      DBGrid.Columns.Items[I].Title.Caption := 'Previsão de Recebimento';

    if DBGrid.Columns.Items[I].FieldName = 'data_recebimento' then
      DBGrid.Columns.Items[I].Title.Caption := 'Data de Recebimento';

    if DBGrid.Columns.Items[I].FieldName = 'valor' then
      DBGrid.Columns.Items[I].Title.Caption := 'Valor Total';

    //
    if DBGrid.Columns.Items[I].FieldName = 'id' then
      DBGrid.Columns.Items[I].Visible := false;

    if DBGrid.Columns.Items[I].FieldName = 'id_lote' then
      DBGrid.Columns.Items[I].Visible := false;

    if DBGrid.Columns.Items[I].FieldName = 'recebido' then
      DBGrid.Columns.Items[I].Visible := false;
  end;

  functions.redimensionarGrid(DBGrid);
end;

procedure TformContasReceber.filtrarContas;
var
  filter: string;
begin
  ClientDataSet.Filtered := false;

  filter := 'month(previsao_recebimento) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);

  if rgFiltros.ItemIndex = 1 then
    filter := filter + ' and recebido = true';

  if rgFiltros.ItemIndex = 2 then
    filter := filter + ' and recebido = false';

  ClientDataSet.Filter := filter;
  ClientDataSet.Filtered := true;

  inserirSituacao;
  calcularTotais;

  btnConfirmar.Color := clGrayText;
  btnConfirmar.Enabled := false;

  btnDelete.Color := clGrayText;
  btnDelete.Enabled := false;
end;

procedure TformContasReceber.FormCreate(Sender: TObject);
begin
  classeContasReceber := TContasReceber.Create;
  functions := TFunctions.Create;
  DataSource := TDataSource.Create(nil);
  DBGrid.DataSource := DataSource;

  ClientDataSet := TClientDataSet.Create(nil);
  ClientDataSet.FieldDefs.Add('id', ftInteger);
  ClientDataSet.FieldDefs.Add('id_lote', ftInteger);
  ClientDataSet.FieldDefs.Add('situacao', ftString, 20);
  ClientDataSet.FieldDefs.Add('op', ftInteger);
  ClientDataSet.FieldDefs.Add('descricao', ftString, 50);
  ClientDataSet.FieldDefs.Add('empresa', ftString, 30);
  ClientDataSet.FieldDefs.Add('previsao_recebimento', ftDate);
  ClientDataSet.FieldDefs.Add('data_recebimento', ftstring, 20);
  ClientDataSet.FieldDefs.Add('valor', ftCurrency);
  ClientDataSet.FieldDefs.Add('recebido', ftBoolean);
  ClientDataSet.CreateDataSet;

  DataSource.DataSet := ClientDataSet;

  SQL;
  editarTitlesDBGrid;
  inserirSituacao;
  calcularTotais;
  cbFiltroMesesChange(Self);
  rgFiltrosClick(Self);
end;

procedure TformContasReceber.FormResize(Sender: TObject);
begin
  functions.redimensionarGrid(DBGrid);
end;

procedure TformContasReceber.inserirSituacao;
var
  situacao: string;
begin
  ClientDataSet.First;
  while not ClientDataSet.Eof do
  begin
    if ClientDataSet.FieldByName('recebido').AsBoolean = false then
      situacao := 'A RECEBER';

    if ClientDataSet.FieldByName('recebido').AsBoolean = true then
      situacao := 'RECEBIDO';

    ClientDataSet.Edit;
    ClientDataSet.FieldByName('situacao').AsString := situacao;
    ClientDataSet.Post;

    if ClientDataSet.FieldByName('data_recebimento').AsString = '' then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('data_recebimento').AsString := 'A CONFIRMAR';
      ClientDataSet.Post;
    end;

    ClientDataSet.Next;
  end;
end;

procedure TformContasReceber.rgFiltrosClick(Sender: TObject);
begin
  filtrarContas;
end;

procedure TformContasReceber.SQL;
var
  stream: TStream;
  jsonRequest: TJSONObject;
  I: Integer;
begin
  ClientDataSet.EmptyDataSet;

  jsonRequest := TJSONObject.Create;
  jsonRequest.AddPair('tabelaBanco', 'tab_contasreceber');
  jsonRequest.AddPair('where', 'and recebido is not true');

  stream := TStringStream.Create(jsonRequest.ToJSON);

  ClientDataSet.LoadFromJSON(functions.httpRequest(get, 'http://localhost:9000/contasreceber'));

  ClientDataSet.IndexFieldNames := 'previsao_recebimento';
end;

end.
