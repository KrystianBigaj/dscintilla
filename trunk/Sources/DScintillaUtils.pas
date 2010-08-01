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

  SysUtils, Classes;

type

{ TDSciLines }

  TDSciLines = class(TStrings)
  protected
    FSendEditor: TDSciSendEditor;

    function IsUTF8: Boolean;

    function InternalGetText(AMessage: Integer; AParam1: Integer; var AText: TDSciString): Integer;
    function InternalSetText(AMessage: Integer; AParam1: Integer; const AText: TDSciString): Integer;
    function InternalGetTextLen(AMessage: Integer; var AText: TDSciString): Integer;
    function InternalSetTextLen(AMessage: Integer; const AText: TDSciString): Integer;

    function InternalSetTargetLine(ALine: Integer): Boolean;

    function GetTextStr: String; override;
    procedure SetTextStr(const AValue: string); override;

    function GetCount: Integer; override;

    function Get(AIndex: Integer): String; override;
    procedure Put(AIndex: Integer; const AString: String); override;

    procedure SetUpdateState(Updating: Boolean); override;

  public
    constructor Create(ASendEditor: TDSciSendEditor);
    procedure Clear; override;

    procedure LoadFromFileUTF8(const AFileName: string); virtual;
    procedure LoadFromStreamUTF8(AStream: TStream); virtual;

    procedure SaveToFileUTF8(const AFileName: string;
      APreamble: Boolean = False); virtual;
    procedure SaveToStreamUTF8(AStream: TStream;
      APreamble: Boolean = False); virtual;

    procedure Delete(AIndex: Integer); override;
    procedure Insert(AIndex: Integer; const AString: string); override;
  end;

implementation

{ TDSciLines }

constructor TDSciLines.Create(ASendEditor: TDSciSendEditor);
begin
  FSendEditor := ASendEditor;

  inherited Create;
end;

function TDSciLines.IsUTF8: Boolean;
begin
  Result := FSendEditor(SCI_GETCODEPAGE) = SC_CP_UTF8;
end;

function TDSciLines.InternalGetText(AMessage: Integer; AParam1: Integer; var AText: TDSciString): Integer;
var
  lBuf: PAnsiChar;
begin
  lBuf := AllocMem(FSendEditor(AMessage, AParam1) + 1);
  try
    Result := FSendEditor(AMessage, AParam1, Integer(lBuf));

    if IsUTF8 then
      AText := UTF8ToUnicodeString(lBuf)
    else
      AText := String(lBuf);

  finally
    FreeMem(lBuf);
  end;
end;

function TDSciLines.InternalSetText(AMessage: Integer; AParam1: Integer; const AText: TDSciString): Integer;
begin
  if IsUTF8 then
    Result := FSendEditor(AMessage, AParam1, Integer(UTF8String(AText)))
  else
    Result := FSendEditor(AMessage, AParam1, Integer(AnsiString(AText)));
end;

function TDSciLines.InternalSetTargetLine(ALine: Integer): Boolean;
var
  lLineStart, lLineEnd: Integer;
begin
  lLineStart := FSendEditor(SCI_POSITIONFROMLINE, ALine);
  if lLineStart = INVALID_POSITION then
    Exit(False);

  if (lLineStart = FSendEditor(SCI_GETLENGTH)) and (ALine > 0) then
  begin
    lLineEnd := lLineStart;
    lLineStart := FSendEditor(SCI_GETLINEENDPOSITION, ALine - 1);
  end else
    lLineEnd := lLineStart + FSendEditor(SCI_LINELENGTH, ALine);

  if lLineEnd = INVALID_POSITION then
    Exit(False);

  FSendEditor(SCI_SETTARGETSTART, lLineStart);
  FSendEditor(SCI_SETTARGETEND, lLineEnd);

  Result := True;
end;

function TDSciLines.InternalGetTextLen(AMessage: Integer; var AText: String): Integer;
var
  lBuf: PAnsiChar;
  lLen: Integer;
begin
  lLen := FSendEditor(AMessage);

  lBuf := AllocMem(lLen + 1);
  try
    Result := FSendEditor(AMessage, lLen + 1, Integer(lBuf));

    if IsUTF8 then
      AText := UTF8ToUnicodeString(lBuf)
    else
      AText := String(lBuf);

  finally
    FreeMem(lBuf);
  end;
end;

function TDSciLines.InternalSetTextLen(AMessage: Integer; const AText: TDSciString): Integer;
var
  lUTF8: UTF8String;
  lAnsi: AnsiString;
