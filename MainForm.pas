unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls, Player, Card_deck, Choise;

type
  TMain_frm = class(TForm)
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
    cbLocation: TComboBox;
    Label11: TLabel;
    lblSkillCheck: TLabel;
    lblNSuccesses: TLabel;
    lblSkill: TLabel;
    lblNumSuccesses: TLabel;
    Button8: TButton;
    Button9: TButton;
    lblLocIDCaption: TLabel;
    lblLocID: TLabel;
    lblLocCardDataCaption: TLabel;
    lblLocCardData: TLabel;
    imEncounter: TImage;
    lblStatSpeed: TLabel;
    Label16: TLabel;
    lblStatSneak: TLabel;
    Label18: TLabel;
    lblStatFight: TLabel;
    Label23: TLabel;
    lblStatWill: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    lblStatLore: TLabel;
    Label28: TLabel;
    lblStatLuck: TLabel;
    edPlaSanity: TEdit;
    edPlaStamina: TEdit;
    edPlaFocus: TEdit;
    edStatSpeed: TEdit;
    edStatSneak: TEdit;
    edStatFight: TEdit;
    edStatWill: TEdit;
    edStatLore: TEdit;
    edStatLuck: TEdit;
    Label14: TLabel;
    lblPlaLoc: TLabel;
    edtPlaLoc: TEdit;
    Button10: TButton;
    Button11: TButton;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure cbLocationChange(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPlaStaminaChange(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  // Статы
  ST_SPEED = 1;
  ST_SNEAK = 2;
  ST_FIGHT = 3;
  ST_WILL = 4;
  ST_LORE = 5;
  ST_LUCK = 6;
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
  CT_ENCOUNTER = 3; // Контакт (первая цифра в ID)
  // Константы Действий
  AT_SPEC = 2;
  AT_WATCH_BUY = 3;
  TLocationName: array [1..16] of string = ('607 Water St.', '7th House on the Left',
        'Administration Building', 'Arkham Asylum',
        'Artists'' Colony', 'Bank of Arkham', 'Bishop''s Brook Bridge', 'Black Cave',
        'Cold Spring Glen', 'Congregational Hospital', 'Curiositie Shoppe',
        'Darke''s Carnival', 'Devil Reef', 'Devil''s Hopyard', 'Dunwich Village',
        'Esoteric Order of Dragon');


type
  TArrayOfCard = TCardDeck;
  PArrayOfCard = ^TArrayOfCard;

var
  Main_frm: TMain_frm;
  gCurrent_phase: integer;
  Cards0, Cards1: TCardDeck; // Массивы карт
  Common_Items_Deck: TCardDeck;
  Unique_Items_Deck: TCardDeck;
  Locations_Deck: TCardDeck;
  Common_Items_Count: integer = 0;
  Unique_Items_Count: integer = 0;
  Locations_Count: integer = 0;
  Cards_Count: integer = 0;
  gPlayer: TPlayer;
  procedure Load_Cards(Card_Type: integer);

implementation

uses Unit2;

{$R *.dfm}

// Загрузка данных в карты из файла
procedure Load_Cards(Card_Type: integer);
var
  i: integer;
begin
  case Card_Type of
    CT_COMMON_ITEM: begin
      // Загружаем все карты, находящиеся в каталоге
      Common_Items_Count :=  Common_Items_Deck.Find_Cards('..\\Gofy\\CardsData\\CommonItems\\');
      Main_frm.ComboBox2.Clear;
      Main_frm.ComboBox2.Text := 'Choose a card';
      for i := 1 to Common_Items_Count do
        Main_frm.ComboBox1.Items.Add(IntToStr(Common_Items_Deck.Get_Card_ID(i)));
    end; // CT_COMMON_ITEM

    CT_UNIQUE_ITEM: begin
      // задание условий поиска и начало поиска
      Unique_Items_Count := Unique_Items_Deck.Find_Cards('..\\Gofy\\CardsData\\UniqueItems\\');

      {Form1.ComboBox2.Clear;
      Form1.ComboBox2.Text := 'Choose a card';
      Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));  }
    end; // CT_UNIQUE_ITEM

    CT_ENCOUNTER: begin
      // Задание условий поиска и начало поиска
      Locations_Count := Locations_Deck.Find_Cards('..\\Gofy\\CardsData\\Locations\\Downtown\\');

      Main_frm.cbLocation.Clear;
      Main_frm.cbLocation.Text := 'Choose a card';

      Form2.cbb1.Clear;
      Form2.cbb1.Text := 'Choose a card';

      for i := 1 to Locations_Count do
      begin
        Main_frm.cbLocation.Items.Add(IntToStr(Locations_Deck.Get_Card_ID(i)));
        Form2.cbb1.Items.Add(IntToStr(Locations_Deck.Get_Card_ID(i)));
      end;

    end; // CT_LOCATION

  end;

