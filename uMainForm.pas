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
    bntEncounter: TButton;
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
    btn19: TButton;
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
    procedure bntEncounterClick(Sender: TObject);
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
    procedure btn19Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
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
  exposed_cards: array [1..MAX_PLAYER_ITEMS] of boolean;
  Common_Items_Count: integer = 0;
  Unique_Items_Count: integer = 0;
  Spells_Count: integer = 0;
  Skills_Count: integer = 0;
  Mythos_Cards_Count: integer = 0;
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
  head_of_list: PLLData;
  player_current_card: array [1..8] of integer; // For displaying cards on form
  selected_cards: array [1..MAX_PLAYER_ITEMS] of boolean;
  procedure GameInit;
  procedure Load_Cards(Card_Type: integer);
  procedure Encounter(player: TPlayer; card: TLocationCard);
  function GetFirstPlayer: integer; // Получение номера игрока с жетоном первого игрока

  //function AdditionalChecks(player: TPlayer; stat: integer): boolean;
  //procedure XML2Tree(head: PMyNode;{tree   : TTreeView;} XMLDoc : TXMLDocument; file_name: string);
  function ProcessCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): boolean;
  function ProcessMultiCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): integer;
  procedure ProcessAction(action: integer; action_value: integer; suxxess: string = '0');
  //procedure Read_Mem(var_addr: Pointer);
  procedure SplitData(delimiter: Char; str: string; var output_data: TStringList);
  procedure ProcessNode(Node : PLLData; add_data: integer = 0);
  function LokIdToName(lok_id: integer): string;
  function GetLokNameByID(id: integer): string;
  function GetCommonItemNameByID(id: integer): string;
  procedure ShowPlayerCards(pl: TPlayer; cur_cards: integer); // Show current player's card in low right corner
  procedure SelectCards(sel_cards: array of boolean; count: integer); // Draw edges on cards
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
  end;

  lblCurPlayer.Caption := IntToStr(GetFirstPlayer);
  gCurrentPlayer := players[GetFirstPlayer];
  current_player := GetFirstPlayer;

  frmMain.btn17Click(Sender);
  UpdStatus;
  //ShowPlayerCards(gCurrentPlayer, player_current_card[current_player]);


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
  Arkham_Streets[ton(gCurrentPlayer.Location)].AddMonster(gCurrentPlayer.Location, mob_id);
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
  // TODO: point to null
  if gCurrentPlayer.Location mod 1000 = 0 then // С улицы
    pl_lok.lok_id := 0
  else
    pl_lok := Arkham_Streets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location);
  if 1=1{gCurrentPhase = PH_MOVE} then
  begin
    gCurrentPlayer.MoveToLocation(pl_lok, GetLokIDByName(cbLocation.Text));
    pl_lok := Arkham_Streets[ton(gCurrentPlayer.Location)].GetLokByID(gCurrentPlayer.Location);
    //Showmessage(IntToStr(GetLokByID(gCurrentPlayer.Location).monsters[1]));
    for i := 1 to pl_lok.lok_mon_count do
      if pl_lok.monsters[1] > 0 then
      begin
        frmMonster.PrepareMonster(GetMonsterByID(Monsters, pl_lok.Monsters[1]), gCurrentPlayer);
        frmMonster.ShowModal;
      end;

    if pl_lok.clues > 0 then
    begin
      gCurrentPlayer.Clues := gCurrentPlayer.Clues + 1; // Сбор улик :)
      ShowMessage('Игрок нашел улики! Аааа-а-аа-аа-ааа супер круто. *Игрок бегает по-кругу в порывах радости.*');
    end;

    //gCurrent_phase := PH_ENCOUNTER;
  end
  else
    ShowMessage('Wrong phase.');

  UpdStatus;

  //gPlayer.Encounter(Locations_Deck);
end;

procedure TfrmMain.btnShuffleClick(Sender: TObject);
var
  i: integer;
