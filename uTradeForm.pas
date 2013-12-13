unit uTradeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TfrmTrade = class(TForm)
    Image1: TImage;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    btnTrade: TButton;
    Image2: TImage;
    Image3: TImage;
    procedure btnTradeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrade: TfrmTrade;

implementation

{$R *.dfm}

procedure TfrmTrade.btnTradeClick(Sender: TObject);
begin
  if not RadioButton1.Checked and not RadioButton2.Checked and not RadioButton3.Checked then
    ShowMessage('Na ah!')
  else
    Close;
end;

end.
