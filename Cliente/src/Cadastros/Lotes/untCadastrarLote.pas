unit untCadastrarLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, untClasseLotes, untListarEmpresas, untClasseEmpresas,
  System.JSON, functions, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage, BancoFuncoes,
  System.Generics.Collections;

type
  TformCadastrarLote = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    btnSave: TPanel;
    btnCancel: TPanel;
    Label2: TLabel;
    edCodigo: TEdit;
    Panel1: TPanel;
    edOP: TEdit;
    Label1: TLabel;
    edDescricao: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edDataEnt: TDateTimePicker;
    Label6: TLabel;
    edQuantidade: TEdit;
    Label7: TLabel;
    edValorUnit: TEdit;
    edValorTotal: TEdit;
    Label8: TLabel;
    edTempoMin: TEdit;
    Label9: TLabel;
    edEmpresa: TEdit;
    Label10: TLabel;
    ImageList1: TImageList;
    pnlBtnBuscarEmpresa: TPanel;
    btnBuscarEmpresa: TImage;
    procedure btnSaveMouseEnter(Sender: TObject);
    procedure btnSaveMouseLeave(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edValorUnitChange(Sender: TObject);
    procedure edValorTotalChange(Sender: TObject);
    procedure edTempoMinChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    classeLotes: TLotes;
    classeEmpresas: TEmpresa;
    listarEmpresas: TformListarEmpresas;
    vIdEmpresaSelecionada, vIdLote: integer;
  public
    procedure carregarDados(vDicDados: TDictionary<string, Variant>);
  end;

var
  formCadastrarLote: TformCadastrarLote;

implementation

{$R *.dfm}

procedure TformCadastrarLote.btnCancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformCadastrarLote.btnSaveClick(Sender: TObject);
var
  resultadoTempoTotal: Double;
begin
  if (Trim(edCodigo.Text) = '') or (Trim(edOP.Text) = '') or (Trim(edDescricao.Text) = '') or
  (Trim(edEmpresa.Text) = '') or (Trim(edQuantidade.Text) = '') or (Trim(edTempoMin.Text) = '') or
  (Trim(edValorUnit.Text) = '') or (Trim(edValorTotal.Text) = '') then
  begin
    Application.MessageBox('Preencha os campos vazios!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  with BDBuscarRegistros('tab_lotes', 'op', EmptyStr, ' op = ' + Trim(edOP.Text), EmptyStr, EmptyStr, -1, 'fdqBuscarOP') do
  begin
    if (RecordCount > 0) and (not classeLotes.editar) then
    begin
      Application.MessageBox('Erro ao cadastrar lote!' + sLineBreak +
        'A OP informada já possui cadastro!', 'Atenção', MB_ICONWARNING);
      exit;
    end;
  end;

  resultadoTempoTotal := StrToFloat(Trim(edTempoMin.Text).Replace('.', '')) * StrToInt(edQuantidade.Text);

  with classeLotes do
  begin
    idLote := vIdLote;
    idEmpresa := vIdEmpresaSelecionada;
    codigo := StrToInt(edCodigo.Text);
    OP := StrToInt(edOP.Text);
    descricao := edDescricao.Text;
    empresa := classeEmpresas;
    dataEntrada := edDataEnt.Date;
    quantidade := StrToInt(edQuantidade.Text);
    valorUnit := StrToCurr(Trim(edValorUnit.Text).Replace('.', ''));
    valorTotal := StrToCurr(Trim(edValorTotal.Text).Replace('.', ''));
    tempoMin := StrToFloat(Trim(edTempoMin.Text).Replace('.', ''));
    tempoTotal := resultadoTempoTotal;
    inserirDados;

    if classeLotes.editar = false then
      Application.MessageBox('Lote cadastrado com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK)
    else
      Application.MessageBox('Dados editados com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);
  end;

  Self.Close;
end;

procedure TformCadastrarLote.btnSaveMouseEnter(Sender: TObject);
begin
  btnSave.Color := clBlack;
end;

procedure TformCadastrarLote.btnSaveMouseLeave(Sender: TObject);
begin
  btnSave.Color := $0007780B;
end;

procedure TformCadastrarLote.carregarDados(vDicDados: TDictionary<string, Variant>);
begin
  classeLotes.editar := true;

  with vDicDados do
  begin
    vIdLote := Items['id_lote'];
    vIdEmpresaSelecionada := Items['id_empresa'];
    edCodigo.Text := Items['codigo'];
    edOP.Text := Items['op'];
    edDescricao.Text := Items['descricao'];
    edDataEnt.Date := Items['data_entrada'];
    edEmpresa.Text := Items['empresa'];
    edQuantidade.Text := Items['quantidade'];
    edValorUnit.Text := FormatFloat('###,###,##0.00', Items['valor_unit']);
    edValorTotal.Text := FormatFloat('###,###,##0.00', Items['valor_total']);
    edTempoMin.Text := FormatFloat('###,###,##0.000', Items['tempo_min']);
  end;

  edCodigo.Enabled := false;
  edOP.Enabled := false;
  edEmpresa.Enabled := false;
  btnBuscarEmpresa.Enabled := false;
  pnlBtnBuscarEmpresa.Color := $00D6D5D3;
end;

procedure TformCadastrarLote.edTempoMinChange(Sender: TObject);
begin
  SisEditFloatChange(edTempoMin, 3);
end;

procedure TformCadastrarLote.edValorTotalChange(Sender: TObject);
begin
  SisEditFloatChange(edValorTotal);
end;

procedure TformCadastrarLote.edValorUnitChange(Sender: TObject);
var
  resultado: currency;
begin
  SisEditFloatChange(edValorUnit);

  resultado := StrToCurr(Trim(edValorUnit.Text).Replace('.', '')) * StrToIntDef(edQuantidade.Text, 0);
  edValorTotal.Text := FormatCurr('###,###,##0.00', resultado);
end;

procedure TformCadastrarLote.FormCreate(Sender: TObject);
begin
  classeLotes := TLotes.Create;
  classeEmpresas := TEmpresa.Create;
end;

procedure TformCadastrarLote.FormShow(Sender: TObject);
begin
  if not classeLotes.editar then
    edDataEnt.Date := Now;
end;

procedure TformCadastrarLote.btnBuscarEmpresaClick(Sender: TObject);
var
  modalListarEmpresas: TformListarEmpresas;
begin
  modalListarEmpresas := TformListarEmpresas.Create(self);
  with modalListarEmpresas do
  begin
    mudarEstadoDBGrid := true;
    WindowState := TWindowState.wsNormal;
    BorderStyle := bsSingle;
    Align := alNone;
    btnSelect.Visible := true;
    esconderColunas := true;
    ShowModal;

    if selecionado then
    begin
      edEmpresa.Text := modalListarEmpresas.dbgEmpresas.DataSource.DataSet.FieldByName('nomefantasia').AsString;
      vIdEmpresaSelecionada := modalListarEmpresas.dbgEmpresas.DataSource.DataSet.FieldByName('id').AsInteger;
    end;

    Destroy;
  end;
end;

end.
