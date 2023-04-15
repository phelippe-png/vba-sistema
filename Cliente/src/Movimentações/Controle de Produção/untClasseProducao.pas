unit untClasseProducao;

interface

uses
  IdHTTP, System.Classes, System.JSON, System.SysUtils, functions, BancoFuncoes,
  System.Generics.Collections;

type
  TProducao = class
  private
    FidEmpresa: integer;
    Fempresa: string;
    FdataInicio: TDate;
    FdataFinal: TDate;
    Fstatus: string;
    FquantidadeTotal: integer;
    FquantidadeProduzir: integer;
    FvalorTotal: Currency;
    FtempoTotal: Double;
    FidProducao: integer;
    FidLote: integer;
    Ffinalizado: boolean;
    FidCorpoProducao: integer;
    FvalorLote: currency;
    Fcoluna: string;

  public
    modo: string;
    property idEmpresa: integer read FidEmpresa write FidEmpresa;
    property empresa: string read Fempresa write Fempresa;
    property dataInicio: TDate read FdataInicio write FdataInicio;
    property dataFinal: TDate read FdataFinal write FdataFinal;
    property status: string read Fstatus write Fstatus;
    property quantidadeTotal: integer read FquantidadeTotal write FquantidadeTotal;
    property quantidadeProduzir: integer read FquantidadeProduzir write FquantidadeProduzir;
    property valorTotal: Currency read FvalorTotal write FvalorTotal;
    property tempoTotal: Double read FtempoTotal write FtempoTotal;
    property idProducao: integer read FidProducao write FidProducao;
    property idCorpoProducao: integer read FidCorpoProducao write FidCorpoProducao;
    property idLote: integer read FidLote write FidLote;
    property finalizado: boolean read Ffinalizado write Ffinalizado;
    property valorLote: currency read FvalorLote write FvalorLote;
    property coluna: string read Fcoluna write Fcoluna;

    constructor Create;
    function enviarDadosProducao: Integer;
    function enviarDadosCorpoProducao: Integer;
    function enviarDadosContasReceber: Integer;
    procedure alterarStatusProducao;
    procedure excluirProducao(id: integer);
    procedure excluirCorpoProducao(id: integer);
  end;

implementation

procedure TProducao.alterarStatusProducao;
var
  vDicDados: TDictionary<String, Variant>;
begin
  try
    vDicDados := TDictionary<String, Variant>.Create;
    vDicDados.Add('status', Fstatus);
    BDAtualizarRegistros('tab_controleproducao', ' id = ' + FidProducao.ToString, vDicDados);

    if Fstatus = 'FINALIZADO' then
    begin
      vDicDados := TDictionary<String, Variant>.Create;
      vDicDados.Add('finalizado', True);
      BDAtualizarRegistros('tab_controleproducao_corpo', ' id_producao = ' + FidProducao.ToString, vDicDados);
    end;
  finally
    vDicDados.Destroy;
  end;
end;

constructor TProducao.Create;
begin
  modo := 'adicionar';
end;

function TProducao.enviarDadosContasReceber: Integer;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      Add('id_lote', FidLote);
      Add('valor', FvalorLote);
      Result := BDInserirRegistros('tab_contasreceber', ' id ', ' tab_contasreceber_id_seq ', vDicDados);
    end;
  finally
    vDicDados := nil;
  end;
end;

function TProducao.enviarDadosCorpoProducao: Integer;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      Add('id_lote', FidLote);
      Add('finalizado', Ffinalizado);
      Add('id_producao', FidProducao);
    end;

    if modo = 'adicionar' then
      Result := BDInserirRegistros('tab_controleproducao_corpo', ' id ', ' tab_controleproducao_corpo_id_seq ', vDicDados);

    if modo = 'editar' then
      BDAtualizarRegistros('tab_controleproducao_corpo', ' id = ' + FidCorpoProducao.ToString, vDicDados);
  finally
    vDicDados := nil;
  end;
end;

function TProducao.enviarDadosProducao: Integer;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      Add('id_empresa', FidEmpresa);
      Add('data_inicio', DateToStr(FdataInicio));
      Add('data_final', DateToStr(FdataFinal));
      Add('quantidade_total', FquantidadeTotal);
      Add('quantidade_produzir', FquantidadeProduzir);
      Add('valor_total', FvalorTotal);
      Add('tempo_total', FtempoTotal);
    end;

    if modo = 'adicionar' then
      Result := BDInserirRegistros('tab_controleproducao', ' id ', ' tab_controleproducao_id_seq ', vDicDados)
    else if modo = 'editar' then
      BDAtualizarRegistros('tab_controleproducao', ' id = ' + FidProducao.ToString, vDicDados);
  finally
    vDicDados := nil;
  end;
end;

procedure TProducao.excluirCorpoProducao(id: integer);
begin
  BDExcluirRegistro('tab_controleproducao_corpo', ' id_producao = ' + id.ToString);
end;

procedure TProducao.excluirProducao(id: integer);
begin
  BDExcluirRegistro('tab_controleproducao', ' id = ' + id.ToString);
end;

end.