begin
  //Arkham_Streets[ton(gCurrentPlayer.Location)].deck.Shuffle;

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
      frmMain.lstLog.Items.Add('Проверяется навык ' + IntToStr(prm) + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
      skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n, 1); // Choise - номер скилла
      { TODO -oRonar : Choise is in dependence with structure of construction
        of program. In another words if indices have been changed, program
        will be broken }
      frmMain.lstLog.Items.Add('Проверка навыка ' + IntToStr(prm) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
      if (skill_test >= suxxess) then
        ProcessCondition := True
      else
      begin
        ProcessCondition := False;
      end;
    end;
    3: begin // Проверка наличия
      frmMain.lstLog.Items.Add('Проверка наличия чего-либо у игрока');
      if gPlayer.CheckAvailability(prm, N) then //
        ProcessCondition := True
      else
      begin
        ProcessCondition := False;
        frmMain.lstLog.Items.Add('Не хватат!');
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
      frmMain.lstLog.Items.Add('Проверка наличия карты в колоде');
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
      frmMain.lstLog.Items.Add('Проверяется навык ' + IntToStr(Choise - 1) + '(=' + IntToStr(gCurrentPlayer.Stats[Choise - 1]) + ')..');
      skill_test := gPlayer.RollADice(gCurrentPlayer.Stats[Choise - 1] - N); // Choise - номер скилла
      frmMain.lstLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
      if (skill_test >= min) then
        ProcessCondition := True
      else
        ProcessCondition := False;
    end;
  end;}
  end;

  UpdStatus;
end;

function ProcessMultiCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): integer;
var
  skill_test: integer;
