unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls, uPlayer, uCardDeck, Choise,
  uCommon, uMonster, xmldom, XMLIntf, msxmldom, XMLDoc, uCardXML, Spin, uStreet;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    btnInit: TButton;
    btnPlaData: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbItems: TListBox;
    Label2: TLabel;
    cbLocation: TComboBox;
    Label11: TLabel;
    btnEncounter: TButton;
    lblLocIDCaption: TLabel;
    lblLocID: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
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
    edtPlaLoc: TEdit;
    btnMoveToLok: TButton;
    btnShuffle: TButton;
    Label20: TLabel;
    edtPlaClue: TEdit;
    Label27: TLabel;
    edtPlaMoney: TEdit;
    btnNextPers: TButton;
    btnChsInv: TButton;
    edtPlaInv: TEdit;
    Label6: TLabel;
    btnUseCard: TButton;
    btnAddClue: TButton;
    imgDR1: TImage;
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
    xmldoc1: TXMLDocument;
    seCrdNum: TSpinEdit;
    Label7: TLabel;
    btnLogClear: TButton;
    Button2: TButton;
    pgc1: TPageControl;
    ts1: TTabSheet;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn7: TButton;
    pnl1: TPanel;
    lbl4: TLabel;
    lblPlNum: TLabel;
    lblCurPhase: TLabel;
    lbl7: TLabel;
    img1: TImage;
    ts2: TTabSheet;
    grp1: TGroupBox;
    btn8: TButton;
    btn9: TButton;
    grp2: TGroupBox;
    btn10: TButton;
    btn11: TButton;
    grp3: TGroupBox;
    btn12: TButton;
    btn13: TButton;
    pnl2: TPanel;
    img2: TImage;
    lbl8: TLabel;
    lbl9: TLabel;
    lblStamina: TLabel;
    lblSanity: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lblStaminaValue: TLabel;
    lblSanityValue: TLabel;
    img3: TImage;
    pbStamina: TProgressBar;
    pbSanity: TProgressBar;
    grp4: TGroupBox;
    btnPrevCards: TButton;
    btnNextCards: TButton;
    btnProcess: TButton;
    pnl3: TPanel;
    lblSpeed: TLabel;
    lblSneak: TLabel;
    lblFight: TLabel;
    lblWill: TLabel;
    lblLore: TLabel;
    lblLuck: TLabel;
    lblSpeedValue: TLabel;
    lblSneakValue: TLabel;
    lblFightValue: TLabel;
    lblWillValue: TLabel;
    lblLoreValue: TLabel;
    lblLuckValue: TLabel;
    lblFocusValue: TLabel;
    lblFocus: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    btn17: TButton;
    btn18: TButton;
    btnContinue: TButton;
    pb3: TProgressBar;
    pb4: TProgressBar;
    pnl4: TPanel;
    pgc2: TPageControl;
    ts3: TTabSheet;
    lst1: TListBox;
    ts4: TTabSheet;
    ts5: TTabSheet;
    lst3: TListBox;
    pnl5: TPanel;
    edt1: TEdit;
    lstLog: TListBox;
    imgEncounter: TImage;
    btnShowCards: TButton;
    lbl1: TLabel;
    lblCurPlayer: TLabel;
    pnlCard1: TPanel;
    imgPlaCard1: TImage;
    pnlCard2: TPanel;
    imgPlaCard2: TImage;
    pnlCard3: TPanel;
    imgPlaCard3: TImage;
    btn1: TButton;
    lblPlaLoc: TLabel;
    lblPlaClue: TLabel;
    lblPlaMoney: TLabel;
    lblPlaInv: TLabel;
    lbl2: TLabel;
    btnTakeWeapon: TButton;
    btn2: TButton;
    edtMoves: TEdit;
    lblMoves: TLabel;
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
    procedure DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPlaStaminaChange(Sender: TObject);
    procedure btnMoveToLokClick(Sender: TObject);
    procedure btnShuffleClick(Sender: TObject);
    procedure btnChsInvClick(Sender: TObject);
    procedure btnAddClueClick(Sender: TObject);
    procedure edStatSpeedChange(Sender: TObject);
    procedure btnGiveItemClick(Sender: TObject);
    procedure btnMoveToExactLokClick(Sender: TObject);
    procedure edtPlaClueExit(Sender: TObject);
    procedure edStatFightExit(Sender: TObject);
    procedure btnShowCardsClick(Sender: TObject);
    procedure edStatWillExit(Sender: TObject);
    procedure edStatLuckExit(Sender: TObject);
    procedure edtPlaMoneyExit(Sender: TObject);
    procedure edStatLoreExit(Sender: TObject);
    procedure btnLogClearClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn17Click(Sender: TObject);
    procedure btnPrevCardsClick(Sender: TObject);
    procedure btnNextCardsClick(Sender: TObject);
    procedure btnProcessClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgPlaCard1Click(Sender: TObject);
    procedure imgPlaCard2Click(Sender: TObject);
    procedure imgPlaCard3Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnTakeWeaponClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtMovesExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  gCurrentPhase: integer;
  Common_Items_Deck: TCommonItemCardDeck;
  //Unique_Items_Deck: TItemCardDeck;
  //Spells_Deck: TItemCardDeck;
  //Skills_Deck: TItemCardDeck;
  Mythos_Deck: TMythosDeck;
  gInvestigators: TInvDeck;
  Monsters: TMonsterArray;//array [1..MONSTER_MAX] of TMonster;
  Arkham_Streets: array [1..NUMBER_OF_STREETS] of TStreet;
  Other_Worlds_Deck: TOtherWorldCardsDeck;
  exposed_cards: array [1..MAX_PLAYER_ITEMS] of boolean;
  Common_Items_Count: integer = 0;
  Unique_Items_Count: integer = 0;
  Spells_Count: integer = 0;
  Skills_Count: integer = 0;
  OW_Cards_Count: integer = 0;  Mythos_Cards_Count: integer = 0;
  Investigators_Count: integer = 0;
  //Downtown_Count: integer = 0;
  Locations_Count: integer = 0;
  Cards_Count: integer = 0;
  players: array [1..8] of TPlayer;
  gPlayer, gCurrentPlayer: TPlayer;
  current_player: integer;
  gates: array [1..8] of TGate;
  gStatsMod: array [1..6] of integer;
  player_count: integer;
  path_to_exe: string;
  //monCount: integer;
  //head_of_list: PLLData;
  player_current_card: array [1..8] of integer; // For displaying cards on form
  selected_cards: array [1..MAX_PLAYER_ITEMS] of boolean;
  procedure GameInit;
  procedure Load_Cards(Card_Type: integer);
  procedure Encounter(card: TLocationCard);
  procedure OWEncounter(lok_id: integer; crd_num: integer);
  function GetFirstPlayer: integer; // Получение номера игрока с жетоном первого игрока
