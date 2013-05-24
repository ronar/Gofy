unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Jpeg, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    lblPlrStamina: TLabel;
    Label1: TLabel;
    lblPlrSanity: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblPlrFocus: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Label7: TLabel;
    TabControl1: TTabControl;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label3: TLabel;
    lblPrm2: TLabel;
    lblPrm3: TLabel;
    Label6: TLabel;
    lblPrm4: TLabel;
    Label8: TLabel;
    lblPrm5: TLabel;
    Label10: TLabel;
    lblPrm6: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lblPrm1: TLabel;
    lblCardData: TLabel;
    ComboBox1: TComboBox;
    Button4: TButton;
    Button5: TButton;
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  // ��������� ���
  PH_PEREDISHKA = 1;
  PH_DVIJENIE = 2;
  PH_KONTAKTI_V_ARKHEME = 3;
  PH_KONTAKTI_V_INIH_MIRAH = 4;
  PH_MIF = 5;
  // ��������� ����� ����
  CT_DEJSTVIE = 6;
  CT_KONTAKT = 7;
  CT_MYTHOS = 8; // ���
  CT_HEADLINE = 9; // ����
  CT_COMMON_ITEM = 1; // ������� �������� (������ ����� � ID)
  // ��������� ��������
  AT_SPEC = 2;
  AT_WATCH_BUY = 3;

type
  TCard = class(TObject) // �����
  private
    Card_ID: integer;
    Card_Type: integer; // ��� ����� (����, ���, ������� � �.�.)
    Card_Data: string; // ������ � ������� � ����� � ����������� �� ����
                       // "�����", ��� ������ � ������ ����� ������� Dejstvie_karti
    function GetLokation: integer;
    function GetNom: integer;
    //procedure SetLok;
  public
    function Get_Card_ID: integer;
    property Lokaciya: integer read GetLokation; // ������� ����� (��������)
    //property Nom: integer;
    procedure Dejstvie_karti; // ���������� ����������� �������� �����
    procedure Shuffle();
  end;

  TPlayer = class(TObject)
  private
    Sanity: integer;
    Stamina: integer;
    Focus: integer;
    Cards: array [1..100] of integer; // �������� ������
    Items_Count: integer; // ���-�� ��������� � ������
    bFirst_Player: boolean; // ���� ������� ������
  public
    constructor Create(First_Player: boolean);
    procedure Draw_Card(Card_ID: integer);
    function Get_Items_Count(): integer;
    function Get_Sanity(): integer;
    function Get_Stamina(): integer;
    function Get_Focus: integer;
    function Get_Item(indx: integer): integer;
  end;

var
  Form1: TForm1;
  Current_phase: integer;
  Cards0, Cards1: array [1..100] of TCard; // ������� ����
  Common_Items_Deck: array [1..100] of TCard;
  gPlayer: TPlayer;
  function Load_Card(Card_Type: integer; Card_Num: integer): TCard;

implementation

{$R *.dfm}

// ����������� ������
constructor TPlayer.Create(First_Player: boolean);
var
  i: integer;
begin
  Stamina := 0;
  Sanity := 0;
  Focus := 0;
  //SetLength(Cards, 0);
  for i := 1 to 100 do
    Cards[i] := 0;
  bFirst_Player := False;
  Items_Count := 0;
end;

// �������: ������ ����� �� ������
procedure TPlayer.Draw_Card(Card_ID: integer);
begin
  Items_Count := Items_Count + 1;
  //SetLength(Cards, Items_Count);
  Cards[Items_Count] := Card_ID;
end;

// �������: ��������� ���-�� ��������� � ������
function TPlayer.Get_Items_Count;
begin
  Get_Items_Count := Items_Count;
end;

// �������: ��������� �������� "����" ������
function TPlayer.Get_Stamina;
begin
  Get_Stamina := Stamina;
end;

// �������: ��������� �������� "������" ������
function TPlayer.Get_Sanity;
begin
  Get_Sanity := Sanity;
end;

// �������: ��������� �������� "�����������" ������
function TPlayer.Get_Focus;
begin
  Get_Focus := Focus;
end;

// �������: ��������� �������� �� �������.
// ������� �������� �� ������, � �� ��������
function TPlayer.Get_Item(indx: integer): integer;
begin
  Get_Item := Cards[indx];
end;

