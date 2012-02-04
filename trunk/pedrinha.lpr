program pedrinha;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, sqlite3laz, imagesforlazarus, udados, umineral_lista, umineral_item
  { you can add units after this };

{$R *.res}

begin
  Application.Title := 'Pedrinha';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDados, Dados);
  Application.CreateForm(TFormMineralLista, FormMineralLista);
  Application.CreateForm(TFormMineralItem, FormMineralItem);
  Application.Run;
end.

