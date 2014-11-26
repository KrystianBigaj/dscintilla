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

{$IF CompilerVersion < 20}
  {$DEFINE DSCI_JCLWIDESTRINGS}
{$IFEND}

interface

uses
  DScintillaTypes,

{$IF Defined(DSCI_JCLWIDESTRINGS)}
  JclWideStrings,
{$IFEND}

  SysUtils, Classes;

const
  cDSciNull: AnsiChar = #0;

type

{ TDSciUnicodeStrings }

{$IF Defined(DSCI_JCLWIDESTRINGS)}
  TDSciUnicodeStrings = class(JclWideStrings.TJclWideStrings)
  public
    procedure LoadFromFile(const FileName: TFileName;
      WideFileOptions: TWideFileOptions = [foAnsiFile]); override;
    procedure LoadFromStream(Stream: TStream;
      WideFileOptions: TWideFileOptions = [foAnsiFile]); override;

    procedure SaveToFile(const FileName: TFileName;
      WideFileOptions: TWideFileOptions = [foAnsiFile]); override;
    procedure SaveToStream(Stream: TStream;
      WideFileOptions: TWideFileOptions = [foAnsiFile]); override;
  end;
{$ELSE}
  TDSciUnicodeStrings = TStrings;
{$IFEND}

{ TDSciHelper }

  TDSciHelper = class
  private
    FSendEditor: TDSciSendEditor;
  public
    constructor Create(ASendEditor: TDSciSendEditor);

    function SendEditor(AMessage: Integer;
      WParam: Integer = 0; LParam: Integer = 0): Integer;

    function IsUTF8: Boolean;

    function GetStrFromPtr(ABuf: PAnsiChar): UnicodeString;
    function GetStrFromPtrA(ABuf: PAnsiChar): AnsiString;
    function GetPtrFromAStr(AStr: AnsiString): PAnsiChar;

    function GetText(AMessage: Integer; AWParam: Integer; var AText: UnicodeString): Integer;
    function GetTextA(AMessage: Integer; AWParam: Integer; var AText: AnsiString): Integer;
    function SetText(AMessage: Integer; AWParam: Integer; const AText: UnicodeString): Integer;
    function SetTextA(AMessage: Integer; AWParam: Integer; const AText: AnsiString): Integer;
    function GetTextLen(AMessage: Integer; var AText: UnicodeString): Integer;
    function SetTextLen(AMessage: Integer; const AText: UnicodeString): Integer;

    function SetTargetLine(ALine: Integer): Boolean;
  end;

{ TDSciLines }

  TDSciLines = class(TDSciUnicodeStrings)
  protected
    FHelper: TDSciHelper;   
{$IFDEF DSCI_JCLWIDESTRINGS}
    FLastGetP: UnicodeString;
{$ENDIF}

    function GetTextStr: UnicodeString; override;
    procedure SetTextStr(const AValue: UnicodeString); override;

    function GetCount: Integer; override;

{$IFDEF DSCI_JCLWIDESTRINGS}
    // DON'T CALL GetP DIRECTLY
    // After second call, pointer from first call is invalid!
    function GetP(AIndex: Integer): PWideString; override;
    function Get(AIndex: Integer): UnicodeString;
{$ELSE}
    function Get(AIndex: Integer): UnicodeString; override;
{$ENDIF}

    procedure Put(AIndex: Integer; const AString: UnicodeString); override;
    procedure PutObject(Index: Integer; AObject: TObject); override;

    procedure SetUpdateState(Updating: Boolean); override;

  public
    constructor Create(AHelper: TDSciHelper);
    procedure Clear; override;

{$IF CompilerVersion > 19}
    procedure LoadFromFileUTF8(const AFileName: UnicodeString); virtual;
    procedure LoadFromStreamUTF8(AStream: TStream); virtual;

    procedure SaveToFileUTF8(const AFileName: UnicodeString;
      APreamble: Boolean = False); virtual;
    procedure SaveToStreamUTF8(AStream: TStream;
      APreamble: Boolean = False); virtual;
{$IFEND}

    procedure Delete(AIndex: Integer); override;
{$IFDEF DSCI_JCLWIDESTRINGS}
    procedure InsertObject(AIndex: Integer; const AString: UnicodeString;
      AObject: TObject); override;
{$ELSE}
    procedure Insert(AIndex: Integer; const AString: UnicodeString); override;
{$ENDIF}
  end;

{$IF CompilerVersion > 19}
type
  // Compiler 'magic' will do conversion
  UnicodeStringToUTF8 = UTF8String;
{$ELSE}
function UTF8ToUnicodeString(const S: PAnsiChar): UnicodeString;
function UnicodeStringToUTF8(const S: UnicodeString): UTF8String;
{$IFEND}

implementation

{$IF CompilerVersion < 20}
function _strlenA(lpString: PAnsiChar): Integer; stdcall;
  external 'kernel32.dll' name 'lstrlenA';

function UTF8ToUnicodeString(const S: PAnsiChar): UnicodeString;
var
  lLen: Integer;
  lUStr: UnicodeString;
begin
  Result := '';
  if S = '' then
    Exit;

  lLen := _strlenA(S);
  SetLength(lUStr, lLen);

  lLen := Utf8ToUnicode(PWideChar(lUStr), lLen + 1, S, lLen);
  if lLen > 0 then
    SetLength(lUStr, lLen - 1)
  else
    lUStr := '';
  Result := lUStr;
end;

function UnicodeStringToUTF8(const S: UnicodeString): UTF8String;
begin
  Result := UTF8Encode(S);