begin
  ProcessMultiCondition := 0;
  // Проверка скила
  frmMain.lstLog.Items.Add('Проверяется навык ' + IntToStr(prm) + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
  skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n, 1); // prm - order num of skill (1 - speed, ...)
  frmMain.lstLog.Items.Add('Проверка навыка ' + IntToStr(prm) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
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
  i, drawn_monster: integer;
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
      frmMain.lstLog.Items.Add('Игрок получил деньги: ' + IntToStr(action_value) + '.');
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
      if action_value > 99 then
      begin
        gPlayer.Money := 0;
        frmMain.lstLog.Items.Add('Игрок потерял все деньги.');

      end
      else
      begin
        gPlayer.Money := gPlayer.Money - action_value;
        frmMain.lstLog.Items.Add('Игрок потерял деньги: ' + IntToStr(action_value) + '.');
      end;
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
      frmMain.lstLog.Items.Add('Игрок получил тело: ' + IntToStr(action_value) + '.');
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
      frmMain.lstLog.Items.Add('Игрок получил разум: ' + IntToStr(action_value) + '.');
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
      frmMain.lstLog.Items.Add('Игрок потерял тело: ' + IntToStr(action_value) + '.');
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
      frmMain.lstLog.Items.Add('Игрок потерял разум: ' + IntToStr(action_value) + '.');
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
      frmMain.lstLog.Items.Add('Игрок получил улику(и): ' + IntToStr(action_value) + '.');
    end; // case 7
    8: begin // Lose clues
      gCurrentPlayer.Clues := gCurrentPlayer.Clues - action_value;
      frmMain.lstLog.Items.Add('Игрок потерял улику(и): ' + IntToStr(action_value) + '.');
    end; // case 8
    9: begin // Draw common item
      if action_value > 1000 then // id of card is defined
        gCurrentPlayer.AddItem(Common_Items_Deck, action_value)
      else
      begin
        for i := 1 to action_value do
          gCurrentPlayer.AddItem(Common_Items_Deck, Common_Items_Deck.DrawCard);
      end;
      frmMain.lstLog.Items.Add('Игрок вытянул карту простого предмета: ' + IntToStr(action_value));
    end; // case 9
    10: begin // Draw unique item
      if action_value > 1000 then // id of card is defined
        gCurrentPlayer.AddItem(Common_Items_Deck, action_value)
      else
      begin
        for i := 1 to action_value do // Draw 'action_value' number of cards
          //gCurrentPlayer.AddItem(Unique_Items_Deck.DrawCard);
          gCurrentPlayer.AddItem(Common_Items_Deck, Common_Items_Deck.DrawCard);
      end;
      frmMain.lstLog.Items.Add('Игрок вытянул карту уникального предмета.');
    end; // case 10
    11: begin // Draw spell
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lstLog.Items.Add('Игрок вытянул карту закла.');
    end; // case 11
    12: begin // Draw skill
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lstLog.Items.Add('Игрок берет карту навыка.');
    end; // case 12
    13: begin // Draw ally card
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      for i := 1 to ALLIES_MAX do
        if StrToInt(Allies[i, 1]) = action_value then
          frmMain.lstLog.Items.Add('Игрок вытянул карту союзника: ' + Allies[i, 2] + '.');
    end; // case 13
    15: begin // Drop item of player's choise
      PrepareCardsToDrop(gCurrentPlayer, action_value);
      frmDrop.ShowModal;
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lstLog.Items.Add('Игрок потерял предмет (на выбор).');
    end; // case 15
    16: begin // Drop weapon of player's choise or amt.
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lstLog.Items.Add('Игрок потерял оружие ' + IntToStr(action_value));
    end; // case 16
    18: begin // Drop spell
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lstLog.Items.Add('Игрок потерял закл.');
    end; // case 18
    19: begin // Drop skill
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      frmMain.lstLog.Items.Add('Игрок потерял навык.');
    end; // case 19
    20: begin // Move to street
      //gCurrentPlayer.Blessed := True;
      frmMain.lstLog.Items.Add('Игрок вышел на улицу (overlapping).');
    end; // case 20

    22: begin //

    end; // case 22
    25: begin // Busted
      //gCurrentPlayer.MoveToLocation(3200);
      gCurrentPlayer.Location := 3200;
      frmMain.lstLog.Items.Add('Игрок арестован.');
    end; // case 25
{    21: begin // Draw another card for encounter
      frmMain.lstLog.Items.Add('Игрок тянет другую карту контакта для локации');
    end; // case 25
}    26: begin // Draw common items, buy for 1 above of it's price, any or all
      frmMain.lstLog.Items.Add('Encounter');
    end; // case 26
    30: begin // Move to lok/street (ID or 0 - to street, -1 - to any lok/street)
      if action_value = 0 then
      begin
        gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
        frmMain.lstLog.Items.Add('Игрок вышел на улицу');
      end
      else
        if action_value = -1 then
        begin
          frmChsLok.ShowModal;
          gCurrentPlayer.Location := StrToInt(frmChsLok.edtLok.text);
          frmMain.lstLog.Items.Add('Игрок перешел на локацию: ' + LokIdToName(StrToInt(frmChsLok.edtLok.text)));
        end
        else
        begin
          gCurrentPlayer.Location := action_value;
          frmMain.lstLog.Items.Add('Игрок перешел на локацию: ' + LokIdToName(action_value));
        end;

      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;

    end; // case 30
    32: begin // Encounter
      //TODO: top card in deck, not 7
      frmMain.lstLog.Items.Add('Игрок вступает в контакт');
      Encounter(gCurrentPlayer, Arkham_Streets[ton(gCurrentPlayer.Location)].deck.cards[7, hon(gCurrentPlayer.Location)]);
    end; // case 32
    33: begin // Blessed
      gCurrentPlayer.Blessed := True;
      frmMain.lstLog.Items.Add('Игрок благословен.');
    end; // case 33
    34: begin //

    end; // case 34
    35: begin // Sucked into gate
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lstLog.Items.Add('Игрока затянуло во врата.');
    end; // case 35
    36: begin // Monster apeeared
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      drawn_monster := DrawMonsterCard(Monsters);
      Arkham_Streets[ton(gCurrentPlayer.Location)].AddMonster(gCurrentPlayer.Location, drawn_monster);

      frmMain.lstLog.Items.Add('Появился монстр: ' + IntToStr(drawn_monster));
    end; // case 36
    37: begin // Gate appeared
      Arkham_Streets[ton(gCurrentPlayer.Location)].AddGate(gCurrentPlayer.Location, gates[random(8)+1]);
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lstLog.Items.Add('Появились врата.');
    end; // case 37
    38: begin // Pass turn
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lstLog.Items.Add('Игрок пропускает ход.');
      gCurrentPlayer.Moves := 0;
    end; // case 38
    39: begin // Lost in time and space
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      frmMain.lstLog.Items.Add('Игрок потерян во сремени и пространстве.');
    end; // case 39

 { 41: begin // Check skill
    frmMain.lstLog.Items.Add('Проверяется навык ' + IntToStr(Choise - 1) + '(=' + IntToStr(gCurrentPlayer.Stats[Choise - 1]) + ' -' + IntToStr(N) + ')..');
    skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[Choise - 1] - N); // Choise - номер скилла
    frmMain.lstLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
    if (skill_test >= min) then
      Take_Action();
    else
    begin
     Take_Action();
    end;
  end; }// case 41
    40: // Игрок тянет 1 простую вещь бесплатно из n
      begin
        Trade(TR_TAKE_ITEMS, CT_COMMON_ITEM, action_value);
        frmMain.lstLog.Items.Add('Игрок тянет 1 простую вещь бесплатно из ' + IntToStr(action_value));
      end; // case 42
    42: // Игрок тянет 1 простую вещь бесплатно из n
      begin
        frmMain.lstLog.Items.Add('Игрок тянет 1 простую вещь бесплатно из ' + IntToStr(action_value));
      end; // case 42
    43: begin
      frmMain.lstLog.Items.Add('Игрок берет верхнюю карту из любой колоды локаций. Она достанется тому сыщику, кто первый получит контакт в этой локации :)');
    end; // case 43
    51: // Take common weapon
      begin
        frmMain.lstLog.Items.Add('Игрок берет простое оружие бесплатно: ' + IntToStr(action_value));
      end; // case 51
    53: // Take common tome
      begin
        frmMain.lstLog.Items.Add('Игрок берет первую попавшеюся простую книгу: ' + IntToStr(action_value));
      end; // case 51
      55: // Sell an item for 2x price
      begin
        card_to_load := CT_COMMON_ITEM;
        frmCard.ShowModal;
        frmMain.lstLog.Items.Add('Игрок может продать любую вещь в 2 раза дороже: ' + IntToStr(action_value));
      end; // case 51
      66: begin // Cursed
        gCurrentPlayer.Cursed := True;
        frmMain.lstLog.Items.Add('Игрок проклят.');
      end; // case 66

    28: // Move to location, enc
      if action_value = 0 then
      begin
        frmChsLok.ShowModal;

      end
      else
        frmMain.lstLog.Items.Add('Ничего не произошло.'); //gPlayer.Location := StrToInt(IntToStr(Round(action_value / 3 + 0.4)) + IntToStr(action_value - (Round(action_value / 3 + 0.4) - 1) * 3));
  end; // case

  UpdStatus;
