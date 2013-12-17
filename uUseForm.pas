unit uUseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TfrmUse = class(TForm)
    Image1: TImage;
    lbCard: TLabel;
    cbCard: TComboBox;
    btnUse: TButton;
    procedure btnUseClick(Sender: TObject);
    procedure cbCardChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUse: TfrmUse;

implementation

{$R *.dfm}

procedure TfrmUse.btnUseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUse.cbCardChange(Sender: TObject);
begin
  if cbCard.Items.Count > 0 then
  begin
    case StrToInt(cbCard.text[1]) of
      1: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\CommonItems\' + cbCard.Text + '.jpg');
      2: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\UniqueItems\' + cbCard.Text + '.jpg');
      3: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\Spells\' + cbCard.Text + '.jpg');
      4: Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + '\CardsData\Skills\' + cbCard.Text + '.jpg');
    end;
  end;
end;

end.
