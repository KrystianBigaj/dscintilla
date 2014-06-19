function TDScintilla.GetLength: Integer;
begin
  Result := SendEditor(SCI_GETLENGTH, 0, 0);
end;

function TDScintilla.GetCharAt(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_GETCHARAT, APos, 0);
end;

function TDScintilla.GetCurrentPos: Integer;
begin
  Result := SendEditor(SCI_GETCURRENTPOS, 0, 0);
end;

function TDScintilla.GetAnchor: Integer;
begin
  Result := SendEditor(SCI_GETANCHOR, 0, 0);
end;

function TDScintilla.GetStyleAt(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_GETSTYLEAT, APos, 0);
end;

procedure TDScintilla.SetUndoCollection(ACollectUndo: Boolean);
begin
  SendEditor(SCI_SETUNDOCOLLECTION, Integer(ACollectUndo), 0);
end;

function TDScintilla.GetUndoCollection: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETUNDOCOLLECTION, 0, 0));
end;

function TDScintilla.GetViewWS: Integer;
begin
  Result := SendEditor(SCI_GETVIEWWS, 0, 0);
end;

procedure TDScintilla.SetViewWS(AViewWS: Integer);
begin
  SendEditor(SCI_SETVIEWWS, AViewWS, 0);
end;

procedure TDScintilla.SetAnchor(APosAnchor: Integer);
begin
  SendEditor(SCI_SETANCHOR, APosAnchor, 0);
end;

function TDScintilla.GetEndStyled: Integer;
begin
  Result := SendEditor(SCI_GETENDSTYLED, 0, 0);
end;

function TDScintilla.GetEOLMode: Integer;
begin
  Result := SendEditor(SCI_GETEOLMODE, 0, 0);
end;

procedure TDScintilla.SetEOLMode(AEolMode: Integer);
begin
  SendEditor(SCI_SETEOLMODE, AEolMode, 0);
end;

function TDScintilla.GetBufferedDraw: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETBUFFEREDDRAW, 0, 0));
end;

procedure TDScintilla.SetBufferedDraw(ABuffered: Boolean);
begin
  SendEditor(SCI_SETBUFFEREDDRAW, Integer(ABuffered), 0);
end;

procedure TDScintilla.SetTabWidth(ATabWidth: Integer);
begin
  SendEditor(SCI_SETTABWIDTH, ATabWidth, 0);
end;

function TDScintilla.GetTabWidth: Integer;
begin
  Result := SendEditor(SCI_GETTABWIDTH, 0, 0);
end;

procedure TDScintilla.SetCodePage(ACodePage: Integer);
begin
  SendEditor(SCI_SETCODEPAGE, ACodePage, 0);
end;

procedure TDScintilla.SetMarginTypeN(AMargin: Integer; AMarginType: Integer);
begin
  SendEditor(SCI_SETMARGINTYPEN, AMargin, AMarginType);
end;

function TDScintilla.GetMarginTypeN(AMargin: Integer): Integer;
begin
  Result := SendEditor(SCI_GETMARGINTYPEN, AMargin, 0);
end;

procedure TDScintilla.SetMarginWidthN(AMargin: Integer; APixelWidth: Integer);
begin
  SendEditor(SCI_SETMARGINWIDTHN, AMargin, APixelWidth);
end;

function TDScintilla.GetMarginWidthN(AMargin: Integer): Integer;
begin
  Result := SendEditor(SCI_GETMARGINWIDTHN, AMargin, 0);
end;

procedure TDScintilla.SetMarginMaskN(AMargin: Integer; AMask: Integer);
begin
  SendEditor(SCI_SETMARGINMASKN, AMargin, AMask);
end;

function TDScintilla.GetMarginMaskN(AMargin: Integer): Integer;
begin
  Result := SendEditor(SCI_GETMARGINMASKN, AMargin, 0);
end;

procedure TDScintilla.SetMarginSensitiveN(AMargin: Integer; ASensitive: Boolean);
begin
  SendEditor(SCI_SETMARGINSENSITIVEN, AMargin, Integer(ASensitive));
end;

function TDScintilla.GetMarginSensitiveN(AMargin: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETMARGINSENSITIVEN, AMargin, 0));
end;

procedure TDScintilla.SetMarginCursorN(AMargin: Integer; ACursor: Integer);
begin
  SendEditor(SCI_SETMARGINCURSORN, AMargin, ACursor);
end;

function TDScintilla.GetMarginCursorN(AMargin: Integer): Integer;
begin
  Result := SendEditor(SCI_GETMARGINCURSORN, AMargin, 0);
end;

procedure TDScintilla.StyleSetFore(AStyle: Integer; AFore: TColor);
begin
  SendEditor(SCI_STYLESETFORE, AStyle, Integer(AFore));
end;

procedure TDScintilla.StyleSetBack(AStyle: Integer; ABack: TColor);
begin
  SendEditor(SCI_STYLESETBACK, AStyle, Integer(ABack));
end;

procedure TDScintilla.StyleSetBold(AStyle: Integer; ABold: Boolean);
begin
  SendEditor(SCI_STYLESETBOLD, AStyle, Integer(ABold));
end;

procedure TDScintilla.StyleSetItalic(AStyle: Integer; AItalic: Boolean);
begin
  SendEditor(SCI_STYLESETITALIC, AStyle, Integer(AItalic));
end;

procedure TDScintilla.StyleSetSize(AStyle: Integer; ASizePoints: Integer);
begin
  SendEditor(SCI_STYLESETSIZE, AStyle, ASizePoints);
end;

procedure TDScintilla.StyleSetFont(AStyle: Integer; const AFontName: UnicodeString);
begin
  SendEditor(SCI_STYLESETFONT, AStyle, Integer(AnsiString(AFontName)));
end;

procedure TDScintilla.StyleSetEOLFilled(AStyle: Integer; AFilled: Boolean);
begin
  SendEditor(SCI_STYLESETEOLFILLED, AStyle, Integer(AFilled));
end;

procedure TDScintilla.StyleSetUnderline(AStyle: Integer; AUnderline: Boolean);
begin
  SendEditor(SCI_STYLESETUNDERLINE, AStyle, Integer(AUnderline));
end;

function TDScintilla.StyleGetFore(AStyle: Integer): TColor;
begin
  Result := TColor(SendEditor(SCI_STYLEGETFORE, AStyle, 0));
end;

function TDScintilla.StyleGetBack(AStyle: Integer): TColor;
begin
  Result := TColor(SendEditor(SCI_STYLEGETBACK, AStyle, 0));
end;

function TDScintilla.StyleGetBold(AStyle: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_STYLEGETBOLD, AStyle, 0));
end;

function TDScintilla.StyleGetItalic(AStyle: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_STYLEGETITALIC, AStyle, 0));
end;

function TDScintilla.StyleGetSize(AStyle: Integer): Integer;
begin
  Result := SendEditor(SCI_STYLEGETSIZE, AStyle, 0);
end;

function TDScintilla.StyleGetEOLFilled(AStyle: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_STYLEGETEOLFILLED, AStyle, 0));
end;

function TDScintilla.StyleGetUnderline(AStyle: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_STYLEGETUNDERLINE, AStyle, 0));
end;

function TDScintilla.StyleGetCase(AStyle: Integer): Integer;
begin
  Result := SendEditor(SCI_STYLEGETCASE, AStyle, 0);
end;

function TDScintilla.StyleGetCharacterSet(AStyle: Integer): Integer;
begin
  Result := SendEditor(SCI_STYLEGETCHARACTERSET, AStyle, 0);
end;

function TDScintilla.StyleGetVisible(AStyle: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_STYLEGETVISIBLE, AStyle, 0));
end;

function TDScintilla.StyleGetChangeable(AStyle: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_STYLEGETCHANGEABLE, AStyle, 0));
end;

function TDScintilla.StyleGetHotSpot(AStyle: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_STYLEGETHOTSPOT, AStyle, 0));
end;

