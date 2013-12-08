unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls, uPlayer, uCardDeck, Choise;

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
    Label20: TLabel;
    lblPlaClue: TLabel;
    edtPlaClue: TEdit;
    Label27: TLabel;
    lblPlaMoney: TLabel;
    edtPlaMoney: TEdit;
    LabeledEdit1: TLabeledEdit;
    lblCurrentPlayer: TLabel;
    lblCurPlayer: TLabel;
    Button4: TButton;
    Button5: TButton;
    lblPlaInv: TLabel;
    edtPlaInv: TEdit;
    Label6: TLabel;
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
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TLocation = record
    id: integer;
    Name: string;
    Neighborhood: string;
    deck: TLocationCardDeck;
    card_count: integer;
  end;

var
  Main_frm: TMain_frm;
  gCurrent_phase: integer;
  Cards0, Cards1: TCardDeck; // Массивы карт
  Common_Items_Deck: TItemCardDeck;
  Unique_Items_Deck: TItemCardDeck;
  Downtown: TLocation;
  Common_Items_Count: integer = 0;
  Unique_Items_Count: integer = 0;
  //Downtown_Count: integer = 0;
  Locations_Count: integer = 0;
  Cards_Count: integer = 0;
  players: array [1..8] of TPlayer;
  gPlayer, gCurrentPlayer: TPlayer;
  player_count: integer;
  procedure Load_Cards(Card_Type: integer);
  procedure Encounter(player: TPlayer; var Locations_Deck: TLocationCardDeck; card: integer);
  function GetFirstPlayer: integer; // Получение номера игрока с жетоном первого игрока
  function GetLokID(lok_name: string): string; // Получение ID локации по названию
  function GetLokByID(id: integer): TLocation;

implementation

uses Unit2, Math, uInvChsForm, uCommon;

{$R *.dfm}

// Загрузка данных в карты из файла
procedure Load_Cards(Card_Type: integer);
var
  i: integer;
begin
  case Card_Type of
    CT_COMMON_ITEM: begin
      // Загружаем все карты, находящиеся в каталоге
      Common_Items_Count :=  Common_Items_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\CommonItems\\');
      //Main_frm.ComboBox2.Clear;
      //Main_frm.ComboBox2.Text := 'Choose a card';
      //for i := 1 to Common_Items_Count do
      //  Main_frm.ComboBox1.Items.Add(IntToStr(Common_Items_Deck.Get_Card_ID(i)));
    end; // CT_COMMON_ITEM

    CT_UNIQUE_ITEM: begin
      // задание условий поиска и начало поиска
      //Unique_Items_Count := Unique_Items_Deck.Find_Cards(ExtractFilePath(Application.ExeName)+'\\CardsData\\UniqueItems\\');

      {Form1.ComboBox2.Clear;
      Form1.ComboBox2.Text := 'Choose a card';
      Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));  }
    end; // CT_UNIQUE_ITEM

    CT_ENCOUNTER: begin
      // Loading cards for diff. neighborhoods
      Downtown.card_count := Downtown.deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\Locations\\Downtown\\');

      //Main_frm.cbLocation.Clear;
      //Main_frm.cbLocation.Text := 'Choose a card';

      //Form2.cbb1.Clear;
      //Form2.cbb1.Text := 'Choose a card';

      for i := 1 to Downtown.card_count do
      begin
        //Main_frm.cbLocation.Items.Add(IntToStr(Downtown_Deck.Get_Card_ID(i)));
        //Form2.cbb1.Items.Add(IntToStr(Downtown_Deck.Get_Card_ID(i)));
      end;

    end; // CT_ENCOUNTER

  end;

end;

