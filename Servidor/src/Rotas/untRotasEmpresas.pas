unit untRotasEmpresas;

interface

uses
  System.SysUtils, Horse, untController, System.JSON,
  DataSet.Serialize, System.Generics.Collections;

var
  Controller: TController;
  procedure Control(Horse: THorse);

  procedure getDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure getDadosPorFiltros(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure insertDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure deleteDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure updateDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure Control(Horse: THorse);
begin
  Horse.Get('/empresas', getDados);
  Horse.Post('/empresas', getDados);
  Horse.Post('/empresas/inserir', insertDados);
  Horse.Delete('/empresas/deletar/:id', deleteDados);
  Horse.Put('/empresas/atualizar/:id', updateDados);
end;

procedure getDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  tabelaBanco: string;
begin
  Controller := TController.Create;
  Res.Send<TJSONArray>(Controller.getDados('tab_empresas').ToJSONArray);
  Controller.Free;
end;

procedure getDadosPorFiltros(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  tabelaBanco: string;
begin
  Controller := TController.Create;
  Res.Send<TJSONArray>(Controller.getDados(req.Body).ToJSONArray);
  Controller.Free;
end;

procedure insertDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Controller := TController.Create;
  Controller.setDados(Req.Body<TJSONObject>, 'tab_empresas');
  Controller.Free;
  res.Send(res.Status.ToString);
end;

procedure deleteDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Controller := TController.Create;
  Controller.deletarDados(req.Params['id'].ToInteger, 'tab_empresas');
  Controller.Free;
end;

procedure updateDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Controller := TController.Create;
  Controller.updateDados(Req.Body<TJSONObject>, Req.Params['id'].ToInteger, 'tab_empresas');
  Controller.Free;
end;

end.
