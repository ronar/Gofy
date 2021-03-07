{******************************************************************************}
{                                                                              }
{ Gofy - Arkham Horror Card Game                                               }
{                                                                              }
{ The contents of this file are subject to the Mozilla Public License Version  }
{ 1.0 (the "License"); you may not use this file except in compliance with the }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/ }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ The Original Code is CommonItemCardDeck.pas.                                 }
{                                                                              }
{ Contains logic for handling common card.                                     }
{                                                                              }
{ Unit owner:    Ronar                                                         }
{ Last modified: March 7, 2021                                                 }
{                                                                              }
{******************************************************************************}

unit uCommonItemCardDeck;

interface

uses
  SysUtils, Classes, uCommon, uCardDeck;

type
  TCommonItemCard = record
    id: integer;
    amt: Integer; // Количество присутсвующих карт в колоде
    ccounter: integer; // how many times card was used
    ccounter_max: integer; // max times uses
    data: string;
    cardType: Integer; // Weapon, Tome
    exposed: boolean;
    hands: integer;
    price: integer;
    phase_use: integer;
    prm: integer;
    prm_value: integer;
  end;

  TCommonItemCardDeck = class(TCardDeck)
  private
    fCards: array [1..NUMBER_OF_COMMON_CARDS] of TCommonItemCard; // Данные о каждой карте
    function GetCardID(i: integer): Integer;
    function GetCardData(i: integer): string;
  public
    constructor Create (CardType: integer);
    property card[i: integer]: integer read GetCardID;
    function FindCards(file_path: string): integer; override;
    function GetCardByID(id: integer): TCommonItemCard;
    function IndexOfCard(id: integer): integer;
    function DrawCard: Integer; //overload;
    function DrawWeaponCard: Integer;
    procedure Shuffle(); override;
    function CheckAvailability(N: integer): boolean;
    procedure IncCounter(indx: integer); // Увеличивает счетчик карты
    procedure DecCounter(indx: integer); // Уменьшает счетчик карты
    procedure AddCardToDeck(indx: integer);
    procedure RemoveCardFromDeck(indx: integer);
    //destructor Destroy; override;
  end;

implementation

constructor TCommonItemCardDeck.Create(CardType: integer);
var
  i: Integer;
begin
  fCardType := CardType;
  for i := 1 to NUMBER_OF_COMMON_CARDS do
  begin
    fCards[i].id := 0;
    fCards[i].amt := 0;
    fCards[i].ccounter := 0; // how many times card was used
    fCards[i].ccounter_max := 0; // max times uses
    fCards[i].data := '';
    fCards[i].cardType := 0; // Weapon, Tome
    fCards[i].exposed := False;
    fCards[i].hands := 0;
    fCards[i].price := 0;
    fCards[i].phase_use := 0;
    fCards[i].prm := 0;
    fCards[i].prm_value := 0;

  end;
end;

function TCommonItemCardDeck.GetCardByID(id: integer): TCommonItemCard;
var
  i: integer;
begin
  for i:= 1 to fCount do
  begin
    if fCards[i].id = id then
    begin
      GetCardByID := fCards[i];
      break;
    end;
  end;
end;

function TCommonItemCardDeck.IndexOfCard(id: integer): integer;
var
  i: integer;
begin
  for i:= 1 to fCount do
  begin
    if fCards[i].id = id then
    begin
      IndexOfCard := i;
      break;
    end;
  end;
end;

// Получение ID карты
function TCommonItemCardDeck.GetCardID(i: integer): integer;
begin
  GetCardID := fCards[i].id;
end;

// Получение данных карты (указатель на голову связного списка)
function TCommonItemCardDeck.GetCardData(i: integer): string;
begin
  GetCardData := fCards[i].data;
end;

function TCommonItemCardDeck.DrawCard: Integer;
begin
  Shuffle;
  DrawCard := fCards[fCount].id;
end;

function TCommonItemCardDeck.DrawWeaponCard: Integer;
var
  i: integer;
begin
  Result := 0;
  Shuffle;
  for i := 1 to fCount do
  begin
    if fCards[i].cardType = COMMON_ITEM_WEAPON then
    begin
      Result := fCards[i].id;
      Break;
    end;
  end;

end;

// Поиск файлов в картами
function TCommonItemCardDeck.FindCards(file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // Поисковая переменная
  FindRes: Integer; // Переменная для записи результата поиска
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
  // Задание условий поиска и начало поиска
  FindRes := FindFirst(file_path + '*.txt', faAnyFile, SR);

  i := 0;
  output_data := TStringList.Create;

  while FindRes = 0 do // Пока мы находим файлы (каталоги), то выполнять цикл

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
      fCardType := StrToInt(output_data[0]);
      price := StrToInt(output_data[1]);

      hands := StrToInt(output_data[3]);
      phase_use := StrToInt(output_data[4]);
      prm := StrToInt(output_data[5]);
      prm_value := StrToInt(output_data[6]);
     end;


    FindRes := FindNext(SR); // Продолжение поиска по заданным условиям
  end;
  output_data.Free;
  FindClose(SR); // Закрываем поиск
  FindCards := i;
  fCount := i;
end;

// Тасовка колоды
procedure TCommonItemCardDeck.Shuffle();
var
  i, r: integer;
  temp: TCommonItemCard;
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

function TCommonItemCardDeck.CheckAvailability(N: integer): boolean;
var
  i: Integer;
begin
  result := false;
  for i := 1 to fCount do
    if fCards[i].id = N then
      result := true;
end;

procedure TCommonItemCardDeck.IncCounter(indx: integer);
begin
  fCards[indx].ccounter := fCards[indx].ccounter + 1;
end;

procedure TCommonItemCardDeck.DecCounter(indx: integer);
begin
  fCards[indx].ccounter := fCards[indx].ccounter - 1;
end;

// Добавление карты в колоду (например, при возвращении)
procedure TCommonItemCardDeck.AddCardToDeck(indx: integer);
begin
  if fCards[indx].amt < StrToInt(IntToStr(fCards[indx].id)[4]) then
    fCards[indx].amt := fCards[indx].amt + 1;
end;

// Удаление карты из колоды (при передаче ее игроку)
procedure TCommonItemCardDeck.RemoveCardFromDeck(indx: integer);
begin
  if fCards[indx].amt > 0 then
    fCards[indx].amt := fCards[indx].amt - 1;
end;


end.
