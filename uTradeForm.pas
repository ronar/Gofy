unit uTradeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, uCommon, uMainForm;

type
  TfrmTrade = class(TForm)
    Image1: TImage;
    btnTrade: TButton;
    Image2: TImage;
    Image3: TImage;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    procedure btnTradeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrade: TfrmTrade;
  crds: array [1..3] of integer;
  gAvailable_to_buy: integer;
  gHow: integer;

  procedure Trade(how: Integer; what: integer; how_many: integer);
  procedure Reset_ChkBoxes;
  function BuyItems(): boolean;

implementation

uses uCardDeck;

{$R *.dfm}

procedure Trade(how: Integer; what: integer; how_many: integer);
var
  i: integer;
begin
  //gAvailable_to_buy := available_to_buy;
  gHow := how;
  case how of
    TR_TAKE_ITEMS: begin
      case what of
        CT_COMMON_ITEM: begin

          frmTrade.lbl2.Caption := 'Взять простую вещь (' + IntToStr(how_many) + ')';
          Reset_ChkBoxes;
          for i := 1 to how_many do
          begin
            crds[i] := Common_Items_Deck.DrawCard;
            //(frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).Tag := crds[i];
            (frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + IntToStr(crds[i]) + '.jpg');
          end;
        end;
        CT_UNIQUE_ITEM: begin
          frmTrade.lbl2.Caption := 'Взять уникальную вещь (' + IntToStr(how_many) + ')';
        end;
        CT_SPELL: begin
          frmTrade.lbl2.Caption := 'Взять заклинание (' + IntToStr(how_many) + ')';
        end;
        CT_SKILL: begin
          frmTrade.lbl2.Caption := 'Взять умение (' + IntToStr(how_many) + ')';
        end;
        CT_WEAPON: begin
          frmTrade.lbl2.Caption := 'Взять первое попавшееся оружие';
          Reset_ChkBoxes;
          gAvailable_to_buy := 1;
          crds[1] := Common_Items_Deck.DrawWeaponCard;
          if crds[1] <> 0 then
            (frmTrade.FindComponent('Image1') as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + IntToStr(crds[1]) + '.jpg');
        end;
        CT_TOME: begin

        end;
        CT_ALLY: begin

        end;
        CT_MYTHOS: begin

        end;

      end;
    end;
    TR_TAKE_REST_DISCARD: ;
    TR_BUY_NOM_PRICE: begin
      case what of
        CT_COMMON_ITEM: begin
          frmTrade.lbl2.Caption := 'Купить простую вещь по номинальной цене (' + IntToStr(how_many) + ')';
          Reset_ChkBoxes;
          gavailable_to_buy := 1;
          for i := 1 to how_many do
          begin
            crds[i] := Common_Items_Deck.DrawCard;
            (frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + IntToStr(crds[i]) + '.jpg');
          end;
        end; //CT_COMMON_ITEM
      end; // case
    end;
    TR_BUY_ONE_ABOVE: begin
      case what of
        CT_COMMON_ITEM: begin
          frmTrade.lbl2.Caption := 'Купить простую вещь по цене на 1$ выше номинальной цены (' + IntToStr(how_many) + ')';
          Reset_ChkBoxes;
          gavailable_to_buy := 1;
          for i := 1 to how_many do
          begin
            crds[i] := Common_Items_Deck.DrawCard;
            (frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + IntToStr(crds[i]) + '.jpg');
          end;
        end; //CT_COMMON_ITEM
      end; // case

    end;
    TR_BUY_ONE_BELOW: begin
      case what of
        CT_COMMON_ITEM: begin
          frmTrade.lbl2.Caption := 'Купить простую вещь по цене на 1$ ниже номинальной цены (' + IntToStr(how_many) + ')';
          Reset_ChkBoxes;
          gavailable_to_buy := 1;
          for i := 1 to how_many do
          begin
            crds[i] := Common_Items_Deck.DrawCard;
            (frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + IntToStr(crds[i]) + '.jpg');
          end;
        end; //CT_COMMON_ITEM
      end; // case

    end;
    TR_BUY_ANY_ONE_ABOVE: begin
      case what of
        CT_COMMON_ITEM: begin
          frmTrade.lbl2.Caption := 'Купить простые вещь по цене на 1$ выше номинальной цены, любые или все';
          Reset_ChkBoxes;
          gavailable_to_buy := 3;
          for i := 1 to how_many do
          begin
            crds[i] := Common_Items_Deck.DrawCard;
            //(frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).tag := crds[i];
            (frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + IntToStr(crds[i]) + '.jpg');
          end;
        end; //CT_COMMON_ITEM
      end; // case
    end;
    TR_BUY_ANY_ONE_BELOW: begin
      case what of
        CT_COMMON_ITEM: begin
          frmTrade.lbl2.Caption := 'Купить простые вещь по цене на 1$ ниже номинальной цены, любые или все';
          Reset_ChkBoxes;
          gavailable_to_buy := 3;
          for i := 1 to how_many do
          begin
            crds[i] := Common_Items_Deck.DrawCard;
            (frmTrade.FindComponent('Image' + IntToStr(i)) as TImage).Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CardsData\CommonItems\' + IntToStr(crds[i]) + '.jpg');
          end;
        end; //CT_COMMON_ITEM
      end; // case
    end;
    TR_TAKE_FIRST: ;
    TR_TAKE_COMMON_TOME: ;
    TR_TAKE_UNIQUE_OTEM: ;
  end;
  frmTrade.ShowModal;
