unit untCadastrarFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, System.Generics.Collections, BancoFuncoes, functions,
  System.JSON, System.StrUtils;

type
  TformCadastrarFuncionario = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel3: TPanel;
    btnSave: TPanel;
    btnCancel: TPanel;
    GroupBox2: TGroupBox;
    Panel5: TPanel;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    DateTimePicker7: TDateTimePicker;
    DateTimePicker8: TDateTimePicker;
    DateTimePicker9: TDateTimePicker;
    ComboBox3: TComboBox;
    Panel6: TPanel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    edtNome: TEdit;
    edtCPF: TEdit;
    edtTelefone: TEdit;
    edtEmail: TEdit;
    edtFuncao: TEdit;
    edtSalario: TEdit;
    dtpNascimento: TDateTimePicker;
    dtpAdmissao: TDateTimePicker;
    dtpDemissao: TDateTimePicker;
    cbxSexo: TComboBox;
    GroupBox3: TGroupBox;
    Panel4: TPanel;
    Label1: TLabel;
    edtDescricaoBeneficios: TEdit;
    Label2: TLabel;
    edtValorBeneficios: TEdit;
    sbxBeneficios: TScrollBox;
    Label3: TLabel;
    edtCEP: TEdit;
    Label4: TLabel;
    edtEndereco: TEdit;
    Label5: TLabel;
    edtNumero: TEdit;
    Label6: TLabel;
    edtBairro: TEdit;
    cbxEstado: TComboBox;
    Label8: TLabel;
    Label7: TLabel;
    edtComplemento: TEdit;
    Label9: TLabel;
    cbxCidade: TComboBox;
    cbxStatus: TComboBox;
    Label10: TLabel;
    btnAdicionarBeneficio: TSpeedButton;
    Label14: TLabel;
    edtNomeMae: TEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAdicionarBeneficioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCEPChange(Sender: TObject);
    procedure edtCEPKeyPress(Sender: TObject; var Key: Char);
    procedure edtCPFChange(Sender: TObject);
    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
    procedure edtTelefoneChange(Sender: TObject);
    procedure edtTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure edtSalarioChange(Sender: TObject);
    procedure cbxEstadoChange(Sender: TObject);
    procedure cbxCidadeChange(Sender: TObject);
    procedure edtValorBeneficiosChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxStatusChange(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure sbxBeneficiosMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure sbxBeneficiosMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    vJSArrayBeneficios: TJSONArray;
    vIdFuncionario, vIdEndereco, vCodigoCidade: Integer;

    procedure CarregarBeneficios(Count: Integer; strDescricao: string; Valor: Currency);
    procedure CarregarOrdemBeneficios;
    procedure CarregarUFs;
    procedure OnClickDeleteBeneficio(Sender: TObject);
  public
    procedure CarregarDados(vId: Integer);
  end;

var
  formCadastrarFuncionario: TformCadastrarFuncionario;

implementation

{$R *.dfm}

procedure TformCadastrarFuncionario.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TformCadastrarFuncionario.btnSaveClick(Sender: TObject);
var
  vDicDados: TDictionary<String, Variant>;
begin
  if not validaCPF(SisOnlyNumbers(Trim(edtCPF.Text))) then
  begin
    Application.MessageBox('CPF inválido!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  if vIdFuncionario = 0 then
    with BDBuscarRegistros('tab_funcionario', EmptyStr, EmptyStr, ' cpf = '+QuotedStr(Trim(edtCPF.Text)), EmptyStr, EmptyStr, -1, 'FDQBuscarCPFFuncionario') do
      if RecordCount > 0 then
      begin
        Application.MessageBox('O CPF informado já está cadastrado!', 'Atenção', MB_ICONWARNING);
        Exit;
      end;

  if (Trim(edtNome.Text) = EmptyStr) or (Trim(edtCPF.Text) = EmptyStr) or (Trim(edtTelefone.Text) = EmptyStr) or
  (Trim(edtFuncao.Text) = EmptyStr) or (Trim(edtSalario.Text) = EmptyStr) then
  begin
    Application.MessageBox('Preencha os campos pessoais!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  if (Trim(edtCEP.Text) = EmptyStr) or (Trim(edtEndereco.Text) = EmptyStr) or (Trim(edtNumero.Text) = EmptyStr) or
  (Trim(edtBairro.Text) = EmptyStr) or (Trim(cbxEstado.Text) = EmptyStr) or (Trim(cbxCidade.Text) = EmptyStr) then
  begin
    Application.MessageBox('Preencha os campos de endereço!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  vDicDados := TDictionary<String, Variant>.Create;
  with vDicDados do
  begin
    Add('nome', Trim(edtNome.Text));
    Add('cpf', Trim(edtCPF.Text));
    Add('dt_admissao', DateToStr(dtpAdmissao.Date));
    Add('dt_demissao', SisVarIf(cbxStatus.Text = 'Bloqueado', DateToStr(dtpDemissao.Date), Null));
    Add('funcao', Trim(edtFuncao.Text));
    Add('salario', StrToFloat(Trim(edtSalario.Text).Replace('.', '')));
    Add('telefone', Trim(edtTelefone.Text));
    Add('email', LowerCase(Trim(edtEmail.Text)));
    Add('dt_nascimento', DateToStr(dtpNascimento.Date));
    Add('sexo', cbxSexo.Text);
    Add('beneficios', vJSArrayBeneficios.ToJSON);
    Add('nome_mae', Trim(edtNomeMae.Text));
    Add('ativo', SisVarIf(cbxStatus.Text = 'Ativo', True, False));
  end;
  if vIdFuncionario = 0 then
    vIdFuncionario := BDInserirRegistros('tab_funcionario', 'id', 'tab_funcionarios_id_seq', vDicDados)
  else
    BDAtualizarRegistros('tab_funcionario', 'id = ' + vIdFuncionario.ToString, vDicDados);
  vDicDados.Clear;
  
  vDicDados := TDictionary<String, Variant>.Create;
  with vDicDados do
  begin
    Add('id_vinculado', vIdFuncionario);
    Add('logradouro', Trim(edtEndereco.Text));
    Add('numero', Trim(edtNumero.Text).ToInteger);
    Add('cep', Trim(edtCEP.Text));
    Add('bairro', Trim(edtBairro.Text));
    Add('id_cidade', vCodigoCidade);
    Add('cidade', Trim(cbxCidade.Text));
    Add('uf', Trim(cbxEstado.Text));
    Add('complemento', Trim(edtComplemento.Text));
  end;
  if vIdEndereco = 0 then
    vIdEndereco := BDInserirRegistros('tab_endereco', 'id', 'tab_endereco_id_seq', vDicDados)
  else
    BDAtualizarRegistros('tab_endereco', 'id = ' + vIdEndereco.ToString, vDicDados);

  Application.MessageBox('Dados incluidos com sucesso.', 'Confirmação', MB_ICONINFORMATION);
  Close;
end;

procedure TformCadastrarFuncionario.CarregarBeneficios(Count: Integer; strDescricao: string; Valor: Currency);
var
  GPName: string;
  PContainerName: string;
begin
  with TPanel.Create(Self) do
  begin
    Name := 'PContainer_' + Count.ToString;
    PContainerName := Name;
    Parent := sbxBeneficios;
    Align := alBottom;
    Align := alTop;
    Height := 50;
    BevelOuter := bvNone;
    Caption := EmptyStr;
  end;

  //Border
  with TPanel.Create(Self) do
  begin
    Parent := Self.FindComponent(PContainerName) as TPanel;
    Height := 1;
    Align := alTop;
    Color := $00CFCFCF;
  end;

  with TGridPanel.Create(Self) do
  begin
    ColumnCollection.Clear;
    RowCollection.Clear;
    RowCollection.Add;
    with ColumnCollection.Add do
    begin
      SizeStyle := ssPercent;
      Value := 35;
    end;
    with ColumnCollection.Add do
    begin
      SizeStyle := ssAbsolute;
      Value := 200;
    end;
    with ColumnCollection.Add do
    begin
      SizeStyle := ssPercent;
      Value := 65;
    end;
    with ColumnCollection.Add do
    begin
      SizeStyle := ssAbsolute;
      Value := 35;
    end;

    Parent := Self.FindComponent(PContainerName) as TPanel;
    Align := alClient;
    BevelOuter := bvNone;
    Name := 'GPBeneficios_' + Count.ToString;
    GPName := Name;
    Caption := EmptyStr;

    //count
    with TLabel.Create(Self) do
    begin
      Name := 'lblCount_' + Count.ToString;
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 15;
      Font.Style := [fsBold];
      Caption := Count.ToString;
    end;

    //descricão
    with TLabel.Create(Self) do
    begin
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 11;
      Font.Style := [fsBold];
      Caption := strDescricao;
      WordWrap := True;
    end;

    //valor
    with TLabel.Create(Self) do
    begin
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 9;
      Font.Style := [fsBold];
      Caption := FormatFloat('R$###,###,##0.00', Valor);
    end;

    //btnExcluir
    with TSpeedButton.Create(Self) do
    begin
      Name := 'btnExcluirBeneficio_' + Count.ToString;
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Width := 22;
      Height := 22;
      Flat := True;
      Glyph.LoadFromResourceName(HInstance, 'ICOTrash');
      OnClick := OnClickDeleteBeneficio;
    end;
  end;
end;

procedure TformCadastrarFuncionario.CarregarDados(vId: Integer);
var
  I, vCount: Integer;
  s: string;
begin
  with BDBuscarRegistros('tab_funcionario f', ' *, e.id idendereco ',
  ' left join tab_endereco e on e.id_vinculado = f.id ',
  ' f.id = ' + vId.ToString, EmptyStr, EmptyStr, -1, 'FDQBuscaDadosFuncionario') do
  begin
    vIdFuncionario := vId;
    edtNome.Text := FieldByName('nome').AsString;
    edtCPF.Text := FieldByName('cpf').AsString;
    edtTelefone.Text := FieldByName('telefone').AsString;
    dtpNascimento.Date := FieldByName('dt_nascimento').AsDateTime;
    edtFuncao.Text := FieldByName('funcao').AsString;
    edtSalario.Text := FormatFloat('###,###,##0.00', FieldByName('salario').AsCurrency);
    edtEmail.Text := FieldByName('email').AsString;
    edtNomeMae.Text := FieldByName('nome_mae').AsString;
    dtpAdmissao.Date := StrToDateDef(FieldByName('dt_admissao').AsString, StrToDate('01/01/2000'));
    dtpDemissao.Date := StrToDateDef(FieldByName('dt_demissao').AsString, StrToDate('01/01/2000'));
    cbxSexo.ItemIndex := cbxSexo.Items.IndexOf(FieldByName('sexo').AsString);
    cbxStatus.ItemIndex := SisVarIf(FieldByName('ativo').AsBoolean, 0, 1);
    vJSArrayBeneficios := TJSONObject.ParseJSONValue(FieldByName('beneficios').AsString) as TJSONArray;

    vCount := 1;
    for I := 0 to Pred(vJSArrayBeneficios.Count) do
    begin
      s := vJSArrayBeneficios.Get(I).GetValue<string>('description');
      CarregarBeneficios(vCount, vJSArrayBeneficios.Get(I).GetValue<string>('description'), vJSArrayBeneficios.Get(I).GetValue<Currency>('value'));
      Inc(vCount);
    end;

    //Endereço
    vIdEndereco := FieldByName('idendereco').AsInteger;
    vCodigoCidade := FieldByName('id_cidade').AsInteger;
    edtCEP.Text := FieldByName('cep').AsString;
    edtEndereco.Text := FieldByName('logradouro').AsString;
    edtNumero.Text := FieldByName('numero').AsString;
    edtBairro.Text := FieldByName('bairro').AsString;
    edtComplemento.Text := FieldByName('complemento').AsString;
    cbxEstado.ItemIndex := cbxEstado.Items.IndexOf(FieldByName('uf').AsString);
    cbxEstadoChange(Self);
    cbxCidade.ItemIndex := cbxCidade.Items.IndexOf(FieldByName('cidade').AsString);
  end;
end;

procedure TformCadastrarFuncionario.CarregarOrdemBeneficios;
var
  I, vCount: Integer;
  ComponentPanel: TPanel;
  ComponentGridPanel: TGridPanel;
  ComponentLabel: TLabel;
  ComponentButton: TSpeedButton;
begin
  vCount := 1;
  for I := 1 to sbxBeneficios.ControlCount + 1 do
  begin
    ComponentLabel := TLabel(Self.FindComponent('lblCount_'+I.ToString) as TLabel);
    ComponentPanel := TPanel(Self.FindComponent('PContainer_'+I.ToString) as TPanel);
    ComponentGridPanel := TGridPanel(Self.FindComponent('GPBeneficios_'+I.ToString) as TGridPanel);
    ComponentButton := TSpeedButton(Self.FindComponent('btnExcluirBeneficio_'+I.ToString) as TSpeedButton);

    if ComponentPanel <> nil then
    begin
      ComponentPanel.Name := Trim(ComponentPanel.Name).Replace(SisOnlyNumbers(ComponentPanel.Name), '') + vCount.ToString;
      ComponentGridPanel.Name := Trim(ComponentGridPanel.Name).Replace(SisOnlyNumbers(ComponentGridPanel.Name), '') + vCount.ToString;
      ComponentLabel.Name := Trim(ComponentLabel.Name).Replace(SisOnlyNumbers(ComponentLabel.Name), '') + vCount.ToString;
      ComponentButton.Name := Trim(ComponentButton.Name).Replace(SisOnlyNumbers(ComponentButton.Name), '') + vCount.ToString;

      ComponentLabel.Caption := vCount.ToString;
      Inc(vCount);
    end;
  end;
end;

procedure TformCadastrarFuncionario.CarregarUFs;
begin
  cbxEstado.Clear;
  with BDBuscarRegistros('tab_cidades', 'uf', EmptyStr, EmptyStr, 'uf', 'uf', -1, 'FDQBuscaUFs') do
    while not Eof do
    begin
      cbxEstado.Items.Add(FieldByName('uf').AsString);
      Next;
    end;
end;

procedure TformCadastrarFuncionario.cbxCidadeChange(Sender: TObject);
begin
  with BDBuscarRegistros('tab_cidades', 'id', EmptyStr, ' nome = ' + QuotedStr(cbxCidade.Text), EmptyStr, EmptyStr, -1, 'FDQBuscaIdCidade') do
    vCodigoCidade := FieldByName('id').AsInteger;
end;

procedure TformCadastrarFuncionario.cbxEstadoChange(Sender: TObject);
begin
  cbxCidade.Clear;
  with BDBuscarRegistros('tab_cidades', 'nome cidade', EmptyStr, ' uf = ' + QuotedStr(cbxEstado.Text), EmptyStr, 'nome', -1, 'FDQBuscaCidades') do
    while not Eof do
    begin
      cbxCidade.Items.Add(FieldByName('cidade').AsString);
      Next;
    end;
end;

procedure TformCadastrarFuncionario.cbxStatusChange(Sender: TObject);
begin
  if cbxStatus.Text = 'Ativo' then
    dtpDemissao.Enabled := False
  else
    dtpDemissao.Enabled := True;
end;

procedure TformCadastrarFuncionario.edtCEPChange(Sender: TObject);
begin
  SisFormatarEdit(edtCEP, tpFormatCep);
end;

procedure TformCadastrarFuncionario.edtCEPExit(Sender: TObject);
var
  vJSONInformacoesCEP: TJSONObject;
begin
  try
    if Length(edtCEP.Text) = 10 then
    begin
      vJSONInformacoesCEP := TJSONObject.Create;
      vJSONInformacoesCEP := TJSONObject.ParseJSONValue(SisBuscarCEP(edtCEP.Text)) as TJSONObject;

      edtEndereco.Text := UpperCase(vJSONInformacoesCEP.GetValue<string>('logradouro'));
      edtBairro.Text := UpperCase(vJSONInformacoesCEP.GetValue<string>('bairro'));
      cbxEstado.ItemIndex := cbxEstado.Items.IndexOf(vJSONInformacoesCEP.GetValue<string>('uf'));
      cbxEstadoChange(Self);
      cbxCidade.ItemIndex := cbxCidade.Items.IndexOf(UpperCase(vJSONInformacoesCEP.GetValue<string>('localidade')));
    end;
  except
    Application.MessageBox('CEP inválido!', 'Atenção', MB_ICONWARNING + MB_OK);
  end;
end;

procedure TformCadastrarFuncionario.edtCEPKeyPress(Sender: TObject; var Key: Char);
begin
  SisEditKeyPress(edtCEP, Key);
end;

procedure TformCadastrarFuncionario.edtCPFChange(Sender: TObject);
begin
  SisFormatarEdit(edtCPF, tpFormatCpfCnpj);
end;

procedure TformCadastrarFuncionario.edtCPFKeyPress(Sender: TObject;
  var Key: Char);
begin
  SisEditKeyPress(edtCPF, Key);
end;

procedure TformCadastrarFuncionario.edtSalarioChange(Sender: TObject);
begin
  SisEditFloatChange(edtSalario);
end;

procedure TformCadastrarFuncionario.edtTelefoneChange(Sender: TObject);
begin
  SisFormatarEdit(edtTelefone, tpFormatTelefone);
end;

procedure TformCadastrarFuncionario.edtTelefoneKeyPress(Sender: TObject;
  var Key: Char);
begin
  SisEditKeyPress(edtTelefone, Key);
end;

procedure TformCadastrarFuncionario.edtValorBeneficiosChange(Sender: TObject);
begin
  SisEditFloatChange(edtValorBeneficios);
end;

procedure TformCadastrarFuncionario.FormCreate(Sender: TObject);
begin
  dtpNascimento.Date := Now;
  dtpAdmissao.Date := Now;
  dtpDemissao.Date := Now;
  vJSArrayBeneficios := TJSONArray.Create;
  CarregarUFs;
end;

procedure TformCadastrarFuncionario.FormShow(Sender: TObject);
begin
  btnAdicionarBeneficio.Glyph.LoadFromResourceName(HInstance, 'ICOAdd');
  cbxStatusChange(Self);
end;

procedure TformCadastrarFuncionario.OnClickDeleteBeneficio(Sender: TObject);
var
  I: Integer;
  ComponentName, ReplaceText: string;
begin
  for I := 0 to Pred(sbxBeneficios.ControlCount) do
  begin
    ReplaceText := SisOnlyNumbers(sbxBeneficios.Controls[I].Name);
    ComponentName := StringReplace(sbxBeneficios.Controls[I].Name, ReplaceText, '', []);
    if sbxBeneficios.Controls[I].Name = ComponentName + SisOnlyNumbers(TSpeedButton(Sender).Name) then
    begin
      vJSArrayBeneficios.Remove(I);
      sbxBeneficios.Controls[I].Destroy;
      CarregarOrdemBeneficios;
      Break;
    end;
  end;
end;

procedure TformCadastrarFuncionario.sbxBeneficiosMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbxBeneficios.VertScrollBar.Position := sbxBeneficios.VertScrollBar.Position + 5;
end;

procedure TformCadastrarFuncionario.sbxBeneficiosMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbxBeneficios.VertScrollBar.Position := sbxBeneficios.VertScrollBar.Position - 5;
end;

procedure TformCadastrarFuncionario.btnAdicionarBeneficioClick(Sender: TObject);
var
  vJSObjBeneficios: TJSONObject;
begin
  if (Trim(edtDescricaoBeneficios.Text) = EmptyStr) or (Trim(edtValorBeneficios.Text) = EmptyStr) then
  begin
    Application.MessageBox('Preencha os campos para incluir o benefício!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  vJSObjBeneficios := TJSONObject.Create;
  vJSObjBeneficios.AddPair('description', Trim(edtDescricaoBeneficios.Text));
  vJSObjBeneficios.AddPair('value', TJSONNumber.Create(StrToFloat(Trim(edtValorBeneficios.Text).Replace('.', ''))));
  vJSArrayBeneficios.Add(vJSObjBeneficios);

  CarregarBeneficios(vJSArrayBeneficios.Count, vJSObjBeneficios.GetValue<string>('description'), vJSObjBeneficios.GetValue<Currency>('value'));

  edtDescricaoBeneficios.Text := EmptyStr;
  edtValorBeneficios.Text := EmptyStr;
end;

end.
