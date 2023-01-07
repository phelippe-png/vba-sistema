unit untController;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, untConnection, System.JSON, DataSet.Serialize,
  System.Generics.Collections, FireDAC.DApt, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Stan.Def, FireDAC.Stan.Async, FireDAC.Phys.Intf,
  FireDAC.Stan.Pool, FireDAC.VCLUI.Wait, FireDAC.UI.Intf, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, Horse;

const
  tabela = 'tab_controleproducao_corpo';

type
  TController = class(TConnection)
  private
    query: TFDQuery;
    FIndexConnection: Integer;
  public
    function GetVariantType(const v: variant): string;
    function getDados(tabelaBanco: string): TFDQuery;
    function getByValue(value: Variant; tabelaBanco, coluna, tipoRetorno: string): TJSONValue;
    function setDados(Dados: TJSONObject; tabelaBanco: string): string;
    procedure updateDados(Dados: TJSONObject; id: integer; tabelaBanco, coluna: string);
    procedure deletarDados(id: integer; tabelaBanco, coluna: string);
    function getProducoesRelatorio(where: string): TFDQuery;
    function getContasPagarRelatorio(where: string): TFDQuery;
    function getContasReceberRelatorio(where: string): TFDQuery;
    function getContasReceber(tabelaBanco, where: string): TFDQuery;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

function TController.GetVariantType(const v: variant): string;
begin
  case TVarData(v).vType of
    varEmpty: result := 'Empty';
    varNull: result := 'Null';
    varSmallInt: result := 'SmallInt';
    varInteger: result := 'Integer';
    varSingle: result := 'Single';
    varDouble: result := 'Double';
    varCurrency: result := 'Currency';
    varDate: result := 'Date';
    varOleStr: result := 'OleStr';
    varDispatch: result := 'Dispatch';
    varError: result := 'Error';
    varBoolean: result := 'Boolean';
    varVariant: result := 'Variant';
    varUnknown: result := 'Unknown';
    varByte: result := 'Byte';
    varString: result := 'String';
    varTypeMask: result := 'TypeMask';
    varArray: result := 'Array';
    varByRef: result := 'ByRef';
  end;
end;

constructor TController.Create;
begin
  query := TFDQuery.Create(nil);
  FIndexConnection := Connect;
  query.Connection := ConnectionList.Items[FIndexConnection];

  inherited;
end;

destructor TController.Destroy;
begin
  Disconnect(FIndexConnection);

  inherited;
end;

function TController.getDados(tabelaBanco: string): TFDQuery;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('select * from ' + tabelaBanco);
  query.Open;

  Result := query;
end;

function TController.getByValue(value: Variant; tabelaBanco, coluna, tipoRetorno: string): TJSONValue;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('select * from ' + tabelaBanco + ' where ' + coluna + ' = ' + QuotedStr(value));
  query.Open;

  if tipoRetorno = 'array' then
    result := query.ToJSONArray
  else if tipoRetorno = 'object' then
    result := query.ToJSONObject;
end;

procedure TController.updateDados(Dados: TJSONObject; id: integer; tabelaBanco, coluna: string);
var
  I: integer;
  s: string;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('update ' + tabelaBanco + ' set ');

  for I := 0 to Pred(Dados.Count) do
  begin
    query.SQL.Add(Dados.Get(I).JsonString.Value + ' = ' + QuotedStr(Dados.Get(I).JsonValue.Value));

    if I < Pred(Dados.Count) then
      query.SQL.Add(', ');
  end;

  query.SQL.Text;

  query.SQL.Add(' where ' + coluna + ' = :id');
  query.ParamByName('id').AsInteger := id;
  query.ExecSQL;
end;

function TController.setDados(Dados: TJSONObject; tabelaBanco: string): string;
var
  I: integer;
  jsonValue: TJSONValue;
begin
  jsonValue := TJSONValue.Create;
  jsonValue := Dados.GetValue('id_producao');

  if (tabelaBanco = tabela) and (jsonValue = nil) then
  begin
    query.Close;
    query.SQL.Clear;
    query.SQL.Add('select max(id) id from tab_controleproducao');
    query.Open;

    Dados.AddPair('id_producao', query.FieldByName('id').AsString);
  end;

  query.Close;
  query.SQL.Clear;

  try
    query.SQL.Add('insert into ' + tabelaBanco + ' (');

    for I := 0 to Pred(Dados.Count) do
    begin
      query.SQL.Add(Dados.Get(I).JsonString.Value);

      if I < Pred(Dados.Count) then
        query.SQL.Add(', ');
    end;

    query.SQL.Add(') values (');

    for I := 0 to Pred(Dados.Count) do
    begin
      query.SQL.Add(QuotedStr(Dados.Get(I).JsonValue.Value));

      if I < Pred(Dados.Count) then
        query.SQL.Add(', ');
    end;

    query.SQL.Add(')');
    query.ExecSQL;

  except on E: Exception do
    Result := E.Message;
  end;
