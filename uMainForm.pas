unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls, uPlayer, uCardDeck, Choise,
  uCommon, uMonster, xmldom, XMLIntf, msxmldom, XMLDoc, uCardXML, Spin;

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
    bntEncounter: TButton;
    btnProcess: TButton;
    lblLocIDCaption: TLabel;
    lblLocID: TLabel;
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
    xmldoc1: TXMLDocument;
    btn1: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    btn2: TButton;
    seCrdNum: TSpinEdit;
    Label7: TLabel;
    btnLogClear: TButton;
    Button2: TButton;
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
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure edStatWillExit(Sender: TObject);
    procedure edStatLuckExit(Sender: TObject);
    procedure edtPlaMoneyExit(Sender: TObject);
    procedure edStatLoreExit(Sender: TObject);
    procedure btnLogClearClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TLocation = record
    lok_id: integer; // id of location (2100, 2200, 2300, etc..)
    lok_name: string;
    clues: integer; // Улики на локации
    gate: integer; // Врата открытые на локации
    monsters: array [1..5] of integer;
    lok_mon_count: integer;
  end;

  TStreet = class
  private
    fId: integer; // id of streets (1000, 2000, 3000, etc..)
    fLok: array [1..3] of TLocation;
    fDeck: TLocationCardsDeck;
    function GetDeck: TLocationCardsDeck;
  public
    constructor Create(street_id: integer);
    property StreetId: integer read fId write fId;
    property Deck: TLocationCardsDeck read GetDeck;
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
  gInvestigators: TInvDeck;
  Monsters: TMonsterArray;//array [1..MONSTER_MAX] of TMonster;
  Arkham_Streets: array [1..NUMBER_OF_STREETS] of TStreet;
  Common_Items_Count: integer = 0;
  Unique_Items_Count: integer = 0;
  Spells_Count: integer = 0;
  Skills_Count: integer = 0;
  Investigators_Count: integer = 0;
  //Downtown_Count: integer = 0;
  Locations_Count: integer = 0;
  Cards_Count: integer = 0;
  players: array [1..8] of TPlayer;
  gPlayer, gCurrentPlayer: TPlayer;
  player_count: integer;
  path_to_exe: string;
  //monCount: integer;
  head_of_list: PLLData;
  procedure Load_Cards(Card_Type: integer);
  procedure Encounter(player: TPlayer; card: TLocationCard);
  function GetFirstPlayer: integer; // Получение номера игрока с жетоном первого игрока
  function GetLokIDByName(lok_name: string): integer; // Получение ID локации по названию
  function GetStreetIDByName(street_name: string): integer;
  function GetStreetIndxByLokID(id: integer): integer; // Searches the array for location that matches the id param
  function GetStreetNameByID(id: integer): string;
  function hon(num: integer): integer; // hundredth of number
  function ton(num: integer): integer; // thousandth of number
  //function AdditionalChecks(player: TPlayer; stat: integer): boolean;
  //procedure XML2Tree(head: PMyNode;{tree   : TTreeView;} XMLDoc : TXMLDocument; file_name: string);
  function ProcessCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): boolean;
  function ProcessMultiCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): integer;
  procedure ProcessAction(action: integer; action_value: integer; suxxess: string = '0');
  //procedure Read_Mem(var_addr: Pointer);
  procedure SplitData(delimiter: Char; str: string; var output_data: TStringList);
  procedure ProcessNode(Node : PLLData; add_data: integer = 0);
  function LokIdToName(lok_id: integer): string;

implementation

uses uChsLok, Math, uInvChsForm, uTradeForm, uUseForm;

{$R *.dfm}

constructor TStreet.Create(street_id: integer);
var
  n: integer;
begin
  //for i := 1 to NUMBER_OF_STREETS do
  begin
      fId := street_id;
      for n := 1 to 3 do
      begin
        fLok[n].lok_id := fId + 100 * n;
        fLok[n].clues := 0;
        fLok[n].gate := 0;
        fLok[n].monsters[1] := 0;
        fLok[n].monsters[2] := 0;
        fLok[n].monsters[3] := 0;
        fLok[n].monsters[4] := 0;
        fLok[n].monsters[5] := 0;
        fLok[n].lok_mon_count := 0;
    end;
    fDeck := TLocationCardsDeck.Create;

  end;
end;

// Загрузка данных в карты из файла
procedure Load_Cards(card_type: integer);
var
  i: integer;
