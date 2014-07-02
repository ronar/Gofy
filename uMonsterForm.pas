unit uMonsterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uMonster, uPlayer, jpeg, uStreet;

type
  TfrmMonster = class(TForm)
    imgMonster: TImage;
    btnNextMob: TButton;
    btnPrevMob: TButton;
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
  frmMonster: TfrmMonster;
  gMonster: TMonster;
  //gPlayer: TPlayer;
  mon_pic: boolean = false;


implementation

uses uMainForm, uCommon;

{$R *.dfm}

procedure TfrmMonster.PrepareMonster(monster: TMonster; player: TPlayer);
var
  p_addr: ^Integer;
begin
  if monster.fId = 0 then
  begin
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(monster.fId)+'-1.jpg');
    ShowMessage('Чето нету монстра!');
    exit;
  end;
  
  gMonster := monster;
  if monster.fId < 100 then
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\0'+IntToStr(monster.fId)+'-1.jpg')
  else
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(monster.fId)+'-1.jpg');
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
end;

procedure TfrmMonster.btnEvadeClick(Sender: TObject);
begin
  if Arkham_Streets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location).lok_mon_count = 0 then
  begin
    ShowMessage('Уходить уже не от кого :('+#10+#13+'Все монстры вышли.');
    exit;
  end;

  if gCurrentPlayer.RollADice(gCurrentPlayer.Stats[ST_SNEAK] + gMonster.fAwareness, 1) > 0 then
  begin
    gCurrentPlayer.evadedmosnters[1] := gMonster.fId;
    frmMain.lstLog.Items.Add('Ушел от моба!!');
    close;
  end
  else
  begin
    lst1.Items.Add('Не ушел от моба!!');
    lst1.Items.Add('Fight!! *играет музыка из MK*');
    btnBattleClick(sender);
  end;

end;

procedure TfrmMonster.btnBattleClick(Sender: TObject);
var
  empty_lok: TLocation;
begin
  if gCurrentPlayer.Stamina < 1 then
  begin
    ShowMessage('Игрок не может драться!!');
    exit;
  end;

  if Arkham_Streets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location).lok_mon_count = 0 then
  begin
    ShowMessage('Биться не с кем :('+#10+#13+'Все монстры вышли.');
    exit;
  end;


  // Horror! check
  if gCurrentPlayer.RollADice(gCurrentPlayer.Stats[ST_WILL] + gMonster.fHorrorRate, 1) >= 1 then
  begin
    lst1.Items.Add('Horror checked!!');
  end
  else
  begin
    gCurrentPlayer.Sanity := gCurrentPlayer.Sanity - gMonster.fHorrorDmg;
    lst1.Items.Add('Игрок потерял разум: ' + IntToStr(gMonster.fHorrorDmg) + '!!');
  end;

  // Monster fight!
  if gCurrentPlayer.RollADice(gCurrentPlayer.Stats[ST_FIGHT] + gMonster.fCmbtRate + gCurrentPlayer.BonusWeapon, gMonster.fToughness) >= gMonster.fToughness then
  begin
    gCurrentPlayer.AddMonsterTrophies(gMonster.fId);
    Arkham_Streets[ton(gCurrentPlayer.Location)].TakeAwayMonster(gCurrentPlayer.Location, gMonster.fId);
    lst1.Items.Add('Убил моба!!');
    lst1.Items.Add('Гирок получил монстр-трофеюшек!!');
  end
  else
  begin
    gCurrentPlayer.Stamina := gCurrentPlayer.Stamina - gMonster.fCmbtDmg;
    lst1.Items.Add('Игроку нанесено урона: ' + IntToStr(gMonster.fCmbtDmg) + '!!');
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
      gCurrentPlayer.Location := 5200;
      gCurrentPlayer.Moves := 0;
    end;

  end;


end;

procedure TfrmMonster.imgMonsterClick(Sender: TObject);
begin
  mon_pic := not mon_pic;
  if mon_pic then
  begin
    if gMonster.fId < 100 then
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\0'+IntToStr(gmonster.fId)+'-1.jpg')
    else
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(gmonster.fId)+'-1.jpg');
  end
  else
  begin
    if gMonster.fId < 100 then
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\0'+IntToStr(gmonster.fId)+'-2.jpg')
    else
      imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(gmonster.fId)+'-2.jpg');
  end;
end;

end.
