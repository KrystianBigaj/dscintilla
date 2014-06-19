procedure TDScintilla.AddText(const AText: UnicodeString);
begin
  FHelper.SetTextLen(SCI_ADDTEXT, AText);
end;

procedure TDScintilla.AddStyledText(const ACells: TDSciCells);
begin
  SendEditor(SCI_ADDSTYLEDTEXT, System.Length(ACells) * 2, Integer(ACells));
end;

procedure TDScintilla.InsertText(APos: Integer; const AText: UnicodeString);
begin
  FHelper.SetText(SCI_INSERTTEXT, APos, AText);
end;

procedure TDScintilla.ChangeInsertion(const AText: UnicodeString);
begin
  FHelper.SetTextLen(SCI_CHANGEINSERTION, AText);
end;

procedure TDScintilla.ClearAll;
begin
  SendEditor(SCI_CLEARALL, 0, 0);
end;

procedure TDScintilla.DeleteRange(APos: Integer; ADeleteLength: Integer);
begin
  SendEditor(SCI_DELETERANGE, APos, ADeleteLength);
end;

procedure TDScintilla.ClearDocumentStyle;
begin
  SendEditor(SCI_CLEARDOCUMENTSTYLE, 0, 0);
end;

procedure TDScintilla.Redo;
begin
  SendEditor(SCI_REDO, 0, 0);
end;

procedure TDScintilla.SelectAll;
begin
  SendEditor(SCI_SELECTALL, 0, 0);
end;

procedure TDScintilla.SetSavePoint;
begin
  SendEditor(SCI_SETSAVEPOINT, 0, 0);
end;

function TDScintilla.GetStyledText(AStart, AEnd: Integer): TDSciCells;
var
  lRange: TDSciTextRange;
begin
  if AStart >= AEnd then
  begin
    SetLength(Result, 0);
    Exit;
  end;

  SetLength(Result, AEnd - AStart + 2{nul});

  lRange.chrg.cpMin := AStart;
  lRange.chrg.cpMax := AEnd;
  lRange.lpstrText := @Result;

  SendEditor(SCI_GETSTYLEDTEXT, 0, Integer(@lRange));
end;

function TDScintilla.CanRedo: Boolean;
begin
  Result := Boolean(SendEditor(SCI_CANREDO, 0, 0));
end;

function TDScintilla.MarkerLineFromHandle(AHandle: Integer): Integer;
begin
  Result := SendEditor(SCI_MARKERLINEFROMHANDLE, AHandle, 0);
end;

procedure TDScintilla.MarkerDeleteHandle(AHandle: Integer);
begin
  SendEditor(SCI_MARKERDELETEHANDLE, AHandle, 0);
end;

function TDScintilla.PositionFromPoint(AX: Integer; AY: Integer): Integer;
begin
  Result := SendEditor(SCI_POSITIONFROMPOINT, AX, AY);
end;

function TDScintilla.PositionFromPointClose(AX: Integer; AY: Integer): Integer;
begin
  Result := SendEditor(SCI_POSITIONFROMPOINTCLOSE, AX, AY);
end;

procedure TDScintilla.GotoLine(ALine: Integer);
begin
  SendEditor(SCI_GOTOLINE, ALine, 0);
end;

procedure TDScintilla.GotoPos(APos: Integer);
begin
  SendEditor(SCI_GOTOPOS, APos, 0);
end;

function TDScintilla.GetCurLine(var AText: UnicodeString): Integer;
begin
  Result := FHelper.GetTextLen(SCI_GETCURLINE, AText);
end;

procedure TDScintilla.ConvertEOLs(AEolMode: Integer);
begin
  SendEditor(SCI_CONVERTEOLS, AEolMode, 0);
end;

procedure TDScintilla.StartStyling(APos: Integer; AMask: Integer);
begin
  SendEditor(SCI_STARTSTYLING, APos, AMask);
end;

procedure TDScintilla.SetStyling(ALength: Integer; AStyle: Integer);
begin
  SendEditor(SCI_SETSTYLING, ALength, AStyle);
end;

procedure TDScintilla.MarkerDefine(AMarkerNumber: Integer; AMarkerSymbol: Integer);
begin
  SendEditor(SCI_MARKERDEFINE, AMarkerNumber, AMarkerSymbol);
end;

procedure TDScintilla.MarkerSetFore(AMarkerNumber: Integer; AFore: TColor);
begin
  SendEditor(SCI_MARKERSETFORE, AMarkerNumber, Integer(AFore));
end;

procedure TDScintilla.MarkerSetBack(AMarkerNumber: Integer; ABack: TColor);
begin
  SendEditor(SCI_MARKERSETBACK, AMarkerNumber, Integer(ABack));
end;

procedure TDScintilla.MarkerSetBackSelected(AMarkerNumber: Integer; ABack: TColor);
begin
  SendEditor(SCI_MARKERSETBACKSELECTED, AMarkerNumber, Integer(ABack));
end;

procedure TDScintilla.MarkerEnableHighlight(AEnabled: Boolean);
begin
  SendEditor(SCI_MARKERENABLEHIGHLIGHT, Integer(AEnabled), 0);
end;

function TDScintilla.MarkerAdd(ALine: Integer; AMarkerNumber: Integer): Integer;
begin
  Result := SendEditor(SCI_MARKERADD, ALine, AMarkerNumber);
end;

procedure TDScintilla.MarkerDelete(ALine: Integer; AMarkerNumber: Integer);
begin
  SendEditor(SCI_MARKERDELETE, ALine, AMarkerNumber);
end;

procedure TDScintilla.MarkerDeleteAll(AMarkerNumber: Integer);
begin
  SendEditor(SCI_MARKERDELETEALL, AMarkerNumber, 0);
end;

function TDScintilla.MarkerGet(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_MARKERGET, ALine, 0);
end;

function TDScintilla.MarkerNext(ALineStart: Integer; AMarkerMask: Integer): Integer;
begin
  Result := SendEditor(SCI_MARKERNEXT, ALineStart, AMarkerMask);
end;

function TDScintilla.MarkerPrevious(ALineStart: Integer; AMarkerMask: Integer): Integer;
begin
  Result := SendEditor(SCI_MARKERPREVIOUS, ALineStart, AMarkerMask);
end;