// �������� ������ � ����� �� �����
function Load_Card(Card_Type: integer; Card_Num: integer): TCard;
var
  F: TextFile;
  File_Name: string;
  s: string[80];
  temp: TCard;
begin
  case Card_Type of
    CT_KONTAKT: begin
      AssignFile (F, '..\����\CardsData\'+IntToStr(Card_Num)+'.txt');
      Reset(F);
      readln(F, s);
      CloseFile(F);
      temp := TCard.Create;
      temp.Card_Data := s;
      temp.Card_Type := CT_KONTAKT;
      temp.Card_ID := StrToInt(Copy(s, 1, 3));
      Load_Card := temp;
    end;
    CT_COMMON_ITEM: begin
      if Card_Num < 10 then
        File_Name := '10'+IntToStr(Card_Num)+'2.txt'
      else
        File_Name := '1'+IntToStr(Card_Num)+'2.txt';
      try
      AssignFile (F, '..\����\CardsData\CommonItems\'+File_Name);
      Reset(F);
      readln(F, s);
      CloseFile(F);
      temp := TCard.Create;
      temp.Card_Data := s;
      temp.Card_Type := CT_COMMON_ITEM;
      temp.Card_ID := StrToInt(Copy(File_Name, 1, 4));
      Load_Card := temp;
      except
        ShowMessage('��� ����� � ������ ����� '+ File_Name + '.');
      end;
    end;
  end;

end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0
  then ShowMessage('Phase 1!');
  if RadioGroup1.ItemIndex = 1
  then ShowMessage('Phase 2!');
  if RadioGroup1.ItemIndex = 2
  then ShowMessage('Phase 3!');
  if RadioGroup1.ItemIndex = 3
  then ShowMessage('Phase 4!');
  if RadioGroup1.ItemIndex = 4
  then ShowMessage('Phase 5!');
end;

function TCard.GetLokation;
begin
  GetLokation := StrToInt(Copy(Card_Data, 0, 2));
end;

function TCard.GetNom;
begin
  GetNom := StrToInt(Copy(Card_Data, 2, 2));
end;

// ��������� ID �����
function TCard.Get_Card_ID;
begin
  Get_Card_ID := Card_ID;
end;

// ���������� �������� �����
Procedure TCard.Dejstvie_karti;
var
  Action_Type: integer;
begin
  // � ����������� �� ����
  case Card_Type of
    CT_DEJSTVIE:;
    CT_KONTAKT:
    begin
      Action_Type := StrToInt(Card_Data[4]);
      case Action_Type of
        AT_WATCH_BUY:
        begin{
          Form1.Label14.Caption := Copy(Card_Data, 1, 3);
          Form1.Label4.Caption := '�����. � �����.';
          case StrToInt(Card_Data[5]) of
            1: Form1.Label5.Caption := '������� ����';
            2: Form1.Label5.Caption := '���������� ����';
            3: Form1.Label5.Caption := '����������';
            4: Form1.Label5.Caption := '�����';
            5: Form1.Label5.Caption := '�������';
          end;
          Form1.Label7.Caption := Card_Data[6];
          Form1.Label9.Caption := Card_Data[7];
          Form1.Label11.Caption := Card_Data[8];}
        end;
        AT_SPEC:
        begin
          {Form1.Label4.Caption := '����. �����';
          case StrToInt(Card_Data[9]) of
            1: Form1.Label5.Caption := '�������';
            2: Form1.Label5.Caption := '�����. ����';
            3: Form1.Label5.Caption := '�����';
            4: Form1.Label5.Caption := '���. ������';
            5: Form1.Label5.Caption := '�����';
            6: Form1.Label5.Caption := '����';
          end;                                   }

        end;
      end;
    end;
    CT_MYTHOS:;
    CT_HEADLINE:;
    CT_COMMON_ITEM: begin
      Form1.lblPrm1.Caption := Form1.ComboBox1.Text;
      Form1.lblPrm2.Caption := Copy(Form1.ComboBox1.Text, 2, 2);
      Form1.lblPrm3.Caption := Card_Data[1];
      Form1.lblPrm4.Caption := Card_Data[4];
      //lblPrm5.Caption := Card_Data[6];
      case StrToInt(Card_Data[6]) of
        0: Form1.lblPrm5.Caption := '����';
        1: Form1.lblPrm5.Caption := '�����';
        2: Form1.lblPrm5.Caption := '���� ��������';
        3: Form1.lblPrm5.Caption := '�����';
        4: Form1.lblPrm5.Caption := '�������� �����';
      end;
      Form1.lblPrm6.Caption := Card_Data[7];
      Form1.lblCardData.Caption := Card_Data;
    end;
  end;
end;

// ������� ������
procedure TCard.Shuffle();
begin

end;

// �������������
// ����� �������������, ������ ���� ����� ���������
// � ���� ��� ����� ������������� ����
procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
begin
  // �������� ������� ������
  gPlayer := TPlayer.Create(False);
  //  TODO: ���������� ���������� ���� ���������
  // �������� ���� 3-�� ���� (��������)
  for i:= 1 to 13 do
  begin
    cards0[i] := Load_Card(CT_KONTAKT, i);
  end;

  //SetLength(Common_Items_Deck, 13);
  // �������� ���� ������� ���������
  //for i:= 1 to 100 do
  //begin
    Common_Items_Deck[1] := Load_Card(CT_COMMON_ITEM, 1);
    Common_Items_Deck[2] := Load_Card(CT_COMMON_ITEM, 2);
    Common_Items_Deck[3] := Load_Card(CT_COMMON_ITEM, 3);
    Common_Items_Deck[4] := Load_Card(CT_COMMON_ITEM, 4);
    Common_Items_Deck[5] := Load_Card(CT_COMMON_ITEM, 6);
    Common_Items_Deck[6] := Load_Card(CT_COMMON_ITEM, 7);
    Common_Items_Deck[7] := Load_Card(CT_COMMON_ITEM, 8);
    Common_Items_Deck[8] := Load_Card(CT_COMMON_ITEM, 9);
    Common_Items_Deck[9] := Load_Card(CT_COMMON_ITEM, 10);
    Common_Items_Deck[10] := Load_Card(CT_COMMON_ITEM, 11);
    Common_Items_Deck[11] := Load_Card(CT_COMMON_ITEM, 14);
    Common_Items_Deck[12] := Load_Card(CT_COMMON_ITEM, 18);
    Common_Items_Deck[13] := Load_Card(CT_COMMON_ITEM, 19);
    Common_Items_Deck[14] := Load_Card(CT_COMMON_ITEM, 21);
    Common_Items_Deck[15] := Load_Card(CT_COMMON_ITEM, 29);
    Common_Items_Deck[16] := Load_Card(CT_COMMON_ITEM, 31);
    Common_Items_Deck[17] := Load_Card(CT_COMMON_ITEM, 41);
    Common_Items_Deck[18] := Load_Card(CT_COMMON_ITEM, 48);
    Common_Items_Deck[19] := Load_Card(CT_COMMON_ITEM, 51);
    Common_Items_Deck[20] := Load_Card(CT_COMMON_ITEM, 52);
    Common_Items_Deck[21] := Load_Card(CT_COMMON_ITEM, 56);
  //end;

  // � �.�.
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i: integer;
begin
  lblPlrStamina.Caption := IntToStr(gPlayer.Get_Stamina);
  lblPlrSanity.Caption := IntToStr(gPlayer.Get_Sanity);
  lblPlrFocus.Caption := IntToStr(gPlayer.Get_Focus);
  ListBox1.Clear;
  for i := 1 to gPlayer.Get_Items_Count do
    ListBox1.Items.Add(IntToStr(gPlayer.Get_Item(i)));
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Image1.Picture.LoadFromFile('..\����\CardsData\CommonItems\'+ComboBox1.Text+'.jpg');
  Common_Items_Deck[ComboBox1.ItemIndex+1].Dejstvie_karti;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//  cards0[StrToInt(ComboBox1.Text)].Dejstvie_karti;
  if ComboBox1.ItemIndex < 1 then
    ShowMessage('�������� �����')
  else
    gPlayer.Draw_Card(StrToInt(ComboBox1.Text));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  pl: TPlayer;
begin
  //pl := TPlayer.Create(False);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gPlayer.Free;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i,r: integer;
  temp: TCard;
begin
  randomize;
  for i := 1 to 21 do
  begin
    temp := Common_Items_Deck[i];
    r := random(21);
    Common_Items_Deck[i] := Common_Items_Deck[r+1]; 
  end;
  //Common_Items_Deck.Shuffle;
end;

end.
