unit untListarLotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, IdHTTP, DataSet.Serialize,
  untCadastrarLote, Vcl.ComCtrls, System.JSON, functions, Datasnap.DBClient,
  untClasseLotes;

type
  TformListarLotes = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    Panel6: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    btnDelete: TPanel;
    btnEdit: TPanel;
    btnAdd: TPanel;
    DBGrid: TDBGrid;
    cbFiltroMeses: TComboBox;
    Label13: TLabel;
    Label3: TLabel;
    cbFiltro: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbFiltroMesesChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbFiltroChange(Sender: TObject);
  private
    ClientDataSet: TClientDataSet;
    DataSource: TDataSource;
    formCadastrarLote: TformCadastrarLote;
    functions: TFunctions;
    classeLotes: TLotes;

    procedure SQL;
    procedure editarDBGrid;
    function loteIncluido: boolean;
  public
    lib: boolean;
    selecionar: boolean;
    notFilter: string;
    esconderColunas: boolean;
  end;

var
  formListarLotes: TformListarLotes;

implementation

{$R *.dfm}

procedure TformListarLotes.edSearchChange(Sender: TObject);
begin
  ClientDataSet.FilterOptions := [foCaseInsensitive];
  ClientDataSet.Filtered := false;

  if cbFiltro.ItemIndex = 0 then
    ClientDataSet.Filter := 'codigo like ' + QuotedStr('%' + edSearch.Text + '%');

  if cbFiltro.ItemIndex = 1 then
    ClientDataSet.Filter := 'op like ' + QuotedStr('%' + edSearch.Text + '%');

  if cbFiltro.ItemIndex = 2 then
    ClientDataSet.Filter := 'descricao like ' + QuotedStr('%' + edSearch.Text + '%');

  if cbFiltro.ItemIndex = 3 then
    ClientDataSet.Filter := 'empresa like ' + QuotedStr('%' + edSearch.Text + '%');

  ClientDataSet.Filter := 'month(data_entrada) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);
  ClientDataSet.Filtered := true;
end;

procedure TformListarLotes.editarDBGrid;
begin
  DBGrid.Columns.Items[0].Visible := false;
  DBGrid.Columns.Items[1].Visible := false;

  TField(ClientDataSet.FieldByName('codigo')).DisplayLabel := 'Código';
  TField(ClientDataSet.FieldByName('op')).DisplayLabel := 'OP';
  TField(ClientDataSet.FieldByName('descricao')).DisplayLabel := 'Descrição';
  TField(ClientDataSet.FieldByName('empresa')).DisplayLabel := 'Empresa';
  TField(ClientDataSet.FieldByName('quantidade')).DisplayLabel := 'Quantidade';
  TField(ClientDataSet.FieldByName('valor_unit')).DisplayLabel := 'Valor Unitário';
  TField(ClientDataSet.FieldByName('valor_total')).DisplayLabel := 'Valor Total';
  TField(ClientDataSet.FieldByName('tempo_min')).DisplayLabel := 'Tempo Minutos';
  TField(ClientDataSet.FieldByName('tempo_total')).DisplayLabel := 'Tempo Total';
  TField(ClientDataSet.FieldByName('data_entrada')).DisplayLabel := 'Data Entrada';

  TCurrencyField(ClientDataSet.FieldByName('valor_unit')).DisplayFormat := 'R$ ###,###,##0.00';
  TCurrencyField(ClientDataSet.FieldByName('valor_total')).DisplayFormat := 'R$ ###,###,##0.00';
  TFloatField(ClientDataSet.FieldByName('tempo_min')).DisplayFormat := '###,###,##0.000';
  TFloatField(ClientDataSet.FieldByName('tempo_total')).DisplayFormat := '###,###,##0.000';

  if esconderColunas then
  begin
    TField(ClientDataSet.FieldByName('valor_unit')).Visible := false;
    TField(ClientDataSet.FieldByName('tempo_min')).Visible := false;
    TField(ClientDataSet.FieldByName('tempo_total')).Visible := false;
  end;

  functions.redimensionarGrid(DBGrid);
end;

procedure TformListarLotes.btnAddClick(Sender: TObject);
begin
  try
    formCadastrarLote := TformCadastrarLote.Create(Self);
    formCadastrarLote.ShowModal;
  finally
    SQL;
  end;
end;

procedure TformListarLotes.btnDeleteClick(Sender: TObject);
var
  jsonResponse: TJSONObject;
