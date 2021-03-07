unit uEncounterInquiryForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEncounterInquiryForm = class(TForm)
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Button1: TButton;
    RadioButton4: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Choise2(act1: string; act2: string);
    procedure Choise3(act1: string; act2: string; act3: string);
    procedure Choise4(act1: string; act2: string; act3: string; act4: string);
  end;

var
  EncounterInquiryForm: TEncounterInquiryForm;

implementation

{$R *.dfm}

procedure TEncounterInquiryForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TEncounterInquiryForm.FormShow(Sender: TObject);
begin
  //ChoiseForm.Tag := 0;
  RadioButton1.Checked := False;
  RadioButton2.Checked := False;
  RadioButton3.Checked := False;
  RadioButton4.Checked := False;

end;

procedure TEncounterInquiryForm.RadioButton1Click(Sender: TObject);
begin
  EncounterInquiryForm.Tag := 1;
end;

procedure TEncounterInquiryForm.RadioButton2Click(Sender: TObject);
begin
  EncounterInquiryForm.Tag := 2;
end;

procedure TEncounterInquiryForm.RadioButton3Click(Sender: TObject);
begin
  EncounterInquiryForm.Tag := 3;
end;

procedure TEncounterInquiryForm.Choise2(act1: string; act2: string);
begin
   RadioButton1.Caption := act1;
   RadioButton2.Caption := act2;
   RadioButton3.Visible := False;
end;

procedure TEncounterInquiryForm.Choise3(act1: string; act2: string; act3: string);
begin
   RadioButton3.Visible := True;
   RadioButton1.Caption := act1;
   RadioButton2.Caption := act2;
   RadioButton3.Caption := act3;
end;

procedure TEncounterInquiryForm.Choise4(act1: string; act2: string; act3: string; act4: string);
begin
   RadioButton4.Visible := True;
   RadioButton1.Caption := act1;
   RadioButton2.Caption := act2;
   RadioButton3.Caption := act3;
   RadioButton4.Caption := act4;
end;

procedure TEncounterInquiryForm.RadioButton4Click(Sender: TObject);
begin
  EncounterInquiryForm.Tag := 4;
end;

end.
