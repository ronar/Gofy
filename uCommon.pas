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
  CT_SPELL = 3; // Заклинание
  CT_ALLY = 7; // Союзник
  CT_MYTHOS = 8; // Миф
  CT_SKILL = 4; // Навык
  CT_COMMON_ITEM = 1; // Простые предметы (первая цифра в ID)
  CT_UNIQUE_ITEM = 2; // Уникальные предметы (первая цифра в ID)
  CT_ENCOUNTER = 6; // Контакт (первая цифра в ID)
  // Константы Действий
  AT_SPEC = 2;
  AT_WATCH_BUY = 3;
  NUMBER_OF_STREETS = 19;
  NUMBER_OF_LOCATIONS = 57;
  LOCATION_CARD_NUMBER = 20; // Число карт на каждую локацию
  ITEMS_CARD_NUMBER = 30;
  MAX_PLAYER_ITEMS = 20;
  MONSTER_MAX = 50;
  ALLIES_MAX = 50;
  NeighborhoodsNames: array [1..NUMBER_OF_STREETS, 1..2] of string = (
        ('1000', 'Northside'),
        ('2000', 'Downtown'),
        ('3000', 'Easttown'),
        ('4000', 'Rivertown'),
        ('5000', 'Merchant District'),
        ('6000', 'French Hill'),
        ('7000', 'Miskatonic University'),
        ('8000', 'Southside'),
        ('9000', 'Uptown'),
        ('0000', 'Backwoods Country'),
        ('0000', 'Blasted Heath'),
        ('0000', 'Central Hill'),
        ('0000', 'Church Green'),
        ('0000', 'Factory District'),
        ('0000', 'Harborside'),
        ('0000', 'Innsmouth Shore'),
        ('0000', 'Kingsport Head'),
        ('0000', 'South Shore'),
        ('0000', 'Village Common'));
  LocationsNames: array [1..NUMBER_OF_LOCATIONS, 1..2] of string = (
        ('011', '607 Water St.'),
        ('012', '7th House on the Left'),
        ('7100', 'Administration Building'),
        ('2100', 'Arkham Asylum'),
        ('011', 'Artists'' Colony'),
        ('2200', 'Bank of Arkham'),
        ('011', 'Bishop''s Brook Bridge'),
        ('4100', 'Black Cave'),
        ('011', 'Cold Spring Glen'),
        ('011', 'Congregational Hospital'),
        ('1100', 'Curiositie Shoppe'),
        ('011', 'Darke''s Carnival'),
        ('011', 'Devil Reef'),
        ('011', 'Devil''s Hopyard'),
        ('011', 'Dunwich Village'),
        ('011', 'Esoteric Order of Dagon'),
        ('011', 'Falcon Point'),
        ('011', 'First National Grocery'),
        ('011', 'Gardners'' Place'),
        ('4200', 'General Store'),
        ('011', 'Gilman House Hotel'),
        ('4300', 'Graveyard'),
        ('011', 'Hall School'),
        ('011', 'Harney Jones'' Shack'),
        ('3100', 'Hibb''s Roadhouse'),
        ('8300', 'Historical Society'),
        ('2300', 'Independence Square'),
        ('6200', 'Inner Sanctum'),
        ('011', 'Innsmouth Jail'),
        ('011', 'Jail Cell'),
        ('7200', 'Library'),
        ('8100', 'Ma''s Boarding House'),
        ('011', 'Marsh Refinery'),
        ('011', 'Neil''s Curiosity Shop'),
        ('1200', 'Newspaper'),
        ('011', 'North Point Lighthouse'),
        ('3200', 'Police Station'),
        ('5100', 'River Docks'),
        ('7300', 'Science Building'),
        ('6100', 'Silver Twilight Lodge'),
        ('8200', 'South Church'),
        ('011', 'St. Erasmus''s Home'),
        ('9100', 'St. Mary''s Hospital'),
        ('011', 'Strange High House'),
        ('011', 'The Causeway'),
        ('011', 'The Rope and Anchor'),
        ('5200', 'The Unnamable'),
        ('6300', 'The Witch House'),
        ('1300', 'Train Station'),
        ('5300', 'Unvisited Isle'),
        ('3300', 'Velma''s Diner'),
        ('011', 'Whateley Farm'),
        ('011', 'Wireless Station'),
        ('011', 'Wizard''s Hill'),
        ('9200', 'Woods'),
        ('011', 'Y''ha-nthlei'),
        ('9300', 'Ye Olde Magick Shoppe'));
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

  MonsterNames: array [1..MONSTER_MAX, 1..2] of string = (
        ('013', 'Bayakee'),
        ('023', 'Bayakee'),
        ('033', 'Bayakee'),
        ('043', 'Bayakee'),
        ('053', 'Bayakee'),
        ('063', 'Bayakee'),
        ('073', 'Bayakee'),
        ('083', 'Bayakee'),
        ('093', 'Bayakee'),
        ('103', 'Bayakee'),
        ('112', 'Chthonian'),
        ('123', 'Bayakee'),
        ('133', 'Bayakee'),
        ('146', 'Cultist'),
        ('153', 'Bayakee'),
        ('163', 'Bayakee'),
        ('173', 'Bayakee'),
        ('183', 'Bayakee'),
        ('193', 'Bayakee'),
        ('202', 'Fire Vampire'),
        ('213', 'Bayakee'),
        ('223', 'Bayakee'),
        ('233', 'Bayakee'),
        ('243', 'Bayakee'),
        ('253', 'Bayakee'),
        ('263', 'Bayakee'),
        ('273', 'Bayakee'),
        ('282', 'Fire Vampire'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'));

  Allies: array [1..ALLIES_MAX, 1..2] of string = (
        ('013', 'Bayakee'),
        ('01', 'Bayakee'),
        ('033', 'Bayakee'),
        ('043', 'Bayakee'),
        ('053', 'Bayakee'),
        ('05', 'Bayakee'),
        ('073', 'Bayakee'),
        ('083', 'Bayakee'),
        ('093', 'Bayakee'),
        ('103', 'Bayakee'),
        ('10', 'Chthonian'),
        ('123', 'Bayakee'),
        ('133', 'Bayakee'),
        ('146', 'Cultist'),
        ('153', 'Bayakee'),
        ('15', 'Bayakee'),
        ('173', 'Bayakee'),
        ('183', 'Bayakee'),
        ('193', 'Bayakee'),
        ('202', 'Fire Vampire'),
        ('20', 'Bayakee'),
        ('223', 'Bayakee'),
        ('233', 'Bayakee'),
        ('243', 'Bayakee'),
        ('253', 'Bayakee'),
        ('25', 'Bayakee'),
        ('273', 'Bayakee'),
        ('282', 'Fire Vampire'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('30', 'Bayakee'),
        ('063', 'Bayakee'),
        ('32', 'Rayan Din'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('35', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('40', 'Bayakee'),
        ('41', 'Tom "Mountain" Murphy'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('45', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('063', 'Bayakee'),
        ('49', 'Bayakee'));
  Things: array [1..3] of string = (
        ('$'),
        ('Clue(s)'),
        ('Monster trophie(s)'));

type
  StrDataArray = array [1..10] of string;

implementation

end.
