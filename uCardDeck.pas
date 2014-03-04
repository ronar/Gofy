unit uCardDeck;

interface

uses
  SysUtils, Dialogs, uCommon, uCardXML;

type
  TItemCard = record
    id: integer;
    data: string;
    exposed: boolean;
  end;

  TLocationCard = record
    id: integer;
    crd_head: PLLData;
    exposed: boolean;
  end;

  TCardDeck = class(TObject) // Общий класс колод карт
  private
    fCount: integer; // Кол-во карт
    fCardType: integer; // Тип карты (предмет, миф, контакт и т.д.)
  public
    destructor Destroy; override;
    property Count: integer read fCount;
    //function GetCardID(i: integer): Integer; overload;
    //function GetCardData(i: integer): string; overload;
    //function GetCardByID(id: integer): CCard; overload;
    function FindCards(file_path: string): integer; virtual; abstract;
    function DrawCard(n: integer): Integer; virtual; abstract;
    procedure Shuffle(); virtual; abstract;
    //function Get_Card_By_ID(id: integer): TCard; // Нахождение карты по ее ID
  end;

  TItemCardDeck = class(TCardDeck)
  private
    fCards: array [1..ITEMS_CARD_NUMBER] of TItemCard; // Данные о каждой карте
    function GetCardByID(id: integer): TItemCard;
    function GetCardID(i: integer): Integer;
    function GetCardData(i: integer): string;
  public
    constructor Create (crd_type: integer);
    property card[i: integer]: integer read GetCardID;
    function FindCards(file_path: string): integer; override;
    function DrawCard: Integer; //overload;
    procedure Shuffle(); override;
    function CheckAvailability(N: integer): boolean;
    //destructor Destroy; override;
  end;

  TLocationCardsDeck = class(TCardDeck) // Карты
  private
    fCards: array [1..LOCATION_CARD_NUMBER, 1..3] of TLocationCard; // Данные о каждой карте
    function GetCard(id: integer; n: integer): TLocationCard; // Получает карту из колоды (для трех локаций улицы). Для св-ва.
    //function GetLokation: integer;
    //function GetNom: integer;
    //procedure SetLok;
  public
    constructor Create;
    //destructor Destroy; override;
    //property Lokaciya: integer read GetLokation; // Локация карты (свойство)
    function GetCardID(i, n: integer): Integer; overload; // Получить ID карты по порядковому номеру
    function GetCardData(i, n: integer): PLLData; overload; // Получить данные карты по порядковому номеру
    function FindCards(file_path: string): integer; override;
    function DrawCard(n: integer): TLocationCard; // Returns ID of the card on top of the deck
    property cards[id: integer; n: integer]: TLocationCard read GetCard;
    //property Nom: integer;
    procedure Shuffle();
    //function Get_Card_By_ID(id: integer): TCard; // Нахождение карты по ее ID
  end;

implementation

uses Classes;

// Деструктор TCardDeck
destructor TCardDeck.Destroy;
begin
  inherited;
end;

/////////////////////////////// TItemCardDeck //////////////////////////////////

// Конструктор
constructor TItemCardDeck.Create(crd_type: integer);
var
  i: Integer;
begin
  fCardType := crd_type;
  for i := 1 to ITEMS_CARD_NUMBER do
  begin
    fCards[i].id := 0;
    fCards[i].data := '';
    fCards[i].exposed := False;
  end;
end;

function TItemCardDeck.GetCardByID(id: integer): TItemCard;
var
  i: integer;
begin
  for i:= 1 to fCount do
  begin
    if fCards[i].id = id then
      GetCardByID := fCards[i];
  end;
end;

// Получение ID карты
function TItemCardDeck.GetCardID(i: integer): integer;
begin
  GetCardID := fCards[i].id;
end;

// Получение данных карты (указатель на голову связного списка)
function TItemCardDeck.GetCardData(i: integer): string;
begin
  GetCardData := fCards[i].data;
end;

function TItemCardDeck.DrawCard: Integer;
begin
  DrawCard := fCards[fCount].id;
  Shuffle;
end;

