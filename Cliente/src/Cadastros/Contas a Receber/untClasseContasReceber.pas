unit untClasseContasReceber;

interface

uses
  functions, System.Classes, System.JSON, System.SysUtils;

type
  TContasReceber = class
  private
    functions: tfunctions;
    stream: TStream;
    jsonRequest: TJSONObject;
    FdataRecebimento: TDate;
    FidContaReceber: integer;
  public
    property idContaReceber: integer read FidContaReceber write FidContaReceber;
    property dataRecebimento: TDate read FdataRecebimento write FdataRecebimento;

    constructor Create;
    procedure confirmarRecebimento;
    procedure excluirConta;
  end;

implementation

procedure TContasReceber.confirmarRecebimento;
begin
  jsonRequest := TJSONObject.Create;

  try
    jsonRequest.AddPair('id', FidContaReceber.ToString);
    jsonRequest.AddPair('tabelaBanco', 'tab_contasreceber');
    jsonRequest.AddPair('data_recebimento', DateToStr(FdataRecebimento));
    jsonRequest.AddPair('recebido', TJSONBool.Create(true));

    stream := TStringStream.Create(jsonRequest.ToJSON);
  
    functions.httpRequest(httpPut, 'http://localhost:9000/contasreceber', stream);
  except
    
  end;
end;

constructor TContasReceber.Create;
begin
  functions := TFunctions.Create;
end;

procedure TContasReceber.excluirConta;
begin
  jsonRequest := TJSONObject.Create;

  try
    jsonRequest.AddPair('id', FidContaReceber.ToString);
    jsonRequest.AddPair('tabelaBanco', 'tab_contasreceber');

    stream := TStringStream.Create(jsonRequest.ToJSON);

    functions.httpRequest(httpDelete, 'http://localhost:9000/contasreceber', stream);
  except

  end;
end;

end.
