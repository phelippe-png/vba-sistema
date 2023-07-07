unit functions;

interface

uses
  Vcl.Controls, Winapi.Windows, Winapi.Messages, Vcl.DBGrids, Data.DB, IdHTTP,
  IdSSLOpenSSL, System.Classes, System.SysUtils, Vcl.StdCtrls, Vcl.Forms,
  Vcl.Graphics, System.JSON, System.StrUtils, FireDAC.Comp.Client,
  System.MaskUtils;

type
  tipoFormatacaoEdit = (tpSemFormatacao, tpFormatCpfCnpj, tpFormatCep, tpFormatTelefone);

var
  http: TIdHTTP;
  stream: TStream;
  SisBoolEdit: boolean;
  tamanhoTextCampoAntigo: integer;

procedure SISDBGridResizeColumns(DBGrid: TDBgrid);
procedure SisEditFloatChange(campo: TEdit; vNrCasasDecimais : Integer = 2);
function SisFormatarEdit(edit: TEdit; tipoFormatacao: tipoFormatacaoEdit): string;
function SisOnlyNumbers(str: string): string;
function SisCursorIsNumber(edit: TEdit): boolean;
procedure SisEditKeyPress(edit: TEdit; var Key: Char);
function SisVerificarPosicaoCursor(campo: TEdit): boolean;
function SisBuscarCEP(stCEP: string): string;
function SisPegarMes(vMes: integer): string;
function SisVarIf(Condicao: Boolean; TrueValue, FalseValue: Variant): Variant overload;
function SisVarEmptyStrDef(StrValue, Default: string): string;
function SisTratarDate(vDate: string): TDateTime;
function validaCPF(CPF: string): boolean;
function validaCNPJ(CNPJ: string): boolean;

//procedure redimensionarGrid(const Grid: TDBGrid; const CoverWhiteSpace: Boolean = True);


implementation

procedure SisEditFloatChange(campo: TEdit; vNrCasasDecimais : Integer = 2);
 var
  s: string;
  v: Extended;
  I: integer;
begin
//   1º Passo : se o edit estiver vazio, nada pode ser feito.
  if campo.Text = emptystr then
  begin
    campo.Text := '0';
    Exit;
  end;

  //   2º Passo : obter o texto do edit, SEM a virgula e SEM o ponto decimal:
  s := '';
  for I := 1 to length(campo.Text) do
    if (campo.Text[I] in ['0' .. '9']) then
      s := s + campo.Text[I];

  //  Validando campo de valor!
  if NOT(TryStrToFloat(s, v)) then
    campo.Text := '0';

  // 3º Passo : fazer com que o conteúdo do edit apresente as casas decimais:
  try
    v := StrToFloat(s);
    v := (v /  StrToInt('1'+StringOfChar('0',vNrCasasDecimais)));
  except on E: Exception do
    raise Exception.Create('Valor digitado incorretamente !'+sLineBreak+e.Message);
  end;
   campo.Text := FormatFloat('###,'+StringOfChar('#',vNrCasasDecimais)+'0.'+StringOfChar('0',vNrCasasDecimais), v);

  campo.SelStart := length(campo.Text);
end;

function SisFormatarEdit(edit: TEdit; tipoFormatacao: tipoFormatacaoEdit): string;
var
  formatText: string;
  sel: integer;
begin
  sel := edit.SelStart;
  formatText := SisOnlyNumbers(edit.Text);

  case tipoFormatacao of
    tpFormatCpfCnpj:
    begin
      if Length(Trim(edit.Text)) > 14 then
        formatText := FormatMaskText('00\.000\.000\/0000\-00;0;', formatText)
      else
        formatText := FormatMaskText('000\.000\.000\-00;0;', formatText);
    end;
    tpFormatCep:
      formatText := FormatMaskText('00\.000\-000;0;', formatText);
    tpFormatTelefone:
      formatText := FormatMaskText('\(00\)00000\-0000;0;', formatText);
  end;

  Delete(formatText, Pos(' ', formatText), Length(formatText));
  edit.Text := formatText;

  if SisBoolEdit then
    edit.SelStart := Length(edit.Text)
  else
    edit.SelStart := sel;
end;

function SisOnlyNumbers(str: string): string;
var
  I: Integer;
begin
  Result := EmptyStr;
  for I := 1 to Length(str) do
    if str[I] in ['0' .. '9'] then
      Result := Result + str[I];
end;

function SisCursorIsNumber(edit: TEdit): boolean;
var
  char: string;
begin
  char := Copy(edit.Text, edit.SelStart, 1);

  if (char <> '') and (char[1] in ['0'..'9']) then
    Result := true else Result := false;
end;

