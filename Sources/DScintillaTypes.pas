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
    rc: PRect;                        // Rectangle in which to print
    rcPage: PRect;                    // Physically printable page size
    chrg: TDSciCharacterRange;        // Range of characters to print
  end;

{ TDSciSCNotification }

  TDSciNotifyHeader = TNMHdr;

  PDSciSCNotification = ^TDSciSCNotification;
  TDSciSCNotification = record
    NotifyHeader: TDSciNotifyHeader;
    position: Integer;
    // SCN_STYLENEEDED, SCN_DOUBLECLICK, SCN_MODIFIED, SCN_DWELLSTART,
    // SCN_DWELLEND, SCN_CALLTIPCLICK,
    // SCN_HOTSPOTCLICK, SCN_HOTSPOTDOUBLECLICK
    ch: Integer;                // SCN_CHARADDED, SCN_KEY
    modifiers: Integer;         // SCN_KEY, SCN_DOUBLECLICK, SCN_HOTSPOTCLICK, SCN_HOTSPOTDOUBLECLICK
    modificationType: Integer;  // SCN_MODIFIED
    text: PAnsiChar;            // SCN_MODIFIED, SCN_USERLISTSELECTION, SCN_AUTOCSELECTION
    length: Integer;            // SCN_MODIFIED
    linesAdded: Integer;        // SCN_MODIFIED
    message: Integer;           // SCN_MACRORECORD
    wParam: Integer;            // SCN_MACRORECORD
    lParam: Integer;            // SCN_MACRORECORD
    line: Integer;              // SCN_MODIFIED, SCN_DOUBLECLICK
    foldLevelNow: Integer;      // SCN_MODIFIED
    foldLevelPrev: Integer;     // SCN_MODIFIED
    margin: Integer;            // SCN_MARGINCLICK
    listType: Integer;          // SCN_USERLISTSELECTION, SCN_AUTOCSELECTION
    x: Integer;                 // SCN_DWELLSTART, SCN_DWELLEND
    y: Integer;                 // SCN_DWELLSTART, SCN_DWELLEND
  end;

{ TDScintilla events }

  TDSciStyleNeededEvent = procedure(ASender: TObject; APosition: Integer) of object;
  TDSciCharAddedEvent = procedure(ASender: TObject; ACh: Integer) of object;
  TDSciSavePointReachedEvent = procedure(ASender: TObject) of object;
  TDSciSavePointLeftEvent = procedure(ASender: TObject) of object;
  TDSciModifyAttemptROEvent = procedure(ASender: TObject) of object;
  // # GTK+ Specific to work around focus and accelerator problems:
  // evt  Key=2005(Integer ch; Integer modifiers)
  // evt  DoubleClick=2006()
  TDSciUpdateUIEvent = procedure(ASender: TObject) of object;
  TDSciModifiedEvent = procedure(ASender: TObject; APosition: Integer; AModificationType: Integer;
    AText: String; ALength: Integer; ALinesAdded: Integer; ALine: Integer;
    AFoldLevelNow: Integer; AFoldLevelPrev: Integer) of object;
  TDSciMacroRecordEvent = procedure(ASender: TObject; AMessage: Integer; AWParam: Integer; ALParam: Integer) of object;
  TDSciMarginClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer; AMargin: Integer) of object;
  TDSciNeedShownEvent = procedure(ASender: TObject; APosition: Integer; ALength: Integer) of object;
  TDSciPaintedEvent = procedure(ASender: TObject) of object;
  TDSciUserListSelectionEvent = procedure(ASender: TObject; AListType: Integer; AText: String) of object;
  TDSciURIDroppedEvent = procedure(ASender: TObject; AText: String) of object;
  TDSciDwellStartEvent = procedure(ASender: TObject; APosition: Integer) of object;
  TDSciDwellEndEvent = procedure(ASender: TObject; APosition: Integer) of object;
  TDSciZoomEvent = procedure(ASender: TObject) of object;
  TDSciHotSpotClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciHotSpotDoubleClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciCallTipClickEvent = procedure(ASender: TObject; APosition: Integer) of object;
  TDSciAutoCSelectionEvent = procedure(ASender: TObject; AText: String) of object;
  TDSciIndicatorClickEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciIndicatorReleaseEvent = procedure(ASender: TObject; AModifiers: Integer; APosition: Integer) of object;
  TDSciAutoCCancelledEvent = procedure(ASender: TObject) of object;
  TDSciAutoCCharDeletedEvent = procedure(ASender: TObject) of object;

const

{ Scintilla event codes }

  SCN_STYLENEEDED        = 2000;
  SCN_CHARADDED          = 2001;
  SCN_SAVEPOINTREACHED   = 2002;
  SCN_SAVEPOINTLEFT      = 2003;
  SCN_MODIFYATTEMPTRO    = 2004;
  //# GTK+ Specific to work around focus and accelerator problems:
  //evt void Key           =2005(int ch, int modifiers)
  //evt void DoubleClick   =2006(void)
  SCN_UPDATEUI           = 2007;
  SCN_MODIFIED           = 2008;
  SCN_MACRORECORD        = 2009;
  SCN_MARGINCLICK        = 2010;
  SCN_NEEDSHOWN          = 2011;
  SCN_PAINTED            = 2013;
  SCN_USERLISTSELECTION  = 2014;
  SCN_URIDROPPED         = 2015;
  SCN_DWELLSTART         = 2016;
  SCN_DWELLEND           = 2017;
  SCN_ZOOM               = 2018;
  SCN_HOTSPOTCLICK       = 2019;
  SCN_HOTSPOTDOUBLECLICK = 2020;
  SCN_CALLTIPCLICK       = 2021;
  SCN_AUTOCSELECTION     = 2022;
  SCN_INDICATORCLICK     = 2023;
  SCN_INDICATORRELEASE   = 2024;
  SCN_AUTOCCANCELLED     = 2025;
  SCN_AUTOCCHARDELETED   = 2026;

const

{ Scintilla consts and method codes }

  INVALID_POSITION = -1;

  // TODO: SCI_Xxx codes

implementation

end.

