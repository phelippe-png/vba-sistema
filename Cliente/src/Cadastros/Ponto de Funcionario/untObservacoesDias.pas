unit untObservacoesDias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCalendars,
  Vcl.ExtCtrls, Vcl.Buttons, untFuncionarios, BancoFuncoes,
  FireDAC.Comp.Client, Data.DB, System.DateUtils, System.Generics.Collections;

type
  TformObservacoesDias = class(TForm)
    btnSave: TPanel;
    btnCancel: TPanel;
    SpeedButton1: TSpeedButton;
    lblFuncionario: TLabel;
    sbxContainerObservacao: TScrollBox;
    cvCalendario: TCalendarView;
    mmObservacao: TMemo;
    Panel1: TPanel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cvCalendarioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cvCalendarioClick(Sender: TObject);
    procedure cvCalendarioDrawDayItem(Sender: TObject;
      DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
    procedure btnSaveClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    vIdFuncionarioSelecionado: Integer;
    vDiaSelecionado: TDate;
    vFDMObservacaoDias, vFDMDiasComPontos: TFDMemTable;
    vStrObservacao: string;

    procedure ConfigurarDataSet;
    procedure ClearMemo;
  public
    { Public declarations }
  end;

var
  formObservacoesDias: TformObservacoesDias;

implementation

{$R *.dfm}

procedure TformObservacoesDias.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TformObservacoesDias.btnSaveClick(Sender: TObject);
var
  vDicDados: TDictionary<String, Variant>;
begin
  if vIdFuncionarioSelecionado = 0 then
  begin
    Application.MessageBox('Não é possível salvar as observações sem selecionar um funcionário!', 'Atenção', MB_ICONWARNING);
    Exit;
  end;

  with vFDMObservacaoDias do
  begin
    First;
    while not Eof do
    begin
      vDicDados := TDictionary<String, Variant>.Create;
      vDicDados.Add('observacao', FieldByName('observacao').AsString);
      BDAtualizarRegistros('tab_pontofuncionario',
      ' id_funcionario = ' + vIdFuncionarioSelecionado.ToString + ' and data = ' + QuotedStr(DateToStr(FieldByName('dia').AsDateTime)), vDicDados);

      Next;
    end;
  end;

  Application.MessageBox('Observações aplicadas com sucesso.', 'Sucesso', MB_ICONINFORMATION);
end;

procedure TformObservacoesDias.ClearMemo;
var
  I: Integer;
begin
  for I := 0 to Pred(mmObservacao.Lines.Count) do
    mmObservacao.Lines.Delete(I);
end;

procedure TformObservacoesDias.ConfigurarDataSet;
begin
  with vFDMObservacaoDias do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('observacao', ftMemo);
    FieldDefs.Add('dia', ftDate);
    CreateDataSet;
  end;

  with vFDMDiasComPontos do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('data', ftDate);
    FieldDefs.Add('mes', ftInteger);
    FieldDefs.Add('ano', ftInteger);
    CreateDataSet;
  end;
end;

procedure TformObservacoesDias.cvCalendarioChange(Sender: TObject);
begin
  if vIdFuncionarioSelecionado = 0 then
  begin
    Application.MessageBox('Selecione um funcionário primeiro antes de aplicar observação!', 'Atenção', MB_ICONWARNING);
    ClearMemo;
    Exit;
  end;

  with vFDMObservacaoDias do
    mmObservacao.Lines.Add(FieldByName('observacao').AsString);
end;

procedure TformObservacoesDias.cvCalendarioClick(Sender: TObject);
begin
  if vIdFuncionarioSelecionado = 0 then
    Exit;

  if (not vFDMDiasComPontos.Locate('mes', MonthOf(vDiaSelecionado), [])) or (not vFDMDiasComPontos.Locate('ano', YearOf(vDiaSelecionado), [])) then
    with BDBuscarRegistros('tab_funcionario f', ' f.nome, p.data ',
    ' left join tab_pontofuncionario p on p.id_funcionario = f.id ',
    ' f.id = ' + vIdFuncionarioSelecionado.ToString +
    ' and extract(''month'' from p.data) = extract(''month'' from '+QuotedStr(DateToStr(vDiaSelecionado))+'::date) ' +
    ' and extract(''year'' from p.data) = extract(''year'' from '+QuotedStr(DateToStr(vDiaSelecionado))+'::date) ',
    EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionarioSelecionado') do
      if RecordCount > 0 then
      begin
        vFDMDiasComPontos.EmptyDataSet;
        while not Eof do
        begin
          vFDMDiasComPontos.Append;
          vFDMDiasComPontos.FieldByName('data').AsDateTime := FieldByName('data').AsDateTime;
          vFDMDiasComPontos.FieldByName('mes').AsInteger := MonthOf(FieldByName('data').AsDateTime);   
          vFDMDiasComPontos.FieldByName('ano').AsInteger := YearOf(FieldByName('data').AsDateTime);       
          vFDMDiasComPontos.Post;
          Next;
        end;
      end;
end;

procedure TformObservacoesDias.cvCalendarioDrawDayItem(Sender: TObject;
  DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
begin
  with vFDMObservacaoDias do
    if (Locate('dia', CalendarViewViewInfo.Date, [])) and (Trim(FieldByName('observacao').AsString) <> EmptyStr) then
      DrawParams.BkColor := $00B3FFB3;

  with vFDMDiasComPontos do
    if (not Locate('data', CalendarViewViewInfo.Date, [])) and (MonthOf(CalendarViewViewInfo.Date) = MonthOf(cvCalendario.Date)) then
      DrawParams.BkColor := $00B3B3FF;
end;

procedure TformObservacoesDias.FormCreate(Sender: TObject);
begin
  vFDMObservacaoDias := TFDMemTable.Create(Self);
  vFDMDiasComPontos := TFDMemTable.Create(Self);
end;

procedure TformObservacoesDias.FormShow(Sender: TObject);
begin
  ConfigurarDataSet;
  vDiaSelecionado := cvCalendario.Date;
end;

procedure TformObservacoesDias.Panel1Click(Sender: TObject);
begin
  with vFDMObservacaoDias do
  begin
    if Locate('dia', cvCalendario.Date) then Edit else Append;
    FieldByName('observacao').AsString := mmObservacao.Lines.Text;
    FieldByName('dia').AsDateTime := cvCalendario.Date;
    Post;
  end;
end;

procedure TformObservacoesDias.SpeedButton1Click(Sender: TObject);
begin
  with TformFuncionarios.Create(Self) do
  begin
    btnSelect.Visible := True;
    WindowState := wsNormal;
    Align := alNone;
    BorderStyle := bsSizeable;
    TelaInModal := True;
    ShowModal;

    if Selecionado then
    begin
      vIdFuncionarioSelecionado := dbgFuncionarios.DataSource.DataSet.FieldByName('id').AsInteger;
      with BDBuscarRegistros('tab_funcionario f', ' f.nome, p.data, p.observacao ',
      ' left join tab_pontofuncionario p on p.id_funcionario = f.id ',
      ' f.id = ' + vIdFuncionarioSelecionado.ToString +
      ' and extract(''month'' from p.data) = extract(''month'' from '+QuotedStr(DateToStr(cvCalendario.Date))+'::date) ' +
      ' and extract(''year'' from p.data) = extract(''year'' from '+QuotedStr(DateToStr(cvCalendario.Date))+'::date) ',
      EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionarioSelecionado') do
        if RecordCount > 0 then
        begin
          lblFuncionario.Caption := FieldByName('nome').AsString;
          while not Eof do
          begin
            vFDMDiasComPontos.Append;
            vFDMDiasComPontos.FieldByName('data').AsDateTime := FieldByName('data').AsDateTime;
            vFDMDiasComPontos.FieldByName('mes').AsInteger := MonthOf(FieldByName('data').AsDateTime);
            vFDMDiasComPontos.FieldByName('ano').AsInteger := YearOf(FieldByName('data').AsDateTime);
            vFDMDiasComPontos.Post;

            vFDMObservacaoDias.Append;
            vFDMObservacaoDias.FieldByName('observacao').AsString := FieldByName('observacao').AsString;
            vFDMObservacaoDias.FieldByName('dia').AsDateTime := FieldByName('data').AsDateTime;
            vFDMObservacaoDias.Post;

            Next;
          end;
        end;
    end;
  end;
end;

end.
