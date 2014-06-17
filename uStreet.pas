unit uStreet;

interface
uses uCommon, uCardDeck, uCardXML, SysUtils, Dialogs, Controls;

type
  TLocation = record
    lok_id: integer; // id of location (2100, 2200, 2300, etc..)
    lok_name: string;
    clues: integer; // Улики на локации
    gate: TGate; // Врата открытые на локации
    HasGate: Boolean;
    monsters: array [1..5] of integer;
    lok_mon_count: integer;
  end;

  TStreet = class
  private
    fId: integer; // id of streets (1000, 2000, 3000, etc..)
    fLok: array [1..3] of TLocation;
    fDeck: TLocationCardsDeck;
    fAdjacent: array [1..6] of integer; // Прилегающие локации
    function GetDeck: TLocationCardsDeck;
  public
    constructor Create(street_id: integer);
    property StreetId: integer read fId write fId;
    property Deck: TLocationCardsDeck read GetDeck;
    function GetLokByID(id: integer): TLocation;
    procedure Encounter(lok_id: integer; crd_num: integer);
    procedure AddMonster(lok_id: integer; mob_id: integer);
    procedure AddClue(lok_id: integer; n: integer);
    procedure AddGate(lok_id: integer; gate: TGate);
    procedure TakeAwayMonster(lok_id: integer; mob_id: integer);
    procedure CloseGate(lok_id: integer);
  end;

  function GetLokIDByName(lok_name: string): integer; // Получение ID локации по названию
  function GetStreetIDByName(street_name: string): integer;
  //function GetStreetIndxByLokID(id: integer): integer; // Searches the array for location that matches the id param
  function GetStreetNameByID(id: integer): string;
  function GetLokNameByID(id: integer): string;  
//  function ProcessCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): boolean;
//  function ProcessMultiCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): integer;
//  procedure ProcessAction(action: integer; action_value: integer; suxxess: string = '0');


implementation

uses uTradeForm, uMainForm, Choise, uDrop, uChsLok, uMonster, uCardForm, Classes;

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
        fLok[n].gate.other_world := 0;
        fLok[n].gate.modif := 0;
        fLok[n].gate.dimension := 0;
        fLok[n].HasGate := false;
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

function TStreet.GetDeck: TLocationCardsDeck;
begin
  result := fDeck;
end;

function TStreet.GetLokByID(id: integer): TLocation;
var
  i: integer;
  ln: integer;
