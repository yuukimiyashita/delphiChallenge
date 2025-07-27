program Faturamento;

uses
  Vcl.Forms,
  uCadastroNota in 'uCadastroNota.pas' {ufrmCadastroNota},
  dmConexao in 'dmConexao.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TufrmCadastroNota, ufrmCadastroNota);
  Application.CreateForm(TdmDados, dmDados);
  Application.Run;
end.
