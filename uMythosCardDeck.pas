{***************************************************************************}
{                                                                           }
{           TMythosCardDeck                                                 }
{                                                                           }
{           Copyright (C) 2019 Ronar                                        }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under ...                                                       }
{***************************************************************************}

unit uMythosCardDeck;

interface

uses
  SysUtils, Classes, uCommon, uCardXML, uCardDeck, uMythos;

type
  TMythosDeck = class(TCardDeck)
  private
    fCards: array [1..NUMBER_OF_MYTHOS_CARDS] of TMythosCard; // Данные о каждой карте
    function GetCardByID(id: integer): TMythosCard;
    function GetCardID(i: integer): Integer;
    //function GetCardData(i: integer): string;
  public
    constructor Create(crd_type: integer);
    property card[i: integer]: TMythosCard read GetCardByID;
    function FindCards(file_path: string): integer; override;
    function DrawCard: Integer; //overload;
    procedure Shuffle(); override;
    destructor Destroy; override;
  end;

implementation

constructor TMythosDeck.Create(crd_type: integer);
var
  i, j, k: Integer;
begin
  fCardType := crd_type;
  for i := 1 to NUMBER_OF_MYTHOS_CARDS do
  begin
    ;//fCards[i] := ;
  end;

end;

destructor TMythosDeck.Destroy;
var
  i: Integer;
begin
  for i := 1 to NUMBER_OF_MYTHOS_CARDS do
    ;//fCards[i].Free;
end;

function TMythosDeck.GetCardByID(id: integer): TMythosCard;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_MYTHOS_CARDS do
  begin
    if fCards[i].fId = id then
    begin
      GetCardByID := fCards[i];
      Break;
    end;
  end;
end;

// Получение ID карты
function TMythosDeck.GetCardID(i: integer): integer;
begin
  GetCardID := fCards[i].fId;
end;


// TODO: Correct number of drawn card
function TMythosDeck.DrawCard: Integer;
begin
  DrawCard := fCards[2].fId;
  //Shuffle;
end;

function TMythosDeck.FindCards(file_path: string): integer;
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
  FindRes := FindFirst(file_path + '*.myt', faAnyFile, SR);

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
      fid := crd_num;
      fClueSpawn := StrToInt(output_data[2]);
      fCloseLok  := StrToInt(output_data[3]);
      fProcess   := StrToInt(output_data[0]);
      fHeadline  := StrToInt(output_data[1]);
      fSkillChk      := StrToInt(output_data[6]);
      fSkillChkTrue  := StrToInt(output_data[7]);
      fSkillChkFalse := StrToInt(output_data[8]);
      fSpeedMod := StrToInt(output_data[9]);
      fSneakMod := StrToInt(output_data[10]);
      fFightMod := StrToInt(output_data[11]);
      fWillMod  := StrToInt(output_data[12]);
      fLoreMod  := StrToInt(output_data[13]);
      fLuckMod  := StrToInt(output_data[14]);
      fGateSpawn:= StrToInt(output_data[15]);
      for j := 1 to 9 do
      begin
        fMobMoveWhite[j] := StrToInt(output_data[15+j]);
      end;

      for j := 1 to 9 do
      begin
        fMobMoveBlack[j] := StrToInt(output_data[24+j]);
      end;
      // Random possessions
      // Stats

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
procedure TMythosDeck.Shuffle();
var
  i, r: integer;
  temp: TMythosCard;
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
