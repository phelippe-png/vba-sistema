unit untClasseEmpresas;

interface

uses
  IdHTTP, System.JSON, System.Classes, System.SysUtils, Vcl.DBGrids, functions,
  FireDAC.Comp.Client, BancoFuncoes, System.Generics.Collections;

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

    procedure cadastrarDados;
    function buscarDados: TFDQuery;
    procedure deletarRegistro(id: integer);
    function validaCPF(CPF: string): boolean;
    function validaCNPJ(CNPJ: string): boolean;
    constructor Create;
  end;

implementation

constructor TEmpresa.Create;
begin
  dadosEmpresa := TJSONObject.Create;
end;

procedure TEmpresa.deletarRegistro(id: integer);
begin
  BDExcluirRegistro('tab_empresas', ' id = ' + id.ToString);
end;

function TEmpresa.buscarDados: TFDQuery;
begin
  Result := BDBuscarRegistros('tab_empresas', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, -1, 'fdqBuscaEmpresas');
end;

procedure TEmpresa.cadastrarDados;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      Add('razaosocial', FrazaoSocial);
      Add('nomefantasia', FnomeFantasia);
      Add('cpf_cnpj', Fcpf_cnpj);
      Add('insc_estadual', FinscEstadual);
      Add('telefone', Ftelefone);
      Add('cep', Fcep);
      Add('logradouro', Flogradouro);
      Add('numero', Fnumero.ToString);
      Add('bairro', Fbairro);
      Add('cidade', Fcidade);
      Add('uf', Fuf);
    end;

    if editar then
      BDAtualizarRegistros('tab_empresas', ' id = ' + idAtualizarEmpresa.ToString, vDicDados)
    else
      BDInserirRegistros('tab_empresas', ' id ', ' tab_empresas_id_seq ', vDicDados);
  finally
    vDicDados.Destroy;
  end;
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
