unit relatorioPontoFuncionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, RLFilters, RLPDFFilter,
  Data.DB, functions, BancoFuncoes;

type
  TformRelatPontoFuncionarios = class(TForm)
    DataSource: TDataSource;
    RLPDFFilter: TRLPDFFilter;
    RLReport: TRLReport;
    RLBand1: TRLBand;
    rllTitle: TRLLabel;
    RLImage1: TRLImage;
    RLLabel9: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLPanel6: TRLPanel;
    RLPanel7: TRLPanel;
    RLPanel8: TRLPanel;
    RLPanel9: TRLPanel;
    RLPanel10: TRLPanel;
    RLPanel11: TRLPanel;
    RLPanel12: TRLPanel;
    RLLabel14: TRLLabel;
    RLPanel13: TRLPanel;
    RLLabel15: TRLLabel;
    RLPanel14: TRLPanel;
    RLLabel12: TRLLabel;
    RLPanel18: TRLPanel;
    RLPanel19: TRLPanel;
    RLBand4: TRLBand;
    RLPanel21: TRLPanel;
    RLLabel16: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel17: TRLLabel;
    RLDBText4: TRLDBText;
    RLPanel22: TRLPanel;
    RLPanel23: TRLPanel;
    RLLabel18: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel19: TRLLabel;
    RLDBText6: TRLDBText;
    RLPanel24: TRLPanel;
    RLLabel20: TRLLabel;
    RLDBText7: TRLDBText;
    RLPanel25: TRLPanel;
    RLPanel26: TRLPanel;
    RLLabel21: TRLLabel;
    RLDBText8: TRLDBText;
    RLPanel27: TRLPanel;
    RLLabel22: TRLLabel;
    RLDBText9: TRLDBText;
    RLPanel28: TRLPanel;
    RLLabel23: TRLLabel;
    RLDBText10: TRLDBText;
    RLLabel24: TRLLabel;
    RLDBText11: TRLDBText;
    RLPanel29: TRLPanel;
    RLPanel30: TRLPanel;
    RLLabel25: TRLLabel;
    RLDBText12: TRLDBText;
    RLLabel26: TRLLabel;
    RLPanel31: TRLPanel;
    RLLabel27: TRLLabel;
    DataSource2: TDataSource;
    RLGroup1: TRLGroup;
    RLBand3: TRLBand;
    rldbDia: TRLDBText;
    rldbHoraEntrada: TRLDBText;
    rldbHoraSaidaAlmoco: TRLDBText;
    rldbHoraEntradaAlmoco: TRLDBText;
    rldbHoraSaida: TRLDBText;
    RLPanel1: TRLPanel;
    RLPanel2: TRLPanel;
    RLPanel3: TRLPanel;
    RLPanel4: TRLPanel;
    RLPanel5: TRLPanel;
    RLPanel15: TRLPanel;
    RLPanel16: TRLPanel;
    RLPanel17: TRLPanel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLPanel20: TRLPanel;
    RLBand5: TRLBand;
    RLLabel28: TRLLabel;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLLabel29: TRLLabel;
    RLDBText17: TRLDBText;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    procedure RLReportDataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
  private
    { Private declarations }
  public
    procedure imprimirRelatorio(Mes, Ano, IdFuncionario: Integer);
  end;

var
  formRelatPontoFuncionarios: TformRelatPontoFuncionarios;

implementation

{$R *.dfm}

{ TForm1 }