end;


// Разрешить контакт
procedure Encounter(player: TPlayer; card: TLocationCard);
var
  i: integer;
  c_node: PLLData;
  crd_name: string;

 { function GetLokNameByID(id: integer): string;
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
  end;     }
begin
  // TODO: таблицу с картами | N | ID_Card |, чтобы находить карты для условия
  // и добавлять новые

  // Получили данные карты
  if card.crd_head <> nil then
  begin
    crd_name := path_to_exe+'CardsData\Locations\' + aNeighborhoodsNames[ton(card.id), 2] + '\' + IntToStr((ton(card.ID) * 1000) + StrToInt(IntToStr(card.ID)[4])) + '.jpg';
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
    if gCurrentPlayer.Location mod 1000 = 0 then
    begin
      ShowMessage('Для улицы нет контакта!');
      Exit;
    end;
    case gCurrentPlayer.Location of
      4200: begin
        if MessageDlg('Trade?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          Trade(TR_BUY_NOM_PRICE, CT_COMMON_ITEM, 3);
        end
        else
          Encounter(gCurrentPlayer, Arkham_Streets[ton(gCurrentPlayer.Location)].deck.cards[seCrdNum.Value, hon(gCurrentPlayer.Location)]);
      end; // 4300
      //else Encounter(gCurrentPlayer, Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.DrawCard(hon(gCurrentPlayer.Location)));
      else Encounter(gCurrentPlayer, Arkham_Streets[ton(gCurrentPlayer.Location)].deck.cards[seCrdNum.Value, hon(gCurrentPlayer.Location)]); {DrawCard(hon(gCurrentPlayer.Location)));}
    end;

    //Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.Shuffle;
  end
  else
    ShowMessage('Wrong phase!');
  UpdStatus;
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

