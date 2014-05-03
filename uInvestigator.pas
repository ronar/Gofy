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
    //items: array [1..10] of integer; // Random possessions
    fItemsCount: integer; // How many different items in investigator's possession
    fAlly: integer;
    fFocus: integer;
    fStats: array [1..6] of integer;
    function GetStat(i: integer): integer;
    procedure SetSpeed(value: integer);
    procedure SetSneak(value: integer);
    procedure SetFight(value: integer);
    procedure SetWill(value: integer);
    procedure Setlore(value: integer);
    procedure SetLuck(value: integer);
    //can_take: array [1..4, 1..2] of integer; // What, how many
  public
    property id: Integer read fId write fId;
    property name: string read fName write fName;
    property sanity: Integer read fSanity write fSanity;
    property stamina: Integer read fStamina write fStamina;
    property start_lok: Integer read fStartLok write fStartLok;
    property money: Integer read fMoney write fMoney;
    property clues: Integer read fClues write fClues;
    property items_count: Integer read fItemsCount write fItemsCount;
    property ally: Integer read fAlly write fAlly;
    property focus: Integer read fFocus write fFocus;
    property stat[i: integer]: integer read GetStat;
    property speed: integer write SetSpeed;
    property sneak: integer write SetSneak;
    property fight: integer write SetFight;
    property will: integer write SetWill;
    property lore: integer write SetLore;
    property luck: integer write SetLuck;

    //procedure Investigator; // Процедура для игры, позволяет сделать то что написано на карте сыщика
  end;


implementation

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


end.
