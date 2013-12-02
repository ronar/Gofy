unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    btn1: TButton;
    Edit1: TEdit;
    cbb1: TComboBox;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses uMainForm;

{$R *.dfm}

procedure TForm2.btn1Click(Sender: TObject);
begin

  gPlayer.Location := StrToInt(Edit1.Text);
  Close;
  //gPlayer.Encounter;
end;

end.