procedure TDScintilla.MarkerDefinePixmap(AMarkerNumber: Integer; const APixmap: TBytes);
begin
  SendEditor(SCI_MARKERDEFINEPIXMAP, AMarkerNumber, Integer(APixmap));
end;

procedure TDScintilla.MarkerAddSet(ALine: Integer; ASet: Integer);
begin
  SendEditor(SCI_MARKERADDSET, ALine, ASet);
end;

procedure TDScintilla.MarkerSetAlpha(AMarkerNumber: Integer; AAlpha: Integer);
begin
  SendEditor(SCI_MARKERSETALPHA, AMarkerNumber, AAlpha);
end;

procedure TDScintilla.StyleClearAll;
begin
  SendEditor(SCI_STYLECLEARALL, 0, 0);
end;

procedure TDScintilla.StyleResetDefault;
begin
  SendEditor(SCI_STYLERESETDEFAULT, 0, 0);
end;

function TDScintilla.StyleGetFont(AStyle: Integer): UnicodeString;
begin
  FHelper.GetText(SCI_STYLEGETFONT, AStyle, Result);
end;

procedure TDScintilla.SetSelFore(AUseSetting: Boolean; AFore: TColor);
begin
  SendEditor(SCI_SETSELFORE, Integer(AUseSetting), Integer(AFore));
end;

procedure TDScintilla.SetSelBack(AUseSetting: Boolean; ABack: TColor);
begin
  SendEditor(SCI_SETSELBACK, Integer(AUseSetting), Integer(ABack));
end;

procedure TDScintilla.AssignCmdKey(AKm: Integer; AMsg: Integer);
begin
  SendEditor(SCI_ASSIGNCMDKEY, AKm, AMsg);
end;

procedure TDScintilla.ClearCmdKey(AKm: Integer);
begin
  SendEditor(SCI_CLEARCMDKEY, AKm, 0);
end;

procedure TDScintilla.ClearAllCmdKeys;
begin
  SendEditor(SCI_CLEARALLCMDKEYS, 0, 0);
end;

procedure TDScintilla.SetStylingEx(const AStyles: TDSciStyles);
begin
  SendEditor(SCI_SETSTYLINGEX, System.Length(AStyles), Integer(AStyles));
end;

procedure TDScintilla.BeginUndoAction;
begin
  SendEditor(SCI_BEGINUNDOACTION, 0, 0);
end;

procedure TDScintilla.EndUndoAction;
begin
  SendEditor(SCI_ENDUNDOACTION, 0, 0);
end;

procedure TDScintilla.SetWhitespaceFore(AUseSetting: Boolean; AFore: TColor);
begin
  SendEditor(SCI_SETWHITESPACEFORE, Integer(AUseSetting), Integer(AFore));
end;

procedure TDScintilla.SetWhitespaceBack(AUseSetting: Boolean; ABack: TColor);
begin
  SendEditor(SCI_SETWHITESPACEBACK, Integer(AUseSetting), Integer(ABack));
end;

procedure TDScintilla.AutoCShow(ALenEntered: Integer; const AItemList: UnicodeString);
begin
  FHelper.SetText(SCI_AUTOCSHOW, ALenEntered, AItemList);
end;

procedure TDScintilla.AutoCCancel;
begin
  SendEditor(SCI_AUTOCCANCEL, 0, 0);
end;

function TDScintilla.AutoCActive: Boolean;
begin
  Result := Boolean(SendEditor(SCI_AUTOCACTIVE, 0, 0));
end;

function TDScintilla.AutoCPosStart: Integer;
begin
  Result := SendEditor(SCI_AUTOCPOSSTART, 0, 0);
end;

procedure TDScintilla.AutoCComplete;
begin
  SendEditor(SCI_AUTOCCOMPLETE, 0, 0);
end;

procedure TDScintilla.AutoCStops(const ACharacterSet: UnicodeString);
begin
  FHelper.SetText(SCI_AUTOCSTOPS, 0, ACharacterSet);
end;

procedure TDScintilla.AutoCSelect(const AText: UnicodeString);
begin
  FHelper.SetText(SCI_AUTOCSELECT, 0, AText);
end;

procedure TDScintilla.UserListShow(AListType: Integer; const AItemList: UnicodeString);
begin
  FHelper.SetText(SCI_USERLISTSHOW, AListType, AItemList);
end;

procedure TDScintilla.RegisterImage(AType: Integer; const AXpmData: TBytes);
begin
  if Length(AXpmData) > 0 then
    SendEditor(SCI_REGISTERIMAGE, AType, Integer(AXpmData));
end;

procedure TDScintilla.ClearRegisteredImages;
begin
  SendEditor(SCI_CLEARREGISTEREDIMAGES, 0, 0);
end;

function TDScintilla.CountCharacters(AStartPos: Integer; AEndPos: Integer): Integer;
begin
  Result := SendEditor(SCI_COUNTCHARACTERS, AStartPos, AEndPos);
end;

procedure TDScintilla.SetEmptySelection(APos: Integer);
begin
  SendEditor(SCI_SETEMPTYSELECTION, APos, 0);
end;

function TDScintilla.FindText(AFlags: Integer; const AText: UnicodeString; var ARange: TDSciCharacterRange): Integer;
var
  lRange: TDSciTextToFind;
begin
  lRange.chrg := ARange;
  if SendEditor(SCI_GETCODEPAGE) = SC_CP_UTF8 then
  begin
    lRange.lpstrText := PAnsiChar(UnicodeStringToUTF8(AText));
    Result := SendEditor(SCI_FINDTEXT, AFlags, Integer(@lRange));
  end else
  begin
    lRange.lpstrText := PAnsiChar(AnsiString(AText));
    Result := SendEditor(SCI_FINDTEXT, AFlags, Integer(@lRange));
  end;

  if Result > INVALID_POSITION then
    ARange := lRange.chrgText;
end;

function TDScintilla.FormatRange(ADraw: Boolean; var AFr: TDSciRangeToFormat): Integer;
begin
  Result := SendEditor(SCI_FORMATRANGE, Integer(ADraw), Integer(@AFr));
end;

function TDScintilla.GetLine(ALine: Integer): UnicodeString;
begin
  FHelper.GetText(SCI_GETLINE, ALine, Result);
end;

procedure TDScintilla.SetSel(AStart: Integer; AEnd: Integer);
begin
  SendEditor(SCI_SETSEL, AStart, AEnd);
