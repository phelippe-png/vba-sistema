unit untModalRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXPanels,
  Vcl.StdCtrls, Vcl.ComCtrls, relatorioContasPagar, functions, System.JSON,
  relatorioContasReceber, relatorioControleProducao, Vcl.Imaging.pngimage,
  untListarEmpresas, relatorioControlePagamento, Vcl.Buttons, Vcl.WinXPickers,
  untFuncionarios, System.DateUtils, relatorioPontoFuncionarios;

type
  TformModalRelatorios = class(TForm)
    CardPanel1: TCardPanel;
    cardContasPagar: TCard;
    Label4: TLabel;
    pnlContainer: TPanel;
    Panel6: TPanel;
    cbFiltroMesesContasPagar: TComboBox;
    dataFinalContasPagar: TDateTimePicker;
    Label2: TLabel;
    dataInicialContasPagar: TDateTimePicker;
    Label3: TLabel;
    Label1: TLabel;
    Panel1: TPanel;
    rgSituacoesContasPagar: TRadioGroup;
    rbDataContasPagar: TRadioButton;
    rbMesContasPagar: TRadioButton;
    Panel2: TPanel;
    btnGerar: TPanel;
    cardContasReceber: TCard;
    Label9: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Panel4: TPanel;
    cbFiltroMesContasReceber: TComboBox;
    dataFinalContasReceber: TDateTimePicker;
    dataInicialContasReceber: TDateTimePicker;
    Panel5: TPanel;
    rgContasReceber: TRadioGroup;
    rbDataContasReceber: TRadioButton;
    rbMesContasReceber: TRadioButton;
    cardControleProducao: TCard;
    Label11: TLabel;
    Label12: TLabel;
    Panel7: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Panel8: TPanel;
    cbFiltroMesProducao: TComboBox;
    dataFinalProducao: TDateTimePicker;
    dataInicialProducao: TDateTimePicker;
    Panel9: TPanel;
    rgStatusProducao: TRadioGroup;
    rbDataProducao: TRadioButton;
    rbMesProducao: TRadioButton;
    Label16: TLabel;
    Panel10: TPanel;
    ckbEmpresaProducao: TCheckBox;
    Label17: TLabel;
    btnBuscarEmpresa: TImage;
    lblTituloRazao: TLabel;
    lblTituloFantasia: TLabel;
    lblRazao: TLabel;
    lblFantasia: TLabel;
    cardControlePagamento: TCard;
    Label18: TLabel;
    Label19: TLabel;
    Panel11: TPanel;
    pnlBtnBuscarEmpresa: TPanel;
    lblFuncionario: TLabel;
    Panel14: TPanel;
    cardPontoFuncionario: TCard;
    btnBuscarFuncionario: TSpeedButton;
    Label22: TLabel;
    ckbFiltrarPorMesAno: TCheckBox;
    dtpMesAnoPagamento: TDatePicker;
    Label20: TLabel;
    Label21: TLabel;
    Panel12: TPanel;
    lblPontoFuncionario: TLabel;
    Panel13: TPanel;
    btnPontoBuscarFuncionario: TSpeedButton;
    Panel15: TPanel;
    dtpPontoMes: TDatePicker;
    dtpPontoAno: TDatePicker;
    rgpPontoFiltros: TRadioGroup;
    procedure rbMesContasPagarClick(Sender: TObject);
    procedure rbDataContasPagarClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure rbDataContasReceberClick(Sender: TObject);
    procedure rbMesContasReceberClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure ckbEmpresaProducaoClick(Sender: TObject);
    procedure rbDataProducaoClick(Sender: TObject);
    procedure rbMesProducaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ckbFiltrarPorMesAnoClick(Sender: TObject);
    procedure btnBuscarFuncionarioClick(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure rgpPontoFiltrosClick(Sender: TObject);
  private
    relatorioContasPagar: TformRelatContasPagar;
    relatorioContasReceber: TformRelatContasReceber;
    relatorioControleProducao: TformRelatControleProducao;
    relatorioControlePagamento: TformRelatorioControlePagamento;
    relatorioPontoFuncionario: TformRelatPontoFuncionarios;
    stream: TStream;
    idEmpresa, vIdFuncionario: integer;
    vStrListSQL: TStringList;

    function montarQuery: string;
  public
    tipoRelatorio: (contasPagar, contasReceber, controleProducao, controlePagamento, pontoFuncionario);
  end;

var
  formModalRelatorios: TformModalRelatorios;

implementation

{$R *.dfm}

procedure TformModalRelatorios.btnBuscarEmpresaClick(Sender: TObject);
var
  vFormEmpresas: TformListarEmpresas;
begin
  vFormEmpresas := TformListarEmpresas.Create(Self);
  with vFormEmpresas do
  begin
    mudarEstadoDBGrid := True;
    BorderStyle := bsSingle;
    Align := alNone;
    ShowModal;

    if selecionado then
    begin
      idEmpresa := dbgEmpresas.DataSource.DataSet.FieldByName('id').AsInteger;
      lblRazao.Caption := dbgEmpresas.DataSource.DataSet.FieldByName('razaosocial').AsString;
      lblFantasia.Caption := dbgEmpresas.DataSource.DataSet.FieldByName('nomefantasia').AsString;
    end;
  end;
end;

procedure TformModalRelatorios.btnGerarClick(Sender: TObject);
begin
  if (idEmpresa = 0) and (ckbEmpresaProducao.Checked) then
  begin
    Application.MessageBox('Selecione uma empresa para filtrar!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  relatorioContasPagar := TformRelatContasPagar.Create(self);
  relatorioContasReceber := TformRelatContasReceber.Create(self);
  relatorioControleProducao := TformRelatControleProducao.Create(self);
  relatorioControlePagamento := TformRelatorioControlePagamento.Create(Self);
  relatorioPontoFuncionario := TformRelatPontoFuncionarios.Create(Self);

  if tipoRelatorio = contasPagar then
    relatorioContasPagar.imprimirRelatorio(montarQuery);
  if tipoRelatorio = contasReceber then
    relatorioContasReceber.imprimirRelatorio(montarQuery);
  if tipoRelatorio = controleProducao then
    relatorioControleProducao.imprimirRelatorio(montarQuery);
  if tipoRelatorio = controlePagamento then
    relatorioControlePagamento.imprimirRelatorio(montarQuery);

  if tipoRelatorio = pontoFuncionario then
  begin
    if vIdFuncionario = 0 then
    begin
      Application.MessageBox('Selecione um funcionário!', 'Atenção', MB_ICONWARNING);
      Exit;
    end;
    relatorioPontoFuncionario.imprimirRelatorio(SisVarIf(dtpPontoMes.Enabled, MonthOf(dtpPontoMes.Date), 0), YearOf(dtpPontoAno.Date), vIdFuncionario);
  end;
end;

procedure TformModalRelatorios.ckbEmpresaProducaoClick(Sender: TObject);
begin
  idEmpresa := 0;
  lblRazao.Caption := 'Não selecionado';
  lblFantasia.Caption := 'Não selecionado';

  if ckbEmpresaProducao.Checked then
  begin
    lblTituloRazao.Visible := true;
    lblTituloFantasia.Visible := true;
    lblRazao.Visible := true;
    lblFantasia.Visible := true;

    btnBuscarEmpresa.Enabled := true;
  end;

  if not ckbEmpresaProducao.Checked then
  begin
    lblTituloRazao.Visible := false;
    lblTituloFantasia.Visible := false;
    lblRazao.Visible := false;
    lblFantasia.Visible := false;

    btnBuscarEmpresa.Enabled := false;
  end;
end;

procedure TformModalRelatorios.ckbFiltrarPorMesAnoClick(Sender: TObject);
begin
  dtpMesAnoPagamento.Enabled := ckbFiltrarPorMesAno.Checked;
end;

procedure TformModalRelatorios.FormCreate(Sender: TObject);
begin
  vStrListSQL := TStringList.Create;
end;

procedure TformModalRelatorios.FormShow(Sender: TObject);
begin
  dataInicialContasPagar.Date := Now;
  dataInicialContasReceber.Date := Now;
  dataInicialProducao.Date := Now;
  dataFinalContasPagar.Date := Now;
  dataFinalContasReceber.Date := Now;
  dataFinalProducao.Date := Now;

  if tipoRelatorio = contasPagar then
    CardPanel1.ActiveCard := cardContasPagar;

  if tipoRelatorio = contasReceber then
    CardPanel1.ActiveCard := cardContasReceber;

  if tipoRelatorio = controleProducao then
    CardPanel1.ActiveCard := cardControleProducao;

  if tipoRelatorio = controlePagamento then
  begin
    Self.Height := 190;
    CardPanel1.ActiveCard := cardControlePagamento;
  end;

  if tipoRelatorio = pontoFuncionario then
  begin
    Self.Height := 210;
    CardPanel1.ActiveCard := cardPontoFuncionario;
  end;
end;

function TformModalRelatorios.montarQuery: string;
begin
  with vStrListSQL do
  begin
    Clear;

    if tipoRelatorio = contasPagar then
    begin
      if rbDataContasPagar.Checked then
        Add(' and data_venc between ' + QuotedStr(DateToStr(dataInicialContasPagar.Date)) +
          ' and ' + QuotedStr(DateToStr(dataFinalContasPagar.Date)));

      if rbMesContasPagar.Checked then
        Add(' and extract(''month'' from data_venc) = ' +
          IntToStr(cbFiltroMesesContasPagar.ItemIndex + 1));

      if rgSituacoesContasPagar.ItemIndex = 1 then
        Add(' and pago is true ');
      if rgSituacoesContasPagar.ItemIndex = 2 then
        Add(' and pago is not true ');
      if rgSituacoesContasPagar.ItemIndex = 3 then
        Add(' and data_venc > current_date and pago is not true ');
      if rgSituacoesContasPagar.ItemIndex = 4 then
        Add(' and data_venc = current_date and pago is not true ');
      if rgSituacoesContasPagar.ItemIndex = 5 then
        Add(' and data_venc < current_date and pago is not true ');
    end;

    if tipoRelatorio = contasReceber then
    begin
      if rbDataContasReceber.Checked then
        Add(' and previsao_recebimento between ' + QuotedStr(DateToStr(dataInicialContasReceber.Date)) +
          ' and ' + QuotedStr(DateToStr(dataFinalContasReceber.Date)));

      if rbMesContasReceber.Checked then
        Add(' and extract(''month'' from previsao_recebimento) = ' +
          IntToStr(cbFiltroMesContasReceber.ItemIndex + 1));

      if rgContasReceber.ItemIndex = 1 then
        Add(' and recebido is true ');
      if rgContasReceber.ItemIndex = 2 then
        Add(' and recebido is not true ');
    end;

    if tipoRelatorio = controleProducao then
    begin
      if rbDataProducao.Checked then
        Add(' and data_inicio between ' + QuotedStr(DateToStr(dataInicialProducao.Date)) +
        ' and ' + QuotedStr(DateToStr(dataFinalProducao.Date)));

      if rbMesProducao.Checked then
        Add(' and extract(''month'' from data_inicio) = ' + IntToStr(cbFiltroMesProducao.ItemIndex + 1));

      if ckbEmpresaProducao.Checked then
        Add(' and cp.id_empresa = ' + IntToStr(idEmpresa));

      if rgStatusProducao.ItemIndex = 1 then
        Add(' and status = ''EM ABERTO'' ');
      if rgStatusProducao.ItemIndex = 2 then
        Add(' and status = ''EM PRODUÇÃO'' ');
      if rgStatusProducao.ItemIndex = 3 then
        Add(' and status = ''FINALIZADO'' ');
    end;

    if tipoRelatorio = controlePagamento then
    begin
      if ckbFiltrarPorMesAno.Checked then
        Add(' and extract(month from pag.data_pagamento)||''/''||extract(year from pag.data_pagamento) = '+
                  QuotedStr(MonthOf(dtpMesAnoPagamento.Date).ToString+'/'+YearOf(dtpMesAnoPagamento.Date).ToString));

      if vIdFuncionario <> 0 then
        Add(' and f.id = '+vIdFuncionario.ToString);
    end;

    Result := Text;
  end;
end;

procedure TformModalRelatorios.Panel2Click(Sender: TObject);
begin
  Close;
end;

procedure TformModalRelatorios.rbDataContasPagarClick(Sender: TObject);
begin
  cbFiltroMesesContasPagar.Enabled := false;
  cbFiltroMesesContasPagar.ItemIndex := -1;

  dataInicialContasPagar.Enabled := true;
  dataFinalContasPagar.Enabled := true;
end;

procedure TformModalRelatorios.rbDataContasReceberClick(Sender: TObject);
begin
  cbFiltroMesContasReceber.Enabled := false;
  cbFiltroMesContasReceber.ItemIndex := -1;

  dataInicialContasReceber.Enabled := true;
  dataFinalContasReceber.Enabled := true;
end;

procedure TformModalRelatorios.rbDataProducaoClick(Sender: TObject);
begin
  cbFiltroMesProducao.Enabled := false;
  cbFiltroMesProducao.ItemIndex := -1;

  dataInicialProducao.Enabled := true;
  dataFinalProducao.Enabled := true;
end;

procedure TformModalRelatorios.rbMesContasPagarClick(Sender: TObject);
begin
  dataInicialContasPagar.Enabled := false;
  dataFinalContasPagar.Enabled := false;

  cbFiltroMesesContasPagar.Enabled := true;
  cbFiltroMesesContasPagar.ItemIndex := 0;
end;

procedure TformModalRelatorios.rbMesContasReceberClick(Sender: TObject);
begin
  dataInicialContasReceber.Enabled := false;
  dataFinalContasReceber.Enabled := false;

  cbFiltroMesContasReceber.Enabled := true;
  cbFiltroMesContasReceber.ItemIndex := 0;
end;

procedure TformModalRelatorios.rbMesProducaoClick(Sender: TObject);
begin
  dataInicialProducao.Enabled := false;
  dataFinalProducao.Enabled := false;

  cbFiltroMesProducao.Enabled := true;
  cbFiltroMesProducao.ItemIndex := 0;
end;

procedure TformModalRelatorios.rgpPontoFiltrosClick(Sender: TObject);
begin
  dtpPontoMes.Enabled := True;
  dtpPontoMes.Color := clWindow;

  if rgpPontoFiltros.ItemIndex = 1 then
  begin
    dtpPontoMes.Enabled := False;
    dtpPontoMes.Color := $00B7B7B7;
    Refresh;
  end;
end;

procedure TformModalRelatorios.btnBuscarFuncionarioClick(Sender: TObject);
begin
  with TformFuncionarios.Create(Self) do
  begin
    WindowState := wsNormal;
    Align := alNone;
    BorderStyle := bsSingle;
    btnSelect.Visible := True;
    ShowModal;

    if Selecionado then
    begin
      lblFuncionario.Caption := 'Funcionário: '+dbgFuncionarios.DataSource.DataSet.FieldByName('nome').AsString;
      vIdFuncionario := dbgFuncionarios.DataSource.DataSet.FieldByName('id').AsInteger;
    end;
  end;
end;

end.
