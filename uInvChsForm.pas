unit uInvChsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TInvFrm = class(TForm)
    ComboBox1: TComboBox;
    Image1: TImage;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvFrm: TInvFrm;
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

{$R *.dfm}

procedure TInvFrm.FormShow(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 49 do
  begin
    ComboBox1.Items.Add(investigators[i]);
  end;
end;

procedure TInvFrm.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
