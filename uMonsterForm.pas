unit uMonsterForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uMonster, uPlayer;

type
  TfrmMonster = class(TForm)
    imgMonster: TImage;
    btnNextMob: TButton;
    btnPrevMob: TButton;
    btnBattle: TButton;
    btnEvade: TButton;
    lst1: TListBox;
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
  mon_pic := not mon_pic;
end;

procedure TfrmMonster.btnEvadeClick(Sender: TObject);
begin
  if gPlayer.RollADice(ST_SNEAK + gMonster.fAwareness) > 0 then
  begin
    gPlayer.evadedmosnters[1] := gMonster.fId;
    lst1.Items.Add('Ушел от моба!!');
  end
  else
    lst1.Items.Add('Не ушел от моба!!');

end;

procedure TfrmMonster.btnBattleClick(Sender: TObject);
begin
  if gPlayer.RollADice(ST_FIGHT + gMonster.fCmbtRate) >= gMonster.fToughness then
  begin
    gPlayer.evadedmosnters[1] := gMonster.fId;
    lst1.Items.Add('Убил моба!!');
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
