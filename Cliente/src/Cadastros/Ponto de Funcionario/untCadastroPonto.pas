unit untCadastroPonto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, functions,
  Vcl.Buttons, BancoFuncoes, System.Generics.Collections, untObservacoesDias;

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
    btnInserir: TSpeedButton;
    lblAviso: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure btnObservacoesClick(Sender: TObject);
    procedure edtCPFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    procedure ExibirMensagemAviso(Msg: string; DeuCerto: Boolean);
  public
    { Public declarations }
  end;

var
  formCadastrarPonto: TformCadastrarPonto;

implementation

{$R *.dfm}

procedure TformCadastrarPonto.btnObservacoesClick(Sender: TObject);
begin
  with TformObservacoesDias.Create(Self) do
    ShowModal;
end;

procedure TformCadastrarPonto.edtCPFChange(Sender: TObject);
begin
  lblAviso.Caption := EmptyStr;
  SisFormatarEdit(edtCPF, tpFormatCpfCnpj);
end;

procedure TformCadastrarPonto.edtCPFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnInserirClick(Self);
end;

procedure TformCadastrarPonto.edtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  SisEditKeyPress(edtCPF, Key);
end;

procedure TformCadastrarPonto.ExibirMensagemAviso(Msg: string; DeuCerto: Boolean);
begin
  if DeuCerto then
  begin
    lblAviso.Caption := Msg;
    lblAviso.Font.Color := $002BAA00;
  end else
  begin
    lblAviso.Caption := Msg;
    lblAviso.Font.Color := clMaroon;
  end;
end;

procedure TformCadastrarPonto.FormCreate(Sender: TObject);
begin
  lblTime.Caption := TimeToStr(Time);
end;

procedure TformCadastrarPonto.FormShow(Sender: TObject);
begin
  edtCPF.SetFocus;
end;

procedure TformCadastrarPonto.Panel1Click(Sender: TObject);
begin
  Close;
end;

procedure TformCadastrarPonto.btnInserirClick(Sender: TObject);
var
  vDicDados: TDictionary<String, Variant>;
  vIdFuncionario: Integer;
  vStrFieldName: string;
begin
  if (not validaCPF(SisOnlyNumbers(Trim(edtCPF.Text)))) then
  begin
    ExibirMensagemAviso('CPF inválido!', False);
    Exit;
  end;

  with BDBuscarRegistros('tab_funcionario', ' id ', EmptyStr, ' cpf = ' + QuotedStr(Trim(edtCPF.Text)), EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionario') do
  begin
    if RecordCount = 0 then
    begin
      ExibirMensagemAviso('Funcionário não encontrado!', False);
      Exit;
    end;

    vIdFuncionario := FieldByName('id').AsInteger;
    vDicDados := TDictionary<String, Variant>.Create;

    if TimeToStr(Time) < '11:50:00' then
    begin
      vDicDados.Add('hora_entrada', TimeToStr(Time));
      vStrFieldName := 'hora_entrada';
    end
    else if (TimeToStr(Time) >= '11:50:00') and (TimeToStr(Time) <= '12:15:00') then
    begin
      vDicDados.Add('hora_saida_almoco', TimeToStr(Time));
      vStrFieldName := 'hora_saida_almoco';
    end
    else if (TimeToStr(Time) > '12:15:00') and (TimeToStr(Time) < '13:50:00') then
    begin
      ExibirMensagemAviso('Empresa em horário de almoço!', False);
      Exit;
    end
    else if (TimeToStr(Time) >= '13:50:00') and (TimeToStr(Time) < '14:15:00') then
    begin
      vDicDados.Add('hora_entrada_almoco', TimeToStr(Time));
      vStrFieldName := 'hora_entrada_almoco';
    end
    else if (TimeToStr(Time) >= '14:15:00') then
    begin
      vDicDados.Add('hora_saida', TimeToStr(Time));
      vStrFieldName := 'hora_saida';
    end;

    vDicDados.Add('id_funcionario', vIdFuncionario);
    vDicDados.Add('data', DateToStr(Now));
    with BDBuscarRegistros('tab_pontofuncionario', EmptyStr, EmptyStr,
    ' data = ' + QuotedStr(DateToStr(Now)) + ' and id_funcionario = ' + vIdFuncionario.ToString,
    EmptyStr, EmptyStr, -1, 'FDQBuscaPonto') do
      if RecordCount = 0 then
      begin
        BDInserirRegistros('tab_pontofuncionario', 'id', 'tab_pontofuncionario_id_seq', vDicDados);
        ExibirMensagemAviso('Ponto registrado com sucesso.', True);
      end
      else
      begin
        if FieldByName(vStrFieldName).AsString <> EmptyStr then
          ExibirMensagemAviso('Ponto já registrado no horário atual!', False)
        else
        begin
          BDAtualizarRegistros('tab_pontofuncionario', ' id = ' + FieldByName('id').AsInteger.ToString, vDicDados);
          ExibirMensagemAviso('Ponto registrado com sucesso.', True);
        end;
      end;
  end;

  edtCPF.Clear;
end;

procedure TformCadastrarPonto.TimerTimer(Sender: TObject);
begin
  lblTime.Caption := TimeToStr(Time);
end;

end.
