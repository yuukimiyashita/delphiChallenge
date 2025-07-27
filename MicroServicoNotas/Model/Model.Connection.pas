unit Model.Connection;

interface

uses
  FireDAC.DApt, FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.UI.Intf,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.Classes,
  System.IniFiles, System.SysUtils;

var
  FConnection : TFDConnection;

  function fMontaConexao(FConexao: TFDConnection): String;
  function fConectar: TFDConnection;
  procedure pDesconectar;

implementation

function fMontaConexao(FConexao: TFDConnection): string;
var
  wArquivoConfig : string;
  wIni : TIniFile;
begin
  try
    try

      // aqui acessa o arquivo de config la na pasta debug pra configuar o banco

      wArquivoConfig := GetCurrentDir + '\ServerHorse.ini';

      wIni := TIniFile.Create(wArquivoConfig);

      FConexao.Params.Values['DriverID'] := wIni.ReadString('Banco de Dados', 'DriverID', '');
      FConexao.Params.Values['Database'] := wIni.ReadString('Banco de Dados', 'Database', '');
      FConexao.Params.Values['User_name'] := wIni.ReadString('Banco de Dados', 'User_name', '');
      FConexao.Params.Values['Password'] := wIni.ReadString('Banco de Dados', 'Password', '');
      FConexao.Params.Add('Port=' + wIni.ReadString('Banco de Dados', 'Port', '3050'));
      FConexao.Params.Add('Server=' + wIni.ReadString('Banco de Dados', 'Server', 'localhost'));

      Result := 'OK';
    except on Ex:exception do
      Result := 'Erro ao configurar banco: ' + Ex.Message;
    end;

  finally
    if Assigned(wIni) then
      wIni.DisposeOf;
  end;
end;

function fConectar: TFDConnection;
begin
  FConnection := TFDConnection.Create(nil);
  fMontaConexao(FConnection);
  FConnection.Connected := True;

  Result := FConnection;
end;

procedure pDesconectar;
begin
  if Assigned(FConnection) then
    begin
      if FConnection.Connected then
        FConnection.Connected := False;

      FConnection.Free;
    end;
end;


end.

