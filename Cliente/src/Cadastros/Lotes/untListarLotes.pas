unit untListarLotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, IdHTTP, DataSet.Serialize,
  untCadastrarLote, Vcl.ComCtrls, System.JSON, functions, Datasnap.DBClient,
  untClasseLotes, DateUtils, BancoFuncoes, System.Generics.Collections;

type
  TformListarLotes = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    Panel6: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    btnDelete: TPanel;
    btnEdit: TPanel;
    btnAdd: TPanel;
    dbgLotes: TDBGrid;
    cbFiltroMeses: TComboBox;
    Label13: TLabel;
    Label3: TLabel;
    cbFiltro: TComboBox;
    procedure btnAddClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure dbgLotesDblClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cbFiltroMesesChange(Sender: TObject);
    procedure cbFiltroChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    vFDMRegistros: TFDMemTable;
    formCadastrarLote: TformCadastrarLote;
    classeLotes: TLotes;
    dataEntrada: TDate;

    procedure SQL;
    procedure editarDBGrid;
    function loteIncluido: boolean;
    procedure formatarValores;
    procedure configurarDataSet;
  public
    lib: boolean;
    selecionar: boolean;
    notFilter: string;
    esconderColunas: boolean;
  end;

var
  formListarLotes: TformListarLotes;

implementation

{$R *.dfm}

procedure TformListarLotes.edSearchChange(Sender: TObject);
begin
  with vFDMRegistros do
  begin
    FilterOptions := [foCaseInsensitive];
    Filtered := false;

    if cbFiltro.ItemIndex = 0 then
      Filter := 'codigo like ' + QuotedStr('%' + edSearch.Text + '%');
    if cbFiltro.ItemIndex = 1 then
      Filter := 'op like ' + QuotedStr('%' + edSearch.Text + '%');
    if cbFiltro.ItemIndex = 2 then
      Filter := 'descricao like ' + QuotedStr('%' + edSearch.Text + '%');
    if cbFiltro.ItemIndex = 3 then
      Filter := 'empresa like ' + QuotedStr('%' + edSearch.Text + '%');

    Filter := Filter + ' and month(data_entrada) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);
    Filtered := true;
  end;
end;

procedure TformListarLotes.formatarValores;
begin
  with vFDMRegistros do
  begin
    TFloatField(FieldByName('valor_unit')).DisplayFormat := 'R$ ###,###,##0.00';
    TFloatField(FieldByName('valor_total')).DisplayFormat := 'R$ ###,###,##0.00';
    TFloatField(FieldByName('tempo_min')).DisplayFormat := '###,###,##0.000';
    TFloatField(FieldByName('tempo_total')).DisplayFormat := '###,###,##0.000';
  end;
end;

procedure TformListarLotes.editarDBGrid;
begin
  with vFDMRegistros do
  begin
    if esconderColunas then
    begin
      TField(FieldByName('valor_unit')).Visible := false;
      TField(FieldByName('tempo_min')).Visible := false;
      TField(FieldByName('tempo_total')).Visible := false;
    end;
  end;
end;

procedure TformListarLotes.btnAddClick(Sender: TObject);
var
  modalCadastrarLote: TformCadastrarLote;
begin
  modalCadastrarLote := TformCadastrarLote.Create(Self);
  with modalCadastrarLote do
  begin
    ShowModal;
    cbFiltroMeses.ItemIndex := MonthOf(edDataEnt.Date) - 1;
    Destroy;
  end;

  SQL;
end;

procedure TformListarLotes.btnDeleteClick(Sender: TObject);
var
  jsonResponse: TJSONObject;
begin
  with vFDMRegistros, classeLotes do
  begin
    if loteIncluido then
      exit;

    if Application.MessageBox('Deseja realmente excluir o lote selecionado?', 'Confirma��o', MB_ICONQUESTION + MB_YESNO) = ID_YES then
    begin
      excluirLote(FieldByName('id').AsInteger);
      Application.MessageBox('Lote exclu�do com sucesso.', 'Confirma��o', MB_ICONINFORMATION + MB_OK);
      SQL;
    end;
  end;
end;

procedure TformListarLotes.btnEditClick(Sender: TObject);
var
  modalCadastrarLote: TformCadastrarLote;
  vDicDadosLote: TDictionary<String, Variant>;
