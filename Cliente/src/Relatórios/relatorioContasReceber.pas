unit relatorioContasReceber;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.DataSet, RLFilters, RLPDFFilter, DataSet.Serialize,
  BancoFuncoes, functions;

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
    DataSource: TDataSource;
    procedure RLReport1DataRecord(Sender: TObject; RecNo, CopyNo: Integer;
      var Eof: Boolean; var RecordAction: TRLRecordAction);
  private
  public
    procedure imprimirRelatorio(stCondicoes: string);
  end;

var
  formRelatContasReceber: TformRelatContasReceber;

implementation

{$R *.dfm}

{ TformRelatContasReceber }

procedure TformRelatContasReceber.imprimirRelatorio(stCondicoes: string);
begin
  DataSource.DataSet := BDBuscarRegistros('tab_contasreceber tcr',
  ' tcr.*, tl.op, tl.descricao, te.nomefantasia empresa, extract(''month'' from tcr.previsao_recebimento) as mes, ' +
  ' case when recebido = false then ''A RECEBER'' else ''RECEBIDO'' end as situacao, ' +
  ' case when data_recebimento is null then ''A CONFIRMAR'' ' +
  ' when data_recebimento is not null then to_char(data_recebimento, ''DD/MM/YYYY'')::varchar end as data ',
  ' left join tab_lotes tl on tl.id = tcr.id_lote ' +
  ' left join tab_empresas te on te.id = tl.id_empresa ',
  ' 1=1 ' + stCondicoes, EmptyStr, ' mes, previsao_recebimento ', -1, 'FDQRelatorioContasReceber');

  if DataSource.DataSet.RecordCount = 0 then
  begin
    Application.MessageBox('Nenhum registro foi encontrado!', 'Atenção', MB_ICONWARNING);
    exit;
  end;

  RLReport1.Preview;
end;

procedure TformRelatContasReceber.RLReport1DataRecord(Sender: TObject; RecNo,
  CopyNo: Integer; var Eof: Boolean; var RecordAction: TRLRecordAction);
begin
  if DataSource.DataSet.FieldByName('situacao').AsString = 'A RECEBER' then
    rldbSituacao.Font.Color := clRed;

  if DataSource.DataSet.FieldByName('situacao').AsString = 'RECEBIDO' then
    rldbSituacao.Font.Color := clGreen;

  mes.Caption := SisPegarMes(DataSource.DataSet.FieldByName('mes').AsInteger);
end;

end.