end;

function TDScintilla.GetSelText: UnicodeString;
begin
  FHelper.GetText(SCI_GETSELTEXT, 0, Result);
end;

function TDScintilla.GetTextRange(AStart, AEnd: Integer): UnicodeString;
var
  lRange: TDSciTextRange;
  lChars: TDSciChars;
  lActualLength: Integer;
begin
  Result := '';

  if AEnd = -1 then
    AEnd := GetLength
  else
    if AEnd > GetLength then
      Exit;

  if (AStart < 0) or (AEnd < 0) or (AStart >= AEnd) then
    Exit;

  SetLength(lChars, AEnd - AStart + 1); // to handle case when text is zero-terminated, as per the Scintilla docs for SCI_GETTEXTRANGE

  lRange.chrg.cpMin := AStart;
  lRange.chrg.cpMax := AEnd;
  lRange.lpstrText := @lChars[0];

  lActualLength := SendEditor(SCI_GETTEXTRANGE, 0, Integer(@lRange));
  lChars[lActualLength] := #0;

  Result := FHelper.GetStrFromPtr(@lChars[0]);
end;

procedure TDScintilla.HideSelection(ANormal: Boolean);
begin
  SendEditor(SCI_HIDESELECTION, Integer(ANormal), 0);
end;

function TDScintilla.PointXFromPosition(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_POINTXFROMPOSITION, 0, APos);
end;

function TDScintilla.PointYFromPosition(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_POINTYFROMPOSITION, 0, APos);
end;

function TDScintilla.LineFromPosition(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_LINEFROMPOSITION, APos, 0);
end;

function TDScintilla.PositionFromLine(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_POSITIONFROMLINE, ALine, 0);
end;

procedure TDScintilla.LineScroll(AColumns: Integer; ALines: Integer);
begin
  SendEditor(SCI_LINESCROLL, AColumns, ALines);
end;

procedure TDScintilla.ScrollCaret;
begin
  SendEditor(SCI_SCROLLCARET, 0, 0);
end;

procedure TDScintilla.ScrollRange(ASecondary: Integer; APrimary: Integer);
begin
  SendEditor(SCI_SCROLLRANGE, ASecondary, APrimary);
end;

procedure TDScintilla.ReplaceSel(const AText: UnicodeString);
begin
  FHelper.SetText(SCI_REPLACESEL, 0, AText);
end;

// procedure TDScintilla.Null;
// begin
//   SendEditor(SCI_NULL, 0, 0);
// end;

function TDScintilla.CanPaste: Boolean;
begin
  Result := Boolean(SendEditor(SCI_CANPASTE, 0, 0));
end;

function TDScintilla.CanUndo: Boolean;
begin
  Result := Boolean(SendEditor(SCI_CANUNDO, 0, 0));
end;

procedure TDScintilla.EmptyUndoBuffer;
begin
  SendEditor(SCI_EMPTYUNDOBUFFER, 0, 0);
end;

procedure TDScintilla.Undo;
begin
  SendEditor(SCI_UNDO, 0, 0);
end;

procedure TDScintilla.Cut;
begin
  SendEditor(SCI_CUT, 0, 0);
end;

procedure TDScintilla.Copy;
begin
  SendEditor(SCI_COPY, 0, 0);
end;

procedure TDScintilla.Paste;
begin
  SendEditor(SCI_PASTE, 0, 0);
end;

procedure TDScintilla.Clear;
begin
  SendEditor(SCI_CLEAR, 0, 0);
end;

procedure TDScintilla.SetText(const AText: UnicodeString);
begin
  FHelper.SetTextLen(SCI_SETTEXT, AText);
end;

function TDScintilla.GetText: UnicodeString;
begin
  FHelper.GetTextLen(SCI_GETTEXT, Result);
end;

function TDScintilla.ReplaceTarget(const AText: UnicodeString): Integer;
begin
  Result := FHelper.SetTextLen(SCI_REPLACETARGET, AText);
end;

function TDScintilla.ReplaceTargetRE(const AText: UnicodeString): Integer;
begin
  Result := FHelper.SetTextLen(SCI_REPLACETARGETRE, AText);
end;

function TDScintilla.SearchInTarget(const AText: UnicodeString): Integer;
begin
  Result := FHelper.SetTextLen(SCI_SEARCHINTARGET, AText);
end;

procedure TDScintilla.CallTipShow(APos: Integer; const ADefinition: UnicodeString);
begin
  if ADefinition = '' then
    CallTipCancel
  else
    FHelper.SetText(SCI_CALLTIPSHOW, APos, ADefinition);
end;

procedure TDScintilla.CallTipCancel;
begin
  SendEditor(SCI_CALLTIPCANCEL, 0, 0);
end;

function TDScintilla.CallTipActive: Boolean;
begin
  Result := Boolean(SendEditor(SCI_CALLTIPACTIVE, 0, 0));
end;

function TDScintilla.CallTipPosStart: Integer;
begin
  Result := SendEditor(SCI_CALLTIPPOSSTART, 0, 0);
end;

procedure TDScintilla.CallTipSetHlt(AStart: Integer; AEnd: Integer);
begin
  SendEditor(SCI_CALLTIPSETHLT, AStart, AEnd);
end;

function TDScintilla.VisibleFromDocLine(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_VISIBLEFROMDOCLINE, ALine, 0);
end;

function TDScintilla.DocLineFromVisible(ALineDisplay: Integer): Integer;
begin
  Result := SendEditor(SCI_DOCLINEFROMVISIBLE, ALineDisplay, 0);
end;

function TDScintilla.WrapCount(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_WRAPCOUNT, ALine, 0);
end;

procedure TDScintilla.ShowLines(ALineStart: Integer; ALineEnd: Integer);
begin
  SendEditor(SCI_SHOWLINES, ALineStart, ALineEnd);
end;

procedure TDScintilla.HideLines(ALineStart: Integer; ALineEnd: Integer);
begin
  SendEditor(SCI_HIDELINES, ALineStart, ALineEnd);
end;

procedure TDScintilla.ToggleFold(ALine: Integer);
begin
  SendEditor(SCI_TOGGLEFOLD, ALine, 0);
end;

procedure TDScintilla.FoldLine(ALine: Integer; AAction: Integer);
begin
  SendEditor(SCI_FOLDLINE, ALine, AAction);
