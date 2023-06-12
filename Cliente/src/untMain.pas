unit untMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Grids, Vcl.DBGrids, IdAuthentication,
  DataSet.Serialize, System.JSON, Vcl.Menus, Vcl.WinXPanels, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, untListarEmpresas, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  Vcl.ControlList, Vcl.StdCtrls, Horse, Horse.Jhonson, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, untListarLotes, Vcl.ComCtrls, untListarContasPagar,
  relatorioContasPagar, untCadastrarProducao, untProducao,
  relatorioControleProducao, functions, untContasReceber,
  relatorioContasReceber, untModalRelatorios, ShellAPI, MidasLib, MidasCon, Midas,
  BancoFuncoes, System.Generics.Collections, untFuncionarios, untPagamentos, untCadastroPonto,
  untcontrolepagamento;

type
  TformMain = class(TForm)
    pnlContainer: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Image2: TImage;
    pnlMenu: TPanel;
    Image1: TImage;
    pnlMenus: TPanel;
    pnlProcessos: TPanel;
    Image4: TImage;
    Label3: TLabel;
    SpeedButton5: TSpeedButton;
    pnlCadastros: TPanel;
    Image3: TImage;
    Label4: TLabel;
    SpeedButton4: TSpeedButton;
    pnlRelatorios: TPanel;
    Image5: TImage;
    Label2: TLabel;
    SpeedButton6: TSpeedButton;
    pnlProcessosMenu: TPanel;
    menuControleProducao: TPanel;
    btnControleProducao: TSpeedButton;
    menuControlePagamento: TPanel;
    btnControlePagamento: TSpeedButton;
    pnlRelatoriosMenu: TPanel;
    menuRelatControleProducao: TPanel;
    SpeedButton7: TSpeedButton;
    menuRelatContasReceber: TPanel;
    SpeedButton3: TSpeedButton;
    menuRelatContasPagar: TPanel;
    SpeedButton2: TSpeedButton;
    pnlCadastrosMenu: TPanel;
    menuContasReceber: TPanel;
    btnContasReceber: TSpeedButton;
    menuLotes: TPanel;
    btnLotes: TSpeedButton;
    menuEmpresa: TPanel;
    btnEmpresas: TSpeedButton;
    menuFuncionarios: TPanel;
    btnFuncionarios: TSpeedButton;
    menuContasPagar: TPanel;
    btnContasPagar: TSpeedButton;
    menuCadastroPonto: TPanel;
    btnCadastrarPonto: TSpeedButton;
    menuRelatControlePagamento: TPanel;
    btnRelatControlePagamento: TSpeedButton;
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnEmpresasClick(Sender: TObject);
    procedure btnLotesClick(Sender: TObject);
    procedure btnContasPagarClick(Sender: TObject);
    procedure SpeedButton4MouseEnter(Sender: TObject);
    procedure SpeedButton4MouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
    procedure SpeedButton6MouseEnter(Sender: TObject);
    procedure SpeedButton6MouseLeave(Sender: TObject);
    procedure btnEmpresasMouseLeave(Sender: TObject);
    procedure btnLotesMouseLeave(Sender: TObject);
    procedure btnContasPagarMouseLeave(Sender: TObject);
    procedure btnControleProducaoClick(Sender: TObject);
    procedure btnControleProducaoMouseLeave(Sender: TObject);
    procedure btnContasReceberMouseLeave(Sender: TObject);
    procedure btnContasReceberClick(Sender: TObject);
    procedure SpeedButton2MouseLeave(Sender: TObject);
    procedure SpeedButton3MouseLeave(Sender: TObject);
    procedure SpeedButton7MouseLeave(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure btnFuncionariosMouseLeave(Sender: TObject);
    procedure btnFuncionariosClick(Sender: TObject);
    procedure btnControlePagamentoMouseLeave(Sender: TObject);
    procedure btnControlePagamentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCadastrarPontoMouseLeave(Sender: TObject);
    procedure btnCadastrarPontoClick(Sender: TObject);
    procedure btnRelatControlePagamentoMouseLeave(Sender: TObject);
    procedure btnRelatControlePagamentoClick(Sender: TObject);
  private
    formContasPagar: TformContasPagar;
    formProducao: TformListarProducoes;
    formContasReceber: TformContasReceber;
    pt: TPoint;
    panelPrevious: TPanel;
    shell: Cardinal;

    procedure fecharTelas;
    procedure abrirMenus(panel: TPanel);
    procedure abrirTelas(form: TForm);
    procedure colorChangePainels(panel: TPanel);
    procedure MouseLeaveCadastros(Sender: TObject);
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.fecharTelas;
begin
  if formListarEmpresas <> nil then
    formListarEmpresas.Close;

  if formListarLotes <> nil then
    formListarLotes.Close;

  if formContasPagar <> nil then
    formContasPagar.Close;

  if formProducao <> nil then
    formProducao.Close;

  if formFuncionarios <> nil then
    formFuncionarios.Close;

  if formControlePagamentos <> nil then
    formControlePagamentos.Close;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  pnlMenu.Padding.Left := 100;
  pnlMenu.Padding.Right := 100;
  pnlMenu.Padding.Top := 100;
  pnlMenu.Padding.Bottom := 100;
  panelPrevious := TPanel.Create(Self);
end;

procedure TformMain.FormResize(Sender: TObject);
begin
  Self.Constraints.MinWidth := 1050;
end;

procedure TformMain.FormShow(Sender: TObject);
begin
  btnControlePagamento.Caption := 'Controle de Pagamento' + sLineBreak + '(Manutenção)';
end;

procedure TformMain.Image2Click(Sender: TObject);
begin
  if pnlMenus.Width = 180 then
    pnlMenus.Width := 57
  else
    pnlMenus.Width := 180;
end;

procedure TformMain.MouseLeaveCadastros(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or
  (WindowFromPoint(Pt) = menuLotes.Handle) or
  (WindowFromPoint(Pt) = menuContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuFuncionarios.Handle) or
  (WindowFromPoint(Pt) = menuCadastroPonto.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.abrirMenus(panel: TPanel);
var
  I: Integer;
  pt: TPoint;
begin
  pnlCadastrosMenu.Visible := false;
  pnlProcessosMenu.Visible := false;
  pnlRelatoriosMenu.Visible := false;

  case panel.Tag of
    1:
    begin
      pnlCadastrosMenu.Left := pnlCadastros.Width;
      pnlCadastrosMenu.Visible := true;
    end;
    2:
    begin
      pnlProcessosMenu.Left := pnlProcessos.Width;
      pnlProcessosMenu.Top := 98;
      pnlProcessosMenu.Visible := true;
    end;
    3:
    begin
      pnlRelatoriosMenu.Left := pnlRelatorios.Width;
      pnlRelatoriosMenu.Top := 147;
      pnlRelatoriosMenu.Visible := true;
    end;
  end;
end;

procedure TformMain.colorChangePainels(panel: TPanel);
begin
  panelPrevious.Color := clGray;

  panel.Color := $004D4D4D;

  panelPrevious := panel;
end;

procedure TformMain.abrirTelas(form: TForm);
begin
  fecharTelas;

  form.Parent := pnlMenu;

  pnlMenu.Padding.Top := 0;
  pnlMenu.Padding.Bottom := 0;
  pnlMenu.Padding.Left := 0;
  pnlMenu.Padding.Right := 0;

  form.Show;
end;

procedure TformMain.btnCadastrarPontoClick(Sender: TObject);
begin
  formCadastrarPonto := TformCadastrarPonto.Create(Self);
  formCadastrarPonto.Parent := Self;
  formCadastrarPonto.Show;
end;

procedure TformMain.btnCadastrarPontoMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or
  (WindowFromPoint(Pt) = menuLotes.Handle) or
  (WindowFromPoint(Pt) = menuContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuCadastroPonto.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnContasPagarClick(Sender: TObject);
begin
  formContasPagar := TformContasPagar.Create(self);
  abrirTelas(formContasPagar);
end;



procedure TformMain.btnControleProducaoClick(Sender: TObject);
begin
  formProducao := TformListarProducoes.Create(self);
  abrirTelas(formProducao);
end;

procedure TformMain.btnEmpresasClick(Sender: TObject);
begin
  formListarEmpresas := TformListarEmpresas.Create(Self);
  abrirTelas(formListarEmpresas);
end;

procedure TformMain.btnLotesClick(Sender: TObject);
begin
  formListarLotes := TformListarLotes.Create(self);
  abrirTelas(formListarLotes);
end;

procedure TformMain.SpeedButton2Click(Sender: TObject);
var
  modalRelatorios: TformModalRelatorios;
begin
  modalRelatorios := TformModalRelatorios.Create(self);
  modalRelatorios.tipoRelatorio := contasPagar;
  modalRelatorios.ShowModal;
end;

procedure TformMain.SpeedButton2MouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuRelatControleProducao.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuRelatControlePagamento.Handle) then
    exit
  else
    pnlRelatoriosMenu.Visible := false;
end;

procedure TformMain.SpeedButton3Click(Sender: TObject);
var
  modalRelatorios: TformModalRelatorios;
begin
  modalRelatorios := TformModalRelatorios.Create(self);
  modalRelatorios.tipoRelatorio := contasReceber;
  modalRelatorios.ShowModal;
end;

//mouseenter
procedure TformMain.SpeedButton4MouseEnter(Sender: TObject);
begin
  pnlCadastros.Color := $00282800;
  abrirMenus(pnlCadastros);
end;

procedure TformMain.SpeedButton5MouseEnter(Sender: TObject);
begin
  pnlProcessos.Color := $00282800;
  abrirMenus(pnlProcessos);
end;

procedure TformMain.SpeedButton6MouseEnter(Sender: TObject);
begin
  pnlRelatorios.Color := $00282800;
  abrirMenus(pnlRelatorios);
end;

procedure TformMain.btnRelatControlePagamentoClick(Sender: TObject);
var
  modalRelatorios: TformModalRelatorios;
begin
  modalRelatorios := TformModalRelatorios.Create(self);
  modalRelatorios.tipoRelatorio := controlePagamento;
  modalRelatorios.ShowModal;
end;

//mouseleave
procedure TformMain.btnLotesMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or
  (WindowFromPoint(Pt) = menuLotes.Handle) or
  (WindowFromPoint(Pt) = menuContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuFuncionarios.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnRelatControlePagamentoMouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuRelatControleProducao.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuRelatControlePagamento.Handle) then
    exit
  else
    pnlRelatoriosMenu.Visible := false;
end;

procedure TformMain.btnContasPagarMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or
  (WindowFromPoint(Pt) = menuLotes.Handle) or
  (WindowFromPoint(Pt) = menuContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuFuncionarios.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnControleProducaoMouseLeave(Sender: TObject);
begin
  pnlProcessos.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuControleProducao.Handle) or (WindowFromPoint(Pt) = menuControlePagamento.Handle) then
    exit
  else
    pnlProcessosMenu.Visible := false;
end;

procedure TformMain.SpeedButton4MouseLeave(Sender: TObject);
begin
  pnlCadastros.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or (WindowFromPoint(Pt) = menuLotes.Handle) or (WindowFromPoint(Pt) = menuContasPagar.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.SpeedButton5MouseLeave(Sender: TObject);
begin
  pnlProcessos.Color := $00404000;

  GetCursorPos(Pt);

  if WindowFromPoint(Pt) = menuControleProducao.Handle then
    exit
  else
    pnlProcessosMenu.Visible := false;
end;

procedure TformMain.SpeedButton6MouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuRelatContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuRelatControleProducao.Handle) then
    exit
  else
    pnlRelatoriosMenu.Visible := false;
end;

procedure TformMain.SpeedButton3MouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuRelatControleProducao.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuRelatControlePagamento.Handle) then
    exit
  else
    pnlRelatoriosMenu.Visible := false;
end;

procedure TformMain.SpeedButton7Click(Sender: TObject);
var
  modalRelatorios: TformModalRelatorios;
begin
  modalRelatorios := TformModalRelatorios.Create(self);
  modalRelatorios.tipoRelatorio := controleProducao;
  modalRelatorios.ShowModal;
end;

procedure TformMain.SpeedButton7MouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuRelatControleProducao.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuRelatContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuRelatControlePagamento.Handle) then
    exit
  else
    pnlRelatoriosMenu.Visible := false;
end;

procedure TformMain.btnContasReceberClick(Sender: TObject);
begin
  formContasReceber := TformContasReceber.Create(Self);
  abrirTelas(formContasReceber);
end;

procedure TformMain.btnContasReceberMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or
  (WindowFromPoint(Pt) = menuLotes.Handle) or
  (WindowFromPoint(Pt) = menuContasPagar.Handle) or
  (WindowFromPoint(Pt) = menuContasReceber.Handle) or
  (WindowFromPoint(Pt) = menuCadastroPonto.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnEmpresasMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or (WindowFromPoint(Pt) = menuLotes.Handle) or (WindowFromPoint(Pt) = menuContasPagar.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnFuncionariosClick(Sender: TObject);
begin
  formFuncionarios := TformFuncionarios.Create(Self);
  abrirTelas(formFuncionarios);
end;

procedure TformMain.btnFuncionariosMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or (WindowFromPoint(Pt) = menuLotes.Handle) or (WindowFromPoint(Pt) = menuContasPagar.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnControlePagamentoClick(Sender: TObject);
begin
  formpagamentos := tformpagamentos.Create(Self);
  abrirTelas(formpagamentos);
end;

procedure TformMain.btnControlePagamentoMouseLeave(Sender: TObject);
begin
  pnlProcessos.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuControleProducao.Handle) or (WindowFromPoint(Pt) = menuControlePagamento.Handle) then
    exit
  else
    pnlProcessosMenu.Visible := false;
end;

end.
