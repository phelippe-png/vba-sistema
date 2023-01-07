unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid: TDBGrid;
    pnlSearch: TPanel;
    Label2: TLabel;
    Panel9: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    Panel10: TPanel;
    cbSearchType: TComboBox;
    Panel4: TPanel;
    btnEdit: TPanel;
    btnDelete: TPanel;
    btnAdd: TPanel;
    pnlExit: TPanel;
    btnExit: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
