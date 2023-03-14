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
  Vcl.Imaging.pngimage, RLFilters, RLPDFFilter, BancoFuncoes, functions;

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
    DataSource: TDataSource;
    procedure RLReport1DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
  private

  public
    procedure imprimirRelatorio(stCondicoes: string);
  end;

var
  formRelatControleProducao: TformRelatControleProducao;

implementation

{$R *.dfm}

procedure TformRelatControleProducao.imprimirRelatorio(stCondicoes: string);
begin
  DataSource.DataSet := BDBuscarRegistros('tab_controleproducao cp',
  ' cp.id, cp.id_empresa, to_char(cp.data_inicio, ''DD/MM/YYYY'') as data_inicio, ' +
  ' to_char(cp.data_final, ''DD/MM/YYYY'') as data_final, cp.status, cp.quantidade_total, cp.quantidade_produzir, ' +
  ' cp.valor_total as valor_total_producao, cp.tempo_total as tempo_total_producao, ' +
  ' cpc.id_producao, cpc.id_lote, cpc.finalizado, tl.id, tl.op, tl.descricao, tl.quantidade,  ' +
  ' tl.valor_unit, tl.valor_total, tl.tempo_min, tl.tempo_total, te.nomefantasia, ' +
  ' case when cp.status = ''FINALIZADO'' then ''FINALIZADO'' ' +
  ' when cp.data_final > current_date then ''EM DIA'' ' +
  ' when cp.data_final < current_date then ''ATRASADO'' ' +
  ' when cp.data_final = current_date then ''ATRASARÁ HOJE'' end as situacao, ' +
  ' case when cp.status = ''EM ABERTO'' then ''AGUARDANDO'' ' +
  ' when cpc.finalizado is not true then ''EM PRODUÇÃO'' ' +
  ' when cpc.finalizado is true then ''CONCLUÍDO'' end as status_lote ',
  ' left join tab_controleproducao_corpo cpc on cpc.id_producao = cp.id ' +
  ' left join tab_lotes tl on tl.id = cpc.id_lote ' +
  ' left join tab_empresas te on te.id = cp.id_empresa ', ' 1=1 ' + stCondicoes, EmptyStr, ' cp.id ', -1, 'FDQRelatorioControleProducao');

  if DataSource.DataSet.RecordCount = 0 then
  begin
    Application.MessageBox('Nenhum registro foi encontrado!', 'Atenção', MB_ICONWARNING);
    exit;
  end;

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