end;

procedure TDScintilla.FoldChildren(ALine: Integer; AAction: Integer);
begin
  SendEditor(SCI_FOLDCHILDREN, ALine, AAction);
end;

procedure TDScintilla.ExpandChildren(ALine: Integer; ALevel: Integer);
begin
  SendEditor(SCI_EXPANDCHILDREN, ALine, ALevel);
end;

procedure TDScintilla.FoldAll(AAction: Integer);
begin
  SendEditor(SCI_FOLDALL, AAction, 0);
end;

procedure TDScintilla.EnsureVisible(ALine: Integer);
begin
  SendEditor(SCI_ENSUREVISIBLE, ALine, 0);
end;

procedure TDScintilla.SetFoldFlags(AFlags: Integer);
begin
  SendEditor(SCI_SETFOLDFLAGS, AFlags, 0);
end;

procedure TDScintilla.EnsureVisibleEnforcePolicy(ALine: Integer);
begin
  SendEditor(SCI_ENSUREVISIBLEENFORCEPOLICY, ALine, 0);
end;

function TDScintilla.WordStartPosition(APos: Integer; AOnlyWordCharacters: Boolean): Integer;
begin
  Result := SendEditor(SCI_WORDSTARTPOSITION, APos, Integer(AOnlyWordCharacters));
end;

function TDScintilla.WordEndPosition(APos: Integer; AOnlyWordCharacters: Boolean): Integer;
begin
  Result := SendEditor(SCI_WORDENDPOSITION, APos, Integer(AOnlyWordCharacters));
end;

function TDScintilla.TextWidth(AStyle: Integer; const AText: UnicodeString): Integer;
begin
  Result := FHelper.SetText(SCI_TEXTWIDTH, AStyle, AText);
end;

function TDScintilla.TextHeight(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_TEXTHEIGHT, ALine, 0);
end;

procedure TDScintilla.AppendText(const AText: UnicodeString);
begin
  FHelper.SetTextLen(SCI_APPENDTEXT, AText);
end;

function TDScintilla.GetTag(ATagNumber: Integer): UnicodeString;
begin
  FHelper.GetText(SCI_GETTAG, ATagNumber, Result);
end;

procedure TDScintilla.TargetFromSelection;
begin
  SendEditor(SCI_TARGETFROMSELECTION, 0, 0);
end;

procedure TDScintilla.LinesJoin;
begin
  SendEditor(SCI_LINESJOIN, 0, 0);
end;

procedure TDScintilla.LinesSplit(APixelWidth: Integer);
begin
  SendEditor(SCI_LINESSPLIT, APixelWidth, 0);
end;

procedure TDScintilla.SetFoldMarginColour(AUseSetting: Boolean; ABack: TColor);
begin
  SendEditor(SCI_SETFOLDMARGINCOLOUR, Integer(AUseSetting), Integer(ABack));
end;

procedure TDScintilla.SetFoldMarginHiColour(AUseSetting: Boolean; AFore: TColor);
begin
  SendEditor(SCI_SETFOLDMARGINHICOLOUR, Integer(AUseSetting), Integer(AFore));
end;

procedure TDScintilla.LineDown;
begin
  SendEditor(SCI_LINEDOWN, 0, 0);
end;

procedure TDScintilla.LineDownExtend;
begin
  SendEditor(SCI_LINEDOWNEXTEND, 0, 0);
end;

procedure TDScintilla.LineUp;
begin
  SendEditor(SCI_LINEUP, 0, 0);
end;

procedure TDScintilla.LineUpExtend;
begin
  SendEditor(SCI_LINEUPEXTEND, 0, 0);
end;

procedure TDScintilla.CharLeft;
begin
  SendEditor(SCI_CHARLEFT, 0, 0);
end;

procedure TDScintilla.CharLeftExtend;
begin
  SendEditor(SCI_CHARLEFTEXTEND, 0, 0);
end;

procedure TDScintilla.CharRight;
begin
  SendEditor(SCI_CHARRIGHT, 0, 0);
end;

procedure TDScintilla.CharRightExtend;
begin
  SendEditor(SCI_CHARRIGHTEXTEND, 0, 0);
end;

procedure TDScintilla.WordLeft;
begin
  SendEditor(SCI_WORDLEFT, 0, 0);
end;

procedure TDScintilla.WordLeftExtend;
begin
  SendEditor(SCI_WORDLEFTEXTEND, 0, 0);
end;

procedure TDScintilla.WordRight;
begin
  SendEditor(SCI_WORDRIGHT, 0, 0);
end;

procedure TDScintilla.WordRightExtend;
begin
  SendEditor(SCI_WORDRIGHTEXTEND, 0, 0);
end;

procedure TDScintilla.Home;
begin
  SendEditor(SCI_HOME, 0, 0);
end;

procedure TDScintilla.HomeExtend;
begin
  SendEditor(SCI_HOMEEXTEND, 0, 0);
end;

procedure TDScintilla.LineEnd;
begin
  SendEditor(SCI_LINEEND, 0, 0);
end;

procedure TDScintilla.LineEndExtend;
begin
  SendEditor(SCI_LINEENDEXTEND, 0, 0);
end;

procedure TDScintilla.DocumentStart;
begin
  SendEditor(SCI_DOCUMENTSTART, 0, 0);
end;

procedure TDScintilla.DocumentStartExtend;
begin
  SendEditor(SCI_DOCUMENTSTARTEXTEND, 0, 0);
end;

procedure TDScintilla.DocumentEnd;
begin
  SendEditor(SCI_DOCUMENTEND, 0, 0);
end;

procedure TDScintilla.DocumentEndExtend;
begin
  SendEditor(SCI_DOCUMENTENDEXTEND, 0, 0);
end;

procedure TDScintilla.PageUp;
begin
  SendEditor(SCI_PAGEUP, 0, 0);
end;

procedure TDScintilla.PageUpExtend;
begin
  SendEditor(SCI_PAGEUPEXTEND, 0, 0);
end;

procedure TDScintilla.PageDown;
begin
  SendEditor(SCI_PAGEDOWN, 0, 0);
end;

procedure TDScintilla.PageDownExtend;
begin
  SendEditor(SCI_PAGEDOWNEXTEND, 0, 0);