procedure TDScintilla.StyleSetCase(AStyle: Integer; ACaseForce: Integer);
begin
  SendEditor(SCI_STYLESETCASE, AStyle, ACaseForce);
end;

procedure TDScintilla.StyleSetSizeFractional(AStyle: Integer; ACaseForce: Integer);
begin
  SendEditor(SCI_STYLESETSIZEFRACTIONAL, AStyle, ACaseForce);
end;

function TDScintilla.StyleGetSizeFractional(AStyle: Integer): Integer;
begin
  Result := SendEditor(SCI_STYLEGETSIZEFRACTIONAL, AStyle, 0);
end;

procedure TDScintilla.StyleSetWeight(AStyle: Integer; AWeight: Integer);
begin
  SendEditor(SCI_STYLESETWEIGHT, AStyle, AWeight);
end;

function TDScintilla.StyleGetWeight(AStyle: Integer): Integer;
begin
  Result := SendEditor(SCI_STYLEGETWEIGHT, AStyle, 0);
end;

procedure TDScintilla.StyleSetCharacterSet(AStyle: Integer; ACharacterSet: Integer);
begin
  SendEditor(SCI_STYLESETCHARACTERSET, AStyle, ACharacterSet);
end;

procedure TDScintilla.StyleSetHotSpot(AStyle: Integer; AHotspot: Boolean);
begin
  SendEditor(SCI_STYLESETHOTSPOT, AStyle, Integer(AHotspot));
end;

function TDScintilla.GetSelAlpha: Integer;
begin
  Result := SendEditor(SCI_GETSELALPHA, 0, 0);
end;

procedure TDScintilla.SetSelAlpha(AAlpha: Integer);
begin
  SendEditor(SCI_SETSELALPHA, AAlpha, 0);
end;

function TDScintilla.GetSelEOLFilled: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETSELEOLFILLED, 0, 0));
end;

procedure TDScintilla.SetSelEOLFilled(AFilled: Boolean);
begin
  SendEditor(SCI_SETSELEOLFILLED, Integer(AFilled), 0);
end;

procedure TDScintilla.SetCaretFore(AFore: TColor);
begin
  SendEditor(SCI_SETCARETFORE, Integer(AFore), 0);
end;

procedure TDScintilla.StyleSetVisible(AStyle: Integer; AVisible: Boolean);
begin
  SendEditor(SCI_STYLESETVISIBLE, AStyle, Integer(AVisible));
end;

function TDScintilla.GetCaretPeriod: Integer;
begin
  Result := SendEditor(SCI_GETCARETPERIOD, 0, 0);
end;

procedure TDScintilla.SetCaretPeriod(APeriodMilliseconds: Integer);
begin
  SendEditor(SCI_SETCARETPERIOD, APeriodMilliseconds, 0);
end;

procedure TDScintilla.SetWordChars(const ACharacters: AnsiString);
begin
  FHelper.SetTextA(SCI_SETWORDCHARS, 0, ACharacters);
end;

function TDScintilla.GetWordChars: AnsiString;
begin
  FHelper.GetTextA(SCI_GETWORDCHARS, 0, Result);
end;

procedure TDScintilla.IndicSetStyle(AIndic: Integer; AStyle: Integer);
begin
  SendEditor(SCI_INDICSETSTYLE, AIndic, AStyle);
end;

function TDScintilla.IndicGetStyle(AIndic: Integer): Integer;
begin
  Result := SendEditor(SCI_INDICGETSTYLE, AIndic, 0);
end;

procedure TDScintilla.IndicSetFore(AIndic: Integer; AFore: TColor);
begin
  SendEditor(SCI_INDICSETFORE, AIndic, Integer(AFore));
end;

function TDScintilla.IndicGetFore(AIndic: Integer): TColor;
begin
  Result := TColor(SendEditor(SCI_INDICGETFORE, AIndic, 0));
end;

procedure TDScintilla.IndicSetUnder(AIndic: Integer; AUnder: Boolean);
begin
  SendEditor(SCI_INDICSETUNDER, AIndic, Integer(AUnder));
end;

function TDScintilla.IndicGetUnder(AIndic: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_INDICGETUNDER, AIndic, 0));
end;

procedure TDScintilla.SetWhitespaceSize(ASize: Integer);
begin
  SendEditor(SCI_SETWHITESPACESIZE, ASize, 0);
end;

function TDScintilla.GetWhitespaceSize: Integer;
begin
  Result := SendEditor(SCI_GETWHITESPACESIZE, 0, 0);
end;

procedure TDScintilla.SetStyleBits(ABits: Integer);
begin
  SendEditor(SCI_SETSTYLEBITS, ABits, 0);
end;

function TDScintilla.GetStyleBits: Integer;
begin
  Result := SendEditor(SCI_GETSTYLEBITS, 0, 0);
end;

procedure TDScintilla.SetLineState(ALine: Integer; AState: Integer);
begin
  SendEditor(SCI_SETLINESTATE, ALine, AState);
end;

function TDScintilla.GetLineState(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETLINESTATE, ALine, 0);
end;

function TDScintilla.GetMaxLineState: Integer;
begin
  Result := SendEditor(SCI_GETMAXLINESTATE, 0, 0);
end;

function TDScintilla.GetCaretLineVisible: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETCARETLINEVISIBLE, 0, 0));
end;

procedure TDScintilla.SetCaretLineVisible(AShow: Boolean);
begin
  SendEditor(SCI_SETCARETLINEVISIBLE, Integer(AShow), 0);
end;

function TDScintilla.GetCaretLineBack: TColor;
begin
  Result := TColor(SendEditor(SCI_GETCARETLINEBACK, 0, 0));
end;

procedure TDScintilla.SetCaretLineBack(ABack: TColor);
begin
  SendEditor(SCI_SETCARETLINEBACK, Integer(ABack), 0);
end;

procedure TDScintilla.StyleSetChangeable(AStyle: Integer; AChangeable: Boolean);
begin
  SendEditor(SCI_STYLESETCHANGEABLE, AStyle, Integer(AChangeable));
end;

procedure TDScintilla.AutoCSetSeparator(ASeparatorCharacter: AnsiChar);
begin
  SendEditor(SCI_AUTOCSETSEPARATOR, Integer(ASeparatorCharacter), 0);
end;

function TDScintilla.AutoCGetSeparator: AnsiChar;
begin
  Result := AnsiChar(SendEditor(SCI_AUTOCGETSEPARATOR, 0, 0));
end;

procedure TDScintilla.AutoCSetCancelAtStart(ACancel: Boolean);
begin
  SendEditor(SCI_AUTOCSETCANCELATSTART, Integer(ACancel), 0);
end;

function TDScintilla.AutoCGetCancelAtStart: Boolean;
begin
  Result := Boolean(SendEditor(SCI_AUTOCGETCANCELATSTART, 0, 0));
end;

procedure TDScintilla.AutoCSetFillUps(const ACharacterSet: UnicodeString);
begin
  FHelper.SetText(SCI_AUTOCSETFILLUPS, 0, ACharacterSet);
end;

procedure TDScintilla.AutoCSetChooseSingle(AChooseSingle: Boolean);
begin
  SendEditor(SCI_AUTOCSETCHOOSESINGLE, Integer(AChooseSingle), 0);
end;

function TDScintilla.AutoCGetChooseSingle: Boolean;
begin
  Result := Boolean(SendEditor(SCI_AUTOCGETCHOOSESINGLE, 0, 0));
end;

procedure TDScintilla.AutoCSetIgnoreCase(AIgnoreCase: Boolean);
begin
  SendEditor(SCI_AUTOCSETIGNORECASE, Integer(AIgnoreCase), 0);
end;

function TDScintilla.AutoCGetIgnoreCase: Boolean;
begin
  Result := Boolean(SendEditor(SCI_AUTOCGETIGNORECASE, 0, 0));
end;

procedure TDScintilla.AutoCSetAutoHide(AAutoHide: Boolean);
begin
  SendEditor(SCI_AUTOCSETAUTOHIDE, Integer(AAutoHide), 0);
end;

