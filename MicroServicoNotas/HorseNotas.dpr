
program HorseNotas;


{$APPTYPE CONSOLE}     // aqui fica GUI ou CONSOLE pra esconder o cmd que abre

{$R *.res}

uses
  Horse,
  Windows,
  Horse.Jhonson,
  Model.Connection in 'Model\Model.Connection.pas',
  Model.Notas in 'Model\Model.Notas.pas',
  Controller.Nota in 'Controller\Controller.Nota.pas';

begin
  THorse.Use(Jhonson());
  Controller.Nota.Registry;

  THorse.Listen(9000);

  // faz um loop pra ficar ativo
  while True do
    Sleep(1000);
end.
