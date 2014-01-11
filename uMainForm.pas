unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls, uPlayer, uCardDeck, Choise,
  uCommon, uMonster, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    btnInit: TButton;
    btnPlaData: TButton;
    GroupBox2: TGroupBox;
    lblPlrStamina: TLabel;
    Label1: TLabel;
    lblPlrSanity: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblPlrFocus: TLabel;
    lbItems: TListBox;
    Label2: TLabel;
    btnRollADie: TButton;
    Edit1: TEdit;
    lblNRolls: TLabel;
    cbLocation: TComboBox;
    Label11: TLabel;
    lblSkillCheck: TLabel;
    lblNSuccesses: TLabel;
    lblSkill: TLabel;
    lblNumSuccesses: TLabel;
    bntEncounter: TButton;
    btnProcess: TButton;
    lblLocIDCaption: TLabel;
    lblLocID: TLabel;
    lblLocCardDataCaption: TLabel;
    lblLocCardData: TLabel;
    imgEncounter: TImage;
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
    btnMoveToLok: TButton;
    btnShuffle: TButton;
    Label20: TLabel;
    lblPlaClue: TLabel;
    edtPlaClue: TEdit;
    Label27: TLabel;
    lblPlaMoney: TLabel;
    edtPlaMoney: TEdit;
    LabeledEdit1: TLabeledEdit;
    lblCurrentPlayer: TLabel;
    lblCurPlayer: TLabel;
    btnNextPers: TButton;
    btnChsInv: TButton;
    lblPlaInv: TLabel;
    edtPlaInv: TEdit;
    Label6: TLabel;
    btnUseCard: TButton;
    btnAddClue: TButton;
    imgDR1: TImage;
    lblRolls: TLabel;
    imgDR2: TImage;
    imgDR3: TImage;
    imgDR4: TImage;
    imgDR5: TImage;
    imgDR6: TImage;
    imgDR7: TImage;
    imgDR8: TImage;
    imgDR9: TImage;
    imgDR10: TImage;
    imgDR11: TImage;
    imgDR12: TImage;
    btnGiveItem: TButton;
    lbLog: TListBox;
    Label3: TLabel;
    edtLokID: TEdit;
    btnMoveToExactLok: TButton;
    tv1: TTreeView;
    xmldcmnt1: TXMLDocument;
    procedure RadioGroup1Click(Sender: TObject);
    procedure btnInitClick(Sender: TObject);
    procedure btnPlaDataClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure btnNextPersClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnUseCardClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure cbLocationChange(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPlaStaminaChange(Sender: TObject);
    procedure bntEncounterClick(Sender: TObject);
    procedure btnMoveToLokClick(Sender: TObject);
    procedure btnShuffleClick(Sender: TObject);
    procedure btnChsInvClick(Sender: TObject);
    procedure btnAddClueClick(Sender: TObject);
    procedure btnRollADieClick(Sender: TObject);
    procedure edStatSpeedChange(Sender: TObject);
    procedure btnGiveItemClick(Sender: TObject);
    procedure btnMoveToExactLokClick(Sender: TObject);
    procedure edtPlaClueExit(Sender: TObject);
    procedure edStatFightExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TLocation = record
    lok_id: integer; // id of location (2100, 2200, 2300, etc..)
    Name: string;
    clues: integer; // Улики на локации
    gate: integer; // Врата открытые на локации
    monsters: array [1..5] of integer;
    lok_mon_count: integer;
  end;

  TStreet = class
  private
    mId: integer; // id of streets (1000, 2000, 3000, etc..)
    mLok: array [1..3] of TLocation;
    mDeck: TLocationCardDeck;
    function GetDeck: TLocationCardDeck;
  public
    constructor Create(street_id: integer);
    property st_id: integer read mId write mId;
    property deck: TLocationCardDeck read GetDeck;
    function GetLokByID(id: integer): TLocation;
    procedure AddMonster(lok_id: integer; mob_id: integer);
    procedure AddClue(lok_id: integer; n: integer);
  end;

var
  frmMain: TfrmMain;
  gCurrentPhase: integer;
  Common_Items_Deck: TItemCardDeck;
  Unique_Items_Deck: TItemCardDeck;
  Spells_Deck: TItemCardDeck;
  Skills_Deck: TItemCardDeck;
  Monsters: TMonsterArray;//array [1..MONSTER_MAX] of TMonster;
  Arkham_Streets: array [1..NUMBER_OF_STREETS] of TStreet;
  Common_Items_Count: integer = 0;
  Unique_Items_Count: integer = 0;
  Spells_Count: integer = 0;
  Skills_Count: integer = 0;
  //Downtown_Count: integer = 0;
  Locations_Count: integer = 0;
  Cards_Count: integer = 0;
  players: array [1..8] of TPlayer;
  gPlayer, gCurrentPlayer: TPlayer;
  player_count: integer;
  path_to_exe: string;
  //monCount: integer;
  trees: array [1..50] of TTreeView;
  procedure Load_Cards(Card_Type: integer);
  procedure Encounter(player: TPlayer; card: CCard);
  function GetFirstPlayer: integer; // Получение номера игрока с жетоном первого игрока
  function GetLokIDByName(lok_name: string): integer; // Получение ID локации по названию
  function GetStreetIDByName(street_name: string): integer;
  function GetStreetIndxByLokID(id: integer): integer; // Searches the array for location that matches the id param
  function GetStreetNameByID(id: integer): string;
  function hon(num: integer): integer; // hundredth of number
  function ton(num: integer): integer; // thousandth of number
  //function AdditionalChecks(player: TPlayer; stat: integer): boolean;
  procedure XML2Tree(tree   : TTreeView; XMLDoc : TXMLDocument; file_name: string);
  function ProcessCondition(data: string): boolean;
  procedure ProcessAction(data: string);

implementation

uses uChsLok, Math, uInvChsForm, uTradeForm, uUseForm;

{$R *.dfm}

constructor TStreet.Create(street_id: integer);
var
  n: integer;
begin
  //for i := 1 to NUMBER_OF_STREETS do
  begin
      mid := street_id;
      for n := 1 to 3 do
      begin
        mlok[n].lok_id := mId + 100 * n;
        mlok[n].clues := 0;
        mlok[n].gate := 0;
        mlok[n].monsters[1] := 0;
        mlok[n].monsters[2] := 0;
        mlok[n].monsters[3] := 0;
        mlok[n].monsters[4] := 0;
        mlok[n].monsters[5] := 0;
        mlok[n].lok_mon_count := 0;
    end;
    mdeck := TLocationCardDeck.Create;

  end;
end;

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
      Unique_Items_Count := Unique_Items_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\UniqueItems\\');

      {Form1.ComboBox2.Clear;
      Form1.ComboBox2.Text := 'Choose a card';
      Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));  }
    end; // CT_UNIQUE_ITEM

    CT_SPELL: begin
      // задание условий поиска и начало поиска
      Spells_Count := Spells_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\Spells\\');

      {Form1.ComboBox2.Clear;
      Form1.ComboBox2.Text := 'Choose a card';
      Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));  }
    end; // CT_UNIQUE_ITEM

    CT_SKILL: begin
      // задание условий поиска и начало поиска
      Skills_Count := Skills_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\Skills\\');
    end; // CT_UNIQUE_ITEM

    CT_ENCOUNTER: begin
      // Loading cards for diff. neighborhoods
      { TODO :  Implement auto load streets, not by explicit index }
      Arkham_Streets[5].mDeck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\Locations\\Downtown\\');
      Arkham_Streets[5].mDeck.Shuffle;

    end; // CT_ENCOUNTER

  end;