procedure TMain_frm.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0
  then gCurrent_phase := PH_UPKEEP;
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

  player_count := StrToInt(LabeledEdit1.Text);

  for i := 1 to player_count do
  begin
    // Загрузка объекта игрока
    players[i] := TPlayer.Create(PlStats, False);
    players[i].investigator := nil;
  end;
  players[1].bFirst_Player := True;

  gPlayer := players[1];
  gCurrentPlayer := players[GetFirstPlayer];
  lblCurPlayer.Caption := IntToStr(GetFirstPlayer);

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
  lblPlrStamina.Caption := IntToStr(gCurrentPlayer.Get_Stamina);
  lblPlrSanity.Caption := IntToStr(gCurrentPlayer.Get_Sanity);
  lblPlrFocus.Caption := IntToStr(gCurrentPlayer.Get_Focus);
  lblStatSpeed.Caption := IntToStr(gCurrentPlayer.Stats[1]);
  lblStatSneak.Caption := IntToStr(gCurrentPlayer.Stats[2]);
  lblStatFight.Caption := IntToStr(gCurrentPlayer.Stats[3]);
  lblStatWill.Caption := IntToStr(gCurrentPlayer.Stats[4]);
  lblStatLore.Caption := IntToStr(gCurrentPlayer.Stats[5]);
  lblStatLuck.Caption := IntToStr(gCurrentPlayer.Stats[6]);
  lblPlaLoc.Caption := IntToStr(gCurrentPlayer.Location);
  lblPlaClue.Caption := IntToStr(gCurrentPlayer.Clue_Token);
  lblPlaMoney.Caption := IntToStr(gCurrentPlayer.Money);
  lblPlaInv.Caption := gCurrentPlayer.investigator.name;
  ListBox1.Clear;
  for i := 1 to gPlayer.Get_Items_Count do
    ListBox1.Items.Add(IntToStr(gCurrentPlayer.Get_Item(i)));
end;

procedure TMain_frm.ComboBox1Change(Sender: TObject);
begin
  //Image1.Picture.LoadFromFile('..\Gofy\CardsData\CommonItems\'+ComboBox1.Text+'.jpg');
  //Common_Items_Deck.Cards[ComboBox1.ItemIndex+1].Dejstvie_karti;
end;

procedure TMain_frm.Button4Click(Sender: TObject);
var
  fp, i: integer;
begin
  if GetFirstPlayer < player_count then
  begin
    fp := GetFirstPlayer;
    players[fp].bFirst_Player := False;
    players[fp + 1].bFirst_Player := true;
  end
  else
  begin
    players[1].bFirst_Player := true;
    for i := 2 to player_count do
      players[i].bFirst_Player := false;
  end;

  lblCurPlayer.Caption := IntToStr(GetFirstPlayer);
  gCurrentPlayer := players[GetFirstPlayer];

//  cards0[StrToInt(ComboBox1.Text)].Dejstvie_karti;
  //if ComboBox1.ItemIndex < 1 then
  //  ShowMessage('Выберите карту')
  //else
  //  gPlayer.Draw_Card(StrToInt(ComboBox1.Text));
end;

procedure TMain_frm.Button1Click(Sender: TObject);
var
  pl: TPlayer;
begin
  gPlayer.Take_Action(11, 0);
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
    Common_Items_Deck:= TItemCardDeck.Create(CT_COMMON_ITEM);
    Unique_Items_Deck:= TItemCardDeck.Create(CT_UNIQUE_ITEM);
    Downtown.deck:= TLocationCardDeck.Create;
  end;

  for i := 1 to 57 do
  begin
    cbLocation.Items.Add(LocationsNames[i, 2]);
  end;
  gCurrent_phase := 2;
end;



procedure TMain_frm.Button6Click(Sender: TObject);
begin
  //if ComboBox2.ItemIndex < 1 then
  //  ShowMessage('Выберите карту')
  //else
  //  gPlayer.Draw_Card(StrToInt(ComboBox2.Text));
end;

procedure TMain_frm.ComboBox2Change(Sender: TObject);
begin
  //Image2.Picture.LoadFromFile('..\Gofy\CardsData\UniqueItems\'+ComboBox2.Text+'.jpg');
  //Unique_Items_Deck[ComboBox2.ItemIndex+1].Dejstvie_karti;
end;

procedure TMain_frm.cbLocationChange(Sender: TObject);
var
  LocNum: integer;
