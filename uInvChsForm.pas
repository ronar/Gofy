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
    btnAdd2ndPlayer: TButton;
    btnAdd3rdPlayer: TButton;
    btnAdd4thPlayer: TButton;
    btnAdd5thPlayer: TButton;
    btnAdd6thPlayer: TButton;
    btnAdd7thPlayer: TButton;
    btnAdd8thPlayer: TButton;
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
    edtPlayer1: TEdit;
    edtPlayer2: TEdit;
    edtPlayer3: TEdit;
    edtPlayer4: TEdit;
    edtPlayer5: TEdit;
    edtPlayer6: TEdit;
    edtPlayer7: TEdit;
    edtPlayer8: TEdit;
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
    lbl19: TLabel;
    lblPlNum: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbInvPlayer1Change(Sender: TObject);
    procedure btnCommItemClick(Sender: TObject);
    procedure btnSpellClick(Sender: TObject);
    procedure btnUniqItemClick(Sender: TObject);
    procedure btnSkillClick(Sender: TObject);
    procedure btnAdd2ndPlayerClick(Sender: TObject);
    procedure btnAdd3rdPlayerClick(Sender: TObject);
    procedure btnAdd4thPlayerClick(Sender: TObject);
    procedure btnAdd5thPlayerClick(Sender: TObject);
    procedure btnAdd6thPlayerClick(Sender: TObject);
    procedure btnAdd7thPlayerClick(Sender: TObject);
    procedure btnAdd8thPlayerClick(Sender: TObject);
    procedure cbInvPlayer2Change(Sender: TObject);
    procedure cbInvPlayer3Change(Sender: TObject);
    procedure cbInvPlayer4Change(Sender: TObject);
    procedure cbInvPlayer5Change(Sender: TObject);
    procedure cbInvPlayer6Change(Sender: TObject);
    procedure cbInvPlayer7Change(Sender: TObject);
    procedure cbInvPlayer8Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  i, k: integer;
begin
  //cbInvPlayer1Change(Sender);
  for k := 1 to player_count do
    if players[k].Investigator = nil then
    begin
      ShowMessage('Сыщик не выбран!');
      exit;
    end;

  for k := 1 to player_count do
  begin
    players[k].GetItems();
    if players[k].Investigator.can_take[1] > 0 then
      for i := 1 to players[k].Investigator.can_take[1] do
        players[k].AddItem(Common_Items_Deck, Common_Items_Deck.DrawCard);

    if players[k].Investigator.can_take[2] > 0 then
      for i := 1 to players[k].Investigator.can_take[2] do
        //players[k].AddItem(Unique_Items_Deck.DrawCard);
        players[k].AddItem(Common_Items_Deck, Common_Items_Deck.DrawCard);

    if players[k].Investigator.can_take[3] > 0 then
      for i := 1 to players[k].Investigator.can_take[3] do
        //players[k].AddItem(Spells_Deck.DrawCard);
        players[k].AddItem(Common_Items_Deck, Common_Items_Deck.DrawCard);

    if players[k].Investigator.can_take[4] > 0 then
      for i := 1 to players[k].Investigator.can_take[4] do
        //players[k].AddItem(Skills_Deck.DrawCard);
        players[k].AddItem(Common_Items_Deck, Common_Items_Deck.DrawCard);
  end;

  ShowPlayerCards(gCurrentPlayer, player_current_card[current_player]);
  frmMain.btn17Click(Sender);

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

  btnAdd2ndPlayer.Enabled := True;  
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

procedure TfrmInv.btnAdd2ndPlayerClick(Sender: TObject);
begin
  player_count := 2;
  cbInvPlayer2.Enabled := True;
  edtPlayer2.Enabled := True;
end;

procedure TfrmInv.btnAdd3rdPlayerClick(Sender: TObject);
begin
  cbInvPlayer3.Enabled := False;
  edtPlayer3.Enabled := False;
end;

procedure TfrmInv.btnAdd4thPlayerClick(Sender: TObject);
begin
  cbInvPlayer4.Enabled := False;
  edtPlayer4.Enabled := False;
end;

procedure TfrmInv.btnAdd5thPlayerClick(Sender: TObject);
begin
  cbInvPlayer5.Enabled := False;
  edtPlayer5.Enabled := False;
end;

procedure TfrmInv.btnAdd6thPlayerClick(Sender: TObject);
begin
  cbInvPlayer6.Enabled := False;
  edtPlayer6.Enabled := False;
end;

