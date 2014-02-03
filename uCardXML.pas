unit uCardXML;

interface

type
  PLLData = ^TLLData;
  TLLData = record
    data: string;
    mnChildCount: integer;
    mnParent: PLLData;
    mnChild: array of PLLData;
  end;

procedure DeleteNode(head: PLLData; index: integer);
function Add_Child(var parnt: PLLData; s: string): PLLData;
procedure XML2LL(head: PLLData; {XMLDoc : TXMLDocument; }file_name: string);
//function Get_Child(var parnt: PLLData; s: string): PLLData;

implementation

uses SysUtils, Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc;

procedure XML2LL(
          head: PLLData;
          {XMLDoc : TXMLDocument; }
          file_name: string);
var
  iNode : IXMLNode;
  pc, t, f: boolean;
  XMLDoc: TXMLDocument;

  procedure ProcessNode(
        Node : IXMLNode;
        tn: PLLData);
  var
    cNode : IXMLNode;
    s: string;
  begin
    if tn = nil then
      tn := head;
    if Node = nil then Exit;
    with Node do
    begin
      tn := Add_Child(tn, NodeName);

      if HasAttribute('data') then
        tn.data := tn.data + Attributes['data'];
    end;
    
    cNode := Node.ChildNodes.First;
    while cNode <> nil do
    begin
      ProcessNode(cNode, tn);
      cNode := cNode.NextSibling;
    end;

  end; (*ProcessNode*)
  
begin
  XMLDoc := TXMLDocument.Create(nil) ;
  try
    XMLDoc.Active := True;
    //use XMLDoc here
    XMLDoc.FileName := file_name;//ChangeFileExt(ParamStr(0),'.XML');
    XMLDoc.Active := True;

    iNode := XMLDoc.DocumentElement.ChildNodes.First;

    while iNode <> nil do
    begin
      ProcessNode(iNode,nil);
      iNode := iNode.NextSibling;
    end;

    XMLDoc.Active := False;
  finally
    XMLDoc := nil;
  end;

end;

{procedure InitXMLDoc;
begin

end;             }

function Add_Child(var parnt: PLLData; s: string): PLLData;
var
  tmp: PLLData;
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

procedure DeleteNode(head: PLLData; index: integer);
begin

end;

end.
