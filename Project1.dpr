program Project1;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {Main_frm},
  Unit2 in 'Unit2.pas' {Form2},
  uPlayer in 'uPlayer.pas',
  uCardDeck in 'uCardDeck.pas',
  Choise in 'Choise.pas' {ChoiseForm},
  uInvChsForm in 'uInvChsForm.pas' {frmInv},
  uCommon in 'uCommon.pas',
  uInvestigator in 'uInvestigator.pas',
  uCardForm in 'uCardForm.pas' {frmCard},
  uTradeForm in 'uTradeForm.pas' {frmTrade};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain_frm, Main_frm);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TChoiseForm, ChoiseForm);
  Application.CreateForm(TfrmInv, frmInv);
  Application.CreateForm(TfrmCard, frmCard);
  Application.CreateForm(TfrmTrade, frmTrade);
  Application.Run;
end.
