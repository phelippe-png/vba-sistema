unit BancoFuncoes;

interface

uses
  FireDAC.Comp.Client, System.Classes, System.SysUtils, DM, Data.DB,
  System.Generics.Collections, System.Variants, Vcl.Forms, Winapi.Windows;

function BDCriarOuRetornarFDQuery(stNomeQuery: string; Owner: TComponent = nil): TFDQuery;
function BDCriarOuRetornarDataSource(stNomeDS: string; Owner: TComponent = nil): TDataSource;
function BDCriarOuRetornarFDMemTable(stNomeMemTable: string; Owner: TComponent = nil): TFDMemTable;

function BDBuscarRegistros(stTabela, stAtributos, stJoins, stCondicoes, stGroup, stOrder: string; nrLimit: integer; stNomeDataSet: string): TFDQuery;
function BDInserirRegistros(stTabela, stColunaId, stNomeSeq: string; dicDados: TDictionary<string, Variant>; nrColunaId: Integer = 0): Integer;
function BDAtualizarRegistros(stTabela, stCondicoes: string; dicDados: TDictionary<string, Variant>): Boolean;
function BDExcluirRegistro(stTabela, stCondicoes: string): boolean;

implementation

function BDCriarOuRetornarFDQuery(stNomeQuery: string; Owner: TComponent = nil): TFDQuery;
begin
  if Assigned(Owner) then
    Result := Owner.FindComponent(stNomeQuery) as TFDQuery
  else
    Result := SisDataModule.FindComponent(stNomeQuery) as TFDQuery;
      
  if not Assigned(Result) then
  begin
    if Assigned(Owner) then
      Result := TFDQuery.Create(Owner)
    else
      Result := TFDQuery.Create(SisDataModule);

    if stNomeQuery <> EmptyStr then
      Result.Name := stNomeQuery;
    Result.Connection := SisDataModule.fdConnection;
  end;
end;

function BDCriarOuRetornarDataSource(stNomeDS: string; Owner: TComponent = nil): TDataSource;
begin
  if stNomeDS <> EmptyStr then
    if Assigned(Owner) then
      Result := Owner.FindComponent(stNomeDS) as TDataSource
    else
      Result := SisDataModule.FindComponent(stNomeDS) as TDataSource;

  if not Assigned(Result) then
    if Assigned(Owner) then
      Result := TDataSource.Create(Owner)
    else
      Result := TDataSource.Create(SisDataModule);

  if stNomeDS <> EmptyStr then
    Result.Name := stNomeDS;
end;

function BDCriarOuRetornarFDMemTable(stNomeMemTable: string; Owner: TComponent = nil): TFDMemTable;
begin
  if stNomeMemTable <> EmptyStr then
    if Assigned(Owner) then
      Result := Owner.FindComponent(stNomeMemTable) as TFDMemTable
    else
      Result := SisDataModule.FindComponent(stNomeMemTable) as TFDMemTable;

  if not Assigned(Result) then
    if Assigned(Owner) then
      Result := TFDMemTable.Create(Owner)
    else
      Result := TFDMemTable.Create(SisDataModule);

  if stNomeMemTable <> EmptyStr then
    Result.Name := stNomeMemTable;
end;

function BDBuscarRegistros(stTabela, stAtributos, stJoins, stCondicoes, stGroup, stOrder: string; nrLimit: integer; stNomeDataSet: string): TFDQuery;
var
  stSQL: string;
  vFDQuery: TFDQuery;
begin
  Result := BDCriarOuRetornarFDQuery(stNomeDataSet);
//  Result.Connection := SisDataModule.fdConnection;

  stSQL := 'SELECT ';
  if stAtributos = EmptyStr then
    stAtributos := ' * ';
  stSQL := stSQL + stAtributos;
  stSQL := stSQL + ' FROM ' + stTabela + ' ';
  if stJoins <> EmptyStr then
    stSQL := stSQL + stJoins + ' ';
  if stCondicoes <> EmptyStr then
    stSQL := stSQL + ' WHERE ' + stCondicoes;
  if stGroup <> EmptyStr then
    stSQL := stSQL + ' GROUP BY ' + stGroup;
  if stOrder <> EmptyStr then
    stSQL := stSQL + ' ORDER BY ' + stOrder;
  if nrLimit > 0 then
    stSQL := stSQL + ' LIMIT ' + nrLimit.ToString;

  Result.Open(stSQL);
end;

function BDInserirRegistros(stTabela, stColunaId, stNomeSeq: string; dicDados: TDictionary<string, Variant>; nrColunaId: Integer = 0): Integer;
var
  vFDQInsert: TFDQuery;
  I: Integer;
  vArrayDicKeys: TArray<string>;
  stSQL: string;
  vValueInsert: Variant;
