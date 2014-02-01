unit uCardXML;

interface

type
  PMyNode = ^TMyNode;
  TMyNode = record
    data: string;
    mnChildCount: integer;
    mnParent: PMyNode;
    mnChild: array of PMyNode;
  end;

procedure DeleteNode(head: PMyNode; index: integer);
function Add_Child(var parnt: PMyNode; s: string): PMyNode;

implementation

uses SysUtils, Dialogs;

function Add_Child(var parnt: PMyNode; s: string): PMyNode;
var
  tmp: PMyNode;
begin
  New(tmp);
  tmp.mnParent := parnt;
  tmp.mnChildCount := 0;
  tmp.data := s;
  tmp.mnChild := nil;

  if parnt <> nil then
  begin
    parnt^.mnChildCount := parnt^.mnChildCount + 1;
    SetLength(parnt^.mnChild, parnt^.mnChildCount);
    parnt^.mnChild[parnt^.mnChildCount - 1] := tmp;
  end;

  Result := tmp;
end;

procedure DeleteNode(head: PMyNode; index: integer);
begin

end;

end.
