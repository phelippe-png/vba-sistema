unit untContasReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.CheckLst, Datasnap.DBClient,
  functions, System.JSON, IdHTTP, DataSet.Serialize,
  untModalConfirmarRecebimento, untClasseContasReceber, FireDAC.Comp.Client, BancoFuncoes,
  DateUtils;

type
  TformContasReceber = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label13: TLabel;
    pnlSearch: TPanel;
    Panel5: TPanel;
    btnDelete: TPanel;
    btnConfirmar: TPanel;
    cbFiltroMeses: TComboBox;
    dbgContasReceber: TDBGrid;
    pnlValues: TPanel;
    Label9: TLabel;
    lblTotalReceber: TLabel;
    Panel2: TPanel;
    rgFiltros: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure dbgContasReceberDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cbFiltroMesesChange(Sender: TObject);
    procedure rgFiltrosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbgContasReceberDblClick(Sender: TObject);
    procedure dbgContasReceberCellClick(Column: TColumn);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    vFDMContas: TFDMemTable;
    classeContasReceber: TContasReceber;

    procedure SQL;
    procedure filtrarContas;
    procedure calcularTotais;
    procedure configurarDataSet;
    procedure formatarValores;
  public
    { Public declarations }
  end;

var
  formContasReceber: TformContasReceber;

implementation

{$R *.dfm}

procedure TformContasReceber.btnConfirmarClick(Sender: TObject);
var
  vModalConfirmacao: TformConfirmarRecebimento;
begin
  try
    with vFDMContas do
    begin
      vModalConfirmacao := TformConfirmarRecebimento.Create(self);
      vModalConfirmacao.idContaReceber := FieldByName('id').AsInteger;
      vModalConfirmacao.lblValorReceber.Caption := FormatCurr('R$ ###,###,##0.00', FieldByName('valor').AsCurrency);
      vModalConfirmacao.ShowModal;
    end;

    SQL;
    filtrarContas;
  finally
    vModalConfirmacao.Destroy;
  end;
end;