// Поиск файлов в картами
function TItemCardDeck.FindCards(file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  s: string[80];
  i: integer;
begin
  // задание условий поиска и начало поиска
  FindRes := FindFirst(file_path + '*.txt', faAnyFile, SR);

  i := 0;

  while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
  begin
    i := i + 1;
    AssignFile (F, file_path + SR.Name);
    Reset(F);
    readln(F, s);
    CloseFile(F);
    fCards[i].data := s;
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;
    fCards[i].id := StrToInt(Copy(SR.Name, 1, 4));

    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
  end;
  FindClose(SR); // закрываем поиск
  FindCards := i;
  fCount := i;
end;

// Тасовка колоды
procedure TItemCardDeck.Shuffle();
var
  i, r: integer;
  temp: TItemCard;
begin
  randomize;
  for i := 1 to fCount do
  begin
    temp := fCards[i];
    r := random(Count);
    fCards[i] := fCards[r+1];
    fCards[r+1] := temp;
  end;
end;

function TItemCardDeck.CheckAvailability(N: integer): boolean;
var
  i: Integer;
begin
  result := false;
  for i := 1 to fCount do
    if fCards[i].id = N then
      result := true;
end;

///////////////////////////// TLocationCardDeck ////////////////////////////////

// Конструктор
constructor TLocationCardsDeck.Create;
var
  i, j: Integer;
begin
  fCardType := CT_ENCOUNTER;
  for i := 1 to LOCATION_CARD_NUMBER do
    for j := 1 to 3 do
    begin
      fCards[i, j].id := 0;
      fCards[i, j].crd_head := nil;
      fCards[i, j].exposed := False;
    end;
end;

function TLocationCardsDeck.GetCard(ID: integer; n: integer): TLocationCard;
var
  i, j: integer;
begin
  Result := fCards[id, n];
  {for i := 1 to fCount do
    for j := 1 to 3 do
      if fCards[i, j].id = id then
      begin
        Result := fCards[i, j];
        exit;
      end;}
end;

{function TLocationCardsDeck.GetCardByID(id: integer): TLocationCard;
var
  i, j: integer;
begin
  for i:= 1 to Count do
    for j := 1 to 3 do
    begin
      if fCards[i, j].id = id then
        GetCardByID := fCards[i, j];
    end;
end;    }

// Получение ID карты
function TLocationCardsDeck.GetCardID(i, n: integer): integer;
begin
  GetCardID := fCards[i, n].id;
end;

// Получение данных карты
function TLocationCardsDeck.GetCardData(i, n: integer): PLLData;
begin
  GetCardData := fCards[i, n].crd_head;
end;


// n - номер локации на карте
function TLocationCardsDeck.DrawCard(n: integer): TLocationCard;
begin
  DrawCard := fCards[7{fCount div 3}, n];//n];
  //Shuffle;
end;

// Поиск файлов в картами
function TLocationCardsDeck.FindCards(file_path: string): integer;
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
    if n <> StrToInt(Copy(SR.Name, 2, 1)) then
      i := 0;

    n := StrToInt(Copy(SR.Name, 2, 1));
    crd_num := StrToInt(Copy(SR.Name, 4, 1));
    i := i + 1;
    fCards[crd_num, n].id := StrToInt(Copy(SR.Name, 1, 4));
    New(fCards[crd_num, n].crd_head);
    fCards[crd_num, n].crd_head.mnChildCount := 0;
    fCards[crd_num, n].crd_head.data := '';
    XML2LL(fCards[crd_num, n].crd_head, file_path + SR.Name);
    //ShowMessage(Format('%s', [fCards[i, n].crd_head.mnChild[0].data]));
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;


    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
  end;

  FindClose(SR); // закрываем поиск
  FindCards := i;
  fCount := i;
end;

// Тасовка колоды
procedure TLocationCardsDeck.Shuffle();
var
  i, j, r: integer;
  temp: TLocationCard;
begin
  randomize;
  for i := 1 to fCount do
  begin
    r := random(fCount);
    for j := 1 to 3 do
    begin
      temp := fCards[i, j];
      fCards[i, j] := fCards[r+1, j];
      fCards[r+1, j] := temp;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////

end.
