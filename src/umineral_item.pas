unit umineral_item;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, ActnList, ExtDlgs, LazJPG, db, udados;

type

  { TFormMineralItem }

  TFormMineralItem = class(TForm)
    ActionImagemRemover: TAction;
    ActionImagemSalvar: TAction;
    ActionImagemCarregar: TAction;
    ActionListMineralItemImagem: TActionList;
    DBEditTransparencia: TDBEdit;
    DBEditCor: TDBEdit;
    DBEditBrilho: TDBEdit;
    DBEditOtica: TDBEdit;
    DBEditRisco: TDBEdit;
    DBEditDurezaMax: TDBEdit;
    DBEditDensidadeMax: TDBEdit;
    DBEditDurezaMin: TDBEdit;
    DBEditDensidadeMin: TDBEdit;
    DBEditNome: TDBEdit;
    DBEditFormula: TDBEdit;
    DBEditFratura: TDBEdit;
    DBLookupComboBoxClasse1: TDBLookupComboBox;
    DBLookupComboBoxClasse2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBMemoAssociacao: TDBMemo;
    DBMemoOcorrencia: TDBMemo;
    DBMemoOutras: TDBMemo;
    DBNavigatorMineralItem: TDBNavigator;
    Imagem: TImage;
    ImageListMineralItemImagem: TImageList;
    LabelClasse: TLabel;
    LabelImagem: TLabel;
    LabelTransparencia: TLabel;
    LabelCor: TLabel;
    LabelBrilho: TLabel;
    LabelOtica: TLabel;
    LabelRisco: TLabel;
    LabelDurezaMax: TLabel;
    LabelDensidadeMax: TLabel;
    LabelDurezaMin: TLabel;
    LabelDensidadeMin: TLabel;
    LabelNome: TLabel;
    LabelFormula: TLabel;
    LabelFratura: TLabel;
    OpenPictureDialogImagem: TOpenPictureDialog;
    PageControlMineralItem: TPageControl;
    SavePictureDialogImagem: TSavePictureDialog;
    ScrollBoxImagem: TScrollBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    TabSheetOutras: TTabSheet;
    TabSheetOcorrencia: TTabSheet;
    TabSheetAssociacao: TTabSheet;
    procedure ActionImagemCarregarExecute(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMineralItem: TFormMineralItem;

implementation

{$R *.lfm}

{ TFormMineralItem }

procedure TFormMineralItem.ActionImagemCarregarExecute(Sender: TObject);
var
  JPGImage: TJPGImage;
  MemoryStream: TMemoryStream;
begin
  if ((Dados.DatasetMineral.State in [dsEdit]) and
    (OpenPictureDialogImagem.Execute())) then
  begin
    JPGImage := TJPGImage.Create();
    MemoryStream := TMemoryStream.Create();
    try
      JPGImage.LoadFromFile(OpenPictureDialogImagem.FileName);
      JPGImage.SaveToStream(MemoryStream);
      MemoryStream.Seek(0, soFromBeginning);
      Dados.DatasetMineralimagem.LoadFromStream(MemoryStream);
      Imagem.Picture.Assign(JPGImage);
    finally
      JPGImage.Destroy();
      MemoryStream.Destroy();
    end;
  end;
end;

end.

