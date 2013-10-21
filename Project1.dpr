program Project1;

uses
  Forms,
  MainForm in 'MainForm.pas' {Main_frm},
  Unit2 in 'Unit2.pas' {Form2},
  Player in 'Player.pas',
  Card_deck in 'Card_deck.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain_frm, Main_frm);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
