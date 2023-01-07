unit untRotasContasPagar;

interface

uses
  System.SysUtils, Horse, untController, System.JSON,
  DataSet.Serialize, System.Generics.Collections;

var
  Controller: TController;
  procedure Control(Horse: THorse);

  procedure getDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure insertDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure deleteDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure updateDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Control(Horse: THorse);
begin
  Horse.Get('/contaspagar', getDados);
  Horse.Post('/contaspagar', insertDados);
  Horse.Delete('/contaspagar', deleteDados);
  Horse.Put('/contaspagar', updateDados);
end;

procedure getDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  tabelaBanco: string;
begin
  Controller := TController.Create;
  Res.Send<TJSONArray>(Controller.getDados('tab_contaspagar').ToJSONArray);
  Controller.Free;
end;

procedure insertDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Controller := TController.Create;
  Controller.setDados(Req.Body<TJSONObject>, 'tab_contaspagar');
  Controller.Free;
  res.Send(res.Status.ToString);
end;

procedure deleteDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Controller := TController.Create;
  Controller.deletarDados(req.Params['id'].ToInteger, 'tab_contaspagar');
  Controller.Free;
end;

procedure updateDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Controller := TController.Create;
  Controller.updateDados(Req.Body<TJSONObject>, Req.Body<TJSONObject>.GetValue<integer>('id'), 'tab_contaspagar');
  Controller.Free;
end;

end.
