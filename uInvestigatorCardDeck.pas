{***************************************************************************}
{                                                                           }
{           InvestigatorCardDeck                                            }
{                                                                           }
{           Copyright (C) 2019 Ronar                                        }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under ...                                                       }
{***************************************************************************}

unit uInvestigatorCardDeck;

interface

uses
  SysUtils, Classes, uCommon, uCardDeck, uInvestigator;

type
  TInvestigatorCardDeck = class(TCardDeck)
  private
    fCards: array [1..NUMBER_OF_INVESTIGATORS] of TInvestigator; // Данные о каждой карте
    function GetCardByID(id: integer): TInvestigator;
    function GetCardID(i: integer): Integer;
    function GetCardData(i: integer): string;
  public
    constructor Create(crd_type: integer);
    property card[i: integer]: TInvestigator read GetCardByID;
    function FindCards(file_path: string): integer; override;
    function DrawCard: Integer; //overload;
    procedure Shuffle(); override;
    destructor Destroy; override;
  end;

implementation

constructor TInvestigatorCardDeck.Create(crd_type: integer);
var
  i, j, k: Integer;
begin
  fCardType := crd_type;
  for i := 1 to NUMBER_OF_INVESTIGATORS do
  begin
    fCards[i] := TInvestigator.Create;
  end;

end;

destructor TInvestigatorCardDeck.Destroy;
var
  i: Integer;
begin
  for i := 1 to NUMBER_OF_INVESTIGATORS do
    fCards[i].Free;
end;

function TInvestigatorCardDeck.GetCardByID(id: integer): TInvestigator;
var
  i: integer;
begin
  GetCardByID := fCards[i];
end;

// Получение ID карты
function TInvestigatorCardDeck.GetCardID(i: integer): integer;
begin
 // GetCardID := fCards[i].fId;
end;

// Получение данных ка ты (указатель на голову связного списка)
function TInvestigatorCardDeck.GetCardData(i: integer): string;
begin
//  GetCardData := fCards[i].name;
end;

function TInvestigatorCardDeck.DrawCard: Integer;
begin
  //DrawCard := fCards[fCount].fId;
  //Shuffle;
end;

function TInvestigatorCardDeck.FindCards(file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  s: string[100];
  i, j, k, n, crd_num: integer;
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
  FindRes := FindFirst(file_path + '*.inv', faAnyFile, SR);

  i := 0;
  n := 0;
  output_data := TStringList.Create;

  while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
  begin
    i := i + 1;
    AssignFile (F, file_path + SR.Name);
    Reset(F);
    readln(F, s);
    CloseFile(F);
    SplitData('|', s, output_data);
    crd_num := StrToInt(Copy(SR.Name, 1, 2));
    with fCards[crd_num] do
    begin
      id := crd_num;
      name := output_data[1];
      sanity := StrToInt(output_data[0]);
      stamina := StrToInt(output_data[1]);
      start_lok := StrToInt(output_data[2]);
      money := StrToInt(output_data[3]);
      clues := StrToInt(output_data[4]);
      if (StrToInt(output_data[5]) <> 0) then               // Item
        AddItem(StrToInt(output_data[5]));
      if (StrToInt(output_data[6]) <> 0) then               // Item
        AddItem(StrToInt(output_data[6]));
      if (StrToInt(output_data[7]) <> 0) then               // Item
        AddItem(StrToInt(output_data[7]));
      can_take[1] := StrToInt(output_data[8]); // Common items
      can_take[2] := StrToInt(output_data[9]); // What, how many
      can_take[3] := StrToInt(output_data[10]); // What, how many
      can_take[4] := StrToInt(output_data[11]); // What, how many
      can_take[5] := StrToInt(output_data[12]); // What, how many

      // Random possessions
      // Stats
      focus := StrToInt(output_data[14]);
      speed := StrToInt(output_data[15]);
      sneak := StrToInt(output_data[16]);
      fight := StrToInt(output_data[17]);
      will := StrToInt(output_data[18]);
      lore := StrToInt(output_data[19]);
      luck := StrToInt(output_data[20]);
      //for j := 1 to 10 do
      //  for k := 1 to 10 do
      //can_take[j, k] := StrToInt(output_data[2]); // What, how many
    end;

    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
  end;

  output_data.Free;
  FindClose(SR); // закрываем поиск
  FindCards := i;
  fCount := i;

end;

// Тасовка колоды
procedure TInvestigatorCardDeck.Shuffle();
var
  i, r: integer;
  temp: TInvestigator;
begin
  randomize;
  for i := 1 to fCount do
  begin
{    temp := fCards[i];
    r := random(Count);
    fCards[i] := fCards[r+1];
    fCards[r+1] := temp;      }
  end;
end;

end.