begin
  try
    with vFDMRegistros do
    begin
      if RecordCount = 0 then
        exit;

      vDicDadosLote := TDictionary<string, Variant>.Create;
      with vDicDadosLote do
      begin
        Add('id_lote', FieldByName('id').AsString);
        Add('id_empresa', FieldByName('id_empresa').AsString);
        Add('codigo', FieldByName('codigo').AsString);
        Add('op', FieldByName('op').AsString);
        Add('descricao', FieldByName('descricao').AsString);
        Add('data_entrada', FieldByName('data_entrada').AsDateTime);
        Add('empresa', FieldByName('empresa').AsString);
        Add('quantidade', FieldByName('quantidade').AsString);
        Add('valor_unit', FieldByName('valor_unit').AsFloat);
        Add('valor_total', FieldByName('valor_total').AsFloat);
        Add('tempo_min', FieldByName('tempo_min').AsFloat);
        Add('tempo_total', FieldByName('tempo_total').AsFloat);
      end;

      modalCadastrarLote := TformCadastrarLote.Create(Self);
      with modalCadastrarLote do
      begin
        carregarDados(vDicDadosLote);
        ShowModal;
        Destroy;
      end;
    end;
  finally
    vDicDadosLote.Destroy;
  end;

  SQL;
end;

procedure TformListarLotes.btnSelectClick(Sender: TObject);
begin
  if dbgLotes.SelectedRows.Count > 0 then
  begin
    lib := true;
    Self.Close;
  end;
end;

procedure TformListarLotes.cbFiltroChange(Sender: TObject);
begin
  edSearch.Text := '';
end;

procedure TformListarLotes.cbFiltroMesesChange(Sender: TObject);
begin
  with vFDMRegistros do
  begin
    Filtered := false;
    Filter := 'month(data_entrada) = ' + IntToStr(cbFiltroMeses.ItemIndex + 1);

    if notFilter <> EmptyStr then
      Filter := Filter + ' and not (id in (' + notFilter + ') )';

    Filtered := true;
  end;

  SISDBGridResizeColumns(dbgLotes);
end;

procedure TformListarLotes.configurarDataSet;
begin
  with vFDMRegistros do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('id', ftInteger);
    FieldDefs.Add('id_empresa', ftInteger);
    FieldDefs.Add('codigo', ftInteger);
    FieldDefs.Add('op', ftInteger);
    FieldDefs.Add('descricao', ftString, 100);
    FieldDefs.Add('empresa', ftString, 100);
    FieldDefs.Add('quantidade', ftInteger);
    FieldDefs.Add('valor_unit', ftCurrency);
    FieldDefs.Add('valor_total', ftCurrency);
    FieldDefs.Add('tempo_min', ftFloat);
    FieldDefs.Add('tempo_total', ftFloat);
    FieldDefs.Add('data_entrada', ftDate);
    FieldDefs.Add('pago', ftBoolean);
    CreateDataSet;
  end;
end;

procedure TformListarLotes.dbgLotesDblClick(Sender: TObject);
begin
  if selecionar then
    btnSelectClick(Self)
  else
    btnEditClick(Self);
end;

procedure TformListarLotes.FormCreate(Sender: TObject);
begin
  classeLotes := TLotes.Create;
  vFDMRegistros := BDCriarOuRetornarFDMemTable('vFDMLotes', Self);
  dbgLotes.DataSource := BDCriarOuRetornarDataSource('dsRegistrosLotes');
  dbgLotes.DataSource.DataSet := vFDMRegistros;

  configurarDataSet;
  SQL;
end;

function TformListarLotes.loteIncluido: boolean;
var
  jsonResponse: TJSONObject;
  responseDados: string;
begin
  //verificar lote na produ��o
  with BDBuscarRegistros('tab_controleproducao_corpo', ' id_lote ', EmptyStr,
  ' id_lote = ' + vFDMRegistros.FieldByName('id').AsInteger.ToString, EmptyStr, EmptyStr, -1, 'fdqBuscaLote') do
  begin
    if RecordCount > 0 then
    begin
      Application.MessageBox('Erro ao excluir o lote selecionado!' + sLineBreak +
        'Esse lote j� se encontra em uma produ��o!', 'Aten��o', MB_ICONWARNING);
      Result := true;
      exit;
    end;
  end;

  //verificar lote no contas a receber
  with BDBuscarRegistros('tab_contasreceber', ' id_lote ', EmptyStr,
  ' id_lote = ' + vFDMRegistros.FieldByName('id').AsInteger.ToString, EmptyStr, EmptyStr, -1, 'fdqBuscaLote') do
  begin
    if RecordCount > 0 then
    begin
      Application.MessageBox('Erro ao excluir o lote selecionado!' + sLineBreak +
      'Esse lote j� est� inclu�do no contas a receber!', 'Aten��o', MB_ICONWARNING);
      Result := true;
      exit;
    end;
  end;

  result := false;
end;

procedure TformListarLotes.SQL;
begin
  try
    vFDMRegistros.Close;
    vFDMRegistros.Data := BDBuscarRegistros('tab_lotes tl', 'tl.*, te.nomefantasia empresa',
    'left join tab_empresas te on te.id = tl.id_empresa', EmptyStr, EmptyStr, EmptyStr, -1, 'fdqBuscaLotes');

    editarDBGrid;
    cbFiltroMesesChange(Self);
    formatarValores;
  except
    abort;
  end;
end;

end.
