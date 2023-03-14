unit untCadastrarEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.Buttons, System.JSON, IdHTTP, IdSSLOpenSSL, IdTCPClient,
  IdSSLOpenSSLHeaders, DataSet.Serialize, untClasseEmpresas, MaskUtils, functions,
  System.Generics.Collections, BancoFuncoes;

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
    arrayCPF_CNPJFormats: TArray<string>;

    function existeEmpresaCadastrada: boolean;
  public
    property idAtualizarEmpresa: integer write FidAtualizarEmpresa;

    procedure carregarDados(vDicDados: TDictionary<string, Variant>);
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
  SisFormatarEdit(edCEP, tpFormatCep);

  try
    if Length(edCEP.Text) = 10 then
    begin
      jsonDadosCEP := TJSONObject.Create;
      jsonDadosCEP := TJSONObject.ParseJSONValue(SisValidarCEP(edCEP.Text)) as TJSONObject;

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
  SisEditKeyPress(edCEP, Key);
end;

procedure TformCadastrarEmpresa.edCPF_CNPJChange(Sender: TObject);
begin
  SisFormatarEdit(edCPF_CNPJ, tpFormatCpfCnpj);
end;

procedure TformCadastrarEmpresa.edCPF_CNPJKeyPress(Sender: TObject;
  var Key: Char);
begin
  SisEditKeyPress(edCPF_CNPJ, Key);
end;

procedure TformCadastrarEmpresa.edTelefoneChange(Sender: TObject);
begin
  SisFormatarEdit(edTelefone, tpFormatTelefone);
end;

procedure TformCadastrarEmpresa.edTelefoneKeyPress(Sender: TObject;
  var Key: Char);
begin
  SisEditKeyPress(edTelefone, Key);
end;

function TformCadastrarEmpresa.existeEmpresaCadastrada: boolean;
var
  jsonResponse: TJSONObject;
  responseDados: string;
begin
  if classeEmpresas.editar then
    exit;

  with BDBuscarRegistros('tab_empresas', EmptyStr, EmptyStr,
  ' cpf_cnpj = ' + QuotedStr(Trim(edCPF_CNPJ.Text)), EmptyStr, EmptyStr, -1, 'fdqBuscarEmpresa') do
  begin
    if RecordCount > 0 then
    begin
      Application.MessageBox('Erro ao cadastrar empresa!' + sLineBreak +
        'O CPF/CNPJ informado já possui cadastro!', 'Atenção', MB_ICONWARNING);
      Result := True;
      exit;
    end;
  end;

  Result := False;
end;

procedure TformCadastrarEmpresa.FormCreate(Sender: TObject);
var
  idHttp: TIdHTTP;
  ufs: TJSONArray;
  I: integer;
begin
  idHttp := TIdHTTP.Create;
  classeEmpresas := TEmpresa.Create;
  ufs := TJSONArray.Create;
  try
    ufs := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
    (idHttp.Get('https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome')), 0) as TJSONArray;

    for I := 0 to Pred(ufs.Count) do
      cbUF.Items.Add(UFs.Get(I).GetValue<string>('sigla'));
  finally
    idHttp.Destroy;
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

procedure TformCadastrarEmpresa.carregarDados(vDicDados: TDictionary<string, Variant>);
begin
  with vDicDados do
  begin
    edRazao.Text := Items['razaosocial'];
    edFantasia.Text := Items['nomefantasia'];
    edCPF_CNPJ.Text := Items['cpf_cnpj'];
    edIE.Text := Items['insc_estadual'];
    edTelefone.Text := Items['telefone'];
    edCEP.Text := Items['cep'];
    edLogradouro.Text := Items['logradouro'];
    edNumero.Text := Items['numero'];
    edBairro.Text := Items['bairro'];
    edCidade.Text := Items['cidade'];
    cbUF.ItemIndex := cbUF.Items.IndexOf(Items['uf']);
    classeEmpresas.editar := true;
  end;
end;

end.
