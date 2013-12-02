unit Choise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TChoiseForm = class(TForm)
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Choise1(act: integer; act2: integer);
    procedure Choise2(act: integer; act2: integer; act3: integer);
  end;

var
  ChoiseForm: TChoiseForm;
  actions: array [1..51] of string = ('Ничего', 'Получить $', 'Потерять $', 'Получить тело',
   'Получить разум', 'Потерять тело', 'Потерять разум', 'Взять улику', 'Потерять улик',
   'Взять простой предмет', 'Взять уник. предмет', 'Взять закл.', 'Взять навык',
   'Взять карту союзника, если доступна', 'Взять карту спутника', 'Сбросить простую вещь',
   'Сбросить уник. вещь', 'Сбросить улики', 'Сбросить заклинания', 'Сбросить навык',
   'Иди на улицу', 'Взят в полицию', 'Благословлен', 'Проклят', 'Посм. карты простых вещей (кол-во)',
   'Посм. карты уник. вещей (кол-во)', 'Купить любые из вытянутых на 1 $ дороже',
   'Вытянуть простую вещь', 'Вытянуть уник. вещь', 'Купить на 1 дешевле', 'Купить любую прост. вещь',
   'Купить любую уник. вещь', 'Взять простую вещь (ID)', 'Перейти на любую локацию, контакт',
   'Перейти на любую улицу, контакт', 'Затянуло во врата', 'Появился монстр', 'Вытянуть карту мифа и идти к вратам',
   'Выполнить др. условие', 'Комбинир. условие', 'Контакт', 'спец карта', 'пермещение  конт',
   'б т д в', 'Сброс', 'сброс 2 (конк)', 'брос куб(+/-)', 'комбо нр мр', 'миф перем',
   'хп    мп', 'д п у н з с');

implementation

{$R *.dfm}

procedure TChoiseForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TChoiseForm.FormShow(Sender: TObject);
begin
  //ChoiseForm.Tag := 0;
end;

procedure TChoiseForm.RadioButton1Click(Sender: TObject);
begin
  ChoiseForm.Tag := 1;
end;

procedure TChoiseForm.RadioButton2Click(Sender: TObject);
begin
  ChoiseForm.Tag := 2;
end;

procedure TChoiseForm.RadioButton3Click(Sender: TObject);
begin
  ChoiseForm.Tag := 3;
end;

procedure TChoiseForm.Choise1(act: integer; act2: integer);
begin
   RadioButton1.Caption := actions[act];
   RadioButton2.Caption := actions[act2];
end;

procedure TChoiseForm.Choise2(act: integer; act2: integer; act3: integer);
begin
   RadioButton1.Caption := actions[act];
   RadioButton2.Caption := actions[act2];
   RadioButton3.Caption := actions[act3];
end;

end.
