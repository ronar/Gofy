unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    lblPlrStamina: TLabel;
    Label1: TLabel;
    lblPlrSanity: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblPlrFocus: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Label7: TLabel;
    imDie1: TImage;
    lblRolls: TLabel;
    imDie2: TImage;
    imDie3: TImage;
    imDie4: TImage;
    imDie5: TImage;
    imDie6: TImage;
    imDie7: TImage;
    btnRollADie: TButton;
    Edit1: TEdit;
    lblNRolls: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label3: TLabel;
    lblPrm2: TLabel;
    lblPrm3: TLabel;
    Label6: TLabel;
    lblPrm4: TLabel;
    Label8: TLabel;
    lblPrm5: TLabel;
    Label10: TLabel;
    lblPrm6: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblPrm1: TLabel;
    lblCardData: TLabel;
    ComboBox1: TComboBox;
    Button4: TButton;
    Button5: TButton;
    GroupBox3: TGroupBox;
    Image2: TImage;
    Label9: TLabel;
    lblPrm22: TLabel;
    lblPrm23: TLabel;
    Label15: TLabel;
    lblPrm24: TLabel;
    Label17: TLabel;
    lblPrm25: TLabel;
    Label19: TLabel;
    lblPrm26: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lblPrm21: TLabel;
    lblCardData2: TLabel;
    ComboBox2: TComboBox;
    Button6: TButton;
    Button7: TButton;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRollADieClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  // Константы фаз
  PH_PEREDISHKA = 1;
  PH_DVIJENIE = 2;
  PH_KONTAKTI_V_ARKHEME = 3;
  PH_KONTAKTI_V_INIH_MIRAH = 4;
  PH_MIF = 5;
  // Константы Типов Карт
  CT_DEJSTVIE = 6;
  CT_KONTAKT = 7;
  CT_MYTHOS = 8; // Миф
  CT_HEADLINE = 9; // Слух
  CT_COMMON_ITEM = 1; // Простые предметы (первая цифра в ID)
  CT_UNIQUE_ITEM = 2; // Уникальные предметы (первая цифра в ID)
  // Константы Действий
  AT_SPEC = 2;
  AT_WATCH_BUY = 3;

type
  TCard = class(TObject) // Карты
  private
    Card_ID: integer;
    Card_Type: integer; // Тип карты (слух, миф, контакт и т.д.)
    Card_Data: string; // Строка с данными о карте в зависимости от типа
                       // "Знать", что делать с картой будет функция Dejstvie_karti
    function GetLokation: integer;
    function GetNom: integer;
    //procedure SetLok;
  public
    constructor Create;
    function Get_Card_ID: integer;
    property Lokaciya: integer read GetLokation; // Локация карты (свойство)
    //property Nom: integer;
    procedure Dejstvie_karti; // Выполнение необходимых действий карты
    procedure Shuffle();
  end;

  TPlayer = class(TObject)
  private
    Sanity: integer;
    Stamina: integer;
    Focus: integer;
    Cards: array [1..100] of integer; // Предметы игрока
    Items_Count: integer; // Кол-во предметов у игрока
    bFirst_Player: boolean; // Флаг первого игрока
  public
    constructor Create(First_Player: boolean);
    procedure Draw_Card(Card_ID: integer);
    function Get_Items_Count(): integer;
    function Get_Sanity(): integer;
    function Get_Stamina(): integer;
    function Get_Focus: integer;
    function Get_Item(indx: integer): integer;
    function RollADice: integer;
  end;
  TArrayOfCard = array [1..100] of TCard;
  PArrayOfCard = ^TArrayOfCard;

var
  Form1: TForm1;
  gCurrent_phase: integer;
  Cards0, Cards1: array [1..100] of TCard; // Массивы карт
  Common_Items_Deck: array [1..100] of TCard;
  Unique_Items_Deck: array [1..100] of TCard;
  Common_Items_Count: integer = 0;
  Unique_Items_Count: integer = 0;
  Cards_Count: integer = 0;
  gPlayer: TPlayer;
  function Load_Cards(Card_Type: integer; Cards: PArrayOfCard): integer;

