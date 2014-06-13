unit uMonster;

interface

uses
  SysUtils, Dialogs, uCommon;

type
  TMonster = record
  //private
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
    fLocation: integer;
  //public

  end;

  TMonsterArray = array of TMonster;

  function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
  function DrawMonsterCard(var monsters: TMonsterArray): integer;
  procedure ShuffleMonsterDeck(var monsters: TMonsterArray);
  //procedure MoveMonster(); // TODO: moving of the monsters
  function GetMonsterNameByID(id: integer): string;
  function GetMonsterByID(var monsters: TMonsterArray; id: integer): TMonster; // Get mob from pool
  function GetMonsterCount(var monsters: TMonsterArray): integer;

implementation

var
  monCount: integer = 0;

function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  s: string;
  i, a: integer;
begin
  // задание условий поиска и начало поиска
  FindRes := FindFirst(file_path+'\CardsData\Monsters\' + '*.txt', faAnyFile, SR);

  i := 0;
  a := 0;

  while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
  begin
    i := i + 1;
    AssignFile (F, file_path+'\CardsData\Monsters\' + SR.Name);
    Reset(F);
      //read(F, );
      //i := i + 1;
    SetLength(Monsters, i);
    with Monsters[i-1] do
    begin
      fId := StrToInt(Copy(SR.Name, 1, 3));
      //monData: string;
      fName := GetMonsterNameByID(fId);
      readln(F, s);
      fAwareness   := StrToInt(s);
      readln(F, s);
      fMovBorder   := StrToInt(s);
      readln(F, s);
      fDimention   := StrToInt(s);
      readln(F, s);
      fHorrorRate := StrToInt(s);
      readln(F, s);
      fHorrorDmg  := StrToInt(s);
      readln(F, s);
      fToughness   := StrToInt(s);
      readln(F, s);
      fCmbtRate   := StrToInt(s);
      readln(F, s);
      fCmbtDmg    := StrToInt(s);
      //spec: string[6];
    end;

    CloseFile(F);
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;

    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
    //Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));
  end;
  FindClose(SR); // закрываем поиск
  LoadMonsterCards := i;
  monCount := i;
end;

// Return mob ID
function DrawMonsterCard(var monsters: TMonsterArray): integer;
var
  i: integer;
  dmonster: integer;
begin
  //Assert(monCount > 1);
  dmonster := 0;
  if monCount < 1 then
  begin
    ShowMessage('Нету монстров.');
    DrawMonsterCard := 0;
    Exit;
  end;
  randomize;
  dmonster := monsters[random(monCount)].fId;
  if dmonster = 22 then
    ShowMessage('Alert!');
  Result := dmonster;
  //ShuffleMonsterDeck(monsters);
  monCount := monCount - 1;
end;

// TODO: Access violation
procedure ShuffleMonsterDeck(var monsters: TMonsterArray);
var
  i, r: integer;
  temp: TMonster;
begin
  randomize;
  for i := 0 to monCount-1 do
  begin
    temp := monsters[i];
    r := random(monCount);
    monsters[i] := monsters[r];
    monsters[r] := temp;
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

function GetMonsterByID(var monsters: TMonsterArray; id: integer): TMonster;
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

function GetMonsterCount(var monsters: TMonsterArray): integer;
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
