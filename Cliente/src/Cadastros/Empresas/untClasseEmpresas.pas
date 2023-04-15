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

end.
