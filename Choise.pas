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
    RadioButton4: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Choise2(act1: string; act2: string);
    procedure Choise3(act1: string; act2: string; act3: string);
    procedure Choise4(act1: string; act2: string; act3: string; act4: string);
  end;

var
  ChoiseForm: TChoiseForm;

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

procedure TChoiseForm.Choise2(act1: string; act2: string);
begin
   RadioButton1.Caption := act1;
   RadioButton2.Caption := act2;
   RadioButton3.Visible := False;
end;

procedure TChoiseForm.Choise3(act1: string; act2: string; act3: string);
begin
   RadioButton3.Visible := True;
   RadioButton1.Caption := act1;
   RadioButton2.Caption := act2;
   RadioButton3.Caption := act3;
end;

procedure TChoiseForm.Choise4(act1: string; act2: string; act3: string; act4: string);
begin
   RadioButton4.Visible := True;
   RadioButton1.Caption := act1;
   RadioButton2.Caption := act2;
   RadioButton3.Caption := act3;
   RadioButton4.Caption := act4;
end;

procedure TChoiseForm.RadioButton4Click(Sender: TObject);
begin
  ChoiseForm.Tag := 4;
end;

end.
