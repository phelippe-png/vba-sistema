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
  FireDAC.Comp.DataSet, Datasnap.DBClient, functions, BancoFuncoes,
  System.Generics.Collections;

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
    dbgEmpresas: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure dbgEmpresasDblClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ClientDataSet: TClientDataSet;
    DataSource: TDataSource;
    formCadastrarEmpresa: TformCadastrarEmpresa;
    classeEmpresa: TEmpresa;

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
var
  modalCadastrarEmpresa: TformCadastrarEmpresa;
begin
  modalCadastrarEmpresa := TformCadastrarEmpresa.Create(self);
  with modalCadastrarEmpresa do
    ShowModal;

  SQL;
end;

procedure TformListarEmpresas.btnEditClick(Sender: TObject);
var
  I: Integer;
  vDicDadosEmpresa: TDictionary<string, Variant>;
  modalCadastrarEmpresa: TformCadastrarEmpresa;
begin
  with dbgEmpresas, DataSource.DataSet do
  begin
    if RecordCount = 0 then
      exit;

    try
      vDicDadosEmpresa := TDictionary<string, Variant>.Create;
      modalCadastrarEmpresa := TformCadastrarEmpresa.Create(self);
      with vDicDadosEmpresa, modalCadastrarEmpresa do
      begin
        idAtualizarEmpresa := FieldByName('id').AsInteger;
        Add('razaosocial', FieldByName('razaosocial').AsString);
        Add('nomefantasia', FieldByName('nomefantasia').AsString);
        Add('cpf_cnpj', FieldByName('cpf_cnpj').AsString);
        Add('insc_estadual', FieldByName('insc_estadual').AsString);
        Add('telefone', FieldByName('telefone').AsString);
        Add('cep', FieldByName('cep').AsString);
        Add('logradouro', FieldByName('logradouro').AsString);
        Add('numero', FieldByName('numero').AsString);
        Add('bairro', FieldByName('bairro').AsString);
        Add('cidade', FieldByName('cidade').AsString);
        Add('uf', FieldByName('uf').AsString);

        carregarDados(vDicDadosEmpresa);
        ShowModal;
        Destroy;
      end;
    finally
      vDicDadosEmpresa.Destroy;
    end;
  end;

  SQL;
end;

procedure TformListarEmpresas.SQL;
begin
  dbgEmpresas.DataSource.DataSet := classeEmpresa.buscarDados;
  EditDBGrid;
end;

procedure TformListarEmpresas.dbgEmpresasDblClick(Sender: TObject);
begin
  if mudarEstadoDBGrid then
    btnSelectClick(Self)
  else
    btnEditClick(Self);
end;

procedure TformListarEmpresas.EditDBGrid;
begin
  with dbgEmpresas.DataSource.DataSet do
  begin
    if esconderColunas then
    begin
      TField(FieldByName('insc_estadual')).Visible := false;
      TField(FieldByName('cep')).Visible := false;
      TField(FieldByName('logradouro')).Visible := false;
      TField(FieldByName('numero')).Visible := false;
      TField(FieldByName('bairro')).Visible := false;
      TField(FieldByName('cidade')).Visible := false;
      TField(FieldByName('uf')).Visible := false;
    end;
  end;

  SISDBGridResizeColumns(dbgEmpresas);
end;

procedure TformListarEmpresas.edSearchChange(Sender: TObject);
begin
  with dbgEmpresas.DataSource.DataSet do
  begin
    FilterOptions := [foCaseInsensitive];
    Filtered := false;
    Filter := 'razaosocial like ' + QuotedStr('%' + edSearch.Text + '%') + ' or nomefantasia like ' + QuotedStr('%' + edSearch.Text + '%');
    Filtered := true;
  end;
end;

function TformListarEmpresas.existeEmpresaIncluida: boolean;
begin
  with BDBuscarRegistros('tab_lotes', EmptyStr, EmptyStr,
  ' id_empresa = ' + dbgEmpresas.DataSource.DataSet.FieldByName('id').AsInteger.ToString, EmptyStr, EmptyStr, -1, 'fdqBuscarEmpresa') do
  begin
    if RecordCount > 0 then
    begin
      Application.MessageBox('Erro ao excluir empresa!' + sLineBreak +
        'Existem lotes cadastrados nessa empresa!', 'Atenção', MB_ICONWARNING + MB_OK);
      Result := true;
      exit;
    end;
  end;

  result := false;
end;

procedure TformListarEmpresas.FormCreate(Sender: TObject);
begin
  classeEmpresa := TEmpresa.Create;
  mudarEstadoDBGrid := false;
end;

procedure TformListarEmpresas.FormShow(Sender: TObject);
begin
  dbgEmpresas.DataSource := BDCriarOuRetornarDataSource('dsGridEmpresas');

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
    classeEmpresa.deletarRegistro(dbgEmpresas.DataSource.DataSet.FieldByName('id').AsInteger);
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
  Close;
end;

end.
