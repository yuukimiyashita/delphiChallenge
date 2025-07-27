program Estoque;

uses
  Vcl.Forms,
  uCadastroProduto in 'uCadastroProduto.pas' {frCadProdutos},
  dmConexao in 'dmConexao.pas' {dmDados: TDataModule},
  uConsultaBase in 'uConsultaBase.pas' {frmConsulta};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrCadProdutos, frCadProdutos);
  Application.CreateForm(TdmDados, dmDados);
  Application.CreateForm(TfrmConsulta, frmConsulta);
  Application.Run;
end.