end;

procedure Reset_ChkBoxes;
begin
  frmTrade.CheckBox1.Checked := False;
  frmTrade.CheckBox2.Checked := False;
  frmTrade.CheckBox3.Checked := False;
end;

function BuyItems(): boolean;
var
  price: integer;
begin
  result := false;
  with frmTrade do
  begin
    if not CheckBox1.Checked and not CheckBox2.Checked and not CheckBox3.Checked then
    begin
      Result := True;
      exit;
    end
    else
    begin
      if gAvailable_to_buy = 1 then
      begin
        if CheckBox1.Checked then
        begin
          if CheckBox2.Checked or CheckBox3.Checked then
          begin
            ShowMessage('Выбрано неправильное количество!');
            Exit;
          end;
        end
        else
          if CheckBox2.Checked then
          begin
            if CheckBox1.Checked or CheckBox3.Checked then
            begin
              ShowMessage('Выбрано неправильное количество!');
              Exit;
            end;
          end;
      end;
    end;

    if crds[1] <> 0 then
    begin
      price := Common_Items_Deck.GetCardByID(crds[1]).price;
      if CheckBox1.Checked then
      begin
        if (gHow = TR_TAKE_ITEMS) or (gHow = TR_TAKE_REST_DISCARD) then
        begin
          gCurrentPlayer.AddItem(Common_Items_Deck, crds[1]);
          frmMain.lstLog.Items.Add('Игрок получил карту: ' + GetCommonItemNamebyId(crds[1]));
        end
        else
        begin
          if gCurrentPlayer.Money >= price then
          begin
            gCurrentPlayer.AddItem(Common_Items_Deck, crds[1]);
            gCurrentPlayer.Money := gCurrentPlayer.Money - price;
            frmMain.lstLog.Items.Add('Игрок купил карту: ' + GetCommonItemNamebyId(crds[1]));
            result := true;
          end
          else
          begin
            ShowMessage('Не хватает денег!');
            Exit;
          end;
        end;
      end;
    end;

    if crds[2] <> 0 then
    begin
      price := Common_Items_Deck.GetCardByID(crds[2]).price;
      if CheckBox2.Checked then
      begin
        if (gHow = TR_TAKE_ITEMS) or (gHow = TR_TAKE_REST_DISCARD) then
        begin
          gCurrentPlayer.AddItem(Common_Items_Deck, crds[2]);
          frmMain.lstLog.Items.Add('Игрок получил карту: ' + GetCommonItemNamebyId(crds[2]));
        end
        else
        begin
          if gCurrentPlayer.Money >= price then
          begin
            gCurrentPlayer.AddItem(Common_Items_Deck, crds[2]);
            gCurrentPlayer.Money := gCurrentPlayer.Money - price;
            frmMain.lstLog.Items.Add('Игрок купил карту: ' + GetCommonItemNamebyId(crds[2]));
            result := true;
          end
          else
          begin
            ShowMessage('Не хватает денег!');
            Exit;
          end;
        end;
      end;
    end;

    if crds[3] <> 0 then
    begin
      price := Common_Items_Deck.GetCardByID(crds[3]).price;
      if CheckBox3.Checked then
      begin
        if (gHow = TR_TAKE_ITEMS) or (gHow = TR_TAKE_REST_DISCARD) then
        begin
          gCurrentPlayer.AddItem(Common_Items_Deck, crds[3]);
          frmMain.lstLog.Items.Add('Игрок получил карту: ' + GetCommonItemNamebyId(crds[3]));
        end
        else
        begin
          if gCurrentPlayer.Money >= price then
          begin
            gCurrentPlayer.AddItem(Common_Items_Deck, crds[3]);
            gCurrentPlayer.Money := gCurrentPlayer.Money - price;
            frmMain.lstLog.Items.Add('Игрок купил карту: ' + GetCommonItemNamebyId(crds[3]));
            result := true;
          end
          else
          begin
            ShowMessage('Не хватает денег!');
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmTrade.btnTradeClick(Sender: TObject);

begin
  if BuyItems then
    Close;

end;

end.

