unit uPlayer;

interface
uses
  SysUtils, Dialogs, uCardDeck, uChsLok, uInvestigator, uCommon, ExtCtrls;

type
  TPlayer = class
  private
    fLocation: integer; // Player's location
    fCards: array [1..MAX_PLAYER_ITEMS] of integer; // Player's items
    fCardsCount: integer; // Amt. of player's items
    fSanity: integer;
    fStamina: integer;
    fFocus: integer;
    fMoney: integer;
    fClues: integer;
    fMonsterTrophies: integer;
    fStats: array [1..6] of integer; // Статы игрока (1 - Скорость, 2 - Скрытность)
    fFirstPlayer: boolean; // Флаг первого игрока
    fInvestigator: TInvestigator;
    Roll_results: array [1..12] of integer;
    function GetPlayerCard(indx: integer): integer;
    function GetPlayerStat(indx: integer): integer;
    //function SetPlayerStat(indx: integer; value: integer);
    procedure SetSpeed(value: integer);
  public
    constructor Create(var init_stats: array of integer; first_player: boolean);
    destructor Destroy; override;
    property Location: integer read fLocation write fLocation; // id локации в виде xxy, где (хх - номер улицы, y - номер локации)
    property Cards[indx: integer]: integer read GetPlayerCard; // write AddItem;
    property ItemsCount: integer read fCardsCount;
    property Sanity: integer read fSanity write fSanity;
    property Stamina: integer read fStamina write fStamina;
    property Focus: integer read fFocus write fFocus;
    property Money: integer read fMoney write fMoney;
    property Clues: integer read fClues write fClues;
    property MonsterTrophies: integer read fMonsterTrophies write fMonsterTrophies;
    property Stats[indx: integer]: integer read GetPlayerStat; // write AddItem;
    property Speed: integer write SetSpeed;
    property bFirstPlayer: boolean read fFirstPlayer write fFirstPlayer;
    property Investigator: TInvestigator read fInvestigator;
    procedure DrawCard(card_id: integer);
    procedure AddItem(indx: integer);
    procedure AssignInvestigator(inv: TInvestigator);
    //function Get_Item(indx: integer): integer;
    function RollADice(stat: integer): integer;
    function Act_Condition(Cond: integer; Choise: integer; N:integer; min: integer; max: integer): boolean;
    procedure EvtMoveToLocation(c_N: integer; c_data: string);
    procedure Encounter(var Locations_Deck: TCardDeck);
    procedure Take_Action(action: integer; action_value: integer);
    function CheckAvailability(grade: integer; param: integer): boolean;
    function HasItem(ID: integer): boolean;
    procedure ChangeSkills(r: integer; n: integer);
    //property Speed: integer read Stats[1] write Stats[1];
  end;

implementation

uses uMainForm;

// Конструктор игрока
constructor TPlayer.Create(var init_stats: array of integer; first_player: boolean);
var
  i: integer;
begin
  fCardsCount := 0;
  fStamina := 0;
  fSanity := 0;
  fFocus := 0;
  fStats[1] := init_stats[0];
  fStats[2] := init_stats[1];
  fStats[3] := init_stats[2];
  fStats[4] := init_stats[3];
  fStats[5] := init_stats[4];
  fStats[6] := init_stats[5];

  for i := 1 to MAX_PLAYER_ITEMS do
    fCards[i] := 0;
  fFirstPlayer := False;
  fInvestigator := nil;
end;

// Деструктор объекта TPlayer
destructor TPlayer.Destroy;
begin
  inherited;
end;

// Функция: взятие карты из колоды
procedure TPlayer.DrawCard(card_id: integer);
begin
  //Items_Count := Items_Count + 1;
  //SetLength(Cards, Items_Count);
  //Cards[Items_Count] := Card_ID;
end;

// Функция: получение предмета по индексу.
// Достаем предметы по одному, а не массивом
function TPlayer.GetPlayerCard(indx: integer): integer;
begin
  GetPlayerCard := fCards[indx];
end;

function TPlayer.GetPlayerStat(indx: integer): integer;
begin
  GetPlayerStat := fStats[indx];
end;

procedure TPlayer.SetSpeed(value: integer);
begin
  fStats[1] := value;
end;

procedure TPlayer.AddItem(indx: integer);
begin
  fCardsCount := fCardsCount + 1;
  fCards[fCardsCount] := indx;
end;

