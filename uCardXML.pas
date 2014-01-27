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

procedure AddNode(parent: PMyNode; node: PMyNode);
procedure DeleteNode(head: PMyNode; index: integer);

implementation

//uses SysInit, Math;

procedure AddNode(parent: PMyNode; node: PMyNode);
begin
  if parent = nil then // нету еще ничего
  begin
    Exit;
  end
  else
  begin
    if node <> nil then
    begin
      SetLength(parent.mnChild, parent.mnChildCount + 2);
      parent.mnChild[parent.mnChildCount] := node;
      parent.mnChildCount := parent.mnChildCount + 1;
    end;
  end;

end;

procedure DeleteNode(head: PMyNode; index: integer);
begin

end;

end.
