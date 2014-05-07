unit uInvChsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, jpeg, uInvestigator, uMainForm;

type
  TfrmInv = class(TForm)
    cbInvPlayer1: TComboBox;
    Label1: TLabel;
    cbInvPlayer2: TComboBox;
    Label2: TLabel;
    cbInvPlayer3: TComboBox;
    Label3: TLabel;
    cbInvPlayer4: TComboBox;
    Label4: TLabel;
    cbInvPlayer5: TComboBox;
    Label5: TLabel;
    cbInvPlayer6: TComboBox;
    Label6: TLabel;
    cbInvPlayer7: TComboBox;
    Label7: TLabel;
    cbInvPlayer8: TComboBox;
    Label8: TLabel;
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
    Label9: TLabel;
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
    GroupBox1: TGroupBox;
    btnCommItem: TButton;
    btnUniqItem: TButton;
    btnSpell: TButton;
    btnSkill: TButton;
    btnAlly: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbInvPlayer1Change(Sender: TObject);
    procedure btnCommItemClick(Sender: TObject);
    procedure btnSpellClick(Sender: TObject);
    procedure btnUniqItemClick(Sender: TObject);
    procedure btnSkillClick(Sender: TObject);
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
begin
  //cbInvPlayer1Change(Sender);
  players[1].GetItems();
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

  if players[1].Investigator.can_take[1] <> 0 then
    btnCommItem.Enabled := True;
  if players[1].Investigator.can_take[2] <> 0 then
    btnUniqItem.Enabled := True;
  if players[1].Investigator.can_take[3] <> 0 then
    btnSpell.Enabled := True;
  if players[1].Investigator.can_take[4] <> 0 then
    btnSkill.Enabled := True;
  if players[1].Investigator.can_take[5] <> 0 then
    btnAlly.Enabled := True;

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
{  for i := 1 to 4 do
  begin
    if inv.can_take[i, 1] = CT_SPELL then
      for j := 1 to inv.can_take[i, 2] do
      begin
        card_to_load := CT_SPELL;
        frmCard.ShowModal;
      end;
  end;        }
end;

procedure TfrmInv.btnUniqItemClick(Sender: TObject);
var
  i, j: integer;
begin
 { for i := 1 to 4 do
  begin
    if inv.can_take[i, 1] = CT_UNIQUE_ITEM then
      for j := 1 to inv.can_take[i, 2] do
      begin
        card_to_load := CT_UNIQUE_ITEM;
        frmCard.ShowModal;
      end;
  end;           }
end;

procedure TfrmInv.btnSkillClick(Sender: TObject);
var
  i, j: integer;
begin
 { for i := 1 to 4 do
  begin
    if inv.can_take[i, 1] = CT_SKILL then
      for j := 1 to inv.can_take[i, 2] do
      begin
        card_to_load := CT_SKILL;
        frmCard.ShowModal;
      end;
  end;        }

end;

procedure TfrmInv.FormShow(Sender: TObject);
begin
  btnCommItem.Enabled := False;
  btnUniqItem.Enabled := False;
  btnSpell.Enabled := False;
  btnSkill.Enabled := False;
  btnAlly.Enabled := False;  
end;

end.
