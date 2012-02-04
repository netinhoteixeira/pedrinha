unit umineral_lista;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, ActnList, ComCtrls, StdCtrls, DbCtrls, Buttons;

type

  { TFormMineralLista }

  TFormMineralLista = class(TForm)
    ActionSair: TAction;
    ActionRemover: TAction;
    ActionEditar: TAction;
    ActionAdicionar: TAction;
    ActionFiltrar: TAction;
    ActionListMineralLista: TActionList;
    ButtonSair: TBitBtn;
    ButtonRemover: TBitBtn;
    ButtonEditar: TBitBtn;
    ButtonAdicionar: TBitBtn;
    ComboBoxClasse1: TComboBox;
    ComboBoxClasse2: TComboBox;
    ComboBoxClasse3: TComboBox;
    DBGridMineralLista: TDBGrid;
    ImageListMineralLista: TImageList;
    LabelClasse: TLabel;
    PanelControle: TPanel;
    PanelFiltro: TPanel;
    StatusBarMineralLista: TStatusBar;
    procedure ActionAdicionarExecute(Sender: TObject);
    procedure ActionEditarExecute(Sender: TObject);
    procedure ActionFiltrarExecute(Sender: TObject);
    procedure ActionRemoverExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure ComboBoxClasse1Change(Sender: TObject);
    procedure ComboBoxClasse2Change(Sender: TObject);
    procedure ComboBoxClasse3Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure AtualizarBarraDeEstado;
    procedure InicializarFiltro;
  end;

var
  FormMineralLista: TFormMineralLista;

implementation

uses udados, umineral_item;

{ TFormMineralLista }

procedure TFormMineralLista.AtualizarBarraDeEstado;
begin
  if (Dados.DatasetMineral.Active) then
  begin
    if (Dados.DatasetMineral.RecordCount <= 0) then
    begin
        StatusBarMineralLista.SimpleText := 'Exibindo nenhum registro';
    end
    else if (Dados.DatasetMineral.RecordCount = 1) then
    begin
      StatusBarMineralLista.SimpleText := 'Exibindo 1 registro';
    end
    else
    begin
      StatusBarMineralLista.SimpleText := 'Exibindo ' + IntToStr(Dados.DatasetMineral.RecordCount) + ' registros';
    end;
  end;
end;

procedure TFormMineralLista.InicializarFiltro;
begin
  ComboBoxClasse1.Text := EmptyStr;
  ComboBoxClasse1.Clear();
  ComboBoxClasse2.Visible := False;
  ComboBoxClasse2.Text := EmptyStr;
  ComboBoxClasse2.Clear();
  ComboBoxClasse3.Visible := False;
  ComboBoxClasse3.Text := EmptyStr;
  ComboBoxClasse3.Clear();

  Dados.DatasetMineralClasseComboBox.SQL := 'SELECT DISTINCT classe1 FROM mineral ORDER BY classe1 ASC';
  Dados.DatasetMineralClasseComboBox.Open();
  ComboBoxClasse1.Items.Add(EmptyStr);
  while (not Dados.DatasetMineralClasseComboBox.EOF) do
  begin
    if (Length(Trim(Dados.DatasetMineralClasseComboBox.Fields[0].AsString)) > 0) then
    begin
      ComboBoxClasse1.Items.Add(Dados.DatasetMineralClasseComboBox.Fields[0].AsString);
    end;
    Dados.DatasetMineralClasseComboBox.Next();
  end;
  Dados.DatasetMineralClasseComboBox.Close();
  Dados.DatasetMineralClasseComboBox.Fields.Clear();
end;

procedure TFormMineralLista.FormCreate(Sender: TObject);
begin
  AtualizarBarraDeEstado();
  InicializarFiltro();
end;

procedure TFormMineralLista.ActionFiltrarExecute(Sender: TObject);
begin
  //
end;

procedure TFormMineralLista.ActionRemoverExecute(Sender: TObject);
var
  nome: String;
  formula: String;
begin
  if (not Dados.DatasetMineral.IsEmpty) then
  begin
    nome := Dados.DatasetMineral.FieldByName('nome').AsString;
    formula := Dados.DatasetMineral.FieldByName('formula').AsString;
    if (Length(formula) > 0) then
    begin
      nome := nome + ' [' + formula + ']';
    end;

    if (QuestionDlg('Confirmação', 'Deseja realmente remover "' + nome + '"?',
       mtConfirmation, [mrNo, mrYes], 0) = mrYes) then
    begin
      Dados.DatasetMineral.Delete();
      AtualizarBarraDeEstado();
    end;
  end;
end;

procedure TFormMineralLista.ActionSairExecute(Sender: TObject);
begin
  Self.Close();
end;

procedure TFormMineralLista.ComboBoxClasse1Change(Sender: TObject);
var
  subclasse: Boolean;