begin
  if IsUTF8 then
  begin
    lUTF8 := UTF8String(AText);
    Result := FSendEditor(AMessage, System.Length(lUTF8), Integer(lUTF8));
  end else
  begin
    lAnsi := AnsiString(AText);
    Result := FSendEditor(AMessage, System.Length(lAnsi), Integer(lAnsi));
  end;
end;

procedure TDSciLines.LoadFromFileUTF8(const AFileName: string);
begin
  LoadFromFile(AFileName, TEncoding.UTF8);
end;

procedure TDSciLines.LoadFromStreamUTF8(AStream: TStream);
begin
  LoadFromStream(AStream, TEncoding.UTF8);
end;

procedure TDSciLines.Clear;
begin
  FSendEditor(SCI_CLEARALL);
end;

procedure TDSciLines.Delete(AIndex: Integer);
begin
  if InternalSetTargetLine(AIndex) then
    FSendEditor(SCI_REPLACETARGET, 0, 0);
end;

function TDSciLines.Get(AIndex: Integer): String;
var
  lBuf: PAnsiChar;
  lTextRange: TDSciTextRange;
begin
  lTextRange.chrg.cpMin := FSendEditor(SCI_POSITIONFROMLINE, AIndex);
  lTextRange.chrg.cpMax := FSendEditor(SCI_GETLINEENDPOSITION, AIndex);

  if (lTextRange.chrg.cpMin = INVALID_POSITION) or (lTextRange.chrg.cpMax = INVALID_POSITION) then
    Exit('');

  lBuf := AllocMem(lTextRange.chrg.cpMax - lTextRange.chrg.cpMin  + 1);
  try
    lTextRange.lpstrText := PAnsiChar(lBuf);
    FSendEditor(SCI_GETTEXTRANGE, 0, Integer(@lTextRange));

    if IsUTF8 then
      Result := UTF8ToUnicodeString(lBuf)
    else
      Result := String(lBuf);

  finally
    FreeMem(lBuf);
  end;
end;

function TDSciLines.GetCount: Integer;
begin
  Result := FSendEditor(SCI_GETLINECOUNT);

  if Result = 1 then
    if FSendEditor(SCI_GETLENGTH) = 0 then
      Result := 0;
end;

function TDSciLines.GetTextStr: String;
var
  lBuf: PAnsiChar;
  lLen: Integer;
begin
  lLen := FSendEditor(SCI_GETLENGTH);

  lBuf := AllocMem(lLen + 1);
  try
    FSendEditor(SCI_GETTEXT, lLen + 1, Integer(lBuf));

    if IsUTF8 then
      Result := UTF8ToUnicodeString(lBuf)
    else
      Result := String(lBuf);

  finally
    FreeMem(lBuf);
  end;
end;

procedure TDSciLines.Insert(AIndex: Integer; const AString: string);
var
  lEOL: String;
  lLinePos: Integer;
begin
  lLinePos := FSendEditor(SCI_POSITIONFROMLINE, AIndex);

  if lLinePos = INVALID_POSITION then
    Exit;

  case FSendEditor(SCI_GETEOLMODE) of
  SC_EOL_CRLF:
    lEOL := #13#10;

  SC_EOL_CR:
    lEOL := #13;

  SC_EOL_LF:
    lEOL := #10;
  else
    lEOL := ''; //??
  end;

  FSendEditor(SCI_SETTARGETSTART, lLinePos);
  FSendEditor(SCI_SETTARGETEND, lLinePos);

  if lLinePos = FSendEditor(SCI_GETLENGTH) then
  begin

    if lLinePos = 0 then
      InternalSetTextLen(SCI_REPLACETARGET, AString)
    else
      InternalSetTextLen(SCI_REPLACETARGET, lEOL + AString);

  end else
    InternalSetTextLen(SCI_REPLACETARGET, AString + lEOL);
end;

procedure TDSciLines.Put(AIndex: Integer; const AString: String);
begin
  if InternalSetTargetLine(AIndex) then
    InternalSetTextLen(SCI_REPLACETARGET, AString);
end;

procedure TDSciLines.SaveToFileUTF8(const AFileName: string;
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

procedure TDSciLines.SetTextStr(const AValue: string);
begin
  if IsUTF8 then
    FSendEditor(SCI_SETTEXT, 0, Integer(UTF8String(AValue)))
  else
    FSendEditor(SCI_SETTEXT, 0, Integer(AnsiString(AValue)));
end;

procedure TDSciLines.SetUpdateState(Updating: Boolean);
begin
  if Updating then
    FSendEditor(SCI_BEGINUNDOACTION)
  else
    FSendEditor(SCI_ENDUNDOACTION);
end;

end.