begin
  case card_type of
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
      Arkham_Streets[1].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Northside\');
      Arkham_Streets[2].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Downtown\');
      Arkham_Streets[3].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Easttown\');
      Arkham_Streets[4].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Rivertown\');
      Arkham_Streets[5].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Merchant District\');
      Arkham_Streets[6].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\French Hill\');
      Arkham_Streets[7].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Miskatonic University\');
      Arkham_Streets[8].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Southside\');
      Arkham_Streets[9].fDeck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Uptown\');
      //Arkham_Streets[5].mDeck.Shuffle;

    end; // CT_ENCOUNTER

    CT_INVESTIGATOR: begin
      Investigators_Count := gInvestigators.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\Investigators\\');
    end; // CT_INVESTIGATOR

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
begin
  players[1].bFirstPlayer := True;
  gPlayer := players[1];
  gCurrentPlayer := players[GetFirstPlayer];
  gCurrentPlayer.Stamina := 5; // Give 5 stamina
  gCurrentPlayer.Sanity := 5; // Give 5 sanity
  gCurrentPlayer.Clues := 10; // Give 10 clues
  gCurrentPlayer.Money := 10; // Give 10$
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

  // Загрузка карт investigators
  Load_Cards(CT_INVESTIGATOR);

  //ShowMessage(Arkham_Streets[4].Deck.cards[1, 1].crd_head.mnChild[0].data);

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
  for i := 1 to player_count do
  begin
    // Освобождение ресурсов игрока
    players[i].Free;
  end;

  Common_Items_Deck.Free;
  Unique_Items_Deck.Free;
  Spells_Deck.Free;
  Skills_Deck.Free;
  gInvestigators.Free;

  for i := 1 to NUMBER_OF_STREETS do
  begin
    Arkham_Streets[i].Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i, n: integer;
  PlStats: array [1..6] of integer;
begin
  PlStats[1] := 2; // Speed
  PlStats[2] := 2; // Sneak
  PlStats[3] := 2; // Fight
  PlStats[4] := 2; // Will
  PlStats[5] := 2; // Lore
  PlStats[6] := 2; // Luck

  path_to_exe := ExtractFilePath(Application.ExeName);
  Common_Items_Deck:= TItemCardDeck.Create(CT_COMMON_ITEM);
  Unique_Items_Deck:= TItemCardDeck.Create(CT_UNIQUE_ITEM);
  Spells_Deck:= TItemCardDeck.Create(CT_SPELL);
  Skills_Deck:= TItemCardDeck.Create(CT_SKILL);
  gInvestigators := TInvDeck.Create(CT_INVESTIGATOR);

  for i := 1 to NUMBER_OF_STREETS do
    Arkham_Streets[i] := TStreet.Create(StrToInt(aNeighborhoodsNames[i, 1]));

  for i := 1 to NUMBER_OF_LOCATIONS do
  begin
    cbLocation.Items.Add(aLocationsNames[i, 2]);
  end;

  gCurrentPhase := 2;

  player_count := StrToInt(LabeledEdit1.Text);

  for i := 1 to player_count do
  begin
    // Загрузка объекта игрока
    players[i] := TPlayer.Create(PlStats, False);
    //
  end;

  btnInitClick(Sender);
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
  if 1=1{gCurrentPhase = PH_MOVE} then
  begin
    gCurrentPlayer.MoveToLocation(GetLokIDByName(cbLocation.Text));
    if Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location).clues > 0 then
    begin
      gCurrentPlayer.Clues := gCurrentPlayer.Clues + 1; // Сбор улик :)
      ShowMessage('Игрок нашел улики! Аааа-а-аа-аа-ааа супер круто. *Игрок бегает по-кругу в порывах радости.*');
    end;
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
  Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.Shuffle;
end;

// Проверка выполнилось ли условие на карте
function ProcessCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): boolean;
var
  skill_test: integer;
