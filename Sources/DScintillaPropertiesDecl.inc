    /// <summary>Returns the number of bytes in the document.</summary>
    function GetLength: Integer;

    /// <summary>Returns the character byte at the position.</summary>
    function GetCharAt(APos: Integer): Integer;

    /// <summary>Returns the position of the caret.</summary>
    function GetCurrentPos: Integer;

    /// <summary>Returns the position of the opposite end of the selection to the caret.</summary>
    function GetAnchor: Integer;

    /// <summary>Returns the style byte at the position.</summary>
    function GetStyleAt(APos: Integer): Integer;

    /// <summary>Choose between collecting actions into the undo
    /// history and discarding them.</summary>
    procedure SetUndoCollection(ACollectUndo: Boolean);

    /// <summary>Is undo history being collected?</summary>
    function GetUndoCollection: Boolean;

    /// <summary>Are white space characters currently visible?
    /// Returns one of SCWS_* constants.</summary>
    function GetViewWS: Integer;

    /// <summary>Make white space characters invisible, always visible or visible outside indentation.</summary>
    procedure SetViewWS(AViewWS: Integer);

    /// <summary>Set the selection anchor to a position. The anchor is the opposite
    /// end of the selection from the caret.</summary>
    procedure SetAnchor(APosAnchor: Integer);

    /// <summary>Retrieve the position of the last correctly styled character.</summary>
    function GetEndStyled: Integer;

    /// <summary>Retrieve the current end of line mode - one of CRLF, CR, or LF.</summary>
    function GetEOLMode: Integer;

    /// <summary>Set the current end of line mode.</summary>
    procedure SetEOLMode(AEolMode: Integer);

    /// <summary>Is drawing done first into a buffer or direct to the screen?</summary>
    function GetBufferedDraw: Boolean;

    /// <summary>If drawing is buffered then each line of text is drawn into a bitmap buffer
    /// before drawing it to the screen to avoid flicker.</summary>
    procedure SetBufferedDraw(ABuffered: Boolean);

    /// <summary>Change the visible size of a tab to be a multiple of the width of a space character.</summary>
    procedure SetTabWidth(ATabWidth: Integer);

    /// <summary>Retrieve the visible size of a tab.</summary>
    function GetTabWidth: Integer;

    /// <summary>Set the code page used to interpret the bytes of the document as characters.
    /// The SC_CP_UTF8 value can be used to enter Unicode mode.</summary>
    procedure SetCodePage(ACodePage: Integer);

    /// <summary>Set a margin to be either numeric or symbolic.</summary>
    procedure SetMarginTypeN(AMargin: Integer; AMarginType: Integer);

    /// <summary>Retrieve the type of a margin.</summary>
    function GetMarginTypeN(AMargin: Integer): Integer;

    /// <summary>Set the width of a margin to a width expressed in pixels.</summary>
    procedure SetMarginWidthN(AMargin: Integer; APixelWidth: Integer);

    /// <summary>Retrieve the width of a margin in pixels.</summary>
    function GetMarginWidthN(AMargin: Integer): Integer;

    /// <summary>Set a mask that determines which markers are displayed in a margin.</summary>
    procedure SetMarginMaskN(AMargin: Integer; AMask: Integer);

    /// <summary>Retrieve the marker mask of a margin.</summary>
    function GetMarginMaskN(AMargin: Integer): Integer;

    /// <summary>Make a margin sensitive or insensitive to mouse clicks.</summary>
    procedure SetMarginSensitiveN(AMargin: Integer; ASensitive: Boolean);

    /// <summary>Retrieve the mouse click sensitivity of a margin.</summary>
    function GetMarginSensitiveN(AMargin: Integer): Boolean;

    /// <summary>Set the cursor shown when the mouse is inside a margin.</summary>
    procedure SetMarginCursorN(AMargin: Integer; ACursor: Integer);

    /// <summary>Retrieve the cursor shown in a margin.</summary>
    function GetMarginCursorN(AMargin: Integer): Integer;

    /// <summary>Set the foreground colour of a style.</summary>
    procedure StyleSetFore(AStyle: Integer; AFore: TColor);

    /// <summary>Set the background colour of a style.</summary>
    procedure StyleSetBack(AStyle: Integer; ABack: TColor);

    /// <summary>Set a style to be bold or not.</summary>
    procedure StyleSetBold(AStyle: Integer; ABold: Boolean);

    /// <summary>Set a style to be italic or not.</summary>
    procedure StyleSetItalic(AStyle: Integer; AItalic: Boolean);

    /// <summary>Set the size of characters of a style.</summary>
    procedure StyleSetSize(AStyle: Integer; ASizePoints: Integer);

    /// <summary>Set the font of a style.</summary>
    procedure StyleSetFont(AStyle: Integer; const AFontName: UnicodeString);

    /// <summary>Set a style to have its end of line filled or not.</summary>
    procedure StyleSetEOLFilled(AStyle: Integer; AFilled: Boolean);

    /// <summary>Set a style to be underlined or not.</summary>
    procedure StyleSetUnderline(AStyle: Integer; AUnderline: Boolean);

    /// <summary>Get the foreground colour of a style.</summary>
    function StyleGetFore(AStyle: Integer): TColor;

    /// <summary>Get the background colour of a style.</summary>
    function StyleGetBack(AStyle: Integer): TColor;

    /// <summary>Get is a style bold or not.</summary>
    function StyleGetBold(AStyle: Integer): Boolean;

    /// <summary>Get is a style italic or not.</summary>
    function StyleGetItalic(AStyle: Integer): Boolean;

    /// <summary>Get the size of characters of a style.</summary>
    function StyleGetSize(AStyle: Integer): Integer;

    /// <summary>Get is a style to have its end of line filled or not.</summary>
    function StyleGetEOLFilled(AStyle: Integer): Boolean;

    /// <summary>Get is a style underlined or not.</summary>
    function StyleGetUnderline(AStyle: Integer): Boolean;

    /// <summary>Get is a style mixed case, or to force upper or lower case.</summary>
    function StyleGetCase(AStyle: Integer): Integer;

    /// <summary>Get the character get of the font in a style.</summary>
    function StyleGetCharacterSet(AStyle: Integer): Integer;

    /// <summary>Get is a style visible or not.</summary>
    function StyleGetVisible(AStyle: Integer): Boolean;

    /// <summary>Get is a style changeable or not (read only).
    /// Experimental feature, currently buggy.</summary>
    function StyleGetChangeable(AStyle: Integer): Boolean;

    /// <summary>Get is a style a hotspot or not.</summary>
    function StyleGetHotSpot(AStyle: Integer): Boolean;

    /// <summary>Set a style to be mixed case, or to force upper or lower case.</summary>
    procedure StyleSetCase(AStyle: Integer; ACaseForce: Integer);

    /// <summary>Set the size of characters of a style. Size is in points multiplied by 100.</summary>
    procedure StyleSetSizeFractional(AStyle: Integer; ACaseForce: Integer);

    /// <summary>Get the size of characters of a style in points multiplied by 100</summary>
    function StyleGetSizeFractional(AStyle: Integer): Integer;

    /// <summary>Set the weight of characters of a style.</summary>
    procedure StyleSetWeight(AStyle: Integer; AWeight: Integer);

    /// <summary>Get the weight of characters of a style.</summary>
    function StyleGetWeight(AStyle: Integer): Integer;

    /// <summary>Set the character set of the font in a style.</summary>
    procedure StyleSetCharacterSet(AStyle: Integer; ACharacterSet: Integer);

    /// <summary>Set a style to be a hotspot or not.</summary>
    procedure StyleSetHotSpot(AStyle: Integer; AHotspot: Boolean);

    /// <summary>Get the alpha of the selection.</summary>
    function GetSelAlpha: Integer;

    /// <summary>Set the alpha of the selection.</summary>
    procedure SetSelAlpha(AAlpha: Integer);

    /// <summary>Is the selection end of line filled?</summary>
    function GetSelEOLFilled: Boolean;

    /// <summary>Set the selection to have its end of line filled or not.</summary>
    procedure SetSelEOLFilled(AFilled: Boolean);

    /// <summary>Set the foreground colour of the caret.</summary>
    procedure SetCaretFore(AFore: TColor);

    /// <summary>Set a style to be visible or not.</summary>
    procedure StyleSetVisible(AStyle: Integer; AVisible: Boolean);

    /// <summary>Get the time in milliseconds that the caret is on and off.</summary>
    function GetCaretPeriod: Integer;

    /// <summary>Get the time in milliseconds that the caret is on and off. 0 = steady on.</summary>
    procedure SetCaretPeriod(APeriodMilliseconds: Integer);

    /// <summary>Set the set of characters making up words for when moving or selecting by word.
    /// First sets defaults like SetCharsDefault.</summary>
    procedure SetWordChars(const ACharacters: AnsiString);

    /// <summary>Get the set of characters making up words for when moving or selecting by word.
    /// Retuns the number of characters</summary>
    function GetWordChars: AnsiString;

    /// <summary>Set an indicator to plain, squiggle or TT.</summary>
    procedure IndicSetStyle(AIndic: Integer; AStyle: Integer);

    /// <summary>Retrieve the style of an indicator.</summary>
    function IndicGetStyle(AIndic: Integer): Integer;

    /// <summary>Set the foreground colour of an indicator.</summary>
    procedure IndicSetFore(AIndic: Integer; AFore: TColor);

    /// <summary>Retrieve the foreground colour of an indicator.</summary>
    function IndicGetFore(AIndic: Integer): TColor;

    /// <summary>Set an indicator to draw under text or over(default).</summary>
    procedure IndicSetUnder(AIndic: Integer; AUnder: Boolean);

    /// <summary>Retrieve whether indicator drawn under or over text.</summary>
    function IndicGetUnder(AIndic: Integer): Boolean;

    /// <summary>Set the size of the dots used to mark space characters.</summary>
    procedure SetWhitespaceSize(ASize: Integer);

    /// <summary>Get the size of the dots used to mark space characters.</summary>
    function GetWhitespaceSize: Integer;

    /// <summary>Divide each styling byte into lexical class bits (default: 5) and indicator
    /// bits (default: 3). If a lexer requires more than 32 lexical states, then this
    /// is used to expand the possible states.</summary>
    procedure SetStyleBits(ABits: Integer);

    /// <summary>Retrieve number of bits in style bytes used to hold the lexical state.</summary>
    function GetStyleBits: Integer;

    /// <summary>Used to hold extra styling information for each line.</summary>
    procedure SetLineState(ALine: Integer; AState: Integer);

    /// <summary>Retrieve the extra styling information for a line.</summary>
    function GetLineState(ALine: Integer): Integer;

    /// <summary>Retrieve the last line number that has line state.</summary>
    function GetMaxLineState: Integer;

    /// <summary>Is the background of the line containing the caret in a different colour?</summary>
    function GetCaretLineVisible: Boolean;

    /// <summary>Display the background of the line containing the caret in a different colour.</summary>
    procedure SetCaretLineVisible(AShow: Boolean);

    /// <summary>Get the colour of the background of the line containing the caret.</summary>
    function GetCaretLineBack: TColor;

    /// <summary>Set the colour of the background of the line containing the caret.</summary>
    procedure SetCaretLineBack(ABack: TColor);

    /// <summary>Set a style to be changeable or not (read only).
    /// Experimental feature, currently buggy.</summary>
    procedure StyleSetChangeable(AStyle: Integer; AChangeable: Boolean);

    /// <summary>Change the separator character in the string setting up an auto-completion list.
    /// Default is space but can be changed if items contain space.</summary>
    procedure AutoCSetSeparator(ASeparatorCharacter: AnsiChar);

    /// <summary>Retrieve the auto-completion list separator character.</summary>
    function AutoCGetSeparator: AnsiChar;

    /// <summary>Should the auto-completion list be cancelled if the user backspaces to a
    /// position before where the box was created.</summary>
    procedure AutoCSetCancelAtStart(ACancel: Boolean);

    /// <summary>Retrieve whether auto-completion cancelled by backspacing before start.</summary>
    function AutoCGetCancelAtStart: Boolean;

    /// <summary>Define a set of characters that when typed will cause the autocompletion to
    /// choose the selected item.</summary>
    procedure AutoCSetFillUps(const ACharacterSet: UnicodeString);

    /// <summary>Should a single item auto-completion list automatically choose the item.</summary>
    procedure AutoCSetChooseSingle(AChooseSingle: Boolean);

    /// <summary>Retrieve whether a single item auto-completion list automatically choose the item.</summary>
    function AutoCGetChooseSingle: Boolean;

    /// <summary>Set whether case is significant when performing auto-completion searches.</summary>
    procedure AutoCSetIgnoreCase(AIgnoreCase: Boolean);

    /// <summary>Retrieve state of ignore case flag.</summary>
    function AutoCGetIgnoreCase: Boolean;

    /// <summary>Set whether or not autocompletion is hidden automatically when nothing matches.</summary>
    procedure AutoCSetAutoHide(AAutoHide: Boolean);

    /// <summary>Retrieve whether or not autocompletion is hidden automatically when nothing matches.</summary>
    function AutoCGetAutoHide: Boolean;

    /// <summary>Set whether or not autocompletion deletes any word characters
    /// after the inserted text upon completion.</summary>
    procedure AutoCSetDropRestOfWord(ADropRestOfWord: Boolean);

    /// <summary>Retrieve whether or not autocompletion deletes any word characters
    /// after the inserted text upon completion.</summary>
    function AutoCGetDropRestOfWord: Boolean;

    /// <summary>Retrieve the auto-completion list type-separator character.</summary>
    function AutoCGetTypeSeparator: AnsiChar;

    /// <summary>Change the type-separator character in the string setting up an auto-completion list.
    /// Default is '?' but can be changed if items contain '?'.</summary>
    procedure AutoCSetTypeSeparator(ASeparatorCharacter: AnsiChar);

    /// <summary>Set the maximum width, in characters, of auto-completion and user lists.
    /// Set to 0 to autosize to fit longest item, which is the default.</summary>
    procedure AutoCSetMaxWidth(ACharacterCount: Integer);

    /// <summary>Get the maximum width, in characters, of auto-completion and user lists.</summary>
    function AutoCGetMaxWidth: Integer;

    /// <summary>Set the maximum height, in rows, of auto-completion and user lists.
    /// The default is 5 rows.</summary>
    procedure AutoCSetMaxHeight(ARowCount: Integer);

    /// <summary>Set the maximum height, in rows, of auto-completion and user lists.</summary>
    function AutoCGetMaxHeight: Integer;

    /// <summary>Set the number of spaces used for one level of indentation.</summary>
    procedure SetIndent(AIndentSize: Integer);

    /// <summary>Retrieve indentation size.</summary>
    function GetIndent: Integer;

    /// <summary>Indentation will only use space characters if useTabs is false, otherwise
    /// it will use a combination of tabs and spaces.</summary>
    procedure SetUseTabs(AUseTabs: Boolean);

    /// <summary>Retrieve whether tabs will be used in indentation.</summary>
    function GetUseTabs: Boolean;

    /// <summary>Change the indentation of a line to a number of columns.</summary>
    procedure SetLineIndentation(ALine: Integer; AIndentSize: Integer);

    /// <summary>Retrieve the number of columns that a line is indented.</summary>
    function GetLineIndentation(ALine: Integer): Integer;

    /// <summary>Retrieve the position before the first non indentation character on a line.</summary>
    function GetLineIndentPosition(ALine: Integer): Integer;

    /// <summary>Retrieve the column number of a position, taking tab width into account.</summary>
    function GetColumn(APos: Integer): Integer;

    /// <summary>Show or hide the horizontal scroll bar.</summary>
    procedure SetHScrollBar(AShow: Boolean);

    /// <summary>Is the horizontal scroll bar visible?</summary>
    function GetHScrollBar: Boolean;

    /// <summary>Show or hide indentation guides.</summary>
    procedure SetIndentationGuides(AIndentView: Integer);

    /// <summary>Are the indentation guides visible?</summary>
    function GetIndentationGuides: Integer;

    /// <summary>Set the highlighted indentation guide column.
    /// 0 = no highlighted guide.</summary>
    procedure SetHighlightGuide(AColumn: Integer);

    /// <summary>Get the highlighted indentation guide column.</summary>
    function GetHighlightGuide: Integer;

    /// <summary>Get the position after the last visible characters on a line.</summary>
    function GetLineEndPosition(ALine: Integer): Integer;

    /// <summary>Get the code page used to interpret the bytes of the document as characters.</summary>
    function GetCodePage: Integer;

    /// <summary>Get the foreground colour of the caret.</summary>
    function GetCaretFore: TColor;

    /// <summary>In read-only mode?</summary>
    function GetReadOnly: Boolean;

    /// <summary>Sets the position of the caret.</summary>
    procedure SetCurrentPos(APos: Integer);

    /// <summary>Sets the position that starts the selection - this becomes the anchor.</summary>
    procedure SetSelectionStart(APos: Integer);

    /// <summary>Returns the position at the start of the selection.</summary>
    function GetSelectionStart: Integer;

    /// <summary>Sets the position that ends the selection - this becomes the currentPosition.</summary>
    procedure SetSelectionEnd(APos: Integer);

    /// <summary>Returns the position at the end of the selection.</summary>
    function GetSelectionEnd: Integer;

    /// <summary>Sets the print magnification added to the point size of each style for printing.</summary>
    procedure SetPrintMagnification(AMagnification: Integer);

    /// <summary>Returns the print magnification.</summary>
    function GetPrintMagnification: Integer;

    /// <summary>Modify colours when printing for clearer printed text.</summary>
    procedure SetPrintColourMode(AMode: Integer);

    /// <summary>Returns the print colour mode.</summary>
    function GetPrintColourMode: Integer;

    /// <summary>Retrieve the display line at the top of the display.</summary>
    function GetFirstVisibleLine: Integer;

    /// <summary>Returns the number of lines in the document. There is always at least one.</summary>
    function GetLineCount: Integer;

    /// <summary>Sets the size in pixels of the left margin.</summary>
    procedure SetMarginLeft(APixelWidth: Integer);

    /// <summary>Returns the size in pixels of the left margin.</summary>
    function GetMarginLeft: Integer;

    /// <summary>Sets the size in pixels of the right margin.</summary>
    procedure SetMarginRight(APixelWidth: Integer);

    /// <summary>Returns the size in pixels of the right margin.</summary>
    function GetMarginRight: Integer;

    /// <summary>Is the document different from when it was last saved?</summary>
    function GetModify: Boolean;

    /// <summary>Set to read only or read write.</summary>
    procedure SetReadOnly(AReadOnly: Boolean);

    /// <summary>Retrieve the number of characters in the document.</summary>
    function GetTextLength: Integer;

    /// <summary>Retrieve a pointer to a function that processes messages for this Scintilla.</summary>
    function GetDirectFunction: TDScintillaFunction;

    /// <summary>Retrieve a pointer value to use as the first argument when calling
    /// the function returned by GetDirectFunction.</summary>
    function GetDirectPointer: Pointer;

    /// <summary>Set to overtype (true) or insert mode.</summary>
    procedure SetOvertype(AOvertype: Boolean);

    /// <summary>Returns true if overtype mode is active otherwise false is returned.</summary>
    function GetOvertype: Boolean;

    /// <summary>Set the width of the insert mode caret.</summary>
    procedure SetCaretWidth(APixelWidth: Integer);

    /// <summary>Returns the width of the insert mode caret.</summary>
    function GetCaretWidth: Integer;

    /// <summary>Sets the position that starts the target which is used for updating the
    /// document without affecting the scroll position.</summary>
    procedure SetTargetStart(APos: Integer);

    /// <summary>Get the position that starts the target.</summary>
    function GetTargetStart: Integer;

    /// <summary>Sets the position that ends the target which is used for updating the
    /// document without affecting the scroll position.</summary>
    procedure SetTargetEnd(APos: Integer);

    /// <summary>Get the position that ends the target.</summary>
    function GetTargetEnd: Integer;

    /// <summary>Set the search flags used by SearchInTarget.</summary>
    procedure SetSearchFlags(AFlags: Integer);

    /// <summary>Get the search flags used by SearchInTarget.</summary>
    function GetSearchFlags: Integer;

    /// <summary>Set the start position in order to change when backspacing removes the calltip.</summary>
    procedure CallTipSetPosStart(APosStart: Integer);

    /// <summary>Set the background colour for the call tip.</summary>
    procedure CallTipSetBack(ABack: TColor);

    /// <summary>Set the foreground colour for the call tip.</summary>
    procedure CallTipSetFore(AFore: TColor);

    /// <summary>Set the foreground colour for the highlighted part of the call tip.</summary>
    procedure CallTipSetForeHlt(AFore: TColor);

    /// <summary>Enable use of STYLE_CALLTIP and set call tip tab size in pixels.</summary>
    procedure CallTipUseStyle(ATabSize: Integer);

    /// <summary>Set position of calltip, above or below text.</summary>
    procedure CallTipSetPosition(AAbove: Boolean);

    /// <summary>Set the fold level of a line.
    /// This encodes an integer level along with flags indicating whether the
    /// line is a header and whether it is effectively white space.</summary>
    procedure SetFoldLevel(ALine: Integer; ALevel: Integer);

    /// <summary>Retrieve the fold level of a line.</summary>
    function GetFoldLevel(ALine: Integer): Integer;

    /// <summary>Find the last child line of a header line.</summary>
    function GetLastChild(ALine: Integer; ALevel: Integer): Integer;

    /// <summary>Find the parent line of a child line.</summary>
    function GetFoldParent(ALine: Integer): Integer;

    /// <summary>Is a line visible?</summary>
    function GetLineVisible(ALine: Integer): Boolean;

    /// <summary>Are all lines visible?</summary>
    function GetAllLinesVisible: Boolean;

    /// <summary>Show the children of a header line.</summary>
    procedure SetFoldExpanded(ALine: Integer; AExpanded: Boolean);

    /// <summary>Is a header line expanded?</summary>
    function GetFoldExpanded(ALine: Integer): Boolean;

    /// <summary>Set automatic folding behaviours.</summary>
    procedure SetAutomaticFold(AAutomaticFold: Integer);

    /// <summary>Get automatic folding behaviours.</summary>
    function GetAutomaticFold: Integer;

    /// <summary>Sets whether a tab pressed when caret is within indentation indents.</summary>
    procedure SetTabIndents(ATabIndents: Boolean);

    /// <summary>Does a tab pressed when caret is within indentation indent?</summary>
    function GetTabIndents: Boolean;

    /// <summary>Sets whether a backspace pressed when caret is within indentation unindents.</summary>
    procedure SetBackSpaceUnIndents(ABsUnIndents: Boolean);

    /// <summary>Does a backspace pressed when caret is within indentation unindent?</summary>
    function GetBackSpaceUnIndents: Boolean;

    /// <summary>Sets the time the mouse must sit still to generate a mouse dwell event.</summary>
    procedure SetMouseDwellTime(APeriodMilliseconds: Integer);

    /// <summary>Retrieve the time the mouse must sit still to generate a mouse dwell event.</summary>
    function GetMouseDwellTime: Integer;

    /// <summary>Sets whether text is word wrapped.</summary>
    procedure SetWrapMode(AMode: Integer);

    /// <summary>Retrieve whether text is word wrapped.</summary>
    function GetWrapMode: Integer;

    /// <summary>Set the display mode of visual flags for wrapped lines.</summary>
    procedure SetWrapVisualFlags(AWrapVisualFlags: Integer);

    /// <summary>Retrive the display mode of visual flags for wrapped lines.</summary>
    function GetWrapVisualFlags: Integer;

    /// <summary>Set the location of visual flags for wrapped lines.</summary>
    procedure SetWrapVisualFlagsLocation(AWrapVisualFlagsLocation: Integer);

    /// <summary>Retrive the location of visual flags for wrapped lines.</summary>
    function GetWrapVisualFlagsLocation: Integer;

    /// <summary>Set the start indent for wrapped lines.</summary>
    procedure SetWrapStartIndent(AIndent: Integer);

    /// <summary>Retrive the start indent for wrapped lines.</summary>
    function GetWrapStartIndent: Integer;

    /// <summary>Sets how wrapped sublines are placed. Default is fixed.</summary>
    procedure SetWrapIndentMode(AMode: Integer);

    /// <summary>Retrieve how wrapped sublines are placed. Default is fixed.</summary>
    function GetWrapIndentMode: Integer;

    /// <summary>Sets the degree of caching of layout information.</summary>
    procedure SetLayoutCache(AMode: Integer);

    /// <summary>Retrieve the degree of caching of layout information.</summary>
    function GetLayoutCache: Integer;

    /// <summary>Sets the document width assumed for scrolling.</summary>
    procedure SetScrollWidth(APixelWidth: Integer);

    /// <summary>Retrieve the document width assumed for scrolling.</summary>
    function GetScrollWidth: Integer;

    /// <summary>Sets whether the maximum width line displayed is used to set scroll width.</summary>
    procedure SetScrollWidthTracking(ATracking: Boolean);

    /// <summary>Retrieve whether the scroll width tracks wide lines.</summary>
    function GetScrollWidthTracking: Boolean;

    /// <summary>Sets the scroll range so that maximum scroll position has
    /// the last line at the bottom of the view (default).
    /// Setting this to false allows scrolling one page below the last line.</summary>
    procedure SetEndAtLastLine(AEndAtLastLine: Boolean);

    /// <summary>Retrieve whether the maximum scroll position has the last
    /// line at the bottom of the view.</summary>
    function GetEndAtLastLine: Boolean;

    /// <summary>Show or hide the vertical scroll bar.</summary>
    procedure SetVScrollBar(AShow: Boolean);

    /// <summary>Is the vertical scroll bar visible?</summary>
    function GetVScrollBar: Boolean;

    /// <summary>Is drawing done in two phases with backgrounds drawn before faoregrounds?</summary>
    function GetTwoPhaseDraw: Boolean;

    /// <summary>In twoPhaseDraw mode, drawing is performed in two phases, first the background
    /// and then the foreground. This avoids chopping off characters that overlap the next run.</summary>
    procedure SetTwoPhaseDraw(ATwoPhase: Boolean);

    /// <summary>Choose the quality level for text from the FontQuality enumeration.</summary>
    procedure SetFontQuality(AFontQuality: Integer);

    /// <summary>Retrieve the quality level for text.</summary>
    function GetFontQuality: Integer;

    /// <summary>Scroll so that a display line is at the top of the display.</summary>
    procedure SetFirstVisibleLine(ALineDisplay: Integer);

    /// <summary>Change the effect of pasting when there are multiple selections.</summary>
    procedure SetMultiPaste(AMultiPaste: Integer);

    /// <summary>Retrieve the effect of pasting when there are multiple selections..</summary>
    function GetMultiPaste: Integer;

    /// <summary>Are the end of line characters visible?</summary>
    function GetViewEOL: Boolean;

    /// <summary>Make the end of line characters visible or invisible.</summary>
    procedure SetViewEOL(AVisible: Boolean);

    /// <summary>Retrieve a pointer to the document object.</summary>
    function GetDocPointer: TDSciDocument;

    /// <summary>Change the document object used.</summary>
    procedure SetDocPointer(APointer: TDSciDocument);

    /// <summary>Set which document modification events are sent to the container.</summary>
    procedure SetModEventMask(AMask: Integer);

    /// <summary>Retrieve the column number which text should be kept within.</summary>
    function GetEdgeColumn: Integer;

    /// <summary>Set the column number of the edge.
    /// If text goes past the edge then it is highlighted.</summary>
    procedure SetEdgeColumn(AColumn: Integer);

    /// <summary>Retrieve the edge highlight mode.</summary>
    function GetEdgeMode: Integer;

    /// <summary>The edge may be displayed by a line (EDGE_LINE) or by highlighting text that
    /// goes beyond it (EDGE_BACKGROUND) or not displayed at all (EDGE_NONE).</summary>
    procedure SetEdgeMode(AMode: Integer);

    /// <summary>Retrieve the colour used in edge indication.</summary>
    function GetEdgeColour: TColor;

    /// <summary>Change the colour used in edge indication.</summary>
    procedure SetEdgeColour(AEdgeColour: TColor);

    /// <summary>Set the zoom level. This number of points is added to the size of all fonts.
    /// It may be positive to magnify or negative to reduce.</summary>
    procedure SetZoom(AZoom: Integer);

    /// <summary>Retrieve the zoom level.</summary>
    function GetZoom: Integer;

    /// <summary>Get which document modification events are sent to the container.</summary>
    function GetModEventMask: Integer;

    /// <summary>Change internal focus flag.</summary>
    procedure SetFocus(AFocus: Boolean); reintroduce; overload;

    /// <summary>Get internal focus flag.</summary>
    function GetFocus: Boolean;

    /// <summary>Change error status - 0 = OK.</summary>
    procedure SetStatus(AStatusCode: Integer);

    /// <summary>Get error status.</summary>
    function GetStatus: Integer;

    /// <summary>Set whether the mouse is captured when its button is pressed.</summary>
    procedure SetMouseDownCaptures(ACaptures: Boolean);

    /// <summary>Get whether mouse gets captured.</summary>
    function GetMouseDownCaptures: Boolean;

    /// <summary>Sets the cursor to one of the SC_CURSOR* values.</summary>
    procedure SetCursor(ACursorType: Integer);

    /// <summary>Get cursor type.</summary>
    function GetCursor: Integer;

    /// <summary>Change the way control characters are displayed:
    /// If symbol is &lt; 32, keep the drawn way, else, use the given character.</summary>
    procedure SetControlCharSymbol(ASymbol: Integer);

    /// <summary>Get the way control characters are displayed.</summary>
    function GetControlCharSymbol: Integer;

    /// <summary>Get and Set the xOffset (ie, horizontal scroll position).</summary>
    procedure SetXOffset(ANewOffset: Integer);

    function GetXOffset: Integer;

    /// <summary>Set printing to line wrapped (SC_WRAP_WORD) or not line wrapped (SC_WRAP_NONE).</summary>
    procedure SetPrintWrapMode(AMode: Integer);

    /// <summary>Is printing line wrapped?</summary>
    function GetPrintWrapMode: Integer;

    /// <summary>Set a fore colour for active hotspots.</summary>
    procedure SetHotspotActiveFore(AUseSetting: Boolean; AFore: TColor);

    /// <summary>Get the fore colour for active hotspots.</summary>
    function GetHotspotActiveFore: TColor;

    /// <summary>Set a back colour for active hotspots.</summary>
    procedure SetHotspotActiveBack(AUseSetting: Boolean; ABack: TColor);

    /// <summary>Get the back colour for active hotspots.</summary>
    function GetHotspotActiveBack: TColor;

    /// <summary>Enable / Disable underlining active hotspots.</summary>
    procedure SetHotspotActiveUnderline(AUnderline: Boolean);

    /// <summary>Get whether underlining for active hotspots.</summary>
    function GetHotspotActiveUnderline: Boolean;

    /// <summary>Limit hotspots to single line so hotspots on two lines don't merge.</summary>
    procedure SetHotspotSingleLine(ASingleLine: Boolean);

    /// <summary>Get the HotspotSingleLine property</summary>
    function GetHotspotSingleLine: Boolean;

    /// <summary>Set the selection mode to stream (SC_SEL_STREAM) or rectangular (SC_SEL_RECTANGLE/SC_SEL_THIN) or
    /// by lines (SC_SEL_LINES).</summary>
    procedure SetSelectionMode(AMode: Integer);

    /// <summary>Get the mode of the current selection.</summary>
    function GetSelectionMode: Integer;

    /// <summary>Set the set of characters making up whitespace for when moving or selecting by word.
    /// Should be called after SetWordChars.</summary>
    procedure SetWhitespaceChars(const ACharacters: UnicodeString);

    /// <summary>Get the set of characters making up whitespace for when moving or selecting by word.</summary>
    function GetWhitespaceChars: AnsiString;

    /// <summary>Set the set of characters making up punctuation characters
    /// Should be called after SetWordChars.</summary>
    procedure SetPunctuationChars(const ACharacters: AnsiString);

    /// <summary>Get the set of characters making up punctuation characters</summary>
    function GetPunctuationChars: AnsiString;

    /// <summary>Set auto-completion case insensitive behaviour to either prefer case-sensitive matches or have no preference.</summary>
    procedure AutoCSetCaseInsensitiveBehaviour(ABehaviour: Integer);

    /// <summary>Get auto-completion case insensitive behaviour.</summary>
    function AutoCGetCaseInsensitiveBehaviour: Integer;

    /// <summary>Set the way autocompletion lists are ordered.</summary>
    procedure AutoCSetOrder(AOrder: Integer);

    /// <summary>Get the way autocompletion lists are ordered.</summary>
    function AutoCGetOrder: Integer;

    /// <summary>Can the caret preferred x position only be changed by explicit movement commands?</summary>
    function GetCaretSticky: Integer;

    /// <summary>Stop the caret preferred x position changing when the user types.</summary>
    procedure SetCaretSticky(AUseCaretStickyBehaviour: Integer);

    /// <summary>Enable/Disable convert-on-paste for line endings</summary>
    procedure SetPasteConvertEndings(AConvert: Boolean);

    /// <summary>Get convert-on-paste setting</summary>
    function GetPasteConvertEndings: Boolean;

    /// <summary>Set background alpha of the caret line.</summary>
    procedure SetCaretLineBackAlpha(AAlpha: Integer);

    /// <summary>Get the background alpha of the caret line.</summary>
    function GetCaretLineBackAlpha: Integer;

    /// <summary>Set the style of the caret to be drawn.</summary>
    procedure SetCaretStyle(ACaretStyle: Integer);

    /// <summary>Returns the current style of the caret.</summary>
    function GetCaretStyle: Integer;

    /// <summary>Set the indicator used for IndicatorFillRange and IndicatorClearRange</summary>
    procedure SetIndicatorCurrent(AIndicator: Integer);

    /// <summary>Get the current indicator</summary>
    function GetIndicatorCurrent: Integer;

    /// <summary>Set the value used for IndicatorFillRange</summary>
    procedure SetIndicatorValue(AValue: Integer);

    /// <summary>Get the current indicator value</summary>
    function GetIndicatorValue: Integer;

    /// <summary>Set number of entries in position cache</summary>
    procedure SetPositionCache(ASize: Integer);

    /// <summary>How many entries are allocated to the position cache?</summary>
    function GetPositionCache: Integer;

    /// <summary>Compact the document buffer and return a read-only pointer to the
    /// characters in the document.</summary>
    function GetCharacterPointer: PByte;

    /// <summary>Return a read-only pointer to a range of characters in the document.
    /// May move the gap so that the range is contiguous, but will only move up
    /// to rangeLength bytes.</summary>
    function GetRangePointer(APosition: Integer; ARangeLength: Integer): Pointer;

    /// <summary>Always interpret keyboard input as Unicode</summary>
    procedure SetKeysUnicode(AKeysUnicode: Boolean);

    /// <summary>Are keys always interpreted as Unicode?</summary>
    function GetKeysUnicode: Boolean;

    /// <summary>Set the alpha fill colour of the given indicator.</summary>
    procedure IndicSetAlpha(AIndicator: Integer; AAlpha: Integer);

    /// <summary>Get the alpha fill colour of the given indicator.</summary>
    function IndicGetAlpha(AIndicator: Integer): Integer;

    /// <summary>Set the alpha outline colour of the given indicator.</summary>
    procedure IndicSetOutlineAlpha(AIndicator: Integer; AAlpha: Integer);

    /// <summary>Get the alpha outline colour of the given indicator.</summary>
    function IndicGetOutlineAlpha(AIndicator: Integer): Integer;

    /// <summary>Set extra ascent for each line</summary>
    procedure SetExtraAscent(AExtraAscent: Integer);

    /// <summary>Get extra ascent for each line</summary>
    function GetExtraAscent: Integer;

    /// <summary>Set extra descent for each line</summary>
    procedure SetExtraDescent(AExtraDescent: Integer);

    /// <summary>Get extra descent for each line</summary>
    function GetExtraDescent: Integer;

    /// <summary>Set the text in the text margin for a line</summary>
    procedure MarginSetText(ALine: Integer; const AText: UnicodeString);

    /// <summary>Get the text in the text margin for a line</summary>
    function MarginGetText(ALine: Integer): UnicodeString;

    /// <summary>Set the style number for the text margin for a line</summary>
    procedure MarginSetStyle(ALine: Integer; AStyle: Integer);

    /// <summary>Get the style number for the text margin for a line</summary>
    function MarginGetStyle(ALine: Integer): Integer;

    /// <summary>Set the style in the text margin for a line</summary>
    procedure MarginSetStyles(ALine: Integer; const AStyles: TDSciStyles);

    /// <summary>Get the styles in the text margin for a line</summary>
    function MarginGetStyles(ALine: Integer): TDSciStyles;

    /// <summary>Get the start of the range of style numbers used for margin text</summary>
    procedure MarginSetStyleOffset(AStyle: Integer);

    /// <summary>Get the start of the range of style numbers used for margin text</summary>
    function MarginGetStyleOffset: Integer;

    /// <summary>Set the margin options.</summary>
    procedure SetMarginOptions(AMarginOptions: Integer);

    /// <summary>Get the margin options.</summary>
    function GetMarginOptions: Integer;

    /// <summary>Set the annotation text for a line</summary>
    procedure AnnotationSetText(ALine: Integer; const AText: UnicodeString);

    /// <summary>Get the annotation text for a line</summary>
    function AnnotationGetText(ALine: Integer): UnicodeString;

    /// <summary>Set the style number for the annotations for a line</summary>
    procedure AnnotationSetStyle(ALine: Integer; AStyle: Integer);

    /// <summary>Get the style number for the annotations for a line</summary>
    function AnnotationGetStyle(ALine: Integer): Integer;

    /// <summary>Set the annotation styles for a line</summary>
    procedure AnnotationSetStyles(ALine: Integer; const AStyles: TDSciStyles);

    /// <summary>Get the annotation styles for a line</summary>
    function AnnotationGetStyles(ALine: Integer): TDSciStyles;

    /// <summary>Get the number of annotation lines for a line</summary>
    function AnnotationGetLines(ALine: Integer): Integer;

    /// <summary>Set the visibility for the annotations for a view</summary>
    procedure AnnotationSetVisible(AVisible: Integer);

    /// <summary>Get the visibility for the annotations for a view</summary>
    function AnnotationGetVisible: Integer;

    /// <summary>Get the start of the range of style numbers used for annotations</summary>
    procedure AnnotationSetStyleOffset(AStyle: Integer);

    /// <summary>Get the start of the range of style numbers used for annotations</summary>
    function AnnotationGetStyleOffset: Integer;

    /// <summary>Set whether switching to rectangular mode while selecting with the mouse is allowed.</summary>
    procedure SetMouseSelectionRectangularSwitch(AMouseSelectionRectangularSwitch: Boolean);

    /// <summary>Whether switching to rectangular mode while selecting with the mouse is allowed.</summary>
    function GetMouseSelectionRectangularSwitch: Boolean;

    /// <summary>Set whether multiple selections can be made</summary>
    procedure SetMultipleSelection(AMultipleSelection: Boolean);

    /// <summary>Whether multiple selections can be made</summary>
    function GetMultipleSelection: Boolean;

    /// <summary>Set whether typing can be performed into multiple selections</summary>
    procedure SetAdditionalSelectionTyping(AAdditionalSelectionTyping: Boolean);

    /// <summary>Whether typing can be performed into multiple selections</summary>
    function GetAdditionalSelectionTyping: Boolean;

    /// <summary>Set whether additional carets will blink</summary>
    procedure SetAdditionalCaretsBlink(AAdditionalCaretsBlink: Boolean);

    /// <summary>Whether additional carets will blink</summary>
    function GetAdditionalCaretsBlink: Boolean;

    /// <summary>Set whether additional carets are visible</summary>
    procedure SetAdditionalCaretsVisible(AAdditionalCaretsBlink: Boolean);

    /// <summary>Whether additional carets are visible</summary>
    function GetAdditionalCaretsVisible: Boolean;

    /// <summary>How many selections are there?</summary>
    function GetSelections: Integer;

    /// <summary>Is every selected range empty?</summary>
    function GetSelectionEmpty: Boolean;

    /// <summary>Set the main selection</summary>
    procedure SetMainSelection(ASelection: Integer);

    /// <summary>Which selection is the main selection</summary>
    function GetMainSelection: Integer;

    procedure SetSelectionNCaret(ASelection: Integer; APos: Integer);

    function GetSelectionNCaret(ASelection: Integer): Integer;

    procedure SetSelectionNAnchor(ASelection: Integer; APosAnchor: Integer);

    function GetSelectionNAnchor(ASelection: Integer): Integer;

    procedure SetSelectionNCaretVirtualSpace(ASelection: Integer; ASpace: Integer);

    function GetSelectionNCaretVirtualSpace(ASelection: Integer): Integer;

    procedure SetSelectionNAnchorVirtualSpace(ASelection: Integer; ASpace: Integer);

    function GetSelectionNAnchorVirtualSpace(ASelection: Integer): Integer;

    /// <summary>Sets the position that starts the selection - this becomes the anchor.</summary>
    procedure SetSelectionNStart(ASelection: Integer; APos: Integer);

    /// <summary>Returns the position at the start of the selection.</summary>
    function GetSelectionNStart(ASelection: Integer): Integer;

    /// <summary>Sets the position that ends the selection - this becomes the currentPosition.</summary>
    procedure SetSelectionNEnd(ASelection: Integer; APos: Integer);

    /// <summary>Returns the position at the end of the selection.</summary>
    function GetSelectionNEnd(ASelection: Integer): Integer;

    procedure SetRectangularSelectionCaret(APos: Integer);

    function GetRectangularSelectionCaret: Integer;

    procedure SetRectangularSelectionAnchor(APosAnchor: Integer);

    function GetRectangularSelectionAnchor: Integer;

    procedure SetRectangularSelectionCaretVirtualSpace(ASpace: Integer);

    function GetRectangularSelectionCaretVirtualSpace: Integer;

    procedure SetRectangularSelectionAnchorVirtualSpace(ASpace: Integer);

    function GetRectangularSelectionAnchorVirtualSpace: Integer;

    procedure SetVirtualSpaceOptions(AVirtualSpaceOptions: Integer);

    function GetVirtualSpaceOptions: Integer;

    procedure SetRectangularSelectionModifier(AModifier: Integer);

    /// <summary>Get the modifier key used for rectangular selection.</summary>
    function GetRectangularSelectionModifier: Integer;

    /// <summary>Set the foreground colour of additional selections.
    /// Must have previously called SetSelFore with non-zero first argument for this to have an effect.</summary>
    procedure SetAdditionalSelFore(AFore: TColor);

    /// <summary>Set the background colour of additional selections.
    /// Must have previously called SetSelBack with non-zero first argument for this to have an effect.</summary>
    procedure SetAdditionalSelBack(ABack: TColor);

    /// <summary>Set the alpha of the selection.</summary>
    procedure SetAdditionalSelAlpha(AAlpha: Integer);

    /// <summary>Get the alpha of the selection.</summary>
    function GetAdditionalSelAlpha: Integer;

    /// <summary>Set the foreground colour of additional carets.</summary>
    procedure SetAdditionalCaretFore(AFore: TColor);

    /// <summary>Get the foreground colour of additional carets.</summary>
    function GetAdditionalCaretFore: TColor;

    /// <summary>Set the identifier reported as idFrom in notification messages.</summary>
    procedure SetIdentifier(AIdentifier: Integer);

    /// <summary>Get the identifier.</summary>
    function GetIdentifier: Integer;

    /// <summary>Set the width for future RGBA image data.</summary>
    procedure RGBAImageSetWidth(AWidth: Integer);

    /// <summary>Set the height for future RGBA image data.</summary>
    procedure RGBAImageSetHeight(AHeight: Integer);

    /// <summary>Set the technology used.</summary>
    procedure SetTechnology(ATechnology: Integer);

    /// <summary>Get the tech.</summary>
    function GetTechnology: Integer;

    /// <summary>Is the caret line always visible?</summary>
    function GetCaretLineVisibleAlways: Boolean;

    /// <summary>Sets the caret line to always visible.</summary>
    procedure SetCaretLineVisibleAlways(AAlwaysVisible: Boolean);

    /// <summary>Set the line end types that the application wants to use. May not be used if incompatible with lexer or encoding.</summary>
    procedure SetLineEndTypesAllowed(ALineEndBitSet: Integer);

    /// <summary>Get the line end types currently allowed.</summary>
    function GetLineEndTypesAllowed: Integer;

    /// <summary>Get the line end types currently recognised. May be a subset of the allowed types due to lexer limitation.</summary>
    function GetLineEndTypesActive: Integer;

    /// <summary>Set the way a character is drawn.</summary>
    procedure SetRepresentation(AEncodedCharacter: AnsiString; ARepresentation: AnsiString);

    /// <summary>Set the way a character is drawn.</summary>
    function GetRepresentation(AEncodedCharacter: AnsiString): AnsiString;

    /// <summary>Set the lexing language of the document.</summary>
    procedure SetLexer(ALexer: Integer);

    /// <summary>Retrieve the lexing language of the document.</summary>
    function GetLexer: Integer;

    /// <summary>Set up a value that may be used by a lexer for some optional feature.</summary>
    procedure SetProperty(const AKey: UnicodeString; const AValue: UnicodeString);

    /// <summary>Retrieve a "property" value previously set with SetProperty,
    /// interpreted as an int AFTER any "$()" variable replacement.</summary>
    function GetPropertyInt(const AKey: UnicodeString; ADefault: Integer): Integer;

    /// <summary>Retrieve the number of bits the current lexer needs for styling.</summary>
    function GetStyleBitsNeeded: Integer;

    /// <summary>Retrieve the name of the lexer.
    /// Return the length of the text.</summary>
    function GetLexerLanguage: UnicodeString;

    /// <summary>Bit set of LineEndType enumertion for which line ends beyond the standard
    /// LF, CR, and CRLF are supported by the lexer.</summary>
    function GetLineEndTypesSupported: Integer;

    /// <summary>The starting style number for the sub styles associated with a base style</summary>
    function GetSubStylesStart(AStyleBase: Integer): Integer;

    /// <summary>The number of sub styles associated with a base style</summary>
    function GetSubStylesLength(AStyleBase: Integer): Integer;

    /// <summary>For a sub style, return the base style, else return the argument.</summary>
    function GetStyleFromSubStyle(ASubStyle: Integer): Integer;

    /// <summary>For a secondary style, return the primary style, else return the argument.</summary>
    function GetPrimaryStyleFromStyle(AStyle: Integer): Integer;

    /// <summary>Set the identifiers that are shown in a particular style</summary>
    procedure SetIdentifiers(AStyle: Integer; const AIdentifiers: AnsiString);

    /// <summary>Where styles are duplicated by a feature such as active/inactive code
    /// return the distance between the two types.</summary>
    function DistanceToSecondaryStyles: Integer;

    /// <summary>Get the set of base styles that can be extended with sub styles</summary>
    function GetSubStyleBases: UnicodeString;

    /// <summary>Deprecated in 2.30
    /// In palette mode?</summary>
    // function GetUsePalette: Boolean;

    /// <summary>Deprecated in 2.30
    /// In palette mode, Scintilla uses the environment's palette calls to display
    /// more colours. This may lead to ugly displays.</summary>
    // procedure SetUsePalette(AUsePalette: Boolean);