begin
  LocNum := StrToInt(getLokID(cbLocation.Text));
  lblLocID.Caption := IntToStr(LocNum);
  //gPlayer.Location := StrToInt(cbLocation.Text);
  {lblLocCardData.Caption := Get_Card_By_ID(@Locations_Deck, StrToInt(cbLocation.Text)).Get_Card_Data;
  lblNumSuccesses.Caption := Copy(Locations_Deck[cbLocation.ItemIndex + 1].Get_Card_Data, 9, 3);
  }

  //lblLocCardData.Caption := Downtown_Deck.GetCardByID(StrToInt(cbLocation.Text)).Data;

  {case StrToInt(Copy(Locations_Deck.GetCardByID(StrToInt(cbLocation.Text)).Data, 3, 2)) of
  //1: lblSkill.Caption := ;
  2: lblSkill.Caption := 'Скорость';
  3: lblSkill.Caption := 'Скрытность';
  4: lblSkill.Caption := 'Битва';
  5: lblSkill.Caption := 'Воля';
  6: lblSkill.Caption := 'Знание';
  7: lblSkill.Caption := 'Удача';
  8: lblSkill.Caption := 'Уход';
  end;         }
  //imEncounter.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\\CardsData\\Locations\\Downtown\\'+GetLokID(cbLocation.Text)+'.jpg');
end;

procedure TMain_frm.Button9Click(Sender: TObject);
begin
  case gCurrent_phase of
    PH_UPKEEP: begin
      gCurrent_phase := PH_MOVE;
    end;
    PH_MOVE: begin

    end;
    PH_ENCOUNTER: begin

      //Encounter(gCurrentPlayer, Downtown.Deck, Downtown.Deck.DrawCard);
    end;
    PH_KONTAKTI_V_INIH_MIRAH: begin
    end;
    PH_MYTHOS: begin
    end;
  end;
{  case cbLocation.ItemIndex of
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
}
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
  if gCurrent_phase = PH_MOVE then
  begin
    gCurrentPlayer.Location := StrToInt(GetLokID(cbLocation.Text));//Locations_Deck.DrawCard;
    //gCurrent_phase := PH_ENCOUNTER;
  end
  else
    ShowMessage('Wrong phase.');
  //gPlayer.Encounter(Locations_Deck);
end;

