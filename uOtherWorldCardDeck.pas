{***************************************************************************}
{                                                                           }
{           OtherWorldCardDeck                                              }
{                                                                           }
{           Copyright (C) 2019 Ronar                                        }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under ...                                                       }
{***************************************************************************}

unit uOtherWorldCardDeck;

interface

uses
  SysUtils, uCommon, uCardXML, uCardDeck, uInvestigator, uMythos;

type
  TOWLocationCard = record
    id: integer;
    crd_head: PLLData;
    color: integer;
  end;

  TOtherWorldCardDeck = class(TCardDeck) // Карты контактов иного мира
  private
    fCards: array [1..NUMBER_OF_OW_ENCOUNTER_CARDS] of TOWLocationCard; // Данные о каждой карте

    function GetCard(n: integer): TOWLocationCard; // Получает карту из колоды (для трех локаций улицы). Для св-ва.
    //function GetLokation: integer;
    //function GetNom: integer;
    //procedure SetLok;
  public
    constructor Create;
    //destructor Destroy; override;
    function GetCardID(n: integer): Integer; overload; // Получить ID карты по порядковому номеру
    function GetCardData(n: integer): PLLData; overload; // Получить данные карты по порядковому номеру
    function FindCards(file_path: string): integer; override;
    function DrawCard(n: integer): TOWLocationCard; // Returns ID of the card on top of the deck
    property cards[n: integer]: TOWLocationCard read GetCard;
    //property Nom: integer;
    procedure Shuffle();
    //function Get_Card_By_ID(id: integer): TCard; // Нахождение карты по ее ID
  end;

implementation

constructor TOtherWorldCardDeck.Create;
var
  i, j: Integer;
begin
  fCardType := CT_OW_ENCOUNTER;
  for i := 1 to NUMBER_OF_OW_ENCOUNTER_CARDS do
//    for j := 1 to 3 do
    begin
      fCards[i].id := 0;
      fCards[i].crd_head := nil;
      fCards[i].color := 0;
    end;
end;

// id - number of card in deck
function TOtherWorldCardDeck.GetCard(n: integer): TOWLocationCard;
var
  i: integer;
begin
  Result := fCards[n];
end;


// Получение ID карты
function TOtherWorldCardDeck.GetCardID(n: integer): integer;
begin
  GetCardID := fCards[n].id;
end;

// Получение данных карты
function TOtherWorldCardDeck.GetCardData(n: integer): PLLData;
begin
  GetCardData := fCards[n].crd_head;
end;


// n - номе карты
function TOtherWorldCardDeck.DrawCard(n: integer): TOWLocationCard;
begin
  DrawCard := fCards[n];//n];
  //Shuffle;
end;

// Поиск файлов с картами
function TOtherWorldCardDeck.FindCards(file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  s: string[80];
  i, n, crd_num: integer;
begin
  // задание условий поиска и начало поиска
  FindRes := FindFirst(file_path + '*.xml', faAnyFile, SR);

  i := 0;
  n := 0;

  while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
  begin
    //ShowMessage(Copy(SR.Name, 2, 1));
    crd_num := StrToInt(Copy(SR.Name, 2, 2));
    i := i + 1;
    fCards[i].id := StrToInt(Copy(SR.Name, 1, 3));
    New(fCards[i].crd_head);
    fCards[i].color := StrToInt(Copy(SR.Name, 1, 1));
    fCards[i].crd_head.mnChildCount := 0;
    fCards[i].crd_head.data := '';
    XML2LL(fCards[i].crd_head, file_path + SR.Name);
    //ShowMessage(Format('%s', [fCards[i, n].crd_head.mnChild[0].data]));
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;


    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
  end;

  FindClose(SR); // закрываем поиск
  FindCards := i;
  fCount := i;
end;

// Тасовка колоды
procedure TOtherWorldCardDeck.Shuffle();
var
  i, j, r: integer;
  temp: TOWLocationCard;
begin
  randomize;
  for i := 1 to fCount do
  begin
    r := random(fCount);
    temp := fCards[i];
    fCards[i] := fCards[r+1];
    fCards[r+1] := temp;
  end;
end;

end.