implementation

{$R *.dfm}

// Конструктор игрока
constructor TPlayer.Create(First_Player: boolean);
var
  i: integer;
begin
  Stamina := 0;
  Sanity := 0;
  Focus := 0;
  //SetLength(Cards, 0);
  for i := 1 to 100 do
    Cards[i] := 0;
  bFirst_Player := False;
  Items_Count := 0;
end;

// Функция: взятие карты из колоды
procedure TPlayer.Draw_Card(Card_ID: integer);
begin
  Items_Count := Items_Count + 1;
  //SetLength(Cards, Items_Count);
  Cards[Items_Count] := Card_ID;
end;

// Функция: получение кол-ва предметов у игрока
function TPlayer.Get_Items_Count;
begin
  Get_Items_Count := Items_Count;
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

// Функция: получение предмета по индексу.
// Достаем предметы по одному, а не массивом
function TPlayer.Get_Item(indx: integer): integer;
begin
  Get_Item := Cards[indx];
end;

// Бросок кубика
function TPlayer.RollADice: integer;
var
  r: integer;
begin
  randomize;
  RollADice := random(6)+1;
end;

// Загрузка данных в карты из файла
function Load_Cards(Card_Type: integer; Cards: PArrayOfCard): integer;
var
  F: TextFile;
  File_Name: string;
  s: string[80];
  //temp: TCard;
  SR: TSearchRec; // поисковая переменная
  FindRes: Integer; // переменная для записи результата поиска
  i: integer;
begin
  case Card_Type of
    CT_KONTAKT: begin
      // задание условий поиска и начало поиска
      FindRes := FindFirst('..\\Gofy\\CardsData\\*.txt', faAnyFile, SR);

      i := 0;

      while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
      begin
        i := i + 1;
        AssignFile (F, '..\\Gofy\\CardsData\\' + SR.Name);
        Reset(F);
        readln(F, s);
        CloseFile(F);
        Cards^[i].Card_Data := s;
        Cards^[i].Card_Type := CT_KONTAKT;
        Cards^[i].Card_ID := StrToInt(Copy(SR.Name, 1, 4));
        FindRes := FindNext(SR); // продолжение поиска по заданным условиям

      end;
      FindClose(SR); // закрываем поиск
      Load_Cards := i;
    end;

    CT_COMMON_ITEM: begin
      // задание условий поиска и начало поиска
      FindRes := FindFirst('..\\Gofy\\CardsData\\CommonItems\\*.txt', faAnyFile, SR);

      i := 0;

      Form1.ComboBox1.Clear;
      Form1.ComboBox1.Text := 'Choose a card';

      while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
      begin
        i := i + 1;
        AssignFile (F, '..\\Gofy\\CardsData\\CommonItems\\' + SR.Name);
        Reset(F);
        readln(F, s);
        CloseFile(F);
        Cards^[i].Card_Data := s;
        Cards^[i].Card_Type := CT_COMMON_ITEM;
        Cards^[i].Card_ID := StrToInt(Copy(SR.Name, 1, 4));
        FindRes := FindNext(SR); // продолжение поиска по заданным условиям
        Form1.ComboBox1.Items.Add(IntToStr(Cards^[i].Card_ID));
      end;
      FindClose(SR); // закрываем поиск
      Load_Cards := i;
    end; // CT_COMMON_ITEM

    CT_UNIQUE_ITEM: begin
      // задание условий поиска и начало поиска
      FindRes := FindFirst('..\\Gofy\\CardsData\\UniqueItems\\*.txt', faAnyFile, SR);

      i := 0;

      Form1.ComboBox2.Clear;
      Form1.ComboBox2.Text := 'Choose a card';

      while FindRes = 0 do // пока мы находим файлы (каталоги), то выполнять цикл
      begin
        i := i + 1;
        AssignFile (F, '..\\Gofy\\CardsData\\UniqueItems\\' + SR.Name);
        Reset(F);
        readln(F, s);
        CloseFile(F);
        Cards^[i].Card_Data := s;
        Cards^[i].Card_Type := CT_UNIQUE_ITEM;
        Cards^[i].Card_ID := StrToInt(Copy(SR.Name, 1, 4));
        FindRes := FindNext(SR); // продолжение поиска по заданным условиям
        Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));
      end;
      FindClose(SR); // закрываем поиск
      Load_Cards := i;
    end; // CT_UNIQUE_ITEM

  end;

