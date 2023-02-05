unit untCadastrarLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, untClasseLotes, untListarEmpresas, untClasseEmpresas,
  System.JSON, functions, System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage;

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
    procedure edQuantidadeExit(Sender: TObject);
    procedure edValorTotalChange(Sender: TObject);
    procedure edTempoMinChange(Sender: TObject);
  private
    classeLotes: TLotes;
    classeEmpresas: TEmpresa;
    listarEmpresas: TformListarEmpresas;
    idEmpresaSelecionada, idLote: integer;
    functions: TFunctions;
  public
    procedure carregarDados(dados: TJSONObject);
  end;

var
  formCadastrarLote: TformCadastrarLote;

implementation

{$R *.dfm}

procedure TformCadastrarLote.btnCancelClick(Sender: TObject);
begin
  Self.Close;
  functions.editar := false;
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

  if (classeLotes.existeOP(Trim(edOP.Text))) and (not classeLotes.editar) then
  begin
    Application.MessageBox('Erro ao cadastrar lote!' + sLineBreak +
      'A OP informada já possui cadastro!', 'Atenção', MB_ICONWARNING + MB_OK);
    exit;
  end;

  resultadoTempoTotal := StrToFloat(Trim(edTempoMin.Text).Replace('.', '')) * StrToInt(edQuantidade.Text);

  try
    classeEmpresas.RazaoSocial := edEmpresa.Text;
    classeLotes.idLote := idLote;
    classeLotes.idEmpresa := idEmpresaSelecionada;
    classeLotes.codigo := StrToInt(edCodigo.Text);
    classeLotes.OP := StrToInt(edOP.Text);
    classeLotes.descricao := edDescricao.Text;
    classeLotes.empresa := classeEmpresas;
    classeLotes.dataEntrada := edDataEnt.Date;
    classeLotes.quantidade := StrToInt(edQuantidade.Text);
    classeLotes.valorUnit := StrToCurr(Trim(edValorUnit.Text).Replace('.', ''));
    classeLotes.valorTotal := StrToCurr(Trim(edValorTotal.Text).Replace('.', ''));
    classeLotes.tempoMin := StrToFloat(Trim(edTempoMin.Text).Replace('.', ''));
    classeLotes.tempoTotal := resultadoTempoTotal;
    classeLotes.inserirDados;

    if classeLotes.editar = false then
      Application.MessageBox('Lote cadastrado com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK)
    else
      Application.MessageBox('Dados editados com sucesso.', 'Confirmação', MB_ICONINFORMATION + MB_OK);

    Self.Close;
  except
    Application.MessageBox('Erro ao cadastrar lote!', 'Confirmação', MB_ICONINFORMATION + MB_OK);
  end;
end;

procedure TformCadastrarLote.btnSaveMouseEnter(Sender: TObject);
begin
  btnSave.Color := clBlack;
end;

procedure TformCadastrarLote.btnSaveMouseLeave(Sender: TObject);
begin
  btnSave.Color := $0007780B;
end;

procedure TformCadastrarLote.carregarDados(dados: TJSONObject);
begin
  classeLotes.editar := true;

  idLote := dados.GetValue<integer>('id_lote');
  idEmpresaSelecionada := dados.GetValue<integer>('id_empresa');
  edCodigo.Text := dados.GetValue<string>('codigo');
  edOP.Text := dados.GetValue<string>('op');
  edDescricao.Text := dados.GetValue<string>('descricao');
  edEmpresa.Text := dados.GetValue<string>('empresa');
  edQuantidade.Text := dados.GetValue<string>('quantidade');
  edValorUnit.Text := dados.GetValue<string>('valor_unit');
  edValorTotal.Text := dados.GetValue<string>('valor_total');
  edTempoMin.Text := dados.GetValue<string>('tempo_min');

  edCodigo.Enabled := false;
  edOP.Enabled := false;
  edEmpresa.Enabled := false;
  btnBuscarEmpresa.Enabled := false;
  pnlBtnBuscarEmpresa.Color := $00D6D5D3;
end;

procedure TformCadastrarLote.edQuantidadeExit(Sender: TObject);
begin
  if edQuantidade.Text = '' then
    edQuantidade.Text := '1';
end;

procedure TformCadastrarLote.edTempoMinChange(Sender: TObject);
begin
  functions.SisEditFloatChange(edTempoMin, 3);
end;

procedure TformCadastrarLote.edValorTotalChange(Sender: TObject);
begin
  functions.SisEditFloatChange(edValorTotal);
end;

procedure TformCadastrarLote.edValorUnitChange(Sender: TObject);
var
  resultado: currency;
begin
  functions.SisEditFloatChange(edValorUnit);

  resultado := StrToCurr(Trim(edValorUnit.Text).Replace('.', '')) * StrToInt(edQuantidade.Text);
  edValorTotal.Text := FormatCurr('###,###,##0.00', resultado);
end;

procedure TformCadastrarLote.FormCreate(Sender: TObject);
begin
  classeLotes := TLotes.Create;
  classeEmpresas := TEmpresa.Create;
  functions := TFunctions.Create;
end;

procedure TformCadastrarLote.btnBuscarEmpresaClick(Sender: TObject);
begin
  listarEmpresas := TformListarEmpresas.Create(self);

  listarEmpresas.mudarEstadoDBGrid := true;
  listarEmpresas.WindowState := TWindowState.wsNormal;
  listarEmpresas.BorderStyle := bsSingle;
  listarEmpresas.Align := alNone;
  listarEmpresas.btnSelect.Visible := true;
  listarEmpresas.esconderColunas := true;
  listarEmpresas.ShowModal;

  if listarEmpresas.selecionado then
  begin
    edEmpresa.Text := listarEmpresas.DBGrid.DataSource.DataSet.FieldByName('nomefantasia').AsString;
    idEmpresaSelecionada := listarEmpresas.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;
  end;
end;

end.
