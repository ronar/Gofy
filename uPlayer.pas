unit uPlayer;

interface
uses
  SysUtils, Dialogs, uCardDeck, uChsLok, uInvestigator, uCommon, ExtCtrls,
  Controls;

type
  TPlayer = class
  private
    fLocation: integer; // Player's location
    fNeighborhood: integer; // Neighbourhood of the player's location (for easy ref. instead of hon(..) func.)
    fCards: array [1..MAX_PLAYER_ITEMS] of integer; // Player's items
    fCardsCount: integer; // Amt. of player's items
    fMonsterTrophiesCount: Integer;
    fSpellsCount: integer; // Amt. of player's Spells
    fSanity: integer;
    fStamina: integer;
    fFocus: integer;
    fMoney: integer;
    fClues: integer;
    fMonsterTrophies: array [1..10] of integer; // Monster trophies of player
    fGateTrophies:Integer;
    fStats: array [1..6] of integer; // Статы игрока (1 - Скорость, 2 - Скрытность)
    fBonusStats: array [1..6] of integer; // Прибавка от карт навыков, мифа.
    fBlessed: boolean;
    fCursed: boolean;
    fFirstPlayer: boolean; // Флаг первого игрока
    fInvestigator: TInvestigator;
    fPlNumber: integer;
    fHands: Integer; // Number of hands :)
    Roll_results: array [1..12] of integer;
    function GetPlayerCard(indx: integer): integer;
    function GetPlayerStat(indx: integer): integer;
    function GetMonsterTrophies(indx: integer): integer;
    //function SetPlayerStat(indx: integer; value: integer);
    procedure SetSpeed(value: integer);
    procedure SetSneak(value: integer);
    procedure SetFight(value: integer);
    procedure SetWill(value: integer);
    procedure Setlore(value: integer);
    procedure SetLuck(value: integer);
    function IsBlessed: boolean;
    procedure Bless(b: boolean);
    function IsCursed: boolean;
    procedure Curse(b: boolean);
  public
    active_cards: array [1..4] of integer; // i.e. on hands
    hands_taken: integer;
    evadedmosnters: array [1..5] of integer; // id of mobs which player succesfully evaded
    constructor Create(var init_stats: array of integer; first_player: boolean);
    destructor Destroy; override;
    property Location: integer read fLocation write fLocation; // id локации в виде xxy, где (хх - номер улицы, y - номер локации)
    property Neighborhood: integer read fNeighborhood write fNeighborhood; // id прилегающей улицы
    property Cards[indx: integer]: integer read GetPlayerCard; // write AddItem;
    property MonsterTrophies[indx: integer]: integer read GetMonsterTrophies; // write AddItem;
    property ItemsCount: integer read fCardsCount;
    property Sanity: integer read fSanity write fSanity;
    property Stamina: integer read fStamina write fStamina;
    property Focus: integer read fFocus write fFocus;
    property Money: integer read fMoney write fMoney;
    property Clues: integer read fClues write fClues;
    property Stats[indx: integer]: integer read GetPlayerStat; // write AddItem;
    property Speed: integer write SetSpeed;
    property Sneak: integer write SetSneak;
    property Fight: integer write SetFight;
    property Will: integer write SetWill;
    property Lore: integer write SetLore;
    property Luck: integer write SetLuck;
    property Blessed: boolean read IsBlessed write Bless;
    property Cursed: boolean read IsCursed write Curse;
    property bFirstPlayer: boolean read fFirstPlayer write fFirstPlayer;
    property Investigator: TInvestigator read fInvestigator;
    //property Hands: integer read fHands;
    procedure DrawCard(card_id: integer);
    procedure AddItem(var cards: TCommonItemCardDeck; id: integer);
    procedure AddMonsterTrophies(mon_id: integer);
    procedure AssignInvestigator(inv: TInvestigator);
    //function Get_Item(indx: integer): integer;
    function RollADice(stat: integer): integer;
    function Act_Condition(Cond: integer; Choise: integer; N:integer; min: integer; max: integer): boolean;
    procedure EvtMoveToLocation(c_N: integer; c_data: string);
    procedure Encounter(var Locations_Deck: TCardDeck);
    procedure Take_Action(action: integer; action_value: integer);
    function CheckAvailability(grade: integer; param: integer): boolean;
    function HasItem(ID: integer): boolean;
    procedure ChangeSkills(x1: integer; x2: integer; x3: integer);
    procedure MoveToLocation(id_lok: integer);
    procedure GetItems; // Copy investigator's items to player
    procedure TakeWeapon(item1: integer); // Take choosen card to hands
    procedure DropWeapon; // Take choosen card to hands
    procedure activate_item(item_id: Integer);
    function CardBonus(stat: integer): Integer;
    //procedure
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
  fMonsterTrophiesCount := 0;
  fStamina := 0;
  fSanity := 0;
  fFocus := 0;
  for i := 1 to 5 do
  begin
    active_cards[i] := 0;
    evadedmosnters[i] := 0;
  end;

  for i := 1 to 6 do
  begin
    fStats[i] := init_stats[i - 1];
    fBonusStats[i] := 0;
  end;

  for i := 1 to MAX_PLAYER_ITEMS do
    fCards[i] := 0;

  fHands := 4; // 2 hands
  hands_taken := 0;
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

