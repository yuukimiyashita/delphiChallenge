unit dmConexao;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient, System.Net.URLClient, System.Net.HttpClientComponent,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  Datasnap.DBClient, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Comp.UI;

type
  TdmDados = class(TDataModule)
    NetHTTPClient1: TNetHTTPClient;
  private
    { Private declarations }
  public
    function fBuscaProdutoID(const FProdutoID: String): IHTTPResponse;
    function fCadastraProdutos(const FProdutoJSON: TJSONObject): Boolean;
    function fDeletaProdutos(const FProdutoID : String): Boolean;
  end;

var
  dmDados: TdmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmDados.fBuscaProdutoID(const FProdutoID: String): IHTTPResponse;
var
  wResposta: IHTTPResponse;
begin
  try
    wResposta := NetHTTPClient1.Get('http://localhost:9001/produtos/' + FProdutoID);
    //Vai retornar de qualquer maneira pois usa o status code la na tela para conferir se o produto esta ou nao cadastrado
    Result := wResposta
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar com o microservico: ' + E.Message);
  end;
end;


function TdmDados.fCadastraProdutos(const FProdutoJSON: TJSONObject): Boolean;
var
  wResposta: IHTTPResponse;
  wJsonStream: TStringStream;
begin
  try
    wJsonStream := TStringStream.Create(FProdutoJSON.ToString, TEncoding.UTF8);
    try
      wResposta := NetHTTPClient1.Post(      //Tive erro pois estava mandando como string
        'http://localhost:9001/produtos/',
        wJsonStream,
        nil,
        [TNameValuePair.Create('Content-Type', 'application/json')]
      );

      if wResposta.StatusCode = 200 then
        Result := True
      else
        Result := False;

      //Result := Resposta.StatusCode in [200, 201];
    finally
      FreeAndNil(wJsonStream);
    end;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar com o microservico: ' + E.Message);
  end;
end;



function TdmDados.fDeletaProdutos(const FProdutoID: String): Boolean;
var
  wResposta : IHTTPResponse;
begin
  try
    wResposta := dmDados.NetHTTPClient1.Delete('http://localhost:9001/produtos/' + FProdutoID);
    if wResposta.StatusCode = 200 then
      Result := True
    else
      Result := False;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar com o microservico: ' + E.Message);
  end;
end;


end.