end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0
  then gCurrent_phase := 1;
  if RadioGroup1.ItemIndex = 1
  then gCurrent_phase := 2;
  if RadioGroup1.ItemIndex = 2
  then gCurrent_phase := 3;
  if RadioGroup1.ItemIndex = 3
  then gCurrent_phase := 4;
  if RadioGroup1.ItemIndex = 4
  then gCurrent_phase := 5;
end;

function TCard.GetLokation;
begin
  GetLokation := StrToInt(Copy(Card_Data, 0, 2));
end;

function TCard.GetNom;
begin
  GetNom := StrToInt(Copy(Card_Data, 2, 2));
end;

// Конструктор
constructor TCard.Create;
begin
  Card_ID := 0;
  Card_Type := 0;
  Card_Data := '';
end;

// Получение ID карты
function TCard.Get_Card_ID;
begin
  Get_Card_ID := Card_ID;
end;

// Выполнение действия карты
Procedure TCard.Dejstvie_karti;
var
  Action_Type: integer;
begin
  // В зависимости от типа
  case Card_Type of
    CT_DEJSTVIE:;
    CT_KONTAKT:
    begin
      Action_Type := StrToInt(Card_Data[4]);
      case Action_Type of
        AT_WATCH_BUY:
        begin{
          Form1.Label14.Caption := Copy(Card_Data, 1, 3);
          Form1.Label4.Caption := 'Просм. и покуп.';
          case StrToInt(Card_Data[5]) of
            1: Form1.Label5.Caption := 'Простые вещи';
            2: Form1.Label5.Caption := 'Уникальные вещи';
            3: Form1.Label5.Caption := 'Заклинания';
            4: Form1.Label5.Caption := 'Навык';
            5: Form1.Label5.Caption := 'Союзник';
          end;
          Form1.Label7.Caption := Card_Data[6];
          Form1.Label9.Caption := Card_Data[7];
          Form1.Label11.Caption := Card_Data[8];}
        end;
        AT_SPEC:
        begin
          {Form1.Label4.Caption := 'Спец. карта';
          case StrToInt(Card_Data[9]) of
            1: Form1.Label5.Caption := 'Гонорар';
            2: Form1.Label5.Caption := 'Сереб. ложе';
            3: Form1.Label5.Caption := 'Ссуда';
            4: Form1.Label5.Caption := 'Пом. шерифа';
            5: Form1.Label5.Caption := 'Благо';
            6: Form1.Label5.Caption := 'Прок';
          end;                                   }

        end;
      end;
    end;
    CT_MYTHOS:;
    CT_HEADLINE:;
    CT_COMMON_ITEM: begin
      Form1.lblPrm1.Caption := Form1.ComboBox1.Text;
      Form1.lblPrm2.Caption := Copy(Form1.ComboBox1.Text, 2, 2);
      Form1.lblPrm3.Caption := Card_Data[1];
      Form1.lblPrm4.Caption := Card_Data[4];
      //lblPrm5.Caption := Card_Data[6];
      case StrToInt(Card_Data[6]) of
        0: Form1.lblPrm5.Caption := 'Уход';
        1: Form1.lblPrm5.Caption := 'Битва';
        2: Form1.lblPrm5.Caption := 'Очки движения';
        3: Form1.lblPrm5.Caption := 'Удача';
        4: Form1.lblPrm5.Caption := 'Проверка ужаса';
      end;
      Form1.lblPrm6.Caption := Card_Data[7];
      Form1.lblCardData.Caption := Card_Data;
    end; // CT_COMMON_ITEM

    CT_UNIQUE_ITEM: begin
      Form1.lblPrm21.Caption := Form1.ComboBox2.Text;
      Form1.lblPrm22.Caption := Copy(Form1.ComboBox2.Text, 2, 2);
      Form1.lblPrm23.Caption := Card_Data[1];
      Form1.lblPrm24.Caption := Card_Data[4];
      //lblPrm5.Caption := Card_Data[6];
      case StrToInt(Card_Data[6]) of
        0: Form1.lblPrm25.Caption := 'Уход';
        1: Form1.lblPrm25.Caption := 'Битва';
        2: Form1.lblPrm25.Caption := 'Очки движения';
        3: Form1.lblPrm25.Caption := 'Удача';
        4: Form1.lblPrm25.Caption := 'Проверка ужаса';
      end;
      Form1.lblPrm26.Caption := Card_Data[7];
      Form1.lblCardData2.Caption := Card_Data;
    end; // CT_COMMON_ITEM
  end;
