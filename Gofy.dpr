program Gofy;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  uLocationSelectorForm in 'uLocationSelectorForm.pas' {LocationSelectorForm},
  uPlayer in 'uPlayer.pas',
  uCardDeck in 'uCardDeck.pas',
  uCommonItemCardDeck in 'uCommonItemCardDeck.pas',
  uUniqueItemCardDeck in 'uUniqueItemCardDeck.pas',
  uEncounterInquiryForm in 'uEncounterInquiryForm.pas' {EncounterInquiryForm},
  uInvestigatorSelectorForm in 'uInvestigatorSelectorForm.pas' {InvestigatorSelectorForm},
  uCommon in 'uCommon.pas',
  uInvestigator in 'uInvestigator.pas',
  uCardForm in 'uCardForm.pas' {CardForm},
  uTradeForm in 'uTradeForm.pas' {TradeForm},
  uUseForm in 'uUseForm.pas' {UseForm},
  uMonster in 'uMonster.pas',
  uCardXML in 'uCardXML.pas',
  uMonsterForm in 'uMonsterForm.pas' {MonsterForm},
  uMythos in 'uMythos.pas',
  uStreet in 'uStreet.pas',
  uDrop in 'uDrop.pas' {DropFrom};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gofy';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInvestigatorSelectorForm, InvestigatorSelectorForm);
  Application.CreateForm(TLocationSelectorForm, LocationSelectorForm);
  Application.CreateForm(TEncounterInquiryForm, EncounterInquiryForm);
  Application.CreateForm(TCardForm, CardForm);
  Application.CreateForm(TTradeForm, TradeForm);
  Application.CreateForm(TItemUseForm, ItemUseForm);
  Application.CreateForm(TMonsterForm, MonsterForm);
  Application.CreateForm(TDropForm, DropForm);
  Application.Run;
end.
