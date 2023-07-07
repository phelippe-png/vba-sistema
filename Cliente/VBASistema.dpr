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
  functions in 'src\Fun��es\functions.pas',
  untListarContasPagar in 'src\Cadastros\Contas a Pagar\untListarContasPagar.pas' {formContasPagar},
  untClasseContasPagar in 'src\Cadastros\Contas a Pagar\untClasseContasPagar.pas',
  relatorioContasPagar in 'src\Relat�rios\relatorioContasPagar.pas' {formRelatContasPagar},
  untModalValorPago in 'src\Cadastros\Contas a Pagar\untModalValorPago.pas' {formModal},
  untProducao in 'src\Movimenta��es\Controle de Produ��o\untProducao.pas' {formListarProducoes},
  untCadastrarProducao in 'src\Movimenta��es\Controle de Produ��o\untCadastrarProducao.pas' {formCadastrarProducao},
  untClasseProducao in 'src\Movimenta��es\Controle de Produ��o\untClasseProducao.pas',
  relatorioContasReceber in 'src\Relat�rios\relatorioContasReceber.pas' {formRelatContasReceber},
  relatorioControleProducao in 'src\Relat�rios\relatorioControleProducao.pas' {formRelatControleProducao},
  untContasReceber in 'src\Cadastros\Contas a Receber\untContasReceber.pas' {formContasReceber},
  untModalRelatorios in 'src\untModalRelatorios.pas' {formModalRelatorios},
  untModalConfirmarRecebimento in 'src\Cadastros\Contas a Receber\untModalConfirmarRecebimento.pas' {formConfirmarRecebimento},
  untClasseContasReceber in 'src\Cadastros\Contas a Receber\untClasseContasReceber.pas',
  BancoFuncoes in 'src\Fun��es\BancoFuncoes.pas',
  DM in 'src\DM.pas' {SisDataModule: TDataModule},
  untControlePagamento in 'src\Movimenta��es\Controle de Pagamentos Funcion�rios\untControlePagamento.pas' {formControlePagamentos},
  untFuncionarios in 'src\Cadastros\Funcion�rios\untFuncionarios.pas' {formFuncionarios},
  untCadastrarFuncionario in 'src\Cadastros\Funcion�rios\untCadastrarFuncionario.pas' {formCadastrarFuncionario},
  untCadastroPonto in 'src\Cadastros\Ponto de Funcionario\untCadastroPonto.pas' {formCadastrarPonto},
  untPagamentos in 'src\Movimenta��es\Controle de Pagamentos Funcion�rios\untPagamentos.pas' {formPagamentos},
  untObservacoesDias in 'src\Cadastros\Ponto de Funcionario\untObservacoesDias.pas' {formObservacoesDias},
  untPagamentosAnteriores in 'src\Movimenta��es\Controle de Pagamentos Funcion�rios\untPagamentosAnteriores.pas' {formPagamentosAnteriores},
  relatorioControlePagamento in 'src\Relat�rios\relatorioControlePagamento.pas' {formRelatorioControlePagamento},
  relatorioPontoFuncionarios in 'src\Relat�rios\relatorioPontoFuncionarios.pas' {formRelatPontoFuncionarios},
  untInformarValorPagar in 'src\Movimenta��es\Controle de Pagamentos Funcion�rios\untInformarValorPagar.pas' {formInformarValorPagar};

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
  Application.CreateForm(TformInformarValorPagar, formInformarValorPagar);
  Application.Run;
end.
