unit untListarEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, IdHTTP, System.JSON, DataSet.Serialize, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FireDAC.Comp.Client, Vcl.WinXPanels,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, untCadastrarEmpresa, System.Types,
  untClasseEmpresas, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, Datasnap.DBClient, functions;

type
  TformListarEmpresas = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    pnlSearch: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    btnDelete: TPanel;
    btnEdit: TPanel;
    btnAdd: TPanel;
    DBGrid: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Panel2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ClientDataSet: TClientDataSet;
    DataSource: TDataSource;
    formCadastrarEmpresa: TformCadastrarEmpresa;
    classeEmpresa: TEmpresa;
    functions: TFunctions;

    procedure EditDBGrid;
    procedure SQL;
    function existeEmpresaIncluida: boolean;
  public
    selecionado: boolean;
    mudarEstadoDBGrid: boolean;
    esconderColunas: boolean;
  end;

var
  formListarEmpresas: TformListarEmpresas;

implementation

{$R *.dfm}

procedure TformListarEmpresas.btnAddClick(Sender: TObject);
begin
  try
    formCadastrarEmpresa := TformCadastrarEmpresa.Create(self);
    formCadastrarEmpresa.ShowModal;
  finally
    SQL;
  end;
end;

procedure TformListarEmpresas.btnEditClick(Sender: TObject);
var
  I: Integer;
  dadosEmpresa: TJSONObject;
begin
  if ClientDataSet.RecordCount = 0 then
    exit;

  dadosEmpresa := TJSONObject.Create;
  formCadastrarEmpresa := TformCadastrarEmpresa.Create(self);

  try
    formCadastrarEmpresa.idAtualizarEmpresa := DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;
    dadosEmpresa.AddPair('razaosocial', DBGrid.DataSource.DataSet.FieldByName('razaosocial').AsString);
    dadosEmpresa.AddPair('nomefantasia', DBGrid.DataSource.DataSet.FieldByName('nomefantasia').AsString);
    dadosEmpresa.AddPair('cpf_cnpj', DBGrid.DataSource.DataSet.FieldByName('cpf_cnpj').AsString);
    dadosEmpresa.AddPair('insc_estadual', DBGrid.DataSource.DataSet.FieldByName('insc_estadual').AsString);
    dadosEmpresa.AddPair('telefone', DBGrid.DataSource.DataSet.FieldByName('telefone').AsString);
    dadosEmpresa.AddPair('cep', DBGrid.DataSource.DataSet.FieldByName('cep').AsString);
    dadosEmpresa.AddPair('logradouro', DBGrid.DataSource.DataSet.FieldByName('logradouro').AsString);
    dadosEmpresa.AddPair('numero', DBGrid.DataSource.DataSet.FieldByName('numero').AsString);
    dadosEmpresa.AddPair('bairro', DBGrid.DataSource.DataSet.FieldByName('bairro').AsString);
    dadosEmpresa.AddPair('cidade', DBGrid.DataSource.DataSet.FieldByName('cidade').AsString);
    dadosEmpresa.AddPair('uf', DBGrid.DataSource.DataSet.FieldByName('uf').AsString);

    formCadastrarEmpresa.carregarDados(dadosEmpresa);
    formCadastrarEmpresa.ShowModal;
  finally
    SQL;
  end;
end;

procedure TformListarEmpresas.SQL;
begin
  try
    ClientDataSet.EmptyDataSet;
    ClientDataSet.LoadFromJSON(classeEmpresa.getDados);

    EditDBGrid;
  except
    abort;
  end;
end;

procedure TformListarEmpresas.DBGridDblClick(Sender: TObject);
begin
  if mudarEstadoDBGrid then
    btnSelectClick(Self)
  else
    btnEditClick(Self);
end;

procedure TformListarEmpresas.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if ClientDataSet.FieldByName('numero').AsInteger > 500 then
  begin
    DBGrid.Canvas.Brush.Color := clGreen;
    DBGrid.DefaultDrawDataCell(Rect, dbgrid.columns[datacol].field, State);
  end;
end;

