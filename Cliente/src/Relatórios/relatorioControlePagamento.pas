unit relatorioControlePagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, RLFilters,
  RLPDFFilter, functions, BancoFuncoes;

type
  TformRelatorioControlePagamento = class(TForm)
    RLBand1: TRLBand;
    rllTitle: TRLLabel;
    RLImage1: TRLImage;
    RLLabel9: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand7: TRLBand;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLLabel16: TRLLabel;
    RLPDFFilter: TRLPDFFilter;
    DataSource: TDataSource;
    RLBand2: TRLBand;
    RLLabel1: TRLLabel;
    rldbFuncionario: TRLDBText;
    RLBand4: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel2: TRLLabel;
    RLPanel2: TRLPanel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel12: TRLLabel;
    rldbCPF: TRLDBText;
    rldbFuncao: TRLDBText;
    rldbTelefone: TRLDBText;
    rldbEmail: TRLDBText;
    rldbDataNasc: TRLDBText;
    rldbSalario: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel17: TRLLabel;
    rldbDataPagamento: TRLDBText;
    rldbFaltas: TRLDBText;
    rldbValorPago: TRLDBText;
    RLReport: TRLReport;
  private

  public
    procedure imprimirRelatorio(stCondicoes: string);
  end;

var
  formRelatorioControlePagamento: TformRelatorioControlePagamento;

implementation

{$R *.dfm}

{ TformRelatorioControlePagamento }

procedure TformRelatorioControlePagamento.imprimirRelatorio(stCondicoes: string);
begin
  DataSource.DataSet := BDBuscarRegistros('tab_funcionario f',
  ' f.id id_funcionario, f.nome funcionario, f.cpf, f.funcao, f.telefone, f.email, f.dt_nascimento, f.salario, pag.data_pagamento, pag.valor_pago, ' +
  ' case when f.ativo is true then ''ATIVO'' else ''INATIVO'' end::varchar status, ' +
  ' (extract(''day'' from (date_trunc(''month'', CURRENT_DATE)+interval ''1 month''-interval ''1 day'')::date) - count(p.id)) faltas ',
  ' left join tab_controlepagamento pag on pag.id_funcionario = f.id ' +
  ' left join tab_pontofuncionario p on p.id_funcionario = f.id and pag.data_ocorrencia = (extract(''month'' from p.data)||''/''||extract(''year'' from p.data)) ',
  SisVarIf(not stCondicoes.IsEmpty, ' 1=1 '+stCondicoes, EmptyStr), ' 1,2,3,4,5,6,7,8,9,10 ', ' pag.data_pagamento ', -1, 'FDQBuscaPagamentoFuncionario');

  if DataSource.DataSet.RecordCount = 0 then
  begin
    Application.MessageBox('Nenhum registro foi encontrado!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  RLReport.Preview;
end;

end.
