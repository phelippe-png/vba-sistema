unit untCadastroPonto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, functions;

type
  TformCadastrarPonto = class(TForm)
    Timer: TTimer;
    lblTime: TLabel;
    Label1: TLabel;
    edtCPF: TEdit;
    Label2: TLabel;
    Panel1: TPanel;
    procedure TimerTimer(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCadastrarPonto: TformCadastrarPonto;

implementation

{$R *.dfm}

procedure TformCadastrarPonto.edtCPFChange(Sender: TObject);
begin
  SisFormatarEdit(edtCPF, tpFormatCpfCnpj);
end;

procedure TformCadastrarPonto.edtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  SisEditKeyPress(edtCPF, Key);
end;

procedure TformCadastrarPonto.TimerTimer(Sender: TObject);
begin
  lblTime.Caption := TimeToStr(Time);
end;

end.