//  procedure SplitData(delimiter: Char; str: string; var output_data: TStringList);
  //procedure ProcessNode(Node : PLLData; add_data: integer = 0);

  function GetCommonItemNameByID(id: integer): string;
  procedure ShowPlayerCards(pl: TPlayer; cur_cards: integer); // Show current player's card in low right corner
  procedure SelectCards(sel_cards: array of boolean; count: integer); // Draw edges on cards
  function MatchColors(lok_id: Integer; col: integer): boolean; // Player's location in other world, return color match
  function FindGate(id: integer): integer;
  procedure UpdStatus;

implementation

uses uChsLok, Math,  uTradeForm, uUseForm, uInvChsForm, uMonsterForm,
  uCardForm, uDrop;

{$R *.dfm}

// Загрузка данных в карты из файла
procedure Load_Cards(card_type: integer);
var
  i: integer;
begin
  case card_type of
    CT_COMMON_ITEM: begin
      // Загружаем все карты, находящиеся в каталоге
      Common_Items_Count :=  Common_Items_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\CardsData\CommonItems\');
    end; // CT_COMMON_ITEM

    CT_UNIQUE_ITEM: begin
      // задание условий поиска и начало поиска
      //Unique_Items_Count := Unique_Items_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\UniqueItems\\');

    end; // CT_UNIQUE_ITEM

    CT_SPELL: begin
      // задание условий поиска и начало поиска
      //Spells_Count := Spells_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\Spells\\');

    end; // CT_UNIQUE_ITEM

    CT_SKILL: begin
      // задание условий поиска и начало поиска
