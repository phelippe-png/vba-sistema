unit untProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, untCadastrarProducao, Datasnap.DBClient, IdHTTP, DataSet.Serialize,
  functions, System.JSON, Vcl.Buttons, relatorioControleProducao,
  untClasseProducao, DateUtils, System.Generics.Collections, BancoFuncoes,
  FireDAC.Comp.Client;

type
  TformListarProducoes = class(TForm)
    Panel1: TPanel;
    pnlHeader: TPanel;
    lblTitle: TLabel;
    btnAdd: TPanel;
    pnlContainer: TPanel;
    line: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    Label4: TLabel;
    lblQuantidade: TLabel;
    Label8: TLabel;
    lblValorTotal: TLabel;
    lblTempo: TLabel;
    Label11: TLabel;
    dbgProducao: TDBGrid;
    Panel5: TPanel;
    cbFiltroMesProducao: TComboBox;
    Label15: TLabel;
    btnVisualizar: TPanel;
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgProducaoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Panel5Click(Sender: TObject);
    procedure cbFiltroMesProducaoChange(Sender: TObject);
    procedure btnVisualizarClick(Sender: TObject);
    procedure dbgProducaoDblClick(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    classeProducao: TProducao;
    vFDMProducao: TFDMemTable;

    procedure SQL;
    procedure calcularValores;
    procedure configurarDataSet;
    procedure formatarValores;
  public
    { Public declarations }
  end;

var
  formListarProducoes: TformListarProducoes;

implementation

{$R *.dfm}

procedure TformListarProducoes.btnAddClick(Sender: TObject);
var
  vFormCadastrarProducao: TformCadastrarProducao;
begin
  vFormCadastrarProducao := TformCadastrarProducao.Create(Self);
  try
    vFormCadastrarProducao.ShowModal;
    cbFiltroMesProducao.ItemIndex := MonthOf(vFormCadastrarProducao.pickerInicio.Date) - 1;
    cbFiltroMesProducaoChange(Self);
  finally
    SQL;
    calcularValores;
  end;
end;

procedure TformListarProducoes.calcularValores;
var
  resultadoQuantProduzir: integer;
  resultadoValorTotal: currency;
  resultadoTempoProduzir: double;
  I: Integer;
begin
  resultadoQuantProduzir := 0;
  resultadoValorTotal := 0;
  resultadoTempoProduzir := 0;

  with vFDMProducao do
  begin
    First;
    for I := 0 to RecordCount - 1 do
    begin
      if FieldByName('status').AsString <> 'FINALIZADO' then
      begin
        resultadoQuantProduzir := resultadoQuantProduzir + FieldByName('quantidade_produzir').AsInteger;
        resultadoTempoProduzir := resultadoTempoProduzir + FieldByName('tempo_total').AsFloat;
      end;

      resultadoValorTotal := resultadoValorTotal + FieldByName('valor_total').AsCurrency;

      Next;
    end;
  end;

  lblQuantidade.Caption := resultadoQuantProduzir.ToString;
  lblValorTotal.Caption := FormatCurr('R$ ###,###,##0.00', resultadoValorTotal);
  lblTempo.Caption := FormatFloat('###,###,##0.000', resultadoTempoProduzir);
end;

procedure TformListarProducoes.cbFiltroMesProducaoChange(Sender: TObject);
begin
  with vFDMProducao do
  begin
    Filtered := false;
    Filter := 'month(data_inicio) = ' + IntToStr(cbFiltroMesProducao.ItemIndex + 1);
    Filtered := true;
  end;

  calcularValores;
  SISDBGridResizeColumns(dbgProducao);
end;

procedure TformListarProducoes.configurarDataSet;
begin
  with vFDMProducao do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('situacao', ftString, 100);
    FieldDefs.Add('id', ftInteger);
    FieldDefs.Add('id_empresa', ftInteger);
    FieldDefs.Add('empresa', ftString, 100);
    FieldDefs.Add('data_inicio', ftDate);
    FieldDefs.Add('data_final', ftDate);
    FieldDefs.Add('status', ftString, 50);
    FieldDefs.Add('quantidade_total', ftInteger);
    FieldDefs.Add('quantidade_produzir', ftInteger);
    FieldDefs.Add('valor_total', ftCurrency);
    FieldDefs.Add('tempo_total', ftFloat);
    CreateDataSet;
  end;
end;

procedure TformListarProducoes.dbgProducaoDblClick(Sender: TObject);
begin
  btnVisualizarClick(Self);
end;

procedure TformListarProducoes.dbgProducaoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  bcolor: TColor;
  SCapt: string;
begin
  with dbgProducao, vFDMProducao do
  begin
    if RecordCount = 0 then
      exit;

    if Column.FieldName = 'situacao' then
    begin
      Canvas.Font.Style := [fsBold];
      Canvas.Font.Color := clWhite;
    end;

    if (FieldByName('data_final').AsDateTime > Date) and (Column.FieldName = 'situacao') then
      Canvas.Brush.Color := $00FF9135;

    if (FieldByName('data_final').AsDateTime < Date) and (Column.FieldName = 'situacao') then
      Canvas.Brush.Color := $002D2DFF;

    if (FieldByName('data_final').AsDateTime = Date) and (Column.FieldName = 'situacao') then
      Canvas.Brush.Color := clWebOrange;

    if (FieldByName('status').AsString = 'FINALIZADO') and (Column.FieldName = 'situacao') then
      Canvas.Brush.Color := clGreen;
  end;

  dbgProducao.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TformListarProducoes.formatarValores;
begin
  with vFDMProducao do
  begin
    TFloatField(FieldByName('valor_total')).DisplayFormat := 'R$ ###,###,##0.00';
    TFloatField(FieldByName('tempo_total')).DisplayFormat := '###,###,##0.000';
  end;
end;

procedure TformListarProducoes.FormCreate(Sender: TObject);
begin
  classeProducao := TProducao.Create;
end;

procedure TformListarProducoes.FormShow(Sender: TObject);
begin
  vFDMProducao := BDCriarOuRetornarFDMemTable('FDMProducao', Self);
  dbgProducao.DataSource := BDCriarOuRetornarDataSource('DSProducao', Self);
  dbgProducao.DataSource.DataSet := vFDMProducao;

  configurarDataSet;
  SQL;
  formatarValores;
  calcularValores;
  cbFiltroMesProducaoChange(Self);
end;

procedure TformListarProducoes.btnVisualizarClick(Sender: TObject);
var
  vDicDados: TDictionary<String, Variant>;
  vFormCadastrarProducao: TformCadastrarProducao;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  vFormCadastrarProducao := TformCadastrarProducao.Create(Self);
  with vFDMProducao, vDicDados, vFormCadastrarProducao do
  begin
    try
      if RecordCount = 0 then
        exit;

      Add('id', FieldByName('id').AsString);
      Add('id_empresa', FieldByName('id_empresa').AsString);
      Add('data_inicio', DateToStr(FieldByName('data_inicio').AsDateTime));
      Add('data_final', DateToStr(FieldByName('data_final').AsDateTime));

      vStatus := FieldByName('status').AsString;
      carregarDados(vDicDados);
      ShowModal;
    finally
      vFormCadastrarProducao.Destroy;
      vDicDados := nil;
    end;
  end;

  SQL;
  calcularValores;
end;

procedure TformListarProducoes.Panel2Click(Sender: TObject);
begin
  with vFDMProducao do
  begin
    if RecordCount = 0 then
      exit;

    if Application.MessageBox('Deseja realmente excluir a produção?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_NO then
      exit;

    classeProducao.excluirCorpoProducao(FieldByName('id').AsInteger);
    classeProducao.excluirProducao(FieldByName('id').AsInteger);

    Application.MessageBox('Produção excluida com sucesso.', 'Sucesso', MB_ICONINFORMATION + MB_OK);
  end;

  SQL;
  calcularValores;
end;

procedure TformListarProducoes.Panel5Click(Sender: TObject);
begin
  with vFDMProducao do
  begin
    try
      if RecordCount = 0 then
        exit;

      if FieldByName('status').AsString = 'EM ABERTO' then
      begin
        if Application.MessageBox('Deseja iniciar a produção?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_YES then
        begin
          classeProducao.idProducao := FieldByName('id').AsInteger;
          classeProducao.status := 'EM PRODUÇÃO';
          classeProducao.alterarStatusProducao;
        end;
      end;

      if FieldByName('status').AsString = 'EM PRODUÇÃO' then
      begin
        if Application.MessageBox('ATENÇÃO: Todos os lotes incluídos nessa produção serão finalizados!' + sLineBreak +
          'Deseja realmente finalizar a produção?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = ID_YES then
        begin
          classeProducao.idProducao := FieldByName('id').AsInteger;
          classeProducao.status := 'FINALIZADO';
          classeProducao.alterarStatusProducao;

          with BDBuscarRegistros('tab_controleproducao_corpo', EmptyStr, EmptyStr,
          ' id_producao = ' + FieldByName('id').AsInteger.ToString, EmptyStr, EmptyStr, -1, 'fdqBuscaCorpoProducao') do
          begin
            while not Eof do
            begin
              classeProducao.idCorpoProducao := FieldByName('id').AsInteger;

              with BDBuscarRegistros('tab_lotes', EmptyStr, EmptyStr,
              ' id = ' + FieldByName('id_lote').AsInteger.ToString, EmptyStr, EmptyStr, -1, 'fdqBuscarLote') do
              begin
                classeProducao.idLote := FieldByName('id').AsInteger;
                classeProducao.valorLote := FieldByName('valor_total').AsCurrency;
                classeProducao.enviarDadosContasReceber;
              end;

              Next;
            end;
          end;
        end;
      end;

      SQL;
      calcularValores;
    except
      Application.MessageBox('Erro ao alterar status da produção!', 'Atenção', MB_ICONWARNING + MB_OK);
    end;
  end;
end;

procedure TformListarProducoes.SQL;
begin
  vFDMProducao.Close;
  vFDMProducao.Data := BDBuscarRegistros('tab_controleproducao c',
  ' e.nomefantasia empresa, c.*, ' +
  ' case when c.status = ''FINALIZADO'' then ''FINALIZADO'' ' +
  ' when c.data_final > current_date then ''EM DIA'' ' +
  ' when c.data_final < current_date then ''EM ATRASO'' ' +
  ' when c.data_final = current_date then ''ÚLTIMO DIA'' end::varchar situacao ',
  ' left join tab_empresas e on e.id = c.id_empresa ',
  EmptyStr, EmptyStr, EmptyStr, -1, 'fdqBuscaProducao');

  SISDBGridResizeColumns(dbgProducao);
end;

end.