procedure SisEditKeyPress(edit: TEdit; var Key: Char);
begin
  if (Key = #8) or (edit.SelStart <> Length(edit.Text)) then
    SisBoolEdit := false
  else
    SisBoolEdit := true;

  if (not SisCursorIsNumber(edit)) and (Key = #8) then
  begin
    edit.SelStart := edit.SelStart - 1;
    Key := #8;
  end;
end;

procedure SISDBGridResizeColumns(DBGrid: TDBgrid);
var
  vNrRowCount,  vNrRecordPosition, vNrContCol, vNrCellPosition : integer;
  vDsConteudoLinha, vDsMaiorConteudo : string;
begin
  if (DBGrid.Columns.Count = 0) then
    Exit;

  if not Assigned(DBGrid.DataSource) or  not Assigned(DBGrid.DataSource.DataSet) or  not DBGrid.DataSource.DataSet.Active then
    Exit;

  DBGrid.DataSource.DataSet.DisableControls;
  vNrCellPosition := DBGrid.SelectedIndex;
  with DBGrid.DataSource.DataSet do
  begin
    vNrRecordPosition := RecNo;
    vNrRowCount := RecordCount;
    for vNrContCol := 0 to pred(DBGrid.Columns.Count) do
    begin
      if not DBGrid.Columns[vNrContCol].Visible then
        Continue;
      vDsConteudoLinha := EmptyStr;
      vDsMaiorConteudo := DBGrid.Columns[vNrContCol].Title.Caption;
      if RecNo > 200 then
        RecNo := RecNo - 100
      else
        First;
      while RecNo <> Succ(vNrRowCount) do
      begin
        if not Assigned(FindField(DBGrid.Columns[vNrContCol].FieldName)) or (FindField(DBGrid.Columns[vNrContCol].FieldName).FieldName = EmptyStr) then
          Next;

        if DBGrid.Columns[vNrContCol].Field.DataType in [ftCurrency, ftFloat, ftBCD] then
          vDsConteudoLinha := 'R$ '+FormatCurr('###,###,##0.00', FieldByName(DBGrid.Columns[vNrContCol].FieldName).AsCurrency)
        else
          vDsConteudoLinha := FieldByName(DBGrid.Columns[vNrContCol].FieldName).AsString;
        //Mantem o maior conteudo encontrado !
        if Length(vDsMaiorConteudo) < Length(vDsConteudoLinha) then
          vDsMaiorConteudo := vDsConteudoLinha;
        if vNrRowCount = RecNo then
          Break;
        if ClassType = TFDQuery then
          TFDQuery(DBGrid.DataSource.DataSet).Next
        else
          Next;
      end;
      DBGrid.Columns[vNrContCol].Width := DBGrid.Canvas.TextWidth(vDsMaiorConteudo) + 10;
     end;
    DBGrid.SelectedIndex := vNrCellPosition;
    RecNo := vNrRecordPosition;
  end;
  DBGrid.DataSource.DataSet.EnableControls;
  ShowScrollBar(DBGrid.Handle,SB_VERT,True);
end;

//procedure redimensionarGrid(const Grid: TDBGrid; const CoverWhiteSpace: Boolean = True);
//const
//  C_Add=3;
//var
//  DS: TDataSet;
//  BM: TBookmark;
//  I, W, VisibleColumnsCount: Integer;
//  A: array of Integer;
//  VisibleColumns: array of TColumn;
//begin
//  DS := Grid.DataSource.DataSet;
//  if Assigned(DS) then
//  begin
//    VisibleColumnsCount := 0;
//    SetLength(VisibleColumns, Grid.Columns.Count);
//
//    for I := 0 to Grid.Columns.Count - 1 do
//      if Assigned(Grid.Columns[I].Field) and (Grid.Columns[I].Visible) then
//      begin
//        VisibleColumns[VisibleColumnsCount] := Grid.Columns[I];
//        Inc(VisibleColumnsCount);
//      end;
//
//    SetLength(VisibleColumns, VisibleColumnsCount);
//
//    DS.DisableControls;
//    BM := DS.GetBookmark;
//    try
//      DS.First;
//      SetLength(A, VisibleColumnsCount);
//
//      while not DS.Eof do
//      begin
//        for I := 0 to VisibleColumnsCount - 1 do
//        begin
//            W := Grid.Canvas.TextWidth(DS.FieldByName(VisibleColumns[I].Field.FieldName).DisplayText) - 5;
//            if A[I] < W then
//               A[I] := W;
//        end;
//
//        DS.Next;
//      end;
//
//      //if fieldwidth is smaller than Row 0 (field names) fix
//      for I := 0 to VisibleColumnsCount - 1 do
//      begin
//        W := Grid.Canvas.TextWidth(VisibleColumns[I].Field.FieldName) - 5;
//        if A[I] < W then
//           A[I] := W;
//      end;
//
//      W := 0;
//      if CoverWhiteSpace then
//      begin
//        for I := 0 to VisibleColumnsCount - 1 do
//          Inc(W, A[I]);
//
//        W := (Grid.ClientWidth - W - 5) div VisibleColumnsCount;
//        if W < 0 then
//          W := 0;
//      end;
//
//      for I := 0 to VisibleColumnsCount - 1 do
//        VisibleColumns[I].Width := A[I] + W;
//
//      DS.GotoBookmark(BM);
//    finally
//      DS.FreeBookmark(BM);
//      DS.EnableControls;
//    end;
//  end;
//end;

function SisVerificarPosicaoCursor(campo: TEdit): boolean;
begin
  if (Copy(campo.Text, campo.SelStart, 1) = '.') or (Copy(campo.Text, campo.SelStart, 1) = ',') or
  (Copy(campo.Text, campo.SelStart, 1) = '/') or (Copy(campo.Text, campo.SelStart, 1) = '-') then
  begin
    result := true;
  end
  else
    result := false;
end;

function SisBuscarCEP(stCEP: string): string;
var
  IdHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  IdHTTP := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP);

  IdSSL.SSLOptions.SSLVersions := [sslvSSLv23];

  try
    IdHTTP.IOHandler := IdSSL;
    Result := IdHTTP.Get('https://viacep.com.br/ws/' + SisOnlyNumbers(stCEP) + '/json');
  finally
    IdHTTP.Free;
  end;
end;

function SisPegarMes(vMes: integer): string;
begin
  case vMes of
    1:
      result := 'JANEIRO';
    2:
      result := 'FEVEREIRO';
    3:
      result := 'MARÇO';
    4:
      result := 'ABRIL';
    5:
      result := 'MAIO';
    6:
      result := 'JUNHO';
    7:
      result := 'JULHO';
    8:
      result := 'AGOSTO';
    9:
      result := 'SETEMBRO';
    10:
      result := 'OUTUBRO';
    11:
      result := 'NOVEMBRO';
    12:
      result := 'DEZEMBRO';
  end;
end;

function SisVarIf(Condicao: Boolean; TrueValue, FalseValue: Variant): Variant;
begin
  if Condicao then
    Result := TrueValue
  else
    Result := FalseValue;
end;

function SisVarEmptyStrDef(StrValue, Default: string): string;
begin
  if StrValue = EmptyStr then
    Result := Default
  else
    Result := StrValue;
end;

function SisTratarDate(vDate: string): TDateTime;
begin
  Result := StrToDateDef(vDate, StrToDate('01/01/2000'));
end;

function validaCPF(CPF: string): boolean;
var
  digito10, digito11: string;
  s, I, r, peso: integer;
begin
  if ((CPF = '00000000000') or (CPF = '11111111111') or (CPF = '22222222222') or
    (CPF = '33333333333') or (CPF = '44444444444') or (CPF = '55555555555') or
    (CPF = '66666666666') or (CPF = '77777777777') or (CPF = '88888888888') or
    (CPF = '99999999999') or (length(CPF) <> 11)) then
  begin
    result := false;
    exit;
  end;

  try
    // calculo do primeiro dígito
    s := 0;
    peso := 10;

    for I := 1 to 9 do
    begin
      s := s + (StrToInt(CPF[I]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if (r = 10) or (r = 11) then
      digito10 := '0'
    else
      str(r: 1, digito10);

    // calculo do segundo dígito
    s := 0;
    peso := 11;

    for I := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[I]) * peso);
      peso := peso - 1;
    end;

    r := 11 - (s mod 11);

    if (r = 10) or (r = 11) then
      digito11 := '0'
    else
      str(r: 1, digito11);

    // verifica se os digitos calculados conferem com os digitos informados
    if ((digito10 = CPF[10]) and (digito11 = CPF[11])) then
      result := true
    else
      result := false;
  except
    result := false
  end;
end;

function validaCNPJ(CNPJ: string): boolean;
var
  digito13, digito14: string;
  sm, I, r, peso: integer;
begin
  if ((CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
    (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
    (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
    (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
    (CNPJ = '88888888888888') or (CNPJ = '99999999999999') or
    (length(CNPJ) <> 14)) then
  begin
    result := false;
    exit;
  end;

  try
    //calculo do primeiro dígito
    sm := 0;
    peso := 2;

    for I := 12 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[I]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;

    r := sm mod 11;

    if (r = 0) or (r = 1) then
      digito13 := '0'
    else
      str((11 - r): 1, digito13);

    //calculo do segundo dígito
    sm := 0;
    peso := 2;

    for I := 13 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[I]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;

    r := sm mod 11;

    if (r = 0) or (r = 1) then
      digito14 := '0'
    else
      str((11 - r): 1, digito14);

    // verifica se os digitos calculados conferem com os digitos informados
    if ((digito13 = CNPJ[13]) and (digito14 = CNPJ[14])) then
      result := true
    else
      result := false;
  except
    result := false
  end;
end;

end.
