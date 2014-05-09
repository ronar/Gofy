unit uInvChsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, jpeg, uInvestigator, uMainForm;

type
  TfrmInv = class(TForm)
    cbInvPlayer1: TComboBox;
    cbInvPlayer2: TComboBox;
    cbInvPlayer3: TComboBox;
    cbInvPlayer4: TComboBox;
    cbInvPlayer5: TComboBox;
    cbInvPlayer6: TComboBox;
    cbInvPlayer7: TComboBox;
    cbInvPlayer8: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Image1: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    RadioGroup1: TRadioGroup;
    lbSpeed1: TLabel;
    lbSpeed2: TLabel;
    lbSpeed3: TLabel;
    lbSpeed4: TLabel;
    lbSneak1: TLabel;
    lbSneak2: TLabel;
    lbSneak3: TLabel;
    lbSneak4: TLabel;
    RadioGroup2: TRadioGroup;
    lbFight1: TLabel;
    lbFight2: TLabel;
    lbFight3: TLabel;
    lbFight4: TLabel;
    lbWill1: TLabel;
    lbWill2: TLabel;
    lbWill3: TLabel;
    lbWill4: TLabel;
    RadioGroup3: TRadioGroup;
    lbLore1: TLabel;
    lbLore2: TLabel;
    lbLore3: TLabel;
    lbLore4: TLabel;
    lbLuck1: TLabel;
    lbLuck2: TLabel;
    lbLuck3: TLabel;
    lbLuck4: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    edt8: TEdit;
    edt9: TEdit;
    lbl10: TLabel;
    lbl11: TLabel;
    grp1: TGroupBox;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    rg1: TRadioGroup;
    btn11: TButton;
    btn12: TButton;
    rg2: TRadioGroup;
    cbb9: TComboBox;
    btn13: TButton;
    btn14: TButton;
    btn15: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbInvPlayer1Change(Sender: TObject);
    procedure btnCommItemClick(Sender: TObject);
    procedure btnSpellClick(Sender: TObject);
    procedure btnUniqItemClick(Sender: TObject);
    procedure btnSkillClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInv: TfrmInv;
  //inv: TInvestigator;
  take_common: integer = 0; // How many already taken
  take_uniq: integer = 0;
  take_spell: integer = 0;
  take_skill: integer = 0;

  procedure Draw_Skills(skill: string);

implementation

uses uCardForm, uCommon;

{$R *.dfm}

procedure TfrmInv.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmInv.Button1Click(Sender: TObject);
var
  i: integer;
begin
  //cbInvPlayer1Change(Sender);
  players[1].GetItems();
  if players[1].Investigator.can_take[1] > 0 then
    for i := 1 to players[1].Investigator.can_take[1] do
      players[1].AddItem(Common_Items_Deck.DrawCard);
  if players[1].Investigator.can_take[2] > 0 then
    for i := 1 to players[1].Investigator.can_take[2] do
      players[1].AddItem(Unique_Items_Deck.DrawCard);
  if players[1].Investigator.can_take[3] > 0 then
    for i := 1 to players[1].Investigator.can_take[3] do
      players[1].AddItem(Spells_Deck.DrawCard);
  if players[1].Investigator.can_take[4] > 0 then
    for i := 1 to players[1].Investigator.can_take[4] do
      players[1].AddItem(Skills_Deck.DrawCard);

  players[1].Speed := players[1].Investigator.stat[1] + RadioGroup1.ItemIndex;
  players[1].Sneak := players[1].Investigator.stat[2] - RadioGroup1.ItemIndex;

  players[1].Fight := players[1].Investigator.stat[3] + RadioGroup1.ItemIndex;
  players[1].Will := players[1].Investigator.stat[4] - RadioGroup1.ItemIndex;

  players[1].Lore := players[1].Investigator.stat[5] + RadioGroup1.ItemIndex;
  players[1].Luck := players[1].Investigator.stat[6] - RadioGroup1.ItemIndex;

  Close;
end;

procedure TfrmInv.cbInvPlayer1Change(Sender: TObject);
var
  i, ip: integer;
  F: TextFile;
  s: string[80];
begin
  players[1].AssignInvestigator(gInvestigators.card[cbInvPlayer1.ItemIndex + 1]);
  players[1].Investigator.name := cbInvPlayer1.Text; // Имя сыщика

  lbSpeed1.Caption := IntToStr(players[1].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[1].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[1].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[1].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[1].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[1].Investigator.stat[6]);

  Draw_Skills('Speed');
  Draw_Skills('Sneak');
  Draw_Skills('Fight');
  Draw_Skills('Will');
  Draw_Skills('Lore');
  Draw_Skills('Luck');
end;

procedure Draw_Skills(skill: string);
var
  lb1, lb2, lb3, lb4: TLabel;
begin
  lb1 := (frmInv.FindComponent('lb' + skill + '1') as TLabel);
  lb2 := (frmInv.FindComponent('lb' + skill + '2') as TLabel);
  lb3 := (frmInv.FindComponent('lb' + skill + '3') as TLabel);
  lb4 := (frmInv.FindComponent('lb' + skill + '4') as TLabel);

  if StrToInt(lb1.Caption) < 3 then
  begin
    lb2.Caption := IntToStr(StrToInt(lb1.Caption) + 1);
    lb3.Caption := IntToStr(StrToInt(lb1.Caption) + 2);
    lb4.Caption := IntToStr(StrToInt(lb1.Caption) + 3);
  end
  else
  begin
    lb2.Caption := IntToStr(StrToInt(lb1.Caption) - 1);
    lb3.Caption := IntToStr(StrToInt(lb1.Caption) - 2);
    lb4.Caption := IntToStr(StrToInt(lb1.Caption) - 3);
  end;
end;

procedure TfrmInv.btnCommItemClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 1 to players[1].Investigator.can_take[1] do
  begin
    card_to_load := CT_COMMON_ITEM;
    frmCard.ShowModal;
    players[1].Investigator.AddItem(StrToInt(frmCard.cbCard.text));
  end;
end;

procedure TfrmInv.btnSpellClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 1 to players[1].Investigator.can_take[3] do
  begin
    card_to_load := CT_SPELL;
    frmCard.ShowModal;
    players[1].Investigator.AddItem(StrToInt(frmCard.cbCard.text));
  end;
end;

procedure TfrmInv.btnUniqItemClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 1 to players[1].Investigator.can_take[2] do
  begin
    card_to_load := CT_UNIQUE_ITEM;
    frmCard.ShowModal;
    players[1].Investigator.AddItem(StrToInt(frmCard.cbCard.text));
  end;
end;

procedure TfrmInv.btnSkillClick(Sender: TObject);
var
  i, j: integer;
begin
  for i := 1 to players[1].Investigator.can_take[4] do
  begin
    card_to_load := CT_SKILL;
    frmCard.ShowModal;
    players[1].Investigator.AddItem(StrToInt(frmCard.cbCard.text));
  end;
end;

end.
