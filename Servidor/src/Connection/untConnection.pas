unit untConnection;

interface

uses
  System.Generics.Collections, System.SysUtils, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.PG, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.Phys.Intf,
  FireDAC.Stan.Pool, FireDAC.VCLUI.Wait, FireDAC.UI.Intf, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error;

type
  TConnection = class
  private
    FConnectionList: TObjectList<TFDConnection>;
    FIndexConnection: Integer;
  public
    property ConnectionList: TObjectList<TFDConnection> read FConnectionList write FConnectionList;
    function Connect: Integer;
    procedure Disconnect(index: Integer);
  end;

implementation

{ TConnection }

function TConnection.Connect: Integer;
begin
  if not Assigned(FConnectionList) then
    FConnectionList := TObjectList<TFDConnection>.Create;

  FConnectionList.Add(TFDConnection.Create(nil));
  FIndexConnection := Pred(FConnectionList.Count);

  FConnectionList.Items[FIndexConnection].Params.DriverID := 'PG';
  FConnectionList.Items[FIndexConnection].Params.Database := 'vba_db';
  FConnectionList.Items[FIndexConnection].Params.UserName := 'postgres';
  FConnectionList.Items[FIndexConnection].Params.Password := 'vba8312';
  FConnectionList.Items[FIndexConnection].Params.Add('server=localhost');
  FConnectionList.Items[FIndexConnection].Params.Add('port=5432');
  FConnectionList.Items[FIndexConnection].Connected;

  Result := FIndexConnection;
end;

procedure TConnection.Disconnect(index: Integer);
begin
  FConnectionList.Items[index].Connected := False;
  FConnectionList.Items[index].Free;
  FConnectionList.TrimExcess;
end;

end.
