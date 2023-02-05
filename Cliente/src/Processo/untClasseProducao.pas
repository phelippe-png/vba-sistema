unit untClasseProducao;

interface

uses
  IdHTTP, System.Classes, System.JSON, System.SysUtils, functions;

type
  TProducao = class
  private
    dadosProducao: TJSONObject;
    stream: TStream;
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

    functions: TFunctions;
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
    procedure enviarDadosProducao;
    procedure enviarDadosCorpoProducao;
    procedure enviarDadosContasReceber;
    procedure alterarStatusProducao;
    procedure excluirProducao(id: integer);
    procedure excluirCorpoProducao(id: integer);
  end;

implementation

procedure TProducao.alterarStatusProducao;
begin
  dadosProducao := TJSONObject.Create;
  dadosProducao.AddPair('id', FidProducao.ToString);
  dadosProducao.AddPair('tabelaBanco', 'tab_controleproducao');
  dadosProducao.AddPair('status', Fstatus);

  stream := TStringStream.Create(dadosProducao.ToJSON);
  functions.httpRequest(httpPut, 'htt://localhost:9000/producoes', stream);

  if Fstatus = 'FINALIZADO' then
  begin
    dadosProducao := TJSONObject.Create;
    dadosProducao.AddPair('id', FidProducao.ToString);
    dadosProducao.AddPair('tabelaBanco', 'tab_controleproducao_corpo');
    dadosProducao.AddPair('coluna', 'id_producao');
    dadosProducao.AddPair('finalizado', TJSONBool.Create(true));

    stream := TStringStream.Create(dadosProducao.ToJSON);
    functions.httpRequest(httpPut, 'htt://localhost:9000/producoes', stream);
  end;
end;

constructor TProducao.Create;
begin
  modo := 'adicionar';
  functions := TFunctions.Create;
end;

procedure TProducao.enviarDadosContasReceber;
var
  s: string;
begin
  dadosProducao := TJSONObject.Create;
  dadosProducao.AddPair('id', FidCorpoProducao.ToString);
  dadosProducao.AddPair('tabelaBanco', 'tab_contasreceber');
  dadosProducao.AddPair('id_lote', FidLote.ToString);
  dadosProducao.AddPair('valor', CurrToStr(FvalorLote).Replace(',', '.'));

  stream := TStringStream.Create(dadosProducao.ToJSON);
  functions.httpRequest(httpPost, 'http://localhost:9000/contasreceber', stream);
end;

procedure TProducao.enviarDadosCorpoProducao;
begin
  dadosProducao := TJSONObject.Create;
  dadosProducao.AddPair('id', FidCorpoProducao.ToString);
  dadosProducao.AddPair('tabelaBanco', 'tab_controleproducao_corpo');
  dadosProducao.AddPair('id_lote', FidLote.ToString);
  dadosProducao.AddPair('finalizado', TJSONBool.Create(Ffinalizado));

  if FidProducao <> 0 then
    dadosProducao.AddPair('id_producao', FidProducao.ToString);

  stream := TStringStream.Create(dadosProducao.ToJSON);

  if modo = 'adicionar' then
    functions.httpRequest(httpPost, 'http://localhost:9000/producoes', stream);

  if modo = 'editar' then
    functions.httpRequest(httpPut, 'http://localhost:9000/producoes', stream);
end;

procedure TProducao.enviarDadosProducao;
begin
  dadosProducao := TJSONObject.Create;
  dadosProducao.AddPair('id', FidProducao.ToString);
  dadosProducao.AddPair('tabelaBanco', 'tab_controleproducao');
  dadosProducao.AddPair('id_empresa', FidEmpresa.ToString);
  dadosProducao.AddPair('empresa', Fempresa);
  dadosProducao.AddPair('data_inicio', DateToStr(FdataInicio));
  dadosProducao.AddPair('data_final', DateToStr(FdataFinal));
  dadosProducao.AddPair('quantidade_total', FquantidadeTotal.ToString);
  dadosProducao.AddPair('quantidade_produzir', FquantidadeProduzir.ToString);
  dadosProducao.AddPair('valor_total', CurrToStr(FvalorTotal).Replace(',', '.'));
  dadosProducao.AddPair('tempo_total', FloatToStr(FtempoTotal).Replace(',', '.'));

  stream := TStringStream.Create(dadosProducao.ToJSON);

  if modo = 'adicionar' then
    functions.httpRequest(httpPost, 'http://localhost:9000/producoes', stream)
  else if modo = 'editar' then
    functions.httpRequest(httpPut, 'http://localhost:9000/producoes', stream);
end;

procedure TProducao.excluirCorpoProducao(id: integer);
begin
  dadosProducao := TJSONObject.Create;
  dadosProducao.AddPair('id', id.ToString);
  dadosProducao.AddPair('tabelaBanco', 'tab_controleproducao_corpo');
  dadosProducao.AddPair('coluna', Fcoluna);

  stream := TStringStream.Create(dadosProducao.ToJSON);

  functions.httpRequest(httpDelete, 'http://localhost:9000/producoes', stream);

  Fcoluna := '';
end;

procedure TProducao.excluirProducao(id: integer);
begin
  dadosProducao := TJSONObject.Create;
  dadosProducao.AddPair('id', id.ToString);
  dadosProducao.AddPair('tabelaBanco', 'tab_controleproducao');

  stream := TStringStream.Create(dadosProducao.ToJSON);

  functions.httpRequest(httpDelete, 'http://localhost:9000/producoes', stream);
end;

end.
