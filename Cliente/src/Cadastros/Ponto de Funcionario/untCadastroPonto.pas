unit untCadastroPonto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, functions,
  Vcl.Buttons, BancoFuncoes, System.Generics.Collections;

type
  TformCadastrarPonto = class(TForm)
    Timer: TTimer;
    lblTime: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    btnObservacoes: TSpeedButton;
    Label3: TLabel;
    edtCPF: TEdit;
    SpeedButton1: TSpeedButton;
    procedure TimerTimer(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
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

procedure TformCadastrarPonto.FormCreate(Sender: TObject);
begin
  lblTime.Caption := TimeToStr(Time);
end;

procedure TformCadastrarPonto.Panel1Click(Sender: TObject);
begin
  Close;
end;

procedure TformCadastrarPonto.SpeedButton1Click(Sender: TObject);
var
  vDicDados: TDictionary<String, Variant>;
begin
//  id
//id_funcionario
//hora_entrada
//hora_saida_almoco
//hora_entrada_almoco
//hora_saida
//data
//observacao

  if ((TimeToStr(Time) < '06:50:00') or (TimeToStr(Time) > '07:05:00')) or
  ((TimeToStr(Time) < '10:55:00') or (TimeToStr(Time) > '11:10:00')) or
  ((TimeToStr(Time) < '06:50:00') or (TimeToStr(Time) > '07:05:00')) or
  ((TimeToStr(Time) < '06:50:00') or (TimeToStr(Time) > '07:05:00')) then

  if (not validaCPF(Trim(edtCPF.Text))) then
  begin
    Application.MessageBox('CPF inválido!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  with BDBuscarRegistros('tab_funcionario', ' id ', EmptyStr, ' cpf = ' + QuotedStr(Trim(edtCPF.Text)), EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionario') do
  begin
    if RecordCount = 0 then
    begin
      Application.MessageBox('Funcionário não encontrado!', 'Atenção', MB_ICONWARNING);
      Exit;
    end;

    vDicDados := TDictionary<String, Variant>.Create;
    try
      vDicDados.Add('id_funcionario', FieldByName('id').AsInteger);
      if (TimeToStr(Time) = '06:50:00') or (TimeToStr(Time) = '07:05:00') then

    finally
      vDicDados := nil;
    end;
  end;
end;

procedure TformCadastrarPonto.TimerTimer(Sender: TObject);
begin
  lblTime.Caption := TimeToStr(Time);
end;

end.