procedure TformContasReceber.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir a conta?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
    exit;

  try
    classeContasReceber.idContaReceber := vFDMContas.FieldByName('id').AsInteger;
    classeContasReceber.excluirConta;

    Application.MessageBox('Conta excluída com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);
    SQL;
    filtrarContas;
  except on E: Exception do
    Application.MessageBox(PChar('Erro ao excluir conta! Erro: ' + E.Message), 'Erro', MB_ICONERROR + MB_OK);
  end;
end;

procedure TformContasReceber.calcularTotais;
var
  resultadoTotal: currency;
begin
  with vFDMContas do
  begin
    resultadoTotal := 0;

    First;
    while not Eof do
    begin
      if FieldByName('recebido').AsBoolean = false then
        resultadoTotal := resultadoTotal + FieldByName('valor').AsCurrency;

      Next;
    end;

    lblTotalReceber.Caption := FormatCurr('R$ ###,###,##0.00', resultadoTotal);
  end;
end;

procedure TformContasReceber.cbFiltroMesesChange(Sender: TObject);
begin
  filtrarContas;
  SISDBGridResizeColumns(dbgContasReceber);
end;

procedure TformContasReceber.configurarDataSet;
begin
  with vFDMContas do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('id', ftInteger);
    FieldDefs.Add('id_lote', ftInteger);
    FieldDefs.Add('situacao', ftString, 20);
    FieldDefs.Add('op', ftInteger);
    FieldDefs.Add('descricao', ftString, 50);
    FieldDefs.Add('empresa', ftString, 30);
    FieldDefs.Add('previsao_recebimento', ftDate);
    FieldDefs.Add('data_recebimento', ftString, 20);
    FieldDefs.Add('valor', ftCurrency);
    FieldDefs.Add('recebido', ftBoolean);
    CreateDataSet;
  end;
end;

procedure TformContasReceber.dbgContasReceberCellClick(Column: TColumn);
begin
  with vFDMContas do
  begin
    if FieldByName('recebido').AsBoolean then
    begin
      btnConfirmar.Color := clGrayText;
      btnConfirmar.Enabled := false;
    end;

    if (FieldByName('recebido').AsBoolean = false) and (RecordCount > 0) then
    begin
      btnConfirmar.Color := $0009770E;
      btnConfirmar.Enabled := true;
    end;

    if dbgContasReceber.SelectedRows.Count = 1 then
    begin
      btnDelete.Color := clMaroon;
      btnDelete.Enabled := true;
    end
    else
    begin
      btnDelete.Color := clGrayText;
      btnDelete.Enabled := false;
    end;
  end;
end;

procedure TformContasReceber.dbgContasReceberDblClick(Sender: TObject);
begin
  if (vFDMContas.FieldByName('recebido').AsBoolean = false) and (vFDMContas.RecordCount > 0) then
    btnConfirmarClick(Self);
end;

procedure TformContasReceber.dbgContasReceberDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbgContasReceber, DataSource.DataSet do
  begin
    if (Column.FieldName <> 'situacao') or (RecordCount = 0) then
      exit;

    if Column.FieldName = 'situacao' then
    begin
      Canvas.Font.Style := [fsBold];
      Canvas.Font.Color := clWhite;
      Column.Field.Alignment := taCenter;
    end;

    if FieldByName('recebido').AsBoolean = true then
      Canvas.Brush.Color := clGreen;

    if FieldByName('recebido').AsBoolean = false then
      Canvas.Brush.Color := $005959FF;
  end;

  dbgContasReceber.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TformContasReceber.filtrarContas;
begin
  with vFDMContas do
  begin
    Filtered := false;
    Filter := 'month(previsao_recebimento) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);

    if rgFiltros.ItemIndex = 1 then
      Filter := Filter + ' and recebido = true';
    if rgFiltros.ItemIndex = 2 then
      filter := filter + ' and recebido = false';

    Filtered := true;
  end;

  calcularTotais;

  btnConfirmar.Color := clGrayText;
  btnConfirmar.Enabled := false;

  btnDelete.Color := clGrayText;
  btnDelete.Enabled := false;
end;

procedure TformContasReceber.formatarValores;
begin
  with vFDMContas do
    TFloatField(FieldByName('valor')).DisplayFormat := 'R$ ###,###,##0.00';
end;

procedure TformContasReceber.FormCreate(Sender: TObject);
begin
  classeContasReceber := TContasReceber.Create;
  vFDMContas :=  BDCriarOuRetornarFDMemTable('FDMContasReceber', Self);
  dbgContasReceber.DataSource := BDCriarOuRetornarDataSource('DSContasReceber', Self);
  dbgContasReceber.DataSource.DataSet := vFDMContas;

  configurarDataSet;
  SQL;
  calcularTotais;
  cbFiltroMesesChange(Self);
end;

procedure TformContasReceber.FormShow(Sender: TObject);
begin
  cbFiltroMeses.ItemIndex := MonthOf(Now) - 1;
end;

procedure TformContasReceber.rgFiltrosClick(Sender: TObject);
begin
  filtrarContas;
end;

procedure TformContasReceber.SQL;
begin
  vFDMContas.Close;
  vFDMContas.Data := BDBuscarRegistros('tab_contasreceber tc',
  ' tc.id, tc.id_lote, tc.previsao_recebimento, tc.valor, tc.recebido, t.op, t.descricao, te.nomefantasia empresa, ' +
  ' case when recebido is false then ''A RECEBER'' else ''RECEBIDO'' end::varchar situacao, ' +
  ' case when data_recebimento is null then ''A CONFIRMAR'' else to_char(data_recebimento, ''DD/MM/YYYY'') end::varchar data_recebimento ',
  ' left join tab_lotes t on t.id = tc.id_lote ' +
  ' left join tab_empresas te on te.id = t.id_empresa ',
  EmptyStr, EmptyStr, ' previsao_recebimento ', -1, 'FDQBuscaContasReceber');

  filtrarContas;
  SISDBGridResizeColumns(dbgContasReceber);
  formatarValores;
end;

end.
