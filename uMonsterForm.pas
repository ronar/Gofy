unit uMonsterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uMonster, uPlayer, jpeg;

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
    procedure PrepareMonster(monster: TMonster; var player: TPlayer);
  end;

var
  frmMonster: TfrmMonster;
  gMonster: TMonster;
  gPlayer: TPlayer;
  mon_pic: boolean = false;


implementation

uses uMainForm, uCommon;

{$R *.dfm}

procedure TfrmMonster.PrepareMonster(monster: TMonster; var player: TPlayer);
var
  p_addr: ^Integer;
begin
  gMonster := monster;
  gPlayer := player;
  imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(monster.fId)+'-1.jpg');
  if player.active_cards[1] <> 0 then
    imgPlaCard1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\'+IntToStr(player.active_cards[1])+'.jpg')
  else
    imgPlaCard1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Spells\30.jpg');
  if player.active_cards[2] <> 0 then
    imgPlaCard2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\'+IntToStr(player.active_cards[2])+'.jpg')
  else
    imgPlaCard2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Spells\30.jpg');
  if player.active_cards[3] <> 0 then
    imgPlaCard3.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\'+IntToStr(player.active_cards[3])+'.jpg')
  else
    imgPlaCard3.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Spells\30.jpg');
  mon_pic := not mon_pic;
end;

procedure TfrmMonster.btnEvadeClick(Sender: TObject);
begin
  if gPlayer.RollADice(gPlayer.Stats[ST_SNEAK] + gMonster.fAwareness) > 0 then
  begin
    gPlayer.evadedmosnters[1] := gMonster.fId;
    lst1.Items.Add('Ушел от моба!!');
  end
  else
    lst1.Items.Add('Не ушел от моба!!');

end;

procedure TfrmMonster.btnBattleClick(Sender: TObject);
begin
  // Horror! check
  if gPlayer.RollADice(gPlayer.Stats[ST_WILL] + gMonster.fHorrorRate) >= 1 then
  begin
    lst1.Items.Add('Horror checked!!');
  end
  else
  begin
    gPlayer.Sanity := gPlayer.Sanity - gMonster.fHorrorDmg;
    lst1.Items.Add('Игрок потерял разум: ' + IntToStr(gMonster.fHorrorDmg) + '!!');
  end;

  if gPlayer.RollADice(gPlayer.Stats[ST_FIGHT] + gMonster.fCmbtRate) >= gMonster.fToughness then
  begin
    gPlayer.AddMonsterTrophies(gMonster.fId);
    lst1.Items.Add('Убил моба!!');
    lst1.Items.Add('Гирок получил монстр-трофеюшек!!');
  end
  else
    lst1.Items.Add('Игроку нанесено урона: ' + IntToStr(gMonster.fCmbtDmg) + '!!');

end;

procedure TfrmMonster.imgMonsterClick(Sender: TObject);
begin
  mon_pic := not mon_pic;
  if mon_pic then
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(gMonster.fId)+'-1.jpg')
  else
    imgMonster.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Monsters\'+IntToStr(gMonster.fId)+'-2.jpg');
end;

end.
