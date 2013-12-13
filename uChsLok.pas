unit uChsLok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmChsLok = class(TForm)
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
  frmChsLok: TfrmChsLok;

implementation

uses uMainForm;

{$R *.dfm}

procedure TfrmChsLok.btn1Click(Sender: TObject);
begin
  gPlayer.Location := StrToInt(Edit1.Text);
  Close;
  //gPlayer.Encounter;
end;

end.
