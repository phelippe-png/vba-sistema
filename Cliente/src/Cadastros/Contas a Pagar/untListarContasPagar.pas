unit untListarContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, untClasseContasPagar, Vcl.ComCtrls, FireDAC.Comp.Client, DataSet.Serialize,
  IdHTTP, functions, System.DateUtils, Datasnap.DBClient, relatorioContasPagar,
  System.JSON, untModalValorPago, BancoFuncoes;

type
  THackDBGrid = class(TCustomDBGrid)

  end;

  TformContasPagar = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    pnlSearch: TPanel;
    Panel5: TPanel;
    btnDelete: TPanel;
    btnEdit: TPanel;
    btnSave: TPanel;
    Label3: TLabel;
    edDescricao: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    edValorTotal: TEdit;
    edDataVenc: TDateTimePicker;
    Label7: TLabel;
    Label9: TLabel;
    pnlValues: TPanel;
    lblValorTotal: TLabel;
    lblTotalPagar: TLabel;
    Label8: TLabel;
    lblTotalPago: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    cbFiltroMeses: TComboBox;
    Label13: TLabel;
    Panel3: TPanel;
    rgFiltro: TRadioGroup;
    btnInserirValor: TPanel;
    btnConfirmar: TPanel;
    dbgContasPagar: TDBGrid;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbFiltroMesesChange(Sender: TObject);
    procedure dbgContasPagarDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rgFiltroClick(Sender: TObject);
    procedure btnInserirValorClick(Sender: TObject);
    procedure dbgContasPagarCellClick(Column: TColumn);
    procedure btnEditClick(Sender: TObject);
    procedure edValorTotalChange(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    classeContasPagar: TContasPagar;
    formRelatContasPagar: TformRelatContasPagar;
    vBookmark: TBookmark;
    vFDMContas: TFDMemTable;

    procedure SQL;
    procedure calcularTotais;
    procedure filtrarContas;
    procedure formatarValores;
    function verificarValorInformado: boolean;
  public

  end;

var
  formContasPagar: TformContasPagar;

implementation

{$R *.dfm}

procedure TformContasPagar.btnConfirmarClick(Sender: TObject);
begin
  with vFDMContas do
  begin
    try
      if Application.MessageBox('Deseja confirmar o pagamento?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
        exit;

      classeContasPagar.id := FieldByName('id').AsInteger;
      classeContasPagar.valorTotal := StrToCurr(Trim(FieldByName('valor_total').AsString).Replace('.', ','));
      classeContasPagar.confirmarPagamento;

      Application.MessageBox('Pagamento confirmado com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);
      SQL;
      calcularTotais;
      SISDBGridResizeColumns(dbgContasPagar);
    except on E: Exception do
      Application.MessageBox('Erro ao confirmar pagamento!', 'Erro', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TformContasPagar.btnDeleteClick(Sender: TObject);
begin
  with vFDMContas do
  begin
    try
      if Application.MessageBox('Deseja excluir a conta selecionada?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
        exit;

      classeContasPagar.excluirConta(FieldByName('id').AsInteger);
      Application.MessageBox('Conta excluída com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);
      SQL;
      calcularTotais;

      edValorTotal.Enabled := true;
      classeContasPagar.editar := false;
    except
      Application.MessageBox('Erro ao excluir conta!', 'Erro', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TformContasPagar.btnEditClick(Sender: TObject);
var
  panel: TPanel;
begin
  with vFDMContas do
  begin
    edDescricao.Text := FieldByName('descricao').AsString;
    edDataVenc.Date := FieldByName('data_venc').AsDateTime;
    edValorTotal.Text := FieldByName('valor_total').AsString;
    edValorTotal.Enabled := false;

    vBookmark := Bookmark;
  end;

  classeContasPagar.editar := true;
  edValorTotalChange(Self);
end;

procedure TformContasPagar.btnInserirValorClick(Sender: TObject);
var
  modal: TformModal;
  valorTotal, valorPago, totalPagar: currency;
  pago: boolean;
begin
  with vFDMContas do
  begin
    modal := TformModal.Create(Self);
    modal.valorTotal := FieldByName('valor_total').AsCurrency;
    modal.valorPago := FieldByName('valor_pago').AsCurrency;
    modal.totalPagar := FieldByName('total_pagar').AsCurrency;
    modal.ShowModal;

    if modal.lib then
    begin
      try
        valorPago := FieldByName('valor_pago').AsCurrency + StrToCurr(Trim(modal.edValor.Text).Replace('.', ''));
        totalPagar := FieldByName('valor_total').AsCurrency - valorPago;

        classeContasPagar.id := FieldByName('id').AsInteger;
        classeContasPagar.valorPago := valorPago;
        classeContasPagar.totalPagar := totalPagar;
        classeContasPagar.inserirValorPago;

        Application.MessageBox('Valor pago inserido com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);
        SQL;
        calcularTotais;
        SISDBGridResizeColumns(dbgContasPagar);
      except on E: Exception do
        Application.MessageBox('Erro ao inserir valor pago!', 'Erro', MB_ICONERROR + MB_OK);
      end;
    end;
  end;
end;

procedure TformContasPagar.btnSaveClick(Sender: TObject);
begin
  with vFDMContas do
  begin
    try
      if (Trim(edDescricao.Text) = '') or (Trim(edValorTotal.Text) = '') then
      begin
        Application.MessageBox('Preencha os campos necessários!', 'Atenção', MB_ICONWARNING + MB_OK);
        exit;
      end;

      if edDataVenc.Date < now then
      begin
        Application.MessageBox('Data de vencimento menor que a data atual!', 'Atenção', MB_ICONWARNING + MB_OK);
        exit;
      end;

      Bookmark := vBookmark;

      with classeContasPagar do
      begin
        id := FieldByName('id').AsInteger;
        descricao := edDescricao.Text;
        dataVenc := edDataVenc.Date;
        valorTotal := StrToCurr(Trim(edValorTotal.Text).Replace('.', ''));
        totalPagar := StrToCurr(Trim(edValorTotal.Text).Replace('.', ''));
        inserirDadosConta;

        if not editar then
          Application.MessageBox('Conta inserida com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK)
        else
          Application.MessageBox('Dados atualizados com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);
      end;

      cbFiltroMeses.ItemIndex := Pred(MonthOf(edDataVenc.Date));
      SQL;
      calcularTotais;

      edValorTotal.Text := '0.00';
      edDescricao.Text := EmptyStr;
      edDataVenc.Date := Now;
      edValorTotal.Enabled := true;
      dbgContasPagar.Enabled := true;

      SISDBGridResizeColumns(dbgContasPagar);
    except on E: Exception do
      Application.MessageBox(PChar(E.Message), 'Erro', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TformContasPagar.calcularTotais;
var
  resultadoValorTotal, resultadoValorPago, resultadoTotalPagar: currency;
  I: Integer;
begin
  resultadoValorTotal := 0;
  resultadoValorPago := 0;
  resultadoTotalPagar := 0;

  with vFDMContas do
  begin
    First;
    for I := 0 to Pred(RecordCount) do
    begin
  //    ClientDataSet.Edit;
  //    ClientDataSet.FieldByName('total_pagar').AsCurrency := ClientDataSet.FieldByName('valor_total').AsCurrency -
  //    ClientDataSet.FieldByName('valor_pago').AsCurrency;
  //    ClientDataSet.Post;

      resultadoValorTotal := resultadoValorTotal + FieldByName('valor_total').AsCurrency;
      resultadoValorPago := resultadoValorPago + FieldByName('valor_pago').AsCurrency;
      resultadoTotalPagar := resultadoTotalPagar + FieldByName('total_pagar').AsCurrency;

      Next;
    end;
  end;

  lblValorTotal.Caption := FormatCurr('R$ ###,###,##0.00', resultadoValorTotal);
  lblTotalPago.Caption := FormatCurr('R$ ###,###,##0.00', resultadoValorPago);
  lblTotalPagar.Caption := FormatCurr('R$ ###,###,##0.00', resultadoTotalPagar);
end;

procedure TformContasPagar.cbFiltroMesesChange(Sender: TObject);
begin
  btnInserirValor.Enabled := false;
  btnInserirValor.Color := clGrayText;

  btnConfirmar.Enabled := false;
  btnConfirmar.Color := clGrayText;

  btnEdit.Enabled := false;
  btnEdit.Color := clGrayText;

  btnDelete.Enabled := false;
  btnDelete.Color := clGrayText;

  filtrarContas;
  calcularTotais;
  SISDBGridResizeColumns(dbgContasPagar);
end;

procedure TformContasPagar.dbgContasPagarCellClick(Column: TColumn);
begin
  with vFDMContas do
  begin
    if RecordCount = 0 then
    begin
      btnInserirValor.Enabled := false;
      btnInserirValor.Color := clGrayText;

      btnConfirmar.Enabled := false;
      btnConfirmar.Color := clGrayText;

      btnEdit.Enabled := false;
      btnEdit.Color := clGrayText;

      btnDelete.Enabled := false;
      btnDelete.Color := clGrayText;
      exit;
    end;

    if (FieldByName('pago').AsBoolean) then
    begin
      btnInserirValor.Enabled := false;
      btnInserirValor.Color := clGrayText;

      btnConfirmar.Enabled := false;
      btnConfirmar.Color := clGrayText;

      btnEdit.Enabled := false;
      btnEdit.Color := clGrayText;

      btnDelete.Enabled := true;
      btnDelete.Color := clMaroon;

      exit;
    end;

    if (dbgContasPagar.SelectedRows.Count = 1) then
    begin
      btnInserirValor.Enabled := true;
      btnInserirValor.Color := clHighlight;

      btnConfirmar.Enabled := true;
      btnConfirmar.Color := clOlive;

      btnEdit.Enabled := true;
      btnEdit.Color := $00787307;

      btnDelete.Enabled := true;
      btnDelete.Color := clMaroon;
    end
    else
    begin
      btnInserirValor.Enabled := false;
      btnInserirValor.Color := clGrayText;

      btnConfirmar.Enabled := false;
      btnConfirmar.Color := clGrayText;

      btnEdit.Enabled := false;
      btnEdit.Color := clGrayText;

      btnDelete.Enabled := false;
      btnDelete.Color := clGrayText;
    end;
  end;
end;

procedure TformContasPagar.dbgContasPagarDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbgContasPagar, DataSource.DataSet do
  begin
    if (Column.FieldName <> 'situacao') or (RecordCount = 0) then
      exit;

    if Column.FieldName = 'situacao' then
    begin
      Column.Field.Alignment := taCenter;
      Canvas.Font.Style := [fsBold];
      Canvas.Font.Color := clWhite;
    end;

    if FieldByName('data_venc').AsDateTime < Date then
      Canvas.Brush.Color := $005959FF;

    if FieldByName('data_venc').AsDateTime > Date then
      Canvas.Brush.Color := $00FF9135;

    if FieldByName('data_venc').AsDateTime = Date then
      Canvas.Brush.Color := clWebOrange;

    if FieldByName('pago').AsBoolean = true then
      Canvas.Brush.Color := clGreen;
  end;

  dbgContasPagar.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TformContasPagar.edValorTotalChange(Sender: TObject);
begin
  SisEditFloatChange(edValorTotal);
end;

procedure TformContasPagar.filtrarContas;
var
  filtro: string;
begin
  with vFDMContas do
  begin
    Filtered := false;
    Filter := 'month(data_venc) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);

    if rgFiltro.ItemIndex = 1 then
      Filter := Filter + ' and pago = true';

    if rgFiltro.ItemIndex = 2 then
      Filter := Filter + ' and pago = false';

    Filtered := true;

    calcularTotais;
  end;
end;

procedure TformContasPagar.formatarValores;
begin
  with vFDMContas do
  begin
    TFloatField(FieldByName('valor_total')).DisplayFormat := 'R$ ###,###,##0.00';
    TFloatField(FieldByName('valor_pago')).DisplayFormat := 'R$ ###,###,##0.00';
    TFloatField(FieldByName('total_pagar')).DisplayFormat := 'R$ ###,###,##0.00';
  end;
end;

procedure TformContasPagar.FormCreate(Sender: TObject);
begin
  classeContasPagar := TContasPagar.Create;
  vFDMContas := BDCriarOuRetornarFDMemTable('FDMContasPagar');
  dbgContasPagar.DataSource := BDCriarOuRetornarDataSource('DSContasPagar', Self);
  dbgContasPagar.DataSource.DataSet := vFDMContas;

  SQL;
  calcularTotais;
end;

procedure TformContasPagar.FormShow(Sender: TObject);
begin
  edDataVenc.Date := Now;
end;

procedure TformContasPagar.rgFiltroClick(Sender: TObject);
begin
  btnInserirValor.Enabled := false;
  btnInserirValor.Color := clGrayText;

  btnConfirmar.Enabled := false;
  btnConfirmar.Color := clGrayText;

  btnEdit.Enabled := false;
  btnEdit.Color := clGrayText;

  btnDelete.Enabled := false;
  btnDelete.Color := clGrayText;

  filtrarContas;
  calcularTotais;
  SISDBGridResizeColumns(dbgContasPagar);
end;

procedure TformContasPagar.SQL;
begin
  vFDMContas.Close;
  vFDMContas.Data := BDBuscarRegistros('tab_contaspagar',
  ' *, ' +
  ' case when pago is true then ''PAGO'' ' +
  ' when data_venc > current_date then ''EM DIA'' ' +
  ' when data_venc < current_date then ''VENCIDO'' ' +
  ' when data_venc = current_date then ''A VENCER'' end::varchar situacao ', EmptyStr, EmptyStr, EmptyStr,
  ' data_venc ', -1, 'fdqBuscaContasPagar');

  cbFiltroMesesChange(Self);
  rgFiltroClick(Self);
  formatarValores;
end;

function TformContasPagar.verificarValorInformado: boolean;
var
  valorTotal: string;
  valorPago: currency;
begin
  valorTotal := Trim(edValorTotal.Text).Replace('.', '');
  valorPago := vFDMContas.FieldByName('valor_pago').AsCurrency;

  if (classeContasPagar.editar) and (StrToCurr(valorTotal) < valorPago) then
  begin
    Application.MessageBox('Valor informado maior que o valor pago!', 'Atenção', MB_ICONWARNING + MB_OK);
    result := true;
    exit;
  end;

  result := false;
end;

end.