//      Skills_Count := Skills_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\\CardsData\\Skills\\');
    end; // CT_UNIQUE_ITEM

    CT_ENCOUNTER: begin
      // Loading cards for diff. neighborhoods
      { TODO :  Implement auto load streets, not by explicit index }
      Arkham_Streets[1].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Northside\');
      Arkham_Streets[2].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Downtown\');
      Arkham_Streets[3].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Easttown\');
      Arkham_Streets[4].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Rivertown\');
      Arkham_Streets[5].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Merchant District\');
      Arkham_Streets[6].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\French Hill\');
      Arkham_Streets[7].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Miskatonic University\');
      Arkham_Streets[8].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Southside\');
      Arkham_Streets[9].Deck.FindCards(ExtractFilePath(Application.ExeName)+'CardsData\Locations\Uptown\');
      //Arkham_Streets[5].mDeck.Shuffle;

    end; // CT_ENCOUNTER

    CT_OW_ENCOUNTER: begin
       OW_Cards_Count := Other_Worlds_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\CardsData\OtherWorlds\');
    end; // CT_OW_ENCOUNTER

    CT_MYTHOS: begin
       Mythos_Cards_Count := Mythos_Deck.FindCards(ExtractFilePath(Application.ExeName)+'\CardsData\Mythos\');
    end; // CT_MYTHOS


    CT_INVESTIGATOR: begin
      Investigators_Count := gInvestigators.FindCards(ExtractFilePath(Application.ExeName)+'\CardsData\Investigators\');
    end; // CT_INVESTIGATOR


  end;

end;


procedure TfrmMain.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    gCurrentPhase := PH_UPKEEP;
  end;

  if RadioGroup1.ItemIndex = 1 then
  begin
    gCurrentPhase := PH_MOVE;
  end;

  if RadioGroup1.ItemIndex = 2 then
    gCurrentPhase := PH_ENCOUNTER;

  if RadioGroup1.ItemIndex = 3 then
  begin
    gCurrentPhase := PH_OTHER_WORLDS_ENCOUNTER;
  end;

  if RadioGroup1.ItemIndex = 4 then
  begin
    gCurrentPhase := PH_MYTHOS;
  end;
  lblCurPhase.Caption := aPhasesNames[gCurrentPhase];
end;

// Инициализация
// После инициализации, массив карт будет содержать
// в себе все карты определенного типа, начальные значения
// переменных и т.д.
procedure GameInit;
var
  i: integer;
begin
  players[1].bFirstPlayer := True;
  gPlayer := players[1];
  gCurrentPlayer := players[GetFirstPlayer];
  current_player := 1;
  frmMain.lblCurPlayer.Caption := IntToStr(current_player);
  gCurrentPhase := PH_UPKEEP;
  frmMain.lblCurPhase.Caption := aPhasesNames[gCurrentPhase];
 { gCurrentPlayer.Stamina := 5; // Give 5 stamina
  gCurrentPlayer.Sanity := 5; // Give 5 sanity
  gCurrentPlayer.Clues := 10; // Give 10 clues
  gCurrentPlayer.Money := 10; // Give 10$    }
  frmMain.lblCurPlayer.Caption := IntToStr(GetFirstPlayer);

  // Create gates
  gates[1].other_world := 141;
  gates[1].modif := -1;
  gates[1].dimension := GT_STAR;

  gates[2].other_world := 161;
  gates[2].modif := 0;
  gates[2].dimension := GT_TRIANGLE;

  gates[3].other_world := 111;
  gates[3].modif := -3;
  gates[3].dimension := GT_PLUS;

  gates[4].other_world := 121;
  gates[4].modif := -1;
  gates[4].dimension := GT_DIAMOND;

  gates[5].other_world := 151;
  gates[5].modif := -2;
  gates[5].dimension := GT_CIRCLE;

  gates[6].other_world := 181;
  gates[6].modif := 0;
  gates[6].dimension := GT_SQUARE;

  gates[7].other_world := 131;
  gates[7].modif := 1;
  gates[7].dimension := GT_SLASH;

  gates[8].other_world := 171;
  gates[8].modif := -2;
  gates[8].dimension := GT_HEXAGON;

  for i := 1 to 8 do
    player_current_card[i] := 1;

  for i := 1 to MAX_PLAYER_ITEMS do
    exposed_cards[i] := false;

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

  // Загрузка карт контактов иных миров
  Load_Cards(CT_OW_ENCOUNTER);  

  // Загрузка карт mythos
  Load_Cards(CT_MYTHOS);

  // Загрузка карт investigators
  Load_Cards(CT_INVESTIGATOR);

  //ShowMessage(Arkham_Streets[4].Deck.cards[1, 1].crd_head.mnChild[0].data);

  //monCount := 0;
  // Загрузка monsters
  LoadMonsterCards(Monsters, ExtractFilePath(Application.ExeName));
end;

procedure TfrmMain.btnInitClick(Sender: TObject);
begin
  GameInit;
end;

procedure TfrmMain.btnPlaDataClick(Sender: TObject);
var
  i: integer;
begin
  UpdStatus;
 { lbItems.Clear;
  for i := 1 to gPlayer.ItemsCount do
    lbItems.Items.Add(IntToStr(gCurrentPlayer.cards[i]));      }
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
    //current_player := fp + 1;
  end
  else
  begin
    players[1].bFirstPlayer := true;
    for i := 2 to player_count do
      players[i].bFirstPlayer := false;
    ShowMessage('Все игроки походили. След. фаза.');
    gCurrentPhase := gCurrentPhase + 1;
    if gCurrentPhase > 5 then
      gCurrentPhase := 1;
  end;

  lblCurPlayer.Caption := IntToStr(GetFirstPlayer);
  gCurrentPlayer := players[GetFirstPlayer];
  current_player := GetFirstPlayer;
  btnEncounter.Enabled := true;

  //frmMain.btn17Click(Sender);
  UpdStatus;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  mob_id: integer;
begin
  mob_id := DrawMonsterCard(monsters);
  ShowMessage(IntToStr(mob_id));
  Arkham_Streets[ton(gCurrentPlayer.Location)].AddMonster(gCurrentPlayer.Location, mob_id);
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
  //Unique_Items_Deck.Free;
  //Spells_Deck.Free;
  //Skills_Deck.Free;
  Mythos_Deck.Free;
  gInvestigators.Free;

  for i := 1 to NUMBER_OF_STREETS do
  begin
    Arkham_Streets[i].Free;
  end;
  //Application.Terminate;
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
  Common_Items_Deck:= TCommonItemCardDeck.Create(CT_COMMON_ITEM);
  Other_Worlds_Deck := TOtherWorldCardsDeck.Create();
  //Unique_Items_Deck:= TItemCardDeck.Create(CT_UNIQUE_ITEM);
  //Spells_Deck:= TItemCardDeck.Create(CT_SPELL);
  //Skills_Deck:= TItemCardDeck.Create(CT_SKILL);
  Mythos_Deck := TMythosDeck.Create(CT_MYTHOS);
  gInvestigators := TInvDeck.Create(CT_INVESTIGATOR);

  for i := 1 to NUMBER_OF_STREETS do
    Arkham_Streets[i] := TStreet.Create(StrToInt(aNeighborhoodsNames[i, 1]));

  for i := 1 to NUMBER_OF_LOCATIONS do
  begin
    cbLocation.Items.Add(aLocationsNames[i, 2]);
  end;

  gCurrentPhase := 2;

  player_count := 8;

  for i := 1 to player_count do
  begin
    // Загрузка объекта игрока
    players[i] := TPlayer.Create(PlStats, False);
    //
  end;

  for i := 1 to 20 do
    selected_cards[i] := false;

  GameInit;
end;



procedure TfrmMain.btnUseCardClick(Sender: TObject);
var
  i: integer;
begin
  frmUse.cbCard.Clear;
  for i := 1 to gCurrentPlayer.ItemsCount do
    frmUse.cbCard.Items.Add(IntToStr(gCurrentPlayer.Cards[i]));
  frmUse.ShowModal;
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
var
  i: integer;
  pl_lok: TLocation;
begin


  UpdStatus;

  //gPlayer.Encounter(Locations_Deck);
end;

procedure TfrmMain.btnShuffleClick(Sender: TObject);
var
  i: integer;
begin
  //Arkham_Streets[ton(gCurrentPlayer.Location)].deck.Shuffle;

end;

// Разрешить контакт
procedure Encounter(card: TLocationCard);
begin

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

procedure TfrmMain.btnChsInvClick(Sender: TObject);
var
  i: integer;
begin
  //frmInv.cbInvPlayer1.Items.Add(aInvestigators[]);
  frmInv.ShowModal;
  //gCurrentPlayer.AssignInvestigator(inv); // Investigator := inv;
  //gCurrentPlayer.ChangeSkills(1,1);
  //gCurrentPlayer.ChangeSkills(2,1);
  //gCurrentPlayer.ChangeSkills(3,1);
end;

procedure Fight;
begin

end;

// Get name of the item by id
function GetCommonItemNameByID(id: integer): string;
var
  i: integer;
begin
  result := 'Not defined';
  for i := 1 to NUMBER_OF_COMMON_CARDS do
    if StrToInt(aCommon_Items[i, 1]) = id then
    begin
      Result := aCommon_Items[i, 2];
      break;
    end;
end;

procedure TfrmMain.btnAddClueClick(Sender: TObject);
begin
  Arkham_Streets[ton(gCurrentPlayer.Location)].AddClue(gCurrentPlayer.Location, 1);
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
  //gCurrentPlayer.AddItem(1582);
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

procedure TfrmMain.btnShowCardsClick(Sender: TObject);
var
  temp: TTreeView;
  tmp: PLLData;
begin
  ShowPlayerCards(gCurrentPlayer, player_current_card[current_player]);
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
  frmMain.lstLog.Clear;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  Trade(TR_BUY_NOM_PRICE, CT_COMMON_ITEM, 3);
  {OpenTrdFrm(Common_Items_Deck.card[Common_Items_Deck.DrawCard],
    Common_Items_Deck.card[Common_Items_Deck.DrawCard],
    Common_Items_Deck.card[Common_Items_Deck.DrawCard], 1, 3);}
//    frmTrade.Show;
end;

procedure TfrmMain.btn17Click(Sender: TObject);
begin
  if gCurrentPhase <> PH_UPKEEP then
  begin
    ShowMessage('Wrong phase!');
    exit;
  end;
  gCurrentPlayer.ChangeSkills(TrackBar1.Position, TrackBar2.Position, TrackBar3.Position);
  UpdStatus;
end;

procedure ShowPlayerCards(pl: TPlayer; cur_cards: integer);
var
  i: integer;
  card_name: string;
begin
  frmMain.imgPlaCard1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\Spells\30.jpg');
  frmMain.imgPlaCard2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\Spells\30.jpg');
  frmMain.imgPlaCard3.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\Spells\30.jpg');

  for i := 1 to 3 do
  begin
    card_name := IntTostr(pl.Cards[i + ((cur_cards - 1) * 3)]);
    if card_name = '0' then exit;
    if card_name[1] = '1' then
      card_name := ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + card_name + '.jpg';

    if card_name[1] = '2' then
      card_name := ExtractFilePath(Application.ExeName) + 'CardsData\UniqueItems\' + card_name + '.jpg';

    if card_name[1] = '3' then
      card_name := ExtractFilePath(Application.ExeName) + 'CardsData\Spells\' + card_name + '.jpg';

    if card_name[1] = '4' then
      card_name := ExtractFilePath(Application.ExeName) + 'CardsData\Skills\' + card_name + '.jpg';

    if i = 1 then
      frmMain.imgPlaCard1.Picture.LoadFromFile(card_name);
    if i = 2 then
      frmMain.imgPlaCard2.Picture.LoadFromFile(card_name);
    if i = 3 then
      frmMain.imgPlaCard3.Picture.LoadFromFile(card_name);

  end;



end;

procedure SelectCards(sel_cards: array of boolean; count: integer);
var
  i: integer;
begin
  for i := 1 to 3 do
  begin
    if selected_cards[i + (3 * count)] then
      (frmMain.FindComponent('pnlCard'+IntToStr(i)) as TPanel).Color := clLime
    else
      (frmMain.FindComponent('pnlCard'+IntToStr(i)) as TPanel).Color := clGray;
    if exposed_cards[i + (3 * count)] then
      (frmMain.FindComponent('pnlCard'+IntToStr(i)) as TPanel).Color := clRed;
  end;
end;

// Update labels on the form
procedure UpdStatus;
begin
  with frmMain do
  begin
    lblStaminaValue.Caption := IntToStr(gCurrentPlayer.Stamina);
    lblSanityValue.Caption := IntToStr(gCurrentPlayer.Sanity);
    lblFocusValue.Caption := IntToStr(gCurrentPlayer.Focus);
    lblSpeedValue.Caption := IntToStr(gCurrentPlayer.Stats[1]);
    lblSneakValue.Caption := IntToStr(gCurrentPlayer.Stats[2]);
    lblFightValue.Caption := IntToStr(gCurrentPlayer.Stats[3]);
    lblWillValue.Caption := IntToStr(gCurrentPlayer.Stats[4]);
    lblLoreValue.Caption := IntToStr(gCurrentPlayer.Stats[5]);
    lblLuckValue.Caption := IntToStr(gCurrentPlayer.Stats[6]);
    lblPlaLoc.Caption := GetLokNameByID(gCurrentPlayer.Location);
    lblPlaClue.Caption := IntToStr(gCurrentPlayer.Clues);
    lblPlaMoney.Caption := IntToStr(gCurrentPlayer.Money);
    if gCurrentPlayer.investigator <> nil then
      lblPlaInv.Caption := gCurrentPlayer.investigator.name
    else
      lblPlaInv.Caption := 'Undefined';

    pbSanity.Position := gCurrentPlayer.Sanity;
    pbStamina.Position := gCurrentPlayer.Stamina;
    lblCurPhase.Caption := aPhasesNames[gCurrentPhase];
  end;
  // Отрисовка карт в наличии у игрока
  ShowPlayerCards(gCurrentPlayer, player_current_card[current_player]);
  SelectCards(selected_cards, player_current_card[current_player] - 1);
end;

procedure TfrmMain.btnPrevCardsClick(Sender: TObject);
begin
  if player_current_card[current_player] > 1 then
    player_current_card[current_player] := player_current_card[current_player] - 1;

  ShowPlayerCards(gCurrentPlayer, player_current_card[current_player]);
  SelectCards(selected_cards, player_current_card[current_player] - 1);

end;

procedure TfrmMain.btnNextCardsClick(Sender: TObject);
begin
  player_current_card[current_player] := player_current_card[current_player] + 1;
  ShowPlayerCards(gCurrentPlayer, player_current_card[current_player]);
  SelectCards(selected_cards, player_current_card[current_player] - 1);
end;

procedure TfrmMain.btnProcessClick(Sender: TObject);
var
  i: integer;
  mythos_card_num: integer;
  drawn_monster: integer;
  lok, pl_lok: TLocation;
  drawn_items: array [1..3] of integer;
  crd_num: integer;
begin
 case gCurrentPhase of
    PH_UPKEEP: begin
      //gCurrentPhase := PH_MOVE;
      if (not gCurrentPlayer.Delayed) and (gCurrentPlayer.Location > 1000) then
        gCurrentPlayer.Moves := gCurrentPlayer.Stats[1];

      if gCurrentPlayer.Delayed then
        gCurrentPlayer.Delayed := false;

      lblCurPhase.Caption := aPhasesNames[gCurrentPhase];
    end;
    PH_MOVE: begin
      // TODO: point to null
      if gCurrentPlayer.Location mod 1000 = 0 then // С улицы
        pl_lok.lok_id := 0
      else
        if gCurrentPlayer.Location > 1000 then
          pl_lok := Arkham_Streets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location);

      if gCurrentPlayer.Location > 1000 then // If in Arkham
      begin
        gCurrentPlayer.MoveToLocation(pl_lok, Arkham_Streets[ton(GetLokIDByName(cbLocation.Text))].Lok[hon(GetLokIDByName(cbLocation.Text))]);

        if gCurrentPlayer.Location > 1000 then // If not in other world anyway
        begin
          pl_lok := Arkham_Streets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location);
        //Showmessage(IntToStr(GetLokByID(gCurrentPlayer.Location).monsters[1]));

        for i := 1 to pl_lok.lok_mon_count do
          if pl_lok.monsters[1] > 0 then
          begin
            frmMonster.PrepareMonster(GetMonsterByID(Monsters, pl_lok.Monsters[1]), gCurrentPlayer);
            frmMonster.ShowModal;
          end;
        end;
      end
      else // in mythos
      begin
        if ((gCurrentPlayer.Location mod 100) mod 10) = 1 then // В начале иного мира
          gCurrentPlayer.Location := gCurrentPlayer.Location + 1
        else  // Игрок возвращается
        begin
          gCurrentPlayer.Location := FindGate(gCurrentPlayer.Location - 1);
          gCurrentPlayer.Explored; // Give marker
        end;
      end;

      if pl_lok.clues > 0 then
      begin
        gCurrentPlayer.GiveClue(1); // Сбор улик :)
        Arkham_Streets[ton(gCurrentPlayer.Location)].RemoveClue(gCurrentPlayer.Location, 1);
        ShowMessage('Игрок нашел улики! Аааа-а-аа-аа-ааа супер круто. *Игрок бегает по-кругу в порывах радости.*');
      end;
    end;
    PH_ENCOUNTER: begin
      if gCurrentPlayer.Location mod 1000 = 0 then
      begin
        MessageDlg('Для улицы нет контакта!', mtInformation, [mbOK], 0);
        Exit;
      end;

      Arkham_Streets[ton(gCurrentPlayer.Location)].Encounter(gCurrentPlayer.Location, seCrdNum.Value);
      //Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.Shuffle;
    end;
    //Encounter(gCurrentPlayer, Downtown.Deck, Downtown.Deck.DrawCard);
    PH_OTHER_WORLDS_ENCOUNTER: begin
      if gCurrentPlayer.Location < 1000 then
      begin
        crd_num := 1;
        while not MatchColors(gCurrentPlayer.Location, Other_Worlds_Deck.cards[crd_num].color) do
        begin
          crd_num := crd_num + 1;
          if crd_num > OW_Cards_Count then exit;
        end;
        owEncounter(gCurrentPlayer.Location, crd_num);
      end
      else
        btnContinueClick(Sender);
    end;
    PH_MYTHOS: begin
      randomize;
      mythos_card_num := random(Mythos_Cards_Count) + 2;
      // Open gate and spawn monster
      Arkham_Streets[ton(Mythos_Deck.card[mythos_card_num].fGateSpawn)].SpawnGate(Mythos_Deck.card[mythos_card_num].fGateSpawn, gates[random(8)+1]);
      frmMain.lstLog.Items.Add('Появились ворота: ' + GetLokNameByID(Mythos_Deck.card[mythos_card_num].fGateSpawn));
      drawn_monster := DrawMonsterCard(Monsters);
      Arkham_Streets[ton(Mythos_Deck.card[mythos_card_num].fGateSpawn)].AddMonster(Mythos_Deck.card[mythos_card_num].fGateSpawn, drawn_monster);
      frmMain.lstLog.Items.Add('Появился монстр: ' + IntToStr(drawn_monster));
      // Spawn clue
      Arkham_Streets[ton(Mythos_Deck.card[mythos_card_num].fClueSpawn)].AddClue(Mythos_Deck.card[mythos_card_num].fClueSpawn, 1);
      frmMain.lstLog.Items.Add('Улика появилась: ' + GetLokNameByID(Mythos_Deck.card[mythos_card_num].fClueSpawn));
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
  UpdStatus;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  frmInv.ShowModal;  
  //UpdStatus;
end;

procedure TfrmMain.imgPlaCard1Click(Sender: TObject);
begin
  selected_cards[1 + (3 * (player_current_card[current_player] - 1))] := not selected_cards[1 + (3 * (player_current_card[current_player] - 1))];
  SelectCards(selected_cards, player_current_card[current_player] - 1);
end;

procedure TfrmMain.imgPlaCard2Click(Sender: TObject);
begin
  selected_cards[2 + (3 * (player_current_card[current_player] - 1))] := not selected_cards[2 + (3 * (player_current_card[current_player] - 1))];
  SelectCards(selected_cards, player_current_card[current_player] - 1);
end;

procedure TfrmMain.imgPlaCard3Click(Sender: TObject);
begin
  if not exposed_cards[3 + (3 * (player_current_card[current_player] - 1))] then
    selected_cards[3 + (3 * (player_current_card[current_player] - 1))] := not selected_cards[3 + (3 * (player_current_card[current_player] - 1))];
  SelectCards(selected_cards, player_current_card[current_player] - 1);
end;

procedure TfrmMain.btn1Click(Sender: TObject);
begin

  Common_Items_Deck.AddCardToDeck(1);
  ShowMessage(IntToStr(gCurrentPlayer.CardBonus(ST_FIGHT)));
end;

procedure TfrmMain.btn2Click(Sender: TObject);
begin
  //frmMonster.PrepareMonster(GetMonsterByID(Monsters, Arkham_STreets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location).Monsters[1]), gCurrentPlayer);
  //frmMonster.ShowModal;
  //ShowMessage(IntToStr(p_addr));
//  PrepareCardsToDrop(gCurrentPlayer, 2);
//  frmDrop.Show;
  //players[2].Delayed := True;
  //owEncounter(151, 1);
  Arkham_Streets[ton(gCurrentPlayer.Location)].SpawnGate(gCurrentPlayer.Location, gates[5]);
end;

procedure TfrmMain.btnTakeWeaponClick(Sender: TObject);
var
  i: integer;
begin
  gCurrentPlayer.DropWeapon;
  for i := 1 to MAX_PLAYER_ITEMS do
  begin
    if selected_cards[i] then
    begin
      gCurrentPlayer.TakeWeapon(gCurrentPlayer.Cards[i]);
    end;
  end;
  ShowMessage('Бонус от оружия: ' + IntToStr(gCurrentPlayer.BonusWeapon));


end;

procedure TfrmMain.btnContinueClick(Sender: TObject);
var
  fp, i: integer;
begin
  fp := GetFirstPlayer;

  if (fp < player_count) then
  begin
    //fp := GetFirstPlayer;
    if players[fp + 1].Delayed then
    begin
      frmMain.lstLog.Items.Add('Игрок задержан. Пропуск хода.');
      players[fp].bFirstPlayer := False;
      players[fp + 1].bFirstPlayer := true;
      btnContinueClick(Sender);
      exit;
    end;
    players[fp].bFirstPlayer := False;
    players[fp + 1].bFirstPlayer := true;
    frmMain.lstLog.Items.Add('След. игрок.');
    //current_player := fp + 1;
  end
  else
  begin
    players[1].bFirstPlayer := true;
    for i := 2 to player_count do
      players[i].bFirstPlayer := false;
    frmMain.lstLog.Items.Add('Все игроки походили. След. фаза.');
    gCurrentPhase := gCurrentPhase + 1;
    if gCurrentPhase > 5 then
      gCurrentPhase := 1;
    if gCurrentPhase = 1 then
      btnProcessClick(Sender);
  end;

  lblCurPlayer.Caption := IntToStr(GetFirstPlayer);
  gCurrentPlayer := players[GetFirstPlayer];
  current_player := GetFirstPlayer;
  btnEncounter.Enabled := true;

  //frmMain.btn17Click(Sender);
  UpdStatus;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
var
  i: integer;
begin

end;

// Проверяет, подходит ли цвет карты
function MatchColors(lok_id: Integer; col: integer): boolean;
var
  ii, kk: integer;
begin
  Result := false;
  for ii := 1 to 8 do
  begin
    //ShowMessage(IntToStr(ii));
    if (aEncounterSymbols[ii, 1] = lok_id) and (aEncounterSymbols[ii, col + 1] = col) then
      Result := True;
  end;
end;

// id локации другого мира
function FindGate(id: integer): integer;
var
  i, j: integer;
begin
  for i := 1 to NUMBER_OF_STREETS do
    for j := 1 to 3 do
      if Arkham_Streets[i].Lok[j].gate.other_world = id then
      begin
        Result := Arkham_Streets[i].Lok[j].lok_id;
        exit;
      end;
end;

// Контакт в другом мире
procedure OWEncounter(lok_id: integer; crd_num: integer);
var
  //lok: TOWLocationCard;
  drawn_items: array [1..3] of integer;
  card: TOWLocationCard;
  i: integer;
  c_node: PLLData;
  crd_name: string;
begin
  //if lok_id mod 1000 = 0 then exit; // No encounters on streets

  //lok := fLok[hon(lok_id)];

  card := Other_Worlds_Deck.cards[crd_num];

  if card.crd_head <> nil then
  begin
    crd_name := path_to_exe + 'CardsData\OtherWorlds\' + IntToStr(card.ID) + '.jpg';
    frmMain.imgEncounter.Picture.LoadFromFile(crd_name);
    c_node := card.crd_head;

    ShowMessage(Copy(c_node.mnChild[0].data, 7, 3));

    if StrToInt(Copy(c_node.mnChild[0].data, 7, 3)) = lok_id then
    begin
      ShowMessage('Yay!');
      c_node := c_node.mnChild[0];
    end
    else
      if StrToInt(Copy(c_node.mnChild[1].data, 7, 3)) = lok_id then
      begin
        ShowMessage('Yay1!');
        c_node := c_node.mnChild[1];
      end
      else
      begin
        ShowMessage('Other!');
        c_node := c_node.mnChild[2];
      end;


    for i := 0 to c_node.mnChildCount-1 do
      ProcessNode(c_node.mnChild[i]);
  end
  else
    MessageDlg('Карта почему-то пустая :('+#10+#13+'Или вы не перешли на локацию.', mtError, [mbOK], 0);

end;

procedure TfrmMain.edtMovesExit(Sender: TObject);
begin
  try
    gCurrentPlayer.Moves := StrToInt(edtMoves.Text);
  except
    ShowMessage('No!');
    edtPlaMoney.Text := '0';
  end;
end;

end.
