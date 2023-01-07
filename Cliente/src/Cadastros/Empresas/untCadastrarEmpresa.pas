unit untCadastrarEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Buttons, System.JSON, IdHTTP, IdSSLOpenSSL, IdTCPClient,
  IdSSLOpenSSLHeaders, DataSet.Serialize, untClasseEmpresas, MaskUtils, functions;

type
  TformCadastrarEmpresa = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel5: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    btnSave: TPanel;
    btnCancel: TPanel;
    edRazao: TEdit;
    edFantasia: TEdit;
    edCPF_CNPJ: TEdit;
    edIE: TEdit;
    edTelefone: TEdit;
    edLogradouro: TEdit;
    edNumero: TEdit;
    edCidade: TEdit;
    edBairro: TEdit;
    edCEP: TEdit;
    cbUF: TComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveMouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveMouseLeave(Sender: TObject);
    procedure btnCancelMouseEnter(Sender: TObject);
    procedure btnCancelMouseLeave(Sender: TObject);
    procedure edCEPChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edCPF_CNPJChange(Sender: TObject);
    procedure edCPF_CNPJKeyPress(Sender: TObject; var Key: Char);
    procedure edTelefoneChange(Sender: TObject);
    procedure edTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure edCEPKeyPress(Sender: TObject; var Key: Char);
  private
    classeEmpresas: TEmpresa;
    FidAtualizarEmpresa: integer;
    functions: TFunctions;
    arrayCPF_CNPJFormats: TArray<string>;

    function existeEmpresaCadastrada: boolean;
  public
    property idAtualizarEmpresa: integer write FidAtualizarEmpresa;

    procedure carregarDados(dadosEmpresa: TJSONObject);
  end;

var
  formCadastrarEmpresa: TformCadastrarEmpresa;

implementation

{$R *.dfm}

procedure TformCadastrarEmpresa.btnSaveClick(Sender: TObject);
var
  cpf_cnpjOnlyNumbers: string;