end;


procedure TfrmMain.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0
  then gCurrentPhase := PH_UPKEEP;
  if RadioGroup1.ItemIndex = 1
  then gCurrentPhase := 2;
  if RadioGroup1.ItemIndex = 2
  then gCurrentPhase := 3;
  if RadioGroup1.ItemIndex = 3
  then gCurrentPhase := 4;
  if RadioGroup1.ItemIndex = 4
  then gCurrentPhase := 5;
end;

// Инициализация
// После инициализации, массив карт будет содержать
// в себе все карты определенного типа
procedure TfrmMain.btnInitClick(Sender: TObject);
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

  for i := 1 to 50 do
  begin
    trees[i] := TTreeView.Create(nil);
  end;

  for i := 1 to player_count do
  begin
    // Загрузка объекта игрока
    players[i] := TPlayer.Create(PlStats, False);
    //
  end;
  players[1].bFirstPlayer := True;

  gPlayer := players[1];
  gCurrentPlayer := players[GetFirstPlayer];
  lblCurPlayer.Caption := IntToStr(GetFirstPlayer);

  // Загрузка карт n-го типа (Контакты)

  // Загрузка карт обычных предметов
  Load_Cards(CT_COMMON_ITEM);

  // Загрузка карт уникальных предметов
  Load_Cards(CT_UNIQUE_ITEM);

  // Загрузка карт заклов
  Load_Cards(CT_SPELL);

  // Загрузка карт навыков
  Load_Cards(CT_SKILL);

  // Загрузка карт контактов
  Load_Cards(CT_ENCOUNTER);

  //monCount := 0;
  // Загрузка monsters
  LoadMonsterCards(Monsters, ExtractFilePath(Application.ExeName));

  // И т.д.