begin
  ProcessCondition := False;
  case cond of
    1: begin // Если True
      ProcessCondition := True;
    end;
    2: begin // Проверка скила
      frmMain.lbLog.Items.Add('Проверяется навык ' + IntToStr(prm) + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
      skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n); // Choise - номер скилла
      { TODO -oRonar : Choise is in dependence with structure of construction
        of program. In another words if indices have been changed, program
        will be broken }
      frmMain.lbLog.Items.Add('Проверка навыка ' + IntToStr(prm) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
      if (skill_test >= suxxess) then
        ProcessCondition := True
      else
      begin
        ProcessCondition := False;
      end;
    end;
    3: begin // Проверка наличия
      frmMain.lbLog.Items.Add('Проверка наличия чего-либо у игрока');
      if gPlayer.CheckAvailability(prm, N) then //
        ProcessCondition := True
      else
      begin
        ProcessCondition := False;
        frmMain.lbLog.Items.Add('Не хватат!');
      end;

    end; // case 3
    4: begin // Проверка наличия карты в колоде
      case (prm div 1000) of // Extract 1st digit
        1: begin // Common item
          if Common_Items_Deck.CheckAvailability(prm) then // Временно карты простых вещей
            ProcessCondition := True
          else
            ProcessCondition := False;
        end;
      end;
      //ProcessCondition := True;
      frmMain.lbLog.Items.Add('Проверка наличия карты в колоде');
    end; // case 4
    5: begin // Отдать что-либо
      if MessageDlg('Отдать ' + things[prm] + IntToStr(N) + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        ProcessCondition := True
      else
        ProcessCondition := False;
    end; // case 5
  {7: begin // Spec. card
    if MessageDlg('Confirm?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      frmMain.lbLog.Items.Add('Проверяется навык ' + IntToStr(Choise - 1) + '(=' + IntToStr(gCurrentPlayer.Stats[Choise - 1]) + ')..');
      skill_test := gPlayer.RollADice(gCurrentPlayer.Stats[Choise - 1] - N); // Choise - номер скилла
      frmMain.lbLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
      if (skill_test >= min) then
        ProcessCondition := True
      else
        ProcessCondition := False;
    end;
  end;}
  end;
end;

function ProcessMultiCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): integer;
var
  skill_test: integer;
begin
  ProcessMultiCondition := 0;
  // Проверка скила
  frmMain.lbLog.Items.Add('Проверяется навык ' + IntToStr(prm) + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
  skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n); // prm - order num of skill (1 - speed, ...)
  frmMain.lbLog.Items.Add('Проверка навыка ' + IntToStr(prm) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
  ProcessMultiCondition := skill_test;
end;

function Choise2(act1: string; act2: string): integer;
begin
  ChoiseForm.Choise2(act1, act2);
  ChoiseForm.ShowModal;
  if ChoiseForm.RadioButton1.Checked then
    Choise2 := 1
  else
    if ChoiseForm.RadioButton2.Checked then
      Choise2 := 2;
end;

function Choise3(act1: string; act2: string; act3: string): integer;
begin
  ChoiseForm.Choise3(act1, act2, act3);
  ChoiseForm.ShowModal;
  if ChoiseForm.RadioButton1.Checked then
    Choise3 := 1
  else
    if ChoiseForm.RadioButton2.Checked then
      Choise3 := 2
    else
      Choise3 := 3;
end;

function Choise4(act1: string; act2: string; act3: string; act4: string): integer;
begin
  ChoiseForm.Choise4(act1, act2, act3, act4);
  ChoiseForm.ShowModal;
  if ChoiseForm.RadioButton1.Checked then
    Choise4 := 1
  else
    if ChoiseForm.RadioButton2.Checked then
      Choise4 := 2
    else
      if ChoiseForm.RadioButton3.Checked then
        Choise4 := 3
      else
        Choise4 := 4;
end;

// Выполнение действия согласно карте
procedure ProcessAction(action: integer; action_value: integer; suxxess: string = '0');
var
  i: integer;
begin
  case action of
    1: begin
      if action_value = 88 then
      begin
        Randomize;
        action_value := random(6)+1;
      end;
      if action_value = 882 then
      begin
        Randomize;
        action_value := random(6)+1 + random(6)+1;
      end;
      gPlayer.Money := gPlayer.Money + action_value;
      frmMain.lbLog.Items.Add('Игрок получил деньги: ' + IntToStr(action_value) + '.');
    end;
    2: begin
      if action_value = 88 then
      begin
        Randomize;
        action_value := random(6)+1;
      end;
      if action_value = 882 then
      begin
        Randomize;
        action_value := random(6)+1 + random(6)+1;
      end;
      gPlayer.Money := gPlayer.Money - action_value;
      frmMain.lbLog.Items.Add('Игрок потерял деньги: ' + IntToStr(action_value) + '.');
    end;
    3: begin // Take stamina
    if action_value = 88 then
      begin
        Randomize;
        action_value := random(6)+1;
      end;
      if action_value = 882 then
      begin
        Randomize;
        action_value := random(6)+1 + random(6)+1;
      end;
      gPlayer.Stamina := gPlayer.Stamina + action_value;
      frmMain.lbLog.Items.Add('Игрок получил тело: ' + IntToStr(action_value) + '.');
    end;
    4: begin // Take sanity
    if action_value = 88 then
      begin
        Randomize;
        action_value := random(6)+1;
      end;
      if action_value = 882 then
      begin
        Randomize;
        action_value := random(6)+1 + random(6)+1;
      end;
      gPlayer.Stamina := gPlayer.Sanity + action_value;
      frmMain.lbLog.Items.Add('Игрок получил разум: ' + IntToStr(action_value) + '.');
    end;
    5: begin // Lose stamina
    if action_value = 88 then
      begin
        Randomize;
        action_value := random(6)+1;
      end;
      if action_value = 882 then
      begin
        Randomize;
        action_value := random(6)+1 + random(6)+1;
      end;
      gCurrentPlayer.Stamina := gCurrentPlayer.Stamina - action_value;
      frmMain.lbLog.Items.Add('Игрок потерял тело: ' + IntToStr(action_value) + '.');
    end; // case 5
    6: begin // Lose sanity
    if action_value = 88 then
      begin
        Randomize;
        action_value := random(6)+1;
      end;
      if action_value = 882 then
      begin
        Randomize;
        action_value := random(6)+1 + random(6)+1;
      end;
      gCurrentPlayer.Sanity := gCurrentPlayer.Sanity - action_value;
      frmMain.lbLog.Items.Add('Игрок потерял разум: ' + IntToStr(action_value) + '.');
    end; // case 6
    7: begin // Take clues
      if action_value = 88 then
      begin
        Randomize;
        action_value := random(6)+1;
      end;
      if action_value = 882 then
      begin
        Randomize;
        action_value := random(6)+1 + random(6)+1;
      end;
      gCurrentPlayer.Clues := gCurrentPlayer.Clues + action_value;
      frmMain.lbLog.Items.Add('Игрок получил улику(и): ' + IntToStr(action_value) + '.');
    end; // case 7
    8: begin // Lose clues
      gCurrentPlayer.Clues := gCurrentPlayer.Clues - action_value;
      frmMain.lbLog.Items.Add('Игрок потерял улику(и): ' + IntToStr(action_value) + '.');
    end; // case 8
    9: begin // Draw common item
      if action_value > 1000 then // id of card is defined
        gCurrentPlayer.AddItem(action_value)
      else
      begin
        for i := 1 to action_value do // Draw 'action_value' number of cards
          gCurrentPlayer.AddItem(Common_Items_Deck.DrawCard);
      end;
      frmMain.lbLog.Items.Add('Игрок вытянул карту простого предмета: ' + IntToStr(action_value));
    end; // case 9
    10: begin // Draw unique item
      if action_value > 1000 then // id of card is defined
        gCurrentPlayer.AddItem(action_value)
      else
      begin
        for i := 1 to action_value do // Draw 'action_value' number of cards
          gCurrentPlayer.AddItem(Unique_Items_Deck.DrawCard);
      end;
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
      for i := 1 to ALLIES_MAX do
        if StrToInt(Allies[i, 1]) = action_value then
          frmMain.lbLog.Items.Add('Игрок вытянул карту союзника: ' + Allies[i, 2] + '.');
    end; // case 13
    15: begin // Drop item of player's choise
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lbLog.Items.Add('Игрок потерял предмет (на выбор).');
    end; // case 15
    16: begin // Drop weapon of player's choise or amt.
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lbLog.Items.Add('Игрок потерял оружие ' + IntToStr(action_value));
    end; // case 16
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
      gCurrentPlayer.MoveToLocation(3200);
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
    25: begin // Draw another card for encounter
      frmMain.lbLog.Items.Add('Игрок тянет другую карту контакта для локации');
    end; // case 25
    26: begin // Draw common items, buy for 1 above of it's price, any or all
      frmMain.lbLog.Items.Add('Encounter');
    end; // case 26
    30: begin // Move to lok/street (ID or 0 - to street, -1 - to any lok/street)
      if action_value = 0 then
      begin
        gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
        frmMain.lbLog.Items.Add('Игрок вышел на улицу');
      end
      else
        if action_value = -1 then
        begin
          frmChsLok.ShowModal;
          gCurrentPlayer.Location := StrToInt(frmChsLok.edtLok.text);
          frmMain.lbLog.Items.Add('Игрок перешел на локацию: ' + LokIdToName(StrToInt(frmChsLok.edtLok.text)));
        end
        else
        begin
          gCurrentPlayer.Location := action_value;
          frmMain.lbLog.Items.Add('Игрок перешел на локацию: ' + LokIdToName(action_value));
        end;

      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;

    end; // case 30
    32: begin // Encounter
      //TODO: top card in deck, not 7
      frmMain.lbLog.Items.Add('Игрок вступает в контакт');
      Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.cards[7, hon(gCurrentPlayer.Location)]);
    end; // case 32
    34: begin //
    
    end; // case 34
    35: begin // Sucked into gate
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lbLog.Items.Add('Игрока затянуло во врата.');
    end; // case 35
    36: begin // Monster apeeared
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lbLog.Items.Add('Появился монстр.');
    end; // case 36
    37: begin // Gate appeared
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lbLog.Items.Add('Появились врата.');
    end; // case 37
  38: begin // Pass turn
    //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
    frmMain.lbLog.Items.Add('Игрок пропускает ход.');
  end; // case 38
    39: begin // Lost in time and space
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lbLog.Items.Add('Игрок потерян во сремени и пространстве.');
    end; // case 39
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
    42: // Игрок тянет 1 простую вещь бесплатно из n
      begin
        frmMain.lbLog.Items.Add('Игрок тянет 1 простую вещь бесплатно из ' + IntToStr(action_value));
      end; // case 42
    43: begin
      frmMain.lbLog.Items.Add('Игрок берет верхнюю карту из любой колоды локаций. Она достанется тому сыщику, кто первый получит контакт в этой локации :)');
    end; // case 43
    51: // Take common weapon
      begin
        frmMain.lbLog.Items.Add('Игрок берет простое оружие бесплатно:' + IntToStr(action_value));
      end; // case 51
    53: // Take common tome
      begin
        frmMain.lbLog.Items.Add('Игрок берет первую попавшеюся простую книгу:' + IntToStr(action_value));
      end; // case 51

    28: // Move to location, enc
      if action_value = 0 then
      begin
        frmChsLok.ShowModal;

      end
      else
        frmMain.lbLog.Items.Add('Насин хеппенд :).'); //gPlayer.Location := StrToInt(IntToStr(Round(action_value / 3 + 0.4)) + IntToStr(action_value - (Round(action_value / 3 + 0.4) - 1) * 3));
  end; // case
end;


// Разрешить контакт
procedure Encounter(player: TPlayer; card: TLocationCard);
var
  i: integer;
  c_node: PLLData;
  crd_name: string;

  function GetLokNameByID(id: integer): string;
  var
    k, card_id: Integer;
  begin
    card_id := ton(id)*1000;
    for k := 1 to 9 do
    begin
      if StrToInt(aNeighborhoodsNames[k,1]) = card_id then
      begin
        Result := aNeighborhoodsNames[k,2];
        break;
      end;
    end;
  end;
begin
  // TODO: таблицу с картами | N | ID_Card |, чтобы находить карты для условия
  // и добавлять новые

  // Получили данные карты
  if card.crd_head <> nil then
  begin
    crd_name := path_to_exe+'\CardsData\Locations\' + GetLokNameByID(card.id) + '\' + IntToStr((ton(card.ID) * 1000) + StrToInt(IntToStr(card.ID)[4])) + '.jpg';
    frmMain.imgEncounter.Picture.LoadFromFile(crd_name);
    c_node := card.crd_head;

    for i := 0 to c_node.mnChildCount-1 do
      processnode(c_node.mnChild[i]);
  end
  else
    ShowMessage('Почему-то карта пустая :('+#10+#13+'Или вы не перешли на локацию.');
{  c_data := card.Data;
  if c_data = '' then
  begin
    MessageDlg('Не удалось загрузить карту.', mtError, [mbOK], 0);
    exit;
  end;

  frmMain.imgEncounter.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\CardsData\Locations\Downtown\' + IntToStr((ton(card.ID) * 1000) + StrToInt(IntToStr(card.ID)[4])) + '.jpg');

}
end;

procedure TfrmMain.bntEncounterClick(Sender: TObject);
var
  lok: TLocation;
  drawn_items: array [1..3] of integer;
begin
  //lok := GetLokByID(gCurrentPlayer.Location);
  if 1=1{gCurrentPhase = PH_ENCOUNTER} then
  begin
    case gCurrentPlayer.Location of
      4200: begin
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
          Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.cards[seCrdNum.Value, hon(gCurrentPlayer.Location)]);
      end; // 4300
      //else Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.DrawCard(hon(gCurrentPlayer.Location)));
      else Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.cards[seCrdNum.Value, hon(gCurrentPlayer.Location)]); {DrawCard(hon(gCurrentPlayer.Location)));}
    end;

    //Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.Shuffle;
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
    if ((aLocationsNames[i, 2] = lok_name) AND (StrToInt(aLocationsNames[i, 1]) > 1000)) then
    begin
      result := StrToInt(aLocationsNames[i, 1]);
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
    if ((aLocationsNames[i, 2] = street_name) AND (StrToInt(aLocationsNames[i, 1]) > 1000)) then
    begin
      result := StrToInt(aLocationsNames[i, 1]);
      break;
    end
    else
      result := 1100;
