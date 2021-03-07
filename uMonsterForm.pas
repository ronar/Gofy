﻿unit uMonsterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uMonster, uPlayer, jpeg, uStreet;

type
  TMonsterForm = class(TForm)
    imgMonster: TImage;
    btnBattle: TButton;
    btnEvade: TButton;
    lst1: TListBox;
    lbl1: TLabel;
    imgPlaCard1: TImage;
    imgPlaCard2: TImage;
    imgPlaCard3: TImage;
    img1: TImage;
    procedure btnEvadeClick(Sender: TObject);
    procedure btnBattleClick(Sender: TObject);
    procedure imgMonsterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PrepareMonster(monster: TMonster; player: TPlayer);
  end;

var
  MonsterForm: TMonsterForm;
  gMonster: TMonster;
  //gPlayer: TPlayer;
  mon_pic: boolean = false;


implementation

uses uMainForm, uCommon;

{$R *.dfm}

procedure TMonsterForm.PrepareMonster(monster: TMonster; player: TPlayer);
var
  p_addr: ^Integer;
begin
  if monster.Id = 0 then
  begin
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(monster.Id)+'-1.jpg');
    ShowMessage('Чето нету монстра!');
    exit;
  end;

  gMonster := monster;
  if monster.Id < 100 then
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\0'+IntToStr(monster.Id)+'-1.jpg')
  else
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(monster.Id)+'-1.jpg');
  if gCurrentPlayer.active_cards[1] <> 0 then
    imgPlaCard1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\'+IntToStr(gCurrentPlayer.active_cards[1])+'.jpg')
  else
    imgPlaCard1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Spells\30.jpg');
  if gCurrentPlayer.active_cards[2] <> 0 then
    imgPlaCard2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\'+IntToStr(gCurrentPlayer.active_cards[2])+'.jpg')
  else
    imgPlaCard2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Spells\30.jpg');
  if gCurrentPlayer.active_cards[3] <> 0 then
    imgPlaCard3.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\'+IntToStr(gCurrentPlayer.active_cards[3])+'.jpg')
  else
    imgPlaCard3.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Spells\30.jpg');
  mon_pic := not mon_pic;
  //ShowMessage(IntToStr(Integer(gMonster)));
end;

procedure TMonsterForm.btnEvadeClick(Sender: TObject);
begin
  if Arkham_Streets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location).lok_mon_count = 0 then
  begin
    ShowMessage('Уходить уже не от кого :('+#10+#13+'Все монстры вышли.');
    exit;
  end;

  if gMonster.LocationId = 0 then
  begin
    ShowMessage('Биться не с кем :('+#10+#13+'Видимо вы их победили.');
    exit;
  end;

  if gCurrentPlayer.RollADice(gCurrentPlayer.Stats[ST_SNEAK] + gMonster.Awareness, 1) > 0 then
  begin
    gCurrentPlayer.evadedmosnters[1] := gMonster.Id;
    MainForm.lstLog.Items.Add('Ушел от моба!!');
    close;
  end
  else
  begin
    lst1.Items.Add('Не ушел от моба!!');
    gCurrentPlayer.Stamina := gCurrentPlayer.Stamina - gMonster.CmbtDmg;
    lst1.Items.Add('Игроку нанесено урона: ' + IntToStr(gMonster.CmbtDmg) + '!!');
    btnBattleClick(sender);
  end;

end;

procedure TMonsterForm.btnBattleClick(Sender: TObject);
var
  empty_lok: TLocation;
begin
  if gCurrentPlayer.Stamina < 1 then
  begin
    ShowMessage('Игрок не может драться!!');
    exit;
  end;

  if (gCurrentPlayer.Location mod 1000 <> 0) and (Arkham_Streets[ton(gCurrentPlayer.Location)].Lok[hon(gCurrentPlayer.Location)].lok_mon_count = 0) then
  begin
    ShowMessage('Биться не с кем :('+#10+#13+'Все монстры вышли.');
    exit;
  end;

  if (gCurrentPlayer.Location mod 1000 = 0) and (Arkham_Streets[ton(gCurrentPlayer.Location)].st_mob_count = 0) then
  begin
    ShowMessage('Биться не с кем :('+#10+#13+'Все монстры вышли.');
    exit;
  end;

  if gMonster.LocationId = 0 then
  begin
    ShowMessage('Биться не с кем :('+#10+#13+'Видимо вы их победили.');
    exit;
  end;

  // Horror! check
  if gCurrentPlayer.RollADice(gCurrentPlayer.Stats[ST_WILL] + gMonster.HorrorRate, 1) >= 1 then
  begin
    lst1.Items.Add('Horror checked!!');
  end
  else
  begin
    gCurrentPlayer.Sanity := gCurrentPlayer.Sanity - gMonster.HorrorDmg;
    lst1.Items.Add('Игрок потерял разум: ' + IntToStr(gMonster.HorrorDmg) + '!!');
  end;

  // Monster fight!
  if gCurrentPlayer.RollADice(gCurrentPlayer.Stats[ST_FIGHT] + gMonster.CmbtRate + gCurrentPlayer.BonusWeapon, gMonster.Toughness) >= gMonster.Toughness then
  begin
    gCurrentPlayer.AddMonsterTrophies(gMonster.Id);
    Arkham_Streets[ton(gCurrentPlayer.Location)].TakeAwayMonster(gCurrentPlayer.Location, gMonster);
    lst1.Items.Add('Убил моба!!');
    lst1.Items.Add('Гирок получил монстр-трофеюшек!!');
  end
  else
  begin
    if ((gCurrentPlayer.Location mod 1000 = 0) and (Arkham_Streets[ton(gCurrentPlayer.Location)].st_mob_count > 0)) or
      ((gCurrentPlayer.Location mod 1000 <> 0) and (Arkham_Streets[ton(gCurrentPlayer.Location)].Lok[hon(gCurrentPlayer.Location)].lok_mon_count > 0)) then
    begin


    gCurrentPlayer.Stamina := gCurrentPlayer.Stamina - gMonster.CmbtDmg;
    lst1.Items.Add('Игроку нанесено урона: ' + IntToStr(gMonster.CmbtDmg) + '!!');
    if gCurrentPlayer.Stamina < 1 then
    begin
      lst1.Items.Add('Гирок без сознания, и перемещен в больницу Св. Марии');
      with empty_lok do
      begin
        lok_id := 0;
        lok_name := 'Void';
        clues := 0;
        HasGate := False;
        lok_mon_count := 0;
      end;
      gCurrentPlayer.Location := 9100;
      gCurrentPlayer.Moves := 0;
      gCurrentPlayer.Stamina := 1;
    end;
    end;
  end;


end;

procedure TMonsterForm.imgMonsterClick(Sender: TObject);
begin
  mon_pic := not mon_pic;
  if mon_pic then
  begin
    if gMonster.Id < 100 then
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\0'+IntToStr(gmonster.Id)+'-1.jpg')
    else
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(gmonster.Id)+'-1.jpg');
  end
  else
  begin
    if gMonster.Id < 100 then
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\0'+IntToStr(gmonster.Id)+'-2.jpg')
    else
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(gmonster.Id)+'-2.jpg');
  end;
end;

end.