end;

procedure TMain_frm.RadioGroup1Click(Sender: TObject);
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

// Инициализация
// После инициализации, массив карт будет содержать
// в себе все карты определенного типа
procedure TMain_frm.Button2Click(Sender: TObject);
var
  i: integer;
  PlStats: array [1..6] of integer;
begin
  PlStats[1] := 5; // Speed
  PlStats[2] := 1; // Sneak
  PlStats[3] := 4; // Fight
  PlStats[4] := 0; // Will
  PlStats[5] := 5; // Lore
  PlStats[6] := 0; // Luck
  // Загрузка объекта игрока
  gPlayer := TPlayer.Create(PlStats, False);
  

  // Загрузка карт n-го типа (Контакты)

  // Загрузка карт обычных предметов
  Load_Cards(CT_COMMON_ITEM);

  // Загрузка карт уникальных предметов
  Load_Cards(CT_UNIQUE_ITEM);

  // Загрузка карт локаций
  Load_Cards(CT_ENCOUNTER);

  // И т.д.
end;

procedure TMain_frm.Button3Click(Sender: TObject);
var
  i: integer;
begin
  lblPlrStamina.Caption := IntToStr(gPlayer.Get_Stamina);
  lblPlrSanity.Caption := IntToStr(gPlayer.Get_Sanity);
  lblPlrFocus.Caption := IntToStr(gPlayer.Get_Focus);
  lblStatSpeed.Caption := IntToStr(gPlayer.Stats[1]);
  lblStatSneak.Caption := IntToStr(gPlayer.Stats[2]);
  lblStatFight.Caption := IntToStr(gPlayer.Stats[3]);
  lblStatWill.Caption := IntToStr(gPlayer.Stats[4]);
  lblStatLore.Caption := IntToStr(gPlayer.Stats[5]);
  lblStatLuck.Caption := IntToStr(gPlayer.Stats[6]);
  lblPlaLoc.Caption := IntToStr(gPlayer.Location);
  ListBox1.Clear;
  for i := 1 to gPlayer.Get_Items_Count do
    ListBox1.Items.Add(IntToStr(gPlayer.Get_Item(i)));
end;

