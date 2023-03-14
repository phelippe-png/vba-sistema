unit untCadastrarContaPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TformCadastrarConta = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    edDescricao: TEdit;
    edDataEnt: TDateTimePicker;
    edValorTotal: TEdit;
    Panel3: TPanel;
    btnSave: TPanel;
    btnCancel: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCadastrarConta: TformCadastrarConta;

implementation

{$R *.dfm}

end.
