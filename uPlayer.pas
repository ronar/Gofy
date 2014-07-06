unit uPlayer;

interface
uses
  SysUtils, Dialogs, uCardDeck, uChsLok, uInvestigator, uCommon, ExtCtrls,
  Controls, uStreet;

type
  TPlayer = class
  private
    fLocation: integer; // Player's location
    fNeighborhood: integer; // Neighbourhood of the player's location (for easy ref. instead of hon(..) func.)
    fCards: array [1..MAX_PLAYER_ITEMS] of integer; // Player's items
    fExposedCards: array [1..MAX_PLAYER_ITEMS] of boolean; // Player's items
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
    fStats: array [1..6] of integer; // ����� ������ (1 - ��������, 2 - ����������)
    fBonusStats: array [1..6] of integer; // �������� �� ���� �������, ����.
    fBlessed: boolean;
    fCursed: boolean;
    fFirstPlayer: boolean; // ���� ������� ������
    fInvestigator: TInvestigator;
    fMoves: integer; // ���-�� ���������� �����
    fPlNumber: integer;
    fHands: Integer; // Number of hands :)
    fRollResults: array [1..20] of integer;
    fDelayed: Boolean; // if delayed then pass the turn
    fExploredMarker: boolean;
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
    active_cards: array [1..4] of integer; // i.e. on hands (store id's)
    hands_taken: integer;
    evadedmosnters: array [1..5] of integer; // id of mobs which player succesfully evaded
    constructor Create(var init_stats: array of integer; first_player: boolean);
    destructor Destroy; override;
    property Location: integer read fLocation write fLocation; // id ������� � ���� xxy, ��� (�� - ����� �����, y - ����� �������)
    property Neighborhood: integer read fNeighborhood write fNeighborhood; // id ����������� �����
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
    property Moves: integer read fMoves write fMoves;
    property bFirstPlayer: boolean read fFirstPlayer write fFirstPlayer;
    property Investigator: TInvestigator read fInvestigator;
    property Delayed: Boolean read fDelayed write fDelayed; // if delayed then pass the turn
    //property Hands: integer read fHands;
    procedure DrawCard(card_id: integer);
    procedure AddItem(var cards: TCommonItemCardDeck; id: integer);
    procedure GiveClue(num: integer);
    procedure AddMonsterTrophies(mon_id: integer);
    procedure AssignInvestigator(inv: TInvestigator);
    //function Get_Item(indx: integer): integer;
    function RollADice(stat: integer; difficulty: integer): integer;
    procedure Encounter(var Locations_Deck: TCardDeck);
    function CheckAvailability(grade: integer; param: integer): boolean;
    function HasItem(ID: integer): boolean;
    procedure ChangeSkills(x1: integer; x2: integer; x3: integer);
    procedure MoveToLocation(from_lok: TLocation; to_lok: TLocation);
    procedure MoveToStreet(from_lok: TLocation; st: TStreet);
    procedure GetItems; // Copy investigator's items to player
    procedure TakeWeapon(item1: integer); // Take choosen card to hands
    procedure DropCard(indx: Integer);  // Drop card from player's possession
    procedure DropWeapon; // Take choosen card to hands
    procedure activate_item(item_id: Integer); // Activate weapon
    function CardBonus(stat: integer): Integer; // Bonuses from cards?
    function BonusWeapon: Integer; // Bonuses from weapon
    procedure ExposedCards(var exposed_array: array of Boolean);
    procedure Explored;
    function CloseGate: boolean;
    //procedure
    //property Speed: integer read Stats[1] write Stats[1];
  end;

implementation

uses uMainForm;

// ����������� ������
constructor TPlayer.Create(var init_stats: array of integer; first_player: boolean);
var
  i: integer;
begin
  fCardsCount := 0;
  fMonsterTrophiesCount := 0;
  fStamina := 0;
  fSanity := 0;
  fFocus := 0;
  fExploredMarker := True;
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

// ���������� ������� TPlayer
destructor TPlayer.Destroy;
begin
  inherited;
end;

// �������: ������ ����� �� ������
procedure TPlayer.DrawCard(card_id: integer);
begin
  //Items_Count := Items_Count + 1;
  //SetLength(Cards, Items_Count);
  //Cards[Items_Count] := Card_ID;
end;

// �������: ��������� �������� �� �������.
// ������� �������� �� ������, � �� ��������
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

procedure TPlayer.GiveClue(num: integer);
begin
  fClues := fClues + 1;
end;

procedure TPlayer.AddMonsterTrophies(mon_id: integer);
begin
  fMonsterTrophiesCount := fMonsterTrophiesCount + 1;
  fMonsterTrophies[fMonsterTrophiesCount] := mon_id;
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

// ������ ������ (���������� ����� �������, 0 - ������)
// Rename this func to SkillCheck
function TPlayer.RollADice(stat: integer; difficulty: integer): integer; // stat - exactly value of stat
var
  r, i, s: integer;
  Successes: integer;
