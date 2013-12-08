unit uCommon;

interface

const
  // Статы
  ST_SPEED = 1;
  ST_SNEAK = 2;
  ST_FIGHT = 3;
  ST_WILL = 4;
  ST_LORE = 5;
  ST_LUCK = 6;
  // Константы фаз
  PH_UPKEEP = 1;
  PH_MOVE = 2;
  PH_ENCOUNTER = 3;
  PH_KONTAKTI_V_INIH_MIRAH = 4;
  PH_MYTHOS = 5;
  // Константы Типов Карт
  CT_SPELL = 6; // Заклинание
  CT_ALLY = 7; // Союзник
  CT_MYTHOS = 8; // Миф
  CT_SKILL = 9; // Навык
  CT_COMMON_ITEM = 1; // Простые предметы (первая цифра в ID)
  CT_UNIQUE_ITEM = 2; // Уникальные предметы (первая цифра в ID)
  CT_ENCOUNTER = 3; // Контакт (первая цифра в ID)
  // Константы Действий
  AT_SPEC = 2;
  AT_WATCH_BUY = 3;
  NeighborhoodsNames: array [1..19] of string = ('Backwoods Country', 'Blasted Heath',
        'Central Hill', 'Church Green', 'Downtown', 'Easttown', 'Factory District',
        'French Hill', 'Harborside', 'Innsmouth Shore', 'Kingsport Head',
        'Merchant District', 'Miskatonic University', 'Northside', 'Rivertown',
        'South Shore', 'Southside', 'Uptown', 'Village Common');
  LocationsNames: array [1..57, 1..2] of string = (
        ('011', '607 Water St.'),
        ('012', '7th House on the Left'),
        ('013', 'Administration Building'),
        ('2100', 'Arkham Asylum'),
        ('011', 'Artists'' Colony'),
        ('2200', 'Bank of Arkham'),
        ('011', 'Bishop''s Brook Bridge'),
        ('011', 'Black Cave'),
        ('011', 'Cold Spring Glen'),
        ('011', 'Congregational Hospital'),
        ('011', 'Curiositie Shoppe'),
        ('011', 'Darke''s Carnival'),
        ('011', 'Devil Reef'),
        ('011', 'Devil''s Hopyard'),
        ('011', 'Dunwich Village'),
        ('011', 'Esoteric Order of Dagon'),
        ('011', 'Falcon Point'),
        ('011', 'First National Grocery'),
        ('011', 'Gardners'' Place'),
        ('011', 'General Store'),
        ('011', 'Gilman House Hotel'),
        ('011', 'Graveyard'),
        ('011', 'Hall School'),
        ('011', 'Harney Jones'' Shack'),
        ('011', 'Hibb''s Roadhouse'),
        ('011', 'Historical Society'),
        ('2300', 'Independence Square'),
        ('011', 'Inner Sanctum'),
        ('011', 'Innsmouth Jail'),
        ('011', 'Jail Cell'),
        ('011', 'Library'),
        ('011', 'Ma''s Boarding House'),
        ('011', 'Marsh Refinery'),
        ('011', 'Neil''s Curiosity Shop'),
        ('011', 'Newspaper'),
        ('011', 'North Point Lighthouse'),
        ('011', 'Police Station'),
        ('011', 'River Docks'),
        ('011', 'Science Building'),
        ('011', 'Silver Twilight Lodge'),
        ('011', 'South Church'),
        ('011', 'St. Erasmus''s Home'),
        ('011', 'St. Mary''s Hospital'),
        ('011', 'Strange High House'),
        ('011', 'The Causeway'),
        ('011', 'The Rope and Anchor'),
        ('011', 'The Unnamable'),
        ('011', 'The Witch House'),
        ('011', 'Train Station'),
        ('011', 'Unvisited Isle'),
        ('011', 'Velma''s Diner'),
        ('011', 'Whateley Farm'),
        ('011', 'Wireless Station'),
        ('011', 'Wizard''s Hill'),
        ('011', 'Woods'),
        ('011', 'Y''ha-nthlei'),
        ('011', 'Ye Olde Magick Shoppe'));
  crd_ally: array [1..1] of string = ('Anna Kaslow');
  investigators: array [1..49] of string = ('Agnes Baker', 'Akachi Onyele',
        'Amanda Sharpe', '"Ashcan" Pete', 'Bob Jenkins', 'Calvin Wright',
        'Carolyn Fern', 'Charlie Kane', 'Daisy Walker', 'Darrell Simmons',
        'Dexter Drake', 'Diana Stanley', 'Finn Edwards', 'George Barnaby',
        'Gloria Goldberg', 'Hank Samson', 'Harvey Walters', 'Jacqueline Fine',
        'Jenny Barnes', 'Jim Culver', 'Joe Diamond', 'Kate Winthrop',
        'Leo Anderson', 'Lily Chen', 'Lola Hayes', 'Luke Robinson',
        'Mandy Thompson', 'Marie Lambeau', 'Mark Harrigan', 'Michael McGlen',
        'Minh Thi Phan', 'Monterey Jack', 'Norman Withers', 'Patrice Hathaway',
        'Rex Murphy', 'Rita Young', 'Roland Banks', 'Silas Marsh',
        'Sister Mary', '"Skids" O''Toole', 'Tommy Muldoon', 'Tony Morgan',
        'Trish Scarborough', 'Ursula Downs', 'Vincent Lee', 'Wendy Adams',
        'William Yorick', 'Wilson Richards', 'Zoey Samara');

implementation

end.
 