procedure TformRelatPontoFuncionarios.imprimirRelatorio(Mes, Ano, IdFuncionario: Integer);
begin
  DataSource.DataSet := BDBuscarRegistros(
  ' ( ' +
    ' select lpad(d.dia::varchar, 2, ''0'') ||''/''||lpad(m.numero_mes::varchar, 2, ''0'') dia_mes, d.dia, m.numero_mes, m.mes, ' +
    ' f.nome funcionario, f.cpf, to_char(f.dt_admissao, ''dd/mm/yyyy'') dt_admissao, f.funcao, f.email, f.telefone, ' +
    ' to_char(f.dt_nascimento, ''dd/mm/yyyy'') dt_nascimento, upper(f.sexo) sexo ' +
    ' from tab_meses m ' +
    ' left join tab_dias d on d.dia in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31) ' +
    ' left join tab_funcionario f on f.id = '+IdFuncionario.ToString+
  ' ) ponto_funcionarios  ',
  ' dia, numero_mes, p.hora_entrada, p.hora_saida_almoco, p.hora_entrada_almoco, p.hora_saida, p.observacao, ' +
  ' (((''24:00:00''::time - p.hora_entrada) - p.hora_saida_almoco) + ((''24:00:00''::time - p.hora_entrada_almoco) - (''24:00:00''::time - p.hora_saida)))::varchar total_horas, ' +
  ' (((''24:00:00''::time - p.hora_entrada) - p.hora_saida_almoco) + ((''24:00:00''::time - p.hora_entrada_almoco) - (''24:00:00''::time - p.hora_saida)) - ''08:00:00''::time)::varchar hora_extra, ' +
  ' funcionario, cpf, dt_admissao, funcao, email, telefone, dt_nascimento, sexo, mes, '+Ano.ToString+' ano ',
  ' left join tab_pontofuncionario p on ' +
  ' lpad(extract(day from p.data)::varchar, 2, ''0'')||''/''||lpad(extract(month from p.data)::varchar, 2, ''0'') = dia_mes ' +
  ' and p.id_funcionario = '+IdFuncionario.ToString+' and extract(year from p.data) = '+Ano.ToString,
  SisVarIf(Mes <> 0, ' numero_mes = '+Mes.ToString, EmptyStr), EmptyStr, ' numero_mes, dia ', -1, 'FDQBuscarPontoFuncionario');

  DataSource2.DataSet := BDBuscarRegistros(' ( ' +
    ' select lpad(d.dia::varchar, 2, ''0'') ||''/''||lpad(m.numero_mes::varchar, 2, ''0'') dia_mes, d.dia, m.numero_mes, m.mes ' +
    ' from tab_meses m ' +
    ' left join tab_dias d on d.dia in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31) ' +
  ' ) ponto_funcionarios ',
  ' numero_mes, ' +
  ' sum(((''24:00:00''::time - p.hora_entrada) - p.hora_saida_almoco) + ((''24:00:00''::time - p.hora_entrada_almoco) - (''24:00:00''::time - p.hora_saida)))::varchar horas_totais, ' +
  ' sum(((''24:00:00''::time - p.hora_entrada) - p.hora_saida_almoco) + ((''24:00:00''::time - p.hora_entrada_almoco) - (''24:00:00''::time - p.hora_saida)) - ''08:00:00''::time)::varchar extras_totais, ' +
  ' extract(''day'' from (date_trunc(''month'', (''01/''||lpad(numero_mes::varchar, 2, ''0'')||''/2000'')::date)+interval ''1 month''-interval ''1 day'')::date) - count(p.*) faltas ',
  ' left join tab_pontofuncionario p on lpad(extract(day from p.data)::varchar, 2, ''0'')||''/''||lpad(extract(month from p.data)::varchar, 2, ''0'') = dia_mes ' +
  ' and p.id_funcionario = '+IdFuncionario.ToString+' and extract(year from p.data) = '+Ano.ToString,
  SisVarIf(Mes <> 0, ' numero_mes = '+Mes.ToString, EmptyStr), ' numero_mes ', ' numero_mes ', -1 ,'FDQBuscarTotais');

  RLReport.Preview;
end;

procedure TformRelatPontoFuncionarios.RLReportDataRecord(Sender: TObject; RecNo, CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  DataSource2.DataSet.Locate('numero_mes', DataSource.DataSet.FieldByName('numero_mes').AsInteger - 1, []);
end;

end.
