unit functions;

interface

uses
  Vcl.Controls, Winapi.Windows, Winapi.Messages, Vcl.DBGrids, Data.DB, IdHTTP,
  IdSSLOpenSSL, System.Classes, System.SysUtils, Vcl.StdCtrls, Vcl.Forms,
  Vcl.Graphics, System.JSON, System.StrUtils;

type
  method = (get, post, put, delete);

type
  TIdHTTPAccess = class(TIdHTTP)
  end;

type
  TFunctions = class
  private
    http: TIdHTTP;
    stream: TStream;
    bool: boolean;
    boolSel: boolean;
    boolSelSemDesconto: boolean;
    sel: integer;
    tamanhoTextCampoAntigo: integer;
  public
    idSSL: TIdSSLIOHandlerSocketOpenSSL;
    editar: boolean;

    function GetVariantType(const v: variant): string;
    procedure DrawControl(Control: TWinControl);
    procedure redimensionarGrid(const Grid: TDBGrid; const CoverWhiteSpace: Boolean = True);
    procedure inicializarHttp;
    function httpRequest(method: method; URL: string; streamRequest: TStream = nil): string overload;
    function buscarDados(value: variant; tabelaBanco, coluna, tipoRetorno, url: string): string;

    procedure EditCPFChange(campo:TEdit);
    procedure EditCNPJChange(campo: TEdit);
    procedure EditCPFCNPJKeyPress(campo:TEdit; var Key: char);

    procedure EditCepChange(campo:TEdit);
    procedure EditCepKeyPress(campo:TEdit; var Key: char);

    procedure EditFloatChange(campo: TEdit);
    procedure EditFloatChange3(campo: TEdit);
    procedure EditFloatKeyPress(campo: TEdit; var Key: char);

    procedure EditTelefoneChange(campo: TEdit);
    procedure EditTelefoneKeyPress(campo: TEdit; var Key: char);

    function verificarPosicaoCursor(campo: TEdit): boolean;

//    function httpRequest(method: method; URL: string): string overload;
    constructor Create;
  end;

implementation

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

  result := httpRequest(get, url, streamRequest);
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

procedure TFunctions.EditCepChange(campo:TEdit);
var
  text: String;
  textReplaced: string;
  sel: integer;
begin
  sel := campo.SelStart;

  if bool = false then
  begin
    text := campo.Text;
    textReplaced := text.Replace('.', '').Replace('-', '');

    if Length(textReplaced) >= 3 then
      Insert('.', textReplaced, 3);

    if Length(textReplaced) >= 7 then
      Insert('-', textReplaced, 7);

    bool := true;
    campo.Text := textReplaced;
  end;

  if boolSel then
    campo.SelStart := Length(campo.Text)
  else
    campo.SelStart := sel;

  bool := false;
end;

procedure TFunctions.EditCepKeyPress(campo:TEdit; var Key: char);
var
  text: String;
  textReplaced: string;
