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
  PH_OTHER_WORLDS_ENCOUNTER = 4;
  PH_MYTHOS = 5;
  // Константы Типов Карт
  CT_WEAPON = 9; // Оружие
  CT_TOME = 10; // Книга
  CT_SPELL = 3; // Заклинание
  CT_SKILL = 4; // Навык
  CT_ALLY = 7; // Союзник
  CT_MYTHOS = 8; // Миф
  CT_COMMON_ITEM = 1; // Простые предметы (первая цифра в ID)
  CT_UNIQUE_ITEM = 2; // Уникальные предметы (первая цифра в ID)
  CT_ENCOUNTER = 6; // Контакт (первая цифра в ID)
  CT_OW_ENCOUNTER = 7; // Контакт иного мира (первая цифра в ID)
  CT_INVESTIGATOR = 9;
  COMMON_ITEM_WEAPON = 1; // Оружие
  COMMON_ITEM_TOME = 2; // Книга
  GT_CIRCLE = 1;
  GT_CRESCENT = 2;
  GT_DIAMOND = 3;
  GT_HEXAGON = 4;
  GT_PLUS = 5;
  GT_SLASH = 6;
  GT_SQUARE = 7;
  GT_STAR = 8;
  GT_TRIANGLE = 9;

  // Константы Действий
  AT_SPEC = 2;
  AT_WATCH_BUY = 3;

  // Константы для формы торговли
  TR_TAKE_ITEMS = 1;
  TR_TAKE_REST_DISCARD = 2;
  TR_BUY_NOM_PRICE = 3;
  TR_BUY_ONE_ABOVE = 4;
  TR_BUY_ONE_BELOW = 5;
  TR_TAKE_FIRST = 6;
  TR_TAKE_COMMON_TOME = 7;
  TR_TAKE_UNIQUE_OTEM = 8;
  TR_BUY_ANY_ONE_ABOVE = 9;
  TR_BUY_ANY_ONE_BELOW = 10;

  // Основные константы
  NUMBER_OF_STREETS = 19;
  NUMBER_OF_LOCATIONS = 57;
  NUMBER_OF_COMMON_CARDS = 59;
  NUMBER_OF_UNIQUE_CARDS = 83;
  NUMBER_OF_ENCOUNTER_CARDS = 20;
  NUMBER_OF_OW_ENCOUNTER_CARDS = 50;
  NUMBER_OF_MYTHOS_CARDS = 30;
  NUMBER_OF_INVESTIGATORS = 49;
  //LOCATION_CARD_NUMBER = 20; // Число карт на каждую локацию
  //COMMON_ITEMS_CARD_NUMBER = 30;
  //
  //MYTHOS_CARDS_NUMBER = 30;
  MAX_PLAYER_ITEMS = 20;
  MONSTER_MAX = 50;
  ALLIES_MAX = 50;
  //COMMON_ITEMS_MAX = 100;
  aStats: array [1..6] of string = ('Скорость', 'Скрытность', 'Битва', 'Воля', 'Знание', 'Удача');
  aPhasesNames: array [1..5] of string = ('UPKEEP', 'MOVE', 'ENCOUNTER', 'OTHER WORLDS ENCOUNTER', 'MYTHOS');
  aNeighborhoodsNames: array [1..NUMBER_OF_STREETS, 1..2] of string = (
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
  aLocationsNames: array [1..NUMBER_OF_LOCATIONS, 1..2] of string = (
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
        ('8100', 'Historical Society'),
        ('2300', 'Independence Square'),
        ('6200', 'Inner Sanctum'),
        ('011', 'Innsmouth Jail'),
        ('011', 'Jail Cell'),
        ('7200', 'Library'),
        ('8200', 'Ma''s Boarding House'),
        ('011', 'Marsh Refinery'),
        ('011', 'Neil''s Curiosity Shop'),
        ('1200', 'Newspaper'),
        ('011', 'North Point Lighthouse'),
        ('3200', 'Police Station'),
        ('5100', 'River Docks'),
        ('7300', 'Science Building'),
        ('6100', 'Silver Twilight Lodge'),
        ('8300', 'South Church'),
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

    aCommon_Items: array [1..NUMBER_OF_COMMON_CARDS, 1..2] of string = (
        ('1012', '.18 Derringer'),
        ('1022', '.38 Revolver'),
        ('1032', '.45 Automatic'),
        ('1042', '.357 Magnum'),
        ('1052', 'Ancient Tome'),
        ('1062', 'Athame'),
        ('1072', 'Axe'),
        ('1082', 'Brass Knuckles'),
        ('1092', 'Bullwhip'),
        ('1102', 'Carbine Rifle'),
        ('1112', 'Cavalry Saber'),
        ('1121', 'Courier Run'),
        ('1132', 'Cross'),
        ('1142', 'Crowbar'),
        ('1152', 'Dark Cloak'),
        ('1162', 'Director''s Diary'),
        ('1172', 'Dusty Manuscripts'),
        ('1182', 'Динамит'),
        ('1192', 'Elephant Gun'),
        ('1201', 'Fine Clothing'),
        ('1212', 'z'),
        ('1222', 'Flare Gun'),
        ('1232', 'Еда'),
        ('1241', 'Еда'),
        ('1251', 'Genealogy Research'),
        ('1261', 'Gray''s Anatomy'),
        ('1271', 'Hand Camera'),
        ('1282', 'Handcuffs'),
        ('1292', 'Kerosene'),
        ('1301', 'King James Bible'),
        ('1312', 'Knife'),
        ('1322', 'Lantern'),
        ('1332', 'Ley Line Map'),
        ('1342', 'Lucky Cigarette Case'),
        ('1351', 'Lucky Rabbit''s Foot'),
        ('1362', 'Magnifying Glass'),
        ('1372', 'Makeup Kit'),
        ('1382', 'Map of Arkham'),
        ('1391', 'Military Motorcycle'),
        ('1401', 'Mineralogy Report'),
        ('1412', 'Molotov Cocktail'),
        ('1422', 'Motorcycle'),
        ('1432', 'Newspaper Assignment'),
        ('1442', 'Old Journal'),
        ('1451', 'Patrolling the Streets'),
        ('1462', 'Press Pass'),
        ('1472', 'Материалы следствия'),
        ('1482', 'Rifle'),
        ('1493', 'Safety Deposit Key'),
        ('1502', 'Sedanette'),
        ('1512', 'Дробовик'),
        ('1522', 'Sledgehammer'),
        ('1532', 'Student Newspaper'),
        ('1542', 'Telescope'),
        ('1553', 'Time Bomb'),
        ('1562', 'Tommy Gun'),
        ('1573', 'Understudy''s Script'),
        ('1582', 'Виски'),
        ('1591', 'Виски'));

    aUnique_Items: array [1..NUMBER_OF_UNIQUE_CARDS, 1..2] of string = (
        ('2011', 'Alien Device'),
        ('2021', 'Alien Statue'),
        ('2032', 'Ancient Spear'),
        ('2041', 'Ancient Tablet'),
        ('2051', 'Astral Mirror'),
        ('2061', 'Blue Watcher of the Pyramid'),
        ('2071', 'Book of Dzyan'),
        ('2082', 'Book of the Believer'),
        ('2091', 'Brazier of Souls'),
        ('2102', 'Cabala of Saboth'),
        ('2111', 'Camilla''s Ruby'),
        ('2121', 'Carcosan Page'),
        ('2131', 'Cryptozoology Collection'),
        ('2144', 'Crystal of the Elder Things'),
        ('2152', 'Cultes des Goules'),
        ('2161', 'Cursed Sphere'),
        ('2171', 'De Vermiis Mysteriis'),
        ('2181', 'Dhol Chants'),
        ('2191', 'Dragon''s Eye'),
        ('2201', 'Elder Sign'),
        ('2211', 'Elder Sign'),
        ('2221', 'Elder Sign Pendant'),
        ('2231', 'Elixir of Life'),
        ('2241', 'Eltdown Shards'),
        ('2251', 'Enchanted Blade'),
        ('2261', 'Enchanted Cane'),
        ('2271', 'Enchanted Jewelry'),
        ('2281', 'Enchanted Knife'),
        ('2291', 'Fetch Stick'),
        ('2301', 'Fire of Asshurbanipal'),
        ('2311', 'Flute of the Outer Gods'),
        ('2321', 'For the Greater Good'),
        ('2331', 'Gate Box'),
        ('2341', 'Gladius of Carcosa'),
        ('2351', 'Glass of Mortlan'),
        ('2361', 'Golden Sword of Y''ha-Talla'),
        ('2371', 'Golden Trumpet'),
        ('2381', 'Gruesome Talisman'),
        ('2391', 'Healing Stone'),
        ('2401', 'Illuminated Manuscript'),
        ('2411', 'Святая вода (Holy Water)'),
        ('2421', 'Joining the Winning Team'),
        ('2431', 'Key of Tawil At''Umr'),
        ('2441', 'Lamp of Alhazred'),
        ('2451', 'Lightning Gun'),
        ('2461', 'Livre d''Ivon'),
        ('2471', 'Map of the Mind'),
        ('2481', 'Masquerade of Night'),
        ('2491', 'Massa di Requiem per Shuggay'),
        ('2501', 'Mi-Go Brain Case'),
        ('2511', 'Milk of Shub-Niggurath'),
        ('2521', 'Naacal Key'),
        ('2531', 'Nameless Cults'),
        ('2541', 'Necronomicon'),
        ('2551', 'Obsidian Statue'),
        ('2561', 'Pallid Mask'),
        ('2571', 'Petrifying Solution'),
        ('2581', 'Powder of Ibn-Ghazi'),
        ('2591', 'Purifying The Town'),
        ('2601', 'Puzzle Box'),
        ('2611', 'Ritual Blade'),
        ('2621', 'Ritual Candles'),
        ('2631', 'Ruby of R''lyeh'),
        ('2641', 'Sacrifices to Make'),
        ('2651', 'Sealing The Beast''s Power'),
        ('2661', 'Seeker of the Yellow Sign'),
        ('2671', 'Seven Cryptical Books of Hsan'),
        ('2681', 'Shrine to an Elder God'),
        ('2691', 'Silver Key'),
        ('2701', 'Soul Gem'),
        ('2711', 'Staff of the Pharaoh'),
        ('2721', 'Sword of Glory'),
        ('2731', 'The King in Yellow'),
        ('2741', 'The Light of Reason'),
        ('2751', 'Throne of Carcosa'),
        ('2761', 'True Magick'),
        ('2771', 'Walking the Ley Lines'),
        ('2781', 'Warding of the Yellow Sign'),
        ('2791', 'Warding Statue'),
        ('2801', 'Warning Mirror'),
        ('2811', 'Wave of Destruction'),
        ('2821', 'Yithian Rifle'),
        ('2831', 'Zanthu Tablets'));

  crd_ally: array [1..1] of string = ('Anna Kaslow');
  aInvestigators: array [1..NUMBER_OF_INVESTIGATORS] of string = ('Agnes Baker', 'Akachi Onyele',
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
  TGate = record
    other_world: Integer;
    modif: integer;
    dimension: Integer;
  end;

  function hon(num: integer): integer; // hundredth of number
  function ton(num: integer): integer; // thousandth of number

implementation

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

end.
