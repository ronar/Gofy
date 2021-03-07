{***************************************************************************}
{                                                                           }
{           UniqueItemCardDeck                                              }
{                                                                           }
{           Copyright (C) 2019 Ronar                                        }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under ...                                                       }
{***************************************************************************}

unit uUniqueItemCardDeck;

interface

uses
  SysUtils, Classes, uCommon, uCommonItemCardDeck;

type
  TUniqueItemCard = record
    id: integer;
    amt: Integer; // Количество присутсвующих карт в колоде
    ccounter: integer; // how many times card was used
    ccounter_max: integer; // max times uses
    data: string;
    crd_type: Integer; // Weapon, Tome
    exposed: boolean;
    hands: integer;
    price: integer;
    phase_use: integer;
    prm: integer;
    prm_value: integer;
  end;

  TUniqueItemCardDeck = class(TCommonItemCardDeck)
  private
    fCards: array [1..NUMBER_OF_UNIQUE_CARDS] of TUniqueItemCard; // Данные о каждой карте
//    function GetCardID(i: integer): Integer;
//    function GetCardData(i: integer): string;
  public
    constructor Create (crd_type: integer);
//    property card[i: integer]: integer read GetCardID;
    function FindCards(file_path: string): integer; override;
//    function GetCardByID(id: integer): TCommonItemCard;
//    function IndexOfCard(id: integer): integer;
//    function DrawCard: Integer; //overload;
    function DrawWeaponCard: Integer;
    procedure Shuffle(); override;
//    function CheckAvailability(N: integer): boolean;
//    procedure AddCardToDeck(indx: integer);
//    procedure RemoveCardFromDeck(indx: integer);
    //destructor Destroy; override;
  end;


implementation

constructor TUniqueItemCardDeck.Create(crd_type: integer);
var
  i: Integer;
begin
  fCardType := crd_type;
  for i := 1 to NUMBER_OF_UNIQUE_CARDS do
  begin
    fCards[i].id := 0;
    fCards[i].amt := 0;
    fCards[i].ccounter := 0; // how many times card was used
    fCards[i].ccounter_max := 0; // max times uses
    fCards[i].data := '';
    fCards[i].crd_type := 0; // Weapon, Tome
    fCards[i].exposed := False;
    fCards[i].hands := 0;
    fCards[i].price := 0;
    fCards[i].phase_use := 0;
    fCards[i].prm := 0;
    fCards[i].prm_value := 0;

  end;
end;

function TUniqueItemCardDeck.DrawWeaponCard: Integer;
var
  i: integer;
begin
  Result := 0;
  Shuffle;
  for i := 1 to fCount do
  begin
    if fCards[i].crd_type = COMMON_ITEM_WEAPON then
    begin
      Result := fCards[i].id;
      Break;
    end;
  end;

end;

// Поиск файлов в картами
function TUniqueItemCardDeck.FindCards(file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  s: string[80];
  i: integer;
  output_data: TStringList;
procedure SplitData(delimiter: Char; str: string; var output_data: TStringList);
begin
  output_data.Clear;
  output_data.QuoteChar := '''';
  output_data.Delimiter := delimiter;
  output_data.DelimitedText := str;
end;
begin
  // задание условий поиска и начало поиска
  FindRes := FindFirst(file_path + '*.txt', faAnyFile, SR);

  i := 0;
  output_data := TStringList.Create;

  while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
  begin
    i := i + 1;
    AssignFile (F, file_path + SR.Name);
    Reset(F);
    readln(F, s);
    CloseFile(F);
    SplitData('|', s, output_data);
    fCards[i].data := s;
    //fCards[i].id :=
    with fCards[i] do
    begin
      id := StrToInt(Copy(SR.Name, 1, 4));
      amt := StrToInt(Copy(SR.Name, 4, 1));
      exposed := False;
      crd_type := StrToInt(output_data[0]);
      price := StrToInt(output_data[1]);

      hands := StrToInt(output_data[3]);
      phase_use := StrToInt(output_data[4]);
      prm := StrToInt(output_data[5]);
      prm_value := StrToInt(output_data[6]);
    end;


    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
  end;

  output_data.Free;
  FindClose(SR); // закрываем поиск
  FindCards := i;
  fCount := i;
end;

// Тасовка колоды
procedure TUniqueItemCardDeck.Shuffle();
var
  i, r: integer;
  temp: TUniqueItemCard;
begin
  randomize;
  for i := 1 to fCount do
  begin
    temp := fCards[i];
    r := random(fCount);
    fCards[i] := fCards[r+1];
    fCards[r+1] := temp;
  end;
end;
end.