end;

// Тасовка колоды
procedure TCard.Shuffle();
begin

end;

// Инициализация
// После инициализации, массив карт будет содержать
// в себе все карты определенного типа
procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
begin
  // Загрузка объекта игрока
  gPlayer := TPlayer.Create(False);

  // Загрузка карт n-го типа (Контакты)

  // Загрузка карт обычных предметов
  Common_Items_Count := Load_Cards(CT_COMMON_ITEM, @Common_Items_Deck);

  // Загрузка карт уникальных предметов
  Unique_Items_Count := Load_Cards(CT_UNIQUE_ITEM, @Unique_Items_Deck);

  // И т.д.
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i: integer;
begin
  lblPlrStamina.Caption := IntToStr(gPlayer.Get_Stamina);
  lblPlrSanity.Caption := IntToStr(gPlayer.Get_Sanity);
  lblPlrFocus.Caption := IntToStr(gPlayer.Get_Focus);
  ListBox1.Clear;
  for i := 1 to gPlayer.Get_Items_Count do
    ListBox1.Items.Add(IntToStr(gPlayer.Get_Item(i)));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Image1.Picture.LoadFromFile('..\Gofy\CardsData\CommonItems\'+ComboBox1.Text+'.jpg');
  Common_Items_Deck[ComboBox1.ItemIndex+1].Dejstvie_karti;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//  cards0[StrToInt(ComboBox1.Text)].Dejstvie_karti;
  if ComboBox1.ItemIndex < 1 then
    ShowMessage('Выберите карту')
  else
    gPlayer.Draw_Card(StrToInt(ComboBox1.Text));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  pl: TPlayer;
begin
  //pl := TPlayer.Create(False);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  gPlayer.Free;
  for i := 1 to 100 do
  begin
    Cards0[i].Free;
    Common_Items_Deck[i].Free;
    Unique_Items_Deck[i].Free;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i,r: integer;
  temp: TCard;
begin
  randomize;
  for i := 1 to 21 do
  begin
    temp := Common_Items_Deck[i];
    r := random(21);
    Common_Items_Deck[i] := Common_Items_Deck[r+1];
  end;
  //Common_Items_Deck.Shuffle;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 100 do
  begin
    Cards0[i] := TCard.Create;
    Common_Items_Deck[i]:= TCard.Create;
    Unique_Items_Deck[i]:= TCard.Create;
  end;

end;

procedure TForm1.btnRollADieClick(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to StrToInt(Edit1.Text) do
  begin
    case gPlayer.RollADice of
    1: (FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\1.jpg');
    2: (FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\2.jpg');
    3: (FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\3.jpg');
    4: (FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\4.jpg');
    5: (FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\5.jpg');
    6: (FindComponent('imDie'+IntToStr(i)) as TImage).Picture.LoadFromFile('..\\Gofy\\Pictures\\6.jpg');
    end;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  if ComboBox2.ItemIndex < 1 then
    ShowMessage('Выберите карту')
  else
    gPlayer.Draw_Card(StrToInt(ComboBox2.Text));
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  Image2.Picture.LoadFromFile('..\Gofy\CardsData\UniqueItems\'+ComboBox2.Text+'.jpg');
  Unique_Items_Deck[ComboBox2.ItemIndex+1].Dejstvie_karti;
end;

end.
