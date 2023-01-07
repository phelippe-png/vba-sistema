unit relatorioControleProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, DataSet.Serialize, RLParser,
  Vcl.Imaging.pngimage, RLFilters, RLPDFFilter;

type
  TformRelatControleProducao = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    rllTitle: TRLLabel;
    RLImage1: TRLImage;
    RLGroup1: TRLGroup;
    RLBand3: TRLBand;
    rldbOp: TRLDBText;
    rldbDesc: TRLDBText;
    rldbQuantidade: TRLDBText;
    rldbValorTotalLote: TRLDBText;
    rldbTempoMin: TRLDBText;
    rldbTempoTotal: TRLDBText;
    RLBand4: TRLBand;
    rldbDataInicio: TRLDBText;
    rldbDataFinal: TRLDBText;
    rldbStatus: TRLDBText;
    rldbQuant: TRLDBText;
    rldbQuantProduzir: TRLDBText;
    RLBand5: TRLBand;
    RLDraw1: TRLDraw;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLBand2: TRLBand;
    RLDraw2: TRLDraw;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand7: TRLBand;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    FDQuery1: TFDQuery;
    FDConnection1: TFDConnection;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLBand6: TRLBand;
    RLLabel1: TRLLabel;
    rldbEmpresa: TRLDBText;
    RLLabel18: TRLLabel;
    rldbSituacao: TRLDBText;
    rldbValorTotal: TRLDBText;
    rldbTempoTot: TRLDBText;
    RLPDFFilter1: TRLPDFFilter;
    RLLabel19: TRLLabel;
    rldbStatusLote: TRLDBText;
    RLLabel12: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    procedure RLReport1DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
  private
    MemTable: TFDMemTable;
    DataSource: TDataSource;
  public
    procedure imprimirRelatorio(dados: string);
  end;

var
  formRelatControleProducao: TformRelatControleProducao;

implementation

{$R *.dfm}

procedure TformRelatControleProducao.imprimirRelatorio(dados: string);
begin
  if dados = '[]' then
  begin
    Application.MessageBox('Nada foi encontrado!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  MemTable := TFDMemTable.Create(nil);
  DataSource := TDataSource.Create(nil);

  MemTable.LoadFromJSON(dados);
  DataSource.DataSet := MemTable;

  RLReport1.DataSource := DataSource;

  RLGroup1.DataFields := 'id_producao';

  rldbSituacao.DataSource := DataSource;
  rldbSituacao.DataField := 'situacao';

  //cabeçalho
  rldbValorTotal.DataSource := DataSource;
  rldbValorTotal.DataField := 'valor_total_producao';

  rldbTempoTot.DataSource := DataSource;
  rldbTempoTot.DataField := 'tempo_total_producao';

  rldbEmpresa.DataSource := DataSource;
  rldbEmpresa.DataField := 'nomefantasia';

  rldbDataInicio.DataSource := DataSource;
  rldbDataInicio.DataField := 'data_inicio';

  rldbDataFinal.DataSource := DataSource;
  rldbDataFinal.DataField := 'data_final';

  rldbStatus.DataSource := DataSource;
  rldbStatus.DataField := 'status';

  rldbQuant.DataSource := DataSource;
  rldbQuant.DataField := 'quantidade_total';

  rldbQuantProduzir.DataSource := DataSource;
  rldbQuantProduzir.DataField := 'quantidade_produzir';

  //corpo
  rldbStatusLote.DataSource := DataSource;
  rldbStatusLote.DataField := 'status_lote';

  rldbOp.DataSource := DataSource;
  rldbOp.DataField := 'op';

  rldbDesc.DataSource := DataSource;
  rldbDesc.DataField := 'descricao';

  rldbQuantidade.DataSource := DataSource;
  rldbQuantidade.DataField := 'quantidade';

  rldbValorTotalLote.DataSource := DataSource;
  rldbValorTotalLote.DataField := 'valor_total';

  rldbTempoMin.DataSource := DataSource;
  rldbTempoMin.DataField := 'tempo_min';

  rldbTempoTotal.DataSource := DataSource;
  rldbTempoTotal.DataField := 'tempo_total';

  RLReport1.Preview;
end;

procedure TformRelatControleProducao.RLReport1DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  if DataSource.DataSet.FieldByName('situacao').AsString = 'EM DIA' then
    rldbSituacao.Font.Color := clBlue;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'ATRASADO' then
    rldbSituacao.Font.Color := clRed;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'ATRASARÁ HOJE' then
    rldbSituacao.Font.Color := clWebDarkOrange;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'FINALIZADO' then
    rldbSituacao.Font.Color := clGreen;

  //lote
  if DataSource.DataSet.FieldByName('status_lote').AsString = 'AGUARDANDO' then
    rldbStatusLote.Font.Color := $00FF9A48;

  if DataSource.DataSet.FieldByName('status_lote').AsString = 'EM PRODUÇÃO' then
    rldbStatusLote.Font.Color := $0000A3E8;

  if DataSource.DataSet.FieldByName('status_lote').AsString = 'CONCLUÍDO' then
    rldbStatusLote.Font.Color := clGreen;
end;

end.
