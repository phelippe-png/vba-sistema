unit untControlePagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  functions, BancoFuncoes, untFuncionarios, System.JSON, Vcl.WinXCalendars,
  Vcl.ComCtrls, DateUtils, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.Client, untPagamentosAnteriores, System.Generics.Collections;

type
  TformControlePagamentos = class(TForm)
    pnlPrincipal: TPanel;
    pnlTitle: TPanel;
    lblFuncionario: TLabel;
    pnlContainer: TPanel;
    pnlLine: TPanel;
    btnConfirmarPagamento: TPanel;
    btnCancel: TPanel;
    cvCalendarioPagAtual: TCalendarView;
    mmObservacao: TMemo;
    Panel5: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    sbxBeneficios: TScrollBox;
    Label2: TLabel;
    Label7: TLabel;
    lblSalario: TLabel;
    btnPagamentosAnteriores: TPanel;
    lblDataOcorrencia: TLabel;
    btnAlterarSalario: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cvCalendarioPagAtualDrawDayItem(Sender: TObject;
      DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
    procedure cvCalendarioPagAtualChange(Sender: TObject);
    procedure btnPagamentosAnterioresClick(Sender: TObject);
    procedure btnConfirmarPagamentoClick(Sender: TObject);
    procedure btnAlterarSalarioClick(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure sbxBeneficiosMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure sbxBeneficiosMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    vFDMObservacoes: TFDMemTable;
    vValorPagar: Double;
    vStrListSQL: TStringList;
    vDicPagamento: TDictionary<String, Variant>;

    procedure CarregarBeneficios(Count: Integer; strDescricao: string; Valor: Currency);
    procedure LimparBeneficios;
    procedure ConfigurarDataSet;
    procedure BuscarInformacoesPagamento;
    procedure ExibirObservacaoIndividual(Memo: TMemo; MemTable: TFDMemTable; Calendar: TCalendarView);
    procedure ExibirObservacoesDetalhadas(Memo: TMemo; MemTable: TFDMemTable);
    procedure OnClickConfirmarSalario(Sender: TObject);
    procedure OnChangeEditSalario(Sender: TObject);
  public
    vIdFuncionario: Integer;
    vIsPago: Boolean;
  end;

var
  formControlePagamentos: TformControlePagamentos;

implementation

{$R *.dfm}

procedure TformControlePagamentos.btnAlterarSalarioClick(Sender: TObject);
begin
  lblSalario.Caption := 'Valor: ';
  btnAlterarSalario.Visible := False;

  with TEdit.Create(Self) do
  begin
    Name := 'edtSalario';
    Parent := pnlContainer;
    Text := FormatFloat('###,###,##0.00', vValorPagar);
    MaxLength := 13;
    Left := lblSalario.Left+lblSalario.Width+5;
    Top := lblSalario.Top;
    Font.Size := 10;
    Font.Name := 'Product Sans';
    OnChange := OnChangeEditSalario;
    SetFocus;
  end;

  with TSpeedButton.Create(Self) do
  begin
    Name := 'btnConfirmarSalario';
    Caption := 'Confirmar';
    Font.Size := 10;
    Font.Style := [fsBold];
    Font.Name := 'Product Sans';
    Parent := pnlContainer;
    Width := 70;
    Height := TEdit(Self.FindComponent('edtSalario')).Height;
    Left := TEdit(Self.FindComponent('edtSalario')).Left+TEdit(Self.FindComponent('edtSalario')).Width;
    Top := TEdit(Self.FindComponent('edtSalario')).Top;
    OnClick := OnClickConfirmarSalario;
  end;
end;

procedure TformControlePagamentos.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TformControlePagamentos.FormCreate(Sender: TObject);
begin
  vDicPagamento := TDictionary<String, Variant>.Create;
  vFDMObservacoes := TFDMemTable.Create(nil);

  ConfigurarDataSet;
end;

procedure TformControlePagamentos.FormShow(Sender: TObject);
begin
  BuscarInformacoesPagamento;
  cvCalendarioPagAtual.Date := Now;
  btnAlterarSalario.Left := lblSalario.Left+lblSalario.Width+5;
  btnConfirmarPagamento.Enabled := not vIsPago;
  btnAlterarSalario.Visible := not vIsPago;
  if not btnConfirmarPagamento.Enabled then
    btnConfirmarPagamento.Color := $00A2A2A2;
end;

procedure TformControlePagamentos.Label7Click(Sender: TObject);
begin
  ExibirObservacoesDetalhadas(mmObservacao, vFDMObservacoes);
end;

procedure TformControlePagamentos.LimparBeneficios;
var
  I: Integer;
begin
  for I := 0 to Pred(sbxBeneficios.ControlCount) do
    sbxBeneficios.Controls[I].Destroy;
end;

procedure TformControlePagamentos.OnChangeEditSalario(Sender: TObject);
begin
  SisEditFloatChange(TEdit(Sender));
end;

procedure TformControlePagamentos.OnClickConfirmarSalario(Sender: TObject);
begin
  lblSalario.Caption := SisVarIf(vIsPago, 'Valor pago confirmado: ', 'Valor a pagar: ')+FormatFloat('R$ ###,###,##0.00', Trim(TEdit(Self.FindComponent('edtSalario')).Text).Replace('.', '').ToDouble);
  vValorPagar := Trim(TEdit(Self.FindComponent('edtSalario')).Text).Replace('.', '').ToDouble;

  btnAlterarSalario.Visible := True;
  btnAlterarSalario.Left := lblSalario.Left+lblSalario.Width+5;
  TSpeedButton(Sender).Destroy;
  TEdit(TEdit(Self.FindComponent('edtSalario'))).Destroy;
end;

procedure TformControlePagamentos.sbxBeneficiosMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbxBeneficios.VertScrollBar.Position := sbxBeneficios.VertScrollBar.Position + 5;
end;

procedure TformControlePagamentos.sbxBeneficiosMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbxBeneficios.VertScrollBar.Position := sbxBeneficios.VertScrollBar.Position - 5;
end;

procedure TformControlePagamentos.btnPagamentosAnterioresClick(Sender: TObject);
begin
  with TformPagamentosAnteriores.Create(Self) do
  begin
    IdFuncionario := vIdFuncionario;
    ShowModal;
  end;
end;

procedure TformControlePagamentos.cvCalendarioPagAtualChange(Sender: TObject);
begin
  mmObservacao.Lines.Text := EmptyStr;
  with vFDMObservacoes do
    if (Locate('data', SisTratarDate(DateToStr(cvCalendarioPagAtual.Date)))) and (FieldByName('observacao').AsString <> EmptyStr) then
      ExibirObservacaoIndividual(mmObservacao, vFDMObservacoes, cvCalendarioPagAtual);
end;

procedure TformControlePagamentos.cvCalendarioPagAtualDrawDayItem(
  Sender: TObject; DrawParams: TDrawViewInfoParams;
  CalendarViewViewInfo: TCellItemViewInfo);
begin
  with vFDMObservacoes do
    if (Locate('data', CalendarViewViewInfo.Date)) and (FieldByName('observacao').AsString <> EmptyStr) then
      DrawParams.BkColor := $009FFF80;
end;

procedure TformControlePagamentos.btnConfirmarPagamentoClick(Sender: TObject);
var
  vDataOcorrencia: string;
begin
  if vValorPagar = 0 then
  begin
    Application.MessageBox('Não é possível confirmar o pagamento com o valor zerado!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  if Application.MessageBox('Deseja confirmar o pagamento do funcionário?', 'Confirmação', MB_ICONINFORMATION+MB_YESNO) = ID_NO then
    Exit;

  vDataOcorrencia := SisVarIf(Length(MonthOf(Now).ToString) = 1, '0'+MonthOf(Now).ToString, MonthOf(Now).ToString)+'/'+YearOf(Now).ToString;
  with vDicPagamento do
  begin
    Add('id_funcionario', vIdFuncionario);
    Add('valor_pago', vValorPagar);
    Add('data_pagamento', DateToStr(Now));
    Add('data_ocorrencia', vDataOcorrencia);
  end;

  BDInserirRegistros('tab_controlepagamento', ' id ', ' tab_controlepagamento_id_seq ', vDicPagamento);
  Application.MessageBox('Pagamento confirmado com sucesso.', 'Sucesso', MB_ICONINFORMATION);
  Close;
end;

procedure TformControlePagamentos.BuscarInformacoesPagamento;
var
  vArrayBeneficios: TJSONArray;
  I, Count: Integer;
begin
  with BDBuscarRegistros('tab_funcionario f', ' f.nome, f.salario, f.beneficios, p.valor_pago ',
  ' left join tab_controlepagamento p on p.id_funcionario = f.id and p.data_ocorrencia = lpad(extract(month from now())::varchar, 2, ''0'')||''/''||extract(year from now()) ',
  ' f.id =  ' + vIdFuncionario.ToString, EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionario') do
  begin
    lblFuncionario.Caption := 'Funcionário: ' + UpperCase(FieldByName('nome').AsString);
    lblSalario.Caption := SisVarIf(vIsPago, 'Valor pago confirmado: ', 'Valor a pagar: ')+
                          FormatFloat('R$ ###,###,##0.00', SisVarIf(vIsPago, FieldByName('valor_pago').AsFloat, FieldByName('salario').AsFloat));
    vValorPagar := FieldByName('salario').AsFloat;

    vArrayBeneficios := TJSONArray.Create;
    vArrayBeneficios := TJSONObject.ParseJSONValue(FieldByName('beneficios').AsString) as TJSONArray;
    for I := 0 to Pred(vArrayBeneficios.Count) do
    begin
      Inc(Count);
      CarregarBeneficios(Count, vArrayBeneficios.Get(I).GetValue<string>('description'), vArrayBeneficios.Get(I).GetValue<currency>('value'));
    end;
  end;

  with BDBuscarRegistros('tab_pontofuncionario p', ' data, observacao ', EmptyStr,
  ' id_funcionario = '+vIdFuncionario.ToString+' and (extract(''month'' from p.data)||''/''||extract(''year'' from p.data)) = (extract(''month'' from now())||''/''||extract(''year'' from now())) ',
  EmptyStr, ' data ', -1, 'FDQBuscaObservacoes') do
  begin
    while not Eof do
    begin
      vFDMObservacoes.Append;
      vFDMObservacoes.FieldByName('observacao').AsString := FieldByName('observacao').AsString;
      vFDMObservacoes.FieldByName('data').AsDateTime := FieldByName('data').AsDateTime;
      vFDMObservacoes.Post;
      Next;
    end;
  end;
end;

procedure TformControlePagamentos.CarregarBeneficios(Count: Integer; strDescricao: string; Valor: Currency);
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
    Align := alBottom;
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
      Font.Name := 'Product Sans';
    end;

    //descricão
    with TLabel.Create(Self) do
    begin
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 11;
      Font.Style := [fsBold];
      Caption := strDescricao;
      WordWrap := True;
      Font.Name := 'Product Sans';
    end;

    //valor
    with TLabel.Create(Self) do
    begin
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 9;
      Font.Style := [fsBold];
      Caption := FormatFloat('R$###,###,##0.00', Valor);
      Font.Name := 'Product Sans';
    end;
  end;
end;

procedure TformControlePagamentos.ConfigurarDataSet;
begin
  with vFDMObservacoes do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('observacao', ftString, 200);
    FieldDefs.Add('data', ftDate);
    CreateDataSet;
  end;
end;

procedure TformControlePagamentos.ExibirObservacaoIndividual(Memo: TMemo; MemTable: TFDMemTable; Calendar: TCalendarView);
begin
  Memo.Clear;

  with MemTable do
    if (MonthOf(Calendar.Date) = MonthOf(FieldByName('data').AsDateTime)) and (Locate('data', Calendar.Date)) then
      Memo.Lines.Add('DATA: ' + FormatDateTime('dd/mm/yyyy', FieldByName('data').AsDateTime)+sLineBreak+
      '----------------------------'+sLineBreak+
      FieldByName('observacao').AsString);
end;

procedure TformControlePagamentos.ExibirObservacoesDetalhadas(Memo: TMemo; MemTable: TFDMemTable);
var
  Count: Integer;
begin
  Memo.Clear;

  with MemTable do
  begin
    First;
    Count := 0;
    while not Eof do
    begin
      Inc(Count);
      Memo.Lines.Add(Count.ToString + ' - DATA: ' +
                            FormatDateTime('dd/mm/yyyy', FieldByName('data').AsDateTime)+sLineBreak+
                            '--------------------------------'+sLineBreak+
                            FieldByName('observacao').AsString + sLineBreak+sLineBreak);
      Next;
    end;
  end;
end;

end.
