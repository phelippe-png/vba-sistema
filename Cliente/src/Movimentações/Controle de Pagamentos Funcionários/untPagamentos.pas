unit untPagamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, untControlePagamento, BancoFuncoes, functions;

type
  TformPagamentos = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    pnlSearch: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    dbgPagamentos: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure dbgPagamentosDblClick(Sender: TObject);
    procedure dbgPagamentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    vFormPagamento: TformControlePagamentos;

    procedure SQL;
  public

  end;

var
  formPagamentos: TformPagamentos;

implementation

{$R *.dfm}

procedure TformPagamentos.btnSelectClick(Sender: TObject);
begin
  vFormPagamento := TformControlePagamentos.Create(Self);
  with vFormPagamento do
  begin
    vIdFuncionario := dbgPagamentos.DataSource.DataSet.FieldByName('id').AsInteger;
    lblDataOcorrencia.Caption := 'Mês/ano de ocorrência: '+FormatDateTime('mm/yyyy', Now);
    Parent := Self;
    vIsPago := dbgPagamentos.DataSource.DataSet.FieldByName('status').AsBoolean;
    Show;
  end;
end;

procedure TformPagamentos.dbgPagamentosDblClick(Sender: TObject);
begin
  btnSelectClick(Self);
end;

procedure TformPagamentos.dbgPagamentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.FieldName = 'status_descricao' then
  begin
    dbgPagamentos.Canvas.Font.Color := clWhite;
    dbgPagamentos.Canvas.Font.Style := [fsBold];
    if dbgPagamentos.DataSource.DataSet.FieldByName('status').AsBoolean then
      dbgPagamentos.Canvas.Brush.Color := clGreen;
    if not dbgPagamentos.DataSource.DataSet.FieldByName('status').AsBoolean then
      dbgPagamentos.Canvas.Brush.Color := $005959FF;
  end;

  dbgPagamentos.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TformPagamentos.FormCreate(Sender: TObject);
begin
  dbgPagamentos.DataSource := BDCriarOuRetornarDataSource('DSEmpresas', Self);
end;

procedure TformPagamentos.FormShow(Sender: TObject);
begin
  SQL;
end;

procedure TformPagamentos.SQL;
begin
  dbgPagamentos.DataSource.DataSet := BDBuscarRegistros('tab_funcionario f',
  ' f.id, f.nome, f.cpf, f.salario, ' +
  ' case when cp.data_ocorrencia = (extract(''month'' from now())||''/''||extract(''year'' from now())) then to_char(cp.data_pagamento, ''DD/MM/YYYY'') else ''PENDENTE'' end::varchar data_pagamento, ' +
  ' case when cp.data_ocorrencia = (extract(''month'' from now())||''/''||extract(''year'' from now())) then ''PAGO'' else ''AGUARDANDO PAGAMENTO'' end::varchar status_descricao, ' +
  ' case when cp.data_ocorrencia = (extract(''month'' from now())||''/''||extract(''year'' from now())) then true else false end status ',
  ' left join tab_controlepagamento cp on cp.id_funcionario = f.id and cp.data_ocorrencia = (extract(''month'' from now())||''/''||extract(''year'' from now())) ',
  EmptyStr, EmptyStr, EmptyStr, -1, 'FDQBuscaPagamentos');

  SISDBGridResizeColumns(dbgPagamentos);
end;

end.
