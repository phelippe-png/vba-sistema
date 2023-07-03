program VBASistema;

{$R *.dres}

uses
  Vcl.Forms,
  untMain in 'src\untMain.pas' {formMain},
  untListarEmpresas in 'src\Cadastros\Empresas\untListarEmpresas.pas' {formListarEmpresas},
  untCadastrarEmpresa in 'src\Cadastros\Empresas\untCadastrarEmpresa.pas' {formCadastrarEmpresa},
  untListarLotes in 'src\Cadastros\Lotes\untListarLotes.pas' {formListarLotes},
  untClasseEmpresas in 'src\Cadastros\Empresas\untClasseEmpresas.pas',
  untCadastrarLote in 'src\Cadastros\Lotes\untCadastrarLote.pas' {formCadastrarLote},
  untClasseLotes in 'src\Cadastros\Lotes\untClasseLotes.pas',
  functions in 'src\Funções\functions.pas',
  untListarContasPagar in 'src\Cadastros\Contas a Pagar\untListarContasPagar.pas' {formContasPagar},
  untClasseContasPagar in 'src\Cadastros\Contas a Pagar\untClasseContasPagar.pas',
  relatorioContasPagar in 'src\Relatórios\relatorioContasPagar.pas' {formRelatContasPagar},
  untModalValorPago in 'src\Cadastros\Contas a Pagar\untModalValorPago.pas' {formModal},
  untProducao in 'src\Movimentações\Controle de Produção\untProducao.pas' {formListarProducoes},
  untCadastrarProducao in 'src\Movimentações\Controle de Produção\untCadastrarProducao.pas' {formCadastrarProducao},
  untClasseProducao in 'src\Movimentações\Controle de Produção\untClasseProducao.pas',
  relatorioContasReceber in 'src\Relatórios\relatorioContasReceber.pas' {formRelatContasReceber},
  relatorioControleProducao in 'src\Relatórios\relatorioControleProducao.pas' {formRelatControleProducao},
  untContasReceber in 'src\Cadastros\Contas a Receber\untContasReceber.pas' {formContasReceber},
  untModalRelatorios in 'src\untModalRelatorios.pas' {formModalRelatorios},
  untModalConfirmarRecebimento in 'src\Cadastros\Contas a Receber\untModalConfirmarRecebimento.pas' {formConfirmarRecebimento},
  untClasseContasReceber in 'src\Cadastros\Contas a Receber\untClasseContasReceber.pas',
  BancoFuncoes in 'src\Funções\BancoFuncoes.pas',
  DM in 'src\DM.pas' {SisDataModule: TDataModule},
  untControlePagamento in 'src\Movimentações\Controle de Pagamentos Funcionários\untControlePagamento.pas' {formControlePagamentos},
  untFuncionarios in 'src\Cadastros\Funcionários\untFuncionarios.pas' {formFuncionarios},
  untCadastrarFuncionario in 'src\Cadastros\Funcionários\untCadastrarFuncionario.pas' {formCadastrarFuncionario},
  untCadastroPonto in 'src\Cadastros\Ponto de Funcionario\untCadastroPonto.pas' {formCadastrarPonto},
  untPagamentos in 'src\Movimentações\Controle de Pagamentos Funcionários\untPagamentos.pas' {formPagamentos},
  untObservacoesDias in 'src\Cadastros\Ponto de Funcionario\untObservacoesDias.pas' {formObservacoesDias},
  untPagamentosAnteriores in 'src\Movimentações\Controle de Pagamentos Funcionários\untPagamentosAnteriores.pas' {formPagamentosAnteriores},
  relatorioControlePagamento in 'src\Relatórios\relatorioControlePagamento.pas' {formRelatorioControlePagamento},
  relatorioPontoFuncionarios in 'src\Relatórios\relatorioPontoFuncionarios.pas' {formRelatPontoFuncionarios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TSisDataModule, SisDataModule);
  Application.CreateForm(TformCadastrarPonto, formCadastrarPonto);
  Application.CreateForm(TformPagamentos, formPagamentos);
  Application.CreateForm(TformObservacoesDias, formObservacoesDias);
  Application.CreateForm(TformPagamentosAnteriores, formPagamentosAnteriores);
  Application.CreateForm(TformRelatorioControlePagamento, formRelatorioControlePagamento);
  Application.CreateForm(TformRelatPontoFuncionarios, formRelatPontoFuncionarios);
  Application.Run;
end.
