unit untFuncionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, untCadastrarFuncionario, FireDAC.Comp.Client, BancoFuncoes, functions, DM;

type
  TformFuncionarios = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    Panel6: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    btnEdit: TPanel;
    btnAdd: TPanel;
    dbgFuncionarios: TDBGrid;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgFuncionariosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgFuncionariosDblClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
  private
    vFDMFuncionarios: TFDMemTable;

    procedure SQL;
//    procedure ConfigurarDataSet;
  public
    Selecionado, TelaInModal: boolean;
  end;

var
  formFuncionarios: TformFuncionarios;

implementation

{$R *.dfm}


procedure TformFuncionarios.btnAddClick(Sender: TObject);
var
  vFormCadastrarFuncionario: TformCadastrarFuncionario;
begin
  vFormCadastrarFuncionario := TformCadastrarFuncionario.Create(Self);
  vFormCadastrarFuncionario.ShowModal;
end;

procedure TformFuncionarios.btnEditClick(Sender: TObject);
var
  vFormCadastrarFuncionario: TformCadastrarFuncionario;
begin
  if vFDMFuncionarios.RecordCount = 0 then Exit;
  if TelaInModal then
  begin
    btnSelectClick(Self);
    Exit;
  end;

  vFormCadastrarFuncionario := TformCadastrarFuncionario.Create(Self);
  vFormCadastrarFuncionario.CarregarDados(vFDMFuncionarios.FieldByName('id').AsInteger);
  vFormCadastrarFuncionario.ShowModal;

  SQL;
end;

procedure TformFuncionarios.btnSelectClick(Sender: TObject);
begin
  Selecionado := True;
  Close;
end;

procedure TformFuncionarios.dbgFuncionariosDblClick(Sender: TObject);
begin
  btnEditClick(Self);
end;

procedure TformFuncionarios.dbgFuncionariosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if vFDMFuncionarios.RecordCount = 0 then
    Exit;

  with vFDMFuncionarios, dbgFuncionarios do
  begin
    if Column.FieldName = 'status' then
    begin
      Canvas.Font.Color := clWhite;
      Canvas.Font.Style := [fsBold];
    end;

    if not (FieldByName('ativo').AsBoolean) and (Column.FieldName = 'status') then
      Canvas.Brush.Color := $002D2DFF
    else if (FieldByName('ativo').AsBoolean) and (Column.FieldName = 'status') then
      Canvas.Brush.Color := clGreen;
  end;

  dbgFuncionarios.DefaultDrawDataCell(Rect, Column.Field, State);
end;

procedure TformFuncionarios.edSearchChange(Sender: TObject);
begin
  with dbgFuncionarios.DataSource.DataSet do
  begin
    Filtered := False;
    FilterOptions := [foCaseInsensitive];
    Filter := ' nome like '+QuotedStr('%'+Trim(edSearch.Text)+'%') + ' or cpf like '+QuotedStr('%'+Trim(edSearch.Text)+'%');
    Filtered := True;
  end;
end;

procedure TformFuncionarios.FormCreate(Sender: TObject);
begin
  vFDMFuncionarios := BDCriarOuRetornarFDMemTable('FDMFuncionarios', Self);
  dbgFuncionarios.DataSource := BDCriarOuRetornarDataSource('DSFuncionarios', Self);
  dbgFuncionarios.DataSource.DataSet := vFDMFuncionarios;

//  ConfigurarDataSet;
  SQL;
end;

procedure TformFuncionarios.SQL;
begin
  vFDMFuncionarios.Close;
  vFDMFuncionarios.Data := BDBuscarRegistros('tab_funcionario',
  ' *, case when ativo is true then ''ATIVO'' else ''BLOQUEADO'' end::varchar status ',
  EmptyStr, EmptyStr, EmptyStr, ' nome ', -1, 'FDQBuscarFuncionarios');

  TNumericField(vFDMFuncionarios.FieldByName('salario')).DisplayFormat := 'R$ ###,###,##0.00';

  SISDBGridResizeColumns(dbgFuncionarios);
end;

end.