begin
  //ln := GetStreetIndxByLokID( ton(id) * 1000 );
  result := fLok[hon(id)];
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
      frmMain.lstLog.Items.Add('Проверяется навык ' + aStats[prm] + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
      skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n, 1); // Choise - номер скилла
      { TODO -oRonar : Choise is in dependence with structure of construction
        of program. In another words if indices have been changed, program
        will be broken }
      frmMain.lstLog.Items.Add('Проверка навыка ' + aStats[prm] + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
      if (skill_test >= suxxess) then
        ProcessCondition := True
      else
      begin
        ProcessCondition := False;
      end;
    end;
    3: begin // Проверка наличия
      frmMain.lstLog.Items.Add('Проверка наличия чего-либо у игрока');
      if gCurrentPlayer.CheckAvailability(prm, N) then //
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
  frmMain.lstLog.Items.Add('Проверяется навык ' + aStats[prm] + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
  skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n, 1); // prm - order num of skill (1 - speed, ...)
  frmMain.lstLog.Items.Add('Проверка навыка ' + aStats[prm] + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
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
          frmMain.lstLog.Items.Add('Игрок перешел на локацию: ' + GetLokNameByID(StrToInt(frmChsLok.edtLok.text)));
        end
        else
        begin
          gCurrentPlayer.Location := action_value;
          frmMain.lstLog.Items.Add('Игрок перешел на локацию: ' + GetLokNameByID(action_value));
        end;

      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;

    end; // case 30
    32: begin // Encounter
      //TODO: top card in deck, not 7
      frmMain.lstLog.Items.Add('Игрок вступает в контакт');
      //Encounter(gCurrentPlayer, Arkham_Streets[ton(gCurrentPlayer.Location)].deck.cards[7, hon(gCurrentPlayer.Location)]);
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
    42: // Игрок тянет 1 заклинание бесплатно из n
      begin
        frmMain.lstLog.Items.Add('Игрок тянет 1 заклинание бесплатно из ' + IntToStr(action_value));
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
end; // ProcessAction


procedure ProcessNode(Node : PLLData; add_data: integer = 0);
var
  s: string;
  output_data: TStringList;
  b: boolean;
  i, j: integer;
  st, rolls, pl_choise: Integer; // skill_test
  tmp_str: string;
  
  procedure SplitData(delimiter: Char; str: string; var output_data: TStringList);
  var
    tmp: StrDataArray;
  begin
    output_data.Clear;
    output_data.QuoteChar := '''';
    output_data.Delimiter := delimiter;
    output_data.DelimitedText := str;
  end;
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
end; (*ProcessNode*)

procedure TStreet.Encounter(lok_id: integer; crd_num: integer);
var
  lok: TLocation;
  drawn_items: array [1..3] of integer;
  card: TLocationCard;
  i: integer;
  c_node: PLLData;
  crd_name: string;
begin
  //if lok_id mod 1000 = 0 then exit; // No encounters on streets

  lok := fLok[hon(lok_id)];

  if lok.HasGate then
  begin
    if MessageDlg('Закрыть врата ведущие в иной мир?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if gCurrentPlayer.CloseGate then
        frmMain.lstLog.Items.Add('Игрок подзакрыл врата!')
      else
        frmMain.lstLog.Items.Add('Игрок не смог подзакрыть врата!')

    end;
    Exit;
  end;


  case lok_id of
    4200: begin
      if MessageDlg('Trade?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Trade(TR_BUY_NOM_PRICE, CT_COMMON_ITEM, 3);
        Exit;
      end
        // Получили данные карты
    end;
  end;

  // TODO: таблицу с картами | N | ID_Card |, чтобы находить карты для условия
  // и добавлять новые

  card := fDeck.cards[crd_num, hon(lok_id)];

  if card.crd_head <> nil then
  begin
    crd_name := path_to_exe + 'CardsData\Locations\' + aNeighborhoodsNames[ton(card.id), 2] + '\' + IntToStr((ton(card.ID) * 1000) + StrToInt(IntToStr(card.ID)[4])) + '.jpg';
    frmMain.imgEncounter.Picture.LoadFromFile(crd_name);
    c_node := card.crd_head;

    for i := 0 to c_node.mnChildCount-1 do
      processnode(c_node.mnChild[i]);
  end
  else
    MessageDlg('Карта почему-то пустая :('+#10+#13+'Или вы не перешли на локацию.', mtError, [mbOK], 0);


  //Arkham_Streets[GetStreetIndxByLokID(gCurrentPlayer.Location)].deck.Shuffle;
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

// Searches the array for location that matches the id param
{function GetStreetIndxByLokID(id: integer): integer;
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
end;        }

function GetStreetNameByID(id: integer): string;
var
  i: integer;
begin
  for i := 1 to NUMBER_OF_STREETS do
    if StrToInt(aNeighborhoodsNames[i, 1]) = id then
      GetStreetNameByID := aNeighborhoodsNames[i, 2];
end;

procedure TStreet.AddMonster(lok_id: integer; mob_id: integer);
begin
  fLok[hon(lok_id)].monsters[1] := mob_id;
  fLok[hon(lok_id)].lok_mon_count := fLok[hon(lok_id)].lok_mon_count + 1;
end;

procedure TStreet.AddClue(lok_id: integer; n: integer);
begin
  fLok[hon(lok_id)].clues := fLok[hon(lok_id)].clues + n;
end;

procedure TStreet.AddGate(lok_id: integer; gate: TGate);
begin
  fLok[hon(lok_id)] := GetLokByID(lok_id);
  fLok[hon(lok_id)].gate.other_world := gate.other_world;
  fLok[hon(lok_id)].gate.modif := gate.modif;
  fLok[hon(lok_id)].gate.dimension := gate.dimension;
  fLok[hon(lok_id)].HasGate := true;
end;

procedure TStreet.TakeAwayMonster(lok_id: integer; mob_id: integer);
var
  i: integer;
begin
  if fLok[hon(lok_id)].monsters[1] = mob_id then
  begin
    fLok[hon(lok_id)].monsters[1] := 0;
    fLok[hon(lok_id)].lok_mon_count := fLok[hon(lok_id)].lok_mon_count - 1;
  end;

end;

procedure TStreet.CloseGate(lok_id: integer);
var
  lokk: TLocation;
begin
  fLok[hon(lok_id)] := GetLokByID(lok_id);
  fLok[hon(lok_id)].gate.other_world := 0;
  fLok[hon(lok_id)].gate.modif := 0;
  fLok[hon(lok_id)].gate.dimension := 0;
  fLok[hon(lok_id)].HasGate := false;
end;

end.