function TPlayer.GetMonsterTrophies(indx: integer): integer;
begin
  GetMonsterTrophies := fMonsterTrophies[indx];

end;

function TPlayer.GetPlayerStat(indx: integer): integer;
begin
  GetPlayerStat := fStats[indx];
end;

procedure TPlayer.SetSpeed(value: integer);
begin
  fStats[1] := value;
end;

procedure TPlayer.SetSneak(value: integer);
begin
  fStats[2] := value;
end;

procedure TPlayer.SetFight(value: integer);
begin
  fStats[3] := value;
end;

procedure TPlayer.SetWill(value: integer);
begin
  fStats[4] := value;
end;

procedure TPlayer.SetLore(value: integer);
begin
  fStats[5] := value;
end;

procedure TPlayer.SetLuck(value: integer);
begin
  fStats[6] := value;
end;

function TPlayer.IsBlessed: boolean;
begin
  if fBlessed then
    IsBlessed := True
  else
    IsBlessed := False;
end;

procedure TPlayer.Bless(b: boolean);
begin
  if fCursed then
    fBlessed := False
  else
    fBlessed := b;
end;

function TPlayer.IsCursed: boolean;
begin
  if fCursed then
    IsCursed := True
  else
    IsCursed := False;
end;

procedure TPlayer.Curse(b: boolean);
begin
  if fBlessed then
    fCursed := False
  else
    fCursed := b;
end;

procedure TPlayer.AddItem(var cards: TCommonItemCardDeck; id: integer);
begin
  fCardsCount := fCardsCount + 1;
  fCards[fCardsCount] := id;
  cards.DecCounter(cards.IndexOfCard(id));
end;

procedure TPlayer.AddMonsterTrophies(mon_id: integer);
begin
  fMonsterTrophies[fMonsterTrophiesCount] := mon_id;
  fMonsterTrophiesCount := fMonsterTrophiesCount + 1;
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
// Rename this func to SkillCheck
function TPlayer.RollADice(stat: integer): integer; // stat - exactly value of stat
var
  r, i, s: integer;
  Successes: integer;
