unit untPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TformControlePagamentos = class(TForm)
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Panel4: TPanel;
    btnSave: TPanel;
    btnCancel: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formControlePagamentos: TformControlePagamentos;

implementation

{$R *.dfm}

end.
