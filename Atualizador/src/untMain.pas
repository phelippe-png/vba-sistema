unit untMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdComponent, Vcl.ComCtrls, Vcl.Buttons,
  IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent, IdAntiFreezeBase,
  IdAntiFreeze, Vcl.StdCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, ShellAPI, Vcl.ExtCtrls, Zip;

const
  url = 'https://api.github.com/repos/phelippe-png/vba-sistema/zipball/main';

type
  TuSistemaPrincipal = class(TForm)
    saveDlg: TSaveDialog;
    btnbaixar: TSpeedButton;
    SpeedButton3: TSpeedButton;
    pbProgresso: TProgressBar;
    lblStatus: TLabel;
    lblPorcentDownload: TLabel;
    IdAntiFreeze1: TIdAntiFreeze;
    HTTP: TIdHTTP;
    Panel1: TPanel;
    Label1: TLabel;
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure btnbaixarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    idSSL: TIdSSLIOHandlerSocketOpenSSL;
    shell: cardinal;
    fileName, fileNameZip: string;

    function RecursiveDelete(FullPath: string): Boolean;
    function RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
    function RetornaKiloBytes(ValorAtual: real): string;
    procedure inicializarHttp;
    procedure descompactar;
  public
    { Public declarations }
  end;

var
  uSistemaPrincipal: TuSistemaPrincipal;

implementation

{$R *.dfm}

procedure TuSistemaPrincipal.inicializarHttp;
begin
  idSSL := TIdSSLIOHandlerSocketOpenSSL.Create(HTTP);

  idSSL.SSLOptions.SSLVersions := [sslvSSLv23];
  HTTP.IOHandler := idSSL;
end;

function TuSistemaPrincipal.RecursiveDelete(FullPath: string): Boolean;
var
  sr: TSearchRec;
  FullName: string;
begin
  Result := True;

  if (FindFirst(FullPath + '\*.*', faAnyFile, sr) = 0) then
  try
    repeat
      FullName := IncludeTrailingPathDelimiter(FullPath) + sr.Name;

      if (sr.Name <> '.') and (sr.Name <> '..') then
      begin
        if ((sr.Attr and faDirectory) = 0) then
          Result := DeleteFile(FullName)
        else
          Result := RecursiveDelete(FullName);
      end;

    until (FindNext(sr) <> 0) or not Result;
  finally
    FindClose(sr);
  end;

  Result := Result and DirectoryExists(FullPath) and RemoveDir(FullPath);
end;

procedure TuSistemaPrincipal.btnbaixarClick(Sender: TObject);
var
  fileDownload: TFileStream;
begin
  btnbaixar.Enabled := false;

  try
    if not FileExists('C:\VBASistema') then
      ForceDirectories('C:\VBASistema');

    RecursiveDelete('C:\VBASistema\vba-sistema');
    DeleteFile('C:\VBASistema\vba-sistema.zip');

    fileDownload := TFileStream.Create('C:\VBASistema\vba-sistema.zip', fmCreate);
    HTTP.HandleRedirects := true;
    HTTP.Get(url, fileDownload);
    fileName := fileDownload.FileName;
  finally
    FreeAndNil(fileDownload);
    descompactar;
  end;
end;

procedure TuSistemaPrincipal.descompactar;
var
  zipFile: TZipFile;
begin
  try
    zipFile := TZipFile.Create;
    zipFile.Open(fileName, zmRead);
    fileNameZip := zipFile.FileName[0];
    zipfile.ExtractZipFile(fileName, 'C:\VBASistema');
  finally
    FreeAndNil(zipFile);
  end;

  RenameFile('C:\VBASistema\' + fileNameZip, 'C:\VBASistema\vba-sistema');

  lblStatus.Caption := 'Finalizado com sucesso.';
  Application.MessageBox('Sistema atualizado com sucesso.', 'Sucesso', MB_ICONINFORMATION);
  btnbaixar.Enabled := true;
end;

procedure TuSistemaPrincipal.FormCreate(Sender: TObject);
begin
  inicializarHttp;
end;

procedure TuSistemaPrincipal.HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  pbProgresso.Position := AWorkCount;
  lblStatus.Caption := 'Baixando: ' + RetornaKiloBytes(AWorkCount);
  lblPorcentDownload.Caption := 'Download em ' + RetornaPorcentagem(pbProgresso.Max, AWorkCount);
end;

procedure TuSistemaPrincipal.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  pbProgresso.Max := AWorkCountMax;
end;

procedure TuSistemaPrincipal.HTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  pbProgresso.Position := 0;
  lblStatus.Caption := 'Descompactando...';
  lblPorcentDownload.Caption := '';
end;

function TuSistemaPrincipal.RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
var
  resultado: Real;
begin
  if (ValorAtual <> 0) and (ValorMaximo <> 0) then
    resultado := ((ValorAtual * 100) / ValorMaximo);

  Result := FormatFloat('0%', resultado);
end;

procedure TuSistemaPrincipal.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

function TuSistemaPrincipal.RetornaKiloBytes(ValorAtual: real): string;
var
  resultado : real;
begin
  resultado := ((ValorAtual / 1024) / 1024);
  Result    := FormatFloat('0.000 KBs', resultado);
end;

end.
