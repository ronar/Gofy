unit uInvestigator;

interface

type
  TInvestigator = class
  private
  public
    name: string;
    sanity: integer;
    stamina: integer;
    start_lok: integer;
    money: integer;
    clues: integer;
    items: array [1..10] of integer; // Random possessions
    items_count: integer; // How many different items in investigator's possession
    ally: integer;
    focus: integer;
    stats: array [1..6] of integer;
    can_take: array [1..4, 1..2] of integer; // What, how many
    procedure Investigator; // Процедура для игры, позволяет сделать то что написано на карте сыщика
  end;


implementation

procedure TInvestigator.Investigator;
begin
end;

end.
