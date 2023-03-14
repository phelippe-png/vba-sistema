unit untModalValorPago;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  functions;

type
  TformModal = class(TForm)
    Label1: TLabel;
    edValor: TEdit;
    btnCancel: TPanel;
    btnInsert: TPanel;
    Label2: TLabel;
    lblValorTotal: TLabel;
    Label4: TLabel;
    lblValorPago: TLabel;
    Label6: TLabel;
    lblTotalPagar: TLabel;
    procedure btnCancelMouseEnter(Sender: TObject);
    procedure btnCancelMouseLeave(Sender: TObject);
    procedure btnInsertMouseEnter(Sender: TObject);
    procedure btnInsertMouseLeave(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edValorChange(Sender: TObject);
  private
    FvalorPago: Currency;
    FtotalPagar: Currency;
    FvalorTotal: Currency;
  public
    lib: boolean;
    property valorTotal: Currency read FvalorTotal write FvalorTotal;
    property valorPago: Currency read FvalorPago write FvalorPago;
    property totalPagar: Currency read FtotalPagar write FtotalPagar;

    procedure exibirValores;
  end;

var
  formModal: TformModal;

implementation

{$R *.dfm}

procedure TformModal.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformModal.btnCancelMouseEnter(Sender: TObject);
begin
  btnCancel.Color := clBlack;
end;

procedure TformModal.btnCancelMouseLeave(Sender: TObject);
begin
  btnCancel.Color := clMaroon;
end;

procedure TformModal.btnInsertClick(Sender: TObject);
var
  valor: currency;
begin
  valor := StrToCurr(Trim(edValor.Text).Replace('.', ''));

  if valor <= 0.00 then
  begin
    Application.MessageBox('Informe um valor maior que R$0,00!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if valor > totalPagar then
  begin
    Application.MessageBox('Valor informado maior que o total a pagar!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  lib := true;
  Self.Close;
end;

procedure TformModal.btnInsertMouseEnter(Sender: TObject);
begin
  btnInsert.Color := clBlack;
end;

procedure TformModal.btnInsertMouseLeave(Sender: TObject);
begin
  btnInsert.Color := clGreen;
end;

procedure TformModal.edValorChange(Sender: TObject);
begin
  SisEditFloatChange(edValor);
end;

procedure TformModal.exibirValores;
begin
  lblValorTotal.Caption := FormatCurr('R$ ###,###,##0.00', FvalorTotal);
  lblValorPago.Caption := FormatCurr('R$ ###,###,##0.00', FvalorPago);
  lblTotalPagar.Caption := FormatCurr('R$ ###,###,##0.00', FtotalPagar);
end;

procedure TformModal.FormShow(Sender: TObject);
begin
  exibirValores;
end;

end.
