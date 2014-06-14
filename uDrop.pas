unit uDrop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, uPlayer;

type
  TfrmDrop = class(TForm)
    img1: TImage;
    lbl1: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDrop: TfrmDrop;
  n, dropped: integer;
  cur_crd: Integer;
  pl_cards: array [1..20] of Integer;

  procedure PrepareCardsToDrop(pl: TPlayer; amt: integer);
  procedure ShowCard(indx: integer);

implementation

uses
  uCardDeck, uCommon, uMainForm;

{$R *.dfm}

procedure PrepareCardsToDrop(pl: TPlayer; amt: integer);
var
  i: Integer;
begin
  cur_crd := 1;
  n := amt;
  dropped := 0;

  for i := 1 to 20 do
  begin
    pl_cards[i] := pl.Cards[i];
  end;

  showCard(1);

  //img1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\CommonItems\' + cbCard.Text + '.jpg');
end;

procedure ShowCard(indx: integer);
var
  file_path: string;
begin
    if (indx = 0) or (pl_cards[indx] = 0) then
    begin
      frmDrop.img1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\Spells\30.jpg');
      exit;
    end;

    if ton(pl_cards[indx]) = 1 then
      file_path := ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\';

    if ton(pl_cards[indx]) = 2 then
      file_path := ExtractFilePath(Application.ExeName) + 'CardsData\UniqueItems\';

    if ton(pl_cards[indx]) = 3 then
      file_path := ExtractFilePath(Application.ExeName) + 'CardsData\Spells\';

    if ton(pl_cards[indx]) = 4 then
      file_path := ExtractFilePath(Application.ExeName) + 'CardsData\Skills\';

  frmDrop.img1.Picture.LoadFromFile(file_path + IntToStr(pl_cards[indx]) + '.jpg');
end;

procedure TfrmDrop.btn1Click(Sender: TObject);
begin
  cur_crd := cur_crd - 1;
  if cur_crd < 1 then cur_crd := 1;
  ShowCard(cur_crd);
end;

procedure TfrmDrop.btn2Click(Sender: TObject);
begin
  cur_crd := cur_crd + 1;
  if cur_crd > 20 then cur_crd := 20;
  ShowCard(cur_crd);
end;

procedure TfrmDrop.btn3Click(Sender: TObject);
var
  i: Integer;
begin
  if pl_cards[cur_crd] = 0 then Exit;
  gCurrentPlayer.DropCard(cur_crd);
  pl_cards[cur_crd] := 0;
  //pl_cards := gCurrentPlayer.Cards;

  for i := 1 to 20 do
  begin
    pl_cards[i] := gCurrentPlayer.Cards[i];
  end;
  cur_crd := 1;
  ShowCard(cur_crd);
  dropped := dropped + 1;
  if dropped = n then
  begin
    close;
  end;
end;

end.