begin
  with BDCriarOuRetornarFDQuery(EmptyStr), SQL do
  begin
    Connection := SisDataModule.fdConnection;
    if dicDados.Count > 0 then
    begin
      if nrColunaId = 0 then
      begin
        Close;
        Clear;
        Add('select nextval(' + QuotedStr(stNomeSeq) + ')');
        Open;
        Result := FieldByName('nextval').AsInteger;
      end else
        Result := nrColunaId;

      Close;
      Clear;
      stSQL := 'INSERT INTO ' + stTabela + '(' + stColunaId + ', ';

      vArrayDicKeys := dicDados.Keys.ToArray;
      for I := Low(vArrayDicKeys) to High(vArrayDicKeys) do
      begin
        stSQL := stSQL + vArrayDicKeys[I];
        if I < High(vArrayDicKeys) then
          stSQL := stSQL + ', ';
      end;

      stSQL := stSQL + ') VALUES (' + Result.ToString + ', ';

      for I := Low(vArrayDicKeys) to High(vArrayDicKeys) do
      begin
        vValueInsert := dicDados.Items[vArrayDicKeys[I]];
        case VarType(vValueInsert) of
          varInteger: vValueInsert := IntToStr(dicDados.Items[vArrayDicKeys[I]]);
          varDouble: vValueInsert := FloatToStr(dicDados.Items[vArrayDicKeys[I]]).Replace('.', '').Replace(',', '.');
          varCurrency: vValueInsert := CurrToStr(dicDados.Items[vArrayDicKeys[I]]).Replace('.', '').Replace(',', '.');
          varString: vValueInsert := QuotedStr(dicDados.Items[vArrayDicKeys[I]]);
          varUString: vValueInsert := QuotedStr(dicDados.Items[vArrayDicKeys[I]]);
          varBoolean: vValueInsert := BoolToStr(dicDados.Items[vArrayDicKeys[I]], True);
        end;

        stSQL := stSQL + vValueInsert;
        if I < High(vArrayDicKeys) then
          stSQL := stSQL + ', ';
      end;

      stSQL := stSQL + ')';
      Add(stSQL);
      ExecSQL;
    end
    else
      Application.MessageBox('TDictionary sem dados!', 'Atenção', MB_ICONWARNING);
  end;
end;

function BDAtualizarRegistros(stTabela, stCondicoes: string; dicDados: TDictionary<string, Variant>): Boolean;
var
  I: Integer;
  vArrayDicKeys: TArray<string>;
  vValueUpdate: Variant;
  vSQL: string;
begin
  with BDCriarOuRetornarFDQuery(EmptyStr), SQL do
  begin
    Connection := SisDataModule.fdConnection;

    Close;
    Clear;
    vSQL := 'UPDATE ' + stTabela + ' SET ';

    vArrayDicKeys := dicDados.Keys.ToArray;
    for I := Low(vArrayDicKeys) to High(vArrayDicKeys) do
    begin
      vValueUpdate := dicDados.Items[vArrayDicKeys[I]];
      case VarType(vValueUpdate) of
        varInteger: vValueUpdate := IntToStr(dicDados.Items[vArrayDicKeys[I]]);
        varDouble: vValueUpdate := FloatToStr(dicDados.Items[vArrayDicKeys[I]]).Replace('.', '').Replace(',', '.');
        varCurrency: vValueUpdate := CurrToStr(dicDados.Items[vArrayDicKeys[I]]).Replace('.', '').Replace(',', '.');
        varString: vValueUpdate := QuotedStr(dicDados.Items[vArrayDicKeys[I]]);
        varUString: vValueUpdate := QuotedStr(dicDados.Items[vArrayDicKeys[I]]);
        varBoolean: vValueUpdate := BoolToStr(dicDados.Items[vArrayDicKeys[I]], True);
      end;

      vSQL := vSQL + vArrayDicKeys[I] + ' = ' + vValueUpdate;
      if I < High(vArrayDicKeys) then
        vSQL := vSQL + ', ';
    end;

    vSQL := vSQL + ' WHERE ' + stCondicoes;
    Add(vSQL);
    ExecSQL;
  end;
end;

function BDExcluirRegistro(stTabela, stCondicoes: string): boolean;
begin
  with BDCriarOuRetornarFDQuery(EmptyStr), SQL do
  begin
    Connection := SisDataModule.fdConnection;

    Close;
    Clear;
    Add('DELETE FROM ' + stTabela + ' WHERE ' + stCondicoes);
    ExecSQL;
  end;
end;

end.