end;

procedure TDScintilla.EditToggleOvertype;
begin
  SendEditor(SCI_EDITTOGGLEOVERTYPE, 0, 0);
end;

procedure TDScintilla.Cancel;
begin
  SendEditor(SCI_CANCEL, 0, 0);
end;

procedure TDScintilla.DeleteBack;
begin
  SendEditor(SCI_DELETEBACK, 0, 0);
end;

procedure TDScintilla.Tab;
begin
  SendEditor(SCI_TAB, 0, 0);
end;

procedure TDScintilla.BackTab;
begin
  SendEditor(SCI_BACKTAB, 0, 0);
end;

procedure TDScintilla.NewLine;
begin
  SendEditor(SCI_NEWLINE, 0, 0);
end;

procedure TDScintilla.FormFeed;
begin
  SendEditor(SCI_FORMFEED, 0, 0);
end;

procedure TDScintilla.VCHome;
begin
  SendEditor(SCI_VCHOME, 0, 0);
end;

procedure TDScintilla.VCHomeExtend;
begin
  SendEditor(SCI_VCHOMEEXTEND, 0, 0);
end;

procedure TDScintilla.ZoomIn;
begin
  SendEditor(SCI_ZOOMIN, 0, 0);
end;

procedure TDScintilla.ZoomOut;
begin
  SendEditor(SCI_ZOOMOUT, 0, 0);
end;

procedure TDScintilla.DelWordLeft;
begin
  SendEditor(SCI_DELWORDLEFT, 0, 0);
end;

procedure TDScintilla.DelWordRight;
begin
  SendEditor(SCI_DELWORDRIGHT, 0, 0);
end;

procedure TDScintilla.DelWordRightEnd;
begin
  SendEditor(SCI_DELWORDRIGHTEND, 0, 0);
end;

procedure TDScintilla.LineCut;
begin
  SendEditor(SCI_LINECUT, 0, 0);
end;

procedure TDScintilla.LineDelete;
begin
  SendEditor(SCI_LINEDELETE, 0, 0);
end;

procedure TDScintilla.LineTranspose;
begin
  SendEditor(SCI_LINETRANSPOSE, 0, 0);
end;

procedure TDScintilla.LineDuplicate;
begin
  SendEditor(SCI_LINEDUPLICATE, 0, 0);
end;

procedure TDScintilla.LowerCase;
begin
  SendEditor(SCI_LOWERCASE, 0, 0);
end;

procedure TDScintilla.UpperCase;
begin
  SendEditor(SCI_UPPERCASE, 0, 0);
end;

procedure TDScintilla.LineScrollDown;
begin
  SendEditor(SCI_LINESCROLLDOWN, 0, 0);
end;

procedure TDScintilla.LineScrollUp;
begin
  SendEditor(SCI_LINESCROLLUP, 0, 0);
end;

procedure TDScintilla.DeleteBackNotLine;
begin
  SendEditor(SCI_DELETEBACKNOTLINE, 0, 0);
end;

procedure TDScintilla.HomeDisplay;
begin
  SendEditor(SCI_HOMEDISPLAY, 0, 0);
end;

procedure TDScintilla.HomeDisplayExtend;
begin
  SendEditor(SCI_HOMEDISPLAYEXTEND, 0, 0);
end;

procedure TDScintilla.LineEndDisplay;
begin
  SendEditor(SCI_LINEENDDISPLAY, 0, 0);
end;

procedure TDScintilla.LineEndDisplayExtend;
begin
  SendEditor(SCI_LINEENDDISPLAYEXTEND, 0, 0);
end;

procedure TDScintilla.HomeWrap;
begin
  SendEditor(SCI_HOMEWRAP, 0, 0);
end;

procedure TDScintilla.HomeWrapExtend;
begin
  SendEditor(SCI_HOMEWRAPEXTEND, 0, 0);
end;

procedure TDScintilla.LineEndWrap;
begin
  SendEditor(SCI_LINEENDWRAP, 0, 0);
end;

procedure TDScintilla.LineEndWrapExtend;
begin
  SendEditor(SCI_LINEENDWRAPEXTEND, 0, 0);
end;

procedure TDScintilla.VCHomeWrap;
begin
  SendEditor(SCI_VCHOMEWRAP, 0, 0);
end;

procedure TDScintilla.VCHomeWrapExtend;
begin
  SendEditor(SCI_VCHOMEWRAPEXTEND, 0, 0);
end;

procedure TDScintilla.LineCopy;
begin
  SendEditor(SCI_LINECOPY, 0, 0);
end;

procedure TDScintilla.MoveCaretInsideView;
begin
  SendEditor(SCI_MOVECARETINSIDEVIEW, 0, 0);
end;

function TDScintilla.LineLength(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_LINELENGTH, ALine, 0);
end;

procedure TDScintilla.BraceHighlight(APos1: Integer; APos2: Integer);
begin
  SendEditor(SCI_BRACEHIGHLIGHT, APos1, APos2);
end;

procedure TDScintilla.BraceHighlightIndicator(AUseBraceHighlightIndicator: Boolean; AIndicator: Integer);
begin
  SendEditor(SCI_BRACEHIGHLIGHTINDICATOR, Integer(AUseBraceHighlightIndicator), AIndicator);
end;

procedure TDScintilla.BraceBadLight(APos: Integer);
begin
  SendEditor(SCI_BRACEBADLIGHT, APos, 0);
end;

procedure TDScintilla.BraceBadLightIndicator(AUseBraceBadLightIndicator: Boolean; AIndicator: Integer);
begin
  SendEditor(SCI_BRACEBADLIGHTINDICATOR, Integer(AUseBraceBadLightIndicator), AIndicator);
end;

function TDScintilla.BraceMatch(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_BRACEMATCH, APos, 0);
end;

procedure TDScintilla.SearchAnchor;
begin
  SendEditor(SCI_SEARCHANCHOR, 0, 0);
end;

function TDScintilla.SearchNext(AFlags: Integer; const AText: UnicodeString): Integer;
begin
  Result := FHelper.SetText(SCI_SEARCHNEXT, AFlags, AText);
end;

function TDScintilla.SearchPrev(AFlags: Integer; const AText: UnicodeString): Integer;
begin
  Result := FHelper.SetText(SCI_SEARCHPREV, AFlags, AText);