begin
  verificarPosicaoCursor(campo);

  if (Key = #8) or (campo.SelStart <> Length(campo.Text)) then
    boolSel := false
  else
    boolSel := true;
end;

procedure TFunctions.EditCNPJChange(campo: TEdit);
var
  text: String;
  textReplaced: string;
  sel: integer;
begin
  sel := campo.SelStart ;

  if bool = false then
  begin
    text := campo.Text;
    textReplaced := text.Replace('.', '').Replace('-', '').Replace('/', '');

    if Length(textReplaced) >= 3 then
      Insert('.', textReplaced, 3);

    if Length(textReplaced) >= 7 then
      Insert('.', textReplaced, 7);

    if Length(textReplaced) >= 11 then
      Insert('/', textReplaced, 11);

    if Length(textReplaced) >= 16 then
      Insert('-', textReplaced, 16);

    bool := true;
    campo.Text := textReplaced;
  end;

  if boolSel then
    campo.SelStart := Length(campo.Text)
  else
    campo.SelStart := sel;

  bool := false;
end;

procedure TFunctions.EditCPFChange(campo: TEdit);
var
  text: String;
  textReplaced: string;
  sel: integer;
begin
  sel := campo.SelStart;

  if bool = false then
  begin
    text := campo.Text;
    textReplaced := text.Replace('.', '').Replace('-', '').Replace('/', '');

    if Length(textReplaced) >= 4 then
      Insert('.', textReplaced, 4);

    if Length(textReplaced) >= 8 then
      Insert('.', textReplaced, 8);

    if Length(textReplaced) >= 12 then
      Insert('-', textReplaced, 12);

    bool := true;
    campo.Text := textReplaced;
  end;

  if boolSel then
    campo.SelStart := Length(campo.Text)
  else
    campo.SelStart := sel;

  bool := false;
end;

procedure TFunctions.EditCPFCNPJKeyPress(campo: TEdit; var Key: char);
begin
  verificarPosicaoCursor(campo);

  if (Key = #8) or (campo.SelStart <> Length(campo.Text)) then
    boolSel := false
  else
    boolSel := true;
end;

procedure TFunctions.EditFloatChange(campo: TEdit);
var
  text, textReplaced: string;
begin
  if bool = false then
  begin
    text := campo.Text;
    textReplaced := text.Replace('.', '').Replace(',', '');

    if Length(textReplaced) >= 3 then
    begin
      Insert(',', textReplaced, Length(textReplaced) - 1);
      textReplaced := FormatFloat('###,###,##0.00', StrToCurr(textReplaced));
    end;

    bool := true;
    campo.Text := textReplaced;
  end;
  bool := false;

  if boolSelSemDesconto then
  begin
    campo.SelStart := sel - 1;

    if ((Length(campo.Text) - tamanhoTextCampoAntigo) = -2) then
      campo.SelStart := sel - 2;

    exit;
  end;

  if boolSel then
    campo.SelStart := Length(campo.Text)
  else
  begin
    campo.SelStart := sel + 1;

    if ((Length(campo.Text) - tamanhoTextCampoAntigo) = 2) then
      campo.SelStart := sel + 2;
  end;
end;

procedure TFunctions.EditFloatChange3(campo: TEdit);
var
  text, textReplaced: string;
begin
  if bool = false then
  begin
    text := campo.Text;
    textReplaced := text.Replace('.', '').Replace(',', '');

    if Length(textReplaced) >= 4 then
    begin
      Insert(',', textReplaced, Length(textReplaced) - 2);
      textReplaced := FormatFloat('###,###,##0.000', StrToCurr(textReplaced));
    end;

    bool := true;
    campo.Text := textReplaced;
  end;
  bool := false;

  if boolSelSemDesconto then
  begin
    campo.SelStart := sel - 1;

    if ((Length(campo.Text) - tamanhoTextCampoAntigo) = -2) then
      campo.SelStart := sel - 2;

    exit;
  end;

  if boolSel then
    campo.SelStart := Length(campo.Text)
  else
  begin
    campo.SelStart := sel + 1;

    if ((Length(campo.Text) - tamanhoTextCampoAntigo) = 2) then
      campo.SelStart := sel + 2;
  end;
end;

procedure TFunctions.EditFloatKeyPress(campo: TEdit; var Key: char);
var
  s: integer;
begin
  sel := campo.SelStart;
  tamanhoTextCampoAntigo := Length(campo.Text);

  if verificarPosicaoCursor(campo) and (Key = #8) then
    Key := #0;

  if (Key = #8) then
    boolSelSemDesconto := true
  else
    boolSelSemDesconto := false;

  if (campo.SelStart <> Length(campo.Text)) then
    boolSel := false
  else
    boolSel := true;
end;

//procedure TFunctions.EditFloatKeyPress3(campo: TEdit; var Key: char);
//begin
//  if Length(campo.Text) <= 14 then
//  begin
//    if (campo.SelStart = 3) and (Key = #8) then
//    begin
//      campo.SelStart := 2;
//      Key := #0;
//    end;
//
//    if (campo.SelStart = 7) and (Key = #8) then
//    begin
//      campo.SelStart := 6;
//      Key := #0;
//    end;
//
//    if (campo.SelStart = 11) and (Key = #8) then
//    begin
//      campo.SelStart := 10;
//      Key := #0;
//    end;
//  end;
//
//  if Length(campo.Text) > 14 then
//  begin
//    if (campo.SelStart = 3) and (Key = #8) then
//    begin
//      campo.SelStart := 2;
//      Key := #0;
//    end;
//
//    if (campo.SelStart = 7) and (Key = #8) then
//    begin
//      campo.SelStart := 6;
//      Key := #0;
//    end;
//
//    if (campo.SelStart = 11) and (Key = #8) then
//    begin
//      campo.SelStart := 10;
//      Key := #0;
//    end;
//
//    if (campo.SelStart = 16) and (Key = #8) then
//    begin
//      campo.SelStart := 15;
//      Key := #0;
//    end;
//  end;
//
//  if (Key = #8) or (campo.SelStart <> Length(campo.Text)) then
//    boolSel := false
//  else
//    boolSel := true;
//end;

procedure TFunctions.EditTelefoneChange(campo: TEdit);
var
  text: String;
  textReplaced: string;
  sel: integer;
begin
  sel := campo.SelStart;

  if bool = false then
  begin
    text := campo.Text;
    textReplaced := text.Replace('.', '').Replace('-', '').Replace('(', '').Replace(') ', '');

    if Length(textReplaced) >= 2 then
    begin
      Insert('(', textReplaced, 1);
      Insert(') ', textReplaced, 4);
    end;

    if Length(textReplaced) >= 11 then
      Insert('-', textReplaced, 11);

    bool := true;
    campo.Text := textReplaced;
  end;

  if boolSel then
    campo.SelStart := Length(campo.Text)
  else
    campo.SelStart := sel;

  bool := false;
end;

procedure TFunctions.EditTelefoneKeyPress(campo: TEdit; var Key: char);
var
  sel: integer;
begin
  if ((campo.SelStart = 4) and (Key = #8)) or ((campo.SelStart = 5) and (Key = #8)) then
  begin
    campo.SelStart := 3;
    Key := #0;
    exit;
  end;

  if (campo.SelStart = 1) and (Key = #8) and (Length(campo.Text) >= 5) then
  begin
    campo.SelStart := 0;
    Key := #0;
    exit;
  end;

  if ((campo.SelStart = 2) or (campo.SelStart = 3)) and (Key <> #8)  then
  begin
    campo.SelStart := 5;
    exit;
  end;

  if (Key = #8) or (campo.SelStart <> Length(campo.Text)) then
  begin
    boolSel := false
  end
  else
    boolSel := true;
end;

function TFunctions.httpRequest(method: method; URL: string; streamRequest: TStream = nil): string;
var
  methodHttp: string;
  streamResponse: TStringStream;
begin
  streamResponse := TStringStream.Create;

  try
    if method = get then
      methodHttp := Id_HTTPMethodGet;
    if method = post then
      methodHttp := Id_HTTPMethodPost;
    if method = put then
      methodHttp := Id_HTTPMethodPut;
    if method = delete then
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

function TFunctions.GetVariantType(const v: variant): string;
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
begin
  http := TIdHTTP.Create(nil);
  idSSL := TIdSSLIOHandlerSocketOpenSSL.Create(http);

  idSSL.SSLOptions.SSLVersions := [sslvSSLv23];
  http.IOHandler := idSSL;
end;

end.