procedure TPlayer.AssignInvestigator(inv: TInvestigator);
begin
  fInvestigator := inv;
  fSanity := inv.sanity;
  fStamina := inv.stamina;
  fMoney := inv.money;
  fClues := inv.clues;
  fLocation := inv.start_lok;
  fFocus := inv.focus;
end;

// Бросок кубика (Возвращает число успехов, 0 - провал)
function TPlayer.RollADice(stat: integer): integer;
var
  r, i: integer;
  Successes: integer;
begin
  randomize;
  Successes := 0;
  // Deprecated
  frmMain.imgDR1.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR2.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR3.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR4.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR5.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR6.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR7.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR8.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR9.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR10.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR11.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  frmMain.imgDR12.Picture.LoadFromFile(path_to_exe+'\Pictures\0.jpg');
  // !Deprecated
  //RollADice := random(6)+1;
    //pl := TPlayer.Create(False);
  if Stats[stat] > 0 then
  begin
    for i:=1 to Stats[stat] do
    begin
      Roll_results[i]:=random(6)+1;
      // Deprecated
      case Roll_results[i] of
      1: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\1.jpg');
      2: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\2.jpg');
      3: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\3.jpg');
      4: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\4.jpg');
      5: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\5.jpg');
      6: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\6.jpg');
      end;
      // !Deprecated

      if Roll_results[i]>=5 then
      begin
        Successes := Successes + 1;
        //broskub.usp:=true;
        //broskub.kolusp:=broskub.kolusp+1;
        //if broskub.resbroskub[i]=6 then broskub.kolusp6:=broskub.kolusp6+1;
      end;
    end;
  end;

  RollADice := Successes;
end;

procedure TPlayer.EvtMoveToLocation(c_N: integer; c_data: string);
var
 c_Action1, c_Action1Value: integer;
begin
  // refer to xls file to locs table (n, id)
  if c_N = 0 then
  begin
    frmChsLok.ShowModal; // Move to any location
  end
  else
  begin
    fLocation := 2103;
  end;

  c_Action1 := StrToInt(copy(c_data, 9, 2));
  c_Action1Value := StrToInt(copy(c_data, 14, 2));

  if c_Action1 = 35 then
    ShowMessage('Encounter!');
end;

// Разрешить контакт
procedure TPlayer.Encounter(var Locations_Deck: TCardDeck);
begin

end;

// Проверка выполнилось ли условие на карте
function TPlayer.Act_Condition(cond: integer; choise: integer; N:integer; min: integer; max: integer): boolean;
var
  skill_test: integer;
begin

end;

// Выполнение действие согласно карте
procedure TPlayer.Take_Action(action: integer; action_value: integer);
var
  i: integer;
begin

end;

function TPlayer.CheckAvailability(grade: integer; param: integer): boolean;
begin
  if (grade = 8) and (money >= param) then
    result := true;

  if (grade = 9) and (clues >= param) then
    result := true;

  if (grade = 10) and (fMonsterTrophies >= param) then
    result := true;

  result := false;

end;

function TPlayer.HasItem(ID: integer): boolean;
begin

end;

procedure TPlayer.ChangeSkills(r: integer; n: integer);
begin
  case r of
  1: begin
    if fInvestigator.stats[1] < 3 then
      fStats[1] := fInvestigator.stats[1] + (n - 1)
    else
      fStats[1] := fInvestigator.stats[1] - (n - 1);

    if fInvestigator.stats[2] < 3 then
      fStats[2] := fInvestigator.stats[2] + (n - 1)
    else
      fStats[2] := fInvestigator.stats[2] - (n - 1);
  end;
  2: begin
    if fInvestigator.stats[3] < 3 then
      fStats[3] := fInvestigator.Stats[3] + (n - 1)
    else
      fStats[3] := fInvestigator.Stats[3] - (n - 1);

    if fInvestigator.stats[4] < 3 then
      fStats[4] := fInvestigator.stats[4] + (n - 1)
    else
      fStats[4] := fInvestigator.stats[4] - (n - 1);
  end;
  3: begin
    if fInvestigator.stats[5] < 3 then
      fStats[5] := fInvestigator.stats[5] + n - 1
    else
      fStats[5] := fInvestigator.stats[5] - n - 1;

    if fInvestigator.stats[6] < 3 then
      fStats[6] := fInvestigator.stats[6] + n - 1
    else
      fStats[6] := fInvestigator.stats[6] - n - 1;
  end;
  end;
end;

end.
 