begin
  if (Trim(edRazao.Text) = '') or (Trim(edFantasia.Text) = '') or
    (Trim(edCPF_CNPJ.Text) = '') or (Trim(edIE.Text) = '') or
    (Trim(edTelefone.Text) = '') or (Trim(edCEP.Text) = '') or
    (Trim(edLogradouro.Text) = '') or (Trim(edNumero.Text) = '') or
    (Trim(edBairro.Text) = '') or (Trim(edCidade.Text) = '') or
    (Trim(cbUF.Text) = '') then
    begin
      Application.MessageBox('Preencha os campos vazios!', 'Atenção', MB_ICONWARNING + MB_OK);
      exit;
    end;

  if (existeEmpresaCadastrada) and (not classeEmpresas.editar) then
    exit;

  cpf_cnpjOnlyNumbers := Trim(edCPF_CNPJ.Text).Replace('.', '').Replace('/', '').Replace('-', '');

  if (classeEmpresas.validaCPF(cpf_cnpjOnlyNumbers) = false) and (classeEmpresas.validaCNPJ(cpf_cnpjOnlyNumbers) = false) then
  begin
    Application.MessageBox('CPF/CNPJ Inválido!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  try
    classeEmpresas.razaoSocial := edRazao.Text;
    classeEmpresas.nomeFantasia := edFantasia.Text;
    classeEmpresas.cpf_cnpj := edCPF_CNPJ.Text;
    classeEmpresas.inscEstadual := edIE.Text;
    classeEmpresas.telefone := edTelefone.Text;
    classeEmpresas.cep := edCEP.Text;
    classeEmpresas.logradouro := edLogradouro.Text;
    classeEmpresas.numero := StrToInt(edNumero.Text);
    classeEmpresas.bairro := edBairro.Text;
    classeEmpresas.cidade := edCidade.Text;
    classeEmpresas.uf := cbUF.Text;
    classeEmpresas.idAtualizarEmpresa := FIDAtualizarEmpresa;
    classeEmpresas.cadastrarDados;

    if classeEmpresas.editar then
      Application.MessageBox('Dados editados com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK)
    else
      Application.MessageBox('Empresa cadastrada com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);

    Self.Close;
  except on E:Exception do
    Application.MessageBox('Erro ao cadastrar empresa!', 'Erro', MB_ICONERROR + MB_OK);
  end;

end;

procedure TformCadastrarEmpresa.btnCancelClick(Sender: TObject);
begin
  Self.Close;
  FIDAtualizarEmpresa := 0;
end;

procedure TformCadastrarEmpresa.edCEPChange(Sender: TObject);
var
  jsonDadosCEP: TJSONObject;
begin
  functions.EditCepChange(edCEP);

  try
    if Length(edCEP.Text) = 10 then
    begin
      jsonDadosCEP := TJSONObject.Create;
      jsonDadosCEP := TJSONObject.ParseJSONValue(classeEmpresas.validarCEP(edCEP.Text)) as TJSONObject;

      edLogradouro.Text := jsonDadosCEP.GetValue<string>('logradouro');
      edBairro.Text := jsonDadosCEP.GetValue<string>('bairro');
      edCidade.Text := jsonDadosCEP.GetValue<string>('localidade');
      cbUF.ItemIndex := cbUF.Items.IndexOf(jsonDadosCEP.GetValue<string>('uf'));
    end;
  except
    Application.MessageBox('CEP inválido!', 'Atenção', MB_ICONWARNING + MB_OK);
  end;
end;

procedure TformCadastrarEmpresa.edCEPKeyPress(Sender: TObject; var Key: Char);
begin
  functions.EditCepKeyPress(edCEP, Key);
end;

procedure TformCadastrarEmpresa.edCPF_CNPJChange(Sender: TObject);
begin
  if Length(edCPF_CNPJ.Text) <= 14 then
    functions.EditCPFChange(edCPF_CNPJ);

  if Length(edCPF_CNPJ.Text) > 14 then
    functions.EditCNPJChange(edCPF_CNPJ);
end;

procedure TformCadastrarEmpresa.edCPF_CNPJKeyPress(Sender: TObject;
  var Key: Char);
begin
  functions.EditCPFCNPJKeyPress(edCPF_CNPJ, Key);
end;

procedure TformCadastrarEmpresa.edTelefoneChange(Sender: TObject);
begin
  functions.EditTelefoneChange(edTelefone);
end;

procedure TformCadastrarEmpresa.edTelefoneKeyPress(Sender: TObject;
  var Key: Char);
begin
  functions.EditTelefoneKeyPress(edTelefone, Key);
end;

function TformCadastrarEmpresa.existeEmpresaCadastrada: boolean;
var
  jsonResponse: TJSONObject;
  responseDados: string;
begin
  if classeEmpresas.editar then
    exit;

  classeEmpresas.value := Trim(edCPF_CNPJ.Text);
  classeEmpresas.tabelaBanco := 'tab_empresas';
  classeEmpresas.coluna := 'cpf_cnpj';
  classeEmpresas.tipoRetorno := 'object';
  classeEmpresas.url := 'http://localhost:9000/empresas/empresa';
  responseDados := classeEmpresas.getEmpresa;

  jsonResponse := TJSONObject.Create;
  jsonResponse := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

  if jsonResponse.Count > 0 then
  begin
    Application.MessageBox('Erro ao cadastrar empresa!' + sLineBreak +
      'O CPF/CNPJ informado ja possui cadastro!', 'Atenção', MB_ICONWARNING + MB_OK);
    result := true;
    exit;
  end;

  result := false;
end;

procedure TformCadastrarEmpresa.FormCreate(Sender: TObject);
var
  ufs: TJSONArray;
  I: integer;
begin
  classeEmpresas := TEmpresa.Create;
  functions := TFunctions.Create;
  ufs := TJSONArray.Create;
  ufs := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(functions.httpRequest(get, 'https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome', nil)), 0) as TJSONArray;

  for I := 0 to Pred(ufs.Count) do
  begin
    cbUF.Items.Add(UFs.Get(I).GetValue<string>('sigla'));
  end;
end;

procedure TformCadastrarEmpresa.btnCancelMouseEnter(Sender: TObject);
begin
  btnCancel.Color := clBlack;
end;

procedure TformCadastrarEmpresa.btnCancelMouseLeave(Sender: TObject);
begin
  btnCancel.Color := clRed;
end;

procedure TformCadastrarEmpresa.btnSaveMouseEnter(Sender: TObject);
begin
  btnSave.Color := clBlack;
end;

procedure TformCadastrarEmpresa.btnSaveMouseLeave(Sender: TObject);
begin
  btnSave.Color := $0007780B;
end;

procedure TformCadastrarEmpresa.carregarDados(dadosEmpresa: TJSONObject);
begin
  edRazao.Text := dadosEmpresa.GetValue<string>('razaosocial');
  edFantasia.Text := dadosEmpresa.GetValue<string>('nomefantasia');
  edCPF_CNPJ.Text := dadosEmpresa.GetValue<string>('cpf_cnpj');
  edIE.Text := dadosEmpresa.GetValue<string>('insc_estadual');
  edTelefone.Text := dadosEmpresa.GetValue<string>('telefone');
  edCEP.Text := dadosEmpresa.GetValue<string>('cep');
  edLogradouro.Text := dadosEmpresa.GetValue<string>('logradouro');
  edNumero.Text := dadosEmpresa.GetValue<string>('numero');
  edBairro.Text := dadosEmpresa.GetValue<string>('bairro');
  edCidade.Text := dadosEmpresa.GetValue<string>('cidade');
  cbUF.ItemIndex := cbUF.Items.IndexOf(dadosEmpresa.GetValue<string>('uf'));
  classeEmpresas.editar := true;
end;

end.
