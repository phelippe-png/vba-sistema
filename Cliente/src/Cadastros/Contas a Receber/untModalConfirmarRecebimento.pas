unit untModalConfirmarRecebimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  functions, System.JSON, untClasseContasReceber;

type
  TformConfirmarRecebimento = class(TForm)
    edDataRecebimento: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    lblValorReceber: TLabel;
    btnInsert: TPanel;
    btnCancel: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
  private
    classeContasReceber: TContasReceber;
    FidContaReceber: integer;
  public
    property idContaReceber: integer read FidContaReceber write FidContaReceber;
  end;

var
  formConfirmarRecebimento: TformConfirmarRecebimento;

implementation

{$R *.dfm}

procedure TformConfirmarRecebimento.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformConfirmarRecebimento.btnInsertClick(Sender: TObject);
var
  stream: TStream;
  jsonRequest: TJSONObject;
begin
  if edDataRecebimento.Date > now then
  begin
    Application.MessageBox('Data de recebimento maior que a data atual!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if Application.MessageBox('Deseja confirmar o recebimento de conta?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
    exit;

  try
    classeContasReceber := TContasReceber.Create;
    classeContasReceber.idContaReceber := idContaReceber;
    classeContasReceber.dataRecebimento := edDataRecebimento.Date;
    classeContasReceber.confirmarRecebimento;

    Application.MessageBox('Recebimento confirmado com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);
    self.Close;
  except
    Application.MessageBox('Erro ao confirmar recebimento!', 'Erro', MB_ICONERROR + MB_OK);
  end;
end;

end.