end;

function TDScintilla.LinesOnScreen: Integer;
begin
  Result := SendEditor(SCI_LINESONSCREEN, 0, 0);
end;

procedure TDScintilla.UsePopUp(AAllowPopUp: Boolean);
begin
  SendEditor(SCI_USEPOPUP, Integer(AAllowPopUp), 0);
end;

function TDScintilla.SelectionIsRectangle: Boolean;
begin
  Result := Boolean(SendEditor(SCI_SELECTIONISRECTANGLE, 0, 0));
end;

function TDScintilla.CreateDocument: TDSciDocument;
begin
  Result := TDSciDocument(SendEditor(SCI_CREATEDOCUMENT, 0, 0));
end;

procedure TDScintilla.AddRefDocument(ADoc: TDSciDocument);
begin
  if ADoc <>  nil then
    SendEditor(SCI_ADDREFDOCUMENT, 0, Integer(ADoc));
end;

procedure TDScintilla.ReleaseDocument(ADoc: TDSciDocument);
begin
  if ADoc <> nil then
    SendEditor(SCI_RELEASEDOCUMENT, 0, Integer(ADoc));
end;

procedure TDScintilla.WordPartLeft;
begin
  SendEditor(SCI_WORDPARTLEFT, 0, 0);
end;

procedure TDScintilla.WordPartLeftExtend;
begin
  SendEditor(SCI_WORDPARTLEFTEXTEND, 0, 0);
end;

procedure TDScintilla.WordPartRight;
begin
  SendEditor(SCI_WORDPARTRIGHT, 0, 0);
end;

procedure TDScintilla.WordPartRightExtend;
begin
  SendEditor(SCI_WORDPARTRIGHTEXTEND, 0, 0);
end;

procedure TDScintilla.SetVisiblePolicy(AVisiblePolicy: Integer; AVisibleSlop: Integer);
begin
  SendEditor(SCI_SETVISIBLEPOLICY, AVisiblePolicy, AVisibleSlop);
end;

procedure TDScintilla.DelLineLeft;
begin
  SendEditor(SCI_DELLINELEFT, 0, 0);
end;

procedure TDScintilla.DelLineRight;
begin
  SendEditor(SCI_DELLINERIGHT, 0, 0);
end;

procedure TDScintilla.ChooseCaretX;
begin
  SendEditor(SCI_CHOOSECARETX, 0, 0);
end;

procedure TDScintilla.GrabFocus;
begin
  SendEditor(SCI_GRABFOCUS, 0, 0);
end;

procedure TDScintilla.SetXCaretPolicy(ACaretPolicy: Integer; ACaretSlop: Integer);
begin
  SendEditor(SCI_SETXCARETPOLICY, ACaretPolicy, ACaretSlop);
end;

procedure TDScintilla.SetYCaretPolicy(ACaretPolicy: Integer; ACaretSlop: Integer);
begin
  SendEditor(SCI_SETYCARETPOLICY, ACaretPolicy, ACaretSlop);
end;

procedure TDScintilla.ParaDown;
begin
  SendEditor(SCI_PARADOWN, 0, 0);
end;

procedure TDScintilla.ParaDownExtend;
begin
  SendEditor(SCI_PARADOWNEXTEND, 0, 0);
end;

procedure TDScintilla.ParaUp;
begin
  SendEditor(SCI_PARAUP, 0, 0);
end;

procedure TDScintilla.ParaUpExtend;
begin
  SendEditor(SCI_PARAUPEXTEND, 0, 0);
end;

function TDScintilla.PositionBefore(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_POSITIONBEFORE, APos, 0);
end;

function TDScintilla.PositionAfter(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_POSITIONAFTER, APos, 0);
end;

function TDScintilla.PositionRelative(APos: Integer; ARelative: Integer): Integer;
begin
  Result := SendEditor(SCI_POSITIONRELATIVE, APos, ARelative);
end;

procedure TDScintilla.CopyRange(AStart: Integer; AEnd: Integer);
begin
  SendEditor(SCI_COPYRANGE, AStart, AEnd);
end;

procedure TDScintilla.CopyText(const AText: UnicodeString);
begin
  FHelper.SetTextLen(SCI_COPYTEXT, AText);
end;
function TDScintilla.GetLineSelStartPosition(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETLINESELSTARTPOSITION, ALine, 0);
end;

function TDScintilla.GetLineSelEndPosition(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETLINESELENDPOSITION, ALine, 0);
end;

procedure TDScintilla.LineDownRectExtend;
begin
  SendEditor(SCI_LINEDOWNRECTEXTEND, 0, 0);
end;

procedure TDScintilla.LineUpRectExtend;
begin
  SendEditor(SCI_LINEUPRECTEXTEND, 0, 0);
end;

procedure TDScintilla.CharLeftRectExtend;
begin
  SendEditor(SCI_CHARLEFTRECTEXTEND, 0, 0);
end;

procedure TDScintilla.CharRightRectExtend;
begin
  SendEditor(SCI_CHARRIGHTRECTEXTEND, 0, 0);
end;

procedure TDScintilla.HomeRectExtend;
begin
  SendEditor(SCI_HOMERECTEXTEND, 0, 0);
end;

procedure TDScintilla.VCHomeRectExtend;
begin
  SendEditor(SCI_VCHOMERECTEXTEND, 0, 0);
end;

procedure TDScintilla.LineEndRectExtend;
begin
  SendEditor(SCI_LINEENDRECTEXTEND, 0, 0);
end;

procedure TDScintilla.PageUpRectExtend;
begin
  SendEditor(SCI_PAGEUPRECTEXTEND, 0, 0);
end;

procedure TDScintilla.PageDownRectExtend;
begin
  SendEditor(SCI_PAGEDOWNRECTEXTEND, 0, 0);
end;

procedure TDScintilla.StutteredPageUp;
begin
  SendEditor(SCI_STUTTEREDPAGEUP, 0, 0);
end;

procedure TDScintilla.StutteredPageUpExtend;
begin
  SendEditor(SCI_STUTTEREDPAGEUPEXTEND, 0, 0);
end;

procedure TDScintilla.StutteredPageDown;
begin
  SendEditor(SCI_STUTTEREDPAGEDOWN, 0, 0);
end;

