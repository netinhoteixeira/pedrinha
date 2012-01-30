unit udados;

{$mode objfpc}{$H+}

interface

uses
  Forms, Classes, SysUtils, FileUtil, Sqlite3DS, db, Dialogs;

type

  { TDados }

  TDados = class(TDataModule)
    DatasetMineral: TSqlite3Dataset;
    DatasetMineralClasseComboBox: TSqlite3Dataset;
    DatasetMineralassociacao: TMemoField;
    DatasetMineralbrilho: TMemoField;
    DatasetMineralclasse1: TMemoField;
    DatasetMineralclasse2: TMemoField;
    DatasetMineralclasse3: TMemoField;
    DatasetMineralclasse4: TMemoField;
    DatasetMineralclasse5: TMemoField;
    DatasetMineralclivagem: TMemoField;
    DatasetMineralcor: TMemoField;
    DatasetMineraldensidade_max: TStringField;
    DatasetMineraldensidade_min: TStringField;
    DatasetMineraldureza_max: TStringField;
    DatasetMineraldureza_min: TStringField;
    DatasetMineralformula: TMemoField;
    DatasetMineralfratura: TMemoField;
    DatasetMineralidmineral: TAutoIncField;
    DatasetMineralimagem: TStringField;
    DatasetMineralnome: TMemoField;
    DatasetMineralocorrencia: TMemoField;
    DatasetMineralotica: TMemoField;
    DatasetMineraloutras: TMemoField;
    DatasetMineralrisco: TMemoField;
    DatasetMineraltags: TMemoField;
    DatasetMineraltransparencia: TMemoField;
    DatasourceMineral: TDatasource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DatasetMineralnomeGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Dados: TDados;

implementation

{$R *.lfm}

{ TDados }

procedure TDados.DataModuleCreate(Sender: TObject);
var
  arquivo: String;
begin
  arquivo := ChangeFileExt(Application.ExeName, '.sqlite');
  if (not FileExists(arquivo)) then
  begin
    ShowMessage('A base de dados "' + arquivo + '" não foi encontrada.');
    Application.Terminate();
  end
  else
  begin
    DatasetMineral.FileName := arquivo;
    DatasetMineral.Open();
    DatasetMineralClasseComboBox.FileName := arquivo;
  end;
end;

procedure TDados.DataModuleDestroy(Sender: TObject);
begin
  if (DatasetMineral.Active) then
  begin
    DatasetMineral.Close();
  end;

  if (DatasetMineralClasseComboBox.Active) then
  begin
    DatasetMineralClasseComboBox.Close();
  end;
end;

procedure TDados.DatasetMineralnomeGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
begin
  aText := Copy(Sender.AsString, 1, Sender.DisplayWidth);
end;

end.

