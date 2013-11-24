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

end.
