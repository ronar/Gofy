unit uPlayer;

interface
uses
  SysUtils, Dialogs, uCardDeck, Unit2, uInvestigator;

type
  TPlayer = class
  private
    mLocation: integer;
    //Items_Count: integer; // Кол-во предметов у игрока

  public
    bFirst_Player: boolean; // Флаг первого игрока
    investigator: TInvestigator;
    Cards: array [1..100] of integer; // Предметы игрока
    cards_count: integer; // Amt. of player's items
    Sanity: integer;
    Stamina: integer;
    Focus: integer;
    Money: integer;
    Clue_Token: integer;
    Monster_Trophies: integer;
    Stats: array [1..6] of integer; // Статы игрока (1 - Скорость, 2 - Скрытность)
    constructor Create(var InitStats: array of integer; First_Player: boolean);
    destructor Destroy; override;
    property Location: integer read mLocation write mLocation; // id локации в виде xxy, где (хх - номер улицы, y - номер локации)
    procedure Draw_Card(Card_ID: integer);
    function Get_Items_Count(): integer;
    function Get_Sanity(): integer;
    function Get_Stamina(): integer;
    function Get_Focus: integer;
    function Get_Stat(n: integer): integer;
    function Get_Item(indx: integer): integer;
    function RollADice(stat: integer): integer;
    function Act_Condition(Cond: integer; Choise: integer; N:integer; min: integer; max: integer): boolean;
    procedure EvtMoveToLocation(c_N: integer; c_data: string);
    procedure Encounter(var Locations_Deck: TCardDeck);
    procedure Take_Action(action: integer; action_value: integer);
    function CheckAvailability(grade: integer; param: integer): boolean;
    function HasItem(ID: integer): boolean;
    procedure ChangeSkills(r: integer; n: integer);
    //property Speed: integer read Stats[1] write Stats[1];
  end;

implementation

// Конструктор игрока
constructor TPlayer.Create(var InitStats: array of integer; First_Player: boolean);
var
  i: integer;
begin
  cards_count := 0;
  Stamina := 0;
  Sanity := 0;
  Focus := 0;
  Stats[1] := InitStats[0];
  Stats[2] := InitStats[1];
  Stats[3] := InitStats[2];
  Stats[4] := InitStats[3];
  Stats[5] := InitStats[4];
  Stats[6] := InitStats[5];

  //SetLength(Cards, 0);
  for i := 1 to 100 do
    Cards[i] := 0;
  bFirst_Player := False;
  //Items_Count := 0;
end;

// Деструктор объекта TPlayer
destructor TPlayer.Destroy;
begin
  inherited;
end;

// Функция: взятие карты из колоды
procedure TPlayer.Draw_Card(Card_ID: integer);
begin
  //Items_Count := Items_Count + 1;
  //SetLength(Cards, Items_Count);
  //Cards[Items_Count] := Card_ID;
end;

// Функция: получение кол-ва предметов у игрока
function TPlayer.Get_Items_Count;
begin
  Get_Items_Count := cards_count;
end;

// Функция: получение значения "Тела" игрока
function TPlayer.Get_Stamina;
begin
  Get_Stamina := Stamina;
end;

// Функция: получение значения "Разума" игрока
function TPlayer.Get_Sanity;
begin
  Get_Sanity := Sanity;
end;

// Функция: получение значения "Собранности" игрока
function TPlayer.Get_Focus;
begin
  Get_Focus := Focus;
end;

// Функция: получение значние 1 из 6 статов
function TPlayer.Get_Stat(n: integer): integer;
begin
  Get_Stat := Stats[n];
end;

// Функция: получение предмета по индексу.
// Достаем предметы по одному, а не массивом
function TPlayer.Get_Item(indx: integer): integer;
begin
  Get_Item := Cards[indx];
end;

// Бросок кубика (Возвращает число успехов, 0 - провал)
function TPlayer.RollADice(stat: integer): integer;
var
  r, i: integer;
  Roll_results: array [1..12] of integer;
  Successes: integer;