function TDScintilla.AutoCGetAutoHide: Boolean;
begin
  Result := Boolean(SendEditor(SCI_AUTOCGETAUTOHIDE, 0, 0));
end;

procedure TDScintilla.AutoCSetDropRestOfWord(ADropRestOfWord: Boolean);
begin
  SendEditor(SCI_AUTOCSETDROPRESTOFWORD, Integer(ADropRestOfWord), 0);
end;

function TDScintilla.AutoCGetDropRestOfWord: Boolean;
begin
  Result := Boolean(SendEditor(SCI_AUTOCGETDROPRESTOFWORD, 0, 0));
end;

function TDScintilla.AutoCGetTypeSeparator: AnsiChar;
begin
  Result := AnsiChar(SendEditor(SCI_AUTOCGETTYPESEPARATOR, 0, 0));
end;

procedure TDScintilla.AutoCSetTypeSeparator(ASeparatorCharacter: AnsiChar);
begin
  SendEditor(SCI_AUTOCSETTYPESEPARATOR, Integer(ASeparatorCharacter), 0);
end;

procedure TDScintilla.AutoCSetMaxWidth(ACharacterCount: Integer);
begin
  SendEditor(SCI_AUTOCSETMAXWIDTH, ACharacterCount, 0);
end;

function TDScintilla.AutoCGetMaxWidth: Integer;
begin
  Result := SendEditor(SCI_AUTOCGETMAXWIDTH, 0, 0);
end;

procedure TDScintilla.AutoCSetMaxHeight(ARowCount: Integer);
begin
  SendEditor(SCI_AUTOCSETMAXHEIGHT, ARowCount, 0);
end;

function TDScintilla.AutoCGetMaxHeight: Integer;
begin
  Result := SendEditor(SCI_AUTOCGETMAXHEIGHT, 0, 0);
end;

procedure TDScintilla.SetIndent(AIndentSize: Integer);
begin
  SendEditor(SCI_SETINDENT, AIndentSize, 0);
end;

function TDScintilla.GetIndent: Integer;
begin
  Result := SendEditor(SCI_GETINDENT, 0, 0);
end;

procedure TDScintilla.SetUseTabs(AUseTabs: Boolean);
begin
  SendEditor(SCI_SETUSETABS, Integer(AUseTabs), 0);
end;

function TDScintilla.GetUseTabs: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETUSETABS, 0, 0));
end;

procedure TDScintilla.SetLineIndentation(ALine: Integer; AIndentSize: Integer);
begin
  SendEditor(SCI_SETLINEINDENTATION, ALine, AIndentSize);
end;

function TDScintilla.GetLineIndentation(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETLINEINDENTATION, ALine, 0);
end;

function TDScintilla.GetLineIndentPosition(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETLINEINDENTPOSITION, ALine, 0);
end;

function TDScintilla.GetColumn(APos: Integer): Integer;
begin
  Result := SendEditor(SCI_GETCOLUMN, APos, 0);
end;

procedure TDScintilla.SetHScrollBar(AShow: Boolean);
begin
  SendEditor(SCI_SETHSCROLLBAR, Integer(AShow), 0);
end;

function TDScintilla.GetHScrollBar: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETHSCROLLBAR, 0, 0));
end;

procedure TDScintilla.SetIndentationGuides(AIndentView: Integer);
begin
  SendEditor(SCI_SETINDENTATIONGUIDES, AIndentView, 0);
end;

function TDScintilla.GetIndentationGuides: Integer;
begin
  Result := SendEditor(SCI_GETINDENTATIONGUIDES, 0, 0);
end;

procedure TDScintilla.SetHighlightGuide(AColumn: Integer);
begin
  SendEditor(SCI_SETHIGHLIGHTGUIDE, AColumn, 0);
end;

function TDScintilla.GetHighlightGuide: Integer;
begin
  Result := SendEditor(SCI_GETHIGHLIGHTGUIDE, 0, 0);
end;

function TDScintilla.GetLineEndPosition(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETLINEENDPOSITION, ALine, 0);
end;

function TDScintilla.GetCodePage: Integer;
begin
  Result := SendEditor(SCI_GETCODEPAGE, 0, 0);
end;

function TDScintilla.GetCaretFore: TColor;
begin
  Result := TColor(SendEditor(SCI_GETCARETFORE, 0, 0));
end;

function TDScintilla.GetReadOnly: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETREADONLY, 0, 0));
end;

procedure TDScintilla.SetCurrentPos(APos: Integer);
begin
  SendEditor(SCI_SETCURRENTPOS, APos, 0);
end;

procedure TDScintilla.SetSelectionStart(APos: Integer);
begin
  SendEditor(SCI_SETSELECTIONSTART, APos, 0);
end;

function TDScintilla.GetSelectionStart: Integer;
begin
  Result := SendEditor(SCI_GETSELECTIONSTART, 0, 0);
end;

procedure TDScintilla.SetSelectionEnd(APos: Integer);
begin
  SendEditor(SCI_SETSELECTIONEND, APos, 0);
end;

function TDScintilla.GetSelectionEnd: Integer;
begin
  Result := SendEditor(SCI_GETSELECTIONEND, 0, 0);
end;

procedure TDScintilla.SetPrintMagnification(AMagnification: Integer);
begin
  SendEditor(SCI_SETPRINTMAGNIFICATION, AMagnification, 0);
end;

function TDScintilla.GetPrintMagnification: Integer;
begin
  Result := SendEditor(SCI_GETPRINTMAGNIFICATION, 0, 0);
end;

procedure TDScintilla.SetPrintColourMode(AMode: Integer);
begin
  SendEditor(SCI_SETPRINTCOLOURMODE, AMode, 0);
end;

function TDScintilla.GetPrintColourMode: Integer;
begin
  Result := SendEditor(SCI_GETPRINTCOLOURMODE, 0, 0);
end;

function TDScintilla.GetFirstVisibleLine: Integer;
begin
  Result := SendEditor(SCI_GETFIRSTVISIBLELINE, 0, 0);
end;

function TDScintilla.GetLineCount: Integer;
begin
  Result := SendEditor(SCI_GETLINECOUNT, 0, 0);
end;

procedure TDScintilla.SetMarginLeft(APixelWidth: Integer);
begin
  SendEditor(SCI_SETMARGINLEFT, 0, APixelWidth);
end;

function TDScintilla.GetMarginLeft: Integer;
begin
  Result := SendEditor(SCI_GETMARGINLEFT, 0, 0);
end;

procedure TDScintilla.SetMarginRight(APixelWidth: Integer);
begin
  SendEditor(SCI_SETMARGINRIGHT, 0, APixelWidth);
end;

function TDScintilla.GetMarginRight: Integer;
begin
  Result := SendEditor(SCI_GETMARGINRIGHT, 0, 0);
end;

function TDScintilla.GetModify: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETMODIFY, 0, 0));
end;

procedure TDScintilla.SetReadOnly(AReadOnly: Boolean);
begin
  SendEditor(SCI_SETREADONLY, Integer(AReadOnly), 0);
end;

function TDScintilla.GetTextLength: Integer;
begin
  Result := SendEditor(SCI_GETTEXTLENGTH, 0, 0);
end;

function TDScintilla.GetDirectFunction: TDScintillaFunction;
begin
  Result := TDScintillaFunction(SendEditor(SCI_GETDIRECTFUNCTION, 0, 0));
end;

function TDScintilla.GetDirectPointer: Pointer;
begin
  Result := Pointer(SendEditor(SCI_GETDIRECTPOINTER, 0, 0));
end;

procedure TDScintilla.SetOvertype(AOvertype: Boolean);
begin
  SendEditor(SCI_SETOVERTYPE, Integer(AOvertype), 0);
end;

function TDScintilla.GetOvertype: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETOVERTYPE, 0, 0));
end;

procedure TDScintilla.SetCaretWidth(APixelWidth: Integer);
begin
  SendEditor(SCI_SETCARETWIDTH, APixelWidth, 0);
end;

