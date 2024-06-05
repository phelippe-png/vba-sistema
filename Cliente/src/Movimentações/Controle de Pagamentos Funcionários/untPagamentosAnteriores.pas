unit untPagamentosAnteriores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.WinXCalendars, Vcl.ExtCtrls, functions, BancoFuncoes,
  FireDAC.Comp.Client, System.DateUtils, Vcl.WinXPickers, DM,
  untInformarValorPagar, System.Generics.Collections;

type
  TformPagamentosAnteriores = class(TForm)
    Panel1: TPanel;
    cvCalendarioPagAnterior: TCalendarView;
    dbgPagamentosAnteriores: TDBGrid;
    Label1: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblDataPagamento: TLabel;
    lblFaltas: TLabel;
    lblValorPago: TLabel;
    mmObservacaoPagAnterior: TMemo;
    Panel7: TPanel;
    btnConfirmarPagamento: TPanel;
    Label2: TLabel;
    lblStatus: TLabel;
    dtpFiltroAno: TDatePicker;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPagamentosAnterioresCellClick(Column: TColumn);
    procedure cvCalendarioPagAnteriorDrawDayItem(Sender: TObject;
      DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
    procedure cvCalendarioPagAnteriorChange(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure dtpFiltroAnoChange(Sender: TObject);
    procedure dbgPagamentosAnterioresDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnConfirmarPagamentoClick(Sender: TObject);
  private
    vFDMObservacoesPagAnteriores: TFDMemTable;

    procedure ConfigurarDataSet;
    procedure ExibirObservacaoIndividual(Memo: TMemo; MemTable: TFDMemTable; Calendar: TCalendarView);
    procedure ExibirObservacoesDetalhadas(Memo: TMemo; MemTable: TFDMemTable);
    procedure SQL;
  public
    IdFuncionario: Integer;
  end;

var
  formPagamentosAnteriores: TformPagamentosAnteriores;

implementation

{$R *.dfm}

procedure TformPagamentosAnteriores.btnConfirmarPagamentoClick(Sender: TObject);
var
  vNumeroMes: Integer;
  vDataOcorrencia: string;
  vDicDados: TDictionary<String, Variant>;
begin
  with TformInformarValorPagar.Create(Self) do
  begin
    vNumeroMes := dbgPagamentosAnteriores.DataSource.DataSet.FieldByName('numero_mes').AsInteger;
    lblFuncionario.Caption := 'Funcionário: '+BDBuscarRegistros('tab_funcionario', EmptyStr, EmptyStr, ' id = '+IdFuncionario.ToString).FieldByName('nome').AsString;
    lblMesAno.Caption := 'Data: '+SisVarIf(Length(vNumeroMes.ToString) = 1, '0'+vNumeroMes.ToString, vNumeroMes.ToString)+'/'+YearOf(dtpFiltroAno.Date).ToString;
    ShowModal;

    if Confirmar then
    begin
      vDataOcorrencia := SisVarIf(Length(vNumeroMes.ToString) = 1, '0'+vNumeroMes.ToString, vNumeroMes.ToString)+'/'+YearOf(dtpFiltroAno.Date).ToString;
      vDicDados := TDictionary<String, Variant>.Create;
      with vDicDados do
      begin
        Add('id_funcionario', IdFuncionario);
        Add('valor_pago', StrToFloat(Trim(edtValorPagar.Text).Replace('.', '')));
        Add('data_pagamento', Now);
        Add('data_ocorrencia', vDataOcorrencia);
      end;
      BDInserirRegistros('tab_controlepagamento', 'id', 'tab_controlepagamento_id_seq', vDicDados);

      SQL;
    end;
  end;
end;

procedure TformPagamentosAnteriores.ConfigurarDataSet;
begin
  with vFDMObservacoesPagAnteriores do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('observacao', ftString, 200);
    FieldDefs.Add('data', ftDate);
    CreateDataSet;
  end;
end;

procedure TformPagamentosAnteriores.cvCalendarioPagAnteriorChange(
  Sender: TObject);
begin
  mmObservacaoPagAnterior.Lines.Text := EmptyStr;
  with vFDMObservacoesPagAnteriores do
    if (Locate('data', SisTratarDate(DateToStr(cvCalendarioPagAnterior.Date)))) and (FieldByName('observacao').AsString <> EmptyStr) then
      ExibirObservacaoIndividual(mmObservacaoPagAnterior, vFDMObservacoesPagAnteriores, cvCalendarioPagAnterior);
end;

procedure TformPagamentosAnteriores.cvCalendarioPagAnteriorDrawDayItem(
  Sender: TObject; DrawParams: TDrawViewInfoParams;
  CalendarViewViewInfo: TCellItemViewInfo);
begin
  with vFDMObservacoesPagAnteriores do
    if (Locate('data', CalendarViewViewInfo.Date)) and (FieldByName('observacao').AsString <> EmptyStr) then
      DrawParams.BkColor := $009FFF80;
end;

procedure TformPagamentosAnteriores.dbgPagamentosAnterioresCellClick(Column: TColumn);
var
  vDate: TDateTime;
begin
  mmObservacaoPagAnterior.Lines.Text := EmptyStr;

  with dbgPagamentosAnteriores.DataSource.DataSet do
  begin
    vDate := StrToDate('01/'+FieldByName('numero_mes').AsInteger.ToString+'/'+YearOf(dtpFiltroAno.Date).ToString);

    vFDMObservacoesPagAnteriores.Close;
    vFDMObservacoesPagAnteriores.Data := BDBuscarRegistros('tab_pontofuncionario', ' data, observacao ', EmptyStr,
    ' id_funcionario = '+IdFuncionario.ToString+
    ' and (extract(''month'' from data)||''/''||extract(''year'' from data)) = '+
    ' (extract(''month'' from '+QuotedStr(DateToStr(vDate))+'::date)||''/''|| ' +
    ' extract(''year'' from '+QuotedStr(DateToStr(vDate))+'::date)) ',
    EmptyStr, EmptyStr, -1, 'FDQBuscaObservacoesAnteriores');

    lblDataPagamento.Caption := SisVarIf(SisTratarDate(FieldByName('data_pagamento').AsString) = StrToDate('01/01/2000'),
                                'NÃO DEFINIDO', FormatDateTime('dd/mm/yyyy', SisTratarDate(FieldByName('data_pagamento').AsString)));
    lblFaltas.Caption := FieldByName('faltas').AsInteger.ToString;
    lblValorPago.Caption := FormatFloat('R$ ###,###,##0.00', FieldByName('valor_pago').AsFloat);
    lblStatus.Caption := FieldByName('status').AsString;
    cvCalendarioPagAnterior.Date := vDate;

    if FieldByName('data_pagamento').AsString = 'NÃO DEFINIDO' then
    begin
      btnConfirmarPagamento.Enabled := True;
      btnConfirmarPagamento.Color := $0007780B;
    end else
    begin
      btnConfirmarPagamento.Enabled := False;
      btnConfirmarPagamento.Color := $00A2A2A2;
    end;
  end;
end;

procedure TformPagamentosAnteriores.dbgPagamentosAnterioresDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Column.FieldName = 'status' then
  begin
    dbgPagamentosAnteriores.Canvas.Font.Color := clWhite;
    dbgPagamentosAnteriores.Canvas.Font.Style := [fsBold];
    if dbgPagamentosAnteriores.DataSource.DataSet.FieldByName('status').AsString = 'PAGO' then
      dbgPagamentosAnteriores.Canvas.Brush.Color := clGreen;
    if dbgPagamentosAnteriores.DataSource.DataSet.FieldByName('status').AsString = 'PENDENTE' then
      dbgPagamentosAnteriores.Canvas.Brush.Color := $005959FF;
  end;

  dbgPagamentosAnteriores.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TformPagamentosAnteriores.dtpFiltroAnoChange(Sender: TObject);
begin
  vFDMObservacoesPagAnteriores.EmptyDataSet;
  mmObservacaoPagAnterior.Lines.Text := EmptyStr;
  lblDataPagamento.Caption := 'NÃO DEFINIDO';
  lblStatus.Caption := 'NÃO DEFINIDO';
  lblFaltas.Caption := 'NÃO DEFINIDO';
  lblValorPago.Caption := 'NÃO DEFINIDO';

  SQL;
  cvCalendarioPagAnterior.Refresh;
end;

procedure TformPagamentosAnteriores.FormCreate(Sender: TObject);
begin
  vFDMObservacoesPagAnteriores := TFDMemTable.Create(nil);
  dbgPagamentosAnteriores.DataSource := BDCriarOuRetornarDataSource('DSPagamentosAnteriores', Self);
end;

procedure TformPagamentosAnteriores.FormShow(Sender: TObject);
begin
  ConfigurarDataSet;
  SQL;
end;

procedure TformPagamentosAnteriores.Label8Click(Sender: TObject);
begin

  ExibirObservacoesDetalhadas(mmObservacaoPagAnterior, vFDMObservacoesPagAnteriores);
end;

procedure TformPagamentosAnteriores.SQL;
begin
  dbgPagamentosAnteriores.DataSource.DataSet := BDBuscarRegistros('tab_meses m',
  ' m.numero_mes, m.mes, ' +sLineBreak+
  ' coalesce((select pg.valor_pago from tab_controlepagamento pg where pg.data_ocorrencia = ' +sLineBreak+
  ' lpad(m.numero_mes::varchar, 2, ''0'')||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and pg.id_funcionario = '+IdFuncionario.ToString+'), 0) valor_pago, ' +sLineBreak+
  ' coalesce(to_char((select pg.data_pagamento from tab_controlepagamento pg where pg.data_ocorrencia = ' +sLineBreak+
  ' lpad(m.numero_mes::varchar, 2, ''0'')||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and pg.id_funcionario = '+IdFuncionario.ToString+'), ''dd/mm/yyyy''), ''NÃO DEFINIDO'')::varchar data_pagamento, ' +sLineBreak+
  ' (extract(''day'' from (date_trunc(''month'', (''01/''||lpad(m.numero_mes::varchar, 2, ''0'')||''/2000'')::date)+interval ''1 month''-interval ''1 day'')::date) - ( ' +sLineBreak+
  ' select count(p.id) from tab_pontofuncionario p where extract(month from p.data)||''/''||extract(year from p.data) = m.numero_mes||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and p.id_funcionario = '+IdFuncionario.ToString+sLineBreak+
  ' )) faltas, ' +sLineBreak+
  ' case when (select pg.data_ocorrencia from tab_controlepagamento pg ' +sLineBreak+
  ' where pg.data_ocorrencia = lpad(m.numero_mes::varchar, 2, ''0'')||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and pg.id_funcionario = '+IdFuncionario.ToString+') = ' +sLineBreak+
  ' lpad(m.numero_mes::varchar, 2, ''0'')||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' then ''PAGO'' else ''PENDENTE'' end::varchar status ',
  ' left join tab_funcionario f on f.id = '+IdFuncionario.ToString+' ' +sLineBreak+
  ' left join tab_controlepagamento pag on pag.id_funcionario = f.id ',
  ' case when '+YearOf(dtpFiltroAno.Date).ToString+' < extract(year from f.dt_admissao) then 1=2 else 1=1 end and ' +sLineBreak+
  ' case when '+YearOf(dtpFiltroAno.Date).ToString+' > extract(year from now()) then 1=2 else 1=1 end and ' +sLineBreak+
  ' case when extract(year from f.dt_admissao) = '+YearOf(dtpFiltroAno.Date).ToString+' then m.numero_mes >= extract(month from f.dt_admissao) else 1=1 end and ' +sLineBreak+
  ' case when '+YearOf(dtpFiltroAno.Date).ToString+' = extract(year from now()) then m.numero_mes < extract(month from now()) else 1=1 end ',
  ' m.numero_mes, m.mes ', ' m.numero_mes ', -1, 'FDQBuscaPagamentosAnteriores');

  TNumericField(dbgPagamentosAnteriores.DataSource.DataSet.FieldByName('valor_pago')).DisplayFormat := 'R$ ###,###,##0.00';
  BDCriarArquivoTexto('TESTE.txt', TFDQuery(SisDataModule.FindComponent('FDQBuscaPagamentosAnteriores')).SQL.Text+sLineBreak, False, 'C:\vba-sistema\Executaveis\');
  SISDBGridResizeColumns(dbgPagamentosAnteriores);
end;

procedure TformPagamentosAnteriores.ExibirObservacaoIndividual(Memo: TMemo; MemTable: TFDMemTable; Calendar: TCalendarView);
begin
  Memo.Lines.Text := EmptyStr;

  with MemTable do
    if (MonthOf(Calendar.Date) = MonthOf(FieldByName('data').AsDateTime)) and (Locate('data', Calendar.Date)) then
      Memo.Lines.Add('DATA: ' + FormatDateTime('dd/mm/yyyy', FieldByName('data').AsDateTime)+sLineBreak+
      '----------------------------'+sLineBreak+
      FieldByName('observacao').AsString);
end;

procedure TformPagamentosAnteriores.ExibirObservacoesDetalhadas(Memo: TMemo; MemTable: TFDMemTable);
var
  Count: Integer;
begin
  Memo.Lines.Text := EmptyStr;

  with MemTable do
  begin
    First;
    Count := 0;
    while not Eof do
    begin
      if FieldByName('observacao').AsString <> EmptyStr then
      begin
        Inc(Count);

        Memo.Lines.Add(Count.ToString + ' - DATA: ' + FormatDateTime('dd/mm/yyyy', FieldByName('data').AsDateTime)+sLineBreak+
        '--------------------------------'+sLineBreak+ FieldByName('observacao').AsString + sLineBreak+sLineBreak);
      end;

      Next;
    end;
  end;
end;

end.
