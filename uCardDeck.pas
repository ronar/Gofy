unit uCardDeck;

interface

uses
  SysUtils, Dialogs, uCommon, uCardXML, uInvestigator, uMythos;

type
  TCommonItemCard = record
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

  TCommonItemCardDeck = class(TCardDeck)
  private
    fCards: array [1..COMMON_ITEMS_CARD_NUMBER] of TCommonItemCard; // Данные о каждой карте
    function GetCardID(i: integer): Integer;
    function GetCardData(i: integer): string;
  public
    constructor Create (crd_type: integer);
    property card[i: integer]: integer read GetCardID;
    function FindCards(file_path: string): integer; override;
    function GetCardByID(id: integer): TCommonItemCard;
    function IndexOfCard(id: integer): integer;
    function DrawCard: Integer; //overload;
    procedure Shuffle(); override;
    function CheckAvailability(N: integer): boolean;
    procedure IncCounter(indx: integer); // Увеличивает счетчик карты
    procedure DecCounter(indx: integer); // Уменьшает счетчик карты
    procedure AddCardToDeck(indx: integer);
    procedure RemoveCardFromDeck(indx: integer);
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

  TInvDeck = class(TCardDeck)
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

  TMythosDeck = class(TCardDeck)
  private
    fCards: array [1..MYTHOS_CARDS_NUMBER] of TMythosCard; // Данные о каждой карте
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

uses Classes;

// Деструктор TCardDeck
destructor TCardDeck.Destroy;
begin
  inherited;
end;

////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// TItemCardDeck //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Конструктор
constructor TCommonItemCardDeck.Create(crd_type: integer);
var
  i: Integer;
begin
  fCardType := crd_type;
  for i := 1 to COMMON_ITEMS_CARD_NUMBER do
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
      IndexOfCard := i;
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
  DrawCard := fCards[fCount].id;
  Shuffle;
end;

// Поиск файлов в картами
function TCommonItemCardDeck.FindCards(file_path: string): integer;
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
  FindClose(SR); // закрываем поиск
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
    r := random(Count);
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

////////////////////////////////////////////////////////////////////////////////
///////////////////////////// TLocationCardDeck ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

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

// id - number of card in deck
function TLocationCardsDeck.GetCard(id: integer; n: integer): TLocationCard;
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
/////////////////////////        TInvDeck          /////////////////////////////
////////////////////////////////////////////////////////////////////////////////

constructor TInvDeck.Create(crd_type: integer);
var
  i, j, k: Integer;
begin
  fCardType := crd_type;
  for i := 1 to NUMBER_OF_INVESTIGATORS do
  begin
    fCards[i] := TInvestigator.Create;
  end;

end;

destructor TInvDeck.Destroy;
var
  i: Integer;
begin
  for i := 1 to NUMBER_OF_INVESTIGATORS do
    fCards[i].Free;
end;

function TInvDeck.GetCardByID(id: integer): TInvestigator;
var
  i: integer;
begin
  GetCardByID := fCards[i];
end;

// Получение ID карты
function TInvDeck.GetCardID(i: integer): integer;
begin
 // GetCardID := fCards[i].fId;
end;

// Получение данных карты (указатель на голову связного списка)
function TInvDeck.GetCardData(i: integer): string;
begin
//  GetCardData := fCards[i].name;
end;

function TInvDeck.DrawCard: Integer;
begin
  //DrawCard := fCards[fCount].fId;
  //Shuffle;
end;

function TInvDeck.FindCards(file_path: string): integer;
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

  FindClose(SR); // закрываем поиск
  FindCards := i;
  fCount := i;

end;

// Тасовка колоды
procedure TInvDeck.Shuffle();
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

////////////////////////////////////////////////////////////////////////////////
////////////////////////////// TMythosCardDeck /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

constructor TMythosDeck.Create(crd_type: integer);
var
  i, j, k: Integer;
begin
  fCardType := crd_type;
  for i := 1 to MYTHOS_CARDS_NUMBER do
  begin
    ;//fCards[i] := ;
  end;

end;

destructor TMythosDeck.Destroy;
var
  i: Integer;
begin
  for i := 1 to MYTHOS_CARDS_NUMBER do
    ;//fCards[i].Free;
end;

function TMythosDeck.GetCardByID(id: integer): TMythosCard;
var
  i: integer;
begin
  for i := 1 to MYTHOS_CARDS_NUMBER do
    if fCards[i].fId = id then
    begin
      GetCardByID := fCards[i];
      break;
    end;
end;

// Получение ID карты
function TMythosDeck.GetCardID(i: integer): integer;
begin
  GetCardID := fCards[i].fId;
end;


function TMythosDeck.DrawCard: Integer;
begin
  //DrawCard := fCards[fCount].fId;
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
