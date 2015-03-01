    /// <summary>Add text to the document at current position.</summary>
    procedure AddText(const AText: UnicodeString);

    /// <summary>Add array of cells to document.</summary>
    procedure AddStyledText(const ACells: TDSciCells);

    /// <summary>Insert string at a position.</summary>
    procedure InsertText(APos: Integer; const AText: UnicodeString);

    /// <summary>Change the text that is being inserted in response to SC_MOD_INSERTCHECK</summary>
    procedure ChangeInsertion(const AText: UnicodeString);

    /// <summary>Delete all text in the document.</summary>
    procedure ClearAll;

    /// <summary>Delete a range of text in the document.</summary>
    procedure DeleteRange(APos: Integer; ADeleteLength: Integer);

    /// <summary>Set all style bytes to 0, remove all folding information.</summary>
    procedure ClearDocumentStyle;

    /// <summary>Redoes the next action on the undo history.</summary>
    procedure Redo;

    /// <summary>Select all the text in the document.</summary>
    procedure SelectAll;

    /// <summary>Remember the current position in the undo history as the position
    /// at which the document was saved.</summary>
    procedure SetSavePoint;

    /// <summary>Retrieve a buffer of cells.
    /// Returns the number of bytes in the buffer not including terminating NULs.</summary>
    function GetStyledText(AStart, AEnd: Integer): TDSciCells;

    /// <summary>Are there any redoable actions in the undo history?</summary>
    function CanRedo: Boolean;

    /// <summary>Retrieve the line number at which a particular marker is located.</summary>
    function MarkerLineFromHandle(AHandle: Integer): Integer;

    /// <summary>Delete a marker.</summary>
    procedure MarkerDeleteHandle(AHandle: Integer);

    /// <summary>Find the position from a point within the window.</summary>
    function PositionFromPoint(AX: Integer; AY: Integer): Integer;

    /// <summary>Find the position from a point within the window but return
    /// INVALID_POSITION if not close to text.</summary>
    function PositionFromPointClose(AX: Integer; AY: Integer): Integer;

    /// <summary>Set caret to start of a line and ensure it is visible.</summary>
    procedure GotoLine(ALine: Integer);

    /// <summary>Set caret to a position and ensure it is visible.</summary>
    procedure GotoPos(APos: Integer);

    /// <summary>Retrieve the text of the line containing the caret.
    /// Returns the index of the caret on the line.</summary>
    function GetCurLine(var AText: UnicodeString): Integer;

    /// <summary>Convert all line endings in the document to one mode.</summary>
    procedure ConvertEOLs(AEolMode: Integer);

    /// <summary>Set the current styling position to pos and the styling mask to mask.
    /// The styling mask can be used to protect some bits in each styling byte from modification.</summary>
    procedure StartStyling(APos: Integer; AMask: Integer);

    /// <summary>Change style from current styling position for length characters to a style
    /// and move the current styling position to after this newly styled segment.</summary>
    procedure SetStyling(ALength: Integer; AStyle: Integer);

    /// <summary>Set the symbol used for a particular marker number.</summary>
    procedure MarkerDefine(AMarkerNumber: Integer; AMarkerSymbol: Integer);

    /// <summary>Set the foreground colour used for a particular marker number.</summary>
    procedure MarkerSetFore(AMarkerNumber: Integer; AFore: TColor);

    /// <summary>Set the background colour used for a particular marker number.</summary>
    procedure MarkerSetBack(AMarkerNumber: Integer; ABack: TColor);

    /// <summary>Set the background colour used for a particular marker number when its folding block is selected.</summary>
    procedure MarkerSetBackSelected(AMarkerNumber: Integer; ABack: TColor);

    /// <summary>Enable/disable highlight for current folding bloc (smallest one that contains the caret)</summary>
    procedure MarkerEnableHighlight(AEnabled: Boolean);

    /// <summary>Add a marker to a line, returning an ID which can be used to find or delete the marker.</summary>
    function MarkerAdd(ALine: Integer; AMarkerNumber: Integer): Integer;

    /// <summary>Delete a marker from a line.</summary>
    procedure MarkerDelete(ALine: Integer; AMarkerNumber: Integer);

    /// <summary>Delete all markers with a particular number from all lines.</summary>
    procedure MarkerDeleteAll(AMarkerNumber: Integer);

    /// <summary>Get a bit mask of all the markers set on a line.</summary>
    function MarkerGet(ALine: Integer): Integer;

    /// <summary>Find the next line at or after lineStart that includes a marker in mask.
    /// Return -1 when no more lines.</summary>
    function MarkerNext(ALineStart: Integer; AMarkerMask: Integer): Integer;

    /// <summary>Find the previous line before lineStart that includes a marker in mask.</summary>
    function MarkerPrevious(ALineStart: Integer; AMarkerMask: Integer): Integer;

    /// <summary>Define a marker from a pixmap.</summary>
    procedure MarkerDefinePixmap(AMarkerNumber: Integer; const APixmap: TBytes);

    /// <summary>Add a set of markers to a line.</summary>
    procedure MarkerAddSet(ALine: Integer; ASet: Integer);

    /// <summary>Set the alpha used for a marker that is drawn in the text area, not the margin.</summary>
    procedure MarkerSetAlpha(AMarkerNumber: Integer; AAlpha: Integer);

    /// <summary>Clear all the styles and make equivalent to the global default style.</summary>
    procedure StyleClearAll;

    /// <summary>Reset the default style to its state at startup</summary>
    procedure StyleResetDefault;

    /// <summary>Get the font of a style.
    /// Returns the length of the fontName</summary>
    function StyleGetFont(AStyle: Integer): UnicodeString;

    /// <summary>Set the foreground colour of the main and additional selections and whether to use this setting.</summary>
    procedure SetSelFore(AUseSetting: Boolean; AFore: TColor);

    /// <summary>Set the background colour of the main and additional selections and whether to use this setting.</summary>
    procedure SetSelBack(AUseSetting: Boolean; ABack: TColor);

    /// <summary>When key+modifier combination km is pressed perform msg.</summary>
    procedure AssignCmdKey(AKm: Integer; AMsg: Integer);

    /// <summary>When key+modifier combination km is pressed do nothing.</summary>
    procedure ClearCmdKey(AKm: Integer);

    /// <summary>Drop all key mappings.</summary>
    procedure ClearAllCmdKeys;

    /// <summary>Set the styles for a segment of the document.</summary>
    procedure SetStylingEx(const AStyles: TDSciStyles);

    /// <summary>Start a sequence of actions that is undone and redone as a unit.
    /// May be nested.</summary>
    procedure BeginUndoAction;

    /// <summary>End a sequence of actions that is undone and redone as a unit.</summary>
    procedure EndUndoAction;

    /// <summary>Set the foreground colour of all whitespace and whether to use this setting.</summary>
    procedure SetWhitespaceFore(AUseSetting: Boolean; AFore: TColor);

    /// <summary>Set the background colour of all whitespace and whether to use this setting.</summary>
    procedure SetWhitespaceBack(AUseSetting: Boolean; ABack: TColor);

    /// <summary>Display a auto-completion list.
    /// The lenEntered parameter indicates how many characters before
    /// the caret should be used to provide context.</summary>
    procedure AutoCShow(ALenEntered: Integer; const AItemList: UnicodeString);

    /// <summary>Remove the auto-completion list from the screen.</summary>
    procedure AutoCCancel;

    /// <summary>Is there an auto-completion list visible?</summary>
    function AutoCActive: Boolean;

    /// <summary>Retrieve the position of the caret when the auto-completion list was displayed.</summary>
    function AutoCPosStart: Integer;

    /// <summary>User has selected an item so remove the list and insert the selection.</summary>
    procedure AutoCComplete;

    /// <summary>Define a set of character that when typed cancel the auto-completion list.</summary>
    procedure AutoCStops(const ACharacterSet: UnicodeString);

    /// <summary>Select the item in the auto-completion list that starts with a string.</summary>
    procedure AutoCSelect(const AText: UnicodeString);

    /// <summary>Display a list of strings and send notification when user chooses one.</summary>
    procedure UserListShow(AListType: Integer; const AItemList: UnicodeString);

    /// <summary>Register an XPM image for use in autocompletion lists.</summary>
    procedure RegisterImage(AType: Integer; const AXpmData: TBytes);

    /// <summary>Clear all the registered XPM images.</summary>
    procedure ClearRegisteredImages;

    /// <summary>Count characters between two positions.</summary>
    function CountCharacters(AStartPos: Integer; AEndPos: Integer): Integer;

    /// <summary>Set caret to a position, while removing any existing selection.</summary>
    procedure SetEmptySelection(APos: Integer);

    /// <summary>Find some text in the document.</summary>
    function FindText(AFlags: Integer; const AText: UnicodeString; var ARange: TDSciCharacterRange): Integer;

    /// <summary>On Windows, will draw the document into a display context such as a printer.</summary>
    function FormatRange(ADraw: Boolean; var AFr: TDSciRangeToFormat): Integer;

    /// <summary>Retrieve the contents of a line.
    /// Returns the length of the line.</summary>
    function GetLine(ALine: Integer): UnicodeString;

    /// <summary>Select a range of text.</summary>
    procedure SetSel(AStart: Integer; AEnd: Integer);

    /// <summary>Retrieve the selected text.
    /// Return the length of the text.</summary>
    function GetSelText: UnicodeString;

    /// <summary>Retrieve a range of text.
    /// Return the length of the text.</summary>
    function GetTextRange(AStart, AEnd: Integer): UnicodeString;

    /// <summary>Draw the selection in normal style or with selection highlighted.</summary>
    procedure HideSelection(ANormal: Boolean);

    /// <summary>Retrieve the x value of the point in the window where a position is displayed.</summary>
    function PointXFromPosition(APos: Integer): Integer;

    /// <summary>Retrieve the y value of the point in the window where a position is displayed.</summary>
    function PointYFromPosition(APos: Integer): Integer;

    /// <summary>Retrieve the line containing a position.</summary>
    function LineFromPosition(APos: Integer): Integer;

    /// <summary>Retrieve the position at the start of a line.</summary>
    function PositionFromLine(ALine: Integer): Integer;

    /// <summary>Scroll horizontally and vertically.</summary>
    procedure LineScroll(AColumns: Integer; ALines: Integer);

    /// <summary>Ensure the caret is visible.</summary>
    procedure ScrollCaret;

    /// <summary>Scroll the argument positions and the range between them into view giving
    /// priority to the primary position then the secondary position.
    /// This may be used to make a search match visible.</summary>
    procedure ScrollRange(ASecondary: Integer; APrimary: Integer);

    /// <summary>Replace the selected text with the argument text.</summary>
    procedure ReplaceSel(const AText: UnicodeString);

    /// <summary>Null operation.</summary>
    // procedure Null;

    /// <summary>Will a paste succeed?</summary>
    function CanPaste: Boolean;

    /// <summary>Are there any undoable actions in the undo history?</summary>
    function CanUndo: Boolean;

    /// <summary>Delete the undo history.</summary>
    procedure EmptyUndoBuffer;

    /// <summary>Undo one action in the undo history.</summary>
    procedure Undo;

    /// <summary>Cut the selection to the clipboard.</summary>
    procedure Cut;

    /// <summary>Copy the selection to the clipboard.</summary>
    procedure Copy;

    /// <summary>Paste the contents of the clipboard into the document replacing the selection.</summary>
    procedure Paste;

    /// <summary>Clear the selection.</summary>
    procedure Clear;

    /// <summary>Replace the contents of the document with the argument text.</summary>
    procedure SetText(const AText: UnicodeString);

    /// <summary>Retrieve all the text in the document.
    /// Returns number of characters retrieved.</summary>
    function GetText: UnicodeString;

    /// <summary>Replace the target text with the argument text.
    /// Text is counted so it can contain NULs.
    /// Returns the length of the replacement text.</summary>
    function ReplaceTarget(const AText: UnicodeString): Integer;

    /// <summary>Replace the target text with the argument text after \d processing.
    /// Text is counted so it can contain NULs.
    /// Looks for \d where d is between 1 and 9 and replaces these with the strings
    /// matched in the last search operation which were surrounded by \( and \).
    /// Returns the length of the replacement text including any change
    /// caused by processing the \d patterns.</summary>
    function ReplaceTargetRE(const AText: UnicodeString): Integer;

    /// <summary>Search for a counted string in the target and set the target to the found
    /// range. Text is counted so it can contain NULs.
    /// Returns length of range or -1 for failure in which case target is not moved.</summary>
    function SearchInTarget(const AText: UnicodeString): Integer;

    /// <summary>Show a call tip containing a definition near position pos.</summary>
    procedure CallTipShow(APos: Integer; const ADefinition: UnicodeString);

    /// <summary>Remove the call tip from the screen.</summary>
    procedure CallTipCancel;

    /// <summary>Is there an active call tip?</summary>
    function CallTipActive: Boolean;

    /// <summary>Retrieve the position where the caret was before displaying the call tip.</summary>
    function CallTipPosStart: Integer;

    /// <summary>Highlight a segment of the definition.</summary>
    procedure CallTipSetHlt(AStart: Integer; AEnd: Integer);

    /// <summary>Find the display line of a document line taking hidden lines into account.</summary>
    function VisibleFromDocLine(ALine: Integer): Integer;

    /// <summary>Find the document line of a display line taking hidden lines into account.</summary>
    function DocLineFromVisible(ALineDisplay: Integer): Integer;

    /// <summary>The number of display lines needed to wrap a document line</summary>
    function WrapCount(ALine: Integer): Integer;

    /// <summary>Make a range of lines visible.</summary>
    procedure ShowLines(ALineStart: Integer; ALineEnd: Integer);

    /// <summary>Make a range of lines invisible.</summary>
    procedure HideLines(ALineStart: Integer; ALineEnd: Integer);

    /// <summary>Switch a header line between expanded and contracted.</summary>
    procedure ToggleFold(ALine: Integer);

    /// <summary>Expand or contract a fold header.</summary>
    procedure FoldLine(ALine: Integer; AAction: Integer);

    /// <summary>Expand or contract a fold header and its children.</summary>
    procedure FoldChildren(ALine: Integer; AAction: Integer);

    /// <summary>Expand a fold header and all children. Use the level argument instead of the line's current level.</summary>
    procedure ExpandChildren(ALine: Integer; ALevel: Integer);

    /// <summary>Expand or contract all fold headers.</summary>
    procedure FoldAll(AAction: Integer);

    /// <summary>Ensure a particular line is visible by expanding any header line hiding it.</summary>
    procedure EnsureVisible(ALine: Integer);

    /// <summary>Set some style options for folding.</summary>
    procedure SetFoldFlags(AFlags: Integer);

    /// <summary>Ensure a particular line is visible by expanding any header line hiding it.
    /// Use the currently set visibility policy to determine which range to display.</summary>
    procedure EnsureVisibleEnforcePolicy(ALine: Integer);

    /// <summary>Get position of start of word.</summary>
    function WordStartPosition(APos: Integer; AOnlyWordCharacters: Boolean): Integer;

    /// <summary>Get position of end of word.</summary>
    function WordEndPosition(APos: Integer; AOnlyWordCharacters: Boolean): Integer;

    /// <summary>Measure the pixel width of some text in a particular style.
    /// NUL terminated text argument.
    /// Does not handle tab or control characters.</summary>
    function TextWidth(AStyle: Integer; const AText: UnicodeString): Integer;

    /// <summary>Retrieve the height of a particular line of text in pixels.</summary>
    function TextHeight(ALine: Integer): Integer;

    /// <summary>Append a string to the end of the document without changing the selection.</summary>
    procedure AppendText(const AText: UnicodeString);

    /// <summary>Retrieve the value of a tag from a regular expression search.</summary>
    function GetTag(ATagNumber: Integer): UnicodeString;

    /// <summary>Make the target range start and end be the same as the selection range start and end.</summary>
    procedure TargetFromSelection;

    /// <summary>Join the lines in the target.</summary>
    procedure LinesJoin;

    /// <summary>Split the lines in the target into lines that are less wide than pixelWidth
    /// where possible.</summary>
    procedure LinesSplit(APixelWidth: Integer);

    /// <summary>Set the colours used as a chequerboard pattern in the fold margin</summary>
    procedure SetFoldMarginColour(AUseSetting: Boolean; ABack: TColor);

    procedure SetFoldMarginHiColour(AUseSetting: Boolean; AFore: TColor);

    /// <summary>Move caret down one line.</summary>
    procedure LineDown;

    /// <summary>Move caret down one line extending selection to new caret position.</summary>
    procedure LineDownExtend;

    /// <summary>Move caret up one line.</summary>
    procedure LineUp;

    /// <summary>Move caret up one line extending selection to new caret position.</summary>
    procedure LineUpExtend;

    /// <summary>Move caret left one character.</summary>
    procedure CharLeft;

    /// <summary>Move caret left one character extending selection to new caret position.</summary>
    procedure CharLeftExtend;

    /// <summary>Move caret right one character.</summary>
    procedure CharRight;

    /// <summary>Move caret right one character extending selection to new caret position.</summary>
    procedure CharRightExtend;

    /// <summary>Move caret left one word.</summary>
    procedure WordLeft;

    /// <summary>Move caret left one word extending selection to new caret position.</summary>
    procedure WordLeftExtend;

    /// <summary>Move caret right one word.</summary>
    procedure WordRight;

    /// <summary>Move caret right one word extending selection to new caret position.</summary>
    procedure WordRightExtend;

    /// <summary>Move caret to first position on line.</summary>
    procedure Home;

    /// <summary>Move caret to first position on line extending selection to new caret position.</summary>
    procedure HomeExtend;

    /// <summary>Move caret to last position on line.</summary>
    procedure LineEnd;

    /// <summary>Move caret to last position on line extending selection to new caret position.</summary>
    procedure LineEndExtend;

    /// <summary>Move caret to first position in document.</summary>
    procedure DocumentStart;

    /// <summary>Move caret to first position in document extending selection to new caret position.</summary>
    procedure DocumentStartExtend;

    /// <summary>Move caret to last position in document.</summary>
    procedure DocumentEnd;

    /// <summary>Move caret to last position in document extending selection to new caret position.</summary>
    procedure DocumentEndExtend;

    /// <summary>Move caret one page up.</summary>
    procedure PageUp;

    /// <summary>Move caret one page up extending selection to new caret position.</summary>
    procedure PageUpExtend;

    /// <summary>Move caret one page down.</summary>
    procedure PageDown;

    /// <summary>Move caret one page down extending selection to new caret position.</summary>
    procedure PageDownExtend;

    /// <summary>Switch from insert to overtype mode or the reverse.</summary>
    procedure EditToggleOvertype;

    /// <summary>Cancel any modes such as call tip or auto-completion list display.</summary>
    procedure Cancel;

    /// <summary>Delete the selection or if no selection, the character before the caret.</summary>
    procedure DeleteBack;

    /// <summary>If selection is empty or all on one line replace the selection with a tab character.
    /// If more than one line selected, indent the lines.</summary>
    procedure Tab;

    /// <summary>Dedent the selected lines.</summary>
    procedure BackTab;

    /// <summary>Insert a new line, may use a CRLF, CR or LF depending on EOL mode.</summary>
    procedure NewLine;

    /// <summary>Insert a Form Feed character.</summary>
    procedure FormFeed;

    /// <summary>Move caret to before first visible character on line.
    /// If already there move to first character on line.</summary>
    procedure VCHome;

    /// <summary>Like VCHome but extending selection to new caret position.</summary>
    procedure VCHomeExtend;

    /// <summary>Magnify the displayed text by increasing the sizes by 1 point.</summary>
    procedure ZoomIn;

    /// <summary>Make the displayed text smaller by decreasing the sizes by 1 point.</summary>
    procedure ZoomOut;

    /// <summary>Delete the word to the left of the caret.</summary>
    procedure DelWordLeft;

    /// <summary>Delete the word to the right of the caret.</summary>
    procedure DelWordRight;

    /// <summary>Delete the word to the right of the caret, but not the trailing non-word characters.</summary>
    procedure DelWordRightEnd;

    /// <summary>Cut the line containing the caret.</summary>
    procedure LineCut;

    /// <summary>Delete the line containing the caret.</summary>
    procedure LineDelete;

    /// <summary>Switch the current line with the previous.</summary>
    procedure LineTranspose;

    /// <summary>Duplicate the current line.</summary>
    procedure LineDuplicate;

    /// <summary>Transform the selection to lower case.</summary>
    procedure LowerCase;

    /// <summary>Transform the selection to upper case.</summary>
    procedure UpperCase;

    /// <summary>Scroll the document down, keeping the caret visible.</summary>
    procedure LineScrollDown;

    /// <summary>Scroll the document up, keeping the caret visible.</summary>
    procedure LineScrollUp;

    /// <summary>Delete the selection or if no selection, the character before the caret.
    /// Will not delete the character before at the start of a line.</summary>
    procedure DeleteBackNotLine;

    /// <summary>Move caret to first position on display line.</summary>
    procedure HomeDisplay;

    /// <summary>Move caret to first position on display line extending selection to
    /// new caret position.</summary>
    procedure HomeDisplayExtend;

    /// <summary>Move caret to last position on display line.</summary>
    procedure LineEndDisplay;

    /// <summary>Move caret to last position on display line extending selection to new
    /// caret position.</summary>
    procedure LineEndDisplayExtend;

    procedure HomeWrap;

    procedure HomeWrapExtend;

    procedure LineEndWrap;

    procedure LineEndWrapExtend;

    procedure VCHomeWrap;

    procedure VCHomeWrapExtend;

    /// <summary>Copy the line containing the caret.</summary>
    procedure LineCopy;

    /// <summary>Move the caret inside current view if it's not there already.</summary>
    procedure MoveCaretInsideView;

    /// <summary>How many characters are on a line, including end of line characters?</summary>
    function LineLength(ALine: Integer): Integer;

    /// <summary>Highlight the characters at two positions.</summary>
    procedure BraceHighlight(APos1: Integer; APos2: Integer);

    /// <summary>Use specified indicator to highlight matching braces instead of changing their style.</summary>
    procedure BraceHighlightIndicator(AUseBraceHighlightIndicator: Boolean; AIndicator: Integer);

    /// <summary>Highlight the character at a position indicating there is no matching brace.</summary>
    procedure BraceBadLight(APos: Integer);

    /// <summary>Use specified indicator to highlight non matching brace instead of changing its style.</summary>
    procedure BraceBadLightIndicator(AUseBraceBadLightIndicator: Boolean; AIndicator: Integer);

    /// <summary>Find the position of a matching brace or INVALID_POSITION if no match.</summary>
    function BraceMatch(APos: Integer): Integer;

    /// <summary>Sets the current caret position to be the search anchor.</summary>
    procedure SearchAnchor;

    /// <summary>Find some text starting at the search anchor.
    /// Does not ensure the selection is visible.</summary>
    function SearchNext(AFlags: Integer; const AText: UnicodeString): Integer;

    /// <summary>Find some text starting at the search anchor and moving backwards.
    /// Does not ensure the selection is visible.</summary>
    function SearchPrev(AFlags: Integer; const AText: UnicodeString): Integer;

    /// <summary>Retrieves the number of lines completely visible.</summary>
    function LinesOnScreen: Integer;

    /// <summary>Set whether a pop up menu is displayed automatically when the user presses
    /// the wrong mouse button.</summary>
    procedure UsePopUp(AAllowPopUp: Boolean);

    /// <summary>Is the selection rectangular? The alternative is the more common stream selection.</summary>
    function SelectionIsRectangle: Boolean;

    /// <summary>Create a new document object.
    /// Starts with reference count of 1 and not selected into editor.</summary>
    function CreateDocument: TDSciDocument;

    /// <summary>Extend life of document.</summary>
    procedure AddRefDocument(ADoc: TDSciDocument);

    /// <summary>Release a reference to the document, deleting document if it fades to black.</summary>
    procedure ReleaseDocument(ADoc: TDSciDocument);

    /// <summary>Move to the previous change in capitalisation.</summary>
    procedure WordPartLeft;

    /// <summary>Move to the previous change in capitalisation extending selection
    /// to new caret position.</summary>
    procedure WordPartLeftExtend;

    /// <summary>Move to the change next in capitalisation.</summary>
    procedure WordPartRight;

    /// <summary>Move to the next change in capitalisation extending selection
    /// to new caret position.</summary>
    procedure WordPartRightExtend;

    /// <summary>Set the way the display area is determined when a particular line
    /// is to be moved to by Find, FindNext, GotoLine, etc.</summary>
    procedure SetVisiblePolicy(AVisiblePolicy: Integer; AVisibleSlop: Integer);

    /// <summary>Delete back from the current position to the start of the line.</summary>
    procedure DelLineLeft;

    /// <summary>Delete forwards from the current position to the end of the line.</summary>
    procedure DelLineRight;

    /// <summary>Set the last x chosen value to be the caret x position.</summary>
    procedure ChooseCaretX;

    /// <summary>Set the focus to this Scintilla widget.</summary>
    procedure GrabFocus;

    /// <summary>Set the way the caret is kept visible when going sideways.
    /// The exclusion zone is given in pixels.</summary>
    procedure SetXCaretPolicy(ACaretPolicy: Integer; ACaretSlop: Integer);

    /// <summary>Set the way the line the caret is on is kept visible.
    /// The exclusion zone is given in lines.</summary>
    procedure SetYCaretPolicy(ACaretPolicy: Integer; ACaretSlop: Integer);

    /// <summary>Move caret between paragraphs (delimited by empty lines).</summary>
    procedure ParaDown;

    procedure ParaDownExtend;

    procedure ParaUp;

    procedure ParaUpExtend;

    /// <summary>Given a valid document position, return the previous position taking code
    /// page into account. Returns 0 if passed 0.</summary>
    function PositionBefore(APos: Integer): Integer;

    /// <summary>Given a valid document position, return the next position taking code
    /// page into account. Maximum value returned is the last position in the document.</summary>
    function PositionAfter(APos: Integer): Integer;

    /// <summary>Given a valid document position, return a position that differs in a number
    /// of characters. Returned value is always between 0 and last position in document.</summary>
    function PositionRelative(APos: Integer; ARelative: Integer): Integer;

    /// <summary>Copy a range of text to the clipboard. Positions are clipped into the document.</summary>
    procedure CopyRange(AStart: Integer; AEnd: Integer);

    /// <summary>Copy argument text to the clipboard.</summary>
    procedure CopyText(const AText: UnicodeString);

    /// <summary>Retrieve the position of the start of the selection at the given line (INVALID_POSITION if no selection on this line).</summary>
    function GetLineSelStartPosition(ALine: Integer): Integer;

    /// <summary>Retrieve the position of the end of the selection at the given line (INVALID_POSITION if no selection on this line).</summary>
    function GetLineSelEndPosition(ALine: Integer): Integer;

    /// <summary>Move caret down one line, extending rectangular selection to new caret position.</summary>
    procedure LineDownRectExtend;

    /// <summary>Move caret up one line, extending rectangular selection to new caret position.</summary>
    procedure LineUpRectExtend;

    /// <summary>Move caret left one character, extending rectangular selection to new caret position.</summary>
    procedure CharLeftRectExtend;

    /// <summary>Move caret right one character, extending rectangular selection to new caret position.</summary>
    procedure CharRightRectExtend;

    /// <summary>Move caret to first position on line, extending rectangular selection to new caret position.</summary>
    procedure HomeRectExtend;

    /// <summary>Move caret to before first visible character on line.
    /// If already there move to first character on line.
    /// In either case, extend rectangular selection to new caret position.</summary>
    procedure VCHomeRectExtend;

    /// <summary>Move caret to last position on line, extending rectangular selection to new caret position.</summary>
    procedure LineEndRectExtend;

    /// <summary>Move caret one page up, extending rectangular selection to new caret position.</summary>
    procedure PageUpRectExtend;

    /// <summary>Move caret one page down, extending rectangular selection to new caret position.</summary>
    procedure PageDownRectExtend;

    /// <summary>Move caret to top of page, or one page up if already at top of page.</summary>
    procedure StutteredPageUp;

    /// <summary>Move caret to top of page, or one page up if already at top of page, extending selection to new caret position.</summary>
    procedure StutteredPageUpExtend;

    /// <summary>Move caret to bottom of page, or one page down if already at bottom of page.</summary>
    procedure StutteredPageDown;

    /// <summary>Move caret to bottom of page, or one page down if already at bottom of page, extending selection to new caret position.</summary>
    procedure StutteredPageDownExtend;

    /// <summary>Move caret left one word, position cursor at end of word.</summary>
    procedure WordLeftEnd;

    /// <summary>Move caret left one word, position cursor at end of word, extending selection to new caret position.</summary>
    procedure WordLeftEndExtend;

    /// <summary>Move caret right one word, position cursor at end of word.</summary>
    procedure WordRightEnd;

    /// <summary>Move caret right one word, position cursor at end of word, extending selection to new caret position.</summary>
    procedure WordRightEndExtend;

    /// <summary>Reset the set of characters for whitespace and word characters to the defaults.</summary>
    procedure SetCharsDefault;

    /// <summary>Get currently selected item position in the auto-completion list</summary>
    function AutoCGetCurrent: Integer;

    /// <summary>Get currently selected item text in the auto-completion list
    /// Returns the length of the item text</summary>
    function AutoCGetCurrentText: UnicodeString;

    /// <summary>Enlarge the document to a particular size of text bytes.</summary>
    procedure Allocate(ABytes: Integer);

    /// <summary>Returns the target converted to UTF8.
    /// Return the length in bytes.</summary>
    // function TargetAsUTF8(AS: PAnsiChar): Integer;

    /// <summary>Set the length of the utf8 argument for calling EncodedFromUTF8.
    /// Set to -1 and the string will be measured to the first nul.</summary>
    // procedure SetLengthForEncode(ABytes: Integer);

    /// <summary>Translates a UTF8 string into the document encoding.
    /// Return the length of the result in bytes.
    /// On error return 0.</summary>
    // function EncodedFromUTF8(AUtf8: PAnsiChar; AEncoded: PAnsiChar): Integer;

    /// <summary>Find the position of a column on a line taking into account tabs and
    /// multi-byte characters. If beyond end of line, return line end position.</summary>
    function FindColumn(ALine: Integer; AColumn: Integer): Integer;

    /// <summary>Switch between sticky and non-sticky: meant to be bound to a key.</summary>
    procedure ToggleCaretSticky;

    /// <summary>Duplicate the selection. If selection empty duplicate the line containing the caret.</summary>
    procedure SelectionDuplicate;

    /// <summary>Turn a indicator on over a range.</summary>
    procedure IndicatorFillRange(APosition: Integer; AFillLength: Integer);

    /// <summary>Turn a indicator off over a range.</summary>
    procedure IndicatorClearRange(APosition: Integer; AClearLength: Integer);

    /// <summary>Are any indicators present at position?</summary>
    function IndicatorAllOnFor(APosition: Integer): Integer;

    /// <summary>What value does a particular indicator have at at a position?</summary>
    function IndicatorValueAt(AIndicator: Integer; APosition: Integer): Integer;

    /// <summary>Where does a particular indicator start?</summary>
    function IndicatorStart(AIndicator: Integer; APosition: Integer): Integer;

    /// <summary>Where does a particular indicator end?</summary>
    function IndicatorEnd(AIndicator: Integer; APosition: Integer): Integer;

    /// <summary>Copy the selection, if selection empty copy the line with the caret</summary>
    procedure CopyAllowLine;

    /// <summary>Return a position which, to avoid performance costs, should not be within
    /// the range of a call to GetRangePointer.</summary>
    function GetGapPosition: Integer;

    /// <summary>Which symbol was defined for markerNumber with MarkerDefine</summary>
    function MarkerSymbolDefined(AMarkerNumber: Integer): Integer;

    /// <summary>Clear the margin text on all lines</summary>
    procedure MarginTextClearAll;

    /// <summary>Clear the annotations from all lines</summary>
    procedure AnnotationClearAll;

    /// <summary>Release all extended (&gt;255) style numbers</summary>
    procedure ReleaseAllExtendedStyles;

    /// <summary>Allocate some extended (&gt;255) style numbers and return the start of the range</summary>
    function AllocateExtendedStyles(ANumberStyles: Integer): Integer;

    /// <summary>Add a container action to the undo stack</summary>
    procedure AddUndoAction(AToken: Integer; AFlags: Integer);

    /// <summary>Find the position of a character from a point within the window.</summary>
    function CharPositionFromPoint(AX: Integer; AY: Integer): Integer;

    /// <summary>Find the position of a character from a point within the window.
    /// Return INVALID_POSITION if not close to text.</summary>
    function CharPositionFromPointClose(AX: Integer; AY: Integer): Integer;

    /// <summary>Clear selections to a single empty stream selection</summary>
    procedure ClearSelections;

    /// <summary>Set a simple selection</summary>
    function SetSelection(ACaret: Integer; AAnchor: Integer): Integer;

    /// <summary>Add a selection</summary>
    function AddSelection(ACaret: Integer; AAnchor: Integer): Integer;

    /// <summary>Drop one selection</summary>
    procedure DropSelectionN(ASelection: Integer);

    /// <summary>Set the main selection to the next selection.</summary>
    procedure RotateSelection;

    /// <summary>Swap that caret and anchor of the main selection.</summary>
    procedure SwapMainAnchorCaret;

    /// <summary>Indicate that the internal state of a lexer has changed over a range and therefore
    /// there may be a need to redraw.</summary>
    function ChangeLexerState(AStart: Integer; AEnd: Integer): Integer;

    /// <summary>Find the next line at or after lineStart that is a contracted fold header line.
    /// Return -1 when no more lines.</summary>
    function ContractedFoldNext(ALineStart: Integer): Integer;

    /// <summary>Centre current line in window.</summary>
    procedure VerticalCentreCaret;

    /// <summary>Move the selected lines up one line, shifting the line above after the selection</summary>
    procedure MoveSelectedLinesUp;

    /// <summary>Move the selected lines down one line, shifting the line below before the selection</summary>
    procedure MoveSelectedLinesDown;

    /// <summary>Set the scale factor in percent for future RGBA image data.</summary>
    procedure RGBAImageSetScale(AScalePercent: Integer);

    /// <summary>Define a marker from RGBA data.
    /// It has the width and height from RGBAImageSetWidth/Height</summary>
    procedure MarkerDefineRGBAImage(AMarkerNumber: Integer; APixels: PAnsiChar);

    /// <summary>Register an RGBA image for use in autocompletion lists.
    /// It has the width and height from RGBAImageSetWidth/Height</summary>
    procedure RegisterRGBAImage(AType: Integer; APixels: PAnsiChar);

    /// <summary>Scroll to start of document.</summary>
    procedure ScrollToStart;

    /// <summary>Scroll to end of document.</summary>
    procedure ScrollToEnd;

    /// <summary>Create an ILoader*.</summary>
    function CreateLoader(ABytes: Integer): Pointer;

    /// <summary>On OS X, show a find indicator.</summary>
    // procedure FindIndicatorShow(AStart: Integer; AEnd: Integer);

    /// <summary>On OS X, flash a find indicator, then fade out.</summary>
    // procedure FindIndicatorFlash(AStart: Integer; AEnd: Integer);

    /// <summary>On OS X, hide the find indicator.</summary>
    // procedure FindIndicatorHide;

    /// <summary>Move caret to before first visible character on display line.
    /// If already there move to first character on display line.</summary>
    procedure VCHomeDisplay;

    /// <summary>Like VCHomeDisplay but extending selection to new caret position.</summary>
    procedure VCHomeDisplayExtend;

    /// <summary>Remove a character representation.</summary>
    procedure ClearRepresentation(AEncodedCharacter: AnsiString);

    /// <summary>Start notifying the container of all key presses and commands.</summary>
    procedure StartRecord;

    /// <summary>Stop notifying the container of all key presses and commands.</summary>
    procedure StopRecord;

    /// <summary>Colourise a segment of the document using the current lexing language.</summary>
    procedure Colourise(AStart: Integer; AEnd: Integer);

    /// <summary>Set up the key words used by the lexer.</summary>
    procedure SetKeyWords(AKeywordSet: Integer; const AKeyWords: UnicodeString);

    /// <summary>Set the lexing language of the document based on string name.</summary>
    procedure SetLexerLanguage(const ALanguage: UnicodeString);

    /// <summary>Load a lexer library (dll / so).</summary>
    procedure LoadLexerLibrary(const APath: UnicodeString);

    /// <summary>Retrieve a "property" value previously set with SetProperty.</summary>
    function GetProperty(const AKey: UnicodeString): UnicodeString;

    /// <summary>Retrieve a "property" value previously set with SetProperty,
    /// with "$()" variable replacement on returned buffer.</summary>
    function GetPropertyExpanded(const AKey: UnicodeString): UnicodeString;

    /// <summary>For private communication between an application and a known lexer.</summary>
    function PrivateLexerCall(AOperation: Integer; APointer: Integer): Integer;

    /// <summary>Retrieve a '\n' separated list of properties understood by the current lexer.</summary>
    function PropertyNames: UnicodeString;

    /// <summary>Retrieve the type of a property.</summary>
    function PropertyType(AName: UnicodeString): Integer;

    /// <summary>Describe a property.</summary>
    function DescribeProperty(AName: UnicodeString): UnicodeString;

    /// <summary>Retrieve a '\n' separated list of descriptions of the keyword sets understood by the current lexer.</summary>
    function DescribeKeyWordSets: UnicodeString;

    /// <summary>Allocate a set of sub styles for a particular base style, returning start of range</summary>
    function AllocateSubStyles(AStyleBase: Integer; ANumberStyles: Integer): Integer;

    /// <summary>Free allocated sub styles</summary>
    procedure FreeSubStyles;

