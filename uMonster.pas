unit uMonster;

interface

uses
  SysUtils, Dialogs, uCommon;

type
  TMonster = class
  private
    fId: integer;
    //monData: string;
    fName: string;
    fAwareness:integer;
    fMovBorder: integer;
    fDimention: integer;
    fHorrorRate: integer;
    fHorrorDmg: integer;
    fToughness: integer;
    fCmbtRate: integer;
    fCmbtDmg: integer;
    fSpec: string[6];
    fLocationId: integer;
  public
    property Id: Integer read fId write fId;
    property Name: string read fName write fName;
    property Awareness:integer read fAwareness write fAwareness;
    property MovBorder: integer read fMovBorder write fMovBorder;
    property Dimention: integer read fDimention write fDimention;
    property HorrorRate: integer read fHorrorRate write fHorrorRate;
    property HorrorDmg: integer read fHorrorDmg write fHorrorDmg;
    property Toughness: integer read fToughness write fToughness;
    property CmbtRate: integer read fCmbtRate write fCmbtRate;
    property CmbtDmg: integer read fCmbtDmg write fCmbtDmg;
    //property fSpec: string[6] read fId write fId;
    property LocationId: integer read fLocationId write fLocationId;
    constructor Create();
    function Move(const MobMoveWhite: array of integer; const MobMoveBlack: array of integer): integer;
  end;

  TMonsterArray = array of TMonster;

  function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
  function DrawMonsterCard(var monsters: TMonsterArray): TMonster;
  procedure ShuffleMonsterDeck(monsters: TMonsterArray);
  //procedure MoveMonster(); // TODO: moving of the monsters
  function GetMonsterNameByID(id: integer): string;
  function GetMonsterByID(const monsters: TMonsterArray; id: integer): TMonster; // Get mob from pool
  function GetMonsterCount(const monsters: TMonsterArray): integer;

var
  monCount: integer = 0; // Kol-vo mobov v pule

implementation

uses
  uMainForm, uStreet;

constructor TMonster.Create;
begin

end;

function TMonster.Move(const MobMoveWhite: array of integer; const MobMoveBlack: array of integer): integer;
var
  i: integer;
  lok_id: Integer;
begin
  Result := 0;
  lok_id := fLocationId;
  Arkham_Streets[ton(fLocationId)].TakeAwayMonster(fLocationId, fId);
  //case fMovBorder of
    //1: begin  // Black (normal)
      if MobMoveWhite[fDimention - 1] = 1 then // if white mob move in mythos card
      begin
        for i := 1 to 36 do
          if aMonsterMoves[i, 1] = lok_id then
          begin
            fLocationId := aMonsterMoves[i, 2];
            Result := fLocationId;
            //Arkham_Streets[ton(fLocationId)].AddMonster(fLocationId, fId);
            frmMain.lstLog.Items.Add('������ ' + fName + ' ������� � ������� ' + GetLokNameByID(fLocationId));
          end;
      end;

      if MobMoveBlack[fDimention - 1] = 1 then // if black mob move in mythos card
      begin
        for i := 1 to 36 do
          if aMonsterMoves[i, 1] = lok_id then
          begin
            fLocationId := aMonsterMoves[i, 3];
            Result := fLocationId;
            frmMain.lstLog.Items.Add('������ ' + fName + ' ������� � ������� ' + GetLokNameByID(fLocationId));
          end;
      end;

  //  end;
  //2: ; // Stationary (Yellow Border)
  //3: ; // Fast (Red Border)
  //4: ; // Unique (Green Border)
  //5: ; // Flying (Blue Border)
  //end;

end;

function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
var
  F: TextFile;
  SR: TSearchRec; // ��������� ����������
  FindRes: Integer; // ���������� ��� ������ ���������� ������
  s: string;
  i, a: integer;
begin
  // ������� ������� ������ � ������ ������
  FindRes := FindFirst(file_path+'\CardsData\Monsters\' + '*.txt', faAnyFile, SR);

  i := 0;
  a := 0;

  while FindRes = 0 do // ���� �� ������� ����� (��������), �� ��������� ����
  begin
    i := i + 1;
    AssignFile (F, file_path+'\CardsData\Monsters\' + SR.Name);
    Reset(F);
      //read(F, );
      //i := i + 1;
    SetLength(Monsters, i);
    Monsters[i-1] := TMonster.Create;
    with Monsters[i-1] do
    begin
      Id := StrToInt(Copy(SR.Name, 1, 3));
      //monData: string;
      Name := GetMonsterNameByID(Id);
      readln(F, s);
      Awareness   := StrToInt(s);
      readln(F, s);
      MovBorder   := StrToInt(s);
      readln(F, s);
      Dimention   := StrToInt(s);
      readln(F, s);
      HorrorRate := StrToInt(s);
      readln(F, s);
      HorrorDmg  := StrToInt(s);
      readln(F, s);
      Toughness   := StrToInt(s);
      readln(F, s);
      CmbtRate   := StrToInt(s);
      readln(F, s);
      CmbtDmg    := StrToInt(s);
      //spec: string[6];
    end;

    CloseFile(F);
    //Cards^.Cards.Type := CT_UNIQUE_ITEM;

    FindRes := FindNext(SR); // ����������� ������ �� �������� ��������
    //Form1.ComboBox2.Items.Add(IntToStr(Cards^[i].Card_ID));
  end;
  FindClose(SR); // ��������� �����
  LoadMonsterCards := i;
  monCount := i;
end;

// Return mob ID
function DrawMonsterCard(var monsters: TMonsterArray): TMonster;
var
  i: integer;
  dmonster: TMOnster;
begin
  //Assert(monCount > 1);
  dmonster := nil;
  if monCount < 1 then
  begin
    ShowMessage('���� ��������.');
    DrawMonsterCard := nil;
    Exit;
  end;
  randomize;
  dmonster := monsters[random(monCount)];
  Result := dmonster;
  //ShuffleMonsterDeck(monsters);
  monCount := monCount - 1;
end;

// TODO: Access violation
procedure ShuffleMonsterDeck(monsters: TMonsterArray);
var
  i, r: integer;
  temp: TMonster;
begin
  randomize;
  for i := 0 to monCount-1 do
  begin
    temp := monsters[i];
    r := random(monCount);
    monsters[i] := monsters[r];
    monsters[r] := temp;
  end;
end;

//
function GetMonsterNameByID(id: integer): string;
var
  i: integer;
begin
  for i := 1 to MONSTER_MAX do
    if StrToInt(MonsterNames[i, 1]) = id then
    begin
      GetMonsterNameByID := MonsterNames[i, 2];
      break;
    end;
end;

function GetMonsterByID(const monsters: TMonsterArray; id: integer): TMonster;
var
  i: integer;
begin
  for i := 0 to MONSTER_MAX-1 do
  begin
    if Monsters[i].fId = id then
    begin
      GetMonsterByID := Monsters[i];
      //Monsters[i] := nil;
      break;
    end;
  end;

end;

function GetMonsterCount(const monsters: TMonsterArray): integer;
var
  i, c: integer;
begin
  c := 0;
  i := 0;
  while monsters[i].fId <> 0 do
  begin
    c := c + 1;
    i := i + 1;
  end;
  GetMonsterCount := c;
end;

end.
