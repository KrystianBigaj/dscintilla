{* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Krystian Bigaj code.
 *
 * The Initial Developer of the Original Code is Krystian Bigaj.
 *
 * Portions created by the Initial Developer are Copyright (C) 2010
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   (none)
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** *}

unit DScintillaUtils;

interface

uses
  DScintillaTypes,

{$IFNDEF UNICODE}
  // D2006, D2007
  {$IF CompilerVersion > 17}
  WideStrings,
  {$ELSE}
  // D6/D7 requires JCL (JEDI)
  JclWideStrings,
  {$IFEND}
{$ENDIF}

  SysUtils, Classes;

type

{$IFDEF UNICODE}
  // D2009+
  TDSciUnicodeStrings = TStrings;
{$ELSE}         
  {$IF CompilerVersion > 17}
  // D2006, D2007
  TDSciUnicodeStrings = WideStrings.TWideStrings;
  {$ELSE}
  // D6/D7
  TDSciUnicodeStrings = JclWideStrings.TJclWideStrings;
  {$IFEND}
{$ENDIF}

{ TDSciHelper }

  TDSciHelper = class
  private
    FSendEditor: TDSciSendEditor;
  public
    constructor Create(ASendEditor: TDSciSendEditor);

    function SendEditor(AMessage: Integer;
      WParam: Integer = 0; LParam: Integer = 0): Integer;

    function IsUTF8: Boolean;

    function GetText(AMessage: Integer; AParam1: Integer; var AText: UnicodeString): Integer;
    function SetText(AMessage: Integer; AParam1: Integer; const AText: UnicodeString): Integer;
    function GetTextLen(AMessage: Integer; var AText: UnicodeString): Integer;
    function SetTextLen(AMessage: Integer; const AText: UnicodeString): Integer;

    function SetTargetLine(ALine: Integer): Boolean;
  end;

{ TDSciLines }

  TDSciLines = class(TDSciUnicodeStrings)
  protected
    FHelper: TDSciHelper;

    function GetTextStr: UnicodeString; override;
    procedure SetTextStr(const AValue: UnicodeString); override;

    function GetCount: Integer; override;

    function Get(AIndex: Integer): UnicodeString; {$IF CompilerVersion > 17}override;{$IFEND} // TJclWideStrings.Get is not virtual
    procedure Put(AIndex: Integer; const AString: UnicodeString); override;

    procedure SetUpdateState(Updating: Boolean); override;

  public
    constructor Create(AHelper: TDSciHelper);
    procedure Clear; override;
                 
{$IFDEF UNICODE}
    procedure LoadFromFileUTF8(const AFileName: UnicodeString); virtual;
    procedure LoadFromStreamUTF8(AStream: TStream); virtual;

    procedure SaveToFileUTF8(const AFileName: UnicodeString;
      APreamble: Boolean = False); virtual;
    procedure SaveToStreamUTF8(AStream: TStream;
      APreamble: Boolean = False); virtual;
{$ENDIF}

    procedure Delete(AIndex: Integer); override;
    procedure Insert(AIndex: Integer; const AString: UnicodeString); override;
  end;

{$IFDEF UNICODE}
// TODO:
{$ELSE}
function UTF8ToUnicodeString(const S: PAnsiChar): UnicodeString;
{$ENDIF}

implementation

{$IFNDEF UNICODE}
function _strlenA(lpString: PAnsiChar): Integer; stdcall;
  external 'kernel32.dll' name 'lstrlenA';

function UTF8ToUnicodeString(const S: PAnsiChar): UnicodeString;
var
  lLen: Integer;
  lUStr: UnicodeString;
begin
  Result := '';
  if S = '' then Exit;
  lLen := _strlenA(S);
  SetLength(lUStr, lLen);

  lLen := Utf8ToUnicode(PWideChar(lUStr), lLen + 1, S, lLen);
  if lLen > 0 then
    SetLength(lUStr, lLen - 1)
  else
    lUStr := '';
  Result := lUStr;
end;
{$ENDIF}

{ TDSciHelper }

constructor TDSciHelper.Create(ASendEditor: TDSciSendEditor);
begin
  FSendEditor := ASendEditor;

  inherited Create;
end;

function TDSciHelper.SendEditor(AMessage, WParam, LParam: Integer): Integer;
begin
  Result := FSendEditor(AMessage, WParam, LParam);