begin
  ComboBoxClasse1.Hint := ComboBoxClasse1.Text;

  subclasse := False;
  if (ComboBoxClasse1.Text <> EmptyStr) then
  begin
    Dados.DatasetMineralClasseComboBox.SQL := 'SELECT COUNT(DISTINCT classe2) FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '")';
    Dados.DatasetMineralClasseComboBox.Open();
    subclasse := (Dados.DatasetMineralClasseComboBox.Fields[0].AsInteger > 0);
    Dados.DatasetMineralClasseComboBox.Close();
    Dados.DatasetMineralClasseComboBox.Fields.Clear();

    Dados.DatasetMineral.Close();
    Dados.DatasetMineral.SQL := 'SELECT * FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '")';
    Dados.DatasetMineral.Open();
  end
  else
  begin
    Dados.DatasetMineral.Close();
    Dados.DatasetMineral.SQL := 'SELECT * FROM mineral';
    Dados.DatasetMineral.Open();
  end;
  AtualizarBarraDeEstado();

  ComboBoxClasse2.Visible := False;
  ComboBoxClasse2.Text := EmptyStr;
  ComboBoxClasse2.Clear();
  ComboBoxClasse3.Visible := False;
  ComboBoxClasse3.Text := EmptyStr;
  ComboBoxClasse3.Clear();

  if (subclasse) then
  begin
    ComboBoxClasse2.Visible := True;

    Dados.DatasetMineralClasseComboBox.SQL := 'SELECT DISTINCT classe2 FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '") ORDER BY classe2 ASC';
    Dados.DatasetMineralClasseComboBox.Open();
    ComboBoxClasse2.Items.Add(EmptyStr);
    while (not Dados.DatasetMineralClasseComboBox.EOF) do
    begin
      if (Length(Trim(Dados.DatasetMineralClasseComboBox.Fields[0].AsString)) > 0) then
      begin
        ComboBoxClasse2.Items.Add(Dados.DatasetMineralClasseComboBox.Fields[0].AsString);
      end;
      Dados.DatasetMineralClasseComboBox.Next();
    end;
    Dados.DatasetMineralClasseComboBox.Close();
    Dados.DatasetMineralClasseComboBox.Fields.Clear();
  end;
end;

procedure TFormMineralLista.ComboBoxClasse2Change(Sender: TObject);
var
  subclasse: Boolean;
begin
  ComboBoxClasse2.Hint := ComboBoxClasse2.Text;

  subclasse := False;
  if (ComboBoxClasse2.Text <> EmptyStr) then
  begin
    Dados.DatasetMineralClasseComboBox.SQL := 'SELECT COUNT(DISTINCT classe3) FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '") AND (classe2 = "' + ComboBoxClasse2.Text + '")';
    Dados.DatasetMineralClasseComboBox.Open();
    subclasse := (Dados.DatasetMineralClasseComboBox.Fields[0].AsInteger > 0);
    Dados.DatasetMineralClasseComboBox.Close();
    Dados.DatasetMineralClasseComboBox.Fields.Clear();

    Dados.DatasetMineral.Close();
    Dados.DatasetMineral.SQL := 'SELECT * FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '") AND (classe2 = "' + ComboBoxClasse2.Text + '")';
    Dados.DatasetMineral.Open();
  end
  else
  begin
    Dados.DatasetMineral.Close();
    Dados.DatasetMineral.SQL := 'SELECT * FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '")';
    Dados.DatasetMineral.Open();
  end;
  AtualizarBarraDeEstado();

  ComboBoxClasse3.Visible := False;
  ComboBoxClasse3.Text := EmptyStr;
  ComboBoxClasse3.Clear();

  if (subclasse) then
  begin
    ComboBoxClasse3.Visible := True;

    Dados.DatasetMineralClasseComboBox.SQL := 'SELECT DISTINCT classe3 FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '") AND (classe2 = "' + ComboBoxClasse2.Text + '") ORDER BY classe3 ASC';
    Dados.DatasetMineralClasseComboBox.Open();
    ComboBoxClasse3.Items.Add(EmptyStr);
    while (not Dados.DatasetMineralClasseComboBox.EOF) do
    begin
      if (Length(Trim(Dados.DatasetMineralClasseComboBox.Fields[0].AsString)) > 0) then
      begin
        ComboBoxClasse3.Items.Add(Dados.DatasetMineralClasseComboBox.Fields[0].AsString);
      end;
      Dados.DatasetMineralClasseComboBox.Next();
    end;
    Dados.DatasetMineralClasseComboBox.Close();
    Dados.DatasetMineralClasseComboBox.Fields.Clear();
  end;
end;

procedure TFormMineralLista.ComboBoxClasse3Change(Sender: TObject);
begin
  ComboBoxClasse3.Hint := ComboBoxClasse3.Text;

  Dados.DatasetMineral.Close();
  if (ComboBoxClasse3.Text <> EmptyStr) then
  begin
    Dados.DatasetMineral.SQL := 'SELECT * FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '") AND (classe2 = "' + ComboBoxClasse2.Text + '") AND (classe3 = "' + ComboBoxClasse3.Text + '")';
  end
  else
  begin
    Dados.DatasetMineral.SQL := 'SELECT * FROM mineral WHERE (classe1 = "' + ComboBoxClasse1.Text + '") AND (classe2 = "' + ComboBoxClasse2.Text + '")';
  end;
  Dados.DatasetMineral.Open();
  AtualizarBarraDeEstado();
end;

procedure TFormMineralLista.FormCloseQuery(Sender: TObject;
  var CanClose: boolean);
begin
  CanClose := QuestionDlg('Confirmação', 'Deseja sair?', mtConfirmation, [mrNo,
    mrYes], 0) = mrYes;
  if (CanClose) then
  begin
    try
      Dados.DatasetMineral.Cancel();
      FormMineralItem.Destroy();
    finally
    end;
  end;
end;

procedure TFormMineralLista.ActionAdicionarExecute(Sender: TObject);
begin
  Dados.DatasetMineral.Append();
  FormMineralItem.Show();
end;

procedure TFormMineralLista.ActionEditarExecute(Sender: TObject);
begin
  Dados.DatasetMineral.Edit();
  FormMineralItem.Show();
end;

{$R *.lfm}

end.

