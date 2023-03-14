unit untClasseContasReceber;

interface

uses
  functions, System.Classes, System.JSON, System.SysUtils, BancoFuncoes,
  System.Generics.Collections;

type
  TContasReceber = class
  private
    FdataRecebimento: TDate;
    FidContaReceber: integer;
  public
    property idContaReceber: integer read FidContaReceber write FidContaReceber;
    property dataRecebimento: TDate read FdataRecebimento write FdataRecebimento;

    procedure confirmarRecebimento;
    procedure excluirConta;
  end;

implementation

procedure TContasReceber.confirmarRecebimento;
var
  vDicDados: TDictionary<String, Variant>;
begin
  vDicDados := TDictionary<String, Variant>.Create;
  try
    with vDicDados do
    begin
      Add('data_recebimento', DateToStr(FdataRecebimento));
      Add('recebido', True);
    end;
    BDAtualizarRegistros('tab_contasreceber', ' id = ' + FidContaReceber.ToString, vDicDados);
  finally
    vDicDados := nil;
  end;
end;

procedure TContasReceber.excluirConta;
begin
  try
    BDExcluirRegistro('tab_contasreceber', ' id = ' + FidContaReceber.ToString);
  except on E: Exception do
    raise Exception.Create('Erro ao excluir registro!' + sLineBreak + 'Erro detalhado: ' + E.Message);
  end;
end;

end.
