unit uMonster;

interface

uses
  SysUtils, uCommon;

type
  TMonster = record
    id: integer;
    //monData: string;
    name: string;
    awareness:integer;
    movBorder: integer;
    dimention: integer;
    horror_rate: integer;
    horror_dmg: integer;
    toughness: integer;
    cmbt_rate: integer;
    cmbt_dmg: integer;
    spec: string[6];
  end;

  TMonsterArray = array of TMonster;

  function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
  function GetMonsterNameByID(id: integer): string;
  function GetMonsterByID(var monsters: TMonsterArray; id: integer): TMonster; // Get mob from pool

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
      id := StrToInt(Copy(SR.Name, 1, 3));
      //monData: string;
      name := GetMonsterNameByID(id);
      readln(F, s);
      awareness   := StrToInt(s);
      readln(F, s);
      movBorder   := StrToInt(s);
      readln(F, s);
      dimention   := StrToInt(s);
      readln(F, s);
      horror_rate := StrToInt(s);
      readln(F, s);
      horror_dmg  := StrToInt(s);
      readln(F, s);
      toughness   := StrToInt(s);
      readln(F, s);
      cmbt_rate   := StrToInt(s);
      readln(F, s);
      cmbt_dmg    := StrToInt(s);
      //spec: string[6];
    end;

    CloseFile(F);
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;

    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
    //Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));
  end;
  FindClose(SR); // закрываем поиск
  LoadMonsterCards := i;
  //monCount := i;
end;

//
function GetMonsterNameByID(id: integer): string;
var
  i: integer;
begin
  for i := 1 to MONSTER_MAX do
    if StrToInt(MonsterNames[i, 1]) = id then
      GetMonsterNameByID := MonsterNames[i, 2];
end;

function GetMonsterByID(var monsters: TMonsterArray; id: integer): TMonster;
var
  i: integer;
begin
  for i := 1 to monCount do
  begin
    if Monsters[i].id = id then
      GetMonsterByID := Monsters[i];
      //Monsters[i] := nil;
  end;

end;

end.
