unit udados;

{$mode objfpc}{$H+}

interface

uses
  Forms, Classes, SysUtils, FileUtil, Sqlite3DS, db, Dialogs, LazJPG;

type

  { TDados }

  TDados = class(TDataModule)
    DatasetMineral: TSqlite3Dataset;
    DatasetMineralClasse2ComboBox: TSqlite3Dataset;
    DatasetMineralClasse3ComboBox: TSqlite3Dataset;
    DatasetMineralclasse6: TMemoField;
    DatasetMineralclasse7: TMemoField;
    DatasetMineralClasseComboBox: TSqlite3Dataset;
    DatasetMineralassociacao: TMemoField;
    DatasetMineralbrilho: TMemoField;
    DatasetMineralclasse1: TMemoField;
    DatasetMineralclasse2: TMemoField;
    DatasetMineralclasse3: TMemoField;
    DatasetMineralclasse5: TMemoField;
    DatasetMineralClasse1ComboBox: TSqlite3Dataset;
    DatasetMineralclivagem: TMemoField;
    DatasetMineralcor: TMemoField;
    DatasetMineraldensidade_max: TStringField;
    DatasetMineraldensidade_min: TStringField;
    DatasetMineraldureza_max: TStringField;
    DatasetMineraldureza_min: TStringField;
    DatasetMineralformula: TMemoField;
    DatasetMineralfratura: TMemoField;
    DatasetMineralidmineral: TAutoIncField;
    DatasetMineralimagem: TBlobField;
    DatasetMineralnome: TMemoField;
    DatasetMineralocorrencia: TMemoField;
    DatasetMineralotica: TMemoField;
    DatasetMineraloutras: TMemoField;
    DatasetMineralrisco: TMemoField;
    DatasetMineraltags: TMemoField;
    DatasetMineraltransparencia: TMemoField;
    DatasourceMineral: TDatasource;
    DatasourceMineralClasse1ComboBox: TDatasource;
    DatasourceMineralClasse2ComboBox: TDatasource;
    DatasourceMineralClasse3ComboBox: TDatasource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DatasetMineralAfterPost(DataSet: TDataSet);
    procedure DatasetMineralAfterScroll(DataSet: TDataSet);
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

uses umineral_item;

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
    DatasetMineralClasse1ComboBox.FileName := arquivo;
    DatasetMineralClasse1ComboBox.Open();
    DatasetMineralClasse2ComboBox.FileName := arquivo;
    DatasetMineralClasse2ComboBox.Open();
    DatasetMineralClasse3ComboBox.FileName := arquivo;
    DatasetMineralClasse3ComboBox.Open();
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

  if (DatasetMineralClasse1ComboBox.Active) then
  begin
    DatasetMineralClasse1ComboBox.Close();
  end;

  if (DatasetMineralClasse2ComboBox.Active) then
  begin
    DatasetMineralClasse2ComboBox.Close();
  end;

  if (DatasetMineralClasse3ComboBox.Active) then
  begin
    DatasetMineralClasse3ComboBox.Close();
  end;
end;

procedure TDados.DatasetMineralAfterPost(DataSet: TDataSet);
begin
  DatasetMineralClasse1ComboBox.Refresh();
  DatasetMineralClasse2ComboBox.Refresh();
  DatasetMineralClasse3ComboBox.Refresh();
end;

procedure TDados.DatasetMineralAfterScroll(DataSet: TDataSet);
var
  JPGImage: TJPGImage;
  MemoryStream: TMemoryStream;
begin
  if (Assigned(FormMineralItem)) then
  begin
    //if (FormMineralItem.Showing) then
    //begin
      FormMineralItem.Imagem.Picture.Clear();
      //if (not DatasetMineralimagem.IsNull) then
      //begin
        JPGImage := TJPGImage.Create();
        MemoryStream := TMemoryStream.Create();
        try
          DatasetMineralimagem.SaveToStream(MemoryStream);
          if (MemoryStream.Size > 0) then
          begin
            MemoryStream.Seek(0, soFromBeginning);
            JPGImage.LoadFromStream(MemoryStream);
            FormMineralItem.Imagem.Assign(JPGImage);
          end;
        finally
          JPGImage.Destroy();
          MemoryStream.Destroy();
        end;
      //end;
    //end;
  end;
end;

procedure TDados.DatasetMineralnomeGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
begin
  aText := Copy(Sender.AsString, 1, Sender.DisplayWidth);
end;

end.

