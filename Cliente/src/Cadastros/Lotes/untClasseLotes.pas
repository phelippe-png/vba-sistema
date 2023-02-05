unit untClasseLotes;

interface

uses
  IdHTTP, System.JSON, System.SysUtils, System.Classes, DataSet.Serialize,
  untClasseEmpresas, functions;

type
  TLotes = class
  private
    FidLote: integer;
    FIDEmpresa: integer;
    FCodigo: integer;
    FOP: integer;
    FDescricao: string;
    FEmpresa: TEmpresa;
    FDataEntrada: TDate;
    FDataSaida: TDate;
    FQuantidade: integer;
    FValorUnit: currency;
    FValorTotal: Currency;
    FTempoMin: Double;
    FTempoTotal: Double;
    FtabelaBanco: string;
    Fcoluna: string;
    Fvalue: Variant;
    FtipoRetorno: string;
    Furl: string;

    functions: TFunctions;
    dadosLote: TJSONObject;
    convertJSONToStream: TStream;
  public
    editar: boolean;

    property idLote: integer read FidLote write FidLote;
    property idEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property codigo: integer write FCodigo;
    property OP: integer write FOP;
    property descricao: string write FDescricao;
    property empresa: TEmpresa read FEmpresa write FEmpresa;
    property dataEntrada: TDate write FDataEntrada;
    property dataSaida: TDate write FDataSaida;
    property quantidade: integer write FQuantidade;
    property valorUnit: currency write FValorUnit;
    property valorTotal: Currency write FValorTotal;
    property tempoMin: Double write FTempoMin;
    property tempoTotal: Double read FtempoTotal write FtempoTotal;
    property tabelaBanco: string read FtabelaBanco write FtabelaBanco;
    property coluna: string read Fcoluna write Fcoluna;
    property value: Variant read Fvalue write Fvalue;
    property tipoRetorno: string read FtipoRetorno write FtipoRetorno;
    property url: string read Furl write Furl;

    procedure inserirDados;
    procedure excluirLote;
    function getDados: string;
    function getLote: string;
    function existeOP(op: string): boolean;
    constructor Create;
  end;

implementation

procedure TLotes.inserirDados;
begin
  dadosLote := TJSONObject.Create;
  dadosLote.AddPair('tabelaBanco', 'tab_lotes');
  dadosLote.AddPair('id', IntToStr(idLote));
  dadosLote.AddPair('id_empresa', FIDEmpresa.ToString);
  dadosLote.AddPair('codigo', FCodigo.ToString);
  dadosLote.AddPair('op', FOP.ToString);
  dadosLote.AddPair('descricao', FDescricao);
  dadosLote.AddPair('empresa', FEmpresa.RazaoSocial);
  dadosLote.AddPair('data_entrada', DateToStr(FDataEntrada));
  dadosLote.AddPair('quantidade', FQuantidade.ToString);
  dadosLote.AddPair('valor_unit', CurrToStr(FValorUnit).Replace(',', '.'));
  dadosLote.AddPair('valor_total', CurrToStr(FValorTotal).Replace(',', '.'));
  dadosLote.AddPair('tempo_min', CurrToStr(FTempoMin).Replace(',', '.'));
  dadosLote.AddPair('tempo_total', CurrToStr(FTempoTotal).Replace(',', '.'));

  convertJSONToStream := TStringStream.Create(dadosLote.ToJSON);

  try
    if editar then
      functions.httpRequest(httpPut, 'http://localhost:9000/lotes', convertJSONToStream)
    else
      functions.httpRequest(httpPost, 'http://localhost:9000/lotes', convertJSONToStream);
  except
    raise Exception.Create('Error Message');
  end;
end;

constructor TLotes.Create;
begin
  functions := TFunctions.Create;
end;

procedure TLotes.excluirLote;
begin
  dadosLote := TJSONObject.Create;
  dadosLote.AddPair('id', FidLote.ToString);
  dadosLote.AddPair('tabelaBanco', 'tab_lotes');

  convertJSONToStream := TStringStream.Create(dadosLote.ToJSON);

  functions.httpRequest(httpDelete, 'http://localhost:9000/lotes', convertJSONToStream);
end;

function TLotes.existeOP(op: string): boolean;
var
  jsonResponse: TJSONObject;
  responseDados: string;
begin
  Fvalue := op;
  FtabelaBanco := 'tab_lotes';
  Fcoluna := 'op';
  FtipoRetorno := 'object';
  Furl := 'http://localhost:9000/lotes/lote';

  responseDados := functions.buscarDados(Fvalue, FtabelaBanco, Fcoluna, FtipoRetorno, Furl);

  jsonResponse := TJSONObject.Create;
  jsonResponse := TJSONObject.ParseJSONValue(responseDados) as TJSONObject;

  if jsonResponse.Count > 0 then
  begin
    result := true;
    exit;
  end;

  result := false;
end;

function TLotes.getDados: string;
var
  stream: TStream;
begin
  stream := TStringStream.Create('tab_lotes');
  result := functions.httpRequest(httpGet, 'http://localhost:9000/lotes', stream);
end;

function TLotes.getLote: string;
begin
  result := functions.buscarDados(Fvalue, FtabelaBanco, Fcoluna, FtipoRetorno, Furl);
end;

end.