end;

procedure TfrmMain.btnPlaDataClick(Sender: TObject);
var
  i: integer;
begin
  lblPlrStamina.Caption := IntToStr(gCurrentPlayer.Stamina);
  lblPlrSanity.Caption := IntToStr(gCurrentPlayer.Sanity);
  lblPlrFocus.Caption := IntToStr(gCurrentPlayer.Focus);
  lblStatSpeed.Caption := IntToStr(gCurrentPlayer.Stats[1]);
  lblStatSneak.Caption := IntToStr(gCurrentPlayer.Stats[2]);
  lblStatFight.Caption := IntToStr(gCurrentPlayer.Stats[3]);
  lblStatWill.Caption := IntToStr(gCurrentPlayer.Stats[4]);
  lblStatLore.Caption := IntToStr(gCurrentPlayer.Stats[5]);
  lblStatLuck.Caption := IntToStr(gCurrentPlayer.Stats[6]);
  lblPlaLoc.Caption := IntToStr(gCurrentPlayer.Location);
  lblPlaClue.Caption := IntToStr(gCurrentPlayer.Clues);
  lblPlaMoney.Caption := IntToStr(gCurrentPlayer.Money);
  lblPlaInv.Caption := gCurrentPlayer.investigator.name;
  lbItems.Clear;
  for i := 1 to gPlayer.ItemsCount do
    lbItems.Items.Add(IntToStr(gCurrentPlayer.cards[i]));
end;

procedure TfrmMain.ComboBox1Change(Sender: TObject);
begin
  //Image1.Picture.LoadFromFile('..\Gofy\CardsData\CommonItems\'+ComboBox1.Text+'.jpg');
  //Common_Items_Deck.Cards[ComboBox1.ItemIndex+1].Dejstvie_karti;
end;

procedure TfrmMain.btnNextPersClick(Sender: TObject);
var
  fp, i: integer;
begin
  if GetFirstPlayer < player_count then
  begin
    fp := GetFirstPlayer;
    players[fp].bFirstPlayer := False;
    players[fp + 1].bFirstPlayer := true;
  end
  else
  begin
    players[1].bFirstPlayer := true;
    for i := 2 to player_count do
      players[i].bFirstPlayer := false;
  end;

  lblCurPlayer.Caption := IntToStr(GetFirstPlayer);
  gCurrentPlayer := players[GetFirstPlayer];

//  cards0[StrToInt(ComboBox1.Text)].Dejstvie_karti;
  //if ComboBox1.ItemIndex < 1 then
  //  ShowMessage('Выберите карту')
  //else
  //  gPlayer.Draw_Card(StrToInt(ComboBox1.Text));
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  mob_id: integer;
begin
  mob_id := DrawMonsterCard(monsters);
  ShowMessage(IntToStr(mob_id));
  Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].AddMonster(gCurrentPlayer.Location, mob_id);
 //Arkham_Streets[GetLokNumByID(gCurrentPlayer.Location)].monsters[1] := monsters[1].id;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  for i := 1 to 50 do
  begin
    trees[i].Free;
  end;

  for i := 1 to player_count do
  begin
    // Освобождение ресурсов игрока
    players[i].Free;
  end;

  Common_Items_Deck.Free;
  Unique_Items_Deck.Free;
  Spells_Deck.Free;
  Skills_Deck.Free;

  for i := 1 to NUMBER_OF_STREETS do
  begin
    Arkham_Streets[i].Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i, n: integer;
