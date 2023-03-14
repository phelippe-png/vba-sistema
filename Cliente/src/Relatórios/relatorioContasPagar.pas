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
  RLPDFFilter, RLXLSXFilter, RLXLSFilter, RLHTMLFilter, RLParser, BancoFuncoes, functions;

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
    DataSource: TDataSource;
    procedure RLReport1DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
  private

  public
    procedure imprimirRelatorio(stCondicoes: string);
  end;

var
  formRelatContasPagar: TformRelatContasPagar;

implementation

{$R *.dfm}

procedure TformRelatContasPagar.imprimirRelatorio(stCondicoes: string);
begin
  DataSource.DataSet := BDBuscarRegistros('tab_contaspagar',
  ' *, to_char(data_venc, ''DD/MM/YYYY'') as data, extract(''month'' From data_venc) as mes, ' +
  ' case when pago is true then ''PAGO'' ' +
  ' when data_venc < current_date then ''VENCIDO'' ' +
  ' when data_venc > current_date then ''EM DIA'' ' +
  ' when data_venc = current_date then ''A VENCER'' end as situacao ',
  EmptyStr, ' 1=1 ' + stCondicoes, EmptyStr, ' mes, data_venc ', -1, 'FDQRelatorioContasPagar');

  if DataSource.DataSet.RecordCount = 0 then
  begin
    Application.MessageBox('Nenhum registro encontrado!', 'Atenção', MB_ICONWARNING);
    exit;
  end;

  RLReport1.Preview;
end;

procedure TformRelatContasPagar.RLReport1DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  if DataSource.DataSet.FieldByName('situacao').AsString = 'PAGO' then
    rldbSituacao.Font.Color := clGreen;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'VENCIDO' then
    rldbSituacao.Font.Color := clRed;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'EM DIA' then
    rldbSituacao.Font.Color := $00FF9C24;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'A VENCER' then
    rldbSituacao.Font.Color := clWebDarkOrange;

  mes.Caption := SisPegarMes(DataSource.DataSet.FieldByName('mes').AsInteger);
end;

end.