begin
  randomize;
  Successes := 0;
  s := stat;
  while (Successes < 1) do
  begin
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
  if s > 0 then
  begin
    for i:=1 to s do
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

  RollADice := Successes; { TODO : Добавить сложность броска }
  if Successes < 1 then
  begin
    if MessageDlg('Reroll (using one clue)?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      break;
    end
    else
    begin
      if fClues > 0 then
        fClues := fClues - 1
      else
      begin
        ShowMessage('No clues!');
        break;
      end;
      s := 1;
    end;
  end
  else
    break;
  end; // While
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
var
  i: Integer;
begin
  result := false;

  if grade = 10 then // Проверка наличия карт
    for i := 1 to fCardsCount do
      if fCards[i] = param then
        Result := True;

  if (grade = 1) and (money >= param) then
    result := true;

  if (grade = 2) and (clues >= param) then
    result := true;

  // TODO: correct check monstertrophies
  if (grade = 3) and (fMonsterTrophies[1] >= param) then
    result := true;

  if (grade = 4) and (fSpellsCount >= param) then
    result := true;

  if (grade = 5) and (fSanity >= param) then
    result := true;

  if (grade = 6) and (fSanity >= param) then
    result := true;

  if (grade = 8) and (fGateTrophies >= param) then
    result := true;

end;

// Checks wether the player has the item or not
function TPlayer.HasItem(ID: integer): boolean;
var
  i: integer;
begin
  HasItem := False;
  for i := 1 to fCardsCount do
    if fCards[i] = id then
    begin
      HasItem := True;
      break;
    end;
end;

procedure TPlayer.ChangeSkills(x1: integer; x2: integer; x3: integer);
begin
  fStats[1] := fInvestigator.stat[1] + x1;
  fStats[2] := fInvestigator.stat[2] - x1;

  fStats[3] := fInvestigator.stat[3] + x2;
  fStats[4] := fInvestigator.stat[4] - x2;

  fStats[5] := fInvestigator.stat[5] + x3;
  fStats[6] := fInvestigator.stat[6] - x3;

end;

procedure TPlayer.MoveToLocation(id_lok: integer);
begin
  fLocation := id_lok;
  fNeighborhood := (id_lok div 1000) * 1000; // ?
end;

procedure TPlayer.GetItems;
var
  i: Integer;
begin
  for i := 1 to Investigator.items_count do
    AddItem(Common_Items_Deck, Investigator.items[i]);
end;

procedure TPlayer.activate_item(item_id: Integer);
var
  item_count, i: integer;
begin
  item_count := 1;
  for i := 1 to 4 do
    if active_cards[i] <> 0 then
      item_count := item_count + 1;

  if item_count < 5 then
    active_cards[item_count] := item_id;

end;

procedure TPlayer.TakeWeapon(item1: integer);
begin
  if IntToStr(item1)[1] = '1' then // Common item
  begin
    hands_taken := hands_taken + Common_Items_Deck.GetCardByID(item1).hands;
    if hands_taken <= fHands then
      activate_item(item1);
  end;

 { if IntToStr(item1)[1] = '2' then // Unique item
  begin
    hands_taken := hands_taken + Unique_Items_Deck.GetCardByID(item1).hands;
    if hands_taken <= fHands then
      activate_item(item1);
  end;

  if IntToStr(item1)[1] = '3' then // Spell
  begin
    hands_taken := hands_taken + Spells_Deck.GetCardByID(item1).hands;
    if hands_taken <= fHands then
      activate_item(item1);
  end;  }

end;

procedure TPlayer.DropWeapon;
begin
  hands_taken := 0;
  active_cards[1] := 0;
  active_cards[2] := 0;
  active_cards[3] := 0;
  active_cards[4] := 0;

end;

function TPlayer.CardBonus(stat: integer): integer;
var
  i: Integer;
begin
  Result := 0;
  case stat of
    ST_SPEED:;
    ST_SNEAK:;
    ST_FIGHT:
    begin
      for i := 1 to fCardsCount do
      begin
        if ((Common_Items_Deck.GetCardByID(fCards[i]).crd_type = CT_WEAPON) and
          (Common_Items_Deck.GetCardByID(fCards[i]).prm = 2)) then
          begin
            Common_Items_Deck.IncCounter(i);
            ShowMessage(IntToStr(Common_Items_Deck.GetCardByID(fCards[i]).ccounter));
            Result := Result + Common_Items_Deck.GetCardByID(fCards[i]).prm_value;
          end;
      end;
    end;
    ST_WILL:;
    ST_LORE:;
    ST_LUCK:;
  end;
end;

end.