procedure TfrmInv.btnAdd7thPlayerClick(Sender: TObject);
begin
  cbInvPlayer7.Enabled := False;
  edtPlayer7.Enabled := False;
end;

procedure TfrmInv.btnAdd8thPlayerClick(Sender: TObject);
begin
  cbInvPlayer8.Enabled := False;
  edtPlayer8.Enabled := False;
end;

procedure TfrmInv.cbInvPlayer2Change(Sender: TObject);
begin
  players[2].AssignInvestigator(gInvestigators.card[cbInvPlayer2.ItemIndex + 1]);
  players[2].Investigator.name := cbInvPlayer2.Text; // Имя сыщика

  lbSpeed1.Caption := IntToStr(players[2].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[2].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[2].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[2].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[2].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[2].Investigator.stat[6]);

  cbInvPlayer3.Enabled := True;
  edtPlayer3.Enabled := True;
end;

procedure TfrmInv.cbInvPlayer3Change(Sender: TObject);
begin
  players[3].AssignInvestigator(gInvestigators.card[cbInvPlayer3.ItemIndex + 1]);
  players[3].Investigator.name := cbInvPlayer3.Text; // Имя сыщика

  player_count := 3;

  lbSpeed1.Caption := IntToStr(players[3].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[3].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[3].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[3].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[3].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[3].Investigator.stat[6]);

  cbInvPlayer4.Enabled := True;
  edtPlayer4.Enabled := True;
end;

procedure TfrmInv.cbInvPlayer4Change(Sender: TObject);
begin
  players[4].AssignInvestigator(gInvestigators.card[cbInvPlayer4.ItemIndex + 1]);
  players[4].Investigator.name := cbInvPlayer4.Text; // Имя сыщика

  player_count := 4;

  lbSpeed1.Caption := IntToStr(players[4].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[4].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[4].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[4].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[4].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[4].Investigator.stat[6]);

  cbInvPlayer5.Enabled := True;
  edtPlayer5.Enabled := True;
end;

procedure TfrmInv.cbInvPlayer5Change(Sender: TObject);
begin
  players[5].AssignInvestigator(gInvestigators.card[cbInvPlayer5.ItemIndex + 1]);
  players[5].Investigator.name := cbInvPlayer5.Text; // Имя сыщика

  player_count := 5;

  lbSpeed1.Caption := IntToStr(players[5].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[5].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[5].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[5].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[5].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[5].Investigator.stat[6]);

  cbInvPlayer6.Enabled := True;
  edtPlayer6.Enabled := True;
end;

procedure TfrmInv.cbInvPlayer6Change(Sender: TObject);
begin
  players[6].AssignInvestigator(gInvestigators.card[cbInvPlayer6.ItemIndex + 1]);
  players[6].Investigator.name := cbInvPlayer6.Text; // Имя сыщика

  player_count := 6;

  lbSpeed1.Caption := IntToStr(players[6].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[6].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[6].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[6].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[6].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[6].Investigator.stat[6]);

  cbInvPlayer7.Enabled := True;
  edtPlayer7.Enabled := True;
end;

procedure TfrmInv.cbInvPlayer7Change(Sender: TObject);
begin
  players[7].AssignInvestigator(gInvestigators.card[cbInvPlayer7.ItemIndex + 1]);
  players[7].Investigator.name := cbInvPlayer7.Text; // Имя сыщика

  player_count := 7;

  lbSpeed1.Caption := IntToStr(players[7].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[7].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[7].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[7].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[7].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[7].Investigator.stat[6]);

  cbInvPlayer8.Enabled := True;
  edtPlayer8.Enabled := True;
end;

procedure TfrmInv.cbInvPlayer8Change(Sender: TObject);
begin
  players[8].AssignInvestigator(gInvestigators.card[cbInvPlayer8.ItemIndex + 1]);
  players[8].Investigator.name := cbInvPlayer8.Text; // Имя сыщика

  player_count := 8;

  lbSpeed1.Caption := IntToStr(players[8].Investigator.stat[1]);
  lbSneak1.Caption := IntToStr(players[8].Investigator.stat[2]);
  lbFight1.Caption := IntToStr(players[8].Investigator.stat[3]);
  lbWill1.Caption := IntToStr(players[8].Investigator.stat[4]);
  lbLore1.Caption := IntToStr(players[8].Investigator.stat[5]);
  lbLuck1.Caption := IntToStr(players[8].Investigator.stat[6]);
end;

procedure TfrmInv.FormShow(Sender: TObject);
begin
  player_count := 1;
end;

end.
