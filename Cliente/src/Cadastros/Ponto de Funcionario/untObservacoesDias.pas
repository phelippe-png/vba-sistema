unit untObservacoesDias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCalendars,
  Vcl.ExtCtrls, Vcl.Buttons, untFuncionarios, BancoFuncoes,
  FireDAC.Comp.Client, Data.DB, System.DateUtils, System.Generics.Collections,
  functions;

type
  TformObservacoesDias = class(TForm)
    btnSave: TPanel;
    btnCancel: TPanel;
    lblFuncionario: TLabel;
    sbxContainerObservacao: TScrollBox;
    cvCalendario: TCalendarView;
    mmObservacao: TMemo;
    btnSalvarObservacao: TPanel;
    btnBuscarFuncionario: TSpeedButton;
    procedure btnCancelClick(Sender: TObject);
    procedure cvCalendarioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cvCalendarioClick(Sender: TObject);
    procedure cvCalendarioDrawDayItem(Sender: TObject;
      DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSalvarObservacaoClick(Sender: TObject);
    procedure btnBuscarFuncionarioClick(Sender: TObject);
  private
    vIdFuncionarioSelecionado, vAno, vMes: Integer;
    vDiaSelecionado: TDate;
    vFDMObservacaoDias: TFDMemTable;
    vStrObservacao: string;

    procedure ConfigurarDataSet;
  public
    { Public declarations }
  end;

var
  formObservacoesDias: TformObservacoesDias;

implementation

{$R *.dfm}

procedure TformObservacoesDias.btnBuscarFuncionarioClick(Sender: TObject);
begin
  btnBuscarFuncionario.Down := True;

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
      vFDMObservacaoDias.EmptyDataSet;
      vIdFuncionarioSelecionado := dbgFuncionarios.DataSource.DataSet.FieldByName('id').AsInteger;
      lblFuncionario.Caption := dbgFuncionarios.DataSource.DataSet.FieldByName('nome').AsString;
      with BDBuscarRegistros('tab_funcionario f', ' f.nome, p.data, p.observacao ',
      ' left join tab_pontofuncionario p on p.id_funcionario = f.id ',
      ' f.id = ' + vIdFuncionarioSelecionado.ToString +
      ' and extract(''month'' from p.data) = extract(''month'' from '+QuotedStr(DateToStr(cvCalendario.Date))+'::date) ' +
      ' and extract(''year'' from p.data) = extract(''year'' from '+QuotedStr(DateToStr(cvCalendario.Date))+'::date) ',
      EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionarioSelecionado') do
      begin
        while not Eof do
        begin
          vFDMObservacaoDias.Append;
          vFDMObservacaoDias.FieldByName('observacao').AsString := FieldByName('observacao').AsString;
          vFDMObservacaoDias.FieldByName('data').AsDateTime := FieldByName('data').AsDateTime;
          vFDMObservacaoDias.FieldByName('dia').AsInteger := DayOf(FieldByName('data').AsDateTime);
          vFDMObservacaoDias.FieldByName('mes').AsInteger := MonthOf(FieldByName('data').AsDateTime);
          vFDMObservacaoDias.FieldByName('ano').AsInteger := YearOf(FieldByName('data').AsDateTime);
          vFDMObservacaoDias.Post;

          Next;
        end;
      end;
    end;
  end;
end;

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
      ' id_funcionario = ' + vIdFuncionarioSelecionado.ToString + ' and data = ' + QuotedStr(DateToStr(FieldByName('data').AsDateTime)), vDicDados);

      Next;
    end;
  end;

  Application.MessageBox('Observações aplicadas com sucesso.', 'Sucesso', MB_ICONINFORMATION);
  Close;
end;

procedure TformObservacoesDias.ConfigurarDataSet;
begin
  with vFDMObservacaoDias do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('observacao', ftMemo);
    FieldDefs.Add('data', ftDate);
    FieldDefs.Add('dia', ftInteger);
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
    mmObservacao.Lines.Text := EmptyStr;
    Exit;
  end;

  mmObservacao.Lines.Text := EmptyStr;
  if vFDMObservacaoDias.Locate('data', SisTratarDate(DateToStr(cvCalendario.Date))) then
  begin
    mmObservacao.ReadOnly := False;                                                 
    mmObservacao.Color := clWindow;
    btnSalvarObservacao.Enabled := True;
    btnSalvarObservacao.Color := $00C08000;
    mmObservacao.Lines.Add(vFDMObservacaoDias.FieldByName('observacao').AsString);
  end else
  begin
    mmObservacao.ReadOnly := True;
    mmObservacao.Color := $00DADADA;
    btnSalvarObservacao.Enabled := False;
    btnSalvarObservacao.Color := $00A2A2A2;
    mmObservacao.Lines.Text := EmptyStr;
  end;

  cvCalendario.Refresh;
end;

procedure TformObservacoesDias.cvCalendarioClick(Sender: TObject);
begin
  if vIdFuncionarioSelecionado = 0 then
    Exit;

  if (not vFDMObservacaoDias.Locate('mes', MonthOf(SisTratarDate(DateToStr(cvCalendario.Date))), [])) or
     (not vFDMObservacaoDias.Locate('ano', YearOf(SisTratarDate(DateToStr(cvCalendario.Date))), [])) then
  begin
    with BDBuscarRegistros('tab_funcionario f', ' f.nome, p.data, p.observacao ',
    ' left join tab_pontofuncionario p on p.id_funcionario = f.id ',
    ' f.id = ' + vIdFuncionarioSelecionado.ToString +
    ' and extract(''month'' from p.data) = extract(''month'' from '+QuotedStr(DateToStr(SisTratarDate(DateToStr(cvCalendario.Date))))+'::date) ' +
    ' and extract(''year'' from p.data) = extract(''year'' from '+QuotedStr(DateToStr(SisTratarDate(DateToStr(cvCalendario.Date))))+'::date) ',
    EmptyStr, EmptyStr, -1, 'FDQBuscaFuncionarioSelecionado') do
      if RecordCount > 0 then
      begin
//        vFDMObservacaoDias.EmptyDataSet;
        while not Eof do
        begin
          vFDMObservacaoDias.Append;
          vFDMObservacaoDias.FieldByName('observacao').AsString := FieldByName('observacao').AsString;
          vFDMObservacaoDias.FieldByName('data').AsDateTime := FieldByName('data').AsDateTime;
          vFDMObservacaoDias.FieldByName('dia').AsInteger := DayOf(FieldByName('data').AsDateTime);
          vFDMObservacaoDias.FieldByName('mes').AsInteger := MonthOf(FieldByName('data').AsDateTime);   
          vFDMObservacaoDias.FieldByName('ano').AsInteger := YearOf(FieldByName('data').AsDateTime);       
          vFDMObservacaoDias.Post;
          Next;
        end;
      end;
  end;
end;

procedure TformObservacoesDias.cvCalendarioDrawDayItem(Sender: TObject;
  DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
begin
  with vFDMObservacaoDias do
    if (Locate('data', CalendarViewViewInfo.Date, [])) and (Trim(FieldByName('observacao').AsString) <> EmptyStr) then
      DrawParams.BkColor := $00B3FFB3
    else if (not Locate('data', CalendarViewViewInfo.Date, [])) then
      DrawParams.BkColor := $00B3B3FF;
end;

procedure TformObservacoesDias.FormCreate(Sender: TObject);
begin
  vFDMObservacaoDias := TFDMemTable.Create(Self);
end;

procedure TformObservacoesDias.FormShow(Sender: TObject);
begin
  ConfigurarDataSet;
  vDiaSelecionado := cvCalendario.Date;
end;

procedure TformObservacoesDias.btnSalvarObservacaoClick(Sender: TObject);
begin
  with vFDMObservacaoDias do
  begin
    if Locate('data', SisTratarDate(DateToStr(cvCalendario.Date))) then Edit else Append;
    FieldByName('observacao').AsString := Trim(mmObservacao.Lines.Text);
    FieldByName('data').AsDateTime := SisTratarDate(DateToStr(cvCalendario.Date));
    FieldByName('dia').AsInteger := DayOf(cvCalendario.Date);
    FieldByName('mes').AsInteger := MonthOf(cvCalendario.Date);
    FieldByName('ano').AsInteger := YearOf(cvCalendario.Date);
    Post;
  end;

  Refresh;
end;

end.