begin
  path_to_exe := ExtractFilePath(Application.ExeName);
  //for i := 1 to ITEMS_CARD_NUMBER do
  //begin
    Common_Items_Deck:= TItemCardDeck.Create(CT_COMMON_ITEM);
    Unique_Items_Deck:= TItemCardDeck.Create(CT_UNIQUE_ITEM);
    Spells_Deck:= TItemCardDeck.Create(CT_SPELL);
    Skills_Deck:= TItemCardDeck.Create(CT_SKILL);
  //end;

  for i := 1 to NUMBER_OF_STREETS do
    Arkham_Streets[i] := TStreet.Create(StrToInt(NeighborhoodsNames[i, 1]));

  for i := 1 to NUMBER_OF_LOCATIONS do
  begin
    cbLocation.Items.Add(LocationsNames[i, 2]);
  end;
  gCurrentPhase := 2;

end;



procedure TfrmMain.btnUseCardClick(Sender: TObject);
var
  i: integer;
begin
  frmUse.cbCard.Clear;
  for i := 1 to gCurrentPlayer.ItemsCount do
    frmUse.cbCard.Items.Add(IntToStr(gCurrentPlayer.Cards[i]));
  frmUse.ShowModal;
  //if ComboBox2.ItemIndex < 1 then
  //  ShowMessage('Выберите карту')
  //else
  //  gPlayer.Draw_Card(StrToInt(ComboBox2.Text));
end;

procedure TfrmMain.ComboBox2Change(Sender: TObject);
begin
  //Image2.Picture.LoadFromFile('..\Gofy\CardsData\UniqueItems\'+ComboBox2.Text+'.jpg');
  //Unique_Items_Deck[ComboBox2.ItemIndex+1].Dejstvie_karti;
end;

procedure TfrmMain.cbLocationChange(Sender: TObject);
var
  LocNum: integer;
begin
  LocNum := getLokIDByName(cbLocation.Text);
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

procedure TfrmMain.btnProcessClick(Sender: TObject);
begin
  case gCurrentPhase of
    PH_UPKEEP: begin
      gCurrentPhase := PH_MOVE;
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

procedure TfrmMain.DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_MULTIPLY then
    showmessage ('iwr');
end;

procedure TfrmMain.edPlaStaminaChange(Sender: TObject);
begin
  try
    gCurrentPlayer.Stamina := StrToInt(edPlaStamina.Text);
  except
    on EConvertError do
    begin
      gCurrentPlayer.Stamina := 0;
      edPlaStamina.Text := '0';
    end;
  end;
end;