procedure TMain_frm.ComboBox1Change(Sender: TObject);
begin
  Image1.Picture.LoadFromFile('..\Gofy\CardsData\CommonItems\'+ComboBox1.Text+'.jpg');
  //Common_Items_Deck.Cards[ComboBox1.ItemIndex+1].Dejstvie_karti;
end;

procedure TMain_frm.Button4Click(Sender: TObject);
begin
//  cards0[StrToInt(ComboBox1.Text)].Dejstvie_karti;
  if ComboBox1.ItemIndex < 1 then
    ShowMessage('Выберите карту')
  else
    gPlayer.Draw_Card(StrToInt(ComboBox1.Text));
end;

procedure TMain_frm.Button1Click(Sender: TObject);
var
  pl: TPlayer;
begin
  gPlayer.Take_Action(11,0);
end;

procedure TMain_frm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
//  gPlayer.Free;
  for i := 1 to 100 do
  begin
    //Cards0[i].Free;
    //Common_Items_Deck[i].Free;
    //Unique_Items_Deck[i].Free;
    //Locations_Deck[i].Free;
  end;
end;

procedure TMain_frm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 100 do
  begin
    //Cards0[i] := TCard.Create;
    Common_Items_Deck:= TCardDeck.Create;
    Unique_Items_Deck:= TCardDeck.Create;
    Locations_Deck:= TCardDeck.Create;
  end;

  for i := 1 to 16 do
  begin
    cbLocation.Items.Add(TLocationName[i]);
  end;
end;



procedure TMain_frm.Button6Click(Sender: TObject);
begin
  if ComboBox2.ItemIndex < 1 then
    ShowMessage('Выберите карту')
  else
    gPlayer.Draw_Card(StrToInt(ComboBox2.Text));
end;

procedure TMain_frm.ComboBox2Change(Sender: TObject);
begin
  Image2.Picture.LoadFromFile('..\Gofy\CardsData\UniqueItems\'+ComboBox2.Text+'.jpg');
  //Unique_Items_Deck[ComboBox2.ItemIndex+1].Dejstvie_karti;
end;

procedure TMain_frm.cbLocationChange(Sender: TObject);
var
  LocNum: integer;
begin
  LocNum := StrToInt(Copy(cbLocation.Text, 2, 1));
  lblLocID.Caption := IntToStr(LocNum);
  gPlayer.Location := StrToInt(cbLocation.Text);
  {lblLocCardData.Caption := Get_Card_By_ID(@Locations_Deck, StrToInt(cbLocation.Text)).Get_Card_Data;
  lblNumSuccesses.Caption := Copy(Locations_Deck[cbLocation.ItemIndex + 1].Get_Card_Data, 9, 3);
  case StrToInt(Copy(Get_Card_By_ID(@Locations_Deck, StrToInt(cbLocation.Text)).Get_Card_Data, 9, 1)) of
  1: lblSkill.Caption := 'Скорость';
  2: lblSkill.Caption := 'Скрытность';
  3: lblSkill.Caption := 'Сила';
  4: lblSkill.Caption := 'Воля';
  5: lblSkill.Caption := 'Знание';
  6: lblSkill.Caption := 'Удача';
  7: lblSkill.Caption := 'Уход';
  8: lblSkill.Caption := 'Битва';
  end;
  imEncounter.Picture.LoadFromFile('..\\Gofy\\CardsData\\Locations\\'+cbLocation.Text[1]+'0'+cbLocation.Text[3]+cbLocation.Text[4]+'.jpg');
}end;

procedure TMain_frm.Button9Click(Sender: TObject);
begin
  case cbLocation.ItemIndex of
  0: ShowMessage('''Listen!'' An old man with a piercing gaze locks eyes with you, and you feel strange information squirming around in your head. Pass a Will (-1) check to gain 1 Spell.');
  1: ;//ShowMessage('''Listen!'' An old man with a piercing gaze locks eyes with you, and you feel strange information squirming around in your head. Pass a Will (-1) check to gain 1 Spell.');
  2: ;
  3:  ;
  4:   ;
  5:    ;
  6:     ;
  7:      ;
  8:       ;
  9:       ;
  10:       ;
  11:        ;
  12:         ;
  13:          ;
  14:           ;
  15:            ;
  16:             ;
  end;
end;

procedure TMain_frm.DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_MULTIPLY then
    showmessage ('iwr');
end;

procedure TMain_frm.edPlaStaminaChange(Sender: TObject);
begin
  try
    gPlayer.Stamina := StrToInt(edPlaStamina.Text);
  except
    on EConvertError do
    begin
      gPlayer.Stamina := 0;
      edPlaStamina.Text := '0';
    end;
  end;
end;

procedure TMain_frm.Button10Click(Sender: TObject);
begin
  //gPlayer.Location := Locations_Deck.Draw_card;
  gPlayer.Encounter(Locations_Deck);
end;

procedure TMain_frm.Button11Click(Sender: TObject);
begin
  Locations_Deck.Shuffle;
end;

// Проверка выполнилось ли условие на карте
function Act_Condition(cond: integer; choise: integer; N:integer; min: integer; max: integer): boolean;
var
  skill_test: integer;
begin
  Act_Condition := False;
  case Cond of
  1: begin // Если True
    Act_Condition := True;
  end;
  2: begin // Проверка скила
    skill_test := gPlayer.RollADice(Choise); // Choise - номер скилла
    if (skill_test + N >= min) and
       (skill_test + N <= max) then
      Act_Condition := True
    else
      Act_Condition := False;
  end;
  3: begin // Проверка наличия
    if gPlayer.CheckAvailability(Choise, N) then //
      Act_Condition := True
    else
      Act_Condition := False;
    //ShowMessage('Проверка наличия');
  end;
  end;
end;

function Choise1: integer;
begin
  ChoiseForm.ShowModal;
end;

function Choise2: integer;
begin
  ChoiseForm.ShowModal;
end;

// Выполнение действие согласно карте
procedure Take_Action(action: integer; action_value: integer);
var
  i: integer;
begin
  case action of
  1: gPlayer.Money := gPlayer.Money + action_value;
  2: gPlayer.Money := gPlayer.Money - action_value;
  3: gPlayer.Stamina := gPlayer.Stamina + action_value;
  8: begin // Draw unique item
    gPlayer.cards_count := gPlayer.cards_count + 1;
    gPlayer.Cards[gPlayer.cards_count] := Unique_Items_Deck.Draw_Card;
  end; // case 8
  18: begin // Move to street
      gPlayer.Location := gPlayer.Location div 100 * 100;
  end; // case 18

  28: // Move to lockation, enc
    if action_value = 0 then
    begin
      Form2.ShowModal;

    end
    else
      gPlayer.Location := StrToInt(IntToStr(Round(action_value / 3 + 0.4)) + IntToStr(action_value - (Round(action_value / 3 + 0.4) - 1) * 3));
  end;
end;


// Разрешить контакт
procedure Encounter(var Locations_Deck: TCardDeck);
var
  i: integer;
  s, ns: integer;
  card_data: array [0..71] of integer;
  c_data: string;
  c_Cond1, c_Cond2: integer;
  c_Choise, c_Choise2: integer;
  c_N, c_N2: integer;
  c_NSccssMin, c_NSccssMax, c_NSccssMin2, c_NSccssMax2: integer;
  c_Action1, c_Action2, c_Action3, c_Action21, c_Action22, c_Action23: integer;
  c_Action1Value, c_Action2Value, c_Action3Value,
  c_Action21Value, c_Action22Value, c_Action23Value: integer;
  c_Act1Cond, c_Act2Cond, c_Act21Cond, c_Act22Cond, c_Else1Cond, c_Else2Cond: integer;
  c_Else1, c_Else2, c_Else21, c_Else22: integer;
  c_Else1Value, c_Else2Value, c_Else21Value, c_Else22Value: integer;
  skill_test: integer;
  choise: integer;
begin
  // TODO: таблицу с картами | N | ID_Card |, чтобы находить карты для условия
  // и добавлять новые

  // Получили данные карты
  c_data := Locations_Deck.Get_Card_By_ID(gPlayer.Location).Data;
  for i := 0 to Length(c_data)-1 do
    card_data[i] := StrToInt(c_data[i+1]);

  c_Cond1 := StrToInt(copy(c_data, 1, 2));
  c_Choise := StrToInt(copy(c_data, 3, 2));
  c_N := StrToInt(copy(c_data, 5, 2));
  c_NSccssMin := StrToInt(copy(c_data, 7, 1));
  c_NSccssMax := StrToInt(copy(c_data, 8, 1));

  c_Action1 := StrToInt(copy(c_data, 9, 2));
  c_Action1Value := StrToInt(copy(c_data, 11, 2));
  c_Act1Cond := StrToInt(copy(c_data, 13, 1));
  c_Action2 := StrToInt(copy(c_data, 14, 2));
  c_Action2Value := StrToInt(copy(c_data, 16, 2));
  c_Act2Cond := StrToInt(copy(c_data, 18, 1));
  c_Action3 := StrToInt(copy(c_data, 19, 2));
  c_Action3Value := StrToInt(copy(c_data, 21, 2));

  c_Else1 := StrToInt(copy(c_data, 23, 2));
  c_Else1Value := StrToInt(copy(c_data, 25, 2));
  c_Else1Cond := StrToInt(copy(c_data, 27, 1));
  c_Else2 := StrToInt(copy(c_data, 28, 2));
  c_Else2Value := StrToInt(copy(c_data, 30, 2));

  c_Cond2 := StrToInt(copy(c_data, 27, 2));
  c_Choise2 := StrToInt(copy(c_data, 29, 2));
  c_N2 := StrToInt(copy(c_data, 31, 1));
  c_NSccssMin2 := StrToInt(copy(c_data, 32, 1));
  c_NSccssMax2 := StrToInt(copy(c_data, 33, 1));

  c_Action21 := StrToInt(copy(c_data, 34, 2));
  c_Action21Value := StrToInt(copy(c_data, 36, 1));
  c_Act21Cond := StrToInt(copy(c_data, 37, 1));
  c_Action22 := StrToInt(copy(c_data, 38, 2));
  c_Action22Value := StrToInt(copy(c_data, 41, 1));
  c_Act22Cond := StrToInt(copy(c_data, 42, 1));

  c_Action23 := StrToInt(copy(c_data, 43, 2));
  c_Action23Value := StrToInt(copy(c_data, 45, 1));
  c_Else21 := StrToInt(copy(c_data, 46, 2));
  c_Else21Value := StrToInt(copy(c_data, 48, 1));
  c_Else2Cond := StrToInt(copy(c_data, 49, 1));
  c_Else22 := StrToInt(copy(c_data, 50, 2));
  //c_Else22Value := StrToInt(copy(c_data, 52, 1));

  // Condition
  if Act_Condition(c_Cond1, c_Choise, c_N, c_NSccssMin, c_NSccssMax) then
  begin
    //Action
    if (c_Act1Cond = 2) then// 1 OR
    begin
      if (c_Act2Cond = 2) then // 2 ORs
        choise := Choise2
      else // 1 OR
        choise := Choise1;
      case choise of
      1: Take_Action(c_Action1, c_Action1Value);
      2: Take_Action(c_Action2, c_Action2Value);
      3: Take_Action(c_Action3, c_Action3Value);
      end;
    end
    else // No ORs
      Take_Action(c_Action1, c_Action1Value);
  end
  else // else1
  begin
    if (c_Else1Cond = 2) then// 1 OR
    begin
      choise := Choise1;
      case choise of
      1: Take_Action(c_Else1, c_Else1Value);
      2: Take_Action(c_Else1, c_Else1Value);
      end;
    end
    else // No ORs
      Take_Action(c_Else1, c_Else1Value);
  end;

  // Choise1 proto
  // Dialog window: choose 1 OR 2, if 1 then take_action ... if 2 ...


end;

procedure TMain_frm.Button8Click(Sender: TObject);
begin
  Encounter(Locations_Deck);
end;

end.