end;
{$IFEND}

{ TDSciUnicodeStrings }

{$IF Defined(DSCI_JCLWIDESTRINGS)}

procedure TDSciUnicodeStrings.LoadFromFile(const FileName: TFileName;
  WideFileOptions: TWideFileOptions);
begin
  inherited LoadFromFile(FileName, WideFileOptions);
end;

procedure TDSciUnicodeStrings.LoadFromStream(Stream: TStream;
  WideFileOptions: TWideFileOptions);
begin
  inherited LoadFromStream(Stream, WideFileOptions);
end;

procedure TDSciUnicodeStrings.SaveToFile(const FileName: TFileName;
  WideFileOptions: TWideFileOptions);
begin
  inherited SaveToFile(FileName, WideFileOptions);
end;

procedure TDSciUnicodeStrings.SaveToStream(Stream: TStream;
  WideFileOptions: TWideFileOptions);
begin
  inherited SaveToStream(Stream, WideFileOptions);
end;

{$IFEND}

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

function TDSciHelper.GetPtrFromAStr(AStr: AnsiString): PAnsiChar;
begin
  if AStr = '' then
    Result := @cDSciNull
  else
    Result := PAnsiChar(AStr);
end;

function TDSciHelper.GetStrFromPtr(ABuf: PAnsiChar): UnicodeString;
begin
  if ABuf = nil then
    Result := ''
  else
    if IsUTF8 then
      Result := UTF8ToUnicodeString(ABuf)
    else
      Result:= UnicodeString(ABuf);
end;

function TDSciHelper.GetStrFromPtrA(ABuf: PAnsiChar): AnsiString;
begin
  if ABuf = nil then
    Result := ''
  else
    Result:= AnsiString(ABuf);
end;

function TDSciHelper.GetText(AMessage, AWParam: Integer;
  var AText: UnicodeString): Integer;
var
  lBuf: PAnsiChar;
begin
  lBuf := AllocMem(SendEditor(AMessage, AWParam) + 1);
  try
    Result := SendEditor(AMessage, AWParam, Integer(lBuf));
    AText := GetStrFromPtr(lBuf);
  finally
    FreeMem(lBuf);
  end;
end;

function TDSciHelper.GetTextA(AMessage, AWParam: Integer;
  var AText: AnsiString): Integer;
var
  lBuf: PAnsiChar;
begin
  lBuf := AllocMem(SendEditor(AMessage, AWParam) + 1);
  try
    Result := SendEditor(AMessage, AWParam, Integer(lBuf));
    AText := GetStrFromPtrA(lBuf);
  finally
    FreeMem(lBuf);
  end;
end;

function TDSciHelper.SetText(AMessage, AWParam: Integer;
  const AText: UnicodeString): Integer;
begin
  if AText = '' then
    Result := SendEditor(AMessage, AWParam, Integer(@cDSciNull))
  else
    if IsUTF8 then
      Result := SendEditor(AMessage, AWParam, Integer(UnicodeStringToUTF8(AText)))
    else
      Result := SendEditor(AMessage, AWParam, Integer(AnsiString(AText)));
end;

function TDSciHelper.SetTextA(AMessage, AWParam: Integer;
  const AText: AnsiString): Integer;
begin
  if AText = '' then
    Result := SendEditor(AMessage, AWParam, Integer(@cDSciNull))
  else
    Result := SendEditor(AMessage, AWParam, Integer(AText));
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
    AText := GetStrFromPtr(lBuf);
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
  if AText = '' then
    Result := SendEditor(AMessage, 0, Integer(@cDSciNull))
  else
    if IsUTF8 then
    begin
      lUTF8 := UnicodeStringToUTF8(AText);
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
    Result := FHelper.GetStrFromPtr(lBuf);
  finally
    FreeMem(lBuf);
  end;
end;

procedure TDSciLines.SetTextStr(const AValue: UnicodeString);
begin
  FHelper.SetText(SCI_SETTEXT, 0, AValue);
end;

function TDSciLines.GetCount: Integer;
begin
  Result := FHelper.SendEditor(SCI_GETLINECOUNT);

  if Result = 1 then
    if FHelper.SendEditor(SCI_GETLENGTH) = 0 then
      Result := 0;
end;

{$IFDEF DSCI_JCLWIDESTRINGS}
function TDSciLines.GetP(AIndex: Integer): PWideString;
begin
  FLastGetP := Get(AIndex);
  Result := @FLastGetP;
end;
{$ENDIF}

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
    Result := FHelper.GetStrFromPtr(lBuf);
  finally
    FreeMem(lBuf);
  end;
end;

procedure TDSciLines.Put(AIndex: Integer; const AString: UnicodeString);
begin
  if FHelper.SetTargetLine(AIndex) then
    FHelper.SetTextLen(SCI_REPLACETARGET, AString);
end;

procedure TDSciLines.PutObject(Index: Integer; AObject: TObject);
begin
  // Objects in TDSciLines are not supported
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

{$IF CompilerVersion > 19}
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
{$IFEND}

procedure TDSciLines.Delete(AIndex: Integer);
begin
  if FHelper.SetTargetLine(AIndex) then
    FHelper.SendEditor(SCI_REPLACETARGET, 0, 0);
end;

{$IFDEF DSCI_JCLWIDESTRINGS}
procedure TDSciLines.InsertObject(AIndex: Integer; const AString: UnicodeString;
  AObject: TObject);
{$ELSE}
procedure TDSciLines.Insert(AIndex: Integer; const AString: UnicodeString);
{$ENDIF}
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
    lEOL := sLineBreak;
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