function GetLokNameByID(id: integer): string;
var
  i: integer;
begin
  Result := 'Undefined';
  if id mod 1000 = 0 then // Streets.. right
  begin
    Result := aNeighborhoodsNames[ton(id), 2];
    Exit;
  end;
  
  for i := 1 to NUMBER_OF_LOCATIONS do
    if StrToInt(aLocationsNames[i, 1]) = id then
    begin
      Result := aLocationsNames[i, 2];
      break;
    end;
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
    frmMain.lstLog.Items.Add('Ничего не произошло.');
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

procedure TfrmMain.btnShowCardsClick(Sender: TObject);
var
  temp: TTreeView;
  tmp: PLLData;
begin
  ShowPlayerCards(gCurrentPlayer, player_current_card[current_player]);

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
  mythos_card_num: integer;
  drawn_monster: integer;
begin
 case gCurrentPhase of
    PH_UPKEEP: begin
      gCurrentPhase := PH_MOVE;
      lblCurPhase.Caption := aPhasesNames[gCurrentPhase];
    end;
    PH_MOVE: begin

    end;
    PH_ENCOUNTER: begin

      //Encounter(gCurrentPlayer, Downtown.Deck, Downtown.Deck.DrawCard);
    end;
    PH_OTHER_WORLDS_ENCOUNTER: begin
    end;
    PH_MYTHOS: begin
      randomize;
      mythos_card_num := random(Mythos_Cards_Count) + 2;
      // Open gate and spawn monster
      Arkham_Streets[ton(Mythos_Deck.card[mythos_card_num].fGateSpawn)].AddGate(Mythos_Deck.card[mythos_card_num].fGateSpawn, gates[random(8)+1]);
      frmMain.lstLog.Items.Add('Появились ворота: ' + LokIdToName(Mythos_Deck.card[mythos_card_num].fGateSpawn));
      drawn_monster := DrawMonsterCard(Monsters);
      Arkham_Streets[ton(Mythos_Deck.card[mythos_card_num].fGateSpawn)].AddMonster(Mythos_Deck.card[mythos_card_num].fGateSpawn, drawn_monster);
      frmMain.lstLog.Items.Add('Появился монстр: ' + IntToStr(drawn_monster));
      // Spawn clue
      Arkham_Streets[ton(Mythos_Deck.card[mythos_card_num].fClueSpawn)].AddClue(Mythos_Deck.card[mythos_card_num].fClueSpawn, 1);
      frmMain.lstLog.Items.Add('Улика появилась: ' + LokIdToName(Mythos_Deck.card[mythos_card_num].fClueSpawn));
      UpdStatus;
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
  PrepareCardsToDrop(gCurrentPlayer, 2);
  frmDrop.Show;
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

procedure TfrmMain.btn19Click(Sender: TObject);
begin
  gCurrentPhase := gCurrentPhase + 1;
  if gCurrentPhase > 5 then
    gCurrentPhase := 1;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
var
  i: integer;
begin

end;

end.