procedure TMain_frm.Button11Click(Sender: TObject);
begin
  Downtown.Deck.Shuffle;
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
    skill_test := gPlayer.RollADice(Choise - 1); // Choise - номер скилла
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
  end; // case 3
  7: begin // Spec. card
    if MessageDlg('Confirm?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      skill_test := gPlayer.RollADice(Choise - 2); // Choise - номер скилла
      if (skill_test + N >= min) and
        (skill_test + N <= max) then
        Act_Condition := True
      else
        Act_Condition := False;
    end;
  end;
  end;
end;

function Choise1(act1: integer; act2: integer): integer;
begin
  ChoiseForm.Choise1(act1, act2);
  ChoiseForm.ShowModal;
end;

function Choise2(act1: integer; act2: integer; act3: integer): integer;
begin
  ChoiseForm.Choise2(act1, act2, act3);
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
    //gPlayer.Cards[gPlayer.cards_count] := Unique_Items_Deck.DrawCard;
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
procedure Encounter(player: TPlayer; var Locations_Deck: TLocationCardDeck; card: integer);
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
  c_Else1, c_Else2, c_Else3, c_Else21, c_Else22: integer;
  c_Else1Value, c_Else2Value, c_Else3Value, c_Else21Value, c_Else22Value: integer;
  skill_test: integer;
  choise: integer;
begin
  // TODO: таблицу с картами | N | ID_Card |, чтобы находить карты для условия
  // и добавлять новые

  // Получили данные карты
  c_data := Locations_Deck.GetCardByID(card).Data;
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
  c_Else2Cond := StrToInt(copy(c_data, 32, 1));
  c_Else3 := StrToInt(copy(c_data, 33, 2));
  c_Else3Value := StrToInt(copy(c_data, 35, 2));

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
        choise := Choise2(c_Action1, c_Action2, c_Action3)
      else // 1 OR
        if (c_Act2Cond = 1) then // OR / AND
        begin
          choise := Choise1(c_Action1, c_Action2);
          Take_Action(c_Action3, c_Action3Value);
        end
        else
          choise := Choise1(c_Action1, c_Action2);
      case choise of
      1: Take_Action(c_Action1, c_Action1Value);
      2: Take_Action(c_Action2, c_Action2Value);
      3: Take_Action(c_Action3, c_Action3Value);
      end;
    end
    else // No ORs
    begin
      if (c_Act1Cond = 1) then// 1 AND
      begin
        if (c_Act2Cond = 1) then // 2 AND
        begin
          Take_Action(c_Action1, c_Action1Value);
          Take_Action(c_Action2, c_Action2Value);
          Take_Action(c_Action3, c_Action3Value);
        end
        else // 2 AND
        //begin
          if (c_Act2Cond = 2) then // AND / OR
          begin
            Take_Action(c_Action1, c_Action1Value);
            choise := Choise1(c_Action2, c_Action3);
          end
          else
          begin
            Take_Action(c_Action1, c_Action1Value);
            Take_Action(c_Action2, c_Action2Value);
          end;
      end
      else // 1 AND
        Take_Action(c_Action1, c_Action1Value);
    end; // else No ORs
  end
  else // else1
  begin
    if (c_Else1Cond = 2) then // 1 OR
    begin
      if (c_Else2Cond = 2) then // 2 OR
        choise := Choise2(c_Else1, c_Else2, c_Else3)
      else
        choise := Choise1(c_Else1, c_Else2);
      case choise of
      1: Take_Action(c_Else1, c_Else1Value);
      2: Take_Action(c_Else2, c_Else2Value);
      3: Take_Action(c_Else3, c_Else3Value);
      end;
    end
    else // No ORs
    begin
      if (c_Else1Cond = 1) then// 1 AND
      begin
        Take_Action(c_Else1, c_Else1Value);
        Take_Action(c_Else2, c_Else2Value);
      end
      else
        Take_Action(c_Else1, c_Else1Value);
    end;
  end;

  // Choise1 proto
  // Dialog window: choose 1 OR 2, if 1 then take_action ... if 2 ...

end;

procedure TMain_frm.Button8Click(Sender: TObject);
var
  lok: TLocation;
begin
  lok := GetLokByID(gCurrentPlayer.Location);
  Encounter(players[GetFirstPlayer], lok.Deck, lok.Deck.DrawCard(StrToInt(copy(IntToStr(gCurrentPlayer.Location), 2, 1))));
end;

function GetFirstPlayer;
var
  i: integer;
begin
  for i := 1 to player_count do
  begin
    if players[i].bFirst_Player then
      Result := i;
  end;
end;

function GetLokID(lok_name: string): string;
var
  i: integer;
begin
  for i := 1 to 57 do
    if LocationsNames[i, 2] = lok_name then
    begin
      result := LocationsNames[i, 1];
      break;
    end;
end;

function GetLokByID(id: integer): TLocation;
var
  i: integer;
begin
  result := Downtown;
end;

procedure TMain_frm.Button5Click(Sender: TObject);
var
  i: integer;
begin
  InvFrm.ShowModal;
  gCurrentPlayer.investigator := inv;
  gCurrentPlayer.ChangeSkills(1,1);
  gCurrentPlayer.ChangeSkills(2,1);
  gCurrentPlayer.ChangeSkills(3,1);
  gCurrentPlayer.Sanity := inv.sanity;
  gCurrentPlayer.Stamina := inv.stamina;
  gCurrentPlayer.Money := inv.money;
  gCurrentPlayer.Clue_Token := inv.clues;
  gCurrentPlayer.Location :=  inv.start_lok;
  gCurrentPlayer.Focus := inv.focus;

  //for i := 1 to player_count do
  //  players[i].investigator := (InvFrm.FindComponent('cbInvPlayer'+IntToStr(i)) as TComboBox).ItemIndex + 1;
end;

end.
