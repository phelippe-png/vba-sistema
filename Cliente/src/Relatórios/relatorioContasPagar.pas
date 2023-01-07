unit relatorioContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.Imaging.pngimage, System.JSON, FireDAC.Comp.Client,
  Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, DataSet.Serialize,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, IdHTTP, RLFilters,
  RLPDFFilter, RLXLSXFilter, RLXLSFilter, RLHTMLFilter, RLParser;

type
  TformRelatContasPagar = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    rllTitle: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDraw2: TRLDraw;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLBand3: TRLBand;
    rldbDescricao: TRLDBText;
    rldbDataVenc: TRLDBText;
    rldbValorTotal: TRLDBText;
    rldbValorPago: TRLDBText;
    rldbTotalPagar: TRLDBText;
    RLBand4: TRLBand;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    rldbSituacao: TRLDBText;
    mes: TRLLabel;
    RLLabel8: TRLLabel;
    RLBand7: TRLBand;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLLabel16: TRLLabel;
    RLImage1: TRLImage;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo1: TRLSystemInfo;
    RLPDFFilter1: TRLPDFFilter;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLExpressionParser1: TRLExpressionParser;
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
  formRelatContasPagar: TformRelatContasPagar;

implementation

{$R *.dfm}

function TformRelatContasPagar.imprimirMes(mes: integer): string;
begin
  case mes of
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

procedure TformRelatContasPagar.imprimirRelatorio(dados: string);
begin
  if dados = '[]' then
    exit;

  DataSource := TDataSource.Create(nil);
  MemTable := TFDMemTable.Create(nil);

  MemTable.LoadFromJSON(dados);
  DataSource.DataSet := MemTable;

  RLReport1.DataSource := DataSource;

  RLGroup1.DataFields := 'mes';

  rldbSituacao.DataSource := DataSource;
  rldbSituacao.DataField := 'situacao';

  rldbDescricao.DataSource := DataSource;
  rldbDescricao.DataField := 'descricao';

  rldbDataVenc.DataSource := DataSource;
  rldbDataVenc.DataField := 'data';

  rldbValorTotal.DataSource := DataSource;
  rldbValorTotal.DataField := 'valor_total';

  rldbValorPago.DataSource := DataSource;
  rldbValorPago.DataField := 'valor_pago';

  rldbTotalPagar.DataSource := DataSource;
  rldbTotalPagar.DataField := 'total_pagar';

  RLReport1.Preview;
end;

procedure TformRelatContasPagar.RLReport1DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
var
  rlLabel: TRLLabel;
begin
  if DataSource.DataSet.FieldByName('situacao').AsString = 'PAGO' then
    rldbSituacao.Font.Color := clGreen;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'VENCIDO' then
    rldbSituacao.Font.Color := clRed;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'EM DIA' then
    rldbSituacao.Font.Color := $00FF9C24;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'A VENCER' then
    rldbSituacao.Font.Color := clWebDarkOrange;

  mes.Caption := imprimirMes(DataSource.DataSet.FieldByName('mes').AsInteger);
end;

end.
