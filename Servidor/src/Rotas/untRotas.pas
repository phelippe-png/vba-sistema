unit untRotas;

interface

uses
  System.SysUtils, Horse, untController, System.JSON,
  DataSet.Serialize, System.Generics.Collections, FireDAC.Comp.Client;

var
  dados: TJSONObject;
  value: variant;
  id: integer;
  tabelaBanco, where, tipoRetorno, coluna: string;
  reqJson: TJSONObject;

  Controller: TController;
  procedure Control(Horse: THorse);

  procedure getProducoesRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure getContasPagarRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure getContasReceberRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);

  procedure getDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure getByValue(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure getContasReceber(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure insertDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure deleteDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure updateDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Control(Horse: THorse);
begin
  coluna := '';

  Horse.Get('/empresas/empresa', getByValue);
  Horse.Get('/empresas', getDados);
  Horse.Post('/empresas', insertDados);
  Horse.Delete('/empresas', deleteDados);
  Horse.Put('/empresas', updateDados);

  Horse.Get('/lotes/lote', getByValue);
  Horse.Get('/lotes', getDados);
  Horse.Post('/lotes', insertDados);
  Horse.Delete('/lotes', deleteDados);
  Horse.Put('/lotes', updateDados);

  Horse.Get('/contaspagar', getDados);
  Horse.Post('/contaspagar', insertDados);
  Horse.Delete('/contaspagar', deleteDados);
  Horse.Put('/contaspagar', updateDados);

  Horse.Get('/producoes', getDados);
  Horse.Get('/producoes/producao', getByValue);
  Horse.Post('/producoes', insertDados);
  Horse.Delete('/producoes', deleteDados);
  Horse.Put('/producoes', updateDados);

  Horse.Get('/contasreceber/conta', getByValue);
  Horse.Get('/contasreceber', getContasReceber);
  Horse.Post('/contasreceber', insertDados);
  Horse.Put('/contasreceber', updateDados);
  Horse.Delete('/contasreceber', deleteDados);

  Horse.Get('/relatorio-controleproducao', getProducoesRelatorio);
  Horse.Get('/relatorio-contaspagar', getContasPagarRelatorio);
  Horse.Get('/relatorio-contasreceber', getContasReceberRelatorio);
end;

procedure getDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  tabelaBanco := req.Body;

  Controller := TController.Create;
  Res.Send<TJSONArray>(Controller.getDados(tabelaBanco).ToJSONArray);
  Controller.Free;
end;

procedure getByValue(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  reqJson := TJSONObject.ParseJSONValue(req.body) as TJSONObject;

  value := reqJson.GetValue<string>('value');
  tabelaBanco := reqJson.GetValue<string>('tabelaBanco');
  coluna := reqJson.GetValue<string>('coluna');
  tipoRetorno := reqJson.GetValue<string>('tipoRetorno');

  Controller := TController.Create;
  Res.Send<TJSONValue>(Controller.getByValue(value, tabelaBanco, coluna, tipoRetorno));
  Controller.Free;
end;

procedure insertDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  reqJson := TJSONObject.ParseJSONValue(req.body) as TJSONObject;

  tabelaBanco := reqJson.GetValue<string>('tabelaBanco');

  reqJson.RemovePair('id');
  reqJson.RemovePair('tabelaBanco');

  Controller := TController.Create;
  Controller.setDados(reqJson, tabelaBanco);
  Controller.Free;
end;

procedure updateDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  jsonValue: TJSONValue;
begin
  coluna := '';
  jsonValue := TJSONValue.Create;
  reqJson := TJSONObject.ParseJSONValue(req.body) as TJSONObject;

  id := reqJson.GetValue<integer>('id');
  tabelaBanco := reqJson.GetValue<string>('tabelaBanco');
  jsonValue := reqJson.GetValue('coluna');

  if jsonValue <> nil then
    coluna := jsonValue.Value;

  if coluna = '' then
    coluna := 'id';

  reqJson.RemovePair('id');
  reqJson.RemovePair('tabelaBanco');
  reqJson.RemovePair('coluna');

  Controller := TController.Create;
  Controller.updateDados(reqJson, id, tabelaBanco, coluna);
  Controller.Free;
end;

procedure deleteDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  jsonValue: TJSONValue;
begin
  coluna := '';
  jsonValue := TJSONValue.Create;
  reqJson := TJSONObject.ParseJSONValue(req.body) as TJSONObject;

  id := reqJson.GetValue<integer>('id');
  tabelaBanco := reqJson.GetValue<string>('tabelaBanco');
  jsonValue := reqJson.GetValue('coluna');

  if jsonValue <> nil then
    coluna := jsonValue.Value;

  if coluna = '' then
    coluna := 'id';

  Controller := TController.Create;
  Controller.deletarDados(id, tabelaBanco, coluna);
  Controller.Free;
end;

//
procedure getProducoesRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  where := req.Body;

  Controller := TController.Create;
  Res.Send<TJSONArray>(Controller.getProducoesRelatorio(where).ToJSONArray);
  Controller.Free;
end;

procedure getContasPagarRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  where: string;
begin
  where := Req.Body;

  Controller := TController.Create;
  Res.Send<TJSONArray>(Controller.getContasPagarRelatorio(where).ToJSONArray);
  Controller.Free;
end;

procedure getContasReceberRelatorio(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  where: string;
begin
  where := Req.Body;

  Controller := TController.Create;
  Res.Send<TJSONArray>(Controller.getContasReceberRelatorio(where).ToJSONArray);
  Controller.Free;
end;

procedure getContasReceber(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  reqJson := TJSONObject.ParseJSONValue(req.body) as TJSONObject;

//  where := reqJson.GetValue<string>('where');
//  tabelaBanco := reqJson.GetValue<string>('tabelaBanco');

  Controller := TController.Create;
  Res.Send<TJSONValue>(Controller.getContasReceber(tabelaBanco, where).ToJSONArray);
  Controller.Free;
end;

end.
