unit untClasseContasPagar;

interface

uses
  System.JSON, System.Classes, DataSet.Serialize, System.SysUtils, IdHTTP,
  functions;

const
  tabelaBanco = 'tab_contaspagar';

type
  TContasPagar = class
  private
    Fid: integer;
    Fdescricao: string;
    FdataVenc: TDate;
    FvalorTotal: Currency;
    FvalorPago: Currency;

    functions: TFunctions;
    dadosConta: TJSONObject;
    convertDadosToStream: TStream;
    FtotalPagar: Currency;
  public
    editar: boolean;
    property id: integer read Fid write Fid;
    property descricao: string read FDescricao write FDescricao;
    property dataVenc: TDate read FDataVenc write FDataVenc;
    property valorTotal: Currency read FvalorTotal write FvalorTotal;
    property valorPago: Currency read FvalorPago write FvalorPago;
    property totalPagar: Currency read FtotalPagar write FtotalPagar;

    procedure inserirDadosConta;
    procedure inserirValorPago;
    procedure confirmarPagamento;
    procedure excluirConta;
    constructor Create;
  end;

implementation

procedure TContasPagar.confirmarPagamento;
begin
  dadosConta := TJSONObject.Create;

  try
    dadosConta.AddPair('id', Fid.ToString);
    dadosConta.AddPair('tabelaBanco', tabelaBanco);
    dadosConta.AddPair('valor_pago', CurrToStr(FvalorTotal).Replace(',', '.'));
    dadosConta.AddPair('total_pagar', CurrToStr(0.00));
    dadosConta.AddPair('pago', TJSONBool.Create(true));

    convertDadosToStream := TStringStream.Create(dadosConta.ToJSON);

    functions.httpRequest(put, 'http://localhost:9000/contaspagar', convertDadosToStream);
  except on e:Exception do
    raise Exception.Create('Erro ao confirmar pagamento!');
  end;
end;

constructor TContasPagar.Create;
begin
  functions := TFunctions.Create;
  dadosConta := TJSONObject.Create;
end;

procedure TContasPagar.excluirConta;
begin
  dadosConta := TJSONObject.Create;

  try
    dadosConta.AddPair('id', Fid.ToString);
    dadosConta.AddPair('tabelaBanco', tabelaBanco);

    convertDadosToStream := TStringStream.Create(dadosConta.ToJSON);

    functions.httpRequest(delete, 'http://localhost:9000/contaspagar', convertDadosToStream);
  except
    raise Exception.Create('Error Message');
  end;
end;

procedure TContasPagar.inserirValorPago;
begin
  dadosConta := TJSONObject.Create;

  try
    dadosConta.AddPair('id', Fid.ToString);
    dadosConta.AddPair('tabelaBanco', tabelaBanco);
    dadosConta.AddPair('valor_pago', CurrToStr(FvalorPago).Replace(',', '.'));
    dadosConta.AddPair('total_pagar', CurrToStr(FtotalPagar).Replace(',', '.'));

    if FtotalPagar = 0.00 then
      dadosConta.AddPair('pago', TJSONBool.Create(true));

    convertDadosToStream := TStringStream.Create(dadosConta.ToJSON);

    functions.httpRequest(put, 'http://localhost:9000/contaspagar', convertDadosToStream);
  except
    raise Exception.Create('Error Message');
  end;
end;

procedure TContasPagar.inserirDadosConta;
begin
  dadosConta := TJSONObject.Create;

  try
    dadosConta.AddPair('id', Fid.ToString);
    dadosConta.AddPair('tabelaBanco', tabelaBanco);
    dadosConta.AddPair('descricao', Fdescricao);
    dadosConta.AddPair('data_venc', DateToStr(FdataVenc));
    dadosConta.AddPair('valor_total', CurrToStr(FvalorTotal).Replace(',', '.'));
    dadosConta.AddPair('total_pagar', CurrToStr(FtotalPagar).Replace(',', '.'));

    convertDadosToStream := TStringStream.Create(dadosConta.ToJSON);

    if not editar then
      functions.httpRequest(post, 'http://localhost:9000/contaspagar', convertDadosToStream)
    else
      functions.httpRequest(put, 'http://localhost:9000/contaspagar', convertDadosToStream)
  except
    raise Exception.Create('Error Message');
  end;
end;

end.