procedure TformListarEmpresas.EditDBGrid;
begin
  DBGrid.Columns.Items[0].Visible := false;

  TField(ClientDataSet.FieldByName('razaosocial')).DisplayLabel := 'Razão Social';
  TField(ClientDataSet.FieldByName('nomefantasia')).DisplayLabel := 'Nome Fantasia';
  TField(ClientDataSet.FieldByName('cpf_cnpj')).DisplayLabel := 'CPF/CNPJ';
  TField(ClientDataSet.FieldByName('insc_estadual')).DisplayLabel := 'Insc. Estadual';
  TField(ClientDataSet.FieldByName('telefone')).DisplayLabel := 'Telefone';
  TField(ClientDataSet.FieldByName('cep')).DisplayLabel := 'CEP';
  TField(ClientDataSet.FieldByName('logradouro')).DisplayLabel := 'Logradouro';
  TField(ClientDataSet.FieldByName('numero')).DisplayLabel := 'Número';
  TField(ClientDataSet.FieldByName('bairro')).DisplayLabel := 'Bairro';
  TField(ClientDataSet.FieldByName('cidade')).DisplayLabel := 'Cidade';
  TField(ClientDataSet.FieldByName('uf')).DisplayLabel := 'Estado';

  if esconderColunas then
  begin
    TField(ClientDataSet.FieldByName('insc_estadual')).Visible := false;
    TField(ClientDataSet.FieldByName('cep')).Visible := false;
    TField(ClientDataSet.FieldByName('logradouro')).Visible := false;
    TField(ClientDataSet.FieldByName('numero')).Visible := false;
    TField(ClientDataSet.FieldByName('bairro')).Visible := false;
    TField(ClientDataSet.FieldByName('cidade')).Visible := false;
    TField(ClientDataSet.FieldByName('uf')).Visible := false;
  end;

  functions.redimensionarGrid(DBGrid);
end;

procedure TformListarEmpresas.edSearchChange(Sender: TObject);
begin
  ClientDataSet.FilterOptions := [foCaseInsensitive];
  ClientDataSet.Filtered := false;
  ClientDataSet.Filter := 'razaosocial like ' + QuotedStr('%' + edSearch.Text + '%') + ' or' +
  ' nomefantasia like ' + QuotedStr('%' + edSearch.Text + '%');
  ClientDataSet.Filtered := true;
end;

function TformListarEmpresas.existeEmpresaIncluida: boolean;
var
  jsonResponse: TJSONObject;
  responseDados: string;
begin
  classeEmpresa.value := ClientDataSet.FieldByName('id').AsString;
  classeEmpresa.tabelaBanco := 'tab_lotes';
  classeEmpresa.coluna := 'id_empresa';
  classeEmpresa.tipoRetorno := 'object';
  classeEmpresa.url := 'http://localhost:9000/lotes/lote';
  responseDados := classeEmpresa.getEmpresa;

  jsonResponse := TJSONObject.Create;
  jsonResponse := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

  if jsonResponse.Count > 0 then
  begin
    Application.MessageBox('Erro ao excluir empresa!' + sLineBreak +
      'Existem lotes cadastrados nessa empresa!', 'Atenção', MB_ICONWARNING + MB_OK);
    result := true;
    exit;
  end;

  result := false
end;

procedure TformListarEmpresas.FormCreate(Sender: TObject);
begin
  classeEmpresa := TEmpresa.Create;
  functions := TFunctions.Create;
  DataSource := TDataSource.Create(nil);

  ClientDataSet := TClientDataSet.Create(nil);
  ClientDataSet.FieldDefs.Add('id', ftInteger);
  ClientDataSet.FieldDefs.Add('razaosocial', ftString, 50);
  ClientDataSet.FieldDefs.Add('nomefantasia', ftString, 50);
  ClientDataSet.FieldDefs.Add('cpf_cnpj', ftString, 18);
  ClientDataSet.FieldDefs.Add('insc_estadual', ftString, 15);
  ClientDataSet.FieldDefs.Add('telefone', ftString, 15);
  ClientDataSet.FieldDefs.Add('cep', ftString, 10);
  ClientDataSet.FieldDefs.Add('logradouro', ftString, 50);
  ClientDataSet.FieldDefs.Add('numero', ftInteger);
  ClientDataSet.FieldDefs.Add('bairro', ftString, 50);
  ClientDataSet.FieldDefs.Add('cidade', ftString, 50);
  ClientDataSet.FieldDefs.Add('uf', ftString, 2);
  ClientDataSet.CreateDataSet;

  DataSource.DataSet := ClientDataSet;
  DBGrid.DataSource := DataSource;

  mudarEstadoDBGrid := false;
end;

procedure TformListarEmpresas.FormResize(Sender: TObject);
begin
  functions.redimensionarGrid(DBGrid);
end;

procedure TformListarEmpresas.FormShow(Sender: TObject);
begin
  SQL;
end;

procedure TformListarEmpresas.Panel2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TformListarEmpresas.btnDeleteClick(Sender: TObject);
begin
  if existeEmpresaIncluida then
    exit;

  if Application.MessageBox('Deseja realmente excluir a empresa?', 'Confirmação', MB_ICONINFORMATION + MB_YESNO) = ID_YES then
  begin
    classeEmpresa.deletarRegistro(ClientDataSet.FieldByName('id').AsInteger);
    SQL;
  end;
end;

procedure TformListarEmpresas.btnExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformListarEmpresas.btnSelectClick(Sender: TObject);
begin
  selecionado := true;
  Self.Close;
end;

end.