procedure TfrmMain.btnMoveToLokClick(Sender: TObject);
begin
  if gCurrentPhase = PH_MOVE then
  begin
    gCurrentPlayer.MoveToLocation(GetLokIDByName(cbLocation.Text));
    if Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location).clues > 0 then
      gCurrentPlayer.Clues := gCurrentPlayer.Clues + 1; // Сбор улик :)
    //Showmessage(IntToStr(GetLokByID(gCurrentPlayer.Location).monsters[1]));
    if Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location).monsters[1] > 0 then
      if MessageDlg('Care for battle with an awful monster?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        ShowMessage('Let''s battle!')
      else
        ShowMessage('Aah. Forget it.')

      //gCurrentPlayer.Clues := gCurrentPlayer.Clues + 1; // Сбор улик :)

    //gCurrent_phase := PH_ENCOUNTER;
  end
  else
    ShowMessage('Wrong phase.');

  //gPlayer.Encounter(Locations_Deck);
end;

procedure TfrmMain.btnShuffleClick(Sender: TObject);
begin
  //arkham[2].Deck.Shuffle;
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
    frmMain.lbLog.Items.Add('Проверяется навык ' + IntToStr(Choise - 1) + '(=' + IntToStr(gCurrentPlayer.Stats[Choise - 1]) + ' -' + IntToStr(N) + ')..');
    skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[Choise - 1] - N); // Choise - номер скилла
    { TODO -oRonar : Choise is in dependence with structure of construction
      of program. In another words if indices have been changed, program
      will be broken }
    frmMain.lbLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
    if (skill_test >= min) then
      Act_Condition := True
    else
    begin
     Act_Condition := False;
    end;
  end;
  3: begin // Проверка наличия
    if gPlayer.CheckAvailability(Choise, N) then //
      Act_Condition := True
    else
      Act_Condition := False;
    frmMain.lbLog.Items.Add('Проверка наличия');
  end; // case 3
  7: begin // Spec. card
    if MessageDlg('Confirm?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      frmMain.lbLog.Items.Add('Проверяется навык ' + IntToStr(Choise - 1) + '(=' + IntToStr(gCurrentPlayer.Stats[Choise - 1]) + ')..');
      skill_test := gPlayer.RollADice(gCurrentPlayer.Stats[Choise - 1] - N); // Choise - номер скилла
      frmMain.lbLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
      if (skill_test >= min) then
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
  if ChoiseForm.RadioButton1.Checked then
    Choise1 := 1
  else
    if ChoiseForm.RadioButton2.Checked then
      Choise1 := 2;
end;

function Choise2(act1: integer; act2: integer; act3: integer): integer;
begin
  ChoiseForm.Choise2(act1, act2, act3);
  ChoiseForm.ShowModal;
  if ChoiseForm.RadioButton1.Checked then
    Choise2 := 1
  else
    if ChoiseForm.RadioButton2.Checked then
      Choise2 := 2
    else
      Choise2 := 3;
end;

// Выполнение действия согласно карте
procedure Take_Action(action: integer; action_value: integer; choise: integer = 0; n: integer = 0);
var
  i: integer;
begin
  case action of
  1: begin
    gPlayer.Money := gPlayer.Money + action_value;
    frmMain.lbLog.Items.Add('Игрок получил деньги: ' + IntToStr(action_value) + '.');
  end;
  2: begin
    gPlayer.Money := gPlayer.Money - action_value;
    frmMain.lbLog.Items.Add('Игрок потерял деньги: ' + IntToStr(action_value) + '.');
  end;
  3: begin // Take stamina
    gPlayer.Stamina := gPlayer.Stamina + action_value;
    frmMain.lbLog.Items.Add('Игрок получил тело: ' + IntToStr(action_value) + '.');
  end;
  4: begin // Take sanity
    gPlayer.Stamina := gPlayer.Sanity + action_value;
    frmMain.lbLog.Items.Add('Игрок получил разум: ' + IntToStr(action_value) + '.');
  end;
  5: begin // Lose stamina
    gCurrentPlayer.Stamina := gCurrentPlayer.Stamina - action_value;
    frmMain.lbLog.Items.Add('Игрок потерял тело: ' + IntToStr(action_value) + '.');
  end; // case 5
  6: begin // Lose sanity
    gCurrentPlayer.Sanity := gCurrentPlayer.Sanity - action_value;
    frmMain.lbLog.Items.Add('Игрок потерял разум: ' + IntToStr(action_value) + '.');
  end; // case 6
  7: begin // Take clues
    gCurrentPlayer.Clues := gCurrentPlayer.Clues + action_value;
    frmMain.lbLog.Items.Add('Игрок получил улику(и): ' + IntToStr(action_value) + '.');
  end; // case 7
  8: begin // Lose clues
    gCurrentPlayer.Clues := gCurrentPlayer.Clues - action_value;
    frmMain.lbLog.Items.Add('Игрок потерял улику(и): ' + IntToStr(action_value) + '.');
  end; // case 8
  9: begin // Draw common item
    gCurrentPlayer.AddItem(Common_Items_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок вытянул карту простого предмета.');
  end; // case 9
  10: begin // Draw unique item
    gCurrentPlayer.AddItem(Unique_Items_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок вытянул карту уникального предмета.');
  end; // case 10
  11: begin // Draw spell
    gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок вытянул карту закла.');
  end; // case 11
  12: begin // Draw skill
    //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок берет карту навыка.');
  end; // case 12
  13: begin // Draw ally card
    //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок вытянул карту союзника: ' + IntToStr(action_value) + '.');
  end; // case 13
  15: begin // Drop item of player's choise
    //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок потерял предмет (на выбор).');
  end; // case 15
  18: begin // Drop spell
    //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок потерял закл.');
  end; // case 18
  19: begin // Drop skill
    //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
    frmMain.lbLog.Items.Add('Игрок потерял навык.');
  end; // case 19
  20: begin // Move to street
    //gCurrentPlayer.Blessed := True;
    frmMain.lbLog.Items.Add('Игрок вышел на улицу (overlapping).');
  end; // case 20
  21: begin // Busted
    //gCurrentPlayer.Blessed := True;
    frmMain.lbLog.Items.Add('Игрок взят в полицайку.');
  end; // case 21
  22: begin // Blessed
    gCurrentPlayer.Blessed := True;
    frmMain.lbLog.Items.Add('Игрок благословен.');
  end; // case 22
  23: begin // Cursed
    gCurrentPlayer.Cursed := True;
    frmMain.lbLog.Items.Add('Игрок проклят.');
  end; // case 23

  33: begin // Move to lok (ID или если 0 - на любую)
    if action_value = 0 then
    begin
      frmChsLok.ShowModal;
      gCurrentPlayer.Location := StrToInt(frmChsLok.edtLok.Text);
    end
    else
      gCurrentPlayer.Location := action_value;

    gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
    frmMain.lbLog.Items.Add('Игрок вышел на улицу.');
  end; // case 33
  34: begin // Move to street
    gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
    frmMain.lbLog.Items.Add('Игрок вышел на улицу.');
  end; // case 34
  35: begin // Sucked into gate
    //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
    frmMain.lbLog.Items.Add('Игрока затянуло во врата.');
  end; // case 35

  38: begin // Pass turn
    //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
    frmMain.lbLog.Items.Add('Игрок пропускает ход.');
  end; // case 38

 { 41: begin // Check skill
    frmMain.lbLog.Items.Add('Проверяется навык ' + IntToStr(Choise - 1) + '(=' + IntToStr(gCurrentPlayer.Stats[Choise - 1]) + ' -' + IntToStr(N) + ')..');
    skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[Choise - 1] - N); // Choise - номер скилла
    frmMain.lbLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
    if (skill_test >= min) then
      Take_Action();
    else
    begin
     Take_Action();
    end;
  end; }// case 41

  28: // Move to location, enc
    if action_value = 0 then
    begin
      frmChsLok.ShowModal;

    end
    else
      ; //gPlayer.Location := StrToInt(IntToStr(Round(action_value / 3 + 0.4)) + IntToStr(action_value - (Round(action_value / 3 + 0.4) - 1) * 3));
  end;
end;


// Разрешить контакт
procedure Encounter(player: TPlayer; card: CCard);
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
  c_data := card.Data;
  if c_data = '' then
  begin
    MessageDlg('Не удалось загрузить карту.', mtError, [mbOK], 0);
    exit;
  end;

  frmMain.imgEncounter.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Locations\Downtown\' + IntToStr((ton(card.ID) * 1000) + StrToInt(IntToStr(card.ID)[4])) + '.jpg');

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

{  c_Cond2 := StrToInt(copy(c_data, 27, 2));
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
}  //c_Else22Value := StrToInt(copy(c_data, 52, 1));

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
        else // !2 AND
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
        if (c_Else2Cond = 1) then // OR / AND
        begin
          choise := Choise1(c_Else1, c_Else2);
          Take_Action(c_Else3, c_Else3Value);
        end
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
        if (c_Else2Cond = 1) then // 2 AND
        begin
          Take_Action(c_Else1, c_Else1Value);
          Take_Action(c_Else2, c_Else2Value);
          Take_Action(c_Else3, c_Else3Value);
        end // !2 AND
        else
          if (c_Else2Cond = 2) then // AND / OR
          begin
            Take_Action(c_Else1, c_Else1Value);
            choise := Choise1(c_Else2, c_Else3);
          end
          else
          begin
            Take_Action(c_Else1, c_Else1Value);
            Take_Action(c_Else2, c_Else2Value);
          end;
      end
      else // !1 AND
        Take_Action(c_Else1, c_Else1Value);
    end;
  end;

  // Choise1 proto
  // Dialog window: choose 1 OR 2, if 1 then take_action ... if 2 ...

end;

procedure TfrmMain.bntEncounterClick(Sender: TObject);
var
  lok: TLocation;
  drawn_items: array [1..3] of integer;
begin
  //lok := GetLokByID(gCurrentPlayer.Location);
  if gCurrentPhase = PH_ENCOUNTER then
  begin
    case gCurrentPlayer.Location of
      4300: begin
        if MessageDlg('Trade?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          drawn_items[1] := Common_Items_Deck.DrawCard;
          drawn_items[2] := Common_Items_Deck.DrawCard;
          drawn_items[3] := Common_Items_Deck.DrawCard;
          frmTrade.Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\' + IntToStr(drawn_items[1]) + '.jpg');
          frmTrade.Image2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\' + IntToStr(drawn_items[2]) + '.jpg');
          frmTrade.Image3.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\' + IntToStr(drawn_items[3]) + '.jpg');
          frmTrade.RadioButton1.Caption := IntToStr(drawn_items[1]);
          frmTrade.RadioButton2.Caption := IntToStr(drawn_items[2]);
          frmTrade.RadioButton3.Caption := IntToStr(drawn_items[3]);
          frmTrade.ShowModal;
          If frmTrade.RadioButton1.Checked then
            gCurrentPlayer.AddItem(drawn_items[1]);
          If frmTrade.RadioButton2.Checked then
            gCurrentPlayer.AddItem(drawn_items[2]);
          If frmTrade.RadioButton3.Checked then
            gCurrentPlayer.AddItem(drawn_items[3]);
        end
        else
          Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.DrawCard(hon(gCurrentPlayer.Location)));
      end; // 4300
      else Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.DrawCard(hon(gCurrentPlayer.Location)));
    end;

    Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.Shuffle;
  end
  else
    ShowMessage('Wrong phase!');
end;

function GetFirstPlayer;
var
  i: integer;
begin
  for i := 1 to player_count do
  begin
    if players[i].bFirstPlayer then
      Result := i;
  end;
end;

// Берет назв. локи из массива LocationsNames
function GetLokIDByName(lok_name: string): integer;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_LOCATIONS do
    if ((LocationsNames[i, 2] = lok_name) AND (StrToInt(LocationsNames[i, 1]) > 1000)) then
    begin
      result := StrToInt(LocationsNames[i, 1]);
      break;
    end
    else
      result := 1100;
end;

function GetStreetIDByName(street_name: string): integer;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_LOCATIONS do
    if ((LocationsNames[i, 2] = street_name) AND (StrToInt(LocationsNames[i, 1]) > 1000)) then
    begin
      result := StrToInt(LocationsNames[i, 1]);
      break;
    end
    else
      result := 1100;
end;

function TStreet.GetDeck: TLocationCardDeck;
begin
  result := mDeck;
end;

function TStreet.GetLokByID(id: integer): TLocation;
var
  i: integer;
  ln: integer;
begin
  ln := GetStreetIndxByLokID( ton(id) * 1000 );
  result := Arkham_Streets[ln].mlok[hon(id)];
end;

procedure TStreet.AddMonster(lok_id: integer; mob_id: integer);
begin
  mlok[hon(lok_id)].monsters[1] := mob_id;
end;

procedure TStreet.AddClue(lok_id: integer; n: integer);
begin
  mlok[hon(lok_id)].clues := mlok[hon(lok_id)].clues + n;
end;

procedure TfrmMain.btnChsInvClick(Sender: TObject);
var
  i: integer;
begin
  frmInv.ShowModal;
  gCurrentPlayer.AssignInvestigator(inv); // Investigator := inv;
  gCurrentPlayer.ChangeSkills(1,1);
  gCurrentPlayer.ChangeSkills(2,1);
  gCurrentPlayer.ChangeSkills(3,1);
end;

procedure Fight;
begin

end;

// Searches the array for location that matches the id param
function GetStreetIndxByLokID(id: integer): integer;
var
  i: integer;
  st: integer;
begin
  st := ton(id) * 1000;
  for i := 1 to NUMBER_OF_STREETS do
    if Arkham_Streets[i].mid = st then
    begin
      result := i;
      break;
    end;
end;

function GetStreetNameByID(id: integer): string;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_STREETS do
    if StrToInt(NeighborhoodsNames[i, 1]) = id then
      GetStreetNameByID := NeighborhoodsNames[i, 2];
end;


function hon(num: integer): integer; // hundredth of number // thousandth of number
var
  tmp: integer;
begin
  result := (num mod 1000) div 100;
end;

function ton(num: integer): integer; // thousandth of number
var
  tmp: integer;
begin
  result := num div 1000;
end;

procedure TfrmMain.btnAddClueClick(Sender: TObject);
begin
  Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].AddClue(gCurrentPlayer.Location, 1);
