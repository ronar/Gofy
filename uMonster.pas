unit uMonster;

interface

uses
  SysUtils, Dialogs, uCommon;

type
  TMonster = class
  private
    fId: integer;
    //monData: string;
    fName: string;
    fAwareness:integer;
    fMovBorder: integer;
    fDimention: integer;
    fHorrorRate: integer;
    fHorrorDmg: integer;
    fToughness: integer;
    fCmbtRate: integer;
    fCmbtDmg: integer;
    fSpec: string[6];
    fLocationId: integer;
    fAmbush: boolean; // Засада
    fEndless: boolean; // Неисчислимость
    fPhysical: integer; // Физ. сопр/иммун
    fMagical: integer; // Маг. сопр/иммун
    fNightmarish: Integer; // Кошмар
    fOverwhelming: integer; // Сокрушение
  public
    property Id: Integer read fId write fId;
    property Name: string read fName write fName;
    property Awareness:integer read fAwareness write fAwareness;
    property MovBorder: integer read fMovBorder write fMovBorder;
    property Dimention: integer read fDimention write fDimention;
    property HorrorRate: integer read fHorrorRate write fHorrorRate;
    property HorrorDmg: integer read fHorrorDmg write fHorrorDmg;
    property Toughness: integer read fToughness write fToughness;
    property CmbtRate: integer read fCmbtRate write fCmbtRate;
    property CmbtDmg: integer read fCmbtDmg write fCmbtDmg;
    property Ambush: boolean read fAmbush write fAmbush;
    property Endless: boolean read fEndless write fEndless;
    property Physical: integer read fPhysical write fPhysical;
    property Magical: integer read fMagical write fMagical;
    property Nightmarish: Integer read fNightmarish write fNightmarish;
    property Overwhelming: Integer read fOverwhelming write fOverwhelming;
    
    //property fSpec: string[6] read fId write fId;
    property LocationId: integer read fLocationId write fLocationId;
    constructor Create();
    function Move(const MobMoveWhite: array of integer; const MobMoveBlack: array of integer): integer;
  end;

  TMonsterArray = array of TMonster;

  function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
  function DrawMonsterCard(monsters: TMonsterArray): TMonster;
  procedure ShuffleMonsterDeck(var monsters_deck: TMonsterArray);
  //procedure MoveMonster(); // TODO: moving of the monsters
  function GetMonsterNameByID(id: integer): string;
  function GetMonsterByID(const monsters: TMonsterArray; id: integer): TMonster; // Get mob from pool
  function GetMonsterCount(const monsters: TMonsterArray): integer;

var
  DeckMobCount: integer = 0; // Kol-vo mobov v pule

implementation

uses
  uMainForm, uStreet;

constructor TMonster.Create;
begin

end;

function TMonster.Move(const MobMoveWhite: array of integer; const MobMoveBlack: array of integer): integer;
var
  i, j: integer;
  lok_id: Integer;
begin
  Result := 0;
  lok_id := fLocationId;
  //case fMovBorder of
    //1: begin  // Black (normal)
      if MobMoveWhite[fDimention - 1] = 1 then // if white mob move in mythos card
      begin
        for i := 1 to 36 do
          if aMonsterMoves[i, 1] = lok_id then
          begin
            Arkham_Streets[ton(fLocationId)].TakeAwayMonster(fLocationId, Self);
            Arkham_Streets[ton(aMonsterMoves[i, 2])].AddMonster(aMonsterMoves[i, 2], Self);
            Result := aMonsterMoves[i, 2];
            break;
          end;
      end;

      if MobMoveBlack[fDimention - 1] = 1 then // if black mob move in mythos card
      begin
        for i := 1 to 36 do
          if aMonsterMoves[i, 1] = lok_id then
          begin
            Arkham_Streets[ton(fLocationId)].TakeAwayMonster(fLocationId, Self);
            Arkham_Streets[ton(aMonsterMoves[i, 3])].AddMonster(aMonsterMoves[i, 3], Self);
            Result := aMonsterMoves[i, 3];
            break;
          end;
      end;

  //  end;
  //2: ; // Stationary (Yellow Border)
  //3: ; // Fast (Red Border)
  //4: ; // Unique (Green Border)
  //5: ; // Flying (Blue Border)
  //end;

