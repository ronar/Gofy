unit uStreet;

interface
uses uCommon, uCardDeck, SysUtils;

type
  TLocation = record
    lok_id: integer; // id of location (2100, 2200, 2300, etc..)
    lok_name: string;
    clues: integer; // Улики на локации
    gate: TGate; // Врата открытые на локации
    monsters: array [1..5] of integer;
    lok_mon_count: integer;
  end;

  TStreet = class
  private
    fId: integer; // id of streets (1000, 2000, 3000, etc..)
    fLok: array [1..3] of TLocation;
    fDeck: TLocationCardsDeck;
    function GetDeck: TLocationCardsDeck;
  public
    constructor Create(street_id: integer);
    property StreetId: integer read fId write fId;
    property Deck: TLocationCardsDeck read GetDeck;
    function GetLokByID(id: integer): TLocation;
    procedure AddMonster(lok_id: integer; mob_id: integer);
    procedure AddClue(lok_id: integer; n: integer);
    procedure AddGate(lok_id: integer; gate: TGate);
  end;

  function GetLokIDByName(lok_name: string): integer; // Получение ID локации по названию
  function GetStreetIDByName(street_name: string): integer;
  //function GetStreetIndxByLokID(id: integer): integer; // Searches the array for location that matches the id param
  function GetStreetNameByID(id: integer): string;


implementation

constructor TStreet.Create(street_id: integer);
var
  n: integer;
begin
  //for i := 1 to NUMBER_OF_STREETS do
  begin
      fId := street_id;
      for n := 1 to 3 do
      begin
        fLok[n].lok_id := fId + 100 * n;
        fLok[n].clues := 0;
        fLok[n].gate.other_world := 0;
        fLok[n].gate.modif := 0;
        fLok[n].gate.dimension := 0;
        fLok[n].monsters[1] := 0;
        fLok[n].monsters[2] := 0;
        fLok[n].monsters[3] := 0;
        fLok[n].monsters[4] := 0;
        fLok[n].monsters[5] := 0;
        fLok[n].lok_mon_count := 0;
    end;
    fDeck := TLocationCardsDeck.Create;

  end;
end;

function TStreet.GetDeck: TLocationCardsDeck;
begin
  result := fDeck;
end;

function TStreet.GetLokByID(id: integer): TLocation;
var
  i: integer;
  ln: integer;
begin
  //ln := GetStreetIndxByLokID( ton(id) * 1000 );
  result := fLok[hon(id)];
end;


// Берет назв. локи из массива LocationsNames
function GetLokIDByName(lok_name: string): integer;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_LOCATIONS do
    if ((aLocationsNames[i, 2] = lok_name) AND (StrToInt(aLocationsNames[i, 1]) > 1000)) then
    begin
      result := StrToInt(aLocationsNames[i, 1]);
      break;
    end
    else
      result := 1100;
end;

function GetStreetIDByName(street_name: string): integer;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_LOCATIONS do
    if ((aLocationsNames[i, 2] = street_name) AND (StrToInt(aLocationsNames[i, 1]) > 1000)) then
    begin
      result := StrToInt(aLocationsNames[i, 1]);
      break;
    end
    else
      result := 1100;
end;

// Searches the array for location that matches the id param
{function GetStreetIndxByLokID(id: integer): integer;
var
  i: integer;
  st: integer;
begin
  st := ton(id) * 1000;
  for i := 1 to NUMBER_OF_STREETS do
    if Arkham_Streets[i].fId = st then
    begin
      result := i;
      break;
    end;
end;        }

function GetStreetNameByID(id: integer): string;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_STREETS do
    if StrToInt(aNeighborhoodsNames[i, 1]) = id then
      GetStreetNameByID := aNeighborhoodsNames[i, 2];
end;

procedure TStreet.AddMonster(lok_id: integer; mob_id: integer);
begin
  fLok[hon(lok_id)].monsters[1] := mob_id;
  fLok[hon(lok_id)].lok_mon_count := fLok[hon(lok_id)].lok_mon_count + 1;
end;

procedure TStreet.AddClue(lok_id: integer; n: integer);
begin
  fLok[hon(lok_id)].clues := fLok[hon(lok_id)].clues + n;
end;

procedure TStreet.AddGate(lok_id: integer; gate: TGate);
var
  lokk: TLocation;
begin
  lokk := GetLokByID(lok_id);
  lokk.gate.other_world := gate.other_world;
  lokk.gate.modif := gate.modif;
  lokk.gate.dimension := gate.dimension;
end;

end.