end;

procedure TfrmMain.btnRollADieClick(Sender: TObject);
begin
  gCurrentPlayer.RollADice(StrToInt(Edit1.Text));
end;

procedure TfrmMain.edStatSpeedChange(Sender: TObject);
begin
  try
    gCurrentPlayer.Speed := StrToInt(edStatSpeed.Text);
  except
    on EConvertError do
    begin
      //gCurrentPlayer.Speed := 0;
      edStatSpeed.Text := '0';
    end;
  end;
end;

// Checks wether player can or cannot roll additional dice
function AdditionalChecks(player: TPlayer; stat: integer): boolean;
begin
  if (player.Clues > 0) or (player.HasItem(1342)) then
    AdditionalChecks := True
  else
    AdditionalChecks := False;

end;

procedure TfrmMain.btnGiveItemClick(Sender: TObject);
begin
  gCurrentPlayer.AddItem(1342);
end;

procedure TfrmMain.btnMoveToExactLokClick(Sender: TObject);
begin
  Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(StrToInt(edtLokID.Text))].deck.cards[StrToInt(edtLokID.Text)]);
  //ShowMessage(IntToStr(hon(2200)));
end;

procedure TfrmMain.edtPlaClueExit(Sender: TObject);
begin
  try
    gCurrentPlayer.Clues := StrToInt(edtPlaClue.Text);
  except
    ShowMessage('No!');
    edtPlaClue.Text := '0';
  end;