procedure TDScintilla.StutteredPageDownExtend;
begin
  SendEditor(SCI_STUTTEREDPAGEDOWNEXTEND, 0, 0);
end;

procedure TDScintilla.WordLeftEnd;
begin
  SendEditor(SCI_WORDLEFTEND, 0, 0);
end;

procedure TDScintilla.WordLeftEndExtend;
begin
  SendEditor(SCI_WORDLEFTENDEXTEND, 0, 0);
end;

procedure TDScintilla.WordRightEnd;
begin
  SendEditor(SCI_WORDRIGHTEND, 0, 0);
end;

procedure TDScintilla.WordRightEndExtend;
begin
  SendEditor(SCI_WORDRIGHTENDEXTEND, 0, 0);
end;

procedure TDScintilla.SetCharsDefault;
begin
  SendEditor(SCI_SETCHARSDEFAULT, 0, 0);
end;

function TDScintilla.AutoCGetCurrent: Integer;
begin
  Result := SendEditor(SCI_AUTOCGETCURRENT, 0, 0);
end;

function TDScintilla.AutoCGetCurrentText: UnicodeString;
begin
  FHelper.GetText(SCI_AUTOCGETCURRENTTEXT, 0, Result);
end;

procedure TDScintilla.Allocate(ABytes: Integer);
begin
  SendEditor(SCI_ALLOCATE, ABytes, 0);
end;

// function TDScintilla.TargetAsUTF8(AS: PAnsiChar): Integer;
// begin
//   Result := SendEditor(SCI_TARGETASUTF8, 0, Integer(AS));
// end;

// procedure TDScintilla.SetLengthForEncode(ABytes: Integer);
// begin
//   SendEditor(SCI_SETLENGTHFORENCODE, ABytes, 0);
// end;

// function TDScintilla.EncodedFromUTF8(AUtf8: PAnsiChar; AEncoded: PAnsiChar): Integer;
// begin
//   Result := SendEditor(SCI_ENCODEDFROMUTF8, Integer(AUtf8), Integer(AEncoded));
// end;

function TDScintilla.FindColumn(ALine: Integer; AColumn: Integer): Integer;
begin
  Result := SendEditor(SCI_FINDCOLUMN, ALine, AColumn);
end;

procedure TDScintilla.ToggleCaretSticky;
begin
  SendEditor(SCI_TOGGLECARETSTICKY, 0, 0);
end;

procedure TDScintilla.SelectionDuplicate;
begin
  SendEditor(SCI_SELECTIONDUPLICATE, 0, 0);
end;

procedure TDScintilla.IndicatorFillRange(APosition: Integer; AFillLength: Integer);
begin
  SendEditor(SCI_INDICATORFILLRANGE, APosition, AFillLength);
end;

procedure TDScintilla.IndicatorClearRange(APosition: Integer; AClearLength: Integer);
begin
  SendEditor(SCI_INDICATORCLEARRANGE, APosition, AClearLength);
end;

function TDScintilla.IndicatorAllOnFor(APosition: Integer): Integer;
begin
  Result := SendEditor(SCI_INDICATORALLONFOR, APosition, 0);
end;

function TDScintilla.IndicatorValueAt(AIndicator: Integer; APosition: Integer): Integer;
begin
  Result := SendEditor(SCI_INDICATORVALUEAT, AIndicator, APosition);
end;

function TDScintilla.IndicatorStart(AIndicator: Integer; APosition: Integer): Integer;
begin
  Result := SendEditor(SCI_INDICATORSTART, AIndicator, APosition);
end;

function TDScintilla.IndicatorEnd(AIndicator: Integer; APosition: Integer): Integer;
begin
  Result := SendEditor(SCI_INDICATOREND, AIndicator, APosition);
end;

procedure TDScintilla.CopyAllowLine;
begin
  SendEditor(SCI_COPYALLOWLINE, 0, 0);
end;

function TDScintilla.GetGapPosition: Integer;
begin
  Result := SendEditor(SCI_GETGAPPOSITION, 0, 0);
end;

function TDScintilla.MarkerSymbolDefined(AMarkerNumber: Integer): Integer;
begin
  Result := SendEditor(SCI_MARKERSYMBOLDEFINED, AMarkerNumber, 0);
end;

procedure TDScintilla.MarginTextClearAll;
begin
  SendEditor(SCI_MARGINTEXTCLEARALL, 0, 0);
end;

procedure TDScintilla.AnnotationClearAll;
begin
  SendEditor(SCI_ANNOTATIONCLEARALL, 0, 0);
end;

procedure TDScintilla.ReleaseAllExtendedStyles;
begin
  SendEditor(SCI_RELEASEALLEXTENDEDSTYLES, 0, 0);
end;

function TDScintilla.AllocateExtendedStyles(ANumberStyles: Integer): Integer;
begin
  Result := SendEditor(SCI_ALLOCATEEXTENDEDSTYLES, ANumberStyles, 0);
end;

procedure TDScintilla.AddUndoAction(AToken: Integer; AFlags: Integer);
begin
  SendEditor(SCI_ADDUNDOACTION, AToken, AFlags);
end;

function TDScintilla.CharPositionFromPoint(AX: Integer; AY: Integer): Integer;
begin
  Result := SendEditor(SCI_CHARPOSITIONFROMPOINT, AX, AY);
end;

function TDScintilla.CharPositionFromPointClose(AX: Integer; AY: Integer): Integer;
begin
  Result := SendEditor(SCI_CHARPOSITIONFROMPOINTCLOSE, AX, AY);
end;

procedure TDScintilla.ClearSelections;
begin
  SendEditor(SCI_CLEARSELECTIONS, 0, 0);
end;

function TDScintilla.SetSelection(ACaret: Integer; AAnchor: Integer): Integer;
begin
  Result := SendEditor(SCI_SETSELECTION, ACaret, AAnchor);
end;

function TDScintilla.AddSelection(ACaret: Integer; AAnchor: Integer): Integer;
begin
  Result := SendEditor(SCI_ADDSELECTION, ACaret, AAnchor);
end;

procedure TDScintilla.DropSelectionN(ASelection: Integer);
begin
  SendEditor(SCI_DROPSELECTIONN, ASelection, 0);
end;

procedure TDScintilla.RotateSelection;
begin
  SendEditor(SCI_ROTATESELECTION, 0, 0);
end;

