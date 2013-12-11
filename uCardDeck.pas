unit uCardDeck;

interface

uses
  SysUtils, uCommon;

type
  CCard = record
    ID: integer;
    Data: string;
    exposed: boolean;
  end;

  TCardDeck = class(TObject) // Общий класс колод карт
  private
    mCount: integer; // Кол-во карт
    Card_Type: integer; // Тип карты (предмет, миф, контакт и т.д.)
  public
    destructor Destroy; override;
    property Count: integer read mCount;
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
    mCards: array [1..100] of CCard; // Данные о каждой карте
    function GetCardByID(id: integer): CCard;
    function GetCardID(i: integer): Integer;
    function GetCardData(i: integer): string;
  public
    constructor Create (crd_type: integer);
    property card[i: integer]: integer read GetCardID;
    function FindCards(file_path: string): integer; override;
    function DrawCard: Integer; //overload;
    procedure Shuffle(); override;
    //destructor Destroy; override;
  end;

  TLocationCardDeck = class(TCardDeck) // Карты
  private
    Cards: array [1..LOCATION_CARD_NUMBER, 1..3] of CCard; // Данные о каждой карте
    //function GetLokation: integer;
    //function GetNom: integer;
    //procedure SetLok;
  public
    constructor Create;
    //destructor Destroy; override;
    function GetCardByID(id: integer): CCard;
    //property Lokaciya: integer read GetLokation; // Локация карты (свойство)
    function GetCardID(i, n: integer): Integer; overload; // Получить ID карты по порядковому номеру
    function GetCardData(i, n: integer): string; overload; // Получить данные карты по порядковому номеру
    function FindCards(file_path: string): integer; override;
    function DrawCard(n: integer): Integer;
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
  Card_Type := crd_type;
  for i := 1 to LOCATION_CARD_NUMBER do
  begin
    mCards[i].ID := 0;
    mCards[i].Data := '';
    mCards[i].exposed := False;
  end;
end;

function TItemCardDeck.GetCardByID(id: integer): CCard;
var
  i: integer;
begin
  for i:= 1 to Count do
  begin
    if mCards[i].ID = id then
      GetCardByID := mCards[i];
  end;
end;

// Получение ID карты
function TItemCardDeck.GetCardID(i: integer): integer;
begin
  GetCardID := mCards[i].ID;
end;

// Получение данных карты
function TItemCardDeck.GetCardData(i: integer): string;
begin
  GetCardData := mCards[i].Data;
end;

function TItemCardDeck.DrawCard: Integer;
begin
  DrawCard := mCards[Count].ID;
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
    mCards[i].Data := s;
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;
    mCards[i].ID := StrToInt(Copy(SR.Name, 1, 4));

    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
    //Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));
  end;
  FindClose(SR); // закрываем поиск
  FindCards := i;
  mCount := i;
end;

// Тасовка колоды
procedure TItemCardDeck.Shuffle();
var
  i, r: integer;
  temp: CCard;
begin
  randomize;
  for i := 1 to Count do
  begin
    temp := mCards[i];
    r := random(Count);
    mCards[i] := mCards[r+1];
    mCards[r+1] := temp;
  end;
end;

///////////////////////////// TLocationCardDeck ////////////////////////////////

// Конструктор
constructor TLocationCardDeck.Create;
var
  i, j: Integer;
begin
  Card_Type := CT_ENCOUNTER;
  for i := 1 to LOCATION_CARD_NUMBER do
    for j := 1 to 3 do
    begin
      Cards[i, j].ID := 0;
      Cards[i, j].Data := '';
      Cards[i, j].exposed := False;
    end;
end;

function TLocationCardDeck.GetCardByID(id: integer): CCard;
var
  i, j: integer;
begin
  for i:= 1 to Count do
    for j := 1 to 3 do
    begin
      if Cards[i, j].ID = id then
        GetCardByID := Cards[i, j];
    end;
end;

// Получение ID карты
function TLocationCardDeck.GetCardID(i, n: integer): integer;
begin
  GetCardID := Cards[i, n].ID;
end;

// Получение данных карты
function TLocationCardDeck.GetCardData(i, n: integer): string;
begin
  GetCardData := Cards[i, n].Data;
end;

function TLocationCardDeck.DrawCard(n: integer): Integer;
begin
  DrawCard := cards[Count div 3, n].ID;
  Shuffle;
end;

// Поиск файлов в картами
function TLocationCardDeck.FindCards(file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  s: string[80];
  i, n: integer;
begin
  // задание условий поиска и начало поиска
  FindRes := FindFirst(file_path + '*.txt', faAnyFile, SR);

  i := 0;
  n := 0;

  while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
  begin
    if n <> StrToInt(Copy(SR.Name, 2, 1)) then
      i := 0;
    n := StrToInt(Copy(SR.Name, 2, 1));
    i := i + 1;
    AssignFile (F, file_path + SR.Name);
    Reset(F);
    readln(F, s);
    CloseFile(F);
    Cards[i, n].Data := s;
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;
    Cards[i, n].ID := StrToInt(Copy(SR.Name, 1, 4));

    FindRes := FindNext(SR); // продолжение поиска по заданным условиям
    //Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));
  end;
  FindClose(SR); // закрываем поиск
  FindCards := i;
  mCount := i;
end;

// Тасовка колоды
procedure TLocationCardDeck.Shuffle();
var
  i, j, r: integer;
  temp: CCard;
begin
  randomize;
  for i := 1 to Count do
    for j := 1 to 3 do
    begin
      temp := Cards[i, j];
      r := random(Count);
      Cards[i, j] := Cards[r+1, j];
      Cards[r+1, j] := temp;
    end;
end;

////////////////////////////////////////////////////////////////////////////////

end.