end;

procedure TfrmMain.edStatFightExit(Sender: TObject);
begin
  try
    gCurrentPlayer.Fight := StrToInt(edStatFight.Text);
  except
    ShowMessage('No!');
    edStatFight.Text := '0';
  end;
end;

procedure XML2Tree(
          tree   : TTreeView;
          XMLDoc : TXMLDocument;
          file_name: string);
var
  iNode : IXMLNode;
  pc, t, f: boolean;

  procedure ProcessNode(
        Node : IXMLNode;
        tn   : TTreeNode);
  var
    cNode : IXMLNode;
    s: string;
  begin
    if Node = nil then Exit;
    with Node do
    begin
      tn := tree.Items.AddChild(tn, Attributes['type']);
      //ShowMessage(Attributes['type']);
     { if (Attributes['type'] = 't') and (not pc) then
        Exit
      else
        t := true;

      if (Attributes['type'] = 'f') and pc then
        Exit
      else
        f := true;    }

      if HasAttribute('data') then
      begin
        //s := Attributes['type'];
        tn.Text := tn.Text + Attributes['data'];
//        if Attributes['type'] = 'c' then
//        begin
//          pc := ProcessCondition(Attributes['data']);
//        end;
//        if (Attributes['type'] = 'a') and ((not t and not f)
//            or (pc and t) or (not pc and f)) then
//        begin
//          ProcessAction(Attributes['data']);
//          f := false;
//          t := false;
//        end;


      end;
    end;



    cNode := Node.ChildNodes.First;
    while cNode <> nil do
    begin
      ProcessNode(cNode, tn);
      cNode := cNode.NextSibling;
    end;
  end; (*ProcessNode*)
begin
  tree.Items.Clear;
  XMLDoc.FileName := ExtractFilePath(Application.ExeName)+file_name;//ChangeFileExt(ParamStr(0),'.XML');
  XMLDoc.Active := True;

  iNode := XMLDoc.DocumentElement.ChildNodes.First;

  while iNode <> nil do
  begin
    ProcessNode(iNode,nil);
    iNode := iNode.NextSibling;
  end;

  XMLDoc.Active := False;
end;

function ProcessCondition(data: string): boolean;
begin
  if StrToInt(copy(data, 1, 2)) = 1 then
    ShowMessage('Проверка скилла ' + (copy(data, 3, 2)));
  ProcessCondition := true;
end;

procedure ProcessAction(data: string);
begin
  //if StrToInt(copy(data, 1, 2)) = 1 then
  ShowMessage('Process action.' + data);
end;

end.
