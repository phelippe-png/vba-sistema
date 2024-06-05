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
    edtCPF: TEdit;
    btnConfirmar: TPanel;
    btnObservacoes: TPanel;
    lblAviso: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure edtCPFChange(Sender: TObject);
    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure edtCPFKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnObservacoesClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    procedure ExibirMensagemAviso(Msg: string; DeuCerto: Boolean);
  public
    { Public declarations }
  end;

var
  formCadastrarPonto: TformCadastrarPonto;

implementation

{$R *.dfm}

procedure TformCadastrarPonto.btnConfirmarClick(Sender: TObject);
var
  vDicDados: TDictionary<String, Variant>;
  vIdFuncionario: Integer;
  vStrFieldName, vStrNomeFuncionario: string;
begin
  if (not validaCPF(SisOnlyNumbers(Trim(edtCPF.Text)))) then
  begin
    ExibirMensagemAviso('CPF inválido!', False);
    Exit;
  end;

  with BDBuscarRegistros('tab_funcionario', EmptyStr, EmptyStr, ' cpf = ' + QuotedStr(Trim(edtCPF.Text)), EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionario') do
  begin
    if RecordCount = 0 then
    begin
      ExibirMensagemAviso('Funcionário não encontrado!', False);
      Exit;
    end;

    vStrNomeFuncionario := FieldByName('nome').AsString;
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
        ExibirMensagemAviso('Funcionário: '+vStrNomeFuncionario+sLineBreak+
                            'Ponto registrado com sucesso.', True);
      end else
        if FieldByName(vStrFieldName).AsString <> EmptyStr then
          ExibirMensagemAviso('Funcionário: '+vStrNomeFuncionario+sLineBreak+
                              'Ponto já registrado no horário atual!', False)
        else
        begin
          BDAtualizarRegistros('tab_pontofuncionario', ' id = ' + FieldByName('id').AsInteger.ToString, vDicDados);
          ExibirMensagemAviso('Funcionário: '+vStrNomeFuncionario+sLineBreak+
                              'Ponto registrado com sucesso.', True);
        end;
  end;

  edtCPF.Text := EmptyStr;
end;

procedure TformCadastrarPonto.btnObservacoesClick(Sender: TObject);
begin
  with TformObservacoesDias.Create(Self) do
    ShowModal;
end;

procedure TformCadastrarPonto.edtCPFChange(Sender: TObject);
begin
  SisFormatarEdit(edtCPF, tpFormatCpfCnpj);
end;

procedure TformCadastrarPonto.edtCPFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnConfirmarClick(Self);
end;

procedure TformCadastrarPonto.edtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  SisEditKeyPress(edtCPF, Key);

  if Key in ['1'..'9'] then
    lblAviso.Caption := EmptyStr;
end;

procedure TformCadastrarPonto.ExibirMensagemAviso(Msg: string; DeuCerto: Boolean);
begin
  if DeuCerto then
  begin
    lblAviso.Caption := Msg;
    lblAviso.Font.Color := $00238A00;
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

procedure TformCadastrarPonto.TimerTimer(Sender: TObject);
begin
  lblTime.Caption := TimeToStr(Time);
end;

end.
