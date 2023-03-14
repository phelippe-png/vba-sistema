unit untModalRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXPanels,
  Vcl.StdCtrls, Vcl.ComCtrls, relatorioContasPagar, functions, System.JSON,
  relatorioContasReceber, relatorioControleProducao, Vcl.Imaging.pngimage,
  untListarEmpresas;

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
  private
    relatorioContasPagar: TformRelatContasPagar;
    relatorioContasReceber: TformRelatContasReceber;
    relatorioControleProducao: TformRelatControleProducao;
    stream: TStream;
    idEmpresa: integer;

    function montarQuery: string;
  public
    tipoRelatorio: (contasPagar, contasReceber, controleProducao);
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

  if tipoRelatorio = contasPagar then
    relatorioContasPagar.imprimirRelatorio(montarQuery);

  if tipoRelatorio = contasReceber then
    relatorioContasReceber.imprimirRelatorio(montarQuery);

  if tipoRelatorio = controleProducao then
    relatorioControleProducao.imprimirRelatorio(montarQuery);
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
end;

function TformModalRelatorios.montarQuery: string;
begin
  Result := EmptyStr;

  if tipoRelatorio = contasPagar then
  begin
    if rbDataContasPagar.Checked then
      Result := Result + ' and data_venc between ' + QuotedStr(DateToStr(dataInicialContasPagar.Date)) +
        ' and ' + QuotedStr(DateToStr(dataFinalContasPagar.Date));

    if rbMesContasPagar.Checked then
      Result := Result + ' and extract(''month'' from data_venc) = ' +
        IntToStr(cbFiltroMesesContasPagar.ItemIndex + 1);

    if rgSituacoesContasPagar.ItemIndex = 1 then
      Result := Result + ' and pago is true ';
    if rgSituacoesContasPagar.ItemIndex = 2 then
      Result := Result + ' and pago is not true ';
    if rgSituacoesContasPagar.ItemIndex = 3 then
      Result := Result + ' and data_venc > current_date and pago is not true ';
    if rgSituacoesContasPagar.ItemIndex = 4 then
      Result := Result + ' and data_venc = current_date and pago is not true ';
    if rgSituacoesContasPagar.ItemIndex = 5 then
      Result := Result + ' and data_venc < current_date and pago is not true ';
  end;

  if tipoRelatorio = contasReceber then
  begin
    if rbDataContasReceber.Checked then
      Result := Result + ' and previsao_recebimento between ' + QuotedStr(DateToStr(dataInicialContasReceber.Date)) +
        ' and ' + QuotedStr(DateToStr(dataFinalContasReceber.Date));

    if rbMesContasReceber.Checked then
      Result := Result + ' and extract(''month'' from previsao_recebimento) = ' +
        IntToStr(cbFiltroMesContasReceber.ItemIndex + 1);

    if rgContasReceber.ItemIndex = 1 then
      Result := Result + ' and recebido is true ';
    if rgContasReceber.ItemIndex = 2 then
      Result := Result + ' and recebido is not true ';
  end;

  if tipoRelatorio = controleProducao then
  begin
    if rbDataProducao.Checked then
      Result := Result + ' and data_inicio between ' + QuotedStr(DateToStr(dataInicialProducao.Date)) +
        ' and ' + QuotedStr(DateToStr(dataFinalProducao.Date));

    if rbMesProducao.Checked then
      Result := Result + ' and extract(''month'' from data_inicio) = ' +
        IntToStr(cbFiltroMesProducao.ItemIndex + 1);

    if ckbEmpresaProducao.Checked then
      Result := Result + ' and cp.id_empresa = ' + IntToStr(idEmpresa);

    if rgStatusProducao.ItemIndex = 1 then
      Result := Result + ' and status = ''EM ABERTO'' ';
    if rgStatusProducao.ItemIndex = 2 then
      Result := Result + ' and status = ''EM PRODUÇÃO'' ';
    if rgStatusProducao.ItemIndex = 3 then
      Result := Result + ' and status = ''FINALIZADO'' ';
  end;
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

end.
