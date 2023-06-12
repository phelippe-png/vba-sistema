unit untPagamentosAnteriores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.WinXCalendars, Vcl.ExtCtrls, functions, BancoFuncoes,
  FireDAC.Comp.Client, System.DateUtils, Vcl.WinXPickers;

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
    btnSave: TPanel;
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
  ExibirObservacaoIndividual(mmObservacaoPagAnterior, vFDMObservacoesPagAnteriores, cvCalendarioPagAnterior);
end;

procedure TformPagamentosAnteriores.cvCalendarioPagAnteriorDrawDayItem(
  Sender: TObject; DrawParams: TDrawViewInfoParams;
  CalendarViewViewInfo: TCellItemViewInfo);
begin
  if vFDMObservacoesPagAnteriores.Locate('data', CalendarViewViewInfo.Date) then
    DrawParams.BkColor := $009FFF80;
end;

procedure TformPagamentosAnteriores.dbgPagamentosAnterioresCellClick(
  Column: TColumn);
begin
  mmObservacaoPagAnterior.Clear;

  with dbgPagamentosAnteriores.DataSource.DataSet do
  begin
    vFDMObservacoesPagAnteriores.Close;
    vFDMObservacoesPagAnteriores.Data := BDBuscarRegistros('tab_pontofuncionario', ' data, observacao ', EmptyStr,
    ' id_funcionario = '+IdFuncionario.ToString+
    ' and (extract(''month'' from data)||''/''||extract(''year'' from data)) = '+
    ' (extract(''month'' from '+QuotedStr(DateToStr(FieldByName('data_pagamento').AsDateTime))+'::date)||''/''||extract(''year'' from '+QuotedStr(DateToStr(FieldByName('data_pagamento').AsDateTime))+'::date)) ',
    EmptyStr, EmptyStr, -1, 'FDQBuscaObservacoesAnteriores');

    lblDataPagamento.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('data_pagamento').AsDateTime);
    lblFaltas.Caption := FieldByName('faltas').AsInteger.ToString;
    lblValorPago.Caption := FormatFloat('R$ ###,###,##0.00', FieldByName('valor_pago').AsFloat);
    lblStatus.Caption := FieldByName('status').AsString;
    cvCalendarioPagAnterior.Date := FieldByName('data_pagamento').AsDateTime;
  end;
end;

procedure TformPagamentosAnteriores.dtpFiltroAnoChange(Sender: TObject);
begin
  SQL;
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
  ' m.mes, ' +
  ' coalesce((select pg.valor_pago from tab_controlepagamento pg where extract(month from pg.data_pagamento)||''/''||extract(year from pg.data_pagamento) = ' +
  ' m.numero_mes||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and pg.id_funcionario = '+IdFuncionario.ToString+'), 0) valor_pago, ' +
  ' (select pg.data_pagamento from tab_controlepagamento pg where extract(month from pg.data_pagamento)||''/''||extract(year from pg.data_pagamento) = ' +
  ' m.numero_mes||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and pg.id_funcionario = '+IdFuncionario.ToString+'), ' +
  ' (extract(''day'' from (date_trunc(''month'',CURRENT_DATE)+interval ''1 month''-interval ''1 day'')::date) - ( ' +
  ' select count(p.id) from tab_pontofuncionario p where extract(month from p.data)||''/''||extract(year from p.data) = m.numero_mes||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and p.id_funcionario = '+IdFuncionario.ToString+
  ' )) faltas, ' +
  ' case when (select extract(month from pg.data_pagamento)||''/''||extract(year from pg.data_pagamento) from tab_controlepagamento pg ' +
  ' where extract(month from pg.data_pagamento)||''/''||extract(year from pg.data_pagamento) = m.numero_mes||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' and pg.id_funcionario = '+IdFuncionario.ToString+') = ' +
  ' m.numero_mes||''/''||'+YearOf(dtpFiltroAno.Date).ToString+' then ''PAGO'' else ''PAGAMENTO PENDENTE'' end::varchar status ',
  ' left join tab_funcionario f on f.id = '+IdFuncionario.ToString+' ' +
  ' left join tab_controlepagamento pag on pag.id_funcionario = f.id ',
  ' m.numero_mes < extract(month from now()) and f.ativo is true and ' +
  ' case when extract(year from f.dt_admissao) = '+YearOf(dtpFiltroAno.Date).ToString+' then m.numero_mes >= extract(month from f.dt_admissao) ' +
  ' when '+YearOf(dtpFiltroAno.Date).ToString+' < extract(year from f.dt_admissao) then 1=2 ' +
  ' when '+YearOf(dtpFiltroAno.Date).ToString+' > extract(year from now()) then 1=2 else 1=1 end and ' +
  ' case when extract(year from f.dt_demissao) = '+YearOf(dtpFiltroAno.Date).ToString+' and f.ativo is false then m.numero_mes <= extract(month from f.dt_demissao) else 1=1 end ',
  ' m.numero_mes, m.mes ', ' m.numero_mes ', -1, 'FDQBuscaPagamentosAnteriores');

  SISDBGridResizeColumns(dbgPagamentosAnteriores);
end;

procedure TformPagamentosAnteriores.ExibirObservacaoIndividual(Memo: TMemo; MemTable: TFDMemTable; Calendar: TCalendarView);
begin
  Memo.Clear;

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