function TDScintilla.GetCaretWidth: Integer;
begin
  Result := SendEditor(SCI_GETCARETWIDTH, 0, 0);
end;

procedure TDScintilla.SetTargetStart(APos: Integer);
begin
  SendEditor(SCI_SETTARGETSTART, APos, 0);
end;

function TDScintilla.GetTargetStart: Integer;
begin
  Result := SendEditor(SCI_GETTARGETSTART, 0, 0);
end;

procedure TDScintilla.SetTargetEnd(APos: Integer);
begin
  SendEditor(SCI_SETTARGETEND, APos, 0);
end;

function TDScintilla.GetTargetEnd: Integer;
begin
  Result := SendEditor(SCI_GETTARGETEND, 0, 0);
end;

procedure TDScintilla.SetSearchFlags(AFlags: Integer);
begin
  SendEditor(SCI_SETSEARCHFLAGS, AFlags, 0);
end;

function TDScintilla.GetSearchFlags: Integer;
begin
  Result := SendEditor(SCI_GETSEARCHFLAGS, 0, 0);
end;

procedure TDScintilla.CallTipSetPosStart(APosStart: Integer);
begin
  SendEditor(SCI_CALLTIPSETPOSSTART, APosStart, 0);
end;

procedure TDScintilla.CallTipSetBack(ABack: TColor);
begin
  SendEditor(SCI_CALLTIPSETBACK, Integer(ABack), 0);
end;

procedure TDScintilla.CallTipSetFore(AFore: TColor);
begin
  SendEditor(SCI_CALLTIPSETFORE, Integer(AFore), 0);
end;

procedure TDScintilla.CallTipSetForeHlt(AFore: TColor);
begin
  SendEditor(SCI_CALLTIPSETFOREHLT, Integer(AFore), 0);
end;

procedure TDScintilla.CallTipUseStyle(ATabSize: Integer);
begin
  SendEditor(SCI_CALLTIPUSESTYLE, ATabSize, 0);
end;

procedure TDScintilla.CallTipSetPosition(AAbove: Boolean);
begin
  SendEditor(SCI_CALLTIPSETPOSITION, Integer(AAbove), 0);
end;

procedure TDScintilla.SetFoldLevel(ALine: Integer; ALevel: Integer);
begin
  SendEditor(SCI_SETFOLDLEVEL, ALine, ALevel);
end;

function TDScintilla.GetFoldLevel(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETFOLDLEVEL, ALine, 0);
end;

function TDScintilla.GetLastChild(ALine: Integer; ALevel: Integer): Integer;
begin
  Result := SendEditor(SCI_GETLASTCHILD, ALine, ALevel);
end;

function TDScintilla.GetFoldParent(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_GETFOLDPARENT, ALine, 0);
end;

function TDScintilla.GetLineVisible(ALine: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETLINEVISIBLE, ALine, 0));
end;

function TDScintilla.GetAllLinesVisible: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETALLLINESVISIBLE, 0, 0));
end;

procedure TDScintilla.SetFoldExpanded(ALine: Integer; AExpanded: Boolean);
begin
  SendEditor(SCI_SETFOLDEXPANDED, ALine, Integer(AExpanded));
end;

function TDScintilla.GetFoldExpanded(ALine: Integer): Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETFOLDEXPANDED, ALine, 0));
end;

procedure TDScintilla.SetAutomaticFold(AAutomaticFold: Integer);
begin
  SendEditor(SCI_SETAUTOMATICFOLD, AAutomaticFold, 0);
end;

function TDScintilla.GetAutomaticFold: Integer;
begin
  Result := SendEditor(SCI_GETAUTOMATICFOLD, 0, 0);
end;

procedure TDScintilla.SetTabIndents(ATabIndents: Boolean);
begin
  SendEditor(SCI_SETTABINDENTS, Integer(ATabIndents), 0);
end;

function TDScintilla.GetTabIndents: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETTABINDENTS, 0, 0));
end;

procedure TDScintilla.SetBackSpaceUnIndents(ABsUnIndents: Boolean);
begin
  SendEditor(SCI_SETBACKSPACEUNINDENTS, Integer(ABsUnIndents), 0);
end;

function TDScintilla.GetBackSpaceUnIndents: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETBACKSPACEUNINDENTS, 0, 0));
end;

procedure TDScintilla.SetMouseDwellTime(APeriodMilliseconds: Integer);
begin
  SendEditor(SCI_SETMOUSEDWELLTIME, APeriodMilliseconds, 0);
end;

function TDScintilla.GetMouseDwellTime: Integer;
begin
  Result := SendEditor(SCI_GETMOUSEDWELLTIME, 0, 0);
end;

procedure TDScintilla.SetWrapMode(AMode: Integer);
begin
  SendEditor(SCI_SETWRAPMODE, AMode, 0);
end;

function TDScintilla.GetWrapMode: Integer;
begin
  Result := SendEditor(SCI_GETWRAPMODE, 0, 0);
end;

procedure TDScintilla.SetWrapVisualFlags(AWrapVisualFlags: Integer);
begin
  SendEditor(SCI_SETWRAPVISUALFLAGS, AWrapVisualFlags, 0);
end;

function TDScintilla.GetWrapVisualFlags: Integer;
begin
  Result := SendEditor(SCI_GETWRAPVISUALFLAGS, 0, 0);
end;

procedure TDScintilla.SetWrapVisualFlagsLocation(AWrapVisualFlagsLocation: Integer);
begin
  SendEditor(SCI_SETWRAPVISUALFLAGSLOCATION, AWrapVisualFlagsLocation, 0);
end;

function TDScintilla.GetWrapVisualFlagsLocation: Integer;
begin
  Result := SendEditor(SCI_GETWRAPVISUALFLAGSLOCATION, 0, 0);
end;

procedure TDScintilla.SetWrapStartIndent(AIndent: Integer);
begin
  SendEditor(SCI_SETWRAPSTARTINDENT, AIndent, 0);
end;

function TDScintilla.GetWrapStartIndent: Integer;
begin
  Result := SendEditor(SCI_GETWRAPSTARTINDENT, 0, 0);
end;

procedure TDScintilla.SetWrapIndentMode(AMode: Integer);
begin
  SendEditor(SCI_SETWRAPINDENTMODE, AMode, 0);
end;

function TDScintilla.GetWrapIndentMode: Integer;
begin
  Result := SendEditor(SCI_GETWRAPINDENTMODE, 0, 0);
end;

procedure TDScintilla.SetLayoutCache(AMode: Integer);
begin
  SendEditor(SCI_SETLAYOUTCACHE, AMode, 0);
end;

function TDScintilla.GetLayoutCache: Integer;
begin
  Result := SendEditor(SCI_GETLAYOUTCACHE, 0, 0);
end;

procedure TDScintilla.SetScrollWidth(APixelWidth: Integer);
begin
  SendEditor(SCI_SETSCROLLWIDTH, APixelWidth, 0);
end;

function TDScintilla.GetScrollWidth: Integer;
begin
  Result := SendEditor(SCI_GETSCROLLWIDTH, 0, 0);
end;

procedure TDScintilla.SetScrollWidthTracking(ATracking: Boolean);
begin
  SendEditor(SCI_SETSCROLLWIDTHTRACKING, Integer(ATracking), 0);
end;

function TDScintilla.GetScrollWidthTracking: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETSCROLLWIDTHTRACKING, 0, 0));
end;

procedure TDScintilla.SetEndAtLastLine(AEndAtLastLine: Boolean);
begin
  SendEditor(SCI_SETENDATLASTLINE, Integer(AEndAtLastLine), 0);
end;

function TDScintilla.GetEndAtLastLine: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETENDATLASTLINE, 0, 0));
end;

procedure TDScintilla.SetVScrollBar(AShow: Boolean);
begin
  SendEditor(SCI_SETVSCROLLBAR, Integer(AShow), 0);
end;

function TDScintilla.GetVScrollBar: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETVSCROLLBAR, 0, 0));
end;

