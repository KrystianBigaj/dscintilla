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

unit DScintillaTypes;

interface

uses
  Windows;

type

{$IF CompilerVersion < 20}
  UnicodeString = WideString;
{$IFEND}

{$IF CompilerVersion < 18.5}
  TBytes = array of Byte;
{$IFEND}

{ TDSciSendEditor }

  TDSciSendEditor = function(AMessage: Integer;
    WParam: Integer = 0; LParam: Integer = 0): Integer of object;

{ TDSciDocument }

  TDSciDocument = type Pointer;

{ TDSciCell }

  TDSciChar = AnsiChar;
  TDSciChars = array of TDSciChar;

  TDSciStyle = Byte;
  TDSciStyles = array of TDSciStyle;

  TDSciCell = packed record
    charByte: TDSciChar;
    styleByte: TDSciStyle;
  end;

  TDSciCells = array of TDSciCell;

{ TDSciCharacterRange }

  TDSciCharacterRange = record
    cpMin: Integer;
    cpMax: Integer;
  end;

{ TDSciTextRange }

  PDSciTextRange = ^TDSciTextRange;
  TDSciTextRange = record
    chrg: TDSciCharacterRange;
    lpstrText: PAnsiChar;
  end;

{ TDSciTextToFind }

  PDSciTextToFind = ^TDSciTextToFind;
  TDSciTextToFind = record
    chrg: TDSciCharacterRange;
    lpstrText: PAnsiChar;
    chrgText: TDSciCharacterRange;
  end;

{ TDSciRangeToFormat }

  PDSciRangeToFormat = ^TDSciRangeToFormat;
  TDSciRangeToFormat = record
    hdc: HDC;                         // The HDC (device context) we print to
    hdcTarget: HDC;                   // The HDC we use for measuring (may be same as hdc)
    rc: TRect;                        // Rectangle in which to print
    rcPage: TRect;                    // Physically printable page size
    chrg: TDSciCharacterRange;        // Range of characters to print
  end;

{ TDSciSCNotification }

  TDSciNotifyHeader = TNMHdr;

  PDSciSCNotification = ^TDSciSCNotification;
  TDSciSCNotification = record
    NotifyHeader: TDSciNotifyHeader;
    position: Integer;
	  // SCN_STYLENEEDED, SCN_DOUBLECLICK, SCN_MODIFIED, SCN_MARGINCLICK,
	  // SCN_NEEDSHOWN, SCN_DWELLSTART, SCN_DWELLEND, SCN_CALLTIPCLICK,
	  // SCN_HOTSPOTCLICK, SCN_HOTSPOTDOUBLECLICK, SCN_HOTSPOTRELEASECLICK,
	  // SCN_INDICATORCLICK, SCN_INDICATORRELEASE,
	  // SCN_USERLISTSELECTION, SCN_AUTOCSELECTION

    ch: Integer;                    // SCN_CHARADDED, SCN_KEY
    modifiers: Integer;
	  // SCN_KEY, SCN_DOUBLECLICK, SCN_HOTSPOTCLICK, SCN_HOTSPOTDOUBLECLICK,
	  // SCN_HOTSPOTRELEASECLICK, SCN_INDICATORCLICK, SCN_INDICATORRELEASE,

    modificationType: Integer;      // SCN_MODIFIED
    text: PAnsiChar;                // SCN_MODIFIED
    length: Integer;                // SCN_MODIFIED
    linesAdded: Integer;            // SCN_MODIFIED
    message: Integer;               // SCN_MACRORECORD
    wParam: Integer;                // SCN_MACRORECORD
    lParam: Integer;                // SCN_MACRORECORD
    line: Integer;                  // SCN_MODIFIED
    foldLevelNow: Integer;          // SCN_MODIFIED
    foldLevelPrev: Integer;         // SCN_MODIFIED
    margin: Integer;                // SCN_MARGINCLICK
    listType: Integer;              // SCN_USERLISTSELECTION
    x: Integer;                     // SCN_DWELLSTART, SCN_DWELLEND
    y: Integer;                     // SCN_DWELLSTART, SCN_DWELLEND
    token: Integer;                 // SCN_MODIFIED with SC_MOD_CONTAINER
    annotationLinesAdded: Integer;	// SCN_MODIFIED with SC_MOD_CHANGEANNOTATION
    updated: Integer;	              // SCN_UPDATEUI
  end;

{ TDScintilla events - http://www.scintilla.org/ScintillaDoc.html#Notifications }

  TDSciNotificationEvent = procedure(ASender: TObject; const ASCN: TDSciSCNotification;
    var AHandled: Boolean) of object;

  TDSciStyleNeededEvent = procedure(ASender: TObject; APosition: Integer) of object;
  TDSciCharAddedEvent = procedure(ASender: TObject; ACh: Integer) of object;
  TDSciSavePointReachedEvent = procedure(ASender: TObject) of object;
  TDSciSavePointLeftEvent = procedure(ASender: TObject) of object;
  TDSciModifyAttemptROEvent = procedure(ASender: TObject) of object;
  // # GTK+ Specific to work around focus and accelerator problems:
  // evt  Key=2005(Integer ch; Integer modifiers)
  // evt  DoubleClick=2006()
  TDSciUpdateUIEvent = procedure(ASender: TObject; AUpdated: Integer) of object;
  TDSciModifiedEvent = procedure(ASender: TObject; APosition: Integer; AModificationType: Integer;
    AText: UnicodeString; ALength: Integer; ALinesAdded: Integer; ALine: Integer;
    AFoldLevelNow: Integer; AFoldLevelPrev: Integer) of object;
  TDSciModified2Event = procedure(ASender: TObject; APosition: Integer; AModificationType: Integer;
    AText: UnicodeString; ALength: Integer; ALinesAdded: Integer; ALine: Integer;
    AFoldLevelNow: Integer; AFoldLevelPrev: Integer;
    AToken: Integer; AAnnotationLinesAdded: Integer) of object;
  TDSciMacroRecordEvent = procedure(ASender: TObject; AMessage: Integer; AWParam: Integer; ALParam: Integer) of object;
  TDSciMarginClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer; AMargin: Integer) of object;
  TDSciNeedShownEvent = procedure(ASender: TObject; APosition: Integer; ALength: Integer) of object;
  TDSciPaintedEvent = procedure(ASender: TObject) of object;
  TDSciUserListSelectionEvent = procedure(ASender: TObject; AListType: Integer; AText: UnicodeString) of object;
  TDSciUserListSelection2Event = procedure(ASender: TObject; AListType: Integer; AText: UnicodeString; APosition: Integer) of object;
  TDSciDwellStartEvent = procedure(ASender: TObject; APosition, X, Y: Integer) of object;
  TDSciDwellEndEvent = procedure(ASender: TObject; APosition, X, Y: Integer) of object;
  TDSciZoomEvent = procedure(ASender: TObject) of object;
  TDSciHotSpotClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciHotSpotDoubleClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciHotSpotReleaseClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciCallTipClickEvent = procedure(ASender: TObject; APosition: Integer) of object;
  TDSciAutoCSelectionEvent = procedure(ASender: TObject; AText: UnicodeString; APosition: Integer) of object;
  TDSciIndicatorClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciIndicatorReleaseEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciAutoCCancelledEvent = procedure(ASender: TObject) of object;
  TDSciAutoCCharDeletedEvent = procedure(ASender: TObject) of object;

const

{ Scintilla event codes }

  SCN_STYLENEEDED         = 2000;
  SCN_CHARADDED           = 2001;
  SCN_SAVEPOINTREACHED    = 2002;
  SCN_SAVEPOINTLEFT       = 2003;
  SCN_MODIFYATTEMPTRO     = 2004;
  //# GTK+ Specific to work around focus and accelerator problems:
  //evt void Key           =2005(int ch, int modifiers)
  //evt void DoubleClick   =2006(void)
  SCN_UPDATEUI            = 2007;
  SCN_MODIFIED            = 2008;
  SCN_MACRORECORD         = 2009;
  SCN_MARGINCLICK         = 2010;
  SCN_NEEDSHOWN           = 2011;
  SCN_PAINTED             = 2013;
  SCN_USERLISTSELECTION   = 2014;
  // Only on the GTK+ version
  // SCN_URIDROPPED         = 2015;
  SCN_DWELLSTART          = 2016;
  SCN_DWELLEND            = 2017;
  SCN_ZOOM                = 2018;
  SCN_HOTSPOTCLICK        = 2019;
  SCN_HOTSPOTDOUBLECLICK  = 2020;
  SCN_CALLTIPCLICK        = 2021;
  SCN_AUTOCSELECTION      = 2022;
  SCN_INDICATORCLICK      = 2023;
  SCN_INDICATORRELEASE    = 2024;
  SCN_AUTOCCANCELLED      = 2025;
  SCN_AUTOCCHARDELETED    = 2026;
  SCN_HOTSPOTRELEASECLICK = 2027;

const

{ Scintilla consts and method codes }

