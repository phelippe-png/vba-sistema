unit untClasseLotes;

interface

uses
  IdHTTP, System.JSON, System.SysUtils, System.Classes, DataSet.Serialize,
  untClasseEmpresas, functions, FireDAC.Comp.Client, BancoFuncoes, Vcl.Dialogs,
  System.Generics.Collections;

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
    procedure excluirLote(vId: integer);
    function buscarDados: TFDQuery;
    function buscarLote: TFDQuery;
  end;

implementation

procedure TLotes.inserirDados;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      Add('id_empresa', FIDEmpresa);
      Add('codigo', FCodigo);
      Add('op', FOP);
      Add('descricao', FDescricao);
      Add('data_entrada', DateToStr(FDataEntrada));
      Add('quantidade', FQuantidade);
      Add('valor_unit', FValorUnit);
      Add('valor_total', FValorTotal);
      Add('tempo_min', FTempoMin);
      Add('tempo_total', FTempoTotal);
    end;

    if editar then
      BDAtualizarRegistros('tab_lotes', ' id = ' + FidLote.ToString, vDicDados)
    else
      BDInserirRegistros('tab_lotes', ' id ', ' tab_lotes_id_seq ', vDicDados);
  finally
    vDicDados := nil;
  end;
end;

procedure TLotes.excluirLote(vId: integer);
begin
  try
    BDExcluirRegistro('tab_lotes', ' id = ' + vId.ToString);
  except on E: Exception do
    ShowMessage('Erro ao excluir lote! Erro: ' + E.Message);
  end;
end;

function TLotes.buscarDados: TFDQuery;
begin
  Result := BDBuscarRegistros('tab_lotes tl', 'tl.*, te.nomefantasia empresa',
  'left join tab_empresas te on te.id = tl.id_empresa', EmptyStr, EmptyStr, EmptyStr, -1, 'fdqBuscaLotes');
end;

function TLotes.buscarLote: TFDQuery;
begin
  
end;

end.
