program APIHorse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  untConnection in 'src\Connection\untConnection.pas',
  untController in 'src\Controller\untController.pas',
  untRotas in 'src\Rotas\untRotas.pas';

var
  System: THorse;

begin
  System := THorse.Create;
  System.Use(Jhonson);

  untRotas.Control(System);

  System.Listen(9000);
end.