function TDScintilla.GetTwoPhaseDraw: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETTWOPHASEDRAW, 0, 0));
end;

procedure TDScintilla.SetTwoPhaseDraw(ATwoPhase: Boolean);
begin
  SendEditor(SCI_SETTWOPHASEDRAW, Integer(ATwoPhase), 0);
end;

procedure TDScintilla.SetFontQuality(AFontQuality: Integer);
begin
  SendEditor(SCI_SETFONTQUALITY, AFontQuality, 0);
end;

function TDScintilla.GetFontQuality: Integer;
begin
  Result := SendEditor(SCI_GETFONTQUALITY, 0, 0);
end;

procedure TDScintilla.SetFirstVisibleLine(ALineDisplay: Integer);
begin
  SendEditor(SCI_SETFIRSTVISIBLELINE, ALineDisplay, 0);
end;

procedure TDScintilla.SetMultiPaste(AMultiPaste: Integer);
begin
  SendEditor(SCI_SETMULTIPASTE, AMultiPaste, 0);
end;

function TDScintilla.GetMultiPaste: Integer;
begin
  Result := SendEditor(SCI_GETMULTIPASTE, 0, 0);
end;

function TDScintilla.GetViewEOL: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETVIEWEOL, 0, 0));
end;

procedure TDScintilla.SetViewEOL(AVisible: Boolean);
begin
  SendEditor(SCI_SETVIEWEOL, Integer(AVisible), 0);
end;

function TDScintilla.GetDocPointer: TDSciDocument;
begin
  Result := TDSciDocument(SendEditor(SCI_GETDOCPOINTER, 0, 0));
end;

procedure TDScintilla.SetDocPointer(APointer: TDSciDocument);
begin
  if APointer <> nil then
    SendEditor(SCI_SETDOCPOINTER, 0, Integer(APointer));
end;

procedure TDScintilla.SetModEventMask(AMask: Integer);
begin
  SendEditor(SCI_SETMODEVENTMASK, AMask, 0);
end;

function TDScintilla.GetEdgeColumn: Integer;
begin
  Result := SendEditor(SCI_GETEDGECOLUMN, 0, 0);
end;

procedure TDScintilla.SetEdgeColumn(AColumn: Integer);
begin
  SendEditor(SCI_SETEDGECOLUMN, AColumn, 0);
end;

function TDScintilla.GetEdgeMode: Integer;
begin
  Result := SendEditor(SCI_GETEDGEMODE, 0, 0);
end;

procedure TDScintilla.SetEdgeMode(AMode: Integer);
begin
  SendEditor(SCI_SETEDGEMODE, AMode, 0);
end;

function TDScintilla.GetEdgeColour: TColor;
begin
  Result := TColor(SendEditor(SCI_GETEDGECOLOUR, 0, 0));
end;

procedure TDScintilla.SetEdgeColour(AEdgeColour: TColor);
begin
  SendEditor(SCI_SETEDGECOLOUR, Integer(AEdgeColour), 0);
end;

procedure TDScintilla.SetZoom(AZoom: Integer);
begin
  SendEditor(SCI_SETZOOM, AZoom, 0);
end;

function TDScintilla.GetZoom: Integer;
begin
  Result := SendEditor(SCI_GETZOOM, 0, 0);
end;

function TDScintilla.GetModEventMask: Integer;
begin
  Result := SendEditor(SCI_GETMODEVENTMASK, 0, 0);
end;

procedure TDScintilla.SetFocus(AFocus: Boolean);
begin
  SendEditor(SCI_SETFOCUS, Integer(AFocus), 0);
end;

function TDScintilla.GetFocus: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETFOCUS, 0, 0));
end;

procedure TDScintilla.SetStatus(AStatusCode: Integer);
begin
  SendEditor(SCI_SETSTATUS, AStatusCode, 0);
end;

function TDScintilla.GetStatus: Integer;
begin
  Result := SendEditor(SCI_GETSTATUS, 0, 0);
end;

procedure TDScintilla.SetMouseDownCaptures(ACaptures: Boolean);
begin
  SendEditor(SCI_SETMOUSEDOWNCAPTURES, Integer(ACaptures), 0);
end;

function TDScintilla.GetMouseDownCaptures: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETMOUSEDOWNCAPTURES, 0, 0));
end;

procedure TDScintilla.SetCursor(ACursorType: Integer);
begin
  SendEditor(SCI_SETCURSOR, ACursorType, 0);
end;

function TDScintilla.GetCursor: Integer;
begin
  Result := SendEditor(SCI_GETCURSOR, 0, 0);
end;

procedure TDScintilla.SetControlCharSymbol(ASymbol: Integer);
begin
  SendEditor(SCI_SETCONTROLCHARSYMBOL, ASymbol, 0);
end;

function TDScintilla.GetControlCharSymbol: Integer;
begin
  Result := SendEditor(SCI_GETCONTROLCHARSYMBOL, 0, 0);
end;

procedure TDScintilla.SetXOffset(ANewOffset: Integer);
begin
  SendEditor(SCI_SETXOFFSET, ANewOffset, 0);
end;

function TDScintilla.GetXOffset: Integer;
begin
  Result := SendEditor(SCI_GETXOFFSET, 0, 0);
end;

procedure TDScintilla.SetPrintWrapMode(AMode: Integer);
begin
  SendEditor(SCI_SETPRINTWRAPMODE, AMode, 0);
end;

function TDScintilla.GetPrintWrapMode: Integer;
begin
  Result := SendEditor(SCI_GETPRINTWRAPMODE, 0, 0);
end;

procedure TDScintilla.SetHotspotActiveFore(AUseSetting: Boolean; AFore: TColor);
begin
  SendEditor(SCI_SETHOTSPOTACTIVEFORE, Integer(AUseSetting), Integer(AFore));
end;

function TDScintilla.GetHotspotActiveFore: TColor;
begin
  Result := TColor(SendEditor(SCI_GETHOTSPOTACTIVEFORE, 0, 0));
end;

procedure TDScintilla.SetHotspotActiveBack(AUseSetting: Boolean; ABack: TColor);
begin
  SendEditor(SCI_SETHOTSPOTACTIVEBACK, Integer(AUseSetting), Integer(ABack));
end;

function TDScintilla.GetHotspotActiveBack: TColor;
begin
  Result := TColor(SendEditor(SCI_GETHOTSPOTACTIVEBACK, 0, 0));
end;

procedure TDScintilla.SetHotspotActiveUnderline(AUnderline: Boolean);
begin
  SendEditor(SCI_SETHOTSPOTACTIVEUNDERLINE, Integer(AUnderline), 0);
end;

function TDScintilla.GetHotspotActiveUnderline: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETHOTSPOTACTIVEUNDERLINE, 0, 0));
end;

procedure TDScintilla.SetHotspotSingleLine(ASingleLine: Boolean);
begin
  SendEditor(SCI_SETHOTSPOTSINGLELINE, Integer(ASingleLine), 0);
end;

function TDScintilla.GetHotspotSingleLine: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETHOTSPOTSINGLELINE, 0, 0));
end;

procedure TDScintilla.SetSelectionMode(AMode: Integer);
begin
  SendEditor(SCI_SETSELECTIONMODE, AMode, 0);
end;

function TDScintilla.GetSelectionMode: Integer;
begin
  Result := SendEditor(SCI_GETSELECTIONMODE, 0, 0);
end;

procedure TDScintilla.SetWhitespaceChars(const ACharacters: UnicodeString);
begin
  FHelper.SetText(SCI_SETWHITESPACECHARS, 0, ACharacters);
end;

function TDScintilla.GetWhitespaceChars: AnsiString;
begin
  FHelper.GetTextA(SCI_GETWHITESPACECHARS, 0, Result);
end;

procedure TDScintilla.SetPunctuationChars(const ACharacters: AnsiString);
begin
  FHelper.SetTextA(SCI_SETPUNCTUATIONCHARS, 0, ACharacters);
end;

function TDScintilla.GetPunctuationChars: AnsiString;
begin
  FHelper.GetTextA(SCI_GETPUNCTUATIONCHARS, 0, Result);
