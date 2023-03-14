unit untClasseContasPagar;

interface

uses
  System.JSON, System.Classes, DataSet.Serialize, System.SysUtils, IdHTTP,
  functions, System.Generics.Collections, BancoFuncoes;

type
  TContasPagar = class
  private
    Fid: integer;
    Fdescricao: string;
    FdataVenc: TDate;
    FvalorTotal: Currency;
    FvalorPago: Currency;
    FtotalPagar: Currency;
  public
    editar: boolean;
    property id: integer read Fid write Fid;
    property descricao: string read FDescricao write FDescricao;
    property dataVenc: TDate read FDataVenc write FDataVenc;
    property valorTotal: Currency read FvalorTotal write FvalorTotal;
    property valorPago: Currency read FvalorPago write FvalorPago;
    property totalPagar: Currency read FtotalPagar write FtotalPagar;

    procedure inserirDadosConta;
    procedure inserirValorPago;
    procedure confirmarPagamento;
    procedure excluirConta(vId: Integer);
  end;

implementation

procedure TContasPagar.confirmarPagamento;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      try
        Add('valor_pago', FvalorTotal);
        Add('total_pagar', CurrToStr(0.00));
        Add('pago', true);

        BDAtualizarRegistros('tab_contaspagar', ' id = ' + Fid.ToString, vDicDados);
      except on E: Exception do
        raise Exception.Create('Erro ao confirmar pagamento!' + sLineBreak + 'Erro detalhado: ' + E.Message);
      end;
    end;
  finally
    vDicDados := nil;
  end;
end;

procedure TContasPagar.excluirConta(vId: Integer);
begin
  try
    BDExcluirRegistro('tab_contaspagar', ' id = ' + vId.ToString);
  except on E: Exception do
    raise Exception.Create('Erro ao excluir conta!' + sLineBreak + 'Erro detalhado: ' + E.Message);
  end;
end;

procedure TContasPagar.inserirValorPago;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    try
      with vDicDados do
      begin
        Add('valor_pago', FvalorPago);
        Add('total_pagar', FtotalPagar);

        if FtotalPagar = 0.00 then
          Add('pago', True);
      end;

      BDAtualizarRegistros('tab_contaspagar', ' id = ' + Fid.ToString, vDicDados);
    except on E: Exception do
      raise Exception.Create('Erro ao inserir valor pago!' + sLineBreak + 'Erro detalhado: ' + E.Message);
    end;
  finally
    vDicDados := nil;
  end;
end;

procedure TContasPagar.inserirDadosConta;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      try
        Add('descricao', Fdescricao);
        Add('data_venc', DateToStr(FdataVenc));
        Add('valor_total', FvalorTotal);
        Add('total_pagar', FtotalPagar);

        if not editar then
          BDInserirRegistros('tab_contaspagar', ' id ', ' tab_contaspagar_id_seq ', vDicDados)
        else
          BDAtualizarRegistros('tab_contaspagar', ' id = ' + Fid.ToString, vDicDados);
      except on E: Exception do
        raise Exception.Create('Erro ao inserir conta!' + sLineBreak + 'Erro detalhado: ' + E.Message);
      end;
    end;
  finally
    vDicDados := nil;
  end;
end;

end.
