unit untListarContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, untClasseContasPagar, Vcl.ComCtrls, FireDAC.Comp.Client, DataSet.Serialize,
  IdHTTP, functions, System.DateUtils, Datasnap.DBClient, relatorioContasPagar,
  System.JSON, untModalValorPago;

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
    DBGrid: TDBGrid;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbFiltroMesesChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rgFiltroClick(Sender: TObject);
    procedure btnInserirValorClick(Sender: TObject);
    procedure DBGridCellClick(Column: TColumn);
    procedure btnEditClick(Sender: TObject);
    procedure edValorTotalChange(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    classeContasPagar: TContasPagar;
    functions: TFunctions;
    formRelatContasPagar: TformRelatContasPagar;
    bookmark: TBookmark;

    procedure SQL;
    procedure calcularTotais;
    procedure editarTitlesDBGrid;
    procedure filtrarContas;
    procedure inserirSituacao;
    function verificarValorInformado: boolean;
  public
    ClientDataSet: TClientDataSet;
    DataSource: TDataSource;
  end;

var
  formContasPagar: TformContasPagar;

implementation

{$R *.dfm}

procedure TformContasPagar.btnConfirmarClick(Sender: TObject);
begin
  try
    if Application.MessageBox('Deseja confirmar o pagamento?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
      exit;

    classeContasPagar.id := ClientDataSet.FieldByName('id').AsInteger;
    classeContasPagar.valorTotal := StrToCurr(Trim(ClientDataSet.FieldByName('valor_total').AsString).Replace('.', ','));
    classeContasPagar.confirmarPagamento;

    Application.MessageBox('Pagamento confirmado com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);
    SQL;
    calcularTotais;
    functions.redimensionarGrid(DBGrid);
  except on E: Exception do
    Application.MessageBox('Erro ao confirmar pagamento!', 'Erro', MB_ICONERROR + MB_OK);
  end;
end;

procedure TformContasPagar.btnDeleteClick(Sender: TObject);
begin
  try
    if Application.MessageBox('Deseja excluir a conta selecionada?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
      exit;

    classeContasPagar.id := ClientDataSet.FieldByName('id').AsInteger;
    classeContasPagar.excluirConta;

    Application.MessageBox('Conta excluída com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);
    SQL;
    calcularTotais;

    edValorTotal.Enabled := true;
    classeContasPagar.editar := false;
  except
    Application.MessageBox('Erro ao excluir conta!', 'Erro', MB_ICONERROR + MB_OK);
  end;
end;

procedure TformContasPagar.btnEditClick(Sender: TObject);
var
  panel: TPanel;
begin
  edDescricao.Text := ClientDataSet.FieldByName('descricao').AsString;
  edDataVenc.Date := ClientDataSet.FieldByName('data_venc').AsDateTime;
  edValorTotal.Text := ClientDataSet.FieldByName('valor_total').AsString;
  edValorTotal.Enabled := false;

  bookmark := ClientDataSet.Bookmark;

  classeContasPagar.editar := true;
  edValorTotalChange(Self);
end;

procedure TformContasPagar.btnInserirValorClick(Sender: TObject);
var
  modal: TformModal;
  valorTotal, valorPago, totalPagar: currency;
  pago: boolean;
begin
  modal := TformModal.Create(Self);
  modal.valorTotal := ClientDataSet.FieldByName('valor_total').AsCurrency;
  modal.valorPago := ClientDataSet.FieldByName('valor_pago').AsCurrency;
  modal.totalPagar := ClientDataSet.FieldByName('total_pagar').AsCurrency;
  modal.ShowModal;

  if modal.lib then
  begin
    try
      valorPago := ClientDataSet.FieldByName('valor_pago').AsCurrency +
        StrToCurr(Trim(modal.edValor.Text).Replace('.', ''));
      totalPagar := ClientDataSet.FieldByName('valor_total').AsCurrency - valorPago;

      classeContasPagar.id := ClientDataSet.FieldByName('id').AsInteger;
      classeContasPagar.valorPago := valorPago;
      classeContasPagar.totalPagar := totalPagar;
      classeContasPagar.inserirValorPago;

      Application.MessageBox('Valor pago inserido com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);
      SQL;
      calcularTotais;
      functions.redimensionarGrid(DBGrid);
    except on E: Exception do
      Application.MessageBox('Erro ao inserir valor pago!', 'Erro', MB_ICONERROR + MB_OK);
    end;
  end;
end;

procedure TformContasPagar.btnSaveClick(Sender: TObject);
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

    ClientDataSet.Bookmark := bookmark;

    classeContasPagar.id := ClientDataSet.FieldByName('id').AsInteger;
    classeContasPagar.descricao := edDescricao.Text;
    classeContasPagar.dataVenc := edDataVenc.Date;
    classeContasPagar.valorTotal := StrToCurr(Trim(edValorTotal.Text).Replace('.', ''));
    classeContasPagar.totalPagar := StrToCurr(Trim(edValorTotal.Text).Replace('.', ''));
    classeContasPagar.inserirDadosConta;

    if not classeContasPagar.editar then
      Application.MessageBox('Conta inserida com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK)
    else
      Application.MessageBox('Dados atualizados com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);

    SQL;
    calcularTotais;

    edValorTotal.Enabled := true;
    DBGrid.Enabled := true;

    functions.redimensionarGrid(DBGrid);
  except on E: Exception do
    Application.MessageBox('Erro ao cadastrar conta!', 'Erro', MB_ICONERROR + MB_OK);
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

  ClientDataSet.First;
  for I := 0 to Pred(ClientDataSet.RecordCount) do
  begin
//    ClientDataSet.Edit;
//    ClientDataSet.FieldByName('total_pagar').AsCurrency := ClientDataSet.FieldByName('valor_total').AsCurrency -
//    ClientDataSet.FieldByName('valor_pago').AsCurrency;
//    ClientDataSet.Post;

    resultadoValorTotal := resultadoValorTotal + ClientDataSet.FieldByName('valor_total').AsCurrency;
    resultadoValorPago := resultadoValorPago + ClientDataSet.FieldByName('valor_pago').AsCurrency;
    resultadoTotalPagar := resultadoTotalPagar + ClientDataSet.FieldByName('total_pagar').AsCurrency;

    ClientDataSet.Next;
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
  functions.redimensionarGrid(DBGrid);
end;

procedure TformContasPagar.inserirSituacao;
begin
  ClientDataSet.First;

  while not ClientDataSet.Eof do
  begin
    if ClientDataSet.FieldByName('data_venc').AsDateTime > Date then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'EM DIA';
      ClientDataSet.Post;
    end;

    if ClientDataSet.FieldByName('data_venc').AsDateTime < Date then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'VENCIDO';
      ClientDataSet.Post;
    end;

    if ClientDataSet.FieldByName('data_venc').AsDateTime = Date then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'A VENCER';
      ClientDataSet.Post;
    end;

    if ClientDataSet.FieldByName('pago').AsBoolean then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('situacao').AsString := 'PAGO';
      ClientDataSet.Post;
    end;

    ClientDataSet.Next;
  end;
end;

procedure TformContasPagar.DBGridCellClick(Column: TColumn);
begin
  if ClientDataSet.RecordCount = 0 then
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

  if (ClientDataSet.FieldByName('pago').AsBoolean) then
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

  if (DBGrid.SelectedRows.Count = 1) then
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

procedure TformContasPagar.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName <> 'situacao') or (ClientDataSet.RecordCount = 0) then
    exit;

  if Column.FieldName = 'situacao' then
  begin
    Column.Field.Alignment := taCenter;
    DBGrid.Canvas.Font.Style := [fsBold];
    DBGrid.Canvas.Font.Color := clWhite;
  end;

  if DBGrid.DataSource.DataSet.FieldByName('data_venc').AsDateTime < Date then
  begin
    DBGrid.Canvas.Brush.Color := $005959FF;
  end;

  if DBGrid.DataSource.DataSet.FieldByName('data_venc').AsDateTime > Date then
  begin
    DBGrid.Canvas.Brush.Color := $00FF9135;
  end;

  if DBGrid.DataSource.DataSet.FieldByName('data_venc').AsDateTime = Date then
  begin
    DBGrid.Canvas.Brush.Color := clWebOrange;
  end;

  if DBGrid.DataSource.DataSet.FieldByName('pago').AsBoolean = true then
  begin
    DBGrid.Canvas.Brush.Color := clGreen;
  end;

  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TformContasPagar.editarTitlesDBGrid;
begin
  DBGrid.Columns.Items[0].Visible := false;
  DBGrid.Columns.Items[1].Title.Caption := 'Situação';
  DBGrid.Columns.Items[2].Title.Caption := 'Descrição';
  DBGrid.Columns.Items[3].Title.Caption := 'Data de Vencimento';
  DBGrid.Columns.Items[4].Title.Caption := 'Valor Total';
  DBGrid.Columns.Items[5].Title.Caption := 'Valor Pago';
  DBGrid.Columns.Items[6].Title.Caption := 'Total a Pagar';
  DBGrid.Columns.Items[7].Visible := false;
  functions.redimensionarGrid(DBGrid);
end;

procedure TformContasPagar.edValorTotalChange(Sender: TObject);
begin
  functions.SisEditFloatChange(edValorTotal);
end;

procedure TformContasPagar.filtrarContas;
var
  filtro: string;
begin
  DBGrid.DataSource.DataSet.Filtered := false;

  filtro := 'month(data_venc) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);

  if rgFiltro.ItemIndex = 1 then
    filtro := filtro + ' and pago = true';

  if rgFiltro.ItemIndex = 2 then
    filtro := filtro + ' and pago = false';

  DBGrid.DataSource.DataSet.Filter := filtro;
  DBGrid.DataSource.DataSet.Filtered := true;

  inserirSituacao;
  calcularTotais;
end;

procedure TformContasPagar.FormCreate(Sender: TObject);
begin
  classeContasPagar := TContasPagar.Create;
  functions := TFunctions.Create;
  DataSource := TDataSource.Create(self);

  ClientDataSet := TClientDataSet.Create(self);
  ClientDataSet.FieldDefs.Add('id', ftInteger);
  ClientDataSet.FieldDefs.Add('situacao', ftString, 20);
  ClientDataSet.FieldDefs.Add('descricao', ftString, 60);
  ClientDataSet.FieldDefs.Add('data_venc', ftDate);
  ClientDataSet.FieldDefs.Add('valor_total', ftCurrency);
  ClientDataSet.FieldDefs.Add('valor_pago', ftCurrency);
  ClientDataSet.FieldDefs.Add('total_pagar', ftCurrency);
  ClientDataSet.FieldDefs.Add('pago', ftBoolean);
  ClientDataSet.CreateDataSet;

  DataSource.DataSet := ClientDataSet;
  DBGrid.DataSource := DataSource;

  SQL;
  calcularTotais;
  editarTitlesDBGrid;
  inserirSituacao;
end;

procedure TformContasPagar.FormResize(Sender: TObject);
begin
  functions.redimensionarGrid(DBGrid);
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
  functions.redimensionarGrid(DBGrid);
end;

procedure TformContasPagar.SQL;
var
  stream: TStream;
begin
  try
    ClientDataSet.EmptyDataSet;
    stream := TStringStream.Create('tab_contaspagar');

    ClientDataSet.LoadFromJSON(functions.httpRequest(httpGet, 'http://localhost:9000/contaspagar', stream));
    ClientDataSet.IndexFieldNames := 'data_venc';

    cbFiltroMesesChange(Self);
    rgFiltroClick(Self);
  except
    abort;
  end;
end;

function TformContasPagar.verificarValorInformado: boolean;
var
  valorTotal: string;
  valorPago: currency;
begin
  valorTotal := Trim(edValorTotal.Text).Replace('.', '');
  valorPago := ClientDataSet.FieldByName('valor_pago').AsCurrency;

  if (classeContasPagar.editar) and (StrToCurr(valorTotal) < valorPago) then
  begin
    Application.MessageBox('Valor informado maior que o valor pago!', 'Atenção', MB_ICONWARNING + MB_OK);
    result := true;
    exit;
  end;

  result := false;
end;

end.
