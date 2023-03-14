unit functions;

interface

uses
  Vcl.Controls, Winapi.Windows, Winapi.Messages, Vcl.DBGrids, Data.DB, IdHTTP,
  IdSSLOpenSSL, System.Classes, System.SysUtils, Vcl.StdCtrls, Vcl.Forms,
  Vcl.Graphics, System.JSON, System.StrUtils, FireDAC.Comp.Client,
  System.MaskUtils;

type
  tipoFormatacaoEdit = (tpSemFormatacao, tpFormatCpfCnpj, tpFormatCep, tpFormatTelefone);
  methodHttp = (httpGet, httpPost, httpPut, httpDelete);

  TIdHTTPAccess = class(TIdHTTP)
  end;

  TFunctions = class
  private
    http: TIdHTTP;
    stream: TStream;
    SisBoolEdit: boolean;
    tamanhoTextCampoAntigo: integer;
  public
    editar: boolean;

    procedure SisEditFloatChange(campo: TEdit; vNrCasasDecimais : Integer = 2);
    function SisFormatarEdit(edit: TEdit; tipoFormatacao: tipoFormatacaoEdit): string;
    function SisOnlyNumbers(str: string): string;
    function SisCursorIsNumber(edit: TEdit): boolean;
    procedure SisEditKeyPress(edit: TEdit; var Key: Char);

    procedure DrawControl(Control: TWinControl);
    procedure redimensionarGrid(const Grid: TDBGrid; const CoverWhiteSpace: Boolean = True);
    procedure inicializarHttp;
    function httpRequest(method: methodHttp; URL: string; streamRequest: TStream = nil): string overload;
    function buscarDados(value: variant; tabelaBanco, coluna, tipoRetorno, url: string): string;

    function verificarPosicaoCursor(campo: TEdit): boolean;
    constructor Create;
  end;

implementation

procedure TFunctions.SisEditFloatChange(campo: TEdit; vNrCasasDecimais : Integer = 2);
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

function TFunctions.SisFormatarEdit(edit: TEdit; tipoFormatacao: tipoFormatacaoEdit): string;
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

function TFunctions.SisOnlyNumbers(str: string): string;
var
  I: Integer;
begin
  for I := 1 to Length(str) do
    if str[I] in ['0' .. '9'] then
      Result := Result + str[I];
end;

function TFunctions.SisCursorIsNumber(edit: TEdit): boolean;
var
  char: string;
begin
  char := Copy(edit.Text, edit.SelStart, 1);

  if (char <> '') and (char[1] in ['0'..'9']) then
    Result := true else Result := false;
end;

procedure TFunctions.SisEditKeyPress(edit: TEdit; var Key: Char);
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


constructor TFunctions.Create;
begin
  inicializarHttp;
end;

function TFunctions.buscarDados(value: variant; tabelaBanco, coluna, tipoRetorno, url: string): string;
var
  jsonBody: TJSONObject;
  streamRequest: TStream;
begin
  jsonBody := TJSONObject.Create;
  jsonBody.AddPair('value', value);
  jsonBody.AddPair('tabelaBanco', tabelaBanco);
  jsonBody.AddPair('coluna', coluna);
  jsonBody.AddPair('tipoRetorno', tipoRetorno);

  streamRequest := TStringStream.Create(jsonBody.ToJSON);

  result := httpRequest(httpGet, url, streamRequest);
end;

procedure TFunctions.DrawControl(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 5, 5) ;
    Perform(EM_GETRECT, 0, lParam(@r)) ;
    InflateRect(r, - 4, - 4) ;
    Perform(EM_SETRECTNP, 0, lParam(@r)) ;
    SetWindowRgn(Handle, rgn, True) ;
    Invalidate;
  end;
end;

function TFunctions.httpRequest(method: methodHttp; URL: string; streamRequest: TStream = nil): string;
var
  methodHttp: string;
  streamResponse: TStringStream;
begin
  streamResponse := TStringStream.Create;

  try
    if method = httpGet then
      methodHttp := Id_HTTPMethodGet;
    if method = httpPost then
      methodHttp := Id_HTTPMethodPost;
    if method = httpPut then
      methodHttp := Id_HTTPMethodPut;
    if method = httpDelete then
      methodHttp := Id_HTTPMethodDelete;

    TIdHTTPAccess(http).Request.ContentType := 'application/json';
    TIdHTTPAccess(http).DoRequest(methodHttp, URL, streamRequest, streamResponse, []);

    Result := UTF8Decode(streamResponse.DataString);
  except on e: Exception do
    begin
      raise Exception.Create('HTTP ERROR! ' + e.Message);
    end;
  end;
end;

procedure TFunctions.redimensionarGrid(const Grid: TDBGrid; const CoverWhiteSpace: Boolean = True);
const
  C_Add=3;
var
  DS: TDataSet;
  BM: TBookmark;
  I, W, VisibleColumnsCount: Integer;
  A: array of Integer;
  VisibleColumns: array of TColumn;
begin
  DS := Grid.DataSource.DataSet;
  if Assigned(DS) then
  begin
    VisibleColumnsCount := 0;
    SetLength(VisibleColumns, Grid.Columns.Count);

    for I := 0 to Grid.Columns.Count - 1 do
      if Assigned(Grid.Columns[I].Field) and (Grid.Columns[I].Visible) then
      begin
        VisibleColumns[VisibleColumnsCount] := Grid.Columns[I];
        Inc(VisibleColumnsCount);
      end;

    SetLength(VisibleColumns, VisibleColumnsCount);

    DS.DisableControls;
    BM := DS.GetBookmark;
    try
      DS.First;
      SetLength(A, VisibleColumnsCount);

      while not DS.Eof do
      begin
        for I := 0 to VisibleColumnsCount - 1 do
        begin
            W := Grid.Canvas.TextWidth(DS.FieldByName(VisibleColumns[I].Field.FieldName).DisplayText) - 5;
            if A[I] < W then
               A[I] := W;
        end;

        DS.Next;
      end;

      //if fieldwidth is smaller than Row 0 (field names) fix
      for I := 0 to VisibleColumnsCount - 1 do
      begin
        W := Grid.Canvas.TextWidth(VisibleColumns[I].Field.FieldName) - 5;
        if A[I] < W then
           A[I] := W;
      end;

      W := 0;
      if CoverWhiteSpace then
      begin
        for I := 0 to VisibleColumnsCount - 1 do
          Inc(W, A[I]);

        W := (Grid.ClientWidth - W - 5) div VisibleColumnsCount;
        if W < 0 then
          W := 0;
      end;

      for I := 0 to VisibleColumnsCount - 1 do
        VisibleColumns[I].Width := A[I] + W;

      DS.GotoBookmark(BM);
    finally
      DS.FreeBookmark(BM);
      DS.EnableControls;
    end;
  end;
end;

function TFunctions.verificarPosicaoCursor(campo: TEdit): boolean;
begin
  if (Copy(campo.Text, campo.SelStart, 1) = '.') or (Copy(campo.Text, campo.SelStart, 1) = ',') or
  (Copy(campo.Text, campo.SelStart, 1) = '/') or (Copy(campo.Text, campo.SelStart, 1) = '-') then
  begin
    result := true;
  end
  else
    result := false;
end;

procedure TFunctions.inicializarHttp;
var
  idSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  http := TIdHTTP.Create(nil);
  idSSL := TIdSSLIOHandlerSocketOpenSSL.Create(http);

  idSSL.SSLOptions.SSLVersions := [sslvSSLv23];
  http.IOHandler := idSSL;
end;

end.