end;

function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  s: string;
  i, a, amt, j: integer;
begin
  // задание условий поиска и начало поиска
  FindRes := FindFirst(file_path+'\CardsData\Monsters\' + '*.txt', faAnyFile, SR);

  i := 0;
  a := 0;

  while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
  begin
    AssignFile (F, file_path+'\CardsData\Monsters\' + SR.Name);
    Reset(F);

    amt := StrToInt(Copy(SR.Name, 4, 1));

    for j := 0 to amt - 1 do
    begin
      i := i + 1;
      SetLength(Monsters, i);
      Monsters[i-1] := TMonster.Create;
      with Monsters[i-1] do
      begin
        Id := StrToInt(Copy(SR.Name, 1, 4));
        //monData: string;
        Name := GetMonsterNameByID(Id);
        readln(F, s);
        Awareness   := StrToInt(s);
        readln(F, s);
        MovBorder   := StrToInt(s);
        readln(F, s);
        Dimention   := StrToInt(s);
        readln(F, s);
        HorrorRate := StrToInt(s);
        readln(F, s);
        HorrorDmg  := StrToInt(s);
        readln(F, s);
        Toughness   := StrToInt(s);
        readln(F, s);
        CmbtRate   := StrToInt(s);
        readln(F, s);
        CmbtDmg    := StrToInt(s);
        readln(F, s);
        Ambush     := StrToBool(s);
        readln(F, s);
        Endless    := StrToBool(s);
        readln(F, s);
        Physical   := StrToInt(s);
        readln(F, s);
        Magical    := StrToInt(s);
        readln(F, s);
        Magical    := StrToInt(s);
        readln(F, s);
        Nightmarish:= StrToInt(s);
        readln(F, s);
        Overwhelming:= StrToInt(s);
        //spec: string[6];
      end;
      Reset(F);
    end;

    CloseFile(F);
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;

    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
    //Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));
  end;
  FindClose(SR); // закрываем поиск
  LoadMonsterCards := i;
  DeckMobCount := i;
end;

// Return mob ID
function DrawMonsterCard(monsters: TMonsterArray): TMonster;
var
  i: integer;
  dmonster: TMOnster;
begin
  //Assert(monCount > 1);
  dmonster := nil;

  if DeckMobCount < 1 then
  begin
    frmMain.lstLog.Items.Add('DrawMonsterCard: нету монстров!');
    Result := nil;
    Exit;
  end;

  //ShuffleMonsterDeck(monsters);
  for i := 0 to uMainForm.Monsters_Count - 1 do
  begin
    if monsters[i].fLocationId = 0 then
    begin
      dmonster := monsters[i];
      Result := dmonster;
      Exit;
    end;
  end;

  ShowMessage('Ошибочка! Схватил не того монстра!');
  Result := dmonster;
end;

// TODO: Access violation
procedure ShuffleMonsterDeck(var monsters_deck: TMonsterArray);
var
  i, r: integer;
  temp: TMonster;
begin
  if DeckMobCount < 2 then exit;

  randomize;
  for i := 0 to DeckMobCount - 1 do
  begin
    temp := monsters_deck[i];
    r := random(DeckMobCount);
    monsters_deck[i] := monsters_deck[r];
    monsters_deck[r] := temp;
  end;
end;

//
function GetMonsterNameByID(id: integer): string;
var
  i: integer;
begin
  for i := 1 to MONSTER_MAX do
    if StrToInt(MonsterNames[i, 1]) = id then
    begin
      GetMonsterNameByID := MonsterNames[i, 2];
      break;
    end;
end;

function GetMonsterByID(const monsters: TMonsterArray; id: integer): TMonster;
var
  i: integer;
begin
  for i := 0 to MONSTER_MAX-1 do
  begin
    if Monsters[i].fId = id then
    begin
      GetMonsterByID := Monsters[i];
      //Monsters[i] := nil;
      break;
    end;
  end;

end;

function GetMonsterCount(const monsters: TMonsterArray): integer;
var
  i, c: integer;
begin
  c := 0;
  i := 0;
  while monsters[i].fId <> 0 do
  begin
    c := c + 1;
    i := i + 1;
  end;
  GetMonsterCount := c;
end;

end.
