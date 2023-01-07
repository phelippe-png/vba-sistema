unit untClasseEmpresas;

interface

uses
  IdHTTP, System.JSON, System.Classes, System.SysUtils, Vcl.DBGrids, functions;

type
  TEmpresa = class
  private
    FrazaoSocial: String;
    FnomeFantasia: string;
    Fcpf_cnpj: string;
    FinscEstadual: string;
    Ftelefone: string;
    Fcep: string;
    Flogradouro: string;
    Fnumero: integer;
    Fbairro: string;
    Fcidade: string;
    Fuf: string;
    Fvalue: string;
    FtabelaBanco: string;
    Fcoluna: string;
    FtipoRetorno: string;
    Furl: string;
    FidAtualizarEmpresa: integer;
    functions: TFunctions;

    stream: TStream;
    dadosEmpresa: TJSONObject;
  public
    editar: boolean;

    property razaoSocial: string read FRazaoSocial write FRazaoSocial;
    property nomeFantasia: string read FNomeFantasia write FNomeFantasia;
    property cpf_cnpj: string write FCPF_CNPJ;
    property inscEstadual: string write FInscEstadual;
    property telefone: string write FTelefone;
    property cep: string write FCEP;
    property logradouro: string write FLogradouro;
    property numero: integer write FNumero;
    property bairro: string write FBairro;
    property cidade: string write FCidade;
    property uf: string write FUF;
    property value: string read Fvalue write Fvalue;
    property tabelaBanco: string read FtabelaBanco write FtabelaBanco;
    property coluna: string read Fcoluna write Fcoluna;
    property idAtualizarEmpresa: integer read FIDAtualizarEmpresa write FIDAtualizarEmpresa;
    property tipoRetorno: string read FtipoRetorno write FtipoRetorno;
    property url: string read Furl write Furl;

    function getEmpresa: string;
    procedure cadastrarDados;
    function getDados: string;
    procedure deletarRegistro(id: integer);
    function validaCPF(CPF: string): boolean;
    function validaCNPJ(CNPJ: string): boolean;
    function validarCEP(CEP: string): string;
    constructor Create;
  end;

implementation

constructor TEmpresa.Create;
begin
  functions := TFunctions.Create;
  dadosEmpresa := TJSONObject.Create;
end;

function TEmpresa.getEmpresa: string;
begin
  result := functions.buscarDados(Fvalue, FtabelaBanco, Fcoluna, tipoRetorno, url);
end;

procedure TEmpresa.deletarRegistro(id: integer);
begin
  dadosEmpresa := TJSONObject.Create;
  dadosEmpresa.AddPair('id', id.ToString);
  dadosEmpresa.AddPair('tabelaBanco', 'tab_empresas');

  stream := TStringStream.Create(dadosEmpresa.ToJSON);

  functions.httpRequest(delete, 'http://localhost:9000/empresas', stream);
end;

function TEmpresa.getDados: string;
begin
  stream := TStringStream.Create('tab_empresas');

  result := functions.httpRequest(get, 'http://localhost:9000/empresas', stream);
end;

procedure TEmpresa.cadastrarDados;
begin
  dadosEmpresa := TJSONObject.Create;
  dadosEmpresa.AddPair('id', FidAtualizarEmpresa.ToString);
  dadosEmpresa.AddPair('tabelaBanco', 'tab_empresas');
  dadosEmpresa.AddPair('razaosocial', FrazaoSocial);
  dadosEmpresa.AddPair('nomefantasia', FnomeFantasia);
  dadosEmpresa.AddPair('cpf_cnpj', Fcpf_cnpj);
  dadosEmpresa.AddPair('insc_estadual', FinscEstadual);
  dadosEmpresa.AddPair('telefone', Ftelefone);
  dadosEmpresa.AddPair('cep', Fcep);
  dadosEmpresa.AddPair('logradouro', Flogradouro);
  dadosEmpresa.AddPair('numero', Fnumero.ToString);
  dadosEmpresa.AddPair('bairro', Fbairro);
  dadosEmpresa.AddPair('cidade', Fcidade);
  dadosEmpresa.AddPair('uf', Fuf);

  Stream := TStringStream.Create(dadosEmpresa.ToJSON);

  if editar = false then
  begin
    functions.httpRequest(post, 'http://localhost:9000/empresas', Stream);
  end
  else
  begin
    functions.httpRequest(put, 'http://localhost:9000/empresas', Stream);
  end;
end;

function TEmpresa.validarCEP(CEP: string): string;
var
  cepReplaced: string;
begin
  cepReplaced := CEP.Replace('.', '').Replace('-', '');

  result := functions.httpRequest(get, 'https://viacep.com.br/ws/' + cepReplaced + '/json/');
end;

function TEmpresa.validaCPF(CPF: string): boolean;
var
  digito10, digito11: string;
  s, I, r, peso: integer;
begin
  if ((CPF = '00000000000') or (CPF = '11111111111') or (CPF = '22222222222') or
    (CPF = '33333333333') or (CPF = '44444444444') or (CPF = '55555555555') or
    (CPF = '66666666666') or (CPF = '77777777777') or (CPF = '88888888888') or
    (CPF = '99999999999') or (length(CPF) <> 11)) then
  begin
    result := false;
    exit;
  end;

  try
    // calculo do primeiro dígito
    s := 0;
    peso := 10;

    for I := 1 to 9 do
    begin
      s := s + (StrToInt(CPF[I]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if (r = 10) or (r = 11) then
      digito10 := '0'
    else
      str(r: 1, digito10);

    // calculo do segundo dígito
    s := 0;
    peso := 11;

    for I := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[I]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if (r = 10) or (r = 11) then
      digito11 := '0'
    else
      str(r: 1, digito11);

    // verifica se os digitos calculados conferem com os digitos informados
    if ((digito10 = CPF[10]) and (digito11 = CPF[11])) then
      result := true
    else
      result := false;
  except
    result := false
  end;
end;

function TEmpresa.validaCNPJ(CNPJ: string): boolean;
var
  digito13, digito14: string;
  sm, I, r, peso: integer;
begin
  if ((CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
    (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
    (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
    (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
    (CNPJ = '88888888888888') or (CNPJ = '99999999999999') or
    (length(CNPJ) <> 14)) then
  begin
    result := false;
    exit;
  end;

  try
    //calculo do primeiro dígito
    sm := 0;
    peso := 2;

    for I := 12 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[I]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;

    r := sm mod 11;

    if (r = 0) or (r = 1) then
      digito13 := '0'
    else
      str((11 - r): 1, digito13);

    //calculo do segundo dígito
    sm := 0;
    peso := 2;

    for I := 13 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[I]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;

    r := sm mod 11;

    if (r = 0) or (r = 1) then
      digito14 := '0'
    else
      str((11 - r): 1, digito14);

    // verifica se os digitos calculados conferem com os digitos informados
    if ((digito13 = CNPJ[13]) and (digito14 = CNPJ[14])) then
      result := true
    else
      result := false;
  except
    result := false
  end;
end;

end.
