program VBASistema;

uses
  Vcl.Forms,
  untMain in 'src\untMain.pas' {formMain},
  untListarEmpresas in 'src\Cadastros\Empresas\untListarEmpresas.pas' {formListarEmpresas},
  untCadastrarEmpresa in 'src\Cadastros\Empresas\untCadastrarEmpresa.pas' {formCadastrarEmpresa},
  untListarLotes in 'src\Cadastros\Lotes\untListarLotes.pas' {formListarLotes},
  untClasseEmpresas in 'src\Cadastros\Empresas\untClasseEmpresas.pas',
  untCadastrarLote in 'src\Cadastros\Lotes\untCadastrarLote.pas' {formCadastrarLote},
  untClasseLotes in 'src\Cadastros\Lotes\untClasseLotes.pas',
  functions in 'src\functions.pas',
  untListarContasPagar in 'src\Cadastros\Contas a Pagar\untListarContasPagar.pas' {formContasPagar},
  untClasseContasPagar in 'src\Cadastros\Contas a Pagar\untClasseContasPagar.pas',
  relatorioContasPagar in 'src\Relatórios\relatorioContasPagar.pas' {formRelatContasPagar},
  untModalValorPago in 'src\Cadastros\Contas a Pagar\untModalValorPago.pas' {formModal},
  untProducao in 'src\Processo\untProducao.pas' {formListarProducoes},
  untCadastrarProducao in 'src\Processo\untCadastrarProducao.pas' {formCadastrarProducao},
  untClasseProducao in 'src\Processo\untClasseProducao.pas',
  relatorioContasReceber in 'src\Relatórios\relatorioContasReceber.pas' {formRelatContasReceber},
  relatorioControleProducao in 'src\Relatórios\relatorioControleProducao.pas' {formRelatControleProducao},
  untContasReceber in 'src\Cadastros\Contas a Receber\untContasReceber.pas' {formContasReceber},
  untModalRelatorios in 'src\untModalRelatorios.pas' {formModalRelatorios},
  untModalConfirmarRecebimento in 'src\Cadastros\Contas a Receber\untModalConfirmarRecebimento.pas' {formConfirmarRecebimento},
  untClasseContasReceber in 'src\Cadastros\Contas a Receber\untClasseContasReceber.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
