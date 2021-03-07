unit uCardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TCardForm = class(TForm)
    Image1: TImage;
    cbCard: TComboBox;
    lbCard: TLabel;
    btnTake: TButton;
    procedure btnTakeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbCardChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CardForm: TCardForm;
  card_to_load: integer;

implementation

uses uMainForm, uCommon;

{$R *.dfm}

procedure TCardForm.btnTakeClick(Sender: TObject);
begin
  if cbCard.ItemIndex = -1 then
    ShowMessage('Please choose a card.')
  else
    Close;
end;

procedure TCardForm.FormShow(Sender: TObject);
var
  i: integer;
begin
  cbCard.Clear;
  case card_to_load of
  CT_COMMON_ITEM: for i := 1 to gCurrentPlayer.ItemsCount do cbCard.Items.Add(IntToStr(gCurrentPlayer.Cards[i]));
  //CT_UNIQUE_ITEM: for i := 1 to Unique_Items_Count do cbCard.Items.Add(IntToStr(Unique_Items_Deck.card[i]));
  //CT_SPELL: for i := 1 to Spells_Count do cbCard.Items.Add(IntToStr(Spells_Deck.card[i]));
  //CT_SKILL: for i := 1 to Skills_Count do cbCard.Items.Add(IntToStr(Skills_Deck.card[i]));
  end;
end;

procedure TCardForm.cbCardChange(Sender: TObject);
begin
  case card_to_load of
  CT_COMMON_ITEM: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\CommonItems\' + cbCard.Text + '.jpg');
  CT_UNIQUE_ITEM: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\UniqueItems\' + cbCard.Text + '.jpg');
  CT_SPELL: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\Spells\' + cbCard.Text + '.jpg');
  CT_SKILL: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\Skills\' + cbCard.Text + '.jpg');
  end;
end;

end.
