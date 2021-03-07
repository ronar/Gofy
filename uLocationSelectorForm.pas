{******************************************************************************}
{                                                                              }
{ Gofy - Arkham Horror Card Game                                               }
{                                                                              }
{ The contents of this file are subject to the Mozilla Public License Version  }
{ 1.0 (the "License"); you may not use this file except in compliance with the }
{ License. You may obtain a copy of the License at http://www.mozilla.org/MPL/ }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ The Original Code is LocationSelectorForm.pas.                               }
{                                                                              }
{ Contains dialog for selecting current in-game location.                      }
{                                                                              }
{ Unit owner:    Ronar                                                         }
{ Last modified: March 7, 2021                                                 }
{                                                                              }
{******************************************************************************}

unit uLocationSelectorForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Vcl.ExtCtrls;

type
  TLocationSelectorForm = class(TForm)
    btn1: TButton;
    edtLocationId: TEdit;
    cbb1: TComboBox;
    procedure btn1Click(Sender: TObject);
//    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LocationSelectorForm: TLocationSelectorForm;

implementation

uses uMainForm;

{$R *.dfm}

procedure TLocationSelectorForm.btn1Click(Sender: TObject);
begin
  if edtLocationId.Text = '' then
    MessageDlg('Na ah!', mtWarning, [mbOK], 0)
  else
    Close;
end;

end.