begin
  randomize;
  Successes := 0;
  //Form1.imDie1.Picture.LoadFromFile('..\\Gofy\\Pictures\\0.jpg');
  //Form1.imDie2.Picture.LoadFromFile('..\\Gofy\\Pictures\\0.jpg');
  //Form1.imDie3.Picture.LoadFromFile('..\\Gofy\\Pictures\\0.jpg');
  //Form1.imDie4.Picture.LoadFromFile('..\\Gofy\\Pictures\\0.jpg');
  //Form1.imDie5.Picture.LoadFromFile('..\\Gofy\\Pictures\\0.jpg');
  //Form1.imDie6.Picture.LoadFromFile('..\\Gofy\\Pictures\\0.jpg');
  //Form1.imDie7.Picture.LoadFromFile('..\\Gofy\\Pictures\\0.jpg');
  //RollADice := random(6)+1;
    //pl := TPlayer.Create(False);
  if Stats[stat] > 0 then
  begin
    for i:=1 to Stats[stat] do
    begin
      Roll_results[i]:=random(6)+1;
      {case Roll_results[i] of
      1: (Form1.FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\1.jpg');
      2: (Form1.FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\2.jpg');
      3: (Form1.FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\3.jpg');
      4: (Form1.FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\4.jpg');
      5: (Form1.FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\5.jpg');
      6: (Form1.FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\6.jpg');
      end; }

      if Roll_results[i]>=5 then
      begin
        Successes := Successes + 1;
        //broskub.usp:=true;
        //broskub.kolusp:=broskub.kolusp+1;
        //if broskub.resbroskub[i]=6 then broskub.kolusp6:=broskub.kolusp6+1;
      end;
    end;
  end;

  //Form1.imDie1.Picture.LoadFromFile('0.jpg');
  RollADice := Successes;
end;

procedure TPlayer.EvtMoveToLocation(c_N: integer; c_data: string);
var
 c_Action1, c_Action1Value: integer;
begin
  // refer to xls file to locs table (n, id)
  if c_N = 0 then
  begin
    form2.ShowModal; // Move to any location
  end
  else
  begin
    mLocation := 2103;
  end;

  c_Action1 := StrToInt(copy(c_data, 9, 2));
  c_Action1Value := StrToInt(copy(c_data, 14, 2));

  if c_Action1 = 35 then
    ShowMessage('Encounter!');
end;

// Разрешить контакт
procedure TPlayer.Encounter(var Locations_Deck: TCardDeck);
begin

end;

// Проверка выполнилось ли условие на карте
function TPlayer.Act_Condition(cond: integer; choise: integer; N:integer; min: integer; max: integer): boolean;
var
  skill_test: integer;
begin

end;

// Выполнение действие согласно карте
procedure TPlayer.Take_Action(action: integer; action_value: integer);
var
  i: integer;
begin

end;

function TPlayer.CheckAvailability(grade: integer; param: integer): boolean;
begin
  if (grade = 8) and (money >= param) then
    result := true;

  if (grade = 9) and (clue_token >= param) then
    result := true;

  if (grade = 10) and (Monster_trophies >= param) then
    result := true;

  result := false;

end;

function TPlayer.HasItem(ID: integer): boolean;
begin

end;

procedure TPlayer.ChangeSkills(r: integer; n: integer);
begin
  case r of
  1: begin
    if investigator.stats[1] < 3 then
      Stats[1] := investigator.stats[1] + (n - 1)
    else
      Stats[1] := investigator.stats[1] - (n - 1);

    if investigator.stats[2] < 3 then
      Stats[2] := investigator.stats[2] + (n - 1)
    else
      Stats[2] := investigator.stats[2] - (n - 1);
  end;
  2: begin
    if investigator.stats[3] < 3 then
      Stats[3] := investigator.stats[3] + (n - 1)
    else
      Stats[3] := investigator.stats[3] - (n - 1);

    if investigator.stats[4] < 3 then
      Stats[4] := investigator.stats[4] + (n - 1)
    else
      Stats[4] := investigator.stats[4] - (n - 1);
  end;
  3: begin
    if investigator.stats[5] < 3 then
      Stats[5] := investigator.stats[5] + n - 1
    else
      Stats[5] := investigator.stats[5] - n - 1;

    if investigator.stats[6] < 3 then
      Stats[6] := investigator.stats[6] + n - 1
    else
      Stats[6] := investigator.stats[6] - n - 1;
  end;
  end;
end;

end.
 