begin
  randomize;
  Successes := 0;
  s := stat;
  i := 0;
  while (Successes < difficulty) do
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
      while i < s do
      begin
        i := i + 1;
        fRollResults[i]:=random(6)+1;
        // Deprecated
        if i < 13 then
        begin
          case fRollResults[i] of
          1: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\1.jpg');
          2: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\2.jpg');
          3: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\3.jpg');
          4: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\4.jpg');
          5: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\5.jpg');
          6: (frmMain.FindComponent('imgDR'+IntToStr(i)) as TImage).Picture.LoadFromFile(path_to_exe+'\Pictures\6.jpg');
          end;
        end;
        // !Deprecated

        if fRollResults[i]>=5 then
        begin
          Successes := Successes + 1;
          //broskub.usp:=true;
          //broskub.kolusp:=broskub.kolusp+1;
          //if broskub.resbroskub[i]=6 then broskub.kolusp6:=broskub.kolusp6+1;
        end;

      end;
    end;


    RollADice := Successes; { TODO : �������� ��������� ������ }
    if ((Successes < difficulty) and (fClues > 0)) then
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
        s := s + 1;
        if s < 1 then
          s := 1;
      end;
    end
    else
      break;
  end; // While
end;


// ��������� �������
procedure TPlayer.Encounter(var Locations_Deck: TCardDeck);
begin

end;

function TPlayer.CheckAvailability(grade: integer; param: integer): boolean;
var
  i: Integer;
begin
  result := false;

  if grade = 10 then // �������� ������� ����
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

procedure TPlayer.MoveToLocation(from_lok: TLocation; to_lok: TLocation);
var
  i, j: integer;
  num_of_evaded_mobs: integer;
begin
  if fMoves = 0 then
  begin
    ShowMessage('��� �����!');
    exit;
  end;

  num_of_evaded_mobs := 0;
  for i := 1 to 5 do
    if evadedmosnters[i] <> 0 then
      num_of_evaded_mobs := num_of_evaded_mobs + 1;

  if (num_of_evaded_mobs <> from_lok.lok_mon_count) and (from_lok.lok_id <> 0) then
    ShowMessage('������ ������� �������! ������� ���� �� ������� ����� ���� ��� ��������.')
  else
  begin
    if to_lok.HasGate then // Drawn into gate
    begin
      fLocation := to_lok.gate.other_world;
      fMoves := 0;
      frmMain.lstLog.Items.Add('������ �������� �� �����!');
    end
    else
    begin
      fLocation := to_lok.lok_id;
      fNeighborhood := (to_lok.lok_id div 1000) * 1000; // ?
      fMoves := fMoves - 1;
      frmMain.lstLog.Items.Add('����� ������� � ������� ' + GetLokNameByID(fLocation));
    end;
  end;
end;

procedure TPlayer.MoveToStreet(from_lok: TLocation; st: TStreet);
var
  i, j: integer;
  num_of_evaded_mobs: integer;
begin
  if fMoves = 0 then
  begin
    ShowMessage('��� �����!');
    exit;
  end;

  num_of_evaded_mobs := 0;
  for i := 1 to 5 do
    if evadedmosnters[i] <> 0 then
      num_of_evaded_mobs := num_of_evaded_mobs + 1;

  if (num_of_evaded_mobs <> from_lok.lok_mon_count) and (from_lok.lok_id <> 0) then
    ShowMessage('������ ������� �������! ������� ���� �� ������� ����� ���� ��� ��������.')
  else
  begin
    fLocation := st.StreetId;
    fNeighborhood := st.StreetId; // ?
    fMoves := fMoves - 1;
    frmMain.lstLog.Items.Add('����� ������� �� ����� ' + GetLokNameByID(fLocation));
  end;

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

procedure TPlayer.DropCard(indx: Integer); // Drop card from player's possession
var
  i: integer;
begin
  if indx <> 0 then
  begin
    fCards[indx] := 0;
    for i := indx to fCardsCount do
    begin
      fCards[i] := fCards[i + 1]; 
    end;
    fCardsCount := fCardsCount - 1;
  end;
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

function TPlayer.BonusWeapon: Integer; // Bonuses from weapon
var
  i, bonus: Integer;
begin
  bonus := 0;
  for i := 1 to 4 do
    if active_cards[i] <> 0 then
      bonus := bonus + Common_Items_Deck.GetCardByID(active_cards[i]).prm_value
    else
      Break;
  Result := bonus;
end;

procedure TPlayer.ExposedCards(var exposed_array: array of Boolean);
var
  i: integer;
begin
  for i := 1 to fCardsCount do
  begin
    exposed_array[i] := fExposedCards[i];
  end;

end;

procedure TPlayer.Explored;
begin
  fExploredMarker := True;
end;

function TPlayer.CloseGate: boolean;
begin
  if not fExploredMarker then
  begin
    ShowMessage('���� ������� ���������������!');
    Result := False;
    Exit;
  end;
  //ShowMessage(IntToStr(Arkham_Streets[ton(fLocation)].GetLokByID(fLocation).gate.modif));
  if RollADice(fStats[3] + Arkham_Streets[ton(fLocation)].GetLokByID(fLocation).gate.modif, 1) < 1 then
    if RollADice(fStats[5] + Arkham_Streets[ton(fLocation)].GetLokByID(fLocation).gate.modif, 1) < 1 then
    begin
      Result := False;
      Exit;
    end;
  // TODO: try except?
  Arkham_Streets[ton(fLocation)].CloseGate(fLocation);
  Result := true;
end;

end.
