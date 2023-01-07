unit relatorioContasReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.DataSet, RLFilters, RLPDFFilter, DataSet.Serialize;

type
  TformRelatContasReceber = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    rllTitle: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDraw2: TRLDraw;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    RLBand3: TRLBand;
    rldbDescricao: TRLDBText;
    rldbPrevisao: TRLDBText;
    rldbDataReceb: TRLDBText;
    rldbValor: TRLDBText;
    rldbSituacao: TRLDBText;
    RLBand4: TRLBand;
    RLLabel6: TRLLabel;
    mes: TRLLabel;
    RLLabel4: TRLLabel;
    rldbEmpresa: TRLDBText;
    RLLabel8: TRLLabel;
    rldbOP: TRLDBText;
    RLBand7: TRLBand;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLLabel16: TRLLabel;
    RLImage1: TRLImage;
    RLLabel9: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLPDFFilter1: TRLPDFFilter;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    procedure RLReport1DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
  private
    DataSource: TDataSource;
    MemTable: TFDMemTable;

    function imprimirMes(mes: integer): string;
  public
    procedure imprimirRelatorio(dados: string);
  end;

var
  formRelatContasReceber: TformRelatContasReceber;

implementation

{$R *.dfm}

{ TformRelatContasReceber }

function TformRelatContasReceber.imprimirMes(mes: integer): string;
begin
  case mes of
    1:
      result := 'JANEIRO';
    10:
      result := 'OUTUBRO';
    11:
      result := 'NOVEMBRO';
    12:
      result := 'DEZEMBRO';
  end;
end;

procedure TformRelatContasReceber.imprimirRelatorio(dados: string);
begin
  if dados = '[]' then
  begin
    Application.MessageBox('Nada foi encontrado!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  DataSource := TDataSource.Create(nil);
  MemTable := TFDMemTable.Create(nil);

  MemTable.LoadFromJSON(dados);
  DataSource.DataSet := MemTable;

  RLReport1.DataSource := DataSource;

  RLGroup1.DataFields := 'mes';

  rldbSituacao.DataSource := DataSource;
  rldbSituacao.DataField := 'situacao';

  rldbOP.DataSource := DataSource;
  rldbOP.DataField := 'op';

  rldbDescricao.DataSource := DataSource;
  rldbDescricao.DataField := 'descricao';

  rldbEmpresa.DataSource := DataSource;
  rldbEmpresa.DataField := 'empresa';

  rldbPrevisao.DataSource := DataSource;
  rldbPrevisao.DataField := 'previsao_recebimento';

  rldbDataReceb.DataSource := DataSource;
  rldbDataReceb.DataField := 'data';

  rldbValor.DataSource := DataSource;
  rldbValor.DataField := 'valor';

  RLReport1.Preview;
end;

procedure TformRelatContasReceber.RLReport1DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
var
  rlLabel: TRLLabel;
begin
  if DataSource.DataSet.FieldByName('situacao').AsString = 'A RECEBER' then
    rldbSituacao.Font.Color := clRed;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'RECEBIDO' then
    rldbSituacao.Font.Color := clGreen;

  mes.Caption := imprimirMes(DataSource.DataSet.FieldByName('mes').AsInteger);
end;

end.