end;

procedure TDScintilla.AutoCSetCaseInsensitiveBehaviour(ABehaviour: Integer);
begin
  SendEditor(SCI_AUTOCSETCASEINSENSITIVEBEHAVIOUR, ABehaviour, 0);
end;

function TDScintilla.AutoCGetCaseInsensitiveBehaviour: Integer;
begin
  Result := SendEditor(SCI_AUTOCGETCASEINSENSITIVEBEHAVIOUR, 0, 0);
end;

procedure TDScintilla.AutoCSetOrder(AOrder: Integer);
begin
  SendEditor(SCI_AUTOCSETORDER, AOrder, 0);
end;

function TDScintilla.AutoCGetOrder: Integer;
begin
  Result := SendEditor(SCI_AUTOCGETORDER, 0, 0);
end;

function TDScintilla.GetCaretSticky: Integer;
begin
  Result := SendEditor(SCI_GETCARETSTICKY, 0, 0);
end;

procedure TDScintilla.SetCaretSticky(AUseCaretStickyBehaviour: Integer);
begin
  SendEditor(SCI_SETCARETSTICKY, AUseCaretStickyBehaviour, 0);
end;

procedure TDScintilla.SetPasteConvertEndings(AConvert: Boolean);
begin
  SendEditor(SCI_SETPASTECONVERTENDINGS, Integer(AConvert), 0);
end;

function TDScintilla.GetPasteConvertEndings: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETPASTECONVERTENDINGS, 0, 0));
end;

procedure TDScintilla.SetCaretLineBackAlpha(AAlpha: Integer);
begin
  SendEditor(SCI_SETCARETLINEBACKALPHA, AAlpha, 0);
end;

function TDScintilla.GetCaretLineBackAlpha: Integer;
begin
  Result := SendEditor(SCI_GETCARETLINEBACKALPHA, 0, 0);
end;

procedure TDScintilla.SetCaretStyle(ACaretStyle: Integer);
begin
  SendEditor(SCI_SETCARETSTYLE, ACaretStyle, 0);
end;

function TDScintilla.GetCaretStyle: Integer;
begin
  Result := SendEditor(SCI_GETCARETSTYLE, 0, 0);
end;

procedure TDScintilla.SetIndicatorCurrent(AIndicator: Integer);
begin
  SendEditor(SCI_SETINDICATORCURRENT, AIndicator, 0);
end;

function TDScintilla.GetIndicatorCurrent: Integer;
begin
  Result := SendEditor(SCI_GETINDICATORCURRENT, 0, 0);
end;

procedure TDScintilla.SetIndicatorValue(AValue: Integer);
begin
  SendEditor(SCI_SETINDICATORVALUE, AValue, 0);
end;

function TDScintilla.GetIndicatorValue: Integer;
begin
  Result := SendEditor(SCI_GETINDICATORVALUE, 0, 0);
end;

procedure TDScintilla.SetPositionCache(ASize: Integer);
begin
  SendEditor(SCI_SETPOSITIONCACHE, ASize, 0);
end;

function TDScintilla.GetPositionCache: Integer;
begin
  Result := SendEditor(SCI_GETPOSITIONCACHE, 0, 0);
end;

function TDScintilla.GetCharacterPointer: PByte;
begin
  Result := PByte(SendEditor(SCI_GETCHARACTERPOINTER, 0, 0));
end;

function TDScintilla.GetRangePointer(APosition: Integer; ARangeLength: Integer): Pointer;
begin
  Result := Pointer(SendEditor(SCI_GETRANGEPOINTER, APosition, ARangeLength));
end;

procedure TDScintilla.SetKeysUnicode(AKeysUnicode: Boolean);
begin
  SendEditor(SCI_SETKEYSUNICODE, Integer(AKeysUnicode), 0);
end;

function TDScintilla.GetKeysUnicode: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETKEYSUNICODE, 0, 0));
end;

procedure TDScintilla.IndicSetAlpha(AIndicator: Integer; AAlpha: Integer);
begin
  SendEditor(SCI_INDICSETALPHA, AIndicator, AAlpha);
end;

function TDScintilla.IndicGetAlpha(AIndicator: Integer): Integer;
begin
  Result := SendEditor(SCI_INDICGETALPHA, AIndicator, 0);
end;

procedure TDScintilla.IndicSetOutlineAlpha(AIndicator: Integer; AAlpha: Integer);
begin
  SendEditor(SCI_INDICSETOUTLINEALPHA, AIndicator, AAlpha);
end;

function TDScintilla.IndicGetOutlineAlpha(AIndicator: Integer): Integer;
begin
  Result := SendEditor(SCI_INDICGETOUTLINEALPHA, AIndicator, 0);
end;

procedure TDScintilla.SetExtraAscent(AExtraAscent: Integer);
begin
  SendEditor(SCI_SETEXTRAASCENT, AExtraAscent, 0);
end;

function TDScintilla.GetExtraAscent: Integer;
begin
  Result := SendEditor(SCI_GETEXTRAASCENT, 0, 0);
end;

procedure TDScintilla.SetExtraDescent(AExtraDescent: Integer);
begin
  SendEditor(SCI_SETEXTRADESCENT, AExtraDescent, 0);
end;

function TDScintilla.GetExtraDescent: Integer;
begin
  Result := SendEditor(SCI_GETEXTRADESCENT, 0, 0);
end;

procedure TDScintilla.MarginSetText(ALine: Integer; const AText: UnicodeString);
begin
  FHelper.SetText(SCI_MARGINSETTEXT, ALine, AText);
end;

function TDScintilla.MarginGetText(ALine: Integer): UnicodeString;
begin
  FHelper.GetText(SCI_MARGINGETTEXT, ALine, Result);
end;

procedure TDScintilla.MarginSetStyle(ALine: Integer; AStyle: Integer);
begin
  SendEditor(SCI_MARGINSETSTYLE, ALine, AStyle);
end;

function TDScintilla.MarginGetStyle(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_MARGINGETSTYLE, ALine, 0);
end;

procedure TDScintilla.MarginSetStyles(ALine: Integer; const AStyles: TDSciStyles);
begin
  SendEditor(SCI_MARGINSETSTYLES, ALine, Integer(AStyles));
end;

function TDScintilla.MarginGetStyles(ALine: Integer): TDSciStyles;
begin
  SetLength(Result, SendEditor(SCI_MARGINGETSTYLES, ALine));
  if Length(Result) > 0 then
    SendEditor(SCI_MARGINGETSTYLES, ALine, Integer(Result));
end;

procedure TDScintilla.MarginSetStyleOffset(AStyle: Integer);
begin
  SendEditor(SCI_MARGINSETSTYLEOFFSET, AStyle, 0);
end;

function TDScintilla.MarginGetStyleOffset: Integer;
begin
  Result := SendEditor(SCI_MARGINGETSTYLEOFFSET, 0, 0);
end;

procedure TDScintilla.SetMarginOptions(AMarginOptions: Integer);
begin
  SendEditor(SCI_SETMARGINOPTIONS, AMarginOptions, 0);
end;

function TDScintilla.GetMarginOptions: Integer;
begin
  Result := SendEditor(SCI_GETMARGINOPTIONS, 0, 0);
end;

procedure TDScintilla.AnnotationSetText(ALine: Integer; const AText: UnicodeString);
begin
  FHelper.SetText(SCI_ANNOTATIONSETTEXT, ALine, AText);
end;

function TDScintilla.AnnotationGetText(ALine: Integer): UnicodeString;
begin
  FHelper.SetText(SCI_ANNOTATIONGETTEXT, ALine, Result);
end;
procedure TDScintilla.AnnotationSetStyle(ALine: Integer; AStyle: Integer);
begin
  SendEditor(SCI_ANNOTATIONSETSTYLE, ALine, AStyle);
end;

function TDScintilla.AnnotationGetStyle(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_ANNOTATIONGETSTYLE, ALine, 0);
end;

