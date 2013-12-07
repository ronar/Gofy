unit uInvChsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, jpeg, uInvestigator;

type
  TInvFrm = class(TForm)
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
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbInvPlayer1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvFrm: TInvFrm;
  inv: TInvestigator;

  procedure Draw_Skills(skill: string);

implementation

{$R *.dfm}

procedure TInvFrm.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TInvFrm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TInvFrm.cbInvPlayer1Change(Sender: TObject);
var
  i, ip: integer;
  F: TextFile;
  s: string[80];
begin
  AssignFile (F, ExtractFilePath(Application.ExeName)+'\\CardsData\\Investigators\\'+IntToStr(cbInvPlayer1.ItemIndex + 1) + '.txt');
  Reset(F);
  readln(F, s);
  CloseFile(F);

  inv := TInvestigator.Create;
  inv.name := cbInvPlayer1.Text; // Имя сыщика
  inv.Sanity := StrToInt(Copy(S, 1, 1)); // Разум сыщика
  inv.Stamina := StrToInt(Copy(S, 2, 1)); // Тело сыщика
  inv.Start_Lok := StrToInt(Copy(S, 3, 4)); // Стартовая локация сыщика
  inv.items_count := 0;
  for i := 1 to 3 do
  begin
    ip := StrToInt(Copy(S, 2 + (i * 5), 1));
    case ip of // Investigator's possession
    1: inv.money := StrToInt(Copy(S, 3 + (i * 5), 4)); // $
    2: inv.clues := StrToInt(Copy(S, 3 + (i * 5), 4)); // Clues
    3..7: begin
      inv.items[inv.items_count + 1] := StrToInt(Copy(S, 3 + (i * 5), 4));
      inv.items_count := inv.items_count + 1; end; // Common items, unique items, spells, allies, spec. cards
    end;
  end;
  for i := 1 to 3 do
  begin
    ip := StrToInt(Copy(S, 2 + (i * 5), 1));
    case ip of // Investigator's possession
    1: inv.money := StrToInt(Copy(S, 3 + (i * 5), 4)); // $
    2: inv.clues := StrToInt(Copy(S, 3 + (i * 5), 4)); // Clues
    3..7: begin
      inv.items[inv.items_count + 1] := StrToInt(Copy(S, 3 + (i * 5), 4));
      inv.items_count := inv.items_count + 1; end; // Common items, unique items, spells, allies, spec. cards
    end;
  end;
  inv.can_take[1, 1] := StrToInt(Copy(S, 35, 1));
  inv.can_take[1, 2] := StrToInt(Copy(S, 36, 4));
  inv.can_take[2, 1] := StrToInt(Copy(S, 40, 1));
  inv.can_take[2, 2] := StrToInt(Copy(S, 41, 4));
  inv.can_take[3, 1] := StrToInt(Copy(S, 45, 1));
  inv.can_take[3, 2] := StrToInt(Copy(S, 46, 4));
  inv.can_take[4, 1] := StrToInt(Copy(S, 50, 1));
  inv.can_take[4, 2] := StrToInt(Copy(S, 51, 4));
  inv.focus := StrToInt(Copy(S, 55, 1)) - 1;
  inv.stats[1] := StrToInt(Copy(s, 56, 1));
  inv.stats[2] := StrToInt(Copy(s, 57, 1));
  inv.stats[3] := StrToInt(Copy(s, 58, 1));
  inv.stats[4] := StrToInt(Copy(s, 59, 1));
  inv.stats[5] := StrToInt(Copy(s, 60, 1));
  inv.stats[6] := StrToInt(Copy(s, 61, 1));

  lbSpeed1.Caption := Copy(s, 56, 1);
  lbSneak1.Caption := Copy(s, 57, 1);
  lbFight1.Caption := Copy(s, 58, 1);
  lbWill1.Caption := Copy(s, 59, 1);
  lbLore1.Caption := Copy(s, 60, 1);
  lbLuck1.Caption := Copy(s, 61, 1);

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
  lb1 := (InvFrm.FindComponent('lb' + skill + '1') as TLabel);
  lb2 := (InvFrm.FindComponent('lb' + skill + '2') as TLabel);
  lb3 := (InvFrm.FindComponent('lb' + skill + '3') as TLabel);
  lb4 := (InvFrm.FindComponent('lb' + skill + '4') as TLabel);

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

end.