end;

function TDSciHelper.IsUTF8: Boolean;
begin
  Result := SendEditor(SCI_GETCODEPAGE) = SC_CP_UTF8;
end;

function TDSciHelper.GetText(AMessage, AParam1: Integer;
  var AText: UnicodeString): Integer;
var
  lBuf: PAnsiChar;
begin
  lBuf := AllocMem(SendEditor(AMessage, AParam1) + 1);
  try
    Result := SendEditor(AMessage, AParam1, Integer(lBuf));

    if IsUTF8 then
      AText := UTF8ToUnicodeString(lBuf)
    else
      AText := UnicodeString(AnsiString(lBuf));

  finally
    FreeMem(lBuf);
  end;
end;

function TDSciHelper.SetText(AMessage, AParam1: Integer;
  const AText: UnicodeString): Integer;
begin
  if IsUTF8 then
    Result := SendEditor(AMessage, AParam1, Integer(UTF8String(AText)))
  else
    Result := SendEditor(AMessage, AParam1, Integer(AnsiString(AText)));
end;

function TDSciHelper.GetTextLen(AMessage: Integer;
  var AText: UnicodeString): Integer;
var
  lBuf: PAnsiChar;
  lLen: Integer;
begin
  lLen := SendEditor(AMessage);

  lBuf := AllocMem(lLen + 1);
  try
    Result := SendEditor(AMessage, lLen + 1, Integer(lBuf));

    if IsUTF8 then
      AText := UTF8ToUnicodeString(lBuf)
    else
      AText := UnicodeString(lBuf);

  finally
    FreeMem(lBuf);
  end;
end;

function TDSciHelper.SetTextLen(AMessage: Integer;
  const AText: UnicodeString): Integer;
var
  lUTF8: UTF8String;
  lAnsi: AnsiString;
begin
  if IsUTF8 then
  begin
    lUTF8 := UTF8String(AText);
    Result := SendEditor(AMessage, System.Length(lUTF8), Integer(lUTF8));
  end else
  begin
    lAnsi := AnsiString(AText);
    Result := SendEditor(AMessage, System.Length(lAnsi), Integer(lAnsi));
  end;
end;

function TDSciHelper.SetTargetLine(ALine: Integer): Boolean;
var
  lLineStart, lLineEnd: Integer;
begin
  Result := False;

  lLineStart := SendEditor(SCI_POSITIONFROMLINE, ALine);
  if lLineStart = INVALID_POSITION then
    Exit;

  if (lLineStart = SendEditor(SCI_GETLENGTH)) and (ALine > 0) then
  begin
    lLineEnd := lLineStart;
    lLineStart := SendEditor(SCI_GETLINEENDPOSITION, ALine - 1);
  end else
    lLineEnd := lLineStart + SendEditor(SCI_LINELENGTH, ALine);

  if lLineEnd = INVALID_POSITION then
    Exit;

  SendEditor(SCI_SETTARGETSTART, lLineStart);
  SendEditor(SCI_SETTARGETEND, lLineEnd);

  Result := True;
end;

{ TDSciLines }

constructor TDSciLines.Create(AHelper: TDSciHelper);
begin
  FHelper := AHelper;

  inherited Create;
end;

function TDSciLines.GetTextStr: UnicodeString;
var
  lBuf: PAnsiChar;
  lLen: Integer;
begin
  lLen := FHelper.SendEditor(SCI_GETLENGTH);

  lBuf := AllocMem(lLen + 1);
  try
    FHelper.SendEditor(SCI_GETTEXT, lLen + 1, Integer(lBuf));

    if FHelper.IsUTF8 then
      Result := UTF8ToUnicodeString(lBuf)
    else
      Result := UnicodeString(lBuf);

  finally
    FreeMem(lBuf);
  end;
end;

procedure TDSciLines.SetTextStr(const AValue: UnicodeString);
begin
  if FHelper.IsUTF8 then
    FHelper.SendEditor(SCI_SETTEXT, 0, Integer(UTF8String(AValue)))
  else
    FHelper.SendEditor(SCI_SETTEXT, 0, Integer(AnsiString(AValue)));
end;

function TDSciLines.GetCount: Integer;
begin
  Result := FHelper.SendEditor(SCI_GETLINECOUNT);

  if Result = 1 then
    if FHelper.SendEditor(SCI_GETLENGTH) = 0 then
      Result := 0;