procedure TDScintilla.AnnotationSetStyles(ALine: Integer; const AStyles: TDSciStyles);
begin
  SendEditor(SCI_ANNOTATIONSETSTYLES, ALine, Integer(AStyles));
end;

function TDScintilla.AnnotationGetStyles(ALine: Integer): TDSciStyles;
begin
  SetLength(Result, SendEditor(SCI_ANNOTATIONGETSTYLES, ALine));
  if Length(Result) > 0 then
    SendEditor(SCI_ANNOTATIONGETSTYLES, ALine, Integer(Result));
end;

function TDScintilla.AnnotationGetLines(ALine: Integer): Integer;
begin
  Result := SendEditor(SCI_ANNOTATIONGETLINES, ALine, 0);
end;

procedure TDScintilla.AnnotationSetVisible(AVisible: Integer);
begin
  SendEditor(SCI_ANNOTATIONSETVISIBLE, AVisible, 0);
end;

function TDScintilla.AnnotationGetVisible: Integer;
begin
  Result := SendEditor(SCI_ANNOTATIONGETVISIBLE, 0, 0);
end;

procedure TDScintilla.AnnotationSetStyleOffset(AStyle: Integer);
begin
  SendEditor(SCI_ANNOTATIONSETSTYLEOFFSET, AStyle, 0);
end;

function TDScintilla.AnnotationGetStyleOffset: Integer;
begin
  Result := SendEditor(SCI_ANNOTATIONGETSTYLEOFFSET, 0, 0);
end;

procedure TDScintilla.SetMouseSelectionRectangularSwitch(AMouseSelectionRectangularSwitch: Boolean);
begin
  SendEditor(SCI_SETMOUSESELECTIONRECTANGULARSWITCH, Integer(AMouseSelectionRectangularSwitch), 0);
end;

function TDScintilla.GetMouseSelectionRectangularSwitch: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETMOUSESELECTIONRECTANGULARSWITCH, 0, 0));
end;

procedure TDScintilla.SetMultipleSelection(AMultipleSelection: Boolean);
begin
  SendEditor(SCI_SETMULTIPLESELECTION, Integer(AMultipleSelection), 0);
end;

function TDScintilla.GetMultipleSelection: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETMULTIPLESELECTION, 0, 0));
end;

procedure TDScintilla.SetAdditionalSelectionTyping(AAdditionalSelectionTyping: Boolean);
begin
  SendEditor(SCI_SETADDITIONALSELECTIONTYPING, Integer(AAdditionalSelectionTyping), 0);
end;

function TDScintilla.GetAdditionalSelectionTyping: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETADDITIONALSELECTIONTYPING, 0, 0));
end;

procedure TDScintilla.SetAdditionalCaretsBlink(AAdditionalCaretsBlink: Boolean);
begin
  SendEditor(SCI_SETADDITIONALCARETSBLINK, Integer(AAdditionalCaretsBlink), 0);
end;

function TDScintilla.GetAdditionalCaretsBlink: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETADDITIONALCARETSBLINK, 0, 0));
end;

procedure TDScintilla.SetAdditionalCaretsVisible(AAdditionalCaretsBlink: Boolean);
begin
  SendEditor(SCI_SETADDITIONALCARETSVISIBLE, Integer(AAdditionalCaretsBlink), 0);
end;

function TDScintilla.GetAdditionalCaretsVisible: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETADDITIONALCARETSVISIBLE, 0, 0));
end;

function TDScintilla.GetSelections: Integer;
begin
  Result := SendEditor(SCI_GETSELECTIONS, 0, 0);
end;

function TDScintilla.GetSelectionEmpty: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETSELECTIONEMPTY, 0, 0));
end;

procedure TDScintilla.SetMainSelection(ASelection: Integer);
begin
  SendEditor(SCI_SETMAINSELECTION, ASelection, 0);
end;

function TDScintilla.GetMainSelection: Integer;
begin
  Result := SendEditor(SCI_GETMAINSELECTION, 0, 0);
end;

procedure TDScintilla.SetSelectionNCaret(ASelection: Integer; APos: Integer);
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    SendEditor(SCI_SETSELECTIONNCARET, ASelection, APos);
end;

function TDScintilla.GetSelectionNCaret(ASelection: Integer): Integer;
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    Result := SendEditor(SCI_GETSELECTIONNCARET, ASelection, 0)
  else
    Result := INVALID_POSITION;
end;

procedure TDScintilla.SetSelectionNAnchor(ASelection: Integer; APosAnchor: Integer);
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    SendEditor(SCI_SETSELECTIONNANCHOR, ASelection, APosAnchor);
end;

function TDScintilla.GetSelectionNAnchor(ASelection: Integer): Integer;
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    Result := SendEditor(SCI_GETSELECTIONNANCHOR, ASelection, 0)
  else
    Result := INVALID_POSITION;
end;

procedure TDScintilla.SetSelectionNCaretVirtualSpace(ASelection: Integer; ASpace: Integer);
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    SendEditor(SCI_SETSELECTIONNCARETVIRTUALSPACE, ASelection, ASpace);
end;

function TDScintilla.GetSelectionNCaretVirtualSpace(ASelection: Integer): Integer;
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    Result := SendEditor(SCI_GETSELECTIONNCARETVIRTUALSPACE, ASelection, 0)
  else
    Result := INVALID_POSITION;
end;

procedure TDScintilla.SetSelectionNAnchorVirtualSpace(ASelection: Integer; ASpace: Integer);
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    SendEditor(SCI_SETSELECTIONNANCHORVIRTUALSPACE, ASelection, ASpace);
end;

function TDScintilla.GetSelectionNAnchorVirtualSpace(ASelection: Integer): Integer;
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    Result := SendEditor(SCI_GETSELECTIONNANCHORVIRTUALSPACE, ASelection, 0)
  else
    Result := INVALID_POSITION;
end;

procedure TDScintilla.SetSelectionNStart(ASelection: Integer; APos: Integer);
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    SendEditor(SCI_SETSELECTIONNSTART, ASelection, APos);
end;

function TDScintilla.GetSelectionNStart(ASelection: Integer): Integer;
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    Result := SendEditor(SCI_GETSELECTIONNSTART, ASelection, 0)
  else
    Result := INVALID_POSITION;
end;

procedure TDScintilla.SetSelectionNEnd(ASelection: Integer; APos: Integer);
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    SendEditor(SCI_SETSELECTIONNEND, ASelection, APos);
end;

function TDScintilla.GetSelectionNEnd(ASelection: Integer): Integer;
begin
  if (ASelection >= 0) and (ASelection < GetSelections) then
    Result := SendEditor(SCI_GETSELECTIONNEND, ASelection, 0)
  else
    Result := INVALID_POSITION;
end;

procedure TDScintilla.SetRectangularSelectionCaret(APos: Integer);
begin
  SendEditor(SCI_SETRECTANGULARSELECTIONCARET, APos, 0);
end;

function TDScintilla.GetRectangularSelectionCaret: Integer;
begin
  Result := SendEditor(SCI_GETRECTANGULARSELECTIONCARET, 0, 0);
end;

procedure TDScintilla.SetRectangularSelectionAnchor(APosAnchor: Integer);
begin
  SendEditor(SCI_SETRECTANGULARSELECTIONANCHOR, APosAnchor, 0);
end;

function TDScintilla.GetRectangularSelectionAnchor: Integer;
begin
  Result := SendEditor(SCI_GETRECTANGULARSELECTIONANCHOR, 0, 0);
end;

procedure TDScintilla.SetRectangularSelectionCaretVirtualSpace(ASpace: Integer);
begin
  SendEditor(SCI_SETRECTANGULARSELECTIONCARETVIRTUALSPACE, ASpace, 0);
end;

function TDScintilla.GetRectangularSelectionCaretVirtualSpace: Integer;
begin
  Result := SendEditor(SCI_GETRECTANGULARSELECTIONCARETVIRTUALSPACE, 0, 0);
end;

