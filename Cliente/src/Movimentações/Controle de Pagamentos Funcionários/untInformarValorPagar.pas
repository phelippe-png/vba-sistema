unit untInformarValorPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, functions;

type
  TformInformarValorPagar = class(TForm)
    lblFuncionario: TLabel;
    lblMesAno: TLabel;
    btnCancel: TPanel;
    btnConfirmar: TPanel;
    edtValorPagar: TEdit;
    Label1: TLabel;
    procedure edtValorPagarChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    Confirmar: Boolean;
  end;

var
  formInformarValorPagar: TformInformarValorPagar;

implementation

{$R *.dfm}

procedure TformInformarValorPagar.btnCancelClick(Sender: TObject);
begin
  Confirmar := False;
  Close;
end;

procedure TformInformarValorPagar.btnConfirmarClick(Sender: TObject);
begin
  if StrToFloat(Trim(edtValorPagar.Text).Replace('.', '')) = 0.00 then
  begin
    Application.MessageBox('Informe um valor maior que zero!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  Confirmar := Application.MessageBox('Deseja realmente confirmar o pagamento do funcionário?', 'Atenção', MB_ICONQUESTION+MB_YESNO) = ID_YES;
  Close;
end;

procedure TformInformarValorPagar.edtValorPagarChange(Sender: TObject);
begin
  SisEditFloatChange(edtValorPagar);
end;

end.
