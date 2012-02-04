unit umineral_item;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ComCtrls, ExtCtrls;

type

  { TFormMineralItem }

  TFormMineralItem = class(TForm)
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
    LabelClasse: TLabel;
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
    PageControlMineralItem: TPageControl;
    TabSheetOutras: TTabSheet;
    TabSheetOcorrencia: TTabSheet;
    TabSheetAssociacao: TTabSheet;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMineralItem: TFormMineralItem;

implementation

{$R *.lfm}

end.

