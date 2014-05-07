unit uInvestigator;

interface

type
  TInvestigator = class
  private
    fId: integer;
    fName: string;
    fSanity: integer;
    fStamina: integer;
    fStartLok: integer;
    fMoney: integer;
    fClues: integer;
    fItems: array [1..10] of integer; // Possessions including of player's choises
    fItemsCount: integer; // How many different items in investigator's possession
    fCanTake: array [1..5] of integer; // How many of certain item
    fAlly: integer;
    fFocus: integer;
    fStats: array [1..6] of integer;
    function GetStat(i: integer): integer;
    function GetItem(i: integer): integer;
    function GetCanTake(i: integer): integer;
    procedure SetCanTake(i, value: integer);
    procedure SetSpeed(value: integer);
    procedure SetSneak(value: integer);
    procedure SetFight(value: integer);
    procedure SetWill(value: integer);
    procedure Setlore(value: integer);
    procedure SetLuck(value: integer);
  public
    property id: Integer read fId write fId;
    property name: string read fName write fName;
    property sanity: Integer read fSanity write fSanity;
    property stamina: Integer read fStamina write fStamina;
    property start_lok: Integer read fStartLok write fStartLok;
    property money: Integer read fMoney write fMoney;
    property clues: Integer read fClues write fClues;
    property items[i: integer]: Integer read GetItem;
    property items_count: Integer read fItemsCount;
    property can_take[i: integer]: integer read GetCanTake write SetCanTake;
    property ally: Integer read fAlly write fAlly;
    property focus: Integer read fFocus write fFocus;
    property stat[i: integer]: integer read GetStat;
    property speed: integer write SetSpeed;
    property sneak: integer write SetSneak;
    property fight: integer write SetFight;
    property will: integer write SetWill;
    property lore: integer write SetLore;
    property luck: integer write SetLuck;
    constructor Create;
    procedure AddItem(item_id: integer); // Adding items on start screen
    //procedure SetCanTake(i, j, value: integer);
  end;


implementation

constructor TInvestigator.Create();
var
  i, j, k: Integer;
begin
    name := 'Noname';
      sanity := 0;
      stamina := 0;
      start_lok := 0;
      money := 0;
      clues := 0;
      for i := 1 to 10 do
        fItems[i] := 0; // Possessions
      fItemsCount := 0; // How many different items is in investigator's possession
      ally := 0;
      focus := 0;
      speed := 0;
      sneak := 0;
      fight := 0;
      will := 0;
      lore := 0;
      luck := 0;
      for i := 1 to 5 do
        fCanTake[i] := 0; // How many
end;

function TInvestigator.GetStat(i: integer): integer;
begin
  GetStat := fStats[i];
end;

procedure TInvestigator.SetSpeed(value: integer);
begin
  fStats[1] := value;
end;

procedure TInvestigator.SetSneak(value: integer);
begin
  fStats[2] := value;
end;

procedure TInvestigator.SetFight(value: integer);
begin
  fStats[3] := value;
end;

procedure TInvestigator.SetWill(value: integer);
begin
  fStats[4] := value;
end;

procedure TInvestigator.SetLore(value: integer);
begin
  fStats[5] := value;
end;

procedure TInvestigator.SetLuck(value: integer);
begin
  fStats[6] := value;
end;

procedure TInvestigator.AddItem(item_id: integer);
begin
  fItemsCount := fItemsCount + 1;
  fItems[fItemsCount] := item_id;
end;

function TInvestigator.GetItem(i: integer): integer;
begin
  GetItem := fItems[i];
end;

function TInvestigator.GetCanTake(i: integer): integer;
begin
  GetCanTake := fCanTake[i];
end;

procedure TInvestigator.SetCanTake(i, value: integer);
begin
  fCanTake[i] := value;
end;

end.
