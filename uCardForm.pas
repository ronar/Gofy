unit uCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TfrmCard = class(TForm)
    Image1: TImage;
    cbCard: TComboBox;
    lbCard: TLabel;
    btnTake: TButton;
    procedure btnTakeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCard: TfrmCard;
  card_to_load: integer;

implementation

uses uMainForm, uCommon;

{$R *.dfm}

procedure TfrmCard.btnTakeClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCard.FormShow(Sender: TObject);
var
  i: integer;
begin
  case card_to_load of
  CT_COMMON_ITEM: for i := 1 to Common_Items_Count do cbCard.Items.Add(IntToStr(i));
  end;
end;

end.
