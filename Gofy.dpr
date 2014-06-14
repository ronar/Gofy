program Gofy;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {frmMain},
  uChsLok in 'uChsLok.pas' {frmChsLok},
  uPlayer in 'uPlayer.pas',
  uCardDeck in 'uCardDeck.pas',
  Choise in 'Choise.pas' {ChoiseForm},
  uInvChsForm in 'uInvChsForm.pas' {frmInv},
  uCommon in 'uCommon.pas',
  uInvestigator in 'uInvestigator.pas',
  uCardForm in 'uCardForm.pas' {frmCard},
  uTradeForm in 'uTradeForm.pas' {frmTrade},
  uUseForm in 'uUseForm.pas' {frmUse},
  uMonster in 'uMonster.pas',
  uCardXML in 'uCardXML.pas',
  uMonsterForm in 'uMonsterForm.pas' {frmMonster},
  uMythos in 'uMythos.pas',
  uStreet in 'uStreet.pas',
  uDrop in 'uDrop.pas' {frmDrop};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gofy';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmInv, frmInv);
  Application.CreateForm(TfrmChsLok, frmChsLok);
  Application.CreateForm(TChoiseForm, ChoiseForm);
  Application.CreateForm(TfrmCard, frmCard);
  Application.CreateForm(TfrmTrade, frmTrade);
  Application.CreateForm(TfrmUse, frmUse);
  Application.CreateForm(TfrmMonster, frmMonster);
  Application.CreateForm(TfrmDrop, frmDrop);
  Application.Run;
end.