procedure TDScintilla.SwapMainAnchorCaret;
begin
  SendEditor(SCI_SWAPMAINANCHORCARET, 0, 0);
end;

function TDScintilla.ChangeLexerState(AStart: Integer; AEnd: Integer): Integer;
begin
  Result := SendEditor(SCI_CHANGELEXERSTATE, AStart, AEnd);
end;

function TDScintilla.ContractedFoldNext(ALineStart: Integer): Integer;
begin
  Result := SendEditor(SCI_CONTRACTEDFOLDNEXT, ALineStart, 0);
end;

procedure TDScintilla.VerticalCentreCaret;
begin
  SendEditor(SCI_VERTICALCENTRECARET, 0, 0);
end;

procedure TDScintilla.MoveSelectedLinesUp;
begin
  SendEditor(SCI_MOVESELECTEDLINESUP, 0, 0);
end;

procedure TDScintilla.MoveSelectedLinesDown;
begin
  SendEditor(SCI_MOVESELECTEDLINESDOWN, 0, 0);
end;

procedure TDScintilla.RGBAImageSetScale(AScalePercent: Integer);
begin
  SendEditor(SCI_RGBAIMAGESETSCALE, AScalePercent, 0);
end;

procedure TDScintilla.MarkerDefineRGBAImage(AMarkerNumber: Integer; APixels: PAnsiChar);
begin
  SendEditor(SCI_MARKERDEFINERGBAIMAGE, AMarkerNumber, Integer(APixels));
end;

procedure TDScintilla.RegisterRGBAImage(AType: Integer; APixels: PAnsiChar);
begin
  SendEditor(SCI_REGISTERRGBAIMAGE, AType, Integer(APixels));
end;

procedure TDScintilla.ScrollToStart;
begin
  SendEditor(SCI_SCROLLTOSTART, 0, 0);
end;

procedure TDScintilla.ScrollToEnd;
begin
  SendEditor(SCI_SCROLLTOEND, 0, 0);
end;

function TDScintilla.CreateLoader(ABytes: Integer): Pointer;
begin
  Result := Pointer(SendEditor(SCI_CREATELOADER, ABytes, 0));
end;

// procedure TDScintilla.FindIndicatorShow(AStart: Integer; AEnd: Integer);
// begin
//   SendEditor(SCI_FINDINDICATORSHOW, AStart, AEnd);
// end;

// procedure TDScintilla.FindIndicatorFlash(AStart: Integer; AEnd: Integer);
// begin
//   SendEditor(SCI_FINDINDICATORFLASH, AStart, AEnd);
// end;

// procedure TDScintilla.FindIndicatorHide;
// begin
//   SendEditor(SCI_FINDINDICATORHIDE, 0, 0);
// end;

procedure TDScintilla.VCHomeDisplay;
begin
  SendEditor(SCI_VCHOMEDISPLAY, 0, 0);
end;

procedure TDScintilla.VCHomeDisplayExtend;
begin
  SendEditor(SCI_VCHOMEDISPLAYEXTEND, 0, 0);
end;

procedure TDScintilla.ClearRepresentation(AEncodedCharacter: AnsiString);
begin
  SendEditor(SCI_CLEARREPRESENTATION, Integer(FHelper.GetPtrFromAStr(AEncodedCharacter)), 0);
end;

procedure TDScintilla.StartRecord;
begin
  SendEditor(SCI_STARTRECORD, 0, 0);
end;

procedure TDScintilla.StopRecord;
begin
  SendEditor(SCI_STOPRECORD, 0, 0);
end;

procedure TDScintilla.Colourise(AStart: Integer; AEnd: Integer);
begin
  SendEditor(SCI_COLOURISE, AStart, AEnd);
end;

procedure TDScintilla.SetKeyWords(AKeywordSet: Integer; const AKeyWords: UnicodeString);
begin
  FHelper.SetText(SCI_SETKEYWORDS, AKeywordSet, AKeyWords);
end;

procedure TDScintilla.SetLexerLanguage(const ALanguage: UnicodeString);
begin
  SendEditor(SCI_SETLEXERLANGUAGE, 0, Integer(AnsiString(ALanguage)));
end;

procedure TDScintilla.LoadLexerLibrary(const APath: UnicodeString);
begin
  SendEditor(SCI_LOADLEXERLIBRARY, 0, Integer(AnsiString(APath)));
end;

function TDScintilla.GetProperty(const AKey: UnicodeString): UnicodeString;
begin
  if AKey = '' then
    Result := ''
  else
    FHelper.GetText(SCI_GETPROPERTY, Integer(AnsiString(AKey)), Result);
end;

function TDScintilla.GetPropertyExpanded(const AKey: UnicodeString): UnicodeString;
begin
  if AKey = '' then
    Result := ''
  else
    FHelper.GetText(SCI_GETPROPERTYEXPANDED, Integer(AnsiString(AKey)), Result);
end;

function TDScintilla.PrivateLexerCall(AOperation: Integer; APointer: Integer): Integer;
begin
  Result := SendEditor(SCI_PRIVATELEXERCALL, AOperation, APointer);
end;

function TDScintilla.PropertyNames: UnicodeString;
begin
  FHelper.GetText(SCI_PROPERTYNAMES, 0, Result);
end;

function TDScintilla.PropertyType(AName: UnicodeString): Integer;
begin
  if AName = '' then
    Result := -1
  else
    Result := SendEditor(SCI_PROPERTYTYPE, Integer(UnicodeStringToUTF8(AName)), 0);
end;

function TDScintilla.DescribeProperty(AName: UnicodeString): UnicodeString;
begin
  if AName = '' then
    Result := ''
  else
    FHelper.GetText(SCI_DESCRIBEPROPERTY, Integer(UnicodeStringToUTF8(AName)), Result);
end;

function TDScintilla.DescribeKeyWordSets: UnicodeString;
begin
  FHelper.GetText(SCI_DESCRIBEKEYWORDSETS, 0, Result);
end;

function TDScintilla.AllocateSubStyles(AStyleBase: Integer; ANumberStyles: Integer): Integer;
begin
  Result := SendEditor(SCI_ALLOCATESUBSTYLES, AStyleBase, ANumberStyles);
end;

procedure TDScintilla.FreeSubStyles;
begin
  SendEditor(SCI_FREESUBSTYLES, 0, 0);
end;