begin
  if loteIncluido then
    exit;

  if Application.MessageBox('Deseja realmente excluir o lote selecionado?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_YES then
  begin
    try
      classeLotes.idLote := ClientDataSet.FieldByName('id').AsInteger;
      classeLotes.excluirLote;
      Application.MessageBox('Lote excluído com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);
      SQL;
    except
      Application.MessageBox('Erro ao excluir lote!', 'Erro', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TformListarLotes.btnEditClick(Sender: TObject);
var
  dadosLote: TJSONObject;
begin
  if ClientDataSet.RecordCount = 0 then
    exit;

  formCadastrarLote := TformCadastrarLote.Create(Self);

  try
    dadosLote := TJSONObject.Create;
    dadosLote.AddPair('id_lote', DBGrid.DataSource.DataSet.FieldByName('id').AsString);
    dadosLote.AddPair('id_empresa', DBGrid.DataSource.DataSet.FieldByName('id_empresa').AsString);
    dadosLote.AddPair('codigo', DBGrid.DataSource.DataSet.FieldByName('codigo').AsString);
    dadosLote.AddPair('op', DBGrid.DataSource.DataSet.FieldByName('op').AsString);
    dadosLote.AddPair('descricao', DBGrid.DataSource.DataSet.FieldByName('descricao').AsString);
    dadosLote.AddPair('empresa', DBGrid.DataSource.DataSet.FieldByName('empresa').AsString);
    dadosLote.AddPair('quantidade', DBGrid.DataSource.DataSet.FieldByName('quantidade').AsString);
    dadosLote.AddPair('valor_unit', DBGrid.DataSource.DataSet.FieldByName('valor_unit').AsString);
    dadosLote.AddPair('valor_total', DBGrid.DataSource.DataSet.FieldByName('valor_total').AsString);
    dadosLote.AddPair('tempo_min', DBGrid.DataSource.DataSet.FieldByName('tempo_min').AsString);
    dadosLote.AddPair('tempo_total', DBGrid.DataSource.DataSet.FieldByName('tempo_total').AsString);
    formCadastrarLote.carregarDados(dadosLote);

    formCadastrarLote.ShowModal;
  finally
    SQL;
  end;
end;

procedure TformListarLotes.btnSelectClick(Sender: TObject);
begin
  if DBGrid.SelectedRows.Count > 0 then
  begin
    lib := true;
    Self.Close;
  end;
end;

procedure TformListarLotes.cbFiltroChange(Sender: TObject);
begin
  edSearch.Text := '';
end;

procedure TformListarLotes.cbFiltroMesesChange(Sender: TObject);
begin
  ClientDataSet.Filtered := false;
  ClientDataSet.Filter := '';
  ClientDataSet.Filter := 'month(data_entrada) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);

  if notFilter <> '' then
    ClientDataSet.Filter := ClientDataSet.Filter + ' and not (id in (' + notFilter + ') )';

  ClientDataSet.Filtered := true;

  functions.redimensionarGrid(DBGrid);
end;

procedure TformListarLotes.DBGridDblClick(Sender: TObject);
begin
  if selecionar then
    btnSelectClick(Self)
  else
    btnEditClick(Self);
end;

procedure TformListarLotes.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.FieldName = 'ID' then
    Column.Visible := false;

  if Column.FieldName = 'ID_EMPRESA' then
    Column.Visible := false;

  if Column.FieldName = 'PAGO' then
    Column.Visible := false;
end;

procedure TformListarLotes.FormCreate(Sender: TObject);
begin
  classeLotes := TLotes.Create;
  functions := TFunctions.Create;
  DataSource := TDataSource.Create(nil);

  ClientDataSet := TClientDataSet.Create(nil);
  ClientDataSet.FieldDefs.Add('id', ftInteger);
  ClientDataSet.FieldDefs.Add('id_empresa', ftInteger);
  ClientDataSet.FieldDefs.Add('codigo', ftString, 20);
  ClientDataSet.FieldDefs.Add('op', ftString, 20);
  ClientDataSet.FieldDefs.Add('descricao', ftString, 100);
  ClientDataSet.FieldDefs.Add('empresa', ftString, 30);
  ClientDataSet.FieldDefs.Add('quantidade', ftInteger);
  ClientDataSet.FieldDefs.Add('valor_unit', ftCurrency);
  ClientDataSet.FieldDefs.Add('valor_total', ftCurrency);
  ClientDataSet.FieldDefs.Add('tempo_min', ftFloat);
  ClientDataSet.FieldDefs.Add('tempo_total', ftFloat);
  ClientDataSet.FieldDefs.Add('data_entrada', ftDate);
  ClientDataSet.CreateDataSet;

  DataSource.DataSet := ClientDataSet;
  DBGrid.DataSource := DataSource;
end;

procedure TformListarLotes.FormResize(Sender: TObject);
begin
  functions.redimensionarGrid(DBGrid);
end;

procedure TformListarLotes.FormShow(Sender: TObject);
begin
  SQL;
end;

function TformListarLotes.loteIncluido: boolean;
var
  jsonResponse: TJSONObject;
  responseDados: string;
begin
  //verificar lote na produção
  classeLotes.value := ClientDataSet.FieldByName('id').AsInteger;
  classeLotes.tabelaBanco := 'tab_controleproducao_corpo';
  classeLotes.coluna := 'id_lote';
  classeLotes.tipoRetorno := 'object';
  classeLotes.url := 'http://localhost:9000/producoes/producao';
  responseDados := classeLotes.getLote;

  jsonResponse := TJSONObject.Create;
  jsonResponse := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

  if jsonResponse.Count > 0 then
  begin
    Application.MessageBox('Erro ao excluir o lote selecionado!' + sLineBreak + 
      'Esse lote já se encontra em uma produção!', 'Atenção', MB_ICONWARNING + MB_OK);
    result := true;
    exit;
  end;

  //verificar contas a receber
  classeLotes.value := ClientDataSet.FieldByName('id').AsInteger;
  classeLotes.tabelaBanco := 'tab_contasreceber';
  classeLotes.coluna := 'id_lote';
  classeLotes.tipoRetorno := 'object';
  classeLotes.url := 'http://localhost:9000/contasreceber/conta';
  responseDados := classeLotes.getLote;

  jsonResponse := TJSONObject.Create;
  jsonResponse := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

  if jsonResponse.Count > 0 then
  begin
    Application.MessageBox('Erro ao excluir o lote selecionado!' + sLineBreak + 
      'Esse lote já está incluído no contas a receber!', 'Atenção', MB_ICONWARNING + MB_OK);
    result := true;
    exit;
  end;

  result := false;
end;

procedure TformListarLotes.SQL;
begin
  try
    ClientDataSet.EmptyDataSet;
    ClientDataSet.LoadFromJSON(classeLotes.getDados);

    editarDBGrid;
    cbFiltroMesesChange(Self);

  except
    abort;
  end;
end;

end.