end;

function TDSciLines.Get(AIndex: Integer): UnicodeString;
var
  lBuf: PAnsiChar;
  lTextRange: TDSciTextRange;
begin
  Result := '';

  lTextRange.chrg.cpMin := FHelper.SendEditor(SCI_POSITIONFROMLINE, AIndex);
  lTextRange.chrg.cpMax := FHelper.SendEditor(SCI_GETLINEENDPOSITION, AIndex);

  if (lTextRange.chrg.cpMin = INVALID_POSITION) or (lTextRange.chrg.cpMax = INVALID_POSITION) then
    Exit;

  lBuf := AllocMem(lTextRange.chrg.cpMax - lTextRange.chrg.cpMin  + 1);
  try
    lTextRange.lpstrText := PAnsiChar(lBuf);
    FHelper.SendEditor(SCI_GETTEXTRANGE, 0, Integer(@lTextRange));

    if FHelper.IsUTF8 then
      Result := UTF8ToUnicodeString(lBuf)
    else
      Result := UnicodeString(lBuf);

  finally
    FreeMem(lBuf);
  end;
end;

procedure TDSciLines.Put(AIndex: Integer; const AString: UnicodeString);
begin
  if FHelper.SetTargetLine(AIndex) then
    FHelper.SetTextLen(SCI_REPLACETARGET, AString);
end;

procedure TDSciLines.SetUpdateState(Updating: Boolean);
begin
  if Updating then
    FHelper.SendEditor(SCI_BEGINUNDOACTION)
  else
    FHelper.SendEditor(SCI_ENDUNDOACTION);
end;

procedure TDSciLines.Clear;
begin
  FHelper.SendEditor(SCI_CLEARALL);
end;

{$IFDEF UNICODE}
procedure TDSciLines.LoadFromFileUTF8(const AFileName: UnicodeString);
begin
  LoadFromFile(AFileName, TEncoding.UTF8);
end;

procedure TDSciLines.LoadFromStreamUTF8(AStream: TStream);
begin
  LoadFromStream(AStream, TEncoding.UTF8);
end;

procedure TDSciLines.SaveToFileUTF8(const AFileName: UnicodeString;
  APreamble: Boolean);
var
  lStream: TStream;
begin
  lStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStreamUTF8(lStream, APreamble);
  finally
    lStream.Free;
  end;
end;

procedure TDSciLines.SaveToStreamUTF8(AStream: TStream; APreamble: Boolean);
var
  lBuffer: TBytes;
begin
  if APreamble then
    SaveToStream(AStream, TEncoding.UTF8)
  else
  begin
    lBuffer := TEncoding.UTF8.GetBytes(GetTextStr);
    if Length(lBuffer) > 0 then
      AStream.WriteBuffer(lBuffer[0], Length(lBuffer));
  end;
end;
{$ENDIF}

procedure TDSciLines.Delete(AIndex: Integer);
begin
  if FHelper.SetTargetLine(AIndex) then
    FHelper.SendEditor(SCI_REPLACETARGET, 0, 0);
end;

procedure TDSciLines.Insert(AIndex: Integer; const AString: UnicodeString);
var
  lEOL: UnicodeString;
  lLinePos: Integer;
begin
  lLinePos := FHelper.SendEditor(SCI_POSITIONFROMLINE, AIndex);

  if lLinePos = INVALID_POSITION then
    Exit;

  case FHelper.SendEditor(SCI_GETEOLMODE) of
  SC_EOL_CRLF:
    lEOL := #13#10;

  SC_EOL_CR:
    lEOL := #13;

  SC_EOL_LF:
    lEOL := #10;
  else
    lEOL := ''; //??
  end;

  FHelper.SendEditor(SCI_SETTARGETSTART, lLinePos);
  FHelper.SendEditor(SCI_SETTARGETEND, lLinePos);

  if lLinePos = FHelper.SendEditor(SCI_GETLENGTH) then
  begin

    if lLinePos = 0 then
      FHelper.SetTextLen(SCI_REPLACETARGET, AString)
    else
      FHelper.SetTextLen(SCI_REPLACETARGET, lEOL + AString);

  end else
    FHelper.SetTextLen(SCI_REPLACETARGET, AString + lEOL);
end;

end.