procedure TDScintilla.SetRectangularSelectionAnchorVirtualSpace(ASpace: Integer);
begin
  SendEditor(SCI_SETRECTANGULARSELECTIONANCHORVIRTUALSPACE, ASpace, 0);
end;

function TDScintilla.GetRectangularSelectionAnchorVirtualSpace: Integer;
begin
  Result := SendEditor(SCI_GETRECTANGULARSELECTIONANCHORVIRTUALSPACE, 0, 0);
end;

procedure TDScintilla.SetVirtualSpaceOptions(AVirtualSpaceOptions: Integer);
begin
  SendEditor(SCI_SETVIRTUALSPACEOPTIONS, AVirtualSpaceOptions, 0);
end;

function TDScintilla.GetVirtualSpaceOptions: Integer;
begin
  Result := SendEditor(SCI_GETVIRTUALSPACEOPTIONS, 0, 0);
end;

procedure TDScintilla.SetRectangularSelectionModifier(AModifier: Integer);
begin
  SendEditor(SCI_SETRECTANGULARSELECTIONMODIFIER, AModifier, 0);
end;

function TDScintilla.GetRectangularSelectionModifier: Integer;
begin
  Result := SendEditor(SCI_GETRECTANGULARSELECTIONMODIFIER, 0, 0);
end;

procedure TDScintilla.SetAdditionalSelFore(AFore: TColor);
begin
  SendEditor(SCI_SETADDITIONALSELFORE, Integer(AFore), 0);
end;

procedure TDScintilla.SetAdditionalSelBack(ABack: TColor);
begin
  SendEditor(SCI_SETADDITIONALSELBACK, Integer(ABack), 0);
end;

procedure TDScintilla.SetAdditionalSelAlpha(AAlpha: Integer);
begin
  SendEditor(SCI_SETADDITIONALSELALPHA, AAlpha, 0);
end;

function TDScintilla.GetAdditionalSelAlpha: Integer;
begin
  Result := SendEditor(SCI_GETADDITIONALSELALPHA, 0, 0);
end;

procedure TDScintilla.SetAdditionalCaretFore(AFore: TColor);
begin
  SendEditor(SCI_SETADDITIONALCARETFORE, Integer(AFore), 0);
end;

function TDScintilla.GetAdditionalCaretFore: TColor;
begin
  Result := TColor(SendEditor(SCI_GETADDITIONALCARETFORE, 0, 0));
end;

procedure TDScintilla.SetIdentifier(AIdentifier: Integer);
begin
  SendEditor(SCI_SETIDENTIFIER, AIdentifier, 0);
end;

function TDScintilla.GetIdentifier: Integer;
begin
  Result := SendEditor(SCI_GETIDENTIFIER, 0, 0);
end;

procedure TDScintilla.RGBAImageSetWidth(AWidth: Integer);
begin
  SendEditor(SCI_RGBAIMAGESETWIDTH, AWidth, 0);
end;

procedure TDScintilla.RGBAImageSetHeight(AHeight: Integer);
begin
  SendEditor(SCI_RGBAIMAGESETHEIGHT, AHeight, 0);
end;

procedure TDScintilla.SetTechnology(ATechnology: Integer);
begin
  SendEditor(SCI_SETTECHNOLOGY, ATechnology, 0);
end;

function TDScintilla.GetTechnology: Integer;
begin
  Result := SendEditor(SCI_GETTECHNOLOGY, 0, 0);
end;

function TDScintilla.GetCaretLineVisibleAlways: Boolean;
begin
  Result := Boolean(SendEditor(SCI_GETCARETLINEVISIBLEALWAYS, 0, 0));
end;

procedure TDScintilla.SetCaretLineVisibleAlways(AAlwaysVisible: Boolean);
begin
  SendEditor(SCI_SETCARETLINEVISIBLEALWAYS, Integer(AAlwaysVisible), 0);
end;

procedure TDScintilla.SetLineEndTypesAllowed(ALineEndBitSet: Integer);
begin
  SendEditor(SCI_SETLINEENDTYPESALLOWED, ALineEndBitSet, 0);
end;

function TDScintilla.GetLineEndTypesAllowed: Integer;
begin
  Result := SendEditor(SCI_GETLINEENDTYPESALLOWED, 0, 0);
end;

function TDScintilla.GetLineEndTypesActive: Integer;
begin
  Result := SendEditor(SCI_GETLINEENDTYPESACTIVE, 0, 0);
end;

procedure TDScintilla.SetRepresentation(AEncodedCharacter: AnsiString; ARepresentation: AnsiString);
begin
  FHelper.SetTextA(SCI_SETREPRESENTATION, Integer(FHelper.GetPtrFromAStr(AEncodedCharacter)), ARepresentation);
end;

function TDScintilla.GetRepresentation(AEncodedCharacter: AnsiString): AnsiString;
begin
  FHelper.GetTextA(SCI_GETREPRESENTATION, Integer(FHelper.GetPtrFromAStr(AEncodedCharacter)), Result);
end;

procedure TDScintilla.SetLexer(ALexer: Integer);
begin
  SendEditor(SCI_SETLEXER, ALexer, 0);
end;

function TDScintilla.GetLexer: Integer;
begin
  Result := SendEditor(SCI_GETLEXER, 0, 0);
end;

procedure TDScintilla.SetProperty(const AKey: UnicodeString; const AValue: UnicodeString);
begin
  if AKey <> '' then
    SendEditor(SCI_SETPROPERTY, Integer(AnsiString(AKey)), Integer(AnsiString(AValue)));
end;

function TDScintilla.GetPropertyInt(const AKey: UnicodeString; ADefault: Integer): Integer;
begin
  if AKey = '' then
    Result := ADefault
  else
    Result := SendEditor(SCI_GETPROPERTYINT, Integer(AnsiString(AKey)), ADefault);
end;

function TDScintilla.GetStyleBitsNeeded: Integer;
begin
  Result := SendEditor(SCI_GETSTYLEBITSNEEDED, 0, 0);
end;

function TDScintilla.GetLexerLanguage: UnicodeString;
begin
  FHelper.GetText(SCI_GETLEXERLANGUAGE, 0, Result);
end;

function TDScintilla.GetLineEndTypesSupported: Integer;
begin
  Result := SendEditor(SCI_GETLINEENDTYPESSUPPORTED, 0, 0);
end;

function TDScintilla.GetSubStylesStart(AStyleBase: Integer): Integer;
begin
  Result := SendEditor(SCI_GETSUBSTYLESSTART, AStyleBase, 0);
end;

function TDScintilla.GetSubStylesLength(AStyleBase: Integer): Integer;
begin
  Result := SendEditor(SCI_GETSUBSTYLESLENGTH, AStyleBase, 0);
end;

function TDScintilla.GetStyleFromSubStyle(ASubStyle: Integer): Integer;
begin
  Result := SendEditor(SCI_GETSTYLEFROMSUBSTYLE, ASubStyle, 0);
end;

function TDScintilla.GetPrimaryStyleFromStyle(AStyle: Integer): Integer;
begin
  Result := SendEditor(SCI_GETPRIMARYSTYLEFROMSTYLE, AStyle, 0);
end;

procedure TDScintilla.SetIdentifiers(AStyle: Integer; const AIdentifiers: AnsiString);
begin
  FHelper.SetTextA(SCI_SETIDENTIFIERS, AStyle, AIdentifiers);
end;

function TDScintilla.DistanceToSecondaryStyles: Integer;
begin
  Result := SendEditor(SCI_DISTANCETOSECONDARYSTYLES, 0, 0);
end;

function TDScintilla.GetSubStyleBases: UnicodeString;
begin
  FHelper.GetText(SCI_GETSUBSTYLEBASES, 0, Result);
end;

// function TDScintilla.GetUsePalette: Boolean;
// begin
//   Result := Boolean(SendEditor(SCI_GETUSEPALETTE, 0, 0));
// end;

// procedure TDScintilla.SetUsePalette(AUsePalette: Boolean);
// begin
//   SendEditor(SCI_SETUSEPALETTE, Integer(AUsePalette), 0);
// end;

