program Atualizador;

uses
  Vcl.Forms,
  untMain in 'src\untMain.pas' {uSistemaPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TuSistemaPrincipal, uSistemaPrincipal);
  Application.Run;
end.