end;

function TStreet.GetDeck: TLocationCardsDeck;
begin
  result := fDeck;
end;

function TStreet.GetLokByID(id: integer): TLocation;
var
  i: integer;
  ln: integer;
begin
  ln := GetStreetIndxByLokID( ton(id) * 1000 );
  result := Arkham_Streets[ln].fLok[hon(id)];
end;

procedure TStreet.AddMonster(lok_id: integer; mob_id: integer);
begin
  fLok[hon(lok_id)].monsters[1] := mob_id;
end;

procedure TStreet.AddClue(lok_id: integer; n: integer);
begin
  fLok[hon(lok_id)].clues := fLok[hon(lok_id)].clues + n;
end;

procedure TfrmMain.btnChsInvClick(Sender: TObject);
var
  i: integer;
begin
  //frmInv.cbInvPlayer1.Items.Add(aInvestigators[]);
  frmInv.ShowModal;
  //gCurrentPlayer.AssignInvestigator(inv); // Investigator := inv;
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
    if Arkham_Streets[i].fId = st then
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
    if StrToInt(aNeighborhoodsNames[i, 1]) = id then
      GetStreetNameByID := aNeighborhoodsNames[i, 2];
end;


function hon(num: integer): integer; // hundredth of number
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
  gCurrentPlayer.AddItem(1582);
