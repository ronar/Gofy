unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls, Player, Card_deck;

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
      Locations_Count := Locations_Deck.Find_Cards('..\\Gofy\\CardsData\\Locations\\');

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
  //for i := 1 to gPlayer.Get_Items_Count do
  //  ListBox1.Items.Add(IntToStr(gPlayer.Get_Item(i)));
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

procedure TMain_frm.Button8Click(Sender: TObject);
begin
  gPlayer.Encounter(Locations_Deck);
end;

end.