end;

procedure TController.deletarDados(id: integer; tabelaBanco, coluna: string);
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('delete from ' + tabelaBanco + ' where ' + coluna + ' = :id');
  query.ParamByName('id').AsInteger := id;
  query.ExecSQL;
end;

function TController.getContasReceber(tabelaBanco, where: string): TFDQuery;
var
  I: Integer;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('select tcr.id, tcr.id_lote, tcr.previsao_recebimento, to_char(tcr.data_recebimento, ''DD/MM/YYYY'') as data_recebimento, tcr.valor, tcr.recebido, tl.op, tl.descricao, tl.empresa from tab_contasreceber tcr ');
  query.SQL.Add('left join tab_lotes tl on tl.id = tcr.id_lote where 1=1 ');
  query.SQL.Add(where);
  query.Open;

  result := query;
end;


//
function TController.getProducoesRelatorio(where: string): TFDQuery;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('select cp.id, cp.id_empresa, to_char(cp.data_inicio, ''DD/MM/YYYY'') as data_inicio, ');
  query.SQL.Add('to_char(cp.data_final, ''DD/MM/YYYY'') as data_final, cp.status, cp.quantidade_total, cp.quantidade_produzir, ');
  query.SQL.Add('cp.valor_total as valor_total_producao, cp.tempo_total as tempo_total_producao, ');
  query.SQL.Add('cpc.id_producao, cpc.id_lote, cpc.finalizado, tl.id, tl.op, tl.descricao, tl.quantidade,  ');
  query.SQL.Add('tl.valor_unit, tl.valor_total, tl.tempo_min, tl.tempo_total, te.nomefantasia, ');
  query.SQL.Add('case when cp.status = ''FINALIZADO'' then ''FINALIZADO'' ');
  query.SQL.Add('when cp.data_final > current_date then ''EM DIA'' ');
  query.SQL.Add('when cp.data_final < current_date then ''ATRASADO'' ');
  query.SQL.Add('when cp.data_final = current_date then ''ATRASARÁ HOJE'' end as situacao, ');
  query.SQL.Add('case when cp.status = ''EM ABERTO'' then ''AGUARDANDO'' ');
  query.SQL.Add('when cpc.finalizado is not true then ''EM PRODUÇÃO'' ');
  query.SQL.Add('when cpc.finalizado is true then ''CONCLUÍDO'' end as status_lote ');
  query.SQL.Add('from tab_controleproducao cp ');
  query.SQL.Add('left join tab_controleproducao_corpo cpc on cpc.id_producao = cp.id ');
  query.SQL.Add('left join tab_lotes tl on tl.id = cpc.id_lote ');
  query.SQL.Add('left join tab_empresas te on te.id = cp.id_empresa where 1=1 ');
  query.SQL.Add(where);
  query.SQL.Add(' order by cp.id ');
  query.Open;

  result := query;
end;

function TController.getContasReceberRelatorio(where: string): TFDQuery;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('select tcr.*, tl.op, tl.descricao, tl.empresa, extract(''month'' from tcr.previsao_recebimento) as mes, ');
  query.SQL.Add('case when recebido = false then ''A RECEBER'' else ''RECEBIDO'' end as situacao, ');
  query.SQL.Add('case when data_recebimento is null then ''A CONFIRMAR'' ');
  query.SQL.Add('when data_recebimento is not null then to_char(data_recebimento, ''DD/MM/YYYY'')::varchar end as data ');
  query.SQL.Add('from tab_contasreceber tcr ');
  query.SQL.Add('left join tab_lotes tl on tl.id = tcr.id_lote where 1=1 ');
  query.SQL.Add(where);
  query.SQL.Add(' order by mes, previsao_recebimento ');
  query.Open;

  result := query;

end;

function TController.getContasPagarRelatorio(where: string): TFDQuery;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Add('select *, to_char(data_venc, ''DD/MM/YYYY'') as data, extract(''month'' From data_venc) as mes, ');
  query.SQL.Add('case when pago = true then ''PAGO'' ');
  query.SQL.Add('when data_venc < current_date then ''VENCIDO'' ');
  query.SQL.Add('when data_venc > current_date then ''EM DIA'' ');
  query.SQL.Add('when data_venc = current_date then ''A VENCER'' end as situacao ');
  query.SQL.Add('from tab_contaspagar where 1=1 ');
  query.SQL.Add(where);
  query.SQL.Add(' order by mes, data_venc');
  query.Open;

  result := query;
end;

end.
