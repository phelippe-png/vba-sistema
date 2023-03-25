unit untPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, untControlePagamento;

type
  TformPagamentos = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    pnlSearch: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    dbgEmpresas: TDBGrid;
    Panel2: TPanel;
    procedure Panel2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPagamentos: TformPagamentos;

implementation

{$R *.dfm}

procedure TformPagamentos.Panel2Click(Sender: TObject);
begin
  with TformControlePagamentos.Create(Self) do
  begin
    ShowModal;
  end;
end;

end.
