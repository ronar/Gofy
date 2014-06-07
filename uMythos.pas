unit uMythos;

interface

type
  TMythosCard = record
    fId: integer;
    fClueSpawn: integer;
    fCloseLok:integer;
    fProcess: integer;
    fHeadline: integer;
    fSkillChk: integer;
    fSkillChkTrue: integer;
    fSkillChkFalse: integer;
    fSpeedMod: integer;
    fSneakMod: integer;
    fFightMod: integer;
    fWillMod: integer;
    fLoreMod: integer;
    fLuckMod: integer;
    fGateSpawn: integer;
    fMobMoveWhite: array [1..9] of integer;
    fMobMoveBlack: array [1..9] of integer;
  end;

  TMythosArray = array of TMythosCard;

{  function LoadMonsterCards(var monsters: TMonsterArray; file_path: string): integer;
  function DrawMonsterCard(var monsters: TMonsterArray): integer;
  procedure ShuffleMonsterDeck(var monsters: TMonsterArray);
  function GetMonsterNameByID(id: integer): string;
  function GetMonsterByID(var monsters: TMonsterArray; id: integer): TMonster; // Get mob from pool
  function GetMonsterCount(var monsters: TMonsterArray): integer;
}

implementation

end.
