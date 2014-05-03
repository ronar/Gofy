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
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnTradeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrade: TfrmTrade;

  procedure OpenTrdFrm(crd1, crd2, crd3: integer; available_to_buy: Integer; amt_of_cards: integer );

implementation

{$R *.dfm}

procedure OpenTrdFrm(crd1, crd2, crd3: integer; available_to_buy: Integer; amt_of_cards: integer);
begin
  if available_to_buy > 1 then
  begin
    frmTrade.CheckBox1.Visible := True;
    frmTrade.CheckBox2.Visible := True;
    frmTrade.CheckBox3.Visible := True;
  end
  else
  begin
    frmTrade.RadioButton1.Visible := True;
    frmTrade.RadioButton2.Visible := True;
    frmTrade.RadioButton3.Visible := True;
  end;
  frmTrade.Label1.Caption := IntToStr(crd1);
  frmTrade.Label2.Caption := IntToStr(crd2);
  frmTrade.Label3.Caption := IntToStr(crd3);

end;

procedure TfrmTrade.btnTradeClick(Sender: TObject);
begin
  if not RadioButton1.Checked and not RadioButton2.Checked and not RadioButton3.Checked then
    ShowMessage('Na ah!')
  else
    Close;
end;

end.