end;

procedure TfrmMain.btnMoveToExactLokClick(Sender: TObject);
begin
  //Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(StrToInt(edtLokID.Text))].deck.cards[StrToInt(edtLokID.Text)]);
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

procedure ProcessNode(Node : PLLData; add_data: integer);
var
  s: string;
  output_data: TStringList;
  b: boolean;
  i, j: integer;
  st, rolls, pl_choise: Integer; // skill_test
  tmp_str: string;
begin

  output_data := TStringList.Create;

  splitdata('|', Node.data, output_data);

  if output_data[1] = '0' then // Action
  begin
    frmMain.lbLog.Items.Add('Насин хеппенд :).');
  end;

  if output_data[1] = '3' then // Условие
  begin
    b := ProcessCondition(StrToInt(output_data[2]), StrToInt(output_data[3]), StrToInt(output_data[4]), StrToInt(output_data[5]));
    if b then
    begin
      //ProcessNode(Node.mnChild[0].mnChild[0]);
      for i := 0 to Node.mnChild[0].mnChildCount-1 do
      begin
        ProcessNode(Node.mnChild[0].mnChild[i]);
      end;
    end
    else
    begin
      //ProcessNode(Node.mnChild[1].mnChild[0]);
      for i := 0 to Node.mnChild[1].mnChildCount-1 do
      begin
        ProcessNode(Node.mnChild[1].mnChild[i]);
      end;
    end;

    //ProcessAction(StrToInt(output_data[1]), StrToInt(output_data[2]));
  end;

  if output_data[1] = '4' then // Action
  begin
    if output_data[3] = '77' then // Instead of certain amt, we use result of roll
      ProcessAction(StrToInt(output_data[2]), add_data)
    else
      ProcessAction(StrToInt(output_data[2]), StrToInt(output_data[3]));

  end;

  if output_data[1] = '2' then // OR
  begin
    if output_data[2] = '2' then
      pl_choise := Choise2(output_data[3], output_data[4])
    else
      if output_data[2] = '3' then
        pl_choise := Choise3(output_data[3], output_data[4], output_data[5])
      else
        if output_data[2] = '4' then
          pl_choise := Choise4(output_data[3], output_data[4], output_data[5], output_data[6]);

    if pl_choise = 1 then
    begin
      for i := 0 to Node.mnChild[0].mnChildCount-1 do
        ProcessNode(Node.mnChild[0].mnChild[i]);
    end
    else
      if pl_choise = 2 then
      begin
        for i := 0 to Node.mnChild[1].mnChildCount-1 do
          ProcessNode(Node.mnChild[1].mnChild[i]);
      end
      else
        if pl_choise = 3 then
        begin
          for i := 0 to Node.mnChild[2].mnChildCount-1 do
            ProcessNode(Node.mnChild[2].mnChild[i]);
        end
        else
          if pl_choise = 4 then
            for i := 0 to Node.mnChild[3].mnChildCount-1 do
              ProcessNode(Node.mnChild[3].mnChild[i]);

  end;

  if output_data[1] = '5' then // condition with various num of suxxess
  begin
    if output_data[2] = '1' then // just roll a dice
    begin
      randomize;
      rolls := 0;
      for i := 1 to StrToInt(output_data[4]) do // How many rolls
        rolls := rolls + random(6) + 1;
      for i := 0 to StrToInt(output_data[5])-1 do
      begin
        tmp_str := node.mnChild[i].data;

        if (tmp_str = 'one-three')and(rolls > 0)and(rolls <= 3) then
          for j := 0 to node.mnChild[i].mnChildCount-1 do
            ProcessNode(node.mnChild[i].mnChild[j], rolls);
        if (tmp_str = 'three-six')and(rolls > 3)and(rolls <= 6) then
          for j := 0 to node.mnChild[i].mnChildCount-1 do
            ProcessNode(node.mnChild[i].mnChild[j], rolls);
      end;
      exit;
    end;

    st := ProcessMultiCondition(StrToInt(output_data[2]), StrToInt(output_data[3]), StrToInt(output_data[4]), StrToInt(output_data[5]));
    for i := 0 to StrToInt(output_data[5])-1 do
    begin
      //tmp_str := TStringList.Create;
      tmp_str := Node.mnChild[i].data;

      if st = 0 then
      begin
        if pos('zero', tmp_str) <> 0 then
          for j := 0 to Node.mnChild[i].mnChildCount-1 do
            ProcessNode(Node.mnChild[i].mnChild[j]);
      end;
      {else
        if (tmp_str = 'zero-one') then
          for j := 0 to Node.mnChild[i].mnChildCount-1 do
            ProcessNode(Node.mnChild[i].mnChild[j]);
      }
      if st = 1 then
      begin
         if pos('one', tmp_str) <> 0 then
        for j := 0 to Node.mnChild[i].mnChildCount-1 do
          ProcessNode(Node.mnChild[i].mnChild[j]);
      end;{
      else
        if (tmp_str = 'zero-one')and(st = 1) then
          for j := 0 to Node.mnChild[i].mnChildCount-1 do
            ProcessNode(Node.mnChild[i].mnChild[j]);
      }
      if st = 2 then
      begin
        if pos('two', tmp_str) <> 0 then
          for j := 0 to Node.mnChild[i].mnChildCount-1 do
            ProcessNode(Node.mnChild[i].mnChild[j]);
      end;{
      else
        if (tmp_str = 'twoplus')and(st >= 2) then
          for j := 0 to Node.mnChild[i].mnChildCount-1 do
            ProcessNode(Node.mnChild[i].mnChild[j]);
      }
      if (st = 3) then
      begin
        if pos('twoplus', tmp_str) <> 0 then
            for j := 0 to Node.mnChild[i].mnChildCount-1 do
              ProcessNode(Node.mnChild[i].mnChild[j])
          else
            if pos('three', tmp_str) <> 0 then
              for j := 0 to Node.mnChild[i].mnChildCount-1 do
                ProcessNode(Node.mnChild[i].mnChild[j]);
      end;

      if (st > 3) then
      begin
        if pos('twoplus', tmp_str) <> 0 then
            for j := 0 to Node.mnChild[i].mnChildCount-1 do
              ProcessNode(Node.mnChild[i].mnChild[j])
          else
            if pos('threeplus', tmp_str) <> 0 then
              for j := 0 to Node.mnChild[i].mnChildCount-1 do
                ProcessNode(Node.mnChild[i].mnChild[j]);
      end;
      {else
        if (tmp_str = 'threeplus')and(st >= 3) then
          for j := 0 to Node.mnChild[i].mnChildCount-1 do
            ProcessNode(Node.mnChild[i].mnChild[j]);
      }
    end;
  end;
    //ProcessAction(StrToInt(output_data[1]), StrToInt(output_data[2]));


  output_data.Free;
  {  if Node = nil then Exit;
    with Node do
    begin
      ShowMessage(NodeName);
      tn := tree.Items.AddChild(tn, Attributes['type']);
      ShowMessage(Attributes['type']);
      if (Attributes['type'] = 't') and (not pc) then
        Exit
      else
        t := true;

      if (Attributes['type'] = 'f') and pc then
        Exit
      else
        f := true;

      if HasAttribute('data') then
      begin
        //s := Attributes['type'];
        tn.Text := tn.Text + Attributes['data'];
        if Attributes['type'] = 'c' then
        begin
          pc := ProcessCondition(Attributes['data']);
        end;
        if (Attributes['type'] = 'a') and ((not t and not f)
            or (pc and t) or (not pc and f)) then
        begin
          ProcessAction(Attributes['data']);
          f := false;
          t := false;
        end;


      end;
    end;



  cNode := Node.ChildNodes.First;
  while cNode <> nil do
  begin
    ProcessNode(cNode, tn);
    cNode := cNode.NextSibling;
  end;  }
