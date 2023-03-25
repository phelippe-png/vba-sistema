unit untControlePagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  functions, BancoFuncoes, untFuncionarios, System.JSON, Vcl.WinXCalendars,
  Vcl.ComCtrls, DateUtils;

type
  TformControlePagamentos = class(TForm)
    Label1: TLabel;
    btnProcurarFuncionario: TSpeedButton;
    lblFuncionario: TLabel;
    lblSalario: TLabel;
    btnSave: TPanel;
    btnCancel: TPanel;
    Panel5: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    sbxBeneficios: TScrollBox;
    Label2: TLabel;
    Label3: TLabel;
    edSearch: TEdit;
    Label4: TLabel;
    Memo1: TMemo;
    cvwCalendario: TCalendarView;
    procedure FormShow(Sender: TObject);
    procedure btnProcurarFuncionarioClick(Sender: TObject);
    procedure cvwCalendarioDrawDayItem(Sender: TObject;
      DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure CarregarBeneficios(Count: Integer; strDescricao: string; Valor: Currency);
    procedure LimparBeneficios;
  public
    { Public declarations }
  end;

var
  formControlePagamentos: TformControlePagamentos;

implementation

{$R *.dfm}

procedure TformControlePagamentos.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TformControlePagamentos.btnProcurarFuncionarioClick(Sender: TObject);
var
  vJSONArrBeneficios: TJSONArray;
  I, vCount: Integer;
begin
  with TformFuncionarios.Create(Self) do
  begin
    WindowState := TWindowState.wsNormal;
    BorderStyle := bsSingle;
    Align := alNone;
    btnSelect.Visible := True;
    ShowModal;

    if Selecionado then
      with BDBuscarRegistros('tab_funcionario', EmptyStr, EmptyStr,
      ' id = ' + dbgFuncionarios.DataSource.DataSet.FieldByName('id').AsInteger.ToString,
      EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionario') do
      begin
        lblFuncionario.Caption := 'Funcionário: ' + FieldByName('nome').AsString;
        lblSalario.Caption := 'Salário: ' + FormatCurr('###,###,##0.00', FieldByName('salario').AsCurrency);
        vJSONArrBeneficios := TJSONObject.ParseJSONValue(FieldByName('beneficios').AsString) as TJSONArray;

//        LimparBeneficios;

        vCount := 1;
        for I := 0 to Pred(vJSONArrBeneficios.Count) do
        begin
          CarregarBeneficios(vCount, vJSONArrBeneficios.Get(I).GetValue<string>('description'), vJSONArrBeneficios.Get(I).GetValue<Currency>('value'));
          Inc(vCount);
        end;
      end;
  end;
end;

procedure TformControlePagamentos.FormShow(Sender: TObject);
begin
  btnProcurarFuncionario.Glyph.LoadFromResourceName(HInstance, 'ICOSearch');
end;

procedure TformControlePagamentos.LimparBeneficios;
var
  I: Integer;
begin
  for I := 0 to Pred(sbxBeneficios.ControlCount) do
    sbxBeneficios.Controls[I].Destroy;
end;

procedure TformControlePagamentos.CarregarBeneficios(Count: Integer; strDescricao: string; Valor: Currency);
var
  GPName: string;
  PContainerName: string;
begin
  with TPanel.Create(Self) do
  begin
    Name := 'PContainer_' + Count.ToString;
    PContainerName := Name;
    Parent := sbxBeneficios;
    Align := alBottom;
    Align := alTop;
    Height := 50;
    BevelOuter := bvNone;
    Caption := EmptyStr;
  end;

  //Border
  with TPanel.Create(Self) do
  begin
    Parent := Self.FindComponent(PContainerName) as TPanel;
    Height := 1;
    Align := alBottom;
    Color := $00CFCFCF;
  end;

  with TGridPanel.Create(Self) do
  begin
    ColumnCollection.Clear;
    RowCollection.Clear;
    RowCollection.Add;
    with ColumnCollection.Add do
    begin
      SizeStyle := ssPercent;
      Value := 35;
    end;
    with ColumnCollection.Add do
    begin
      SizeStyle := ssAbsolute;
      Value := 200;
    end;
    with ColumnCollection.Add do
    begin
      SizeStyle := ssPercent;
      Value := 65;
    end;

    Parent := Self.FindComponent(PContainerName) as TPanel;
    Align := alClient;
    BevelOuter := bvNone;
    Name := 'GPBeneficios_' + Count.ToString;
    GPName := Name;
    Caption := EmptyStr;

    //count
    with TLabel.Create(Self) do
    begin
      Name := 'lblCount_' + Count.ToString;
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 15;
      Font.Style := [fsBold];
      Caption := Count.ToString;
      Font.Name := 'Product Sans';
    end;

    //descricão
    with TLabel.Create(Self) do
    begin
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 11;
      Font.Style := [fsBold];
      Caption := strDescricao;
      WordWrap := True;
      Font.Name := 'Product Sans';
    end;

    //valor
    with TLabel.Create(Self) do
    begin
      Parent := Self.FindComponent(GPName) as TGridPanel;
      Font.Size := 9;
      Font.Style := [fsBold];
      Caption := FormatFloat('R$###,###,##0.00', Valor);
      Font.Name := 'Product Sans';
    end;
  end;
end;

procedure TformControlePagamentos.cvwCalendarioDrawDayItem(Sender: TObject;
  DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
begin
  if (DayOf(CalendarViewViewInfo.Date) = 5) and
  (MonthOf(CalendarViewViewInfo.Date) = MonthOf(Now)) then
    DrawParams.BkColor := clRed
end;

end.
