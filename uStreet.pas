{***************************************************************************}
{                                                                           }
{  This file is part of the Gofy "Arkham Horror: The Board Game" migration  }
{  and implementation.                                                      }
{                                                                           }
{  Licensed under GPL License, Version 3.0 (the "License");                 }
{  you may not use this file except in compliance with the License.         }
{  You should have received a copy of the GNU General Public License        }
{  along with Gofy "Arkham Horror: The Board Game" migration Source Code.   }
{  If not, see                                                              }
{                                                                           }
{      <http://www.gnu.org/licenses/>                                       }
{                                                                           }
{  Gofy "Arkham Horror: The Board Game" migration Source Code is free       }
{  software: you can redistribute it and/or modify it under the terms       }
{  of the GNU General Public License as published by the                    }
{  Free Software Foundation, either version 3 of the License, or            }
{  (at your option) any later version.                                      }
{                                                                           }
{  Gofy "Arkham Horror: The Board Game" migration Source Code is            }
{  distributed in the hope that it will be useful,                          }
{  but WITHOUT ANY WARRANTY; without even the implied warranty of           }
{  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the             }
{  GNU General Public License for more details.                             }
{                                                                           }
{ The Original Code is Street.pas.                                          }
{                                                                           }
{ Contains logic for handling monster, gates, clues appearing and           }
{ interaction.                                                              }
{                                                                           }
{ Unit owner:    Ronar                                                      }
{ Last modified: March 7, 2021                                              }
{                                                                           }
{***************************************************************************}

unit uStreet;

interface
uses Winapi.Windows, Graphics, uCommon, uLocationCardDeck, uCardXML, SysUtils, Dialogs, Controls, uMonster;

type
  TLocation = record
    lok_id: integer; // id of location (2100, 2200, 2300, etc..)
    lok_name: string;
    clues: integer; // Улики на локации
    gate: TGate; // Врата открытые на локации
    HasGate: Boolean;
    lok_monsters: array [1..MONSTER_MAX_ON_LOK] of TMonster;
    lok_mon_count: integer;
  end;

  TStreet = class(TObject)
  private
    fId: integer; // id of streets (1000, 2000, 3000, etc..)
    fLok: array [1..3] of TLocation;
    fDeck: TLocationCardsDeck;
    fAdjacent: array [1..6] of integer; // Прилегающие локации
    fMonsters: array [1..MONSTER_MAX_ON_LOK] of TMonster; // Mobs in the streets :)
    fStreetMonsterCount: integer;
    function GetDeck: TLocationCardsDeck;
    function GetLok(i: integer): TLocation;
    function GetMonster(i: integer): TMonster;
    procedure SetMonster(i: integer; mob: TMonster);
  public
    constructor Create(street_id: integer);
    property StreetId: integer read fId write fId;
    property Deck: TLocationCardsDeck read GetDeck;
    property Lok[i: integer]: TLocation read GetLok;
    property Monsters[i: integer]: TMonster read GetMonster write SetMonster;
    property st_mob_count: Integer read fStreetMonsterCount write fStreetMonsterCount;
    function GetLokByID(id: integer): TLocation;
    procedure Encounter(lok_id: integer; crd_num: integer);
    function AddMonster(to_lok: integer; mob: TMonster): Boolean;
    function AddClue(lok_id: integer; n: integer): Boolean;
    function SpawnGate(lok_id: integer; gate: TGate): Boolean;
    procedure RemoveClue(lok_id: integer; n: integer);
    procedure TakeAwayMonster(from_lok: integer; mob: TMonster);
    procedure CloseGate(lok_id: integer);
    procedure MoveMonsters;
  end;

  function GetLokIDByName(lok_name: string): integer; // Получение ID локации по названию
  function GetStreetIDByName(street_name: string): integer;
  //function GetStreetIndxByLokID(id: integer): integer; // Searches the array for location that matches the id param
  function GetStreetNameByID(id: integer): string;
  function GetLokNameByID(id: integer): string;
//  function ProcessCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): boolean;
//  function ProcessMultiCondition(cond: integer; prm: integer; n: Integer; suxxess: integer): integer;
//  procedure ProcessAction(action: integer; action_value: integer; suxxess: string = '0');
  procedure ProcessNode(Node : PLLData; add_data: integer = 0);


implementation

uses uTradeForm, uMainForm, uEncounterInquiryForm, uDrop, uLocationSelectorForm, uCardForm, Classes;

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
        fLok[n].lok_monsters[1] := nil;
        fLok[n].lok_monsters[2] := nil;
        fLok[n].lok_monsters[3] := nil;
        fLok[n].lok_monsters[4] := nil;
        fLok[n].lok_monsters[5] := nil;
        fLok[n].lok_mon_count := 0;
    end;
    fDeck := TLocationCardsDeck.Create;
    fStreetMonsterCount := 0;
  end;
end;

function TStreet.GetDeck: TLocationCardsDeck;
begin
  result := fDeck;
end;

function TStreet.GetLok(i: integer): TLocation;
begin
  Result := fLok[i];
end;

function TStreet.GetMonster(i: integer): TMonster;
begin
  Result := fMonsters[i];
end;

procedure TStreet.SetMonster(i: integer; mob: TMonster);
begin
  Monsters[i] := mob;
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
      MainForm.lstLog.Items.Add('Проверяется навык ' + aStats[prm] + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
      skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n, 1); // Choise - номер скилла
      { TODO -oRonar : Choise is in dependence with structure of construction
        of program. In another words if indices have been changed, program
        will be broken }
      MainForm.lstLog.Items.Add('Проверка навыка ' + aStats[prm] + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
      if (skill_test >= suxxess) then
        ProcessCondition := True
      else
      begin
        ProcessCondition := False;
      end;
    end;
    3: begin // Проверка наличия
      MainForm.lstLog.Items.Add('Проверка наличия чего-либо у игрока');
      if gCurrentPlayer.CheckAvailability(prm, N) then //
        ProcessCondition := True
      else
      begin
        ProcessCondition := False;
        MainForm.lstLog.Items.Add('Не хватат!');
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
      MainForm.lstLog.Items.Add('Проверка наличия карты в колоде');
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
      frmMain.lstLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов');
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
  MainForm.lstLog.Items.Add('Проверяется навык ' + aStats[prm] + '(=' + IntToStr(gCurrentPlayer.Stats[prm]) + ' -' + IntToStr(n) + ')..');
  skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[prm] + n, 1); // prm - order num of skill (1 - speed, ...)
  MainForm.lstLog.Items.Add('Проверка навыка ' + aStats[prm] + ' выпало: ' + IntToStr(skill_test) + ' успеъ(ов)');
  ProcessMultiCondition := skill_test;
end;

function Choise2(act1: string; act2: string): integer;
begin
  EncounterInquiryForm.Choise2(act1, act2);
  EncounterInquiryForm.ShowModal;
  if EncounterInquiryForm.RadioButton1.Checked then
    Choise2 := 1
  else
    if EncounterInquiryForm.RadioButton2.Checked then
      Choise2 := 2;
end;

function Choise3(act1: string; act2: string; act3: string): integer;
begin
  EncounterInquiryForm.Choise3(act1, act2, act3);
  EncounterInquiryForm.ShowModal;
  if EncounterInquiryForm.RadioButton1.Checked then
    Choise3 := 1
  else
    if EncounterInquiryForm.RadioButton2.Checked then
      Choise3 := 2
    else
      Choise3 := 3;
end;

function Choise4(act1: string; act2: string; act3: string; act4: string): integer;
begin
  EncounterInquiryForm.Choise4(act1, act2, act3, act4);
  EncounterInquiryForm.ShowModal;
  if EncounterInquiryForm.RadioButton1.Checked then
    Choise4 := 1
  else
    if EncounterInquiryForm.RadioButton2.Checked then
      Choise4 := 2
    else
      if EncounterInquiryForm.RadioButton3.Checked then
        Choise4 := 3
      else
        Choise4 := 4;
end;

// Выполнение действия согласно карте
procedure ProcessAction(action: integer; action_value: integer; suxxess: string = '0');
var
  i: integer;
  drawn_monster: TMonster;
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
      MainForm.lstLog.Items.Add('Игрок получил деньги: ' + IntToStr(action_value) + '.');
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
        MainForm.lstLog.Items.Add('Игрок потерял все деньги.');

      end
      else
      begin
        gPlayer.Money := gPlayer.Money - action_value;
        MainForm.lstLog.Items.Add('Игрок потерял деньги: ' + IntToStr(action_value) + '.');
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
      MainForm.lstLog.Items.Add('Игрок получил тело: ' + IntToStr(action_value) + '.');
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
      MainForm.lstLog.Items.Add('Игрок получил разум: ' + IntToStr(action_value) + '.');
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
      MainForm.lstLog.Items.Add('Игрок потерял тело: ' + IntToStr(action_value) + '.');
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
      MainForm.lstLog.Items.Add('Игрок потерял разум: ' + IntToStr(action_value) + '.');
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
      MainForm.lstLog.Items.Add('Игрок получил улику(и): ' + IntToStr(action_value) + '.');
    end; // case 7
    8: begin // Lose clues
      gCurrentPlayer.Clues := gCurrentPlayer.Clues - action_value;
      MainForm.lstLog.Items.Add('Игрок потерял улику(и): ' + IntToStr(action_value) + '.');
    end; // case 8
    9: begin // Draw common item
      if action_value > 1000 then // id of card is defined
        gCurrentPlayer.AddItem(Common_Items_Deck, action_value)
      else
      begin
        for i := 1 to action_value do
          gCurrentPlayer.AddItem(Common_Items_Deck, Common_Items_Deck.DrawCard);
      end;
      MainForm.lstLog.Items.Add('Игрок вытянул карту простого предмета: ' + IntToStr(action_value));
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
      MainForm.lstLog.Items.Add('Игрок вытянул карту уникального предмета.');
    end; // case 10
    11: begin // Draw spell
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      MainForm.lstLog.Items.Add('Игрок вытянул карту закла.');
    end; // case 11
    12: begin // Draw skill
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      MainForm.lstLog.Items.Add('Игрок берет карту навыка.');
    end; // case 12
    13: begin // Draw ally card
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      for i := 1 to ALLIES_MAX do
        if StrToInt(Allies[i, 1]) = action_value then
          MainForm.lstLog.Items.Add('Игрок вытянул карту союзника: ' + Allies[i, 2] + '.');
    end; // case 13
    15: begin // Drop item of player's choise
      PrepareCardsToDrop(gCurrentPlayer, action_value);
      DropForm.ShowModal;
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      MainForm.lstLog.Items.Add('Игрок потерял предмет (на выбор).');
    end; // case 15
    16: begin // Drop weapon of player's choise or amt.
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      MainForm.lstLog.Items.Add('Игрок потерял оружие ' + IntToStr(action_value));
    end; // case 16
    18: begin // Drop spell
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      MainForm.lstLog.Items.Add('Игрок потерял закл.');
    end; // case 18
    19: begin // Drop skill
      //gCurrentPlayer.AddItem(Spells_Deck.DrawCard);
      MainForm.lstLog.Items.Add('Игрок потерял навык.');
    end; // case 19
    20: begin // Move to street
      //gCurrentPlayer.Blessed := True;
      MainForm.lstLog.Items.Add('Игрок вышел на улицу (overlapping).');
    end; // case 20

    22: begin //

    end; // case 22
    25: begin // Busted
      //gCurrentPlayer.MoveToLocation(3200);
      gCurrentPlayer.Location := 3200;
      MainForm.lstLog.Items.Add('Игрок арестован.');
    end; // case 25
{    21: begin // Draw another card for encounter
      MainForm.lstLog.Items.Add('Игрок тянет другую карту контакта для локации');
    end; // case 25
}    26: begin // Draw common items, buy for 1 above of it's price, any or all
      MainForm.lstLog.Items.Add('Encounter');
    end; // case 26
    30: begin // Move to lok/street (ID or 0 - to street, -1 - to any lok/street)
      if action_value = 0 then
      begin
        gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
        MainForm.lstLog.Items.Add('Игрок вышел на улицу');
      end
      else
        if action_value = -1 then
        begin
          LocationSelectorForm.ShowModal;
          gCurrentPlayer.Location := StrToInt(LocationSelectorForm.edtLocationId.text);
          MainForm.lstLog.Items.Add('Игрок перешел на локацию: ' + GetLokNameByID(StrToInt(LocationSelectorForm.edtLocationId.text)));
        end
        else
        begin
          gCurrentPlayer.Location := action_value;
          MainForm.lstLog.Items.Add('Игрок перешел на локацию: ' + GetLokNameByID(action_value));
        end;

      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;

    end; // case 30
    32: begin // Encounter
      //TODO: top card in deck, not 7
      MainForm.lstLog.Items.Add('Игрок вступает в контакт');
      //Encounter(gCurrentPlayer, Arkham_Streets[ton(gCurrentPlayer.Location)].deck.cards[7, hon(gCurrentPlayer.Location)]);
    end; // case 32
    33: begin // Blessed
      gCurrentPlayer.Blessed := True;
      MainForm.lstLog.Items.Add('Игрок благословен.');
    end; // case 33
    34: begin //

    end; // case 34
    35: begin // Sucked into gate
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      MainForm.lstLog.Items.Add('Игрока затянуло во врата.');
    end; // case 35
    36: begin // Monster apeeared
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      drawn_monster := DrawMonsterCard(Monsters);
      Arkham_Streets[ton(gCurrentPlayer.Location)].AddMonster(gCurrentPlayer.Location, drawn_monster);
      MainForm.lstLog.Items.Add('Появился монстр: ' + IntToStr(drawn_monster.id));
    end; // case 36
    37: begin // Gate appeared
      Arkham_Streets[ton(gCurrentPlayer.Location)].SpawnGate(gCurrentPlayer.Location, gates[random(8)+1]);
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      MainForm.lstLog.Items.Add('Появились врата.');
    end; // case 37
    38: begin // Pass turn
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      MainForm.lstLog.Items.Add('Игрок пропускает ход.');
      gCurrentPlayer.Moves := 0;
    end; // case 38
    39: begin // Lost in time and space
      //gCurrentPlayer.Location := ton(gCurrentPlayer.Location) * 1000;
      MainForm.lstLog.Items.Add('Игрок потерян во времени и пространстве.');
    end; // case 39

 { 41: begin // Check skill
    MainForm.lstLog.Items.Add('Прове яется навык ' + IntToStr(Choise - 1) + '(=' + IntToStr(gCurrentPlayer.Stats[Choise - 1]) + ' -' + IntToStr(N) + ')..');
    skill_test := gCurrentPlayer.RollADice(gCurrentPlayer.Stats[Choise - 1] - N); // Choise - номер скилла
    MainForm.lstLog.Items.Add('Проверка навыка ' + IntToStr(Choise - 1) + ' выпало: ' + IntToStr(skill_test) + ' успех(ов)');
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
        MainForm.lstLog.Items.Add('Игрок тянет 1 простую вещь бесплатно из ' + IntToStr(action_value));
      end; // case 42
    42: // Игрок тянет 1 заклинание бесплатно из n
      begin
        MainForm.lstLog.Items.Add('Игрок тянет 1 заклинание бесплатно из ' + IntToStr(action_value));
      end; // case 42
    43: begin
      MainForm.lstLog.Items.Add('Игрок берет верхню карту из любой колоды локаций. Она достанется тому сыщику, который первый получит контакт в той локации :)');
    end; // case 43
    51: // Take common weapon
      begin
        MainForm.lstLog.Items.Add('Игрок берет простое оружие бесплатно: ' + IntToStr(action_value));
      end; // case 51
    53: // Take common tome
      begin
        MainForm.lstLog.Items.Add('Игрок берет первую попавшеюся просту книгу: ' + IntToStr(action_value));
      end; // case 51
      55: // Sell an item for 2x price
      begin
        card_to_load := CT_COMMON_ITEM;
        CardForm.ShowModal;
        MainForm.lstLog.Items.Add('Игрок может продать любую вещь в 2 раза дороже: ' + IntToStr(action_value));
      end; // case 51
      66: begin // Cursed
        gCurrentPlayer.Cursed := True;
        MainForm.lstLog.Items.Add('Игрок проклят.');
      end; // case 66

    28: // Move to location, enc
      if action_value = 0 then
      begin
        LocationSelectorForm.ShowModal;

      end
      else
        MainForm.lstLog.Items.Add('Ничего не произошло.'); //gPlayer.Location := StrToInt(IntToStr(Round(action_value / 3 + 0.4)) + IntToStr(action_value - (Round(action_value / 3 + 0.4) - 1) * 3));
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
    MainForm.lstLog.Items.Add('Ничего не произошло.');
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
  PrevStretchBltMode : Integer;
  bmp: TBitmap;
begin
  //if lok_id mod 1000 = 0 then exit; // No encounters on streets

  lok := fLok[hon(lok_id)];

  if lok.HasGate then
  begin
    if MessageDlg('Закрыть врата ведущие в иной мир?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if gCurrentPlayer.CloseGate then
        MainForm.lstLog.Items.Add('Игрок подзакрыл врата!')
      else
        MainForm.lstLog.Items.Add('Игрок не смог подзакрыть врата!')

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
    MainForm.imgEncounter.AutoSize := True;
    MainForm.imgEncounter.Picture.LoadFromFile(crd_name);
//    bmp := MainForm.imgEncounter.Picture.Bitmap;


    bmp := TBitmap.Create;

//
    try
        with bmp do begin
//          bmp.Assign(MainForm.imgEncounter.Bitmap);
          Width := MainForm.imgEncounter.Width;
          Height := MainForm.imgEncounter.Height;
          Canvas.Draw(0, 0, MainForm.imgEncounter.Picture.Graphic);
          MainForm.imgEncounter.Picture := nil;
//          Transparent := True;
//          TransParentColor := bmp.canvas.pixels[50,50];
//          MainForm.Canvas.Draw(0, 0, bmp);
          MainForm.imgEncounter.AutoSize := False;
          MainForm.imgEncounter.Width := 273;
          MainForm.imgEncounter.Height := 428;
//          TransparentMode := tmAuto;
//          MainForm.Canvas.StretchDraw(rect(0, 0, 500, 500), MainForm.imgEncounter.Picture.Graphic);
PrevStretchBltMode := SetStretchBltMode(bmp.Canvas.Handle, STRETCH_HALFTONE);// устанавливаем режим сглаживания
StretchBlt(MainForm.imgEncounter.Canvas.Handle, 0, 0, 273, 428, bmp.Canvas.handle,
     0, 0, bmp.Width, bmp.Height, SRCCOPY);
                 SetStretchBltMode(bmp.Canvas.Handle, PrevStretchBltMode);// Восстанавливаем предыдущий ражим сглаживания
        end;
      finally
        bmp.Free;
      end;

//    PrevStretchBltMode := SetStretchBltMode(MainForm.imgEncounter.Picture.Bitmap.Canvas.Handle, STRETCH_HALFTONE);// устанавливаем режим сглаживания
//    StretchBlt(MainForm.imgEncounter.Canvas.Handle, 0, 0, 300, 300, bmp.Canvas.handle,
//     0, 0, MainForm.imgEncounter.Width, MainForm.imgEncounter.Height, SRCCOPY);
//    Canvas.CopyRect(
//      rect(0, 0, ClientWidth, ClientHeight),
//      Image1.Picture.Bitmap.Canvas,
//      Rect(0,0, Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height));
//
//    SetStretchBltMode(Canvas.Handle, PrevStretchBltMode );// Восстанавливаем предыдущий ражим сглаживания

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
  result := 0;

  for i := 1 to NUMBER_OF_STREETS do
  begin
    if (AnsiCompareText(aNeighborhoodsNames[i, 2], lok_name) = 0) then
      if (StrToInt(aNeighborhoodsNames[i, 1]) >= 1000) then
      begin
        result := StrToInt(aNeighborhoodsNames[i, 1]);
        break;
        Exit;
      end
      else
        result := 0; // TODO: Move to nowhere
  end;

  for i := 1 to NUMBER_OF_LOCATIONS do
  begin
    if (AnsiCompareText(aLocationsNames[i, 2], lok_name) = 0) then
      if (StrToInt(aLocationsNames[i, 1]) > 1000) then
      begin
        result := StrToInt(aLocationsNames[i, 1]);
        break;
        Exit;
      end
      else
        result := 0; // TODO: Move to nowhere
  end;
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

  if id < 1000 then // Other worlds
  begin
    for i := 1 to NUMBER_OF_OW_LOCATIONS do
    if StrToInt(aOtherWorldsNames[i, 1]) = id then
    begin
      Result := aOtherWorldsNames[i, 2];
      break;
    end;
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

function TStreet.AddMonster(to_lok: integer; mob: TMonster): Boolean;
var
  i, lok_num: integer;
begin
  if mob = nil then
  begin
    ShowMessage('Невозможно добавить моба! Nil');
    Result := false;
    exit;
  end;

  if not (mob is TMonster) then
  begin
    ShowMessage('Alarm!!!');
  end;

  try
    if to_lok mod 1000 = 0 then
    begin
      fStreetMonsterCount := fStreetMonsterCount + 1;
      fMonsters[fStreetMonsterCount] := mob;
      mob.LocationId := to_lok;
      uMonster.DeckMobCount := uMonster.DeckMobCount - 1;

     // ShowMessage('Добавлен на локацию: ' + IntToStr(to_lok));
    end
    else
    begin
      lok_num := hon(to_lok);
      fLok[lok_num].lok_mon_count := fLok[lok_num].lok_mon_count + 1;
      fLok[lok_num].lok_monsters[fLok[lok_num].lok_mon_count] := mob;
      mob.LocationId := to_lok;
      uMonster.DeckMobCount := uMonster.DeckMobCount - 1;

     // ShowMessage('Добавлен на локацию: ' + IntToStr(to_lok));
    end;

    result := true;
  except
    ShowMessage('Невозможно добавить монстра! Except');
    Result := false;
  end;

end;

function TStreet.AddClue(lok_id: integer; n: integer): Boolean;
begin
  result := true;
  try
    fLok[hon(lok_id)].clues := fLok[hon(lok_id)].clues + n;
  except
    ShowMessage('Невозможно добавить улику!');
    Result := false;
  end;
end;

procedure TStreet.RemoveClue(lok_id: integer; n: integer);
begin
  fLok[hon(lok_id)].clues := fLok[hon(lok_id)].clues - n;
end;

function TStreet.SpawnGate(lok_id: integer; gate: TGate): boolean;
begin
  try
    fLok[hon(lok_id)] := GetLokByID(lok_id);
    fLok[hon(lok_id)].gate.other_world := gate.other_world;
    fLok[hon(lok_id)].gate.modif := gate.modif;
    fLok[hon(lok_id)].gate.dimension := gate.dimension;
    fLok[hon(lok_id)].HasGate := true;
    result := true;
  except
    ShowMessage('Невозможно добавить врата!');
    Result := false;
  end;

end;

procedure TStreet.TakeAwayMonster(from_lok: integer; mob: TMonster);
var
  i, j: integer;
  lok_num: integer;
  mob_count: Integer;
  procedure AlignArray(var mobs: array of TMonster);
  var
    k, l: Integer;
  begin
    for k := 0 to MONSTER_MAX_ON_LOK - 2 do
      if (mobs[k] = nil) then
        for l := k to MONSTER_MAX_ON_LOK - 2 do
          if (mobs[l + 1] <> nil) then
          begin
            mobs[l] := mobs[l + 1];
            mobs[l + 1] := nil;
          end;
  end;
begin
  if from_lok mod 1000 = 0 then // Street
  begin
    mob_count := fStreetMonsterCount;
    for i := 1 to mob_count do
    begin
      if fMonsters[i] = mob then
      begin
        fMonsters[i].LocationId := 0;
        fMonsters[i] := nil;
        mob.LocationId := 0;
        fStreetMonsterCount := fStreetMonsterCount - 1;
        uMonster.DeckMobCount := uMonster.DeckMobCount + 1;
       // ShowMessage('Убран с локации: ' + IntToStr(from_lok));
      end;
    end;
    AlignArray(Self.fMonsters);
//    ShowMessage('s');
    //AlignArray(Self.fMonsters);
  end
  else // Location
  begin
    lok_num := hon(from_lok);
    mob_count := fLok[lok_num].lok_mon_count;
    for i := 1 to mob_count do
    begin
      if fLok[lok_num].lok_monsters[i] = mob then
      begin
        fLok[lok_num].lok_monsters[i].LocationId := 0;
        fLok[lok_num].lok_monsters[i] := nil;
        mob.LocationId := 0;
        fLok[lok_num].lok_mon_count := fLok[lok_num].lok_mon_count - 1;
        uMonster.DeckMobCount := uMonster.DeckMobCount + 1;
       // ShowMessage('Убран с локации: ' + IntToStr(from_lok));
      end;
    end;
    AlignArray(fLok[lok_num].lok_monsters);
//    ShowMessage('s');
    //AlignArray(fLok[lok_num].lok_monsters);
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

procedure TStreet.MoveMonsters();
begin

end;

end.