end; (*ProcessNode*)

procedure TfrmMain.btn1Click(Sender: TObject);
var
  temp: TTreeView;
  tmp: PLLData;
begin
  head_of_list^.data := '1234';
  head_of_list^.mnChildCount := 0;

  //xml2tree(head_of_list, frmMain.xmldoc1, 'CardsData\Locations\Rivertown\4101');
end;

procedure SplitData(delimiter: Char; str: string; var output_data: TStringList);
var
  tmp: StrDataArray;
begin
  output_data.Clear;
  output_data.QuoteChar := '''';
  output_data.Delimiter := delimiter;
  output_data.DelimitedText := str;
end;

procedure TfrmMain.btn2Click(Sender: TObject);
begin
  lbl1.Caption := Format('%s', [head_of_list.mnChild[0].data]);
end;

procedure TfrmMain.edStatWillExit(Sender: TObject);
begin
  try
    gCurrentPlayer.Will := StrToInt(edStatWill.Text);
  except
    ShowMessage('No!');
    edStatWill.Text := '0';
  end;
end;

procedure TfrmMain.edStatLuckExit(Sender: TObject);
begin
  try
    gCurrentPlayer.Luck := StrToInt(edStatLuck.Text);
  except
    ShowMessage('No!');
    edStatLuck.Text := '0';
  end;

end;

procedure TfrmMain.edtPlaMoneyExit(Sender: TObject);
begin
  try
    gCurrentPlayer.Money := StrToInt(edtPlaMoney.Text);
  except
    ShowMessage('No!');
    edtPlaMoney.Text := '0';
  end;
end;

procedure TfrmMain.edStatLoreExit(Sender: TObject);
begin
  try
    gCurrentPlayer.Lore := StrToInt(edStatLore.Text);
  except
    ShowMessage('No!');
    edStatLore.Text := '0';
  end;
end;

procedure TfrmMain.btnLogClearClick(Sender: TObject);
begin
  frmMain.lbLog.Clear;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  OpenTrdFrm(Common_Items_Deck.card[Common_Items_Deck.DrawCard],
    Common_Items_Deck.card[Common_Items_Deck.DrawCard],
    Common_Items_Deck.card[Common_Items_Deck.DrawCard], 1, 3);
    frmTrade.Show;
end;

function LokIdToName(lok_id: integer): string;
var
  i: integer;
begin
  result := 'Not found';
  for i := 1 to NUMBER_OF_LOCATIONS do
  begin
    if aLocationsNames[i, 1] = IntToStr(lok_id) then
      result := aLocationsNames[i, 2];
  end;
end;

end.