// <scigen>


  /// <summary>The INVALID_POSITION constant (-1)
  /// represents an invalid position within the document.</summary>
  INVALID_POSITION = -1;

  /// <summary>Define start of Scintilla messages to be greater than all Windows edit (EM_*) messages
  /// as many EM_ messages can be used although that use is deprecated.</summary>
  SCI_START = 2000;
  SCI_OPTIONAL_START = 3000;
  SCI_LEXER_START = 4000;

  /// <summary>Add text to the document at current position.</summary>
  SCI_ADDTEXT = 2001;

  /// <summary>Add array of cells to document.</summary>
  SCI_ADDSTYLEDTEXT = 2002;

  /// <summary>Insert string at a position.</summary>
  SCI_INSERTTEXT = 2003;

  /// <summary>Change the text that is being inserted in response to SC_MOD_INSERTCHECK</summary>
  SCI_CHANGEINSERTION = 2672;

  /// <summary>Delete all text in the document.</summary>
  SCI_CLEARALL = 2004;

  /// <summary>Delete a range of text in the document.</summary>
  SCI_DELETERANGE = 2645;

  /// <summary>Set all style bytes to 0, remove all folding information.</summary>
  SCI_CLEARDOCUMENTSTYLE = 2005;

  /// <summary>Returns the number of bytes in the document.</summary>
  SCI_GETLENGTH = 2006;

  /// <summary>Returns the character byte at the position.</summary>
  SCI_GETCHARAT = 2007;

  /// <summary>Returns the position of the caret.</summary>
  SCI_GETCURRENTPOS = 2008;

  /// <summary>Returns the position of the opposite end of the selection to the caret.</summary>
  SCI_GETANCHOR = 2009;

  /// <summary>Returns the style byte at the position.</summary>
  SCI_GETSTYLEAT = 2010;

  /// <summary>Redoes the next action on the undo history.</summary>
  SCI_REDO = 2011;

  /// <summary>Choose between collecting actions into the undo
  /// history and discarding them.</summary>
  SCI_SETUNDOCOLLECTION = 2012;

  /// <summary>Select all the text in the document.</summary>
  SCI_SELECTALL = 2013;

  /// <summary>Remember the current position in the undo history as the position
  /// at which the document was saved.</summary>
  SCI_SETSAVEPOINT = 2014;

  /// <summary>Retrieve a buffer of cells.
  /// Returns the number of bytes in the buffer not including terminating NULs.</summary>
  SCI_GETSTYLEDTEXT = 2015;

  /// <summary>Are there any redoable actions in the undo history?</summary>
  SCI_CANREDO = 2016;

  /// <summary>Retrieve the line number at which a particular marker is located.</summary>
  SCI_MARKERLINEFROMHANDLE = 2017;

  /// <summary>Delete a marker.</summary>
  SCI_MARKERDELETEHANDLE = 2018;

  /// <summary>Is undo history being collected?</summary>
  SCI_GETUNDOCOLLECTION = 2019;

  SCWS_INVISIBLE = 0;
  SCWS_VISIBLEALWAYS = 1;
  SCWS_VISIBLEAFTERINDENT = 2;

  /// <summary>Are white space characters currently visible?
  /// Returns one of SCWS_* constants.</summary>
  SCI_GETVIEWWS = 2020;

  /// <summary>Make white space characters invisible, always visible or visible outside indentation.</summary>
  SCI_SETVIEWWS = 2021;

  /// <summary>Find the position from a point within the window.</summary>
  SCI_POSITIONFROMPOINT = 2022;

  /// <summary>Find the position from a point within the window but return
  /// INVALID_POSITION if not close to text.</summary>
  SCI_POSITIONFROMPOINTCLOSE = 2023;

  /// <summary>Set caret to start of a line and ensure it is visible.</summary>
  SCI_GOTOLINE = 2024;

  /// <summary>Set caret to a position and ensure it is visible.</summary>
  SCI_GOTOPOS = 2025;

  /// <summary>Set the selection anchor to a position. The anchor is the opposite
  /// end of the selection from the caret.</summary>
  SCI_SETANCHOR = 2026;

  /// <summary>Retrieve the text of the line containing the caret.
  /// Returns the index of the caret on the line.</summary>
  SCI_GETCURLINE = 2027;

  /// <summary>Retrieve the position of the last correctly styled character.</summary>
  SCI_GETENDSTYLED = 2028;

  SC_EOL_CRLF = 0;
  SC_EOL_CR = 1;
  SC_EOL_LF = 2;

  /// <summary>Convert all line endings in the document to one mode.</summary>
  SCI_CONVERTEOLS = 2029;

  /// <summary>Retrieve the current end of line mode - one of CRLF, CR, or LF.</summary>
  SCI_GETEOLMODE = 2030;

  /// <summary>Set the current end of line mode.</summary>
  SCI_SETEOLMODE = 2031;

  /// <summary>Set the current styling position to pos and the styling mask to mask.
  /// The styling mask can be used to protect some bits in each styling byte from modification.</summary>
  SCI_STARTSTYLING = 2032;

  /// <summary>Change style from current styling position for length characters to a style
  /// and move the current styling position to after this newly styled segment.</summary>
  SCI_SETSTYLING = 2033;

  /// <summary>Is drawing done first into a buffer or direct to the screen?</summary>
  SCI_GETBUFFEREDDRAW = 2034;

  /// <summary>If drawing is buffered then each line of text is drawn into a bitmap buffer
  /// before drawing it to the screen to avoid flicker.</summary>
  SCI_SETBUFFEREDDRAW = 2035;

  /// <summary>Change the visible size of a tab to be a multiple of the width of a space character.</summary>
  SCI_SETTABWIDTH = 2036;

  /// <summary>Retrieve the visible size of a tab.</summary>
  SCI_GETTABWIDTH = 2121;

  /// <summary>The SC_CP_UTF8 value can be used to enter Unicode mode.
  /// This is the same value as CP_UTF8 in Windows</summary>
  SC_CP_UTF8 = 65001;

  /// <summary>Set the code page used to interpret the bytes of the document as characters.
  /// The SC_CP_UTF8 value can be used to enter Unicode mode.</summary>
  SCI_SETCODEPAGE = 2037;

  MARKER_MAX = 31;
  SC_MARK_CIRCLE = 0;
  SC_MARK_ROUNDRECT = 1;
  SC_MARK_ARROW = 2;
  SC_MARK_SMALLRECT = 3;
  SC_MARK_SHORTARROW = 4;
  SC_MARK_EMPTY = 5;
  SC_MARK_ARROWDOWN = 6;
  SC_MARK_MINUS = 7;
  SC_MARK_PLUS = 8;

  /// <summary>Shapes used for outlining column.</summary>
  SC_MARK_VLINE = 9;
  SC_MARK_LCORNER = 10;
  SC_MARK_TCORNER = 11;
  SC_MARK_BOXPLUS = 12;
  SC_MARK_BOXPLUSCONNECTED = 13;
  SC_MARK_BOXMINUS = 14;
  SC_MARK_BOXMINUSCONNECTED = 15;
  SC_MARK_LCORNERCURVE = 16;
  SC_MARK_TCORNERCURVE = 17;
  SC_MARK_CIRCLEPLUS = 18;
  SC_MARK_CIRCLEPLUSCONNECTED = 19;
  SC_MARK_CIRCLEMINUS = 20;
  SC_MARK_CIRCLEMINUSCONNECTED = 21;

  /// <summary>Invisible mark that only sets the line background colour.</summary>
  SC_MARK_BACKGROUND = 22;
  SC_MARK_DOTDOTDOT = 23;
  SC_MARK_ARROWS = 24;
  SC_MARK_PIXMAP = 25;
  SC_MARK_FULLRECT = 26;
  SC_MARK_LEFTRECT = 27;
  SC_MARK_AVAILABLE = 28;
  SC_MARK_UNDERLINE = 29;
  SC_MARK_RGBAIMAGE = 30;
  SC_MARK_BOOKMARK = 31;

  SC_MARK_CHARACTER = 10000;

  /// <summary>Markers used for outlining column.</summary>
  SC_MARKNUM_FOLDEREND = 25;
  SC_MARKNUM_FOLDEROPENMID = 26;
  SC_MARKNUM_FOLDERMIDTAIL = 27;
  SC_MARKNUM_FOLDERTAIL = 28;
  SC_MARKNUM_FOLDERSUB = 29;
  SC_MARKNUM_FOLDER = 30;
  SC_MARKNUM_FOLDEROPEN = 31;

  SC_MASK_FOLDERS = $FE000000;

  /// <summary>Set the symbol used for a particular marker number.</summary>
  SCI_MARKERDEFINE = 2040;

  /// <summary>Set the foreground colour used for a particular marker number.</summary>
  SCI_MARKERSETFORE = 2041;

  /// <summary>Set the background colour used for a particular marker number.</summary>
  SCI_MARKERSETBACK = 2042;

  /// <summary>Set the background colour used for a particular marker number when its folding block is selected.</summary>
  SCI_MARKERSETBACKSELECTED = 2292;

  /// <summary>Enable/disable highlight for current folding bloc (smallest one that contains the caret)</summary>
  SCI_MARKERENABLEHIGHLIGHT = 2293;

  /// <summary>Add a marker to a line, returning an ID which can be used to find or delete the marker.</summary>
  SCI_MARKERADD = 2043;

  /// <summary>Delete a marker from a line.</summary>
  SCI_MARKERDELETE = 2044;

  /// <summary>Delete all markers with a particular number from all lines.</summary>
  SCI_MARKERDELETEALL = 2045;

  /// <summary>Get a bit mask of all the markers set on a line.</summary>
  SCI_MARKERGET = 2046;

  /// <summary>Find the next line at or after lineStart that includes a marker in mask.
  /// Return -1 when no more lines.</summary>
  SCI_MARKERNEXT = 2047;

  /// <summary>Find the previous line before lineStart that includes a marker in mask.</summary>
  SCI_MARKERPREVIOUS = 2048;

  /// <summary>Define a marker from a pixmap.</summary>
  SCI_MARKERDEFINEPIXMAP = 2049;

  /// <summary>Add a set of markers to a line.</summary>
  SCI_MARKERADDSET = 2466;

  /// <summary>Set the alpha used for a marker that is drawn in the text area, not the margin.</summary>
  SCI_MARKERSETALPHA = 2476;

  SC_MAX_MARGIN = 4;

  SC_MARGIN_SYMBOL = 0;
  SC_MARGIN_NUMBER = 1;
  SC_MARGIN_BACK = 2;
  SC_MARGIN_FORE = 3;
  SC_MARGIN_TEXT = 4;
  SC_MARGIN_RTEXT = 5;

  /// <summary>Set a margin to be either numeric or symbolic.</summary>
  SCI_SETMARGINTYPEN = 2240;

  /// <summary>Retrieve the type of a margin.</summary>
  SCI_GETMARGINTYPEN = 2241;

  /// <summary>Set the width of a margin to a width expressed in pixels.</summary>
  SCI_SETMARGINWIDTHN = 2242;

  /// <summary>Retrieve the width of a margin in pixels.</summary>
  SCI_GETMARGINWIDTHN = 2243;

  /// <summary>Set a mask that determines which markers are displayed in a margin.</summary>
  SCI_SETMARGINMASKN = 2244;

  /// <summary>Retrieve the marker mask of a margin.</summary>
  SCI_GETMARGINMASKN = 2245;

  /// <summary>Make a margin sensitive or insensitive to mouse clicks.</summary>
  SCI_SETMARGINSENSITIVEN = 2246;

  /// <summary>Retrieve the mouse click sensitivity of a margin.</summary>
  SCI_GETMARGINSENSITIVEN = 2247;

  /// <summary>Set the cursor shown when the mouse is inside a margin.</summary>
  SCI_SETMARGINCURSORN = 2248;

  /// <summary>Retrieve the cursor shown in a margin.</summary>
  SCI_GETMARGINCURSORN = 2249;

  /// <summary>Styles in range 32..38 are predefined for parts of the UI and are not used as normal styles.
  /// Style 39 is for future use.</summary>
  STYLE_DEFAULT = 32;
  STYLE_LINENUMBER = 33;
  STYLE_BRACELIGHT = 34;
  STYLE_BRACEBAD = 35;
  STYLE_CONTROLCHAR = 36;
  STYLE_INDENTGUIDE = 37;
  STYLE_CALLTIP = 38;
  STYLE_LASTPREDEFINED = 39;
  STYLE_MAX = 255;

  /// <summary>Character set identifiers are used in StyleSetCharacterSet.
  /// The values are the same as the Windows *_CHARSET values.</summary>
  SC_CHARSET_ANSI = 0;
  SC_CHARSET_DEFAULT = 1;
  SC_CHARSET_BALTIC = 186;
  SC_CHARSET_CHINESEBIG5 = 136;
  SC_CHARSET_EASTEUROPE = 238;
  SC_CHARSET_GB2312 = 134;
  SC_CHARSET_GREEK = 161;
  SC_CHARSET_HANGUL = 129;
  SC_CHARSET_MAC = 77;
  SC_CHARSET_OEM = 255;
  SC_CHARSET_RUSSIAN = 204;
  SC_CHARSET_CYRILLIC = 1251;
  SC_CHARSET_SHIFTJIS = 128;
  SC_CHARSET_SYMBOL = 2;
  SC_CHARSET_TURKISH = 162;
  SC_CHARSET_JOHAB = 130;
  SC_CHARSET_HEBREW = 177;
  SC_CHARSET_ARABIC = 178;
  SC_CHARSET_VIETNAMESE = 163;
  SC_CHARSET_THAI = 222;
  SC_CHARSET_8859_15 = 1000;

  /// <summary>Clear all the styles and make equivalent to the global default style.</summary>
  SCI_STYLECLEARALL = 2050;

  /// <summary>Set the foreground colour of a style.</summary>
  SCI_STYLESETFORE = 2051;

  /// <summary>Set the background colour of a style.</summary>
  SCI_STYLESETBACK = 2052;

  /// <summary>Set a style to be bold or not.</summary>
  SCI_STYLESETBOLD = 2053;

  /// <summary>Set a style to be italic or not.</summary>
  SCI_STYLESETITALIC = 2054;

  /// <summary>Set the size of characters of a style.</summary>
  SCI_STYLESETSIZE = 2055;

  /// <summary>Set the font of a style.</summary>
  SCI_STYLESETFONT = 2056;

  /// <summary>Set a style to have its end of line filled or not.</summary>
  SCI_STYLESETEOLFILLED = 2057;

  /// <summary>Reset the default style to its state at startup</summary>
  SCI_STYLERESETDEFAULT = 2058;

  /// <summary>Set a style to be underlined or not.</summary>
  SCI_STYLESETUNDERLINE = 2059;

  SC_CASE_MIXED = 0;
  SC_CASE_UPPER = 1;
  SC_CASE_LOWER = 2;

  /// <summary>Get the foreground colour of a style.</summary>
  SCI_STYLEGETFORE = 2481;

  /// <summary>Get the background colour of a style.</summary>
  SCI_STYLEGETBACK = 2482;

  /// <summary>Get is a style bold or not.</summary>
  SCI_STYLEGETBOLD = 2483;

  /// <summary>Get is a style italic or not.</summary>
  SCI_STYLEGETITALIC = 2484;

  /// <summary>Get the size of characters of a style.</summary>
  SCI_STYLEGETSIZE = 2485;

  /// <summary>Get the font of a style.
  /// Returns the length of the fontName</summary>
  SCI_STYLEGETFONT = 2486;

  /// <summary>Get is a style to have its end of line filled or not.</summary>
  SCI_STYLEGETEOLFILLED = 2487;

  /// <summary>Get is a style underlined or not.</summary>
  SCI_STYLEGETUNDERLINE = 2488;

  /// <summary>Get is a style mixed case, or to force upper or lower case.</summary>
  SCI_STYLEGETCASE = 2489;

  /// <summary>Get the character get of the font in a style.</summary>
  SCI_STYLEGETCHARACTERSET = 2490;

  /// <summary>Get is a style visible or not.</summary>
  SCI_STYLEGETVISIBLE = 2491;

  /// <summary>Get is a style changeable or not (read only).
  /// Experimental feature, currently buggy.</summary>
  SCI_STYLEGETCHANGEABLE = 2492;

  /// <summary>Get is a style a hotspot or not.</summary>
  SCI_STYLEGETHOTSPOT = 2493;

  /// <summary>Set a style to be mixed case, or to force upper or lower case.</summary>
  SCI_STYLESETCASE = 2060;

  SC_FONT_SIZE_MULTIPLIER = 100;

  /// <summary>Set the size of characters of a style. Size is in points multiplied by 100.</summary>
  SCI_STYLESETSIZEFRACTIONAL = 2061;

  /// <summary>Get the size of characters of a style in points multiplied by 100</summary>
  SCI_STYLEGETSIZEFRACTIONAL = 2062;

  SC_WEIGHT_NORMAL = 400;
  SC_WEIGHT_SEMIBOLD = 600;
  SC_WEIGHT_BOLD = 700;

  /// <summary>Set the weight of characters of a style.</summary>
  SCI_STYLESETWEIGHT = 2063;

  /// <summary>Get the weight of characters of a style.</summary>
  SCI_STYLEGETWEIGHT = 2064;

  /// <summary>Set the character set of the font in a style.</summary>
  SCI_STYLESETCHARACTERSET = 2066;

  /// <summary>Set a style to be a hotspot or not.</summary>
  SCI_STYLESETHOTSPOT = 2409;

  /// <summary>Set the foreground colour of the main and additional selections and whether to use this setting.</summary>
  SCI_SETSELFORE = 2067;

  /// <summary>Set the background colour of the main and additional selections and whether to use this setting.</summary>
  SCI_SETSELBACK = 2068;

  /// <summary>Get the alpha of the selection.</summary>
  SCI_GETSELALPHA = 2477;

  /// <summary>Set the alpha of the selection.</summary>
  SCI_SETSELALPHA = 2478;

  /// <summary>Is the selection end of line filled?</summary>
  SCI_GETSELEOLFILLED = 2479;

  /// <summary>Set the selection to have its end of line filled or not.</summary>
  SCI_SETSELEOLFILLED = 2480;

  /// <summary>Set the foreground colour of the caret.</summary>
  SCI_SETCARETFORE = 2069;

  /// <summary>When key+modifier combination km is pressed perform msg.</summary>
  SCI_ASSIGNCMDKEY = 2070;

  /// <summary>When key+modifier combination km is pressed do nothing.</summary>
  SCI_CLEARCMDKEY = 2071;

  /// <summary>Drop all key mappings.</summary>
  SCI_CLEARALLCMDKEYS = 2072;

  /// <summary>Set the styles for a segment of the document.</summary>
  SCI_SETSTYLINGEX = 2073;

  /// <summary>Set a style to be visible or not.</summary>
  SCI_STYLESETVISIBLE = 2074;

  /// <summary>Get the time in milliseconds that the caret is on and off.</summary>
  SCI_GETCARETPERIOD = 2075;

  /// <summary>Get the time in milliseconds that the caret is on and off. 0 = steady on.</summary>
  SCI_SETCARETPERIOD = 2076;

  /// <summary>Set the set of characters making up words for when moving or selecting by word.
  /// First sets defaults like SetCharsDefault.</summary>
  SCI_SETWORDCHARS = 2077;

  /// <summary>Get the set of characters making up words for when moving or selecting by word.
  /// Retuns the number of characters</summary>
  SCI_GETWORDCHARS = 2646;

  /// <summary>Start a sequence of actions that is undone and redone as a unit.
  /// May be nested.</summary>
  SCI_BEGINUNDOACTION = 2078;

  /// <summary>End a sequence of actions that is undone and redone as a unit.</summary>
  SCI_ENDUNDOACTION = 2079;

  /// <summary>Indicator style enumeration and some constants</summary>
  INDIC_PLAIN = 0;
  INDIC_SQUIGGLE = 1;
  INDIC_TT = 2;
  INDIC_DIAGONAL = 3;
  INDIC_STRIKE = 4;
  INDIC_HIDDEN = 5;
  INDIC_BOX = 6;
  INDIC_ROUNDBOX = 7;
  INDIC_STRAIGHTBOX = 8;
  INDIC_DASH = 9;
  INDIC_DOTS = 10;
  INDIC_SQUIGGLELOW = 11;
  INDIC_DOTBOX = 12;
  INDIC_SQUIGGLEPIXMAP = 13;
  INDIC_COMPOSITIONTHICK = 14;
  INDIC_MAX = 31;
  INDIC_CONTAINER = 8;
  INDIC0_MASK = $20;
  INDIC1_MASK = $40;
  INDIC2_MASK = $80;
  INDICS_MASK = $E0;

  /// <summary>Set an indicator to plain, squiggle or TT.</summary>
  SCI_INDICSETSTYLE = 2080;

  /// <summary>Retrieve the style of an indicator.</summary>
  SCI_INDICGETSTYLE = 2081;

  /// <summary>Set the foreground colour of an indicator.</summary>
  SCI_INDICSETFORE = 2082;

  /// <summary>Retrieve the foreground colour of an indicator.</summary>
  SCI_INDICGETFORE = 2083;

  /// <summary>Set an indicator to draw under text or over(default).</summary>
  SCI_INDICSETUNDER = 2510;

  /// <summary>Retrieve whether indicator drawn under or over text.</summary>
  SCI_INDICGETUNDER = 2511;

  /// <summary>Set the foreground colour of all whitespace and whether to use this setting.</summary>
  SCI_SETWHITESPACEFORE = 2084;

  /// <summary>Set the background colour of all whitespace and whether to use this setting.</summary>
  SCI_SETWHITESPACEBACK = 2085;

  /// <summary>Set the size of the dots used to mark space characters.</summary>
  SCI_SETWHITESPACESIZE = 2086;

  /// <summary>Get the size of the dots used to mark space characters.</summary>
  SCI_GETWHITESPACESIZE = 2087;

  /// <summary>Divide each styling byte into lexical class bits (default: 5) and indicator
  /// bits (default: 3). If a lexer requires more than 32 lexical states, then this
  /// is used to expand the possible states.</summary>
  SCI_SETSTYLEBITS = 2090;

  /// <summary>Retrieve number of bits in style bytes used to hold the lexical state.</summary>
  SCI_GETSTYLEBITS = 2091;

  /// <summary>Used to hold extra styling information for each line.</summary>
  SCI_SETLINESTATE = 2092;

  /// <summary>Retrieve the extra styling information for a line.</summary>
  SCI_GETLINESTATE = 2093;

  /// <summary>Retrieve the last line number that has line state.</summary>
  SCI_GETMAXLINESTATE = 2094;

  /// <summary>Is the background of the line containing the caret in a different colour?</summary>
  SCI_GETCARETLINEVISIBLE = 2095;

  /// <summary>Display the background of the line containing the caret in a different colour.</summary>
  SCI_SETCARETLINEVISIBLE = 2096;

  /// <summary>Get the colour of the background of the line containing the caret.</summary>
  SCI_GETCARETLINEBACK = 2097;

  /// <summary>Set the colour of the background of the line containing the caret.</summary>
  SCI_SETCARETLINEBACK = 2098;

  /// <summary>Set a style to be changeable or not (read only).
  /// Experimental feature, currently buggy.</summary>
  SCI_STYLESETCHANGEABLE = 2099;

  /// <summary>Display a auto-completion list.
  /// The lenEntered parameter indicates how many characters before
  /// the caret should be used to provide context.</summary>
  SCI_AUTOCSHOW = 2100;

  /// <summary>Remove the auto-completion list from the screen.</summary>
  SCI_AUTOCCANCEL = 2101;

  /// <summary>Is there an auto-completion list visible?</summary>
  SCI_AUTOCACTIVE = 2102;

  /// <summary>Retrieve the position of the caret when the auto-completion list was displayed.</summary>
  SCI_AUTOCPOSSTART = 2103;

  /// <summary>User has selected an item so remove the list and insert the selection.</summary>
  SCI_AUTOCCOMPLETE = 2104;

  /// <summary>Define a set of character that when typed cancel the auto-completion list.</summary>
  SCI_AUTOCSTOPS = 2105;

  /// <summary>Change the separator character in the string setting up an auto-completion list.
  /// Default is space but can be changed if items contain space.</summary>
  SCI_AUTOCSETSEPARATOR = 2106;

  /// <summary>Retrieve the auto-completion list separator character.</summary>
  SCI_AUTOCGETSEPARATOR = 2107;

  /// <summary>Select the item in the auto-completion list that starts with a string.</summary>
  SCI_AUTOCSELECT = 2108;

  /// <summary>Should the auto-completion list be cancelled if the user backspaces to a
  /// position before where the box was created.</summary>
  SCI_AUTOCSETCANCELATSTART = 2110;

  /// <summary>Retrieve whether auto-completion cancelled by backspacing before start.</summary>
  SCI_AUTOCGETCANCELATSTART = 2111;

  /// <summary>Define a set of characters that when typed will cause the autocompletion to
  /// choose the selected item.</summary>
  SCI_AUTOCSETFILLUPS = 2112;

  /// <summary>Should a single item auto-completion list automatically choose the item.</summary>
  SCI_AUTOCSETCHOOSESINGLE = 2113;

  /// <summary>Retrieve whether a single item auto-completion list automatically choose the item.</summary>
  SCI_AUTOCGETCHOOSESINGLE = 2114;

  /// <summary>Set whether case is significant when performing auto-completion searches.</summary>
  SCI_AUTOCSETIGNORECASE = 2115;

  /// <summary>Retrieve state of ignore case flag.</summary>
  SCI_AUTOCGETIGNORECASE = 2116;

  /// <summary>Display a list of strings and send notification when user chooses one.</summary>
  SCI_USERLISTSHOW = 2117;

  /// <summary>Set whether or not autocompletion is hidden automatically when nothing matches.</summary>
  SCI_AUTOCSETAUTOHIDE = 2118;

  /// <summary>Retrieve whether or not autocompletion is hidden automatically when nothing matches.</summary>
  SCI_AUTOCGETAUTOHIDE = 2119;

  /// <summary>Set whether or not autocompletion deletes any word characters
  /// after the inserted text upon completion.</summary>
  SCI_AUTOCSETDROPRESTOFWORD = 2270;

  /// <summary>Retrieve whether or not autocompletion deletes any word characters
  /// after the inserted text upon completion.</summary>
  SCI_AUTOCGETDROPRESTOFWORD = 2271;

  /// <summary>Register an XPM image for use in autocompletion lists.</summary>
  SCI_REGISTERIMAGE = 2405;

  /// <summary>Clear all the registered XPM images.</summary>
  SCI_CLEARREGISTEREDIMAGES = 2408;

  /// <summary>Retrieve the auto-completion list type-separator character.</summary>
  SCI_AUTOCGETTYPESEPARATOR = 2285;

  /// <summary>Change the type-separator character in the string setting up an auto-completion list.
  /// Default is '?' but can be changed if items contain '?'.</summary>
  SCI_AUTOCSETTYPESEPARATOR = 2286;

  /// <summary>Set the maximum width, in characters, of auto-completion and user lists.
  /// Set to 0 to autosize to fit longest item, which is the default.</summary>
  SCI_AUTOCSETMAXWIDTH = 2208;

  /// <summary>Get the maximum width, in characters, of auto-completion and user lists.</summary>
  SCI_AUTOCGETMAXWIDTH = 2209;

  /// <summary>Set the maximum height, in rows, of auto-completion and user lists.
  /// The default is 5 rows.</summary>
  SCI_AUTOCSETMAXHEIGHT = 2210;

  /// <summary>Set the maximum height, in rows, of auto-completion and user lists.</summary>
  SCI_AUTOCGETMAXHEIGHT = 2211;

  /// <summary>Set the number of spaces used for one level of indentation.</summary>
  SCI_SETINDENT = 2122;

  /// <summary>Retrieve indentation size.</summary>
  SCI_GETINDENT = 2123;

  /// <summary>Indentation will only use space characters if useTabs is false, otherwise
  /// it will use a combination of tabs and spaces.</summary>
  SCI_SETUSETABS = 2124;

  /// <summary>Retrieve whether tabs will be used in indentation.</summary>
  SCI_GETUSETABS = 2125;

  /// <summary>Change the indentation of a line to a number of columns.</summary>
  SCI_SETLINEINDENTATION = 2126;

  /// <summary>Retrieve the number of columns that a line is indented.</summary>
  SCI_GETLINEINDENTATION = 2127;

  /// <summary>Retrieve the position before the first non indentation character on a line.</summary>
  SCI_GETLINEINDENTPOSITION = 2128;

  /// <summary>Retrieve the column number of a position, taking tab width into account.</summary>
  SCI_GETCOLUMN = 2129;

  /// <summary>Count characters between two positions.</summary>
  SCI_COUNTCHARACTERS = 2633;

  /// <summary>Show or hide the horizontal scroll bar.</summary>
  SCI_SETHSCROLLBAR = 2130;

  /// <summary>Is the horizontal scroll bar visible?</summary>
  SCI_GETHSCROLLBAR = 2131;

  SC_IV_NONE = 0;
  SC_IV_REAL = 1;
  SC_IV_LOOKFORWARD = 2;
  SC_IV_LOOKBOTH = 3;

  /// <summary>Show or hide indentation guides.</summary>
  SCI_SETINDENTATIONGUIDES = 2132;

  /// <summary>Are the indentation guides visible?</summary>
  SCI_GETINDENTATIONGUIDES = 2133;

  /// <summary>Set the highlighted indentation guide column.
  /// 0 = no highlighted guide.</summary>
  SCI_SETHIGHLIGHTGUIDE = 2134;

  /// <summary>Get the highlighted indentation guide column.</summary>
  SCI_GETHIGHLIGHTGUIDE = 2135;

  /// <summary>Get the position after the last visible characters on a line.</summary>
  SCI_GETLINEENDPOSITION = 2136;

  /// <summary>Get the code page used to interpret the bytes of the document as characters.</summary>
  SCI_GETCODEPAGE = 2137;

  /// <summary>Get the foreground colour of the caret.</summary>
  SCI_GETCARETFORE = 2138;

  /// <summary>In read-only mode?</summary>
  SCI_GETREADONLY = 2140;

  /// <summary>Sets the position of the caret.</summary>
  SCI_SETCURRENTPOS = 2141;

  /// <summary>Sets the position that starts the selection - this becomes the anchor.</summary>
  SCI_SETSELECTIONSTART = 2142;

  /// <summary>Returns the position at the start of the selection.</summary>
  SCI_GETSELECTIONSTART = 2143;

  /// <summary>Sets the position that ends the selection - this becomes the currentPosition.</summary>
  SCI_SETSELECTIONEND = 2144;

  /// <summary>Returns the position at the end of the selection.</summary>
  SCI_GETSELECTIONEND = 2145;

  /// <summary>Set caret to a position, while removing any existing selection.</summary>
  SCI_SETEMPTYSELECTION = 2556;

  /// <summary>Sets the print magnification added to the point size of each style for printing.</summary>
  SCI_SETPRINTMAGNIFICATION = 2146;

  /// <summary>Returns the print magnification.</summary>
  SCI_GETPRINTMAGNIFICATION = 2147;

  /// <summary>PrintColourMode - use same colours as screen.</summary>
  SC_PRINT_NORMAL = 0;

  /// <summary>PrintColourMode - invert the light value of each style for printing.</summary>
  SC_PRINT_INVERTLIGHT = 1;

  /// <summary>PrintColourMode - force black text on white background for printing.</summary>
  SC_PRINT_BLACKONWHITE = 2;

  /// <summary>PrintColourMode - text stays coloured, but all background is forced to be white for printing.</summary>
  SC_PRINT_COLOURONWHITE = 3;

  /// <summary>PrintColourMode - only the default-background is forced to be white for printing.</summary>
  SC_PRINT_COLOURONWHITEDEFAULTBG = 4;

  /// <summary>Modify colours when printing for clearer printed text.</summary>
  SCI_SETPRINTCOLOURMODE = 2148;

  /// <summary>Returns the print colour mode.</summary>
  SCI_GETPRINTCOLOURMODE = 2149;

  SCFIND_WHOLEWORD = $2;
  SCFIND_MATCHCASE = $4;
  SCFIND_WORDSTART = $00100000;
  SCFIND_REGEXP = $00200000;
  SCFIND_POSIX = $00400000;

  /// <summary>Find some text in the document.</summary>
  SCI_FINDTEXT = 2150;

  /// <summary>On Windows, will draw the document into a display context such as a printer.</summary>
  SCI_FORMATRANGE = 2151;

  /// <summary>Retrieve the display line at the top of the display.</summary>
  SCI_GETFIRSTVISIBLELINE = 2152;

  /// <summary>Retrieve the contents of a line.
  /// Returns the length of the line.</summary>
  SCI_GETLINE = 2153;

  /// <summary>Returns the number of lines in the document. There is always at least one.</summary>
  SCI_GETLINECOUNT = 2154;

  /// <summary>Sets the size in pixels of the left margin.</summary>
  SCI_SETMARGINLEFT = 2155;

  /// <summary>Returns the size in pixels of the left margin.</summary>
  SCI_GETMARGINLEFT = 2156;

  /// <summary>Sets the size in pixels of the right margin.</summary>
  SCI_SETMARGINRIGHT = 2157;

  /// <summary>Returns the size in pixels of the right margin.</summary>
  SCI_GETMARGINRIGHT = 2158;

  /// <summary>Is the document different from when it was last saved?</summary>
  SCI_GETMODIFY = 2159;

  /// <summary>Select a range of text.</summary>
  SCI_SETSEL = 2160;

  /// <summary>Retrieve the selected text.
  /// Return the length of the text.</summary>
  SCI_GETSELTEXT = 2161;

  /// <summary>Retrieve a range of text.
  /// Return the length of the text.</summary>
  SCI_GETTEXTRANGE = 2162;

  /// <summary>Draw the selection in normal style or with selection highlighted.</summary>
  SCI_HIDESELECTION = 2163;

  /// <summary>Retrieve the x value of the point in the window where a position is displayed.</summary>
  SCI_POINTXFROMPOSITION = 2164;

  /// <summary>Retrieve the y value of the point in the window where a position is displayed.</summary>
  SCI_POINTYFROMPOSITION = 2165;

  /// <summary>Retrieve the line containing a position.</summary>
  SCI_LINEFROMPOSITION = 2166;

  /// <summary>Retrieve the position at the start of a line.</summary>
  SCI_POSITIONFROMLINE = 2167;

  /// <summary>Scroll horizontally and vertically.</summary>
  SCI_LINESCROLL = 2168;

  /// <summary>Ensure the caret is visible.</summary>
  SCI_SCROLLCARET = 2169;

  /// <summary>Scroll the argument positions and the range between them into view giving
  /// priority to the primary position then the secondary position.
  /// This may be used to make a search match visible.</summary>
  SCI_SCROLLRANGE = 2569;

  /// <summary>Replace the selected text with the argument text.</summary>
  SCI_REPLACESEL = 2170;

  /// <summary>Set to read only or read write.</summary>
  SCI_SETREADONLY = 2171;

  /// <summary>Null operation.</summary>
  SCI_NULL = 2172;

  /// <summary>Will a paste succeed?</summary>
  SCI_CANPASTE = 2173;

  /// <summary>Are there any undoable actions in the undo history?</summary>
  SCI_CANUNDO = 2174;

  /// <summary>Delete the undo history.</summary>
  SCI_EMPTYUNDOBUFFER = 2175;

  /// <summary>Undo one action in the undo history.</summary>
  SCI_UNDO = 2176;

  /// <summary>Cut the selection to the clipboard.</summary>
  SCI_CUT = 2177;

  /// <summary>Copy the selection to the clipboard.</summary>
  SCI_COPY = 2178;

  /// <summary>Paste the contents of the clipboard into the document replacing the selection.</summary>
  SCI_PASTE = 2179;

  /// <summary>Clear the selection.</summary>
  SCI_CLEAR = 2180;

  /// <summary>Replace the contents of the document with the argument text.</summary>
  SCI_SETTEXT = 2181;

  /// <summary>Retrieve all the text in the document.
  /// Returns number of characters retrieved.</summary>
  SCI_GETTEXT = 2182;

  /// <summary>Retrieve the number of characters in the document.</summary>
  SCI_GETTEXTLENGTH = 2183;

  /// <summary>Retrieve a pointer to a function that processes messages for this Scintilla.</summary>
  SCI_GETDIRECTFUNCTION = 2184;

  /// <summary>Retrieve a pointer value to use as the first argument when calling
  /// the function returned by GetDirectFunction.</summary>
  SCI_GETDIRECTPOINTER = 2185;

  /// <summary>Set to overtype (true) or insert mode.</summary>
  SCI_SETOVERTYPE = 2186;

  /// <summary>Returns true if overtype mode is active otherwise false is returned.</summary>
  SCI_GETOVERTYPE = 2187;

  /// <summary>Set the width of the insert mode caret.</summary>
  SCI_SETCARETWIDTH = 2188;

  /// <summary>Returns the width of the insert mode caret.</summary>
  SCI_GETCARETWIDTH = 2189;

  /// <summary>Sets the position that starts the target which is used for updating the
  /// document without affecting the scroll position.</summary>
  SCI_SETTARGETSTART = 2190;

  /// <summary>Get the position that starts the target.</summary>
  SCI_GETTARGETSTART = 2191;

  /// <summary>Sets the position that ends the target which is used for updating the
  /// document without affecting the scroll position.</summary>
  SCI_SETTARGETEND = 2192;

  /// <summary>Get the position that ends the target.</summary>
  SCI_GETTARGETEND = 2193;

  /// <summary>Replace the target text with the argument text.
  /// Text is counted so it can contain NULs.
  /// Returns the length of the replacement text.</summary>
  SCI_REPLACETARGET = 2194;

  /// <summary>Replace the target text with the argument text after \d processing.
  /// Text is counted so it can contain NULs.
  /// Looks for \d where d is between 1 and 9 and replaces these with the strings
  /// matched in the last search operation which were surrounded by \( and \).
  /// Returns the length of the replacement text including any change
  /// caused by processing the \d patterns.</summary>
  SCI_REPLACETARGETRE = 2195;

  /// <summary>Search for a counted string in the target and set the target to the found
  /// range. Text is counted so it can contain NULs.
  /// Returns length of range or -1 for failure in which case target is not moved.</summary>
  SCI_SEARCHINTARGET = 2197;

  /// <summary>Set the search flags used by SearchInTarget.</summary>
  SCI_SETSEARCHFLAGS = 2198;

  /// <summary>Get the search flags used by SearchInTarget.</summary>
  SCI_GETSEARCHFLAGS = 2199;

  /// <summary>Show a call tip containing a definition near position pos.</summary>
  SCI_CALLTIPSHOW = 2200;

  /// <summary>Remove the call tip from the screen.</summary>
  SCI_CALLTIPCANCEL = 2201;

  /// <summary>Is there an active call tip?</summary>
  SCI_CALLTIPACTIVE = 2202;

  /// <summary>Retrieve the position where the caret was before displaying the call tip.</summary>
  SCI_CALLTIPPOSSTART = 2203;

  /// <summary>Set the start position in order to change when backspacing removes the calltip.</summary>
  SCI_CALLTIPSETPOSSTART = 2214;

  /// <summary>Highlight a segment of the definition.</summary>
  SCI_CALLTIPSETHLT = 2204;

  /// <summary>Set the background colour for the call tip.</summary>
  SCI_CALLTIPSETBACK = 2205;

  /// <summary>Set the foreground colour for the call tip.</summary>
  SCI_CALLTIPSETFORE = 2206;

  /// <summary>Set the foreground colour for the highlighted part of the call tip.</summary>
  SCI_CALLTIPSETFOREHLT = 2207;

  /// <summary>Enable use of STYLE_CALLTIP and set call tip tab size in pixels.</summary>
  SCI_CALLTIPUSESTYLE = 2212;

  /// <summary>Set position of calltip, above or below text.</summary>
  SCI_CALLTIPSETPOSITION = 2213;

  /// <summary>Find the display line of a document line taking hidden lines into account.</summary>
  SCI_VISIBLEFROMDOCLINE = 2220;

  /// <summary>Find the document line of a display line taking hidden lines into account.</summary>
  SCI_DOCLINEFROMVISIBLE = 2221;

  /// <summary>The number of display lines needed to wrap a document line</summary>
  SCI_WRAPCOUNT = 2235;

  SC_FOLDLEVELBASE = $400;
  SC_FOLDLEVELWHITEFLAG = $1000;
  SC_FOLDLEVELHEADERFLAG = $2000;
  SC_FOLDLEVELNUMBERMASK = $0FFF;

  /// <summary>Set the fold level of a line.
  /// This encodes an integer level along with flags indicating whether the
  /// line is a header and whether it is effectively white space.</summary>
  SCI_SETFOLDLEVEL = 2222;

  /// <summary>Retrieve the fold level of a line.</summary>
  SCI_GETFOLDLEVEL = 2223;

  /// <summary>Find the last child line of a header line.</summary>
  SCI_GETLASTCHILD = 2224;

  /// <summary>Find the parent line of a child line.</summary>
  SCI_GETFOLDPARENT = 2225;

  /// <summary>Make a range of lines visible.</summary>
  SCI_SHOWLINES = 2226;

  /// <summary>Make a range of lines invisible.</summary>
  SCI_HIDELINES = 2227;

  /// <summary>Is a line visible?</summary>
  SCI_GETLINEVISIBLE = 2228;

  /// <summary>Are all lines visible?</summary>
  SCI_GETALLLINESVISIBLE = 2236;

  /// <summary>Show the children of a header line.</summary>
  SCI_SETFOLDEXPANDED = 2229;

  /// <summary>Is a header line expanded?</summary>
  SCI_GETFOLDEXPANDED = 2230;

  /// <summary>Switch a header line between expanded and contracted.</summary>
  SCI_TOGGLEFOLD = 2231;

  SC_FOLDACTION_CONTRACT = 0;
  SC_FOLDACTION_EXPAND = 1;
  SC_FOLDACTION_TOGGLE = 2;

  /// <summary>Expand or contract a fold header.</summary>
  SCI_FOLDLINE = 2237;

  /// <summary>Expand or contract a fold header and its children.</summary>
  SCI_FOLDCHILDREN = 2238;

  /// <summary>Expand a fold header and all children. Use the level argument instead of the line's current level.</summary>
  SCI_EXPANDCHILDREN = 2239;

  /// <summary>Expand or contract all fold headers.</summary>
  SCI_FOLDALL = 2662;

  /// <summary>Ensure a particular line is visible by expanding any header line hiding it.</summary>
  SCI_ENSUREVISIBLE = 2232;

  SC_AUTOMATICFOLD_SHOW = $0001;
  SC_AUTOMATICFOLD_CLICK = $0002;
  SC_AUTOMATICFOLD_CHANGE = $0004;

  /// <summary>Set automatic folding behaviours.</summary>
  SCI_SETAUTOMATICFOLD = 2663;

  /// <summary>Get automatic folding behaviours.</summary>
  SCI_GETAUTOMATICFOLD = 2664;

  SC_FOLDFLAG_LINEBEFORE_EXPANDED = $0002;
  SC_FOLDFLAG_LINEBEFORE_CONTRACTED = $0004;
  SC_FOLDFLAG_LINEAFTER_EXPANDED = $0008;
  SC_FOLDFLAG_LINEAFTER_CONTRACTED = $0010;
  SC_FOLDFLAG_LEVELNUMBERS = $0040;
  SC_FOLDFLAG_LINESTATE = $0080;

  /// <summary>Set some style options for folding.</summary>
  SCI_SETFOLDFLAGS = 2233;

  /// <summary>Ensure a particular line is visible by expanding any header line hiding it.
  /// Use the currently set visibility policy to determine which range to display.</summary>
  SCI_ENSUREVISIBLEENFORCEPOLICY = 2234;

  /// <summary>Sets whether a tab pressed when caret is within indentation indents.</summary>
  SCI_SETTABINDENTS = 2260;

  /// <summary>Does a tab pressed when caret is within indentation indent?</summary>
  SCI_GETTABINDENTS = 2261;

  /// <summary>Sets whether a backspace pressed when caret is within indentation unindents.</summary>
  SCI_SETBACKSPACEUNINDENTS = 2262;

  /// <summary>Does a backspace pressed when caret is within indentation unindent?</summary>
  SCI_GETBACKSPACEUNINDENTS = 2263;

  SC_TIME_FOREVER = 10000000;

  /// <summary>Sets the time the mouse must sit still to generate a mouse dwell event.</summary>
  SCI_SETMOUSEDWELLTIME = 2264;

  /// <summary>Retrieve the time the mouse must sit still to generate a mouse dwell event.</summary>
  SCI_GETMOUSEDWELLTIME = 2265;

  /// <summary>Get position of start of word.</summary>
  SCI_WORDSTARTPOSITION = 2266;

  /// <summary>Get position of end of word.</summary>
  SCI_WORDENDPOSITION = 2267;

  SC_WRAP_NONE = 0;
  SC_WRAP_WORD = 1;
  SC_WRAP_CHAR = 2;
  SC_WRAP_WHITESPACE = 3;

  /// <summary>Sets whether text is word wrapped.</summary>
  SCI_SETWRAPMODE = 2268;

  /// <summary>Retrieve whether text is word wrapped.</summary>
  SCI_GETWRAPMODE = 2269;

  SC_WRAPVISUALFLAG_NONE = $0000;
  SC_WRAPVISUALFLAG_END = $0001;
  SC_WRAPVISUALFLAG_START = $0002;
  SC_WRAPVISUALFLAG_MARGIN = $0004;

  /// <summary>Set the display mode of visual flags for wrapped lines.</summary>
  SCI_SETWRAPVISUALFLAGS = 2460;

  /// <summary>Retrive the display mode of visual flags for wrapped lines.</summary>
  SCI_GETWRAPVISUALFLAGS = 2461;

  SC_WRAPVISUALFLAGLOC_DEFAULT = $0000;
  SC_WRAPVISUALFLAGLOC_END_BY_TEXT = $0001;
  SC_WRAPVISUALFLAGLOC_START_BY_TEXT = $0002;

  /// <summary>Set the location of visual flags for wrapped lines.</summary>
  SCI_SETWRAPVISUALFLAGSLOCATION = 2462;

  /// <summary>Retrive the location of visual flags for wrapped lines.</summary>
  SCI_GETWRAPVISUALFLAGSLOCATION = 2463;

  /// <summary>Set the start indent for wrapped lines.</summary>
  SCI_SETWRAPSTARTINDENT = 2464;

  /// <summary>Retrive the start indent for wrapped lines.</summary>
  SCI_GETWRAPSTARTINDENT = 2465;

  SC_WRAPINDENT_FIXED = 0;
  SC_WRAPINDENT_SAME = 1;
  SC_WRAPINDENT_INDENT = 2;

  /// <summary>Sets how wrapped sublines are placed. Default is fixed.</summary>
  SCI_SETWRAPINDENTMODE = 2472;

  /// <summary>Retrieve how wrapped sublines are placed. Default is fixed.</summary>
  SCI_GETWRAPINDENTMODE = 2473;

  SC_CACHE_NONE = 0;
  SC_CACHE_CARET = 1;
  SC_CACHE_PAGE = 2;
  SC_CACHE_DOCUMENT = 3;

  /// <summary>Sets the degree of caching of layout information.</summary>
  SCI_SETLAYOUTCACHE = 2272;

  /// <summary>Retrieve the degree of caching of layout information.</summary>
  SCI_GETLAYOUTCACHE = 2273;

  /// <summary>Sets the document width assumed for scrolling.</summary>
  SCI_SETSCROLLWIDTH = 2274;

  /// <summary>Retrieve the document width assumed for scrolling.</summary>
  SCI_GETSCROLLWIDTH = 2275;

  /// <summary>Sets whether the maximum width line displayed is used to set scroll width.</summary>
  SCI_SETSCROLLWIDTHTRACKING = 2516;

  /// <summary>Retrieve whether the scroll width tracks wide lines.</summary>
  SCI_GETSCROLLWIDTHTRACKING = 2517;

  /// <summary>Measure the pixel width of some text in a particular style.
  /// NUL terminated text argument.
  /// Does not handle tab or control characters.</summary>
  SCI_TEXTWIDTH = 2276;

  /// <summary>Sets the scroll range so that maximum scroll position has
  /// the last line at the bottom of the view (default).
  /// Setting this to false allows scrolling one page below the last line.</summary>
  SCI_SETENDATLASTLINE = 2277;

  /// <summary>Retrieve whether the maximum scroll position has the last
  /// line at the bottom of the view.</summary>
  SCI_GETENDATLASTLINE = 2278;

  /// <summary>Retrieve the height of a particular line of text in pixels.</summary>
  SCI_TEXTHEIGHT = 2279;

  /// <summary>Show or hide the vertical scroll bar.</summary>
  SCI_SETVSCROLLBAR = 2280;

  /// <summary>Is the vertical scroll bar visible?</summary>
  SCI_GETVSCROLLBAR = 2281;

  /// <summary>Append a string to the end of the document without changing the selection.</summary>
  SCI_APPENDTEXT = 2282;

  /// <summary>Is drawing done in two phases with backgrounds drawn before faoregrounds?</summary>
  SCI_GETTWOPHASEDRAW = 2283;

  /// <summary>In twoPhaseDraw mode, drawing is performed in two phases, first the background
  /// and then the foreground. This avoids chopping off characters that overlap the next run.</summary>
  SCI_SETTWOPHASEDRAW = 2284;

  SC_EFF_QUALITY_MASK = $F;
  SC_EFF_QUALITY_DEFAULT = 0;
  SC_EFF_QUALITY_NON_ANTIALIASED = 1;
  SC_EFF_QUALITY_ANTIALIASED = 2;
  SC_EFF_QUALITY_LCD_OPTIMIZED = 3;

  /// <summary>Choose the quality level for text from the FontQuality enumeration.</summary>
  SCI_SETFONTQUALITY = 2611;

  /// <summary>Retrieve the quality level for text.</summary>
  SCI_GETFONTQUALITY = 2612;

  /// <summary>Scroll so that a display line is at the top of the display.</summary>
  SCI_SETFIRSTVISIBLELINE = 2613;

  SC_MULTIPASTE_ONCE = 0;
  SC_MULTIPASTE_EACH = 1;

  /// <summary>Change the effect of pasting when there are multiple selections.</summary>
  SCI_SETMULTIPASTE = 2614;

  /// <summary>Retrieve the effect of pasting when there are multiple selections..</summary>
  SCI_GETMULTIPASTE = 2615;

  /// <summary>Retrieve the value of a tag from a regular expression search.</summary>
  SCI_GETTAG = 2616;

  /// <summary>Make the target range start and end be the same as the selection range start and end.</summary>
  SCI_TARGETFROMSELECTION = 2287;

  /// <summary>Join the lines in the target.</summary>
  SCI_LINESJOIN = 2288;

  /// <summary>Split the lines in the target into lines that are less wide than pixelWidth
  /// where possible.</summary>
  SCI_LINESSPLIT = 2289;

  /// <summary>Set the colours used as a chequerboard pattern in the fold margin</summary>
  SCI_SETFOLDMARGINCOLOUR = 2290;
  SCI_SETFOLDMARGINHICOLOUR = 2291;

  /// <summary>Move caret down one line.</summary>
  SCI_LINEDOWN = 2300;

  /// <summary>Move caret down one line extending selection to new caret position.</summary>
  SCI_LINEDOWNEXTEND = 2301;

  /// <summary>Move caret up one line.</summary>
  SCI_LINEUP = 2302;

  /// <summary>Move caret up one line extending selection to new caret position.</summary>
  SCI_LINEUPEXTEND = 2303;

  /// <summary>Move caret left one character.</summary>
  SCI_CHARLEFT = 2304;

  /// <summary>Move caret left one character extending selection to new caret position.</summary>
  SCI_CHARLEFTEXTEND = 2305;

  /// <summary>Move caret right one character.</summary>
  SCI_CHARRIGHT = 2306;

  /// <summary>Move caret right one character extending selection to new caret position.</summary>
  SCI_CHARRIGHTEXTEND = 2307;

  /// <summary>Move caret left one word.</summary>
  SCI_WORDLEFT = 2308;

  /// <summary>Move caret left one word extending selection to new caret position.</summary>
  SCI_WORDLEFTEXTEND = 2309;

  /// <summary>Move caret right one word.</summary>
  SCI_WORDRIGHT = 2310;

  /// <summary>Move caret right one word extending selection to new caret position.</summary>
  SCI_WORDRIGHTEXTEND = 2311;

  /// <summary>Move caret to first position on line.</summary>
  SCI_HOME = 2312;

  /// <summary>Move caret to first position on line extending selection to new caret position.</summary>
  SCI_HOMEEXTEND = 2313;

  /// <summary>Move caret to last position on line.</summary>
  SCI_LINEEND = 2314;

  /// <summary>Move caret to last position on line extending selection to new caret position.</summary>
  SCI_LINEENDEXTEND = 2315;

  /// <summary>Move caret to first position in document.</summary>
  SCI_DOCUMENTSTART = 2316;

  /// <summary>Move caret to first position in document extending selection to new caret position.</summary>
  SCI_DOCUMENTSTARTEXTEND = 2317;

  /// <summary>Move caret to last position in document.</summary>
  SCI_DOCUMENTEND = 2318;

  /// <summary>Move caret to last position in document extending selection to new caret position.</summary>
  SCI_DOCUMENTENDEXTEND = 2319;

  /// <summary>Move caret one page up.</summary>
  SCI_PAGEUP = 2320;

  /// <summary>Move caret one page up extending selection to new caret position.</summary>
  SCI_PAGEUPEXTEND = 2321;

  /// <summary>Move caret one page down.</summary>
  SCI_PAGEDOWN = 2322;

  /// <summary>Move caret one page down extending selection to new caret position.</summary>
  SCI_PAGEDOWNEXTEND = 2323;

  /// <summary>Switch from insert to overtype mode or the reverse.</summary>
  SCI_EDITTOGGLEOVERTYPE = 2324;

  /// <summary>Cancel any modes such as call tip or auto-completion list display.</summary>
  SCI_CANCEL = 2325;

  /// <summary>Delete the selection or if no selection, the character before the caret.</summary>
  SCI_DELETEBACK = 2326;

  /// <summary>If selection is empty or all on one line replace the selection with a tab character.
  /// If more than one line selected, indent the lines.</summary>
  SCI_TAB = 2327;

  /// <summary>Dedent the selected lines.</summary>
  SCI_BACKTAB = 2328;

  /// <summary>Insert a new line, may use a CRLF, CR or LF depending on EOL mode.</summary>
  SCI_NEWLINE = 2329;

  /// <summary>Insert a Form Feed character.</summary>
  SCI_FORMFEED = 2330;

  /// <summary>Move caret to before first visible character on line.
  /// If already there move to first character on line.</summary>
  SCI_VCHOME = 2331;

  /// <summary>Like VCHome but extending selection to new caret position.</summary>
  SCI_VCHOMEEXTEND = 2332;

  /// <summary>Magnify the displayed text by increasing the sizes by 1 point.</summary>
  SCI_ZOOMIN = 2333;

  /// <summary>Make the displayed text smaller by decreasing the sizes by 1 point.</summary>
  SCI_ZOOMOUT = 2334;

  /// <summary>Delete the word to the left of the caret.</summary>
  SCI_DELWORDLEFT = 2335;

  /// <summary>Delete the word to the right of the caret.</summary>
  SCI_DELWORDRIGHT = 2336;

  /// <summary>Delete the word to the right of the caret, but not the trailing non-word characters.</summary>
  SCI_DELWORDRIGHTEND = 2518;

  /// <summary>Cut the line containing the caret.</summary>
  SCI_LINECUT = 2337;

  /// <summary>Delete the line containing the caret.</summary>
  SCI_LINEDELETE = 2338;

  /// <summary>Switch the current line with the previous.</summary>
  SCI_LINETRANSPOSE = 2339;

  /// <summary>Duplicate the current line.</summary>
  SCI_LINEDUPLICATE = 2404;

  /// <summary>Transform the selection to lower case.</summary>
  SCI_LOWERCASE = 2340;

  /// <summary>Transform the selection to upper case.</summary>
  SCI_UPPERCASE = 2341;

  /// <summary>Scroll the document down, keeping the caret visible.</summary>
  SCI_LINESCROLLDOWN = 2342;

  /// <summary>Scroll the document up, keeping the caret visible.</summary>
  SCI_LINESCROLLUP = 2343;

  /// <summary>Delete the selection or if no selection, the character before the caret.
  /// Will not delete the character before at the start of a line.</summary>
  SCI_DELETEBACKNOTLINE = 2344;

  /// <summary>Move caret to first position on display line.</summary>
  SCI_HOMEDISPLAY = 2345;

  /// <summary>Move caret to first position on display line extending selection to
  /// new caret position.</summary>
  SCI_HOMEDISPLAYEXTEND = 2346;

  /// <summary>Move caret to last position on display line.</summary>
  SCI_LINEENDDISPLAY = 2347;

  /// <summary>Move caret to last position on display line extending selection to new
  /// caret position.</summary>
  SCI_LINEENDDISPLAYEXTEND = 2348;

  SCI_HOMEWRAP = 2349;
  SCI_HOMEWRAPEXTEND = 2450;
  SCI_LINEENDWRAP = 2451;
  SCI_LINEENDWRAPEXTEND = 2452;
  SCI_VCHOMEWRAP = 2453;
  SCI_VCHOMEWRAPEXTEND = 2454;

  /// <summary>Copy the line containing the caret.</summary>
  SCI_LINECOPY = 2455;

  /// <summary>Move the caret inside current view if it's not there already.</summary>
  SCI_MOVECARETINSIDEVIEW = 2401;

  /// <summary>How many characters are on a line, including end of line characters?</summary>
  SCI_LINELENGTH = 2350;

  /// <summary>Highlight the characters at two positions.</summary>
  SCI_BRACEHIGHLIGHT = 2351;

  /// <summary>Use specified indicator to highlight matching braces instead of changing their style.</summary>
  SCI_BRACEHIGHLIGHTINDICATOR = 2498;

  /// <summary>Highlight the character at a position indicating there is no matching brace.</summary>
  SCI_BRACEBADLIGHT = 2352;

  /// <summary>Use specified indicator to highlight non matching brace instead of changing its style.</summary>
  SCI_BRACEBADLIGHTINDICATOR = 2499;

  /// <summary>Find the position of a matching brace or INVALID_POSITION if no match.</summary>
  SCI_BRACEMATCH = 2353;

  /// <summary>Are the end of line characters visible?</summary>
  SCI_GETVIEWEOL = 2355;

  /// <summary>Make the end of line characters visible or invisible.</summary>
  SCI_SETVIEWEOL = 2356;

  /// <summary>Retrieve a pointer to the document object.</summary>
  SCI_GETDOCPOINTER = 2357;

  /// <summary>Change the document object used.</summary>
  SCI_SETDOCPOINTER = 2358;

  /// <summary>Set which document modification events are sent to the container.</summary>
  SCI_SETMODEVENTMASK = 2359;

  EDGE_NONE = 0;
  EDGE_LINE = 1;
  EDGE_BACKGROUND = 2;

  /// <summary>Retrieve the column number which text should be kept within.</summary>
  SCI_GETEDGECOLUMN = 2360;

  /// <summary>Set the column number of the edge.
  /// If text goes past the edge then it is highlighted.</summary>
  SCI_SETEDGECOLUMN = 2361;

  /// <summary>Retrieve the edge highlight mode.</summary>
  SCI_GETEDGEMODE = 2362;

  /// <summary>The edge may be displayed by a line (EDGE_LINE) or by highlighting text that
  /// goes beyond it (EDGE_BACKGROUND) or not displayed at all (EDGE_NONE).</summary>
  SCI_SETEDGEMODE = 2363;

  /// <summary>Retrieve the colour used in edge indication.</summary>
  SCI_GETEDGECOLOUR = 2364;

  /// <summary>Change the colour used in edge indication.</summary>
  SCI_SETEDGECOLOUR = 2365;

  /// <summary>Sets the current caret position to be the search anchor.</summary>
  SCI_SEARCHANCHOR = 2366;

  /// <summary>Find some text starting at the search anchor.
  /// Does not ensure the selection is visible.</summary>
  SCI_SEARCHNEXT = 2367;

  /// <summary>Find some text starting at the search anchor and moving backwards.
  /// Does not ensure the selection is visible.</summary>
  SCI_SEARCHPREV = 2368;

  /// <summary>Retrieves the number of lines completely visible.</summary>
  SCI_LINESONSCREEN = 2370;

  /// <summary>Set whether a pop up menu is displayed automatically when the user presses
  /// the wrong mouse button.</summary>
  SCI_USEPOPUP = 2371;

  /// <summary>Is the selection rectangular? The alternative is the more common stream selection.</summary>
  SCI_SELECTIONISRECTANGLE = 2372;

  /// <summary>Set the zoom level. This number of points is added to the size of all fonts.
  /// It may be positive to magnify or negative to reduce.</summary>
  SCI_SETZOOM = 2373;

  /// <summary>Retrieve the zoom level.</summary>
  SCI_GETZOOM = 2374;

  /// <summary>Create a new document object.
  /// Starts with reference count of 1 and not selected into editor.</summary>
  SCI_CREATEDOCUMENT = 2375;

  /// <summary>Extend life of document.</summary>
  SCI_ADDREFDOCUMENT = 2376;

  /// <summary>Release a reference to the document, deleting document if it fades to black.</summary>
  SCI_RELEASEDOCUMENT = 2377;

  /// <summary>Get which document modification events are sent to the container.</summary>
  SCI_GETMODEVENTMASK = 2378;

  /// <summary>Change internal focus flag.</summary>
  SCI_SETFOCUS = 2380;

  /// <summary>Get internal focus flag.</summary>
  SCI_GETFOCUS = 2381;

  SC_STATUS_OK = 0;
  SC_STATUS_FAILURE = 1;
  SC_STATUS_BADALLOC = 2;

  /// <summary>Change error status - 0 = OK.</summary>
  SCI_SETSTATUS = 2382;

  /// <summary>Get error status.</summary>
  SCI_GETSTATUS = 2383;

  /// <summary>Set whether the mouse is captured when its button is pressed.</summary>
  SCI_SETMOUSEDOWNCAPTURES = 2384;

  /// <summary>Get whether mouse gets captured.</summary>
  SCI_GETMOUSEDOWNCAPTURES = 2385;

  SC_CURSORNORMAL = -1;
  SC_CURSORARROW = 2;
  SC_CURSORWAIT = 4;
  SC_CURSORREVERSEARROW = 7;

  /// <summary>Sets the cursor to one of the SC_CURSOR* values.</summary>
  SCI_SETCURSOR = 2386;

  /// <summary>Get cursor type.</summary>
  SCI_GETCURSOR = 2387;

  /// <summary>Change the way control characters are displayed:
  /// If symbol is &lt; 32, keep the drawn way, else, use the given character.</summary>
  SCI_SETCONTROLCHARSYMBOL = 2388;

  /// <summary>Get the way control characters are displayed.</summary>
  SCI_GETCONTROLCHARSYMBOL = 2389;

  /// <summary>Move to the previous change in capitalisation.</summary>
  SCI_WORDPARTLEFT = 2390;

  /// <summary>Move to the previous change in capitalisation extending selection
  /// to new caret position.</summary>
  SCI_WORDPARTLEFTEXTEND = 2391;

  /// <summary>Move to the change next in capitalisation.</summary>
  SCI_WORDPARTRIGHT = 2392;

  /// <summary>Move to the next change in capitalisation extending selection
  /// to new caret position.</summary>
  SCI_WORDPARTRIGHTEXTEND = 2393;

  /// <summary>Constants for use with SetVisiblePolicy, similar to SetCaretPolicy.</summary>
  VISIBLE_SLOP = $01;
  VISIBLE_STRICT = $04;

  /// <summary>Set the way the display area is determined when a particular line
  /// is to be moved to by Find, FindNext, GotoLine, etc.</summary>
  SCI_SETVISIBLEPOLICY = 2394;

  /// <summary>Delete back from the current position to the start of the line.</summary>
  SCI_DELLINELEFT = 2395;

  /// <summary>Delete forwards from the current position to the end of the line.</summary>
  SCI_DELLINERIGHT = 2396;

  /// <summary>Get and Set the xOffset (ie, horizontal scroll position).</summary>
  SCI_SETXOFFSET = 2397;
  SCI_GETXOFFSET = 2398;

  /// <summary>Set the last x chosen value to be the caret x position.</summary>
  SCI_CHOOSECARETX = 2399;

  /// <summary>Set the focus to this Scintilla widget.</summary>
  SCI_GRABFOCUS = 2400;

  /// <summary>Caret policy, used by SetXCaretPolicy and SetYCaretPolicy.
  /// If CARET_SLOP is set, we can define a slop value: caretSlop.
  /// This value defines an unwanted zone (UZ) where the caret is... unwanted.
  /// This zone is defined as a number of pixels near the vertical margins,
  /// and as a number of lines near the horizontal margins.
  /// By keeping the caret away from the edges, it is seen within its context,
  /// so it is likely that the identifier that the caret is on can be completely seen,
  /// and that the current line is seen with some of the lines following it which are
  /// often dependent on that line.</summary>
  CARET_SLOP = $01;

  /// <summary>If CARET_STRICT is set, the policy is enforced... strictly.
  /// The caret is centred on the display if slop is not set,
  /// and cannot go in the UZ if slop is set.</summary>
  CARET_STRICT = $04;

  /// <summary>If CARET_JUMPS is set, the display is moved more energetically
  /// so the caret can move in the same direction longer before the policy is applied again.</summary>
  CARET_JUMPS = $10;

  /// <summary>If CARET_EVEN is not set, instead of having symmetrical UZs,
  /// the left and bottom UZs are extended up to right and top UZs respectively.
  /// This way, we favour the displaying of useful information: the begining of lines,
  /// where most code reside, and the lines after the caret, eg. the body of a function.</summary>
  CARET_EVEN = $08;

  /// <summary>Set the way the caret is kept visible when going sideways.
  /// The exclusion zone is given in pixels.</summary>
  SCI_SETXCARETPOLICY = 2402;

  /// <summary>Set the way the line the caret is on is kept visible.
  /// The exclusion zone is given in lines.</summary>
  SCI_SETYCARETPOLICY = 2403;

  /// <summary>Set printing to line wrapped (SC_WRAP_WORD) or not line wrapped (SC_WRAP_NONE).</summary>
  SCI_SETPRINTWRAPMODE = 2406;

  /// <summary>Is printing line wrapped?</summary>
  SCI_GETPRINTWRAPMODE = 2407;

  /// <summary>Set a fore colour for active hotspots.</summary>
  SCI_SETHOTSPOTACTIVEFORE = 2410;

  /// <summary>Get the fore colour for active hotspots.</summary>
  SCI_GETHOTSPOTACTIVEFORE = 2494;

  /// <summary>Set a back colour for active hotspots.</summary>
  SCI_SETHOTSPOTACTIVEBACK = 2411;

  /// <summary>Get the back colour for active hotspots.</summary>
  SCI_GETHOTSPOTACTIVEBACK = 2495;

  /// <summary>Enable / Disable underlining active hotspots.</summary>
  SCI_SETHOTSPOTACTIVEUNDERLINE = 2412;

  /// <summary>Get whether underlining for active hotspots.</summary>
  SCI_GETHOTSPOTACTIVEUNDERLINE = 2496;

  /// <summary>Limit hotspots to single line so hotspots on two lines don't merge.</summary>
  SCI_SETHOTSPOTSINGLELINE = 2421;

  /// <summary>Get the HotspotSingleLine property</summary>
  SCI_GETHOTSPOTSINGLELINE = 2497;

  /// <summary>Move caret between paragraphs (delimited by empty lines).</summary>
  SCI_PARADOWN = 2413;
  SCI_PARADOWNEXTEND = 2414;
  SCI_PARAUP = 2415;
  SCI_PARAUPEXTEND = 2416;

  /// <summary>Given a valid document position, return the previous position taking code
  /// page into account. Returns 0 if passed 0.</summary>
  SCI_POSITIONBEFORE = 2417;

  /// <summary>Given a valid document position, return the next position taking code
  /// page into account. Maximum value returned is the last position in the document.</summary>
  SCI_POSITIONAFTER = 2418;

  /// <summary>Given a valid document position, return a position that differs in a number
  /// of characters. Returned value is always between 0 and last position in document.</summary>
  SCI_POSITIONRELATIVE = 2670;

  /// <summary>Copy a range of text to the clipboard. Positions are clipped into the document.</summary>
  SCI_COPYRANGE = 2419;

  /// <summary>Copy argument text to the clipboard.</summary>
  SCI_COPYTEXT = 2420;

  SC_SEL_STREAM = 0;
  SC_SEL_RECTANGLE = 1;
  SC_SEL_LINES = 2;
  SC_SEL_THIN = 3;

  /// <summary>Set the selection mode to stream (SC_SEL_STREAM) or rectangular (SC_SEL_RECTANGLE/SC_SEL_THIN) or
  /// by lines (SC_SEL_LINES).</summary>
  SCI_SETSELECTIONMODE = 2422;

  /// <summary>Get the mode of the current selection.</summary>
  SCI_GETSELECTIONMODE = 2423;

  /// <summary>Retrieve the position of the start of the selection at the given line (INVALID_POSITION if no selection on this line).</summary>
  SCI_GETLINESELSTARTPOSITION = 2424;

  /// <summary>Retrieve the position of the end of the selection at the given line (INVALID_POSITION if no selection on this line).</summary>
  SCI_GETLINESELENDPOSITION = 2425;

  /// <summary>Move caret down one line, extending rectangular selection to new caret position.</summary>
  SCI_LINEDOWNRECTEXTEND = 2426;

  /// <summary>Move caret up one line, extending rectangular selection to new caret position.</summary>
  SCI_LINEUPRECTEXTEND = 2427;

  /// <summary>Move caret left one character, extending rectangular selection to new caret position.</summary>
  SCI_CHARLEFTRECTEXTEND = 2428;

  /// <summary>Move caret right one character, extending rectangular selection to new caret position.</summary>
  SCI_CHARRIGHTRECTEXTEND = 2429;

  /// <summary>Move caret to first position on line, extending rectangular selection to new caret position.</summary>
  SCI_HOMERECTEXTEND = 2430;

  /// <summary>Move caret to before first visible character on line.
  /// If already there move to first character on line.
  /// In either case, extend rectangular selection to new caret position.</summary>
  SCI_VCHOMERECTEXTEND = 2431;

  /// <summary>Move caret to last position on line, extending rectangular selection to new caret position.</summary>
  SCI_LINEENDRECTEXTEND = 2432;

  /// <summary>Move caret one page up, extending rectangular selection to new caret position.</summary>
  SCI_PAGEUPRECTEXTEND = 2433;

  /// <summary>Move caret one page down, extending rectangular selection to new caret position.</summary>
  SCI_PAGEDOWNRECTEXTEND = 2434;

  /// <summary>Move caret to top of page, or one page up if already at top of page.</summary>
  SCI_STUTTEREDPAGEUP = 2435;

  /// <summary>Move caret to top of page, or one page up if already at top of page, extending selection to new caret position.</summary>
  SCI_STUTTEREDPAGEUPEXTEND = 2436;

  /// <summary>Move caret to bottom of page, or one page down if already at bottom of page.</summary>
  SCI_STUTTEREDPAGEDOWN = 2437;

  /// <summary>Move caret to bottom of page, or one page down if already at bottom of page, extending selection to new caret position.</summary>
  SCI_STUTTEREDPAGEDOWNEXTEND = 2438;

  /// <summary>Move caret left one word, position cursor at end of word.</summary>
  SCI_WORDLEFTEND = 2439;

  /// <summary>Move caret left one word, position cursor at end of word, extending selection to new caret position.</summary>
  SCI_WORDLEFTENDEXTEND = 2440;

  /// <summary>Move caret right one word, position cursor at end of word.</summary>
  SCI_WORDRIGHTEND = 2441;

  /// <summary>Move caret right one word, position cursor at end of word, extending selection to new caret position.</summary>
  SCI_WORDRIGHTENDEXTEND = 2442;

  /// <summary>Set the set of characters making up whitespace for when moving or selecting by word.
  /// Should be called after SetWordChars.</summary>
  SCI_SETWHITESPACECHARS = 2443;

  /// <summary>Get the set of characters making up whitespace for when moving or selecting by word.</summary>
  SCI_GETWHITESPACECHARS = 2647;

  /// <summary>Set the set of characters making up punctuation characters
  /// Should be called after SetWordChars.</summary>
  SCI_SETPUNCTUATIONCHARS = 2648;

  /// <summary>Get the set of characters making up punctuation characters</summary>
  SCI_GETPUNCTUATIONCHARS = 2649;

  /// <summary>Reset the set of characters for whitespace and word characters to the defaults.</summary>
  SCI_SETCHARSDEFAULT = 2444;

  /// <summary>Get currently selected item position in the auto-completion list</summary>
  SCI_AUTOCGETCURRENT = 2445;

  /// <summary>Get currently selected item text in the auto-completion list
  /// Returns the length of the item text</summary>
  SCI_AUTOCGETCURRENTTEXT = 2610;

  SC_CASEINSENSITIVEBEHAVIOUR_RESPECTCASE = 0;
  SC_CASEINSENSITIVEBEHAVIOUR_IGNORECASE = 1;

  /// <summary>Set auto-completion case insensitive behaviour to either prefer case-sensitive matches or have no preference.</summary>
  SCI_AUTOCSETCASEINSENSITIVEBEHAVIOUR = 2634;

  /// <summary>Get auto-completion case insensitive behaviour.</summary>
  SCI_AUTOCGETCASEINSENSITIVEBEHAVIOUR = 2635;

  SC_ORDER_PRESORTED = 0;
  SC_ORDER_PERFORMSORT = 1;
  SC_ORDER_CUSTOM = 2;

  /// <summary>Set the way autocompletion lists are ordered.</summary>
  SCI_AUTOCSETORDER = 2660;

  /// <summary>Get the way autocompletion lists are ordered.</summary>
  SCI_AUTOCGETORDER = 2661;

  /// <summary>Enlarge the document to a particular size of text bytes.</summary>
  SCI_ALLOCATE = 2446;

  /// <summary>Returns the target converted to UTF8.
  /// Return the length in bytes.</summary>
  SCI_TARGETASUTF8 = 2447;

  /// <summary>Set the length of the utf8 argument for calling EncodedFromUTF8.
  /// Set to -1 and the string will be measured to the first nul.</summary>
  SCI_SETLENGTHFORENCODE = 2448;

  /// <summary>Translates a UTF8 string into the document encoding.
  /// Return the length of the result in bytes.
  /// On error return 0.</summary>
  SCI_ENCODEDFROMUTF8 = 2449;

  /// <summary>Find the position of a column on a line taking into account tabs and
  /// multi-byte characters. If beyond end of line, return line end position.</summary>
  SCI_FINDCOLUMN = 2456;

  /// <summary>Can the caret preferred x position only be changed by explicit movement commands?</summary>
  SCI_GETCARETSTICKY = 2457;

  /// <summary>Stop the caret preferred x position changing when the user types.</summary>
  SCI_SETCARETSTICKY = 2458;

  SC_CARETSTICKY_OFF = 0;
  SC_CARETSTICKY_ON = 1;
  SC_CARETSTICKY_WHITESPACE = 2;

  /// <summary>Switch between sticky and non-sticky: meant to be bound to a key.</summary>
  SCI_TOGGLECARETSTICKY = 2459;

  /// <summary>Enable/Disable convert-on-paste for line endings</summary>
  SCI_SETPASTECONVERTENDINGS = 2467;

  /// <summary>Get convert-on-paste setting</summary>
  SCI_GETPASTECONVERTENDINGS = 2468;

  /// <summary>Duplicate the selection. If selection empty duplicate the line containing the caret.</summary>
  SCI_SELECTIONDUPLICATE = 2469;

  SC_ALPHA_TRANSPARENT = 0;
  SC_ALPHA_OPAQUE = 255;
  SC_ALPHA_NOALPHA = 256;

  /// <summary>Set background alpha of the caret line.</summary>
  SCI_SETCARETLINEBACKALPHA = 2470;

  /// <summary>Get the background alpha of the caret line.</summary>
  SCI_GETCARETLINEBACKALPHA = 2471;

  CARETSTYLE_INVISIBLE = 0;
  CARETSTYLE_LINE = 1;
  CARETSTYLE_BLOCK = 2;

  /// <summary>Set the style of the caret to be drawn.</summary>
  SCI_SETCARETSTYLE = 2512;

  /// <summary>Returns the current style of the caret.</summary>
  SCI_GETCARETSTYLE = 2513;

  /// <summary>Set the indicator used for IndicatorFillRange and IndicatorClearRange</summary>
  SCI_SETINDICATORCURRENT = 2500;

  /// <summary>Get the current indicator</summary>
  SCI_GETINDICATORCURRENT = 2501;

  /// <summary>Set the value used for IndicatorFillRange</summary>
  SCI_SETINDICATORVALUE = 2502;

  /// <summary>Get the current indicator value</summary>
  SCI_GETINDICATORVALUE = 2503;

  /// <summary>Turn a indicator on over a range.</summary>
  SCI_INDICATORFILLRANGE = 2504;

  /// <summary>Turn a indicator off over a range.</summary>
  SCI_INDICATORCLEARRANGE = 2505;

  /// <summary>Are any indicators present at position?</summary>
  SCI_INDICATORALLONFOR = 2506;

  /// <summary>What value does a particular indicator have at at a position?</summary>
  SCI_INDICATORVALUEAT = 2507;

  /// <summary>Where does a particular indicator start?</summary>
  SCI_INDICATORSTART = 2508;

  /// <summary>Where does a particular indicator end?</summary>
  SCI_INDICATOREND = 2509;

  /// <summary>Set number of entries in position cache</summary>
  SCI_SETPOSITIONCACHE = 2514;

  /// <summary>How many entries are allocated to the position cache?</summary>
  SCI_GETPOSITIONCACHE = 2515;

  /// <summary>Copy the selection, if selection empty copy the line with the caret</summary>
  SCI_COPYALLOWLINE = 2519;

  /// <summary>Compact the document buffer and return a read-only pointer to the
  /// characters in the document.</summary>
  SCI_GETCHARACTERPOINTER = 2520;

  /// <summary>Return a read-only pointer to a range of characters in the document.
  /// May move the gap so that the range is contiguous, but will only move up
  /// to rangeLength bytes.</summary>
  SCI_GETRANGEPOINTER = 2643;

  /// <summary>Return a position which, to avoid performance costs, should not be within
  /// the range of a call to GetRangePointer.</summary>
  SCI_GETGAPPOSITION = 2644;

  /// <summary>Always interpret keyboard input as Unicode</summary>
  SCI_SETKEYSUNICODE = 2521;

  /// <summary>Are keys always interpreted as Unicode?</summary>
  SCI_GETKEYSUNICODE = 2522;

  /// <summary>Set the alpha fill colour of the given indicator.</summary>
  SCI_INDICSETALPHA = 2523;

  /// <summary>Get the alpha fill colour of the given indicator.</summary>
  SCI_INDICGETALPHA = 2524;

  /// <summary>Set the alpha outline colour of the given indicator.</summary>
  SCI_INDICSETOUTLINEALPHA = 2558;

  /// <summary>Get the alpha outline colour of the given indicator.</summary>
  SCI_INDICGETOUTLINEALPHA = 2559;

  /// <summary>Set extra ascent for each line</summary>
  SCI_SETEXTRAASCENT = 2525;

  /// <summary>Get extra ascent for each line</summary>
  SCI_GETEXTRAASCENT = 2526;

  /// <summary>Set extra descent for each line</summary>
  SCI_SETEXTRADESCENT = 2527;

  /// <summary>Get extra descent for each line</summary>
  SCI_GETEXTRADESCENT = 2528;

  /// <summary>Which symbol was defined for markerNumber with MarkerDefine</summary>
  SCI_MARKERSYMBOLDEFINED = 2529;

  /// <summary>Set the text in the text margin for a line</summary>
  SCI_MARGINSETTEXT = 2530;

  /// <summary>Get the text in the text margin for a line</summary>
  SCI_MARGINGETTEXT = 2531;

  /// <summary>Set the style number for the text margin for a line</summary>
  SCI_MARGINSETSTYLE = 2532;

  /// <summary>Get the style number for the text margin for a line</summary>
  SCI_MARGINGETSTYLE = 2533;

  /// <summary>Set the style in the text margin for a line</summary>
  SCI_MARGINSETSTYLES = 2534;

  /// <summary>Get the styles in the text margin for a line</summary>
  SCI_MARGINGETSTYLES = 2535;

  /// <summary>Clear the margin text on all lines</summary>
  SCI_MARGINTEXTCLEARALL = 2536;

  /// <summary>Get the start of the range of style numbers used for margin text</summary>
  SCI_MARGINSETSTYLEOFFSET = 2537;

  /// <summary>Get the start of the range of style numbers used for margin text</summary>
  SCI_MARGINGETSTYLEOFFSET = 2538;

  SC_MARGINOPTION_NONE = 0;
  SC_MARGINOPTION_SUBLINESELECT = 1;

  /// <summary>Set the margin options.</summary>
  SCI_SETMARGINOPTIONS = 2539;

  /// <summary>Get the margin options.</summary>
  SCI_GETMARGINOPTIONS = 2557;

  /// <summary>Set the annotation text for a line</summary>
  SCI_ANNOTATIONSETTEXT = 2540;

  /// <summary>Get the annotation text for a line</summary>
  SCI_ANNOTATIONGETTEXT = 2541;

  /// <summary>Set the style number for the annotations for a line</summary>
  SCI_ANNOTATIONSETSTYLE = 2542;

  /// <summary>Get the style number for the annotations for a line</summary>
  SCI_ANNOTATIONGETSTYLE = 2543;

  /// <summary>Set the annotation styles for a line</summary>
  SCI_ANNOTATIONSETSTYLES = 2544;

  /// <summary>Get the annotation styles for a line</summary>
  SCI_ANNOTATIONGETSTYLES = 2545;

  /// <summary>Get the number of annotation lines for a line</summary>
  SCI_ANNOTATIONGETLINES = 2546;

  /// <summary>Clear the annotations from all lines</summary>
  SCI_ANNOTATIONCLEARALL = 2547;

  ANNOTATION_HIDDEN = 0;
  ANNOTATION_STANDARD = 1;
  ANNOTATION_BOXED = 2;

  /// <summary>Set the visibility for the annotations for a view</summary>
  SCI_ANNOTATIONSETVISIBLE = 2548;

  /// <summary>Get the visibility for the annotations for a view</summary>
  SCI_ANNOTATIONGETVISIBLE = 2549;

  /// <summary>Get the start of the range of style numbers used for annotations</summary>
  SCI_ANNOTATIONSETSTYLEOFFSET = 2550;

  /// <summary>Get the start of the range of style numbers used for annotations</summary>
  SCI_ANNOTATIONGETSTYLEOFFSET = 2551;

  /// <summary>Release all extended (&gt;255) style numbers</summary>
  SCI_RELEASEALLEXTENDEDSTYLES = 2552;

  /// <summary>Allocate some extended (&gt;255) style numbers and return the start of the range</summary>
  SCI_ALLOCATEEXTENDEDSTYLES = 2553;

  UNDO_MAY_COALESCE = 1;

  /// <summary>Add a container action to the undo stack</summary>
  SCI_ADDUNDOACTION = 2560;

  /// <summary>Find the position of a character from a point within the window.</summary>
  SCI_CHARPOSITIONFROMPOINT = 2561;

  /// <summary>Find the position of a character from a point within the window.
  /// Return INVALID_POSITION if not close to text.</summary>
  SCI_CHARPOSITIONFROMPOINTCLOSE = 2562;

  /// <summary>Set whether switching to rectangular mode while selecting with the mouse is allowed.</summary>
  SCI_SETMOUSESELECTIONRECTANGULARSWITCH = 2668;

  /// <summary>Whether switching to rectangular mode while selecting with the mouse is allowed.</summary>
  SCI_GETMOUSESELECTIONRECTANGULARSWITCH = 2669;

  /// <summary>Set whether multiple selections can be made</summary>
  SCI_SETMULTIPLESELECTION = 2563;

  /// <summary>Whether multiple selections can be made</summary>
  SCI_GETMULTIPLESELECTION = 2564;

  /// <summary>Set whether typing can be performed into multiple selections</summary>
  SCI_SETADDITIONALSELECTIONTYPING = 2565;

  /// <summary>Whether typing can be performed into multiple selections</summary>
  SCI_GETADDITIONALSELECTIONTYPING = 2566;

  /// <summary>Set whether additional carets will blink</summary>
  SCI_SETADDITIONALCARETSBLINK = 2567;

  /// <summary>Whether additional carets will blink</summary>
  SCI_GETADDITIONALCARETSBLINK = 2568;

  /// <summary>Set whether additional carets are visible</summary>
  SCI_SETADDITIONALCARETSVISIBLE = 2608;

  /// <summary>Whether additional carets are visible</summary>
  SCI_GETADDITIONALCARETSVISIBLE = 2609;

  /// <summary>How many selections are there?</summary>
  SCI_GETSELECTIONS = 2570;

  /// <summary>Is every selected range empty?</summary>
  SCI_GETSELECTIONEMPTY = 2650;

  /// <summary>Clear selections to a single empty stream selection</summary>
  SCI_CLEARSELECTIONS = 2571;

  /// <summary>Set a simple selection</summary>
  SCI_SETSELECTION = 2572;

  /// <summary>Add a selection</summary>
  SCI_ADDSELECTION = 2573;

  /// <summary>Drop one selection</summary>
  SCI_DROPSELECTIONN = 2671;

  /// <summary>Set the main selection</summary>
  SCI_SETMAINSELECTION = 2574;

  /// <summary>Which selection is the main selection</summary>
  SCI_GETMAINSELECTION = 2575;

  SCI_SETSELECTIONNCARET = 2576;
  SCI_GETSELECTIONNCARET = 2577;
  SCI_SETSELECTIONNANCHOR = 2578;
  SCI_GETSELECTIONNANCHOR = 2579;
  SCI_SETSELECTIONNCARETVIRTUALSPACE = 2580;
  SCI_GETSELECTIONNCARETVIRTUALSPACE = 2581;
  SCI_SETSELECTIONNANCHORVIRTUALSPACE = 2582;
  SCI_GETSELECTIONNANCHORVIRTUALSPACE = 2583;

  /// <summary>Sets the position that starts the selection - this becomes the anchor.</summary>
  SCI_SETSELECTIONNSTART = 2584;

  /// <summary>Returns the position at the start of the selection.</summary>
  SCI_GETSELECTIONNSTART = 2585;

  /// <summary>Sets the position that ends the selection - this becomes the currentPosition.</summary>
  SCI_SETSELECTIONNEND = 2586;

  /// <summary>Returns the position at the end of the selection.</summary>
  SCI_GETSELECTIONNEND = 2587;

  SCI_SETRECTANGULARSELECTIONCARET = 2588;
  SCI_GETRECTANGULARSELECTIONCARET = 2589;
  SCI_SETRECTANGULARSELECTIONANCHOR = 2590;
  SCI_GETRECTANGULARSELECTIONANCHOR = 2591;
  SCI_SETRECTANGULARSELECTIONCARETVIRTUALSPACE = 2592;
  SCI_GETRECTANGULARSELECTIONCARETVIRTUALSPACE = 2593;
  SCI_SETRECTANGULARSELECTIONANCHORVIRTUALSPACE = 2594;
  SCI_GETRECTANGULARSELECTIONANCHORVIRTUALSPACE = 2595;

  SCVS_NONE = 0;
  SCVS_RECTANGULARSELECTION = 1;
  SCVS_USERACCESSIBLE = 2;

  SCI_SETVIRTUALSPACEOPTIONS = 2596;
  SCI_GETVIRTUALSPACEOPTIONS = 2597;

  SCI_SETRECTANGULARSELECTIONMODIFIER = 2598;

  /// <summary>Get the modifier key used for rectangular selection.</summary>
  SCI_GETRECTANGULARSELECTIONMODIFIER = 2599;

  /// <summary>Set the foreground colour of additional selections.
  /// Must have previously called SetSelFore with non-zero first argument for this to have an effect.</summary>
  SCI_SETADDITIONALSELFORE = 2600;

  /// <summary>Set the background colour of additional selections.
  /// Must have previously called SetSelBack with non-zero first argument for this to have an effect.</summary>
  SCI_SETADDITIONALSELBACK = 2601;

  /// <summary>Set the alpha of the selection.</summary>
  SCI_SETADDITIONALSELALPHA = 2602;

  /// <summary>Get the alpha of the selection.</summary>
  SCI_GETADDITIONALSELALPHA = 2603;

  /// <summary>Set the foreground colour of additional carets.</summary>
  SCI_SETADDITIONALCARETFORE = 2604;

  /// <summary>Get the foreground colour of additional carets.</summary>
  SCI_GETADDITIONALCARETFORE = 2605;

  /// <summary>Set the main selection to the next selection.</summary>
  SCI_ROTATESELECTION = 2606;

  /// <summary>Swap that caret and anchor of the main selection.</summary>
  SCI_SWAPMAINANCHORCARET = 2607;

  /// <summary>Indicate that the internal state of a lexer has changed over a range and therefore
  /// there may be a need to redraw.</summary>
  SCI_CHANGELEXERSTATE = 2617;

  /// <summary>Find the next line at or after lineStart that is a contracted fold header line.
  /// Return -1 when no more lines.</summary>
  SCI_CONTRACTEDFOLDNEXT = 2618;

  /// <summary>Centre current line in window.</summary>
  SCI_VERTICALCENTRECARET = 2619;

  /// <summary>Move the selected lines up one line, shifting the line above after the selection</summary>
  SCI_MOVESELECTEDLINESUP = 2620;

  /// <summary>Move the selected lines down one line, shifting the line below before the selection</summary>
  SCI_MOVESELECTEDLINESDOWN = 2621;

  /// <summary>Set the identifier reported as idFrom in notification messages.</summary>
  SCI_SETIDENTIFIER = 2622;

  /// <summary>Get the identifier.</summary>
  SCI_GETIDENTIFIER = 2623;

  /// <summary>Set the width for future RGBA image data.</summary>
  SCI_RGBAIMAGESETWIDTH = 2624;

  /// <summary>Set the height for future RGBA image data.</summary>
  SCI_RGBAIMAGESETHEIGHT = 2625;

  /// <summary>Set the scale factor in percent for future RGBA image data.</summary>
  SCI_RGBAIMAGESETSCALE = 2651;

  /// <summary>Define a marker from RGBA data.
  /// It has the width and height from RGBAImageSetWidth/Height</summary>
  SCI_MARKERDEFINERGBAIMAGE = 2626;

  /// <summary>Register an RGBA image for use in autocompletion lists.
  /// It has the width and height from RGBAImageSetWidth/Height</summary>
  SCI_REGISTERRGBAIMAGE = 2627;

  /// <summary>Scroll to start of document.</summary>
  SCI_SCROLLTOSTART = 2628;

  /// <summary>Scroll to end of document.</summary>
  SCI_SCROLLTOEND = 2629;

  SC_TECHNOLOGY_DEFAULT = 0;
  SC_TECHNOLOGY_DIRECTWRITE = 1;

  /// <summary>Set the technology used.</summary>
  SCI_SETTECHNOLOGY = 2630;

  /// <summary>Get the tech.</summary>
  SCI_GETTECHNOLOGY = 2631;

  /// <summary>Create an ILoader*.</summary>
  SCI_CREATELOADER = 2632;

  /// <summary>On OS X, show a find indicator.</summary>
  SCI_FINDINDICATORSHOW = 2640;

  /// <summary>On OS X, flash a find indicator, then fade out.</summary>
  SCI_FINDINDICATORFLASH = 2641;

  /// <summary>On OS X, hide the find indicator.</summary>
  SCI_FINDINDICATORHIDE = 2642;

  /// <summary>Move caret to before first visible character on display line.
  /// If already there move to first character on display line.</summary>
  SCI_VCHOMEDISPLAY = 2652;

  /// <summary>Like VCHomeDisplay but extending selection to new caret position.</summary>
  SCI_VCHOMEDISPLAYEXTEND = 2653;

  /// <summary>Is the caret line always visible?</summary>
  SCI_GETCARETLINEVISIBLEALWAYS = 2654;

  /// <summary>Sets the caret line to always visible.</summary>
  SCI_SETCARETLINEVISIBLEALWAYS = 2655;

  /// <summary>Line end types which may be used in addition to LF, CR, and CRLF
  /// SC_LINE_END_TYPE_UNICODE includes U+2028 Line Separator,
  /// U+2029 Paragraph Separator, and U+0085 Next Line</summary>
  SC_LINE_END_TYPE_DEFAULT = 0;
  SC_LINE_END_TYPE_UNICODE = 1;

  /// <summary>Set the line end types that the application wants to use. May not be used if incompatible with lexer or encoding.</summary>
  SCI_SETLINEENDTYPESALLOWED = 2656;

  /// <summary>Get the line end types currently allowed.</summary>
  SCI_GETLINEENDTYPESALLOWED = 2657;

  /// <summary>Get the line end types currently recognised. May be a subset of the allowed types due to lexer limitation.</summary>
  SCI_GETLINEENDTYPESACTIVE = 2658;

  /// <summary>Set the way a character is drawn.</summary>
  SCI_SETREPRESENTATION = 2665;

  /// <summary>Set the way a character is drawn.</summary>
  SCI_GETREPRESENTATION = 2666;

  /// <summary>Remove a character representation.</summary>
  SCI_CLEARREPRESENTATION = 2667;

  /// <summary>Start notifying the container of all key presses and commands.</summary>
  SCI_STARTRECORD = 3001;

  /// <summary>Stop notifying the container of all key presses and commands.</summary>
  SCI_STOPRECORD = 3002;

  /// <summary>Set the lexing language of the document.</summary>
  SCI_SETLEXER = 4001;

  /// <summary>Retrieve the lexing language of the document.</summary>
  SCI_GETLEXER = 4002;

  /// <summary>Colourise a segment of the document using the current lexing language.</summary>
  SCI_COLOURISE = 4003;

  /// <summary>Set up a value that may be used by a lexer for some optional feature.</summary>
  SCI_SETPROPERTY = 4004;

  /// <summary>Maximum value of keywordSet parameter of SetKeyWords.</summary>
  KEYWORDSET_MAX = 8;

  /// <summary>Set up the key words used by the lexer.</summary>
  SCI_SETKEYWORDS = 4005;

  /// <summary>Set the lexing language of the document based on string name.</summary>
  SCI_SETLEXERLANGUAGE = 4006;

  /// <summary>Load a lexer library (dll / so).</summary>
  SCI_LOADLEXERLIBRARY = 4007;

  /// <summary>Retrieve a "property" value previously set with SetProperty.</summary>
  SCI_GETPROPERTY = 4008;

  /// <summary>Retrieve a "property" value previously set with SetProperty,
  /// with "$()" variable replacement on returned buffer.</summary>
  SCI_GETPROPERTYEXPANDED = 4009;

  /// <summary>Retrieve a "property" value previously set with SetProperty,
  /// interpreted as an int AFTER any "$()" variable replacement.</summary>
  SCI_GETPROPERTYINT = 4010;

  /// <summary>Retrieve the number of bits the current lexer needs for styling.</summary>
  SCI_GETSTYLEBITSNEEDED = 4011;

  /// <summary>Retrieve the name of the lexer.
  /// Return the length of the text.</summary>
  SCI_GETLEXERLANGUAGE = 4012;

  /// <summary>For private communication between an application and a known lexer.</summary>
  SCI_PRIVATELEXERCALL = 4013;

  /// <summary>Retrieve a '\n' separated list of properties understood by the current lexer.</summary>
  SCI_PROPERTYNAMES = 4014;

  SC_TYPE_BOOLEAN = 0;
  SC_TYPE_INTEGER = 1;
  SC_TYPE_STRING = 2;

  /// <summary>Retrieve the type of a property.</summary>
  SCI_PROPERTYTYPE = 4015;

  /// <summary>Describe a property.</summary>
  SCI_DESCRIBEPROPERTY = 4016;

  /// <summary>Retrieve a '\n' separated list of descriptions of the keyword sets understood by the current lexer.</summary>
  SCI_DESCRIBEKEYWORDSETS = 4017;

  /// <summary>Bit set of LineEndType enumertion for which line ends beyond the standard
  /// LF, CR, and CRLF are supported by the lexer.</summary>
  SCI_GETLINEENDTYPESSUPPORTED = 4018;

  /// <summary>Allocate a set of sub styles for a particular base style, returning start of range</summary>
  SCI_ALLOCATESUBSTYLES = 4020;

  /// <summary>The starting style number for the sub styles associated with a base style</summary>
  SCI_GETSUBSTYLESSTART = 4021;

  /// <summary>The number of sub styles associated with a base style</summary>
  SCI_GETSUBSTYLESLENGTH = 4022;

  /// <summary>For a sub style, return the base style, else return the argument.</summary>
  SCI_GETSTYLEFROMSUBSTYLE = 4027;

  /// <summary>For a secondary style, return the primary style, else return the argument.</summary>
  SCI_GETPRIMARYSTYLEFROMSTYLE = 4028;

  /// <summary>Free allocated sub styles</summary>
  SCI_FREESUBSTYLES = 4023;

  /// <summary>Set the identifiers that are shown in a particular style</summary>
  SCI_SETIDENTIFIERS = 4024;

  /// <summary>Where styles are duplicated by a feature such as active/inactive code
  /// return the distance between the two types.</summary>
  SCI_DISTANCETOSECONDARYSTYLES = 4025;

  /// <summary>Get the set of base styles that can be extended with sub styles</summary>
  SCI_GETSUBSTYLEBASES = 4026;

  /// <summary>Notifications
  /// Type of modification and the action which caused the modification.
  /// These are defined as a bit mask to make it easy to specify which notifications are wanted.
  /// One bit is set from each of SC_MOD_* and SC_PERFORMED_*.</summary>
  SC_MOD_INSERTTEXT = $1;
  SC_MOD_DELETETEXT = $2;
  SC_MOD_CHANGESTYLE = $4;
  SC_MOD_CHANGEFOLD = $8;
  SC_PERFORMED_USER = $10;
  SC_PERFORMED_UNDO = $20;
  SC_PERFORMED_REDO = $40;
  SC_MULTISTEPUNDOREDO = $80;
  SC_LASTSTEPINUNDOREDO = $100;
  SC_MOD_CHANGEMARKER = $200;
  SC_MOD_BEFOREINSERT = $400;
  SC_MOD_BEFOREDELETE = $800;
  SC_MULTILINEUNDOREDO = $1000;
  SC_STARTACTION = $2000;
  SC_MOD_CHANGEINDICATOR = $4000;
  SC_MOD_CHANGELINESTATE = $8000;
  SC_MOD_CHANGEMARGIN = $10000;
  SC_MOD_CHANGEANNOTATION = $20000;
  SC_MOD_CONTAINER = $40000;
  SC_MOD_LEXERSTATE = $80000;
  SC_MOD_INSERTCHECK = $100000;
  SC_MODEVENTMASKALL = $1FFFFF;

  SC_UPDATE_CONTENT = $1;
  SC_UPDATE_SELECTION = $2;
  SC_UPDATE_V_SCROLL = $4;
  SC_UPDATE_H_SCROLL = $8;

  /// <summary>For compatibility, these go through the COMMAND notification rather than NOTIFY
  /// and should have had exactly the same values as the EN_* constants.
  /// Unfortunately the SETFOCUS and KILLFOCUS are flipped over from EN_*
  /// As clients depend on these constants, this will not be changed.</summary>
  SCEN_CHANGE = 768;
  SCEN_SETFOCUS = 512;
  SCEN_KILLFOCUS = 256;

  SCK_DOWN = 300;
  SCK_UP = 301;
  SCK_LEFT = 302;
  SCK_RIGHT = 303;
  SCK_HOME = 304;
  SCK_END = 305;
  SCK_PRIOR = 306;
  SCK_NEXT = 307;
  SCK_DELETE = 308;
  SCK_INSERT = 309;
  SCK_ESCAPE = 7;
  SCK_BACK = 8;
  SCK_TAB = 9;
  SCK_RETURN = 13;
  SCK_ADD = 310;
  SCK_SUBTRACT = 311;
  SCK_DIVIDE = 312;
  SCK_WIN = 313;
  SCK_RWIN = 314;
  SCK_MENU = 315;

  SCMOD_NORM = 0;
  SCMOD_SHIFT = 1;
  SCMOD_CTRL = 2;
  SCMOD_ALT = 4;
  SCMOD_SUPER = 8;
  SCMOD_META = 16;

  /// <summary>For SciLexer.h</summary>
  SCLEX_CONTAINER = 0;
  SCLEX_NULL = 1;
  SCLEX_PYTHON = 2;
  SCLEX_CPP = 3;
  SCLEX_HTML = 4;
  SCLEX_XML = 5;
  SCLEX_PERL = 6;
  SCLEX_SQL = 7;
  SCLEX_VB = 8;
  SCLEX_PROPERTIES = 9;
  SCLEX_ERRORLIST = 10;
  SCLEX_MAKEFILE = 11;
  SCLEX_BATCH = 12;
  SCLEX_XCODE = 13;
  SCLEX_LATEX = 14;
  SCLEX_LUA = 15;
  SCLEX_DIFF = 16;
  SCLEX_CONF = 17;
  SCLEX_PASCAL = 18;
  SCLEX_AVE = 19;
  SCLEX_ADA = 20;
  SCLEX_LISP = 21;
  SCLEX_RUBY = 22;
  SCLEX_EIFFEL = 23;
  SCLEX_EIFFELKW = 24;
  SCLEX_TCL = 25;
  SCLEX_NNCRONTAB = 26;
  SCLEX_BULLANT = 27;
  SCLEX_VBSCRIPT = 28;
  SCLEX_BAAN = 31;
  SCLEX_MATLAB = 32;
  SCLEX_SCRIPTOL = 33;
  SCLEX_ASM = 34;
  SCLEX_CPPNOCASE = 35;
  SCLEX_FORTRAN = 36;
  SCLEX_F77 = 37;
  SCLEX_CSS = 38;
  SCLEX_POV = 39;
  SCLEX_LOUT = 40;
  SCLEX_ESCRIPT = 41;
  SCLEX_PS = 42;
  SCLEX_NSIS = 43;
  SCLEX_MMIXAL = 44;
  SCLEX_CLW = 45;
  SCLEX_CLWNOCASE = 46;
  SCLEX_LOT = 47;
  SCLEX_YAML = 48;
  SCLEX_TEX = 49;
  SCLEX_METAPOST = 50;
  SCLEX_POWERBASIC = 51;
  SCLEX_FORTH = 52;
  SCLEX_ERLANG = 53;
  SCLEX_OCTAVE = 54;
  SCLEX_MSSQL = 55;
  SCLEX_VERILOG = 56;
  SCLEX_KIX = 57;
  SCLEX_GUI4CLI = 58;
  SCLEX_SPECMAN = 59;
  SCLEX_AU3 = 60;
  SCLEX_APDL = 61;
  SCLEX_BASH = 62;
  SCLEX_ASN1 = 63;
  SCLEX_VHDL = 64;
  SCLEX_CAML = 65;
  SCLEX_BLITZBASIC = 66;
  SCLEX_PUREBASIC = 67;
  SCLEX_HASKELL = 68;
  SCLEX_PHPSCRIPT = 69;
  SCLEX_TADS3 = 70;
  SCLEX_REBOL = 71;
  SCLEX_SMALLTALK = 72;
  SCLEX_FLAGSHIP = 73;
  SCLEX_CSOUND = 74;
  SCLEX_FREEBASIC = 75;
  SCLEX_INNOSETUP = 76;
  SCLEX_OPAL = 77;
  SCLEX_SPICE = 78;
  SCLEX_D = 79;
  SCLEX_CMAKE = 80;
  SCLEX_GAP = 81;
  SCLEX_PLM = 82;
  SCLEX_PROGRESS = 83;
  SCLEX_ABAQUS = 84;
  SCLEX_ASYMPTOTE = 85;
  SCLEX_R = 86;
  SCLEX_MAGIK = 87;
  SCLEX_POWERSHELL = 88;
  SCLEX_MYSQL = 89;
  SCLEX_PO = 90;
  SCLEX_TAL = 91;
  SCLEX_COBOL = 92;
  SCLEX_TACL = 93;
  SCLEX_SORCUS = 94;
  SCLEX_POWERPRO = 95;
  SCLEX_NIMROD = 96;
  SCLEX_SML = 97;
  SCLEX_MARKDOWN = 98;
  SCLEX_TXT2TAGS = 99;
  SCLEX_A68K = 100;
  SCLEX_MODULA = 101;
  SCLEX_COFFEESCRIPT = 102;
  SCLEX_TCMD = 103;
  SCLEX_AVS = 104;
  SCLEX_ECL = 105;
  SCLEX_OSCRIPT = 106;
  SCLEX_VISUALPROLOG = 107;
  SCLEX_LITERATEHASKELL = 108;
  SCLEX_STTXT = 109;
  SCLEX_KVIRC = 110;
  SCLEX_RUST = 111;
  SCLEX_DMAP = 112;
  SCLEX_AS = 113;
  SCLEX_DMIS = 114;

  /// <summary>When a lexer specifies its language as SCLEX_AUTOMATIC it receives a
  /// value assigned in sequence from SCLEX_AUTOMATIC+1.</summary>
  SCLEX_AUTOMATIC = 1000;

  /// <summary>Lexical states for SCLEX_PYTHON</summary>
  SCE_P_DEFAULT = 0;
  SCE_P_COMMENTLINE = 1;
  SCE_P_NUMBER = 2;
  SCE_P_STRING = 3;
  SCE_P_CHARACTER = 4;
  SCE_P_WORD = 5;
  SCE_P_TRIPLE = 6;
  SCE_P_TRIPLEDOUBLE = 7;
  SCE_P_CLASSNAME = 8;
  SCE_P_DEFNAME = 9;
  SCE_P_OPERATOR = 10;
  SCE_P_IDENTIFIER = 11;
  SCE_P_COMMENTBLOCK = 12;
  SCE_P_STRINGEOL = 13;
  SCE_P_WORD2 = 14;
  SCE_P_DECORATOR = 15;

  /// <summary>Lexical states for SCLEX_CPP</summary>
  SCE_C_DEFAULT = 0;
  SCE_C_COMMENT = 1;
  SCE_C_COMMENTLINE = 2;
  SCE_C_COMMENTDOC = 3;
  SCE_C_NUMBER = 4;
  SCE_C_WORD = 5;
  SCE_C_STRING = 6;
  SCE_C_CHARACTER = 7;
  SCE_C_UUID = 8;
  SCE_C_PREPROCESSOR = 9;
  SCE_C_OPERATOR = 10;
  SCE_C_IDENTIFIER = 11;
  SCE_C_STRINGEOL = 12;
  SCE_C_VERBATIM = 13;
  SCE_C_REGEX = 14;
  SCE_C_COMMENTLINEDOC = 15;
  SCE_C_WORD2 = 16;
  SCE_C_COMMENTDOCKEYWORD = 17;
  SCE_C_COMMENTDOCKEYWORDERROR = 18;
  SCE_C_GLOBALCLASS = 19;
  SCE_C_STRINGRAW = 20;
  SCE_C_TRIPLEVERBATIM = 21;
  SCE_C_HASHQUOTEDSTRING = 22;
  SCE_C_PREPROCESSORCOMMENT = 23;
  SCE_C_PREPROCESSORCOMMENTDOC = 24;
  SCE_C_USERLITERAL = 25;
  SCE_C_TASKMARKER = 26;
  SCE_C_ESCAPESEQUENCE = 27;

  /// <summary>Lexical states for SCLEX_D</summary>
  SCE_D_DEFAULT = 0;
  SCE_D_COMMENT = 1;
  SCE_D_COMMENTLINE = 2;
  SCE_D_COMMENTDOC = 3;
  SCE_D_COMMENTNESTED = 4;
  SCE_D_NUMBER = 5;
  SCE_D_WORD = 6;
  SCE_D_WORD2 = 7;
  SCE_D_WORD3 = 8;
  SCE_D_TYPEDEF = 9;
  SCE_D_STRING = 10;
  SCE_D_STRINGEOL = 11;
  SCE_D_CHARACTER = 12;
  SCE_D_OPERATOR = 13;
  SCE_D_IDENTIFIER = 14;
  SCE_D_COMMENTLINEDOC = 15;
  SCE_D_COMMENTDOCKEYWORD = 16;
  SCE_D_COMMENTDOCKEYWORDERROR = 17;
  SCE_D_STRINGB = 18;
  SCE_D_STRINGR = 19;
  SCE_D_WORD5 = 20;
  SCE_D_WORD6 = 21;
  SCE_D_WORD7 = 22;

  /// <summary>Lexical states for SCLEX_TCL</summary>
  SCE_TCL_DEFAULT = 0;
  SCE_TCL_COMMENT = 1;
  SCE_TCL_COMMENTLINE = 2;
  SCE_TCL_NUMBER = 3;
  SCE_TCL_WORD_IN_QUOTE = 4;
  SCE_TCL_IN_QUOTE = 5;
  SCE_TCL_OPERATOR = 6;
  SCE_TCL_IDENTIFIER = 7;
  SCE_TCL_SUBSTITUTION = 8;
  SCE_TCL_SUB_BRACE = 9;
  SCE_TCL_MODIFIER = 10;
  SCE_TCL_EXPAND = 11;
  SCE_TCL_WORD = 12;
  SCE_TCL_WORD2 = 13;
  SCE_TCL_WORD3 = 14;
  SCE_TCL_WORD4 = 15;
  SCE_TCL_WORD5 = 16;
  SCE_TCL_WORD6 = 17;
  SCE_TCL_WORD7 = 18;
  SCE_TCL_WORD8 = 19;
  SCE_TCL_COMMENT_BOX = 20;
  SCE_TCL_BLOCK_COMMENT = 21;

  /// <summary>Lexical states for SCLEX_HTML, SCLEX_XML</summary>
  SCE_H_DEFAULT = 0;
  SCE_H_TAG = 1;
  SCE_H_TAGUNKNOWN = 2;
  SCE_H_ATTRIBUTE = 3;
  SCE_H_ATTRIBUTEUNKNOWN = 4;
  SCE_H_NUMBER = 5;
  SCE_H_DOUBLESTRING = 6;
  SCE_H_SINGLESTRING = 7;
  SCE_H_OTHER = 8;
  SCE_H_COMMENT = 9;
  SCE_H_ENTITY = 10;

  /// <summary>XML and ASP</summary>
  SCE_H_TAGEND = 11;
  SCE_H_XMLSTART = 12;
  SCE_H_XMLEND = 13;
  SCE_H_SCRIPT = 14;
  SCE_H_ASP = 15;
  SCE_H_ASPAT = 16;
  SCE_H_CDATA = 17;
  SCE_H_QUESTION = 18;

  /// <summary>More HTML</summary>
  SCE_H_VALUE = 19;

  /// <summary>X-Code</summary>
  SCE_H_XCCOMMENT = 20;

  /// <summary>SGML</summary>
  SCE_H_SGML_DEFAULT = 21;
  SCE_H_SGML_COMMAND = 22;
  SCE_H_SGML_1ST_PARAM = 23;
  SCE_H_SGML_DOUBLESTRING = 24;
  SCE_H_SGML_SIMPLESTRING = 25;
  SCE_H_SGML_ERROR = 26;
  SCE_H_SGML_SPECIAL = 27;
  SCE_H_SGML_ENTITY = 28;
  SCE_H_SGML_COMMENT = 29;
  SCE_H_SGML_1ST_PARAM_COMMENT = 30;
  SCE_H_SGML_BLOCK_DEFAULT = 31;

  /// <summary>Embedded Javascript</summary>
  SCE_HJ_START = 40;
  SCE_HJ_DEFAULT = 41;
  SCE_HJ_COMMENT = 42;
  SCE_HJ_COMMENTLINE = 43;
  SCE_HJ_COMMENTDOC = 44;
  SCE_HJ_NUMBER = 45;
  SCE_HJ_WORD = 46;
  SCE_HJ_KEYWORD = 47;
  SCE_HJ_DOUBLESTRING = 48;
  SCE_HJ_SINGLESTRING = 49;
  SCE_HJ_SYMBOLS = 50;
  SCE_HJ_STRINGEOL = 51;
  SCE_HJ_REGEX = 52;

  /// <summary>ASP Javascript</summary>
  SCE_HJA_START = 55;
  SCE_HJA_DEFAULT = 56;
  SCE_HJA_COMMENT = 57;
  SCE_HJA_COMMENTLINE = 58;
  SCE_HJA_COMMENTDOC = 59;
  SCE_HJA_NUMBER = 60;
  SCE_HJA_WORD = 61;
  SCE_HJA_KEYWORD = 62;
  SCE_HJA_DOUBLESTRING = 63;
  SCE_HJA_SINGLESTRING = 64;
  SCE_HJA_SYMBOLS = 65;
  SCE_HJA_STRINGEOL = 66;
  SCE_HJA_REGEX = 67;

  /// <summary>Embedded VBScript</summary>
  SCE_HB_START = 70;
  SCE_HB_DEFAULT = 71;
  SCE_HB_COMMENTLINE = 72;
  SCE_HB_NUMBER = 73;
  SCE_HB_WORD = 74;
  SCE_HB_STRING = 75;
  SCE_HB_IDENTIFIER = 76;
  SCE_HB_STRINGEOL = 77;

  /// <summary>ASP VBScript</summary>
  SCE_HBA_START = 80;
  SCE_HBA_DEFAULT = 81;
  SCE_HBA_COMMENTLINE = 82;
  SCE_HBA_NUMBER = 83;
  SCE_HBA_WORD = 84;
  SCE_HBA_STRING = 85;
  SCE_HBA_IDENTIFIER = 86;
  SCE_HBA_STRINGEOL = 87;

  /// <summary>Embedded Python</summary>
  SCE_HP_START = 90;
  SCE_HP_DEFAULT = 91;
  SCE_HP_COMMENTLINE = 92;
  SCE_HP_NUMBER = 93;
  SCE_HP_STRING = 94;
  SCE_HP_CHARACTER = 95;
  SCE_HP_WORD = 96;
  SCE_HP_TRIPLE = 97;
  SCE_HP_TRIPLEDOUBLE = 98;
  SCE_HP_CLASSNAME = 99;
  SCE_HP_DEFNAME = 100;
  SCE_HP_OPERATOR = 101;
  SCE_HP_IDENTIFIER = 102;

  /// <summary>PHP</summary>
  SCE_HPHP_COMPLEX_VARIABLE = 104;

  /// <summary>ASP Python</summary>
  SCE_HPA_START = 105;
  SCE_HPA_DEFAULT = 106;
  SCE_HPA_COMMENTLINE = 107;
  SCE_HPA_NUMBER = 108;
  SCE_HPA_STRING = 109;
  SCE_HPA_CHARACTER = 110;
  SCE_HPA_WORD = 111;
  SCE_HPA_TRIPLE = 112;
  SCE_HPA_TRIPLEDOUBLE = 113;
  SCE_HPA_CLASSNAME = 114;
  SCE_HPA_DEFNAME = 115;
  SCE_HPA_OPERATOR = 116;
  SCE_HPA_IDENTIFIER = 117;

  /// <summary>PHP</summary>
  SCE_HPHP_DEFAULT = 118;
  SCE_HPHP_HSTRING = 119;
  SCE_HPHP_SIMPLESTRING = 120;
  SCE_HPHP_WORD = 121;
  SCE_HPHP_NUMBER = 122;
  SCE_HPHP_VARIABLE = 123;
  SCE_HPHP_COMMENT = 124;
  SCE_HPHP_COMMENTLINE = 125;
  SCE_HPHP_HSTRING_VARIABLE = 126;
  SCE_HPHP_OPERATOR = 127;

  /// <summary>Lexical states for SCLEX_PERL</summary>
  SCE_PL_DEFAULT = 0;
  SCE_PL_ERROR = 1;
  SCE_PL_COMMENTLINE = 2;
  SCE_PL_POD = 3;
  SCE_PL_NUMBER = 4;
  SCE_PL_WORD = 5;
  SCE_PL_STRING = 6;
  SCE_PL_CHARACTER = 7;
  SCE_PL_PUNCTUATION = 8;
  SCE_PL_PREPROCESSOR = 9;
  SCE_PL_OPERATOR = 10;
  SCE_PL_IDENTIFIER = 11;
  SCE_PL_SCALAR = 12;
  SCE_PL_ARRAY = 13;
  SCE_PL_HASH = 14;
  SCE_PL_SYMBOLTABLE = 15;
  SCE_PL_VARIABLE_INDEXER = 16;
  SCE_PL_REGEX = 17;
  SCE_PL_REGSUBST = 18;
  SCE_PL_LONGQUOTE = 19;
  SCE_PL_BACKTICKS = 20;
  SCE_PL_DATASECTION = 21;
  SCE_PL_HERE_DELIM = 22;
  SCE_PL_HERE_Q = 23;
  SCE_PL_HERE_QQ = 24;
  SCE_PL_HERE_QX = 25;
  SCE_PL_STRING_Q = 26;
  SCE_PL_STRING_QQ = 27;
  SCE_PL_STRING_QX = 28;
  SCE_PL_STRING_QR = 29;
  SCE_PL_STRING_QW = 30;
  SCE_PL_POD_VERB = 31;
  SCE_PL_SUB_PROTOTYPE = 40;
  SCE_PL_FORMAT_IDENT = 41;
  SCE_PL_FORMAT = 42;
  SCE_PL_STRING_VAR = 43;
  SCE_PL_XLAT = 44;
  SCE_PL_REGEX_VAR = 54;
  SCE_PL_REGSUBST_VAR = 55;
  SCE_PL_BACKTICKS_VAR = 57;
  SCE_PL_HERE_QQ_VAR = 61;
  SCE_PL_HERE_QX_VAR = 62;
  SCE_PL_STRING_QQ_VAR = 64;
  SCE_PL_STRING_QX_VAR = 65;
  SCE_PL_STRING_QR_VAR = 66;

  /// <summary>Lexical states for SCLEX_RUBY</summary>
  SCE_RB_DEFAULT = 0;
  SCE_RB_ERROR = 1;
  SCE_RB_COMMENTLINE = 2;
  SCE_RB_POD = 3;
  SCE_RB_NUMBER = 4;
  SCE_RB_WORD = 5;
  SCE_RB_STRING = 6;
  SCE_RB_CHARACTER = 7;
  SCE_RB_CLASSNAME = 8;
  SCE_RB_DEFNAME = 9;
  SCE_RB_OPERATOR = 10;
  SCE_RB_IDENTIFIER = 11;
  SCE_RB_REGEX = 12;
  SCE_RB_GLOBAL = 13;
  SCE_RB_SYMBOL = 14;
  SCE_RB_MODULE_NAME = 15;
  SCE_RB_INSTANCE_VAR = 16;
  SCE_RB_CLASS_VAR = 17;
  SCE_RB_BACKTICKS = 18;
  SCE_RB_DATASECTION = 19;
  SCE_RB_HERE_DELIM = 20;
  SCE_RB_HERE_Q = 21;
  SCE_RB_HERE_QQ = 22;
  SCE_RB_HERE_QX = 23;
  SCE_RB_STRING_Q = 24;
  SCE_RB_STRING_QQ = 25;
  SCE_RB_STRING_QX = 26;
  SCE_RB_STRING_QR = 27;
  SCE_RB_STRING_QW = 28;
  SCE_RB_WORD_DEMOTED = 29;
  SCE_RB_STDIN = 30;
  SCE_RB_STDOUT = 31;
  SCE_RB_STDERR = 40;
  SCE_RB_UPPER_BOUND = 41;

  /// <summary>Lexical states for SCLEX_VB, SCLEX_VBSCRIPT, SCLEX_POWERBASIC</summary>
  SCE_B_DEFAULT = 0;
  SCE_B_COMMENT = 1;
  SCE_B_NUMBER = 2;
  SCE_B_KEYWORD = 3;
  SCE_B_STRING = 4;
  SCE_B_PREPROCESSOR = 5;
  SCE_B_OPERATOR = 6;
  SCE_B_IDENTIFIER = 7;
  SCE_B_DATE = 8;
  SCE_B_STRINGEOL = 9;
  SCE_B_KEYWORD2 = 10;
  SCE_B_KEYWORD3 = 11;
  SCE_B_KEYWORD4 = 12;
  SCE_B_CONSTANT = 13;
  SCE_B_ASM = 14;
  SCE_B_LABEL = 15;
  SCE_B_ERROR = 16;
  SCE_B_HEXNUMBER = 17;
  SCE_B_BINNUMBER = 18;
  SCE_B_COMMENTBLOCK = 19;
  SCE_B_DOCLINE = 20;
  SCE_B_DOCBLOCK = 21;
  SCE_B_DOCKEYWORD = 22;

  /// <summary>Lexical states for SCLEX_PROPERTIES</summary>
  SCE_PROPS_DEFAULT = 0;
  SCE_PROPS_COMMENT = 1;
  SCE_PROPS_SECTION = 2;
  SCE_PROPS_ASSIGNMENT = 3;
  SCE_PROPS_DEFVAL = 4;
  SCE_PROPS_KEY = 5;

  /// <summary>Lexical states for SCLEX_LATEX</summary>
  SCE_L_DEFAULT = 0;
  SCE_L_COMMAND = 1;
  SCE_L_TAG = 2;
  SCE_L_MATH = 3;
  SCE_L_COMMENT = 4;
  SCE_L_TAG2 = 5;
  SCE_L_MATH2 = 6;
  SCE_L_COMMENT2 = 7;
  SCE_L_VERBATIM = 8;
  SCE_L_SHORTCMD = 9;
  SCE_L_SPECIAL = 10;
  SCE_L_CMDOPT = 11;
  SCE_L_ERROR = 12;

  /// <summary>Lexical states for SCLEX_LUA</summary>
  SCE_LUA_DEFAULT = 0;
  SCE_LUA_COMMENT = 1;
  SCE_LUA_COMMENTLINE = 2;
  SCE_LUA_COMMENTDOC = 3;
  SCE_LUA_NUMBER = 4;
  SCE_LUA_WORD = 5;
  SCE_LUA_STRING = 6;
  SCE_LUA_CHARACTER = 7;
  SCE_LUA_LITERALSTRING = 8;
  SCE_LUA_PREPROCESSOR = 9;
  SCE_LUA_OPERATOR = 10;
  SCE_LUA_IDENTIFIER = 11;
  SCE_LUA_STRINGEOL = 12;
  SCE_LUA_WORD2 = 13;
  SCE_LUA_WORD3 = 14;
  SCE_LUA_WORD4 = 15;
  SCE_LUA_WORD5 = 16;
  SCE_LUA_WORD6 = 17;
  SCE_LUA_WORD7 = 18;
  SCE_LUA_WORD8 = 19;
  SCE_LUA_LABEL = 20;

  /// <summary>Lexical states for SCLEX_ERRORLIST</summary>
  SCE_ERR_DEFAULT = 0;
  SCE_ERR_PYTHON = 1;
  SCE_ERR_GCC = 2;
  SCE_ERR_MS = 3;
  SCE_ERR_CMD = 4;
  SCE_ERR_BORLAND = 5;
  SCE_ERR_PERL = 6;
  SCE_ERR_NET = 7;
  SCE_ERR_LUA = 8;
  SCE_ERR_CTAG = 9;
  SCE_ERR_DIFF_CHANGED = 10;
  SCE_ERR_DIFF_ADDITION = 11;
  SCE_ERR_DIFF_DELETION = 12;
  SCE_ERR_DIFF_MESSAGE = 13;
  SCE_ERR_PHP = 14;
  SCE_ERR_ELF = 15;
  SCE_ERR_IFC = 16;
  SCE_ERR_IFORT = 17;
  SCE_ERR_ABSF = 18;
  SCE_ERR_TIDY = 19;
  SCE_ERR_JAVA_STACK = 20;
  SCE_ERR_VALUE = 21;
  SCE_ERR_GCC_INCLUDED_FROM = 22;

  /// <summary>Lexical states for SCLEX_BATCH</summary>
  SCE_BAT_DEFAULT = 0;
  SCE_BAT_COMMENT = 1;
  SCE_BAT_WORD = 2;
  SCE_BAT_LABEL = 3;
  SCE_BAT_HIDE = 4;
  SCE_BAT_COMMAND = 5;
  SCE_BAT_IDENTIFIER = 6;
  SCE_BAT_OPERATOR = 7;

  /// <summary>Lexical states for SCLEX_TCMD</summary>
  SCE_TCMD_DEFAULT = 0;
  SCE_TCMD_COMMENT = 1;
  SCE_TCMD_WORD = 2;
  SCE_TCMD_LABEL = 3;
  SCE_TCMD_HIDE = 4;
  SCE_TCMD_COMMAND = 5;
  SCE_TCMD_IDENTIFIER = 6;
  SCE_TCMD_OPERATOR = 7;
  SCE_TCMD_ENVIRONMENT = 8;
  SCE_TCMD_EXPANSION = 9;
  SCE_TCMD_CLABEL = 10;

  /// <summary>Lexical states for SCLEX_MAKEFILE</summary>
  SCE_MAKE_DEFAULT = 0;
  SCE_MAKE_COMMENT = 1;
  SCE_MAKE_PREPROCESSOR = 2;
  SCE_MAKE_IDENTIFIER = 3;
  SCE_MAKE_OPERATOR = 4;
  SCE_MAKE_TARGET = 5;
  SCE_MAKE_IDEOL = 9;

  /// <summary>Lexical states for SCLEX_DIFF</summary>
  SCE_DIFF_DEFAULT = 0;
  SCE_DIFF_COMMENT = 1;
  SCE_DIFF_COMMAND = 2;
  SCE_DIFF_HEADER = 3;
  SCE_DIFF_POSITION = 4;
  SCE_DIFF_DELETED = 5;
  SCE_DIFF_ADDED = 6;
  SCE_DIFF_CHANGED = 7;

  /// <summary>Lexical states for SCLEX_CONF (Apache Configuration Files Lexer)</summary>
  SCE_CONF_DEFAULT = 0;
  SCE_CONF_COMMENT = 1;
  SCE_CONF_NUMBER = 2;
  SCE_CONF_IDENTIFIER = 3;
  SCE_CONF_EXTENSION = 4;
  SCE_CONF_PARAMETER = 5;
  SCE_CONF_STRING = 6;
  SCE_CONF_OPERATOR = 7;
  SCE_CONF_IP = 8;
  SCE_CONF_DIRECTIVE = 9;

  /// <summary>Lexical states for SCLEX_AVE, Avenue</summary>
  SCE_AVE_DEFAULT = 0;
  SCE_AVE_COMMENT = 1;
  SCE_AVE_NUMBER = 2;
  SCE_AVE_WORD = 3;
  SCE_AVE_STRING = 6;
  SCE_AVE_ENUM = 7;
  SCE_AVE_STRINGEOL = 8;
  SCE_AVE_IDENTIFIER = 9;
  SCE_AVE_OPERATOR = 10;
  SCE_AVE_WORD1 = 11;
  SCE_AVE_WORD2 = 12;
  SCE_AVE_WORD3 = 13;
  SCE_AVE_WORD4 = 14;
  SCE_AVE_WORD5 = 15;
  SCE_AVE_WORD6 = 16;

  /// <summary>Lexical states for SCLEX_ADA</summary>
  SCE_ADA_DEFAULT = 0;
  SCE_ADA_WORD = 1;
  SCE_ADA_IDENTIFIER = 2;
  SCE_ADA_NUMBER = 3;
  SCE_ADA_DELIMITER = 4;
  SCE_ADA_CHARACTER = 5;
  SCE_ADA_CHARACTEREOL = 6;
  SCE_ADA_STRING = 7;
  SCE_ADA_STRINGEOL = 8;
  SCE_ADA_LABEL = 9;
  SCE_ADA_COMMENTLINE = 10;
  SCE_ADA_ILLEGAL = 11;

  /// <summary>Lexical states for SCLEX_BAAN</summary>
  SCE_BAAN_DEFAULT = 0;
  SCE_BAAN_COMMENT = 1;
  SCE_BAAN_COMMENTDOC = 2;
  SCE_BAAN_NUMBER = 3;
  SCE_BAAN_WORD = 4;
  SCE_BAAN_STRING = 5;
  SCE_BAAN_PREPROCESSOR = 6;
  SCE_BAAN_OPERATOR = 7;
  SCE_BAAN_IDENTIFIER = 8;
  SCE_BAAN_STRINGEOL = 9;
  SCE_BAAN_WORD2 = 10;

  /// <summary>Lexical states for SCLEX_LISP</summary>
  SCE_LISP_DEFAULT = 0;
  SCE_LISP_COMMENT = 1;
  SCE_LISP_NUMBER = 2;
  SCE_LISP_KEYWORD = 3;
  SCE_LISP_KEYWORD_KW = 4;
  SCE_LISP_SYMBOL = 5;
  SCE_LISP_STRING = 6;
  SCE_LISP_STRINGEOL = 8;
  SCE_LISP_IDENTIFIER = 9;
  SCE_LISP_OPERATOR = 10;
  SCE_LISP_SPECIAL = 11;
  SCE_LISP_MULTI_COMMENT = 12;

  /// <summary>Lexical states for SCLEX_EIFFEL and SCLEX_EIFFELKW</summary>
  SCE_EIFFEL_DEFAULT = 0;
  SCE_EIFFEL_COMMENTLINE = 1;
  SCE_EIFFEL_NUMBER = 2;
  SCE_EIFFEL_WORD = 3;
  SCE_EIFFEL_STRING = 4;
  SCE_EIFFEL_CHARACTER = 5;
  SCE_EIFFEL_OPERATOR = 6;
  SCE_EIFFEL_IDENTIFIER = 7;
  SCE_EIFFEL_STRINGEOL = 8;

  /// <summary>Lexical states for SCLEX_NNCRONTAB (nnCron crontab Lexer)</summary>
  SCE_NNCRONTAB_DEFAULT = 0;
  SCE_NNCRONTAB_COMMENT = 1;
  SCE_NNCRONTAB_TASK = 2;
  SCE_NNCRONTAB_SECTION = 3;
  SCE_NNCRONTAB_KEYWORD = 4;
  SCE_NNCRONTAB_MODIFIER = 5;
  SCE_NNCRONTAB_ASTERISK = 6;
  SCE_NNCRONTAB_NUMBER = 7;
  SCE_NNCRONTAB_STRING = 8;
  SCE_NNCRONTAB_ENVIRONMENT = 9;
  SCE_NNCRONTAB_IDENTIFIER = 10;

  /// <summary>Lexical states for SCLEX_FORTH (Forth Lexer)</summary>
  SCE_FORTH_DEFAULT = 0;
  SCE_FORTH_COMMENT = 1;
  SCE_FORTH_COMMENT_ML = 2;
  SCE_FORTH_IDENTIFIER = 3;
  SCE_FORTH_CONTROL = 4;
  SCE_FORTH_KEYWORD = 5;
  SCE_FORTH_DEFWORD = 6;
  SCE_FORTH_PREWORD1 = 7;
  SCE_FORTH_PREWORD2 = 8;
  SCE_FORTH_NUMBER = 9;
  SCE_FORTH_STRING = 10;
  SCE_FORTH_LOCALE = 11;

  /// <summary>Lexical states for SCLEX_MATLAB</summary>
  SCE_MATLAB_DEFAULT = 0;
  SCE_MATLAB_COMMENT = 1;
  SCE_MATLAB_COMMAND = 2;
  SCE_MATLAB_NUMBER = 3;
  SCE_MATLAB_KEYWORD = 4;

  /// <summary>single quoted string</summary>
  SCE_MATLAB_STRING = 5;
  SCE_MATLAB_OPERATOR = 6;
  SCE_MATLAB_IDENTIFIER = 7;
  SCE_MATLAB_DOUBLEQUOTESTRING = 8;

  /// <summary>Lexical states for SCLEX_SCRIPTOL</summary>
  SCE_SCRIPTOL_DEFAULT = 0;
  SCE_SCRIPTOL_WHITE = 1;
  SCE_SCRIPTOL_COMMENTLINE = 2;
  SCE_SCRIPTOL_PERSISTENT = 3;
  SCE_SCRIPTOL_CSTYLE = 4;
  SCE_SCRIPTOL_COMMENTBLOCK = 5;
  SCE_SCRIPTOL_NUMBER = 6;
  SCE_SCRIPTOL_STRING = 7;
  SCE_SCRIPTOL_CHARACTER = 8;
  SCE_SCRIPTOL_STRINGEOL = 9;
  SCE_SCRIPTOL_KEYWORD = 10;
  SCE_SCRIPTOL_OPERATOR = 11;
  SCE_SCRIPTOL_IDENTIFIER = 12;
  SCE_SCRIPTOL_TRIPLE = 13;
  SCE_SCRIPTOL_CLASSNAME = 14;
  SCE_SCRIPTOL_PREPROCESSOR = 15;

  /// <summary>Lexical states for SCLEX_ASM, SCLEX_AS</summary>
  SCE_ASM_DEFAULT = 0;
  SCE_ASM_COMMENT = 1;
  SCE_ASM_NUMBER = 2;
  SCE_ASM_STRING = 3;
  SCE_ASM_OPERATOR = 4;
  SCE_ASM_IDENTIFIER = 5;
  SCE_ASM_CPUINSTRUCTION = 6;
  SCE_ASM_MATHINSTRUCTION = 7;
  SCE_ASM_REGISTER = 8;
  SCE_ASM_DIRECTIVE = 9;
  SCE_ASM_DIRECTIVEOPERAND = 10;
  SCE_ASM_COMMENTBLOCK = 11;
  SCE_ASM_CHARACTER = 12;
  SCE_ASM_STRINGEOL = 13;
  SCE_ASM_EXTINSTRUCTION = 14;
  SCE_ASM_COMMENTDIRECTIVE = 15;

  /// <summary>Lexical states for SCLEX_FORTRAN</summary>
  SCE_F_DEFAULT = 0;
  SCE_F_COMMENT = 1;
  SCE_F_NUMBER = 2;
  SCE_F_STRING1 = 3;
  SCE_F_STRING2 = 4;
  SCE_F_STRINGEOL = 5;
  SCE_F_OPERATOR = 6;
  SCE_F_IDENTIFIER = 7;
  SCE_F_WORD = 8;
  SCE_F_WORD2 = 9;
  SCE_F_WORD3 = 10;
  SCE_F_PREPROCESSOR = 11;
  SCE_F_OPERATOR2 = 12;
  SCE_F_LABEL = 13;
  SCE_F_CONTINUATION = 14;

  /// <summary>Lexical states for SCLEX_CSS</summary>
  SCE_CSS_DEFAULT = 0;
  SCE_CSS_TAG = 1;
  SCE_CSS_CLASS = 2;
  SCE_CSS_PSEUDOCLASS = 3;
  SCE_CSS_UNKNOWN_PSEUDOCLASS = 4;
  SCE_CSS_OPERATOR = 5;
  SCE_CSS_IDENTIFIER = 6;
  SCE_CSS_UNKNOWN_IDENTIFIER = 7;
  SCE_CSS_VALUE = 8;
  SCE_CSS_COMMENT = 9;
  SCE_CSS_ID = 10;
  SCE_CSS_IMPORTANT = 11;
  SCE_CSS_DIRECTIVE = 12;
  SCE_CSS_DOUBLESTRING = 13;
  SCE_CSS_SINGLESTRING = 14;
  SCE_CSS_IDENTIFIER2 = 15;
  SCE_CSS_ATTRIBUTE = 16;
  SCE_CSS_IDENTIFIER3 = 17;
  SCE_CSS_PSEUDOELEMENT = 18;
  SCE_CSS_EXTENDED_IDENTIFIER = 19;
  SCE_CSS_EXTENDED_PSEUDOCLASS = 20;
  SCE_CSS_EXTENDED_PSEUDOELEMENT = 21;
  SCE_CSS_MEDIA = 22;
  SCE_CSS_VARIABLE = 23;

  /// <summary>Lexical states for SCLEX_POV</summary>
  SCE_POV_DEFAULT = 0;
  SCE_POV_COMMENT = 1;
  SCE_POV_COMMENTLINE = 2;
  SCE_POV_NUMBER = 3;
  SCE_POV_OPERATOR = 4;
  SCE_POV_IDENTIFIER = 5;
  SCE_POV_STRING = 6;
  SCE_POV_STRINGEOL = 7;
  SCE_POV_DIRECTIVE = 8;
  SCE_POV_BADDIRECTIVE = 9;
  SCE_POV_WORD2 = 10;
  SCE_POV_WORD3 = 11;
  SCE_POV_WORD4 = 12;
  SCE_POV_WORD5 = 13;
  SCE_POV_WORD6 = 14;
  SCE_POV_WORD7 = 15;
  SCE_POV_WORD8 = 16;

  /// <summary>Lexical states for SCLEX_LOUT</summary>
  SCE_LOUT_DEFAULT = 0;
  SCE_LOUT_COMMENT = 1;
  SCE_LOUT_NUMBER = 2;
  SCE_LOUT_WORD = 3;
  SCE_LOUT_WORD2 = 4;
  SCE_LOUT_WORD3 = 5;
  SCE_LOUT_WORD4 = 6;
  SCE_LOUT_STRING = 7;
  SCE_LOUT_OPERATOR = 8;
  SCE_LOUT_IDENTIFIER = 9;
  SCE_LOUT_STRINGEOL = 10;

  /// <summary>Lexical states for SCLEX_ESCRIPT</summary>
  SCE_ESCRIPT_DEFAULT = 0;
  SCE_ESCRIPT_COMMENT = 1;
  SCE_ESCRIPT_COMMENTLINE = 2;
  SCE_ESCRIPT_COMMENTDOC = 3;
  SCE_ESCRIPT_NUMBER = 4;
  SCE_ESCRIPT_WORD = 5;
  SCE_ESCRIPT_STRING = 6;
  SCE_ESCRIPT_OPERATOR = 7;
  SCE_ESCRIPT_IDENTIFIER = 8;
  SCE_ESCRIPT_BRACE = 9;
  SCE_ESCRIPT_WORD2 = 10;
  SCE_ESCRIPT_WORD3 = 11;

  /// <summary>Lexical states for SCLEX_PS</summary>
  SCE_PS_DEFAULT = 0;
  SCE_PS_COMMENT = 1;
  SCE_PS_DSC_COMMENT = 2;
  SCE_PS_DSC_VALUE = 3;
  SCE_PS_NUMBER = 4;
  SCE_PS_NAME = 5;
  SCE_PS_KEYWORD = 6;
  SCE_PS_LITERAL = 7;
  SCE_PS_IMMEVAL = 8;
  SCE_PS_PAREN_ARRAY = 9;
  SCE_PS_PAREN_DICT = 10;
  SCE_PS_PAREN_PROC = 11;
  SCE_PS_TEXT = 12;
  SCE_PS_HEXSTRING = 13;
  SCE_PS_BASE85STRING = 14;
  SCE_PS_BADSTRINGCHAR = 15;

  /// <summary>Lexical states for SCLEX_NSIS</summary>
  SCE_NSIS_DEFAULT = 0;
  SCE_NSIS_COMMENT = 1;
  SCE_NSIS_STRINGDQ = 2;
  SCE_NSIS_STRINGLQ = 3;
  SCE_NSIS_STRINGRQ = 4;
  SCE_NSIS_FUNCTION = 5;
  SCE_NSIS_VARIABLE = 6;
  SCE_NSIS_LABEL = 7;
  SCE_NSIS_USERDEFINED = 8;
  SCE_NSIS_SECTIONDEF = 9;
  SCE_NSIS_SUBSECTIONDEF = 10;
  SCE_NSIS_IFDEFINEDEF = 11;
  SCE_NSIS_MACRODEF = 12;
  SCE_NSIS_STRINGVAR = 13;
  SCE_NSIS_NUMBER = 14;
  SCE_NSIS_SECTIONGROUP = 15;
  SCE_NSIS_PAGEEX = 16;
  SCE_NSIS_FUNCTIONDEF = 17;
  SCE_NSIS_COMMENTBOX = 18;

  /// <summary>Lexical states for SCLEX_MMIXAL</summary>
  SCE_MMIXAL_LEADWS = 0;
  SCE_MMIXAL_COMMENT = 1;
  SCE_MMIXAL_LABEL = 2;
  SCE_MMIXAL_OPCODE = 3;
  SCE_MMIXAL_OPCODE_PRE = 4;
  SCE_MMIXAL_OPCODE_VALID = 5;
  SCE_MMIXAL_OPCODE_UNKNOWN = 6;
  SCE_MMIXAL_OPCODE_POST = 7;
  SCE_MMIXAL_OPERANDS = 8;
  SCE_MMIXAL_NUMBER = 9;
  SCE_MMIXAL_REF = 10;
  SCE_MMIXAL_CHAR = 11;
  SCE_MMIXAL_STRING = 12;
  SCE_MMIXAL_REGISTER = 13;
  SCE_MMIXAL_HEX = 14;
  SCE_MMIXAL_OPERATOR = 15;
  SCE_MMIXAL_SYMBOL = 16;
  SCE_MMIXAL_INCLUDE = 17;

  /// <summary>Lexical states for SCLEX_CLW</summary>
  SCE_CLW_DEFAULT = 0;
  SCE_CLW_LABEL = 1;
  SCE_CLW_COMMENT = 2;
  SCE_CLW_STRING = 3;
  SCE_CLW_USER_IDENTIFIER = 4;
  SCE_CLW_INTEGER_CONSTANT = 5;
  SCE_CLW_REAL_CONSTANT = 6;
  SCE_CLW_PICTURE_STRING = 7;
  SCE_CLW_KEYWORD = 8;
  SCE_CLW_COMPILER_DIRECTIVE = 9;
  SCE_CLW_RUNTIME_EXPRESSIONS = 10;
  SCE_CLW_BUILTIN_PROCEDURES_FUNCTION = 11;
  SCE_CLW_STRUCTURE_DATA_TYPE = 12;
  SCE_CLW_ATTRIBUTE = 13;
  SCE_CLW_STANDARD_EQUATE = 14;
  SCE_CLW_ERROR = 15;
  SCE_CLW_DEPRECATED = 16;

  /// <summary>Lexical states for SCLEX_LOT</summary>
  SCE_LOT_DEFAULT = 0;
  SCE_LOT_HEADER = 1;
  SCE_LOT_BREAK = 2;
  SCE_LOT_SET = 3;
  SCE_LOT_PASS = 4;
  SCE_LOT_FAIL = 5;
  SCE_LOT_ABORT = 6;

  /// <summary>Lexical states for SCLEX_YAML</summary>
  SCE_YAML_DEFAULT = 0;
  SCE_YAML_COMMENT = 1;
  SCE_YAML_IDENTIFIER = 2;
  SCE_YAML_KEYWORD = 3;
  SCE_YAML_NUMBER = 4;
  SCE_YAML_REFERENCE = 5;
  SCE_YAML_DOCUMENT = 6;
  SCE_YAML_TEXT = 7;
  SCE_YAML_ERROR = 8;
  SCE_YAML_OPERATOR = 9;

  /// <summary>Lexical states for SCLEX_TEX</summary>
  SCE_TEX_DEFAULT = 0;
  SCE_TEX_SPECIAL = 1;
  SCE_TEX_GROUP = 2;
  SCE_TEX_SYMBOL = 3;
  SCE_TEX_COMMAND = 4;
  SCE_TEX_TEXT = 5;
  SCE_METAPOST_DEFAULT = 0;
  SCE_METAPOST_SPECIAL = 1;
  SCE_METAPOST_GROUP = 2;
  SCE_METAPOST_SYMBOL = 3;
  SCE_METAPOST_COMMAND = 4;
  SCE_METAPOST_TEXT = 5;
  SCE_METAPOST_EXTRA = 6;

  /// <summary>Lexical states for SCLEX_ERLANG</summary>
  SCE_ERLANG_DEFAULT = 0;
  SCE_ERLANG_COMMENT = 1;
  SCE_ERLANG_VARIABLE = 2;
  SCE_ERLANG_NUMBER = 3;
  SCE_ERLANG_KEYWORD = 4;
  SCE_ERLANG_STRING = 5;
  SCE_ERLANG_OPERATOR = 6;
  SCE_ERLANG_ATOM = 7;
  SCE_ERLANG_FUNCTION_NAME = 8;
  SCE_ERLANG_CHARACTER = 9;
  SCE_ERLANG_MACRO = 10;
  SCE_ERLANG_RECORD = 11;
  SCE_ERLANG_PREPROC = 12;
  SCE_ERLANG_NODE_NAME = 13;
  SCE_ERLANG_COMMENT_FUNCTION = 14;
  SCE_ERLANG_COMMENT_MODULE = 15;
  SCE_ERLANG_COMMENT_DOC = 16;
  SCE_ERLANG_COMMENT_DOC_MACRO = 17;
  SCE_ERLANG_ATOM_QUOTED = 18;
  SCE_ERLANG_MACRO_QUOTED = 19;
  SCE_ERLANG_RECORD_QUOTED = 20;
  SCE_ERLANG_NODE_NAME_QUOTED = 21;
  SCE_ERLANG_BIFS = 22;
  SCE_ERLANG_MODULES = 23;
  SCE_ERLANG_MODULES_ATT = 24;
  SCE_ERLANG_UNKNOWN = 31;

  /// <summary>Lexical states for SCLEX_OCTAVE are identical to MatLab
  /// Lexical states for SCLEX_MSSQL</summary>
  SCE_MSSQL_DEFAULT = 0;
  SCE_MSSQL_COMMENT = 1;
  SCE_MSSQL_LINE_COMMENT = 2;
  SCE_MSSQL_NUMBER = 3;
  SCE_MSSQL_STRING = 4;
  SCE_MSSQL_OPERATOR = 5;
  SCE_MSSQL_IDENTIFIER = 6;
  SCE_MSSQL_VARIABLE = 7;
  SCE_MSSQL_COLUMN_NAME = 8;
  SCE_MSSQL_STATEMENT = 9;
  SCE_MSSQL_DATATYPE = 10;
  SCE_MSSQL_SYSTABLE = 11;
  SCE_MSSQL_GLOBAL_VARIABLE = 12;
  SCE_MSSQL_FUNCTION = 13;
  SCE_MSSQL_STORED_PROCEDURE = 14;
  SCE_MSSQL_DEFAULT_PREF_DATATYPE = 15;
  SCE_MSSQL_COLUMN_NAME_2 = 16;

  /// <summary>Lexical states for SCLEX_VERILOG</summary>
  SCE_V_DEFAULT = 0;
  SCE_V_COMMENT = 1;
  SCE_V_COMMENTLINE = 2;
  SCE_V_COMMENTLINEBANG = 3;
  SCE_V_NUMBER = 4;
  SCE_V_WORD = 5;
  SCE_V_STRING = 6;
  SCE_V_WORD2 = 7;
  SCE_V_WORD3 = 8;
  SCE_V_PREPROCESSOR = 9;
  SCE_V_OPERATOR = 10;
  SCE_V_IDENTIFIER = 11;
  SCE_V_STRINGEOL = 12;
  SCE_V_USER = 19;

  /// <summary>Lexical states for SCLEX_KIX</summary>
  SCE_KIX_DEFAULT = 0;
  SCE_KIX_COMMENT = 1;
  SCE_KIX_STRING1 = 2;
  SCE_KIX_STRING2 = 3;
  SCE_KIX_NUMBER = 4;
  SCE_KIX_VAR = 5;
  SCE_KIX_MACRO = 6;
  SCE_KIX_KEYWORD = 7;
  SCE_KIX_FUNCTIONS = 8;
  SCE_KIX_OPERATOR = 9;
  SCE_KIX_IDENTIFIER = 31;

  /// <summary>Lexical states for SCLEX_GUI4CLI</summary>
  SCE_GC_DEFAULT = 0;
  SCE_GC_COMMENTLINE = 1;
  SCE_GC_COMMENTBLOCK = 2;
  SCE_GC_GLOBAL = 3;
  SCE_GC_EVENT = 4;
  SCE_GC_ATTRIBUTE = 5;
  SCE_GC_CONTROL = 6;
  SCE_GC_COMMAND = 7;
  SCE_GC_STRING = 8;
  SCE_GC_OPERATOR = 9;

  /// <summary>Lexical states for SCLEX_SPECMAN</summary>
  SCE_SN_DEFAULT = 0;
  SCE_SN_CODE = 1;
  SCE_SN_COMMENTLINE = 2;
  SCE_SN_COMMENTLINEBANG = 3;
  SCE_SN_NUMBER = 4;
  SCE_SN_WORD = 5;
  SCE_SN_STRING = 6;
  SCE_SN_WORD2 = 7;
  SCE_SN_WORD3 = 8;
  SCE_SN_PREPROCESSOR = 9;
  SCE_SN_OPERATOR = 10;
  SCE_SN_IDENTIFIER = 11;
  SCE_SN_STRINGEOL = 12;
  SCE_SN_REGEXTAG = 13;
  SCE_SN_SIGNAL = 14;
  SCE_SN_USER = 19;

  /// <summary>Lexical states for SCLEX_AU3</summary>
  SCE_AU3_DEFAULT = 0;
  SCE_AU3_COMMENT = 1;
  SCE_AU3_COMMENTBLOCK = 2;
  SCE_AU3_NUMBER = 3;
  SCE_AU3_FUNCTION = 4;
  SCE_AU3_KEYWORD = 5;
  SCE_AU3_MACRO = 6;
  SCE_AU3_STRING = 7;
  SCE_AU3_OPERATOR = 8;
  SCE_AU3_VARIABLE = 9;
  SCE_AU3_SENT = 10;
  SCE_AU3_PREPROCESSOR = 11;
  SCE_AU3_SPECIAL = 12;
  SCE_AU3_EXPAND = 13;
  SCE_AU3_COMOBJ = 14;
  SCE_AU3_UDF = 15;

  /// <summary>Lexical states for SCLEX_APDL</summary>
  SCE_APDL_DEFAULT = 0;
  SCE_APDL_COMMENT = 1;
  SCE_APDL_COMMENTBLOCK = 2;
  SCE_APDL_NUMBER = 3;
  SCE_APDL_STRING = 4;
  SCE_APDL_OPERATOR = 5;
  SCE_APDL_WORD = 6;
  SCE_APDL_PROCESSOR = 7;
  SCE_APDL_COMMAND = 8;
  SCE_APDL_SLASHCOMMAND = 9;
  SCE_APDL_STARCOMMAND = 10;
  SCE_APDL_ARGUMENT = 11;
  SCE_APDL_FUNCTION = 12;

  /// <summary>Lexical states for SCLEX_BASH</summary>
  SCE_SH_DEFAULT = 0;
  SCE_SH_ERROR = 1;
  SCE_SH_COMMENTLINE = 2;
  SCE_SH_NUMBER = 3;
  SCE_SH_WORD = 4;
  SCE_SH_STRING = 5;
  SCE_SH_CHARACTER = 6;
  SCE_SH_OPERATOR = 7;
  SCE_SH_IDENTIFIER = 8;
  SCE_SH_SCALAR = 9;
  SCE_SH_PARAM = 10;
  SCE_SH_BACKTICKS = 11;
  SCE_SH_HERE_DELIM = 12;
  SCE_SH_HERE_Q = 13;

  /// <summary>Lexical states for SCLEX_ASN1</summary>
  SCE_ASN1_DEFAULT = 0;
  SCE_ASN1_COMMENT = 1;
  SCE_ASN1_IDENTIFIER = 2;
  SCE_ASN1_STRING = 3;
  SCE_ASN1_OID = 4;
  SCE_ASN1_SCALAR = 5;
  SCE_ASN1_KEYWORD = 6;
  SCE_ASN1_ATTRIBUTE = 7;
  SCE_ASN1_DESCRIPTOR = 8;
  SCE_ASN1_TYPE = 9;
  SCE_ASN1_OPERATOR = 10;

  /// <summary>Lexical states for SCLEX_VHDL</summary>
  SCE_VHDL_DEFAULT = 0;
  SCE_VHDL_COMMENT = 1;
  SCE_VHDL_COMMENTLINEBANG = 2;
  SCE_VHDL_NUMBER = 3;
  SCE_VHDL_STRING = 4;
  SCE_VHDL_OPERATOR = 5;
  SCE_VHDL_IDENTIFIER = 6;
  SCE_VHDL_STRINGEOL = 7;
  SCE_VHDL_KEYWORD = 8;
  SCE_VHDL_STDOPERATOR = 9;
  SCE_VHDL_ATTRIBUTE = 10;
  SCE_VHDL_STDFUNCTION = 11;
  SCE_VHDL_STDPACKAGE = 12;
  SCE_VHDL_STDTYPE = 13;
  SCE_VHDL_USERWORD = 14;

  /// <summary>Lexical states for SCLEX_CAML</summary>
  SCE_CAML_DEFAULT = 0;
  SCE_CAML_IDENTIFIER = 1;
  SCE_CAML_TAGNAME = 2;
  SCE_CAML_KEYWORD = 3;
  SCE_CAML_KEYWORD2 = 4;
  SCE_CAML_KEYWORD3 = 5;
  SCE_CAML_LINENUM = 6;
  SCE_CAML_OPERATOR = 7;
  SCE_CAML_NUMBER = 8;
  SCE_CAML_CHAR = 9;
  SCE_CAML_WHITE = 10;
  SCE_CAML_STRING = 11;
  SCE_CAML_COMMENT = 12;
  SCE_CAML_COMMENT1 = 13;
  SCE_CAML_COMMENT2 = 14;
  SCE_CAML_COMMENT3 = 15;

  /// <summary>Lexical states for SCLEX_HASKELL</summary>
  SCE_HA_DEFAULT = 0;
  SCE_HA_IDENTIFIER = 1;
  SCE_HA_KEYWORD = 2;
  SCE_HA_NUMBER = 3;
  SCE_HA_STRING = 4;
  SCE_HA_CHARACTER = 5;
  SCE_HA_CLASS = 6;
  SCE_HA_MODULE = 7;
  SCE_HA_CAPITAL = 8;
  SCE_HA_DATA = 9;
  SCE_HA_IMPORT = 10;
  SCE_HA_OPERATOR = 11;
  SCE_HA_INSTANCE = 12;
  SCE_HA_COMMENTLINE = 13;
  SCE_HA_COMMENTBLOCK = 14;
  SCE_HA_COMMENTBLOCK2 = 15;
  SCE_HA_COMMENTBLOCK3 = 16;
  SCE_HA_PRAGMA = 17;
  SCE_HA_PREPROCESSOR = 18;
  SCE_HA_STRINGEOL = 19;
  SCE_HA_RESERVED_OPERATOR = 20;
  SCE_HA_LITERATE_COMMENT = 21;
  SCE_HA_LITERATE_CODEDELIM = 22;

  /// <summary>Lexical states of SCLEX_TADS3</summary>
  SCE_T3_DEFAULT = 0;
  SCE_T3_X_DEFAULT = 1;
  SCE_T3_PREPROCESSOR = 2;
  SCE_T3_BLOCK_COMMENT = 3;
  SCE_T3_LINE_COMMENT = 4;
  SCE_T3_OPERATOR = 5;
  SCE_T3_KEYWORD = 6;
  SCE_T3_NUMBER = 7;
  SCE_T3_IDENTIFIER = 8;
  SCE_T3_S_STRING = 9;
  SCE_T3_D_STRING = 10;
  SCE_T3_X_STRING = 11;
  SCE_T3_LIB_DIRECTIVE = 12;
  SCE_T3_MSG_PARAM = 13;
  SCE_T3_HTML_TAG = 14;
  SCE_T3_HTML_DEFAULT = 15;
  SCE_T3_HTML_STRING = 16;
  SCE_T3_USER1 = 17;
  SCE_T3_USER2 = 18;
  SCE_T3_USER3 = 19;
  SCE_T3_BRACE = 20;

  /// <summary>Lexical states for SCLEX_REBOL</summary>
  SCE_REBOL_DEFAULT = 0;
  SCE_REBOL_COMMENTLINE = 1;
  SCE_REBOL_COMMENTBLOCK = 2;
  SCE_REBOL_PREFACE = 3;
  SCE_REBOL_OPERATOR = 4;
  SCE_REBOL_CHARACTER = 5;
  SCE_REBOL_QUOTEDSTRING = 6;
  SCE_REBOL_BRACEDSTRING = 7;
  SCE_REBOL_NUMBER = 8;
  SCE_REBOL_PAIR = 9;
  SCE_REBOL_TUPLE = 10;
  SCE_REBOL_BINARY = 11;
  SCE_REBOL_MONEY = 12;
  SCE_REBOL_ISSUE = 13;
  SCE_REBOL_TAG = 14;
  SCE_REBOL_FILE = 15;
  SCE_REBOL_EMAIL = 16;
  SCE_REBOL_URL = 17;
  SCE_REBOL_DATE = 18;
  SCE_REBOL_TIME = 19;
  SCE_REBOL_IDENTIFIER = 20;
  SCE_REBOL_WORD = 21;
  SCE_REBOL_WORD2 = 22;
  SCE_REBOL_WORD3 = 23;
  SCE_REBOL_WORD4 = 24;
  SCE_REBOL_WORD5 = 25;
  SCE_REBOL_WORD6 = 26;
  SCE_REBOL_WORD7 = 27;
  SCE_REBOL_WORD8 = 28;

  /// <summary>Lexical states for SCLEX_SQL</summary>
  SCE_SQL_DEFAULT = 0;
  SCE_SQL_COMMENT = 1;
  SCE_SQL_COMMENTLINE = 2;
  SCE_SQL_COMMENTDOC = 3;
  SCE_SQL_NUMBER = 4;
  SCE_SQL_WORD = 5;
  SCE_SQL_STRING = 6;
  SCE_SQL_CHARACTER = 7;
  SCE_SQL_SQLPLUS = 8;
  SCE_SQL_SQLPLUS_PROMPT = 9;
  SCE_SQL_OPERATOR = 10;
  SCE_SQL_IDENTIFIER = 11;
  SCE_SQL_SQLPLUS_COMMENT = 13;
  SCE_SQL_COMMENTLINEDOC = 15;
  SCE_SQL_WORD2 = 16;
  SCE_SQL_COMMENTDOCKEYWORD = 17;
  SCE_SQL_COMMENTDOCKEYWORDERROR = 18;
  SCE_SQL_USER1 = 19;
  SCE_SQL_USER2 = 20;
  SCE_SQL_USER3 = 21;
  SCE_SQL_USER4 = 22;
  SCE_SQL_QUOTEDIDENTIFIER = 23;

  /// <summary>Lexical states for SCLEX_SMALLTALK</summary>
  SCE_ST_DEFAULT = 0;
  SCE_ST_STRING = 1;
  SCE_ST_NUMBER = 2;
  SCE_ST_COMMENT = 3;
  SCE_ST_SYMBOL = 4;
  SCE_ST_BINARY = 5;
  SCE_ST_BOOL = 6;
  SCE_ST_SELF = 7;
  SCE_ST_SUPER = 8;
  SCE_ST_NIL = 9;
  SCE_ST_GLOBAL = 10;
  SCE_ST_RETURN = 11;
  SCE_ST_SPECIAL = 12;
  SCE_ST_KWSEND = 13;
  SCE_ST_ASSIGN = 14;
  SCE_ST_CHARACTER = 15;
  SCE_ST_SPEC_SEL = 16;

  /// <summary>Lexical states for SCLEX_FLAGSHIP (clipper)</summary>
  SCE_FS_DEFAULT = 0;
  SCE_FS_COMMENT = 1;
  SCE_FS_COMMENTLINE = 2;
  SCE_FS_COMMENTDOC = 3;
  SCE_FS_COMMENTLINEDOC = 4;
  SCE_FS_COMMENTDOCKEYWORD = 5;
  SCE_FS_COMMENTDOCKEYWORDERROR = 6;
  SCE_FS_KEYWORD = 7;
  SCE_FS_KEYWORD2 = 8;
  SCE_FS_KEYWORD3 = 9;
  SCE_FS_KEYWORD4 = 10;
  SCE_FS_NUMBER = 11;
  SCE_FS_STRING = 12;
  SCE_FS_PREPROCESSOR = 13;
  SCE_FS_OPERATOR = 14;
  SCE_FS_IDENTIFIER = 15;
  SCE_FS_DATE = 16;
  SCE_FS_STRINGEOL = 17;
  SCE_FS_CONSTANT = 18;
  SCE_FS_WORDOPERATOR = 19;
  SCE_FS_DISABLEDCODE = 20;
  SCE_FS_DEFAULT_C = 21;
  SCE_FS_COMMENTDOC_C = 22;
  SCE_FS_COMMENTLINEDOC_C = 23;
  SCE_FS_KEYWORD_C = 24;
  SCE_FS_KEYWORD2_C = 25;
  SCE_FS_NUMBER_C = 26;
  SCE_FS_STRING_C = 27;
  SCE_FS_PREPROCESSOR_C = 28;
  SCE_FS_OPERATOR_C = 29;
  SCE_FS_IDENTIFIER_C = 30;
  SCE_FS_STRINGEOL_C = 31;

  /// <summary>Lexical states for SCLEX_CSOUND</summary>
  SCE_CSOUND_DEFAULT = 0;
  SCE_CSOUND_COMMENT = 1;
  SCE_CSOUND_NUMBER = 2;
  SCE_CSOUND_OPERATOR = 3;
  SCE_CSOUND_INSTR = 4;
  SCE_CSOUND_IDENTIFIER = 5;
  SCE_CSOUND_OPCODE = 6;
  SCE_CSOUND_HEADERSTMT = 7;
  SCE_CSOUND_USERKEYWORD = 8;
  SCE_CSOUND_COMMENTBLOCK = 9;
  SCE_CSOUND_PARAM = 10;
  SCE_CSOUND_ARATE_VAR = 11;
  SCE_CSOUND_KRATE_VAR = 12;
  SCE_CSOUND_IRATE_VAR = 13;
  SCE_CSOUND_GLOBAL_VAR = 14;
  SCE_CSOUND_STRINGEOL = 15;

  /// <summary>Lexical states for SCLEX_INNOSETUP</summary>
  SCE_INNO_DEFAULT = 0;
  SCE_INNO_COMMENT = 1;
  SCE_INNO_KEYWORD = 2;
  SCE_INNO_PARAMETER = 3;
  SCE_INNO_SECTION = 4;
  SCE_INNO_PREPROC = 5;
  SCE_INNO_INLINE_EXPANSION = 6;
  SCE_INNO_COMMENT_PASCAL = 7;
  SCE_INNO_KEYWORD_PASCAL = 8;
  SCE_INNO_KEYWORD_USER = 9;
  SCE_INNO_STRING_DOUBLE = 10;
  SCE_INNO_STRING_SINGLE = 11;
  SCE_INNO_IDENTIFIER = 12;

  /// <summary>Lexical states for SCLEX_OPAL</summary>
  SCE_OPAL_SPACE = 0;
  SCE_OPAL_COMMENT_BLOCK = 1;
  SCE_OPAL_COMMENT_LINE = 2;
  SCE_OPAL_INTEGER = 3;
  SCE_OPAL_KEYWORD = 4;
  SCE_OPAL_SORT = 5;
  SCE_OPAL_STRING = 6;
  SCE_OPAL_PAR = 7;
  SCE_OPAL_BOOL_CONST = 8;
  SCE_OPAL_DEFAULT = 32;

  /// <summary>Lexical states for SCLEX_SPICE</summary>
  SCE_SPICE_DEFAULT = 0;
  SCE_SPICE_IDENTIFIER = 1;
  SCE_SPICE_KEYWORD = 2;
  SCE_SPICE_KEYWORD2 = 3;
  SCE_SPICE_KEYWORD3 = 4;
  SCE_SPICE_NUMBER = 5;
  SCE_SPICE_DELIMITER = 6;
  SCE_SPICE_VALUE = 7;
  SCE_SPICE_COMMENTLINE = 8;

  /// <summary>Lexical states for SCLEX_CMAKE</summary>
  SCE_CMAKE_DEFAULT = 0;
  SCE_CMAKE_COMMENT = 1;
  SCE_CMAKE_STRINGDQ = 2;
  SCE_CMAKE_STRINGLQ = 3;
  SCE_CMAKE_STRINGRQ = 4;
  SCE_CMAKE_COMMANDS = 5;
  SCE_CMAKE_PARAMETERS = 6;
  SCE_CMAKE_VARIABLE = 7;
  SCE_CMAKE_USERDEFINED = 8;
  SCE_CMAKE_WHILEDEF = 9;
  SCE_CMAKE_FOREACHDEF = 10;
  SCE_CMAKE_IFDEFINEDEF = 11;
  SCE_CMAKE_MACRODEF = 12;
  SCE_CMAKE_STRINGVAR = 13;
  SCE_CMAKE_NUMBER = 14;

  /// <summary>Lexical states for SCLEX_GAP</summary>
  SCE_GAP_DEFAULT = 0;
  SCE_GAP_IDENTIFIER = 1;
  SCE_GAP_KEYWORD = 2;
  SCE_GAP_KEYWORD2 = 3;
  SCE_GAP_KEYWORD3 = 4;
  SCE_GAP_KEYWORD4 = 5;
  SCE_GAP_STRING = 6;
  SCE_GAP_CHAR = 7;
  SCE_GAP_OPERATOR = 8;
  SCE_GAP_COMMENT = 9;
  SCE_GAP_NUMBER = 10;
  SCE_GAP_STRINGEOL = 11;

  /// <summary>Lexical state for SCLEX_PLM</summary>
  SCE_PLM_DEFAULT = 0;
  SCE_PLM_COMMENT = 1;
  SCE_PLM_STRING = 2;
  SCE_PLM_NUMBER = 3;
  SCE_PLM_IDENTIFIER = 4;
  SCE_PLM_OPERATOR = 5;
  SCE_PLM_CONTROL = 6;
  SCE_PLM_KEYWORD = 7;

  /// <summary>Lexical state for SCLEX_PROGRESS</summary>
  SCE_4GL_DEFAULT = 0;
  SCE_4GL_NUMBER = 1;
  SCE_4GL_WORD = 2;
  SCE_4GL_STRING = 3;
  SCE_4GL_CHARACTER = 4;
  SCE_4GL_PREPROCESSOR = 5;
  SCE_4GL_OPERATOR = 6;
  SCE_4GL_IDENTIFIER = 7;
  SCE_4GL_BLOCK = 8;
  SCE_4GL_END = 9;
  SCE_4GL_COMMENT1 = 10;
  SCE_4GL_COMMENT2 = 11;
  SCE_4GL_COMMENT3 = 12;
  SCE_4GL_COMMENT4 = 13;
  SCE_4GL_COMMENT5 = 14;
  SCE_4GL_COMMENT6 = 15;
  SCE_4GL_DEFAULT_ = 16;
  SCE_4GL_NUMBER_ = 17;
  SCE_4GL_WORD_ = 18;
  SCE_4GL_STRING_ = 19;
  SCE_4GL_CHARACTER_ = 20;
  SCE_4GL_PREPROCESSOR_ = 21;
  SCE_4GL_OPERATOR_ = 22;
  SCE_4GL_IDENTIFIER_ = 23;
  SCE_4GL_BLOCK_ = 24;
  SCE_4GL_END_ = 25;
  SCE_4GL_COMMENT1_ = 26;
  SCE_4GL_COMMENT2_ = 27;
  SCE_4GL_COMMENT3_ = 28;
  SCE_4GL_COMMENT4_ = 29;
  SCE_4GL_COMMENT5_ = 30;
  SCE_4GL_COMMENT6_ = 31;

  /// <summary>Lexical states for SCLEX_ABAQUS</summary>
  SCE_ABAQUS_DEFAULT = 0;
  SCE_ABAQUS_COMMENT = 1;
  SCE_ABAQUS_COMMENTBLOCK = 2;
  SCE_ABAQUS_NUMBER = 3;
  SCE_ABAQUS_STRING = 4;
  SCE_ABAQUS_OPERATOR = 5;
  SCE_ABAQUS_WORD = 6;
  SCE_ABAQUS_PROCESSOR = 7;
  SCE_ABAQUS_COMMAND = 8;
  SCE_ABAQUS_SLASHCOMMAND = 9;
  SCE_ABAQUS_STARCOMMAND = 10;
  SCE_ABAQUS_ARGUMENT = 11;
  SCE_ABAQUS_FUNCTION = 12;

  /// <summary>Lexical states for SCLEX_ASYMPTOTE</summary>
  SCE_ASY_DEFAULT = 0;
  SCE_ASY_COMMENT = 1;
  SCE_ASY_COMMENTLINE = 2;
  SCE_ASY_NUMBER = 3;
  SCE_ASY_WORD = 4;
  SCE_ASY_STRING = 5;
  SCE_ASY_CHARACTER = 6;
  SCE_ASY_OPERATOR = 7;
  SCE_ASY_IDENTIFIER = 8;
  SCE_ASY_STRINGEOL = 9;
  SCE_ASY_COMMENTLINEDOC = 10;
  SCE_ASY_WORD2 = 11;

  /// <summary>Lexical states for SCLEX_R</summary>
  SCE_R_DEFAULT = 0;
  SCE_R_COMMENT = 1;
  SCE_R_KWORD = 2;
  SCE_R_BASEKWORD = 3;
  SCE_R_OTHERKWORD = 4;
  SCE_R_NUMBER = 5;
  SCE_R_STRING = 6;
  SCE_R_STRING2 = 7;
  SCE_R_OPERATOR = 8;
  SCE_R_IDENTIFIER = 9;
  SCE_R_INFIX = 10;
  SCE_R_INFIXEOL = 11;

  /// <summary>Lexical state for SCLEX_MAGIK</summary>
  SCE_MAGIK_DEFAULT = 0;
  SCE_MAGIK_COMMENT = 1;
  SCE_MAGIK_HYPER_COMMENT = 16;
  SCE_MAGIK_STRING = 2;
  SCE_MAGIK_CHARACTER = 3;
  SCE_MAGIK_NUMBER = 4;
  SCE_MAGIK_IDENTIFIER = 5;
  SCE_MAGIK_OPERATOR = 6;
  SCE_MAGIK_FLOW = 7;
  SCE_MAGIK_CONTAINER = 8;
  SCE_MAGIK_BRACKET_BLOCK = 9;
  SCE_MAGIK_BRACE_BLOCK = 10;
  SCE_MAGIK_SQBRACKET_BLOCK = 11;
  SCE_MAGIK_UNKNOWN_KEYWORD = 12;
  SCE_MAGIK_KEYWORD = 13;
  SCE_MAGIK_PRAGMA = 14;
  SCE_MAGIK_SYMBOL = 15;

  /// <summary>Lexical state for SCLEX_POWERSHELL</summary>
  SCE_POWERSHELL_DEFAULT = 0;
  SCE_POWERSHELL_COMMENT = 1;
  SCE_POWERSHELL_STRING = 2;
  SCE_POWERSHELL_CHARACTER = 3;
  SCE_POWERSHELL_NUMBER = 4;
  SCE_POWERSHELL_VARIABLE = 5;
  SCE_POWERSHELL_OPERATOR = 6;
  SCE_POWERSHELL_IDENTIFIER = 7;
  SCE_POWERSHELL_KEYWORD = 8;
  SCE_POWERSHELL_CMDLET = 9;
  SCE_POWERSHELL_ALIAS = 10;
  SCE_POWERSHELL_FUNCTION = 11;
  SCE_POWERSHELL_USER1 = 12;
  SCE_POWERSHELL_COMMENTSTREAM = 13;
  SCE_POWERSHELL_HERE_STRING = 14;
  SCE_POWERSHELL_HERE_CHARACTER = 15;
  SCE_POWERSHELL_COMMENTDOCKEYWORD = 16;

  /// <summary>Lexical state for SCLEX_MYSQL</summary>
  SCE_MYSQL_DEFAULT = 0;
  SCE_MYSQL_COMMENT = 1;
  SCE_MYSQL_COMMENTLINE = 2;
  SCE_MYSQL_VARIABLE = 3;
  SCE_MYSQL_SYSTEMVARIABLE = 4;
  SCE_MYSQL_KNOWNSYSTEMVARIABLE = 5;
  SCE_MYSQL_NUMBER = 6;
  SCE_MYSQL_MAJORKEYWORD = 7;
  SCE_MYSQL_KEYWORD = 8;
  SCE_MYSQL_DATABASEOBJECT = 9;
  SCE_MYSQL_PROCEDUREKEYWORD = 10;
  SCE_MYSQL_STRING = 11;
  SCE_MYSQL_SQSTRING = 12;
  SCE_MYSQL_DQSTRING = 13;
  SCE_MYSQL_OPERATOR = 14;
  SCE_MYSQL_FUNCTION = 15;
  SCE_MYSQL_IDENTIFIER = 16;
  SCE_MYSQL_QUOTEDIDENTIFIER = 17;
  SCE_MYSQL_USER1 = 18;
  SCE_MYSQL_USER2 = 19;
  SCE_MYSQL_USER3 = 20;
  SCE_MYSQL_HIDDENCOMMAND = 21;
  SCE_MYSQL_PLACEHOLDER = 22;

  /// <summary>Lexical state for SCLEX_PO</summary>
  SCE_PO_DEFAULT = 0;
  SCE_PO_COMMENT = 1;
  SCE_PO_MSGID = 2;
  SCE_PO_MSGID_TEXT = 3;
  SCE_PO_MSGSTR = 4;
  SCE_PO_MSGSTR_TEXT = 5;
  SCE_PO_MSGCTXT = 6;
  SCE_PO_MSGCTXT_TEXT = 7;
  SCE_PO_FUZZY = 8;
  SCE_PO_PROGRAMMER_COMMENT = 9;
  SCE_PO_REFERENCE = 10;
  SCE_PO_FLAGS = 11;
  SCE_PO_MSGID_TEXT_EOL = 12;
  SCE_PO_MSGSTR_TEXT_EOL = 13;
  SCE_PO_MSGCTXT_TEXT_EOL = 14;
  SCE_PO_ERROR = 15;

  /// <summary>Lexical states for SCLEX_PASCAL</summary>
  SCE_PAS_DEFAULT = 0;
  SCE_PAS_IDENTIFIER = 1;
  SCE_PAS_COMMENT = 2;
  SCE_PAS_COMMENT2 = 3;
  SCE_PAS_COMMENTLINE = 4;
  SCE_PAS_PREPROCESSOR = 5;
  SCE_PAS_PREPROCESSOR2 = 6;
  SCE_PAS_NUMBER = 7;
  SCE_PAS_HEXNUMBER = 8;
  SCE_PAS_WORD = 9;
  SCE_PAS_STRING = 10;
  SCE_PAS_STRINGEOL = 11;
  SCE_PAS_CHARACTER = 12;
  SCE_PAS_OPERATOR = 13;
  SCE_PAS_ASM = 14;

  /// <summary>Lexical state for SCLEX_SORCUS</summary>
  SCE_SORCUS_DEFAULT = 0;
  SCE_SORCUS_COMMAND = 1;
  SCE_SORCUS_PARAMETER = 2;
  SCE_SORCUS_COMMENTLINE = 3;
  SCE_SORCUS_STRING = 4;
  SCE_SORCUS_STRINGEOL = 5;
  SCE_SORCUS_IDENTIFIER = 6;
  SCE_SORCUS_OPERATOR = 7;
  SCE_SORCUS_NUMBER = 8;
  SCE_SORCUS_CONSTANT = 9;

  /// <summary>Lexical state for SCLEX_POWERPRO</summary>
  SCE_POWERPRO_DEFAULT = 0;
  SCE_POWERPRO_COMMENTBLOCK = 1;
  SCE_POWERPRO_COMMENTLINE = 2;
  SCE_POWERPRO_NUMBER = 3;
  SCE_POWERPRO_WORD = 4;
  SCE_POWERPRO_WORD2 = 5;
  SCE_POWERPRO_WORD3 = 6;
  SCE_POWERPRO_WORD4 = 7;
  SCE_POWERPRO_DOUBLEQUOTEDSTRING = 8;
  SCE_POWERPRO_SINGLEQUOTEDSTRING = 9;
  SCE_POWERPRO_LINECONTINUE = 10;
  SCE_POWERPRO_OPERATOR = 11;
  SCE_POWERPRO_IDENTIFIER = 12;
  SCE_POWERPRO_STRINGEOL = 13;
  SCE_POWERPRO_VERBATIM = 14;
  SCE_POWERPRO_ALTQUOTE = 15;
  SCE_POWERPRO_FUNCTION = 16;

  /// <summary>Lexical states for SCLEX_SML</summary>
  SCE_SML_DEFAULT = 0;
  SCE_SML_IDENTIFIER = 1;
  SCE_SML_TAGNAME = 2;
  SCE_SML_KEYWORD = 3;
  SCE_SML_KEYWORD2 = 4;
  SCE_SML_KEYWORD3 = 5;
  SCE_SML_LINENUM = 6;
  SCE_SML_OPERATOR = 7;
  SCE_SML_NUMBER = 8;
  SCE_SML_CHAR = 9;
  SCE_SML_STRING = 11;
  SCE_SML_COMMENT = 12;
  SCE_SML_COMMENT1 = 13;
  SCE_SML_COMMENT2 = 14;
  SCE_SML_COMMENT3 = 15;

  /// <summary>Lexical state for SCLEX_MARKDOWN</summary>
  SCE_MARKDOWN_DEFAULT = 0;
  SCE_MARKDOWN_LINE_BEGIN = 1;
  SCE_MARKDOWN_STRONG1 = 2;
  SCE_MARKDOWN_STRONG2 = 3;
  SCE_MARKDOWN_EM1 = 4;
  SCE_MARKDOWN_EM2 = 5;
  SCE_MARKDOWN_HEADER1 = 6;
  SCE_MARKDOWN_HEADER2 = 7;
  SCE_MARKDOWN_HEADER3 = 8;
  SCE_MARKDOWN_HEADER4 = 9;
  SCE_MARKDOWN_HEADER5 = 10;
  SCE_MARKDOWN_HEADER6 = 11;
  SCE_MARKDOWN_PRECHAR = 12;
  SCE_MARKDOWN_ULIST_ITEM = 13;
  SCE_MARKDOWN_OLIST_ITEM = 14;
  SCE_MARKDOWN_BLOCKQUOTE = 15;
  SCE_MARKDOWN_STRIKEOUT = 16;
  SCE_MARKDOWN_HRULE = 17;
  SCE_MARKDOWN_LINK = 18;
  SCE_MARKDOWN_CODE = 19;
  SCE_MARKDOWN_CODE2 = 20;
  SCE_MARKDOWN_CODEBK = 21;

  /// <summary>Lexical state for SCLEX_TXT2TAGS</summary>
  SCE_TXT2TAGS_DEFAULT = 0;
  SCE_TXT2TAGS_LINE_BEGIN = 1;
  SCE_TXT2TAGS_STRONG1 = 2;
  SCE_TXT2TAGS_STRONG2 = 3;
  SCE_TXT2TAGS_EM1 = 4;
  SCE_TXT2TAGS_EM2 = 5;
  SCE_TXT2TAGS_HEADER1 = 6;
  SCE_TXT2TAGS_HEADER2 = 7;
  SCE_TXT2TAGS_HEADER3 = 8;
  SCE_TXT2TAGS_HEADER4 = 9;
  SCE_TXT2TAGS_HEADER5 = 10;
  SCE_TXT2TAGS_HEADER6 = 11;
  SCE_TXT2TAGS_PRECHAR = 12;
  SCE_TXT2TAGS_ULIST_ITEM = 13;
  SCE_TXT2TAGS_OLIST_ITEM = 14;
  SCE_TXT2TAGS_BLOCKQUOTE = 15;
  SCE_TXT2TAGS_STRIKEOUT = 16;
  SCE_TXT2TAGS_HRULE = 17;
  SCE_TXT2TAGS_LINK = 18;
  SCE_TXT2TAGS_CODE = 19;
  SCE_TXT2TAGS_CODE2 = 20;
  SCE_TXT2TAGS_CODEBK = 21;
  SCE_TXT2TAGS_COMMENT = 22;
  SCE_TXT2TAGS_OPTION = 23;
  SCE_TXT2TAGS_PREPROC = 24;
  SCE_TXT2TAGS_POSTPROC = 25;

  /// <summary>Lexical states for SCLEX_A68K</summary>
  SCE_A68K_DEFAULT = 0;
  SCE_A68K_COMMENT = 1;
  SCE_A68K_NUMBER_DEC = 2;
  SCE_A68K_NUMBER_BIN = 3;
  SCE_A68K_NUMBER_HEX = 4;
  SCE_A68K_STRING1 = 5;
  SCE_A68K_OPERATOR = 6;
  SCE_A68K_CPUINSTRUCTION = 7;
  SCE_A68K_EXTINSTRUCTION = 8;
  SCE_A68K_REGISTER = 9;
  SCE_A68K_DIRECTIVE = 10;
  SCE_A68K_MACRO_ARG = 11;
  SCE_A68K_LABEL = 12;
  SCE_A68K_STRING2 = 13;
  SCE_A68K_IDENTIFIER = 14;
  SCE_A68K_MACRO_DECLARATION = 15;
  SCE_A68K_COMMENT_WORD = 16;
  SCE_A68K_COMMENT_SPECIAL = 17;
  SCE_A68K_COMMENT_DOXYGEN = 18;

  /// <summary>Lexical states for SCLEX_MODULA</summary>
  SCE_MODULA_DEFAULT = 0;
  SCE_MODULA_COMMENT = 1;
  SCE_MODULA_DOXYCOMM = 2;
  SCE_MODULA_DOXYKEY = 3;
  SCE_MODULA_KEYWORD = 4;
  SCE_MODULA_RESERVED = 5;
  SCE_MODULA_NUMBER = 6;
  SCE_MODULA_BASENUM = 7;
  SCE_MODULA_FLOAT = 8;
  SCE_MODULA_STRING = 9;
  SCE_MODULA_STRSPEC = 10;
  SCE_MODULA_CHAR = 11;
  SCE_MODULA_CHARSPEC = 12;
  SCE_MODULA_PROC = 13;
  SCE_MODULA_PRAGMA = 14;
  SCE_MODULA_PRGKEY = 15;
  SCE_MODULA_OPERATOR = 16;
  SCE_MODULA_BADSTR = 17;

  /// <summary>Lexical states for SCLEX_COFFEESCRIPT</summary>
  SCE_COFFEESCRIPT_DEFAULT = 0;
  SCE_COFFEESCRIPT_COMMENT = 1;
  SCE_COFFEESCRIPT_COMMENTLINE = 2;
  SCE_COFFEESCRIPT_COMMENTDOC = 3;
  SCE_COFFEESCRIPT_NUMBER = 4;
  SCE_COFFEESCRIPT_WORD = 5;
  SCE_COFFEESCRIPT_STRING = 6;
  SCE_COFFEESCRIPT_CHARACTER = 7;
  SCE_COFFEESCRIPT_UUID = 8;
  SCE_COFFEESCRIPT_PREPROCESSOR = 9;
  SCE_COFFEESCRIPT_OPERATOR = 10;
  SCE_COFFEESCRIPT_IDENTIFIER = 11;
  SCE_COFFEESCRIPT_STRINGEOL = 12;
  SCE_COFFEESCRIPT_VERBATIM = 13;
  SCE_COFFEESCRIPT_REGEX = 14;
  SCE_COFFEESCRIPT_COMMENTLINEDOC = 15;
  SCE_COFFEESCRIPT_WORD2 = 16;
  SCE_COFFEESCRIPT_COMMENTDOCKEYWORD = 17;
  SCE_COFFEESCRIPT_COMMENTDOCKEYWORDERROR = 18;
  SCE_COFFEESCRIPT_GLOBALCLASS = 19;
  SCE_COFFEESCRIPT_STRINGRAW = 20;
  SCE_COFFEESCRIPT_TRIPLEVERBATIM = 21;
  SCE_COFFEESCRIPT_COMMENTBLOCK = 22;
  SCE_COFFEESCRIPT_VERBOSE_REGEX = 23;
  SCE_COFFEESCRIPT_VERBOSE_REGEX_COMMENT = 24;

  /// <summary>Lexical states for SCLEX_AVS</summary>
  SCE_AVS_DEFAULT = 0;
  SCE_AVS_COMMENTBLOCK = 1;
  SCE_AVS_COMMENTBLOCKN = 2;
  SCE_AVS_COMMENTLINE = 3;
  SCE_AVS_NUMBER = 4;
  SCE_AVS_OPERATOR = 5;
  SCE_AVS_IDENTIFIER = 6;
  SCE_AVS_STRING = 7;
  SCE_AVS_TRIPLESTRING = 8;
  SCE_AVS_KEYWORD = 9;
  SCE_AVS_FILTER = 10;
  SCE_AVS_PLUGIN = 11;
  SCE_AVS_FUNCTION = 12;
  SCE_AVS_CLIPPROP = 13;
  SCE_AVS_USERDFN = 14;

  /// <summary>Lexical states for SCLEX_ECL</summary>
  SCE_ECL_DEFAULT = 0;
  SCE_ECL_COMMENT = 1;
  SCE_ECL_COMMENTLINE = 2;
  SCE_ECL_NUMBER = 3;
  SCE_ECL_STRING = 4;
  SCE_ECL_WORD0 = 5;
  SCE_ECL_OPERATOR = 6;
  SCE_ECL_CHARACTER = 7;
  SCE_ECL_UUID = 8;
  SCE_ECL_PREPROCESSOR = 9;
  SCE_ECL_UNKNOWN = 10;
  SCE_ECL_IDENTIFIER = 11;
  SCE_ECL_STRINGEOL = 12;
  SCE_ECL_VERBATIM = 13;
  SCE_ECL_REGEX = 14;
  SCE_ECL_COMMENTLINEDOC = 15;
  SCE_ECL_WORD1 = 16;
  SCE_ECL_COMMENTDOCKEYWORD = 17;
  SCE_ECL_COMMENTDOCKEYWORDERROR = 18;
  SCE_ECL_WORD2 = 19;
  SCE_ECL_WORD3 = 20;
  SCE_ECL_WORD4 = 21;
  SCE_ECL_WORD5 = 22;
  SCE_ECL_COMMENTDOC = 23;
  SCE_ECL_ADDED = 24;
  SCE_ECL_DELETED = 25;
  SCE_ECL_CHANGED = 26;
  SCE_ECL_MOVED = 27;

  /// <summary>Lexical states for SCLEX_OSCRIPT</summary>
  SCE_OSCRIPT_DEFAULT = 0;
  SCE_OSCRIPT_LINE_COMMENT = 1;
  SCE_OSCRIPT_BLOCK_COMMENT = 2;
  SCE_OSCRIPT_DOC_COMMENT = 3;
  SCE_OSCRIPT_PREPROCESSOR = 4;
  SCE_OSCRIPT_NUMBER = 5;
  SCE_OSCRIPT_SINGLEQUOTE_STRING = 6;
  SCE_OSCRIPT_DOUBLEQUOTE_STRING = 7;
  SCE_OSCRIPT_CONSTANT = 8;
  SCE_OSCRIPT_IDENTIFIER = 9;
  SCE_OSCRIPT_GLOBAL = 10;
  SCE_OSCRIPT_KEYWORD = 11;
  SCE_OSCRIPT_OPERATOR = 12;
  SCE_OSCRIPT_LABEL = 13;
  SCE_OSCRIPT_TYPE = 14;
  SCE_OSCRIPT_FUNCTION = 15;
  SCE_OSCRIPT_OBJECT = 16;
  SCE_OSCRIPT_PROPERTY = 17;
  SCE_OSCRIPT_METHOD = 18;

  /// <summary>Lexical states for SCLEX_VISUALPROLOG</summary>
  SCE_VISUALPROLOG_DEFAULT = 0;
  SCE_VISUALPROLOG_KEY_MAJOR = 1;
  SCE_VISUALPROLOG_KEY_MINOR = 2;
  SCE_VISUALPROLOG_KEY_DIRECTIVE = 3;
  SCE_VISUALPROLOG_COMMENT_BLOCK = 4;
  SCE_VISUALPROLOG_COMMENT_LINE = 5;
  SCE_VISUALPROLOG_COMMENT_KEY = 6;
  SCE_VISUALPROLOG_COMMENT_KEY_ERROR = 7;
  SCE_VISUALPROLOG_IDENTIFIER = 8;
  SCE_VISUALPROLOG_VARIABLE = 9;
  SCE_VISUALPROLOG_ANONYMOUS = 10;
  SCE_VISUALPROLOG_NUMBER = 11;
  SCE_VISUALPROLOG_OPERATOR = 12;
  SCE_VISUALPROLOG_CHARACTER = 13;
  SCE_VISUALPROLOG_CHARACTER_TOO_MANY = 14;
  SCE_VISUALPROLOG_CHARACTER_ESCAPE_ERROR = 15;
  SCE_VISUALPROLOG_STRING = 16;
  SCE_VISUALPROLOG_STRING_ESCAPE = 17;
  SCE_VISUALPROLOG_STRING_ESCAPE_ERROR = 18;
  SCE_VISUALPROLOG_STRING_EOL_OPEN = 19;
  SCE_VISUALPROLOG_STRING_VERBATIM = 20;
  SCE_VISUALPROLOG_STRING_VERBATIM_SPECIAL = 21;
  SCE_VISUALPROLOG_STRING_VERBATIM_EOL = 22;

  /// <summary>Lexical states for SCLEX_STTXT</summary>
  SCE_STTXT_DEFAULT = 0;
  SCE_STTXT_COMMENT = 1;
  SCE_STTXT_COMMENTLINE = 2;
  SCE_STTXT_KEYWORD = 3;
  SCE_STTXT_TYPE = 4;
  SCE_STTXT_FUNCTION = 5;
  SCE_STTXT_FB = 6;
  SCE_STTXT_NUMBER = 7;
  SCE_STTXT_HEXNUMBER = 8;
  SCE_STTXT_PRAGMA = 9;
  SCE_STTXT_OPERATOR = 10;
  SCE_STTXT_CHARACTER = 11;
  SCE_STTXT_STRING1 = 12;
  SCE_STTXT_STRING2 = 13;
  SCE_STTXT_STRINGEOL = 14;
  SCE_STTXT_IDENTIFIER = 15;
  SCE_STTXT_DATETIME = 16;
  SCE_STTXT_VARS = 17;
  SCE_STTXT_PRAGMAS = 18;

  /// <summary>Lexical states for SCLEX_KVIRC</summary>
  SCE_KVIRC_DEFAULT = 0;
  SCE_KVIRC_COMMENT = 1;
  SCE_KVIRC_COMMENTBLOCK = 2;
  SCE_KVIRC_STRING = 3;
  SCE_KVIRC_WORD = 4;
  SCE_KVIRC_KEYWORD = 5;
  SCE_KVIRC_FUNCTION_KEYWORD = 6;
  SCE_KVIRC_FUNCTION = 7;
  SCE_KVIRC_VARIABLE = 8;
  SCE_KVIRC_NUMBER = 9;
  SCE_KVIRC_OPERATOR = 10;
  SCE_KVIRC_STRING_FUNCTION = 11;
  SCE_KVIRC_STRING_VARIABLE = 12;

  /// <summary>Lexical states for SCLEX_RUST</summary>
  SCE_RUST_DEFAULT = 0;
  SCE_RUST_COMMENTBLOCK = 1;
  SCE_RUST_COMMENTLINE = 2;
  SCE_RUST_COMMENTBLOCKDOC = 3;
  SCE_RUST_COMMENTLINEDOC = 4;
  SCE_RUST_NUMBER = 5;
  SCE_RUST_WORD = 6;
  SCE_RUST_WORD2 = 7;
  SCE_RUST_WORD3 = 8;
  SCE_RUST_WORD4 = 9;
  SCE_RUST_WORD5 = 10;
  SCE_RUST_WORD6 = 11;
  SCE_RUST_WORD7 = 12;
  SCE_RUST_STRING = 13;
  SCE_RUST_STRINGR = 14;
  SCE_RUST_CHARACTER = 15;
  SCE_RUST_OPERATOR = 16;
  SCE_RUST_IDENTIFIER = 17;
  SCE_RUST_LIFETIME = 18;
  SCE_RUST_MACRO = 19;
  SCE_RUST_LEXERROR = 20;

  /// <summary>Lexical states for SCLEX_DMAP</summary>
  SCE_DMAP_DEFAULT = 0;
  SCE_DMAP_COMMENT = 1;
  SCE_DMAP_NUMBER = 2;
  SCE_DMAP_STRING1 = 3;
  SCE_DMAP_STRING2 = 4;
  SCE_DMAP_STRINGEOL = 5;
  SCE_DMAP_OPERATOR = 6;
  SCE_DMAP_IDENTIFIER = 7;
  SCE_DMAP_WORD = 8;
  SCE_DMAP_WORD2 = 9;
  SCE_DMAP_WORD3 = 10;

  /// <summary>Lexical states for SCLEX_DMIS</summary>
  SCE_DMIS_DEFAULT = 0;
  SCE_DMIS_COMMENT = 1;
  SCE_DMIS_STRING = 2;
  SCE_DMIS_NUMBER = 3;
  SCE_DMIS_KEYWORD = 4;
  SCE_DMIS_MAJORWORD = 5;
  SCE_DMIS_MINORWORD = 6;
  SCE_DMIS_UNSUPPORTED_MAJOR = 7;
  SCE_DMIS_UNSUPPORTED_MINOR = 8;
  SCE_DMIS_LABEL = 9;

  /// <summary>Deprecated in 2.21
  /// The SC_CP_DBCS value can be used to indicate a DBCS mode for GTK+.</summary>
  SC_CP_DBCS = 1;

  /// <summary>Deprecated in 2.30
  /// In palette mode?</summary>
  SCI_GETUSEPALETTE = 2139;

  /// <summary>Deprecated in 2.30
  /// In palette mode, Scintilla uses the environment's palette calls to display
  /// more colours. This may lead to ugly displays.</summary>
  SCI_SETUSEPALETTE = 2039;

// </scigen>

implementation

end.

