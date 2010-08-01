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

unit DScintilla;

interface

uses
  DScintillaCustom, DScintillaTypes, DScintillaUtils,

  SysUtils, Classes, Messages, Graphics;

type

{ TDScintilla }

  TDScintilla = class(TDScintillaCustom)
  private
    FHelper: TDSciHelper;
    FLines: TDSciLines;

    FOnUpdateUI: TDSciUpdateUIEvent;
    FOnSavePointReached: TDSciSavePointReachedEvent;
    FOnZoom: TDSciZoomEvent;
    FOnUserListSelection: TDSciUserListSelectionEvent;
    FOnDwellEnd: TDSciDwellEndEvent;
    FOnPainted: TDSciPaintedEvent;
    FOnModifyAttemptRO: TDSciModifyAttemptROEvent;
    FOnAutoCCharDeleted: TDSciAutoCCharDeletedEvent;
    FOnAutoCCancelled: TDSciAutoCCancelledEvent;
    FOnModified: TDSciModifiedEvent;
    FOnStyleNeeded: TDSciStyleNeededEvent;
    FOnSavePointLeft: TDSciSavePointLeftEvent;
    FOnIndicatorRelease: TDSciIndicatorReleaseEvent;
    FOnNeedShown: TDSciNeedShownEvent;
    FOnMacroRecord: TDSciMacroRecordEvent;
    FOnCharAdded: TDSciCharAddedEvent;
    FOnCallTipClick: TDSciCallTipClickEvent;
    FOnHotSpotClick: TDSciHotSpotClickEvent;
    FOnURIDropped: TDSciURIDroppedEvent;
    FOnMarginClick: TDSciMarginClickEvent;
    FOnHotSpotDoubleClick: TDSciHotSpotDoubleClickEvent;
    FOnDwellStart: TDSciDwellStartEvent;
    FOnIndicatorClick: TDSciIndicatorClickEvent;
    FOnAutoCSelection: TDSciAutoCSelectionEvent;

    procedure SetLines(const Value: TDSciLines);

  protected
    /// <summary>Handles notification messages from Scintilla,
    /// only if using patched Scintilla (eg. DScintilla.dll/DSciLexer.dll)
    /// http://code.google.com/p/dscintilla/source/browse/trunk/Scintilla.patch.txt
    /// In other case you need handle it from parent window, see HandleWMNotify.</summary>
    procedure WMNotify(var AMessage: TWMNotify); message WM_NOTIFY;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    /// <summary>Handles Scintilla notification messages.
    /// Returns True, if message was handled.
    /// If returns False, you must pass-through message
    /// by calling inherited; see TDScintilla.WMNotify.
    ///
    /// You don't need to call that function if you are using
    /// patched Scintilla (eg. DScintilla.dll/DSciLexer.dll)
    /// http://code.google.com/p/dscintilla/source/browse/trunk/Scintilla.patch.txt
    /// In such case it's handled in TDScintilla.WMNotify
    ///
    /// In case if you want use original (unpatched) Scintilla,
    /// you must catch WM_NOTIFY from parent window of TDScintilla
    /// similar to TDScintilla.WMNotify:
    ///
    ///    If TDScintilla in directly on Form, you can write code like this:
    ///    procedure TForm1.WMNotify(var AMessage: TWMNotify);
    ///    begin
    ///      if not DScintilla1.HandleWMNotify(AMessage) then
    ///        inherited;
    ///    end;</summary>
    function HandleWMNotify(var AMessage: TWMNotify): Boolean;

  published

    property Lines: TDSciLines read FLines write SetLines;

    // Scintilla events - see documentation at http://www.scintilla.org/ScintillaDoc.html#Notifications

    property OnStyleNeeded: TDSciStyleNeededEvent read FOnStyleNeeded write FOnStyleNeeded;
    property OnCharAdded: TDSciCharAddedEvent read FOnCharAdded write FOnCharAdded;
    property OnSavePointReached: TDSciSavePointReachedEvent read FOnSavePointReached write FOnSavePointReached;
    property OnSavePointLeft: TDSciSavePointLeftEvent read FOnSavePointLeft write FOnSavePointLeft;
    property OnModifyAttemptRO: TDSciModifyAttemptROEvent read FOnModifyAttemptRO write FOnModifyAttemptRO;
    property OnUpdateUI: TDSciUpdateUIEvent read FOnUpdateUI write FOnUpdateUI;
    property OnModified: TDSciModifiedEvent read FOnModified write FOnModified;
    property OnMacroRecord: TDSciMacroRecordEvent read FOnMacroRecord write FOnMacroRecord;
    property OnMarginClick: TDSciMarginClickEvent read FOnMarginClick write FOnMarginClick;
    property OnNeedShown: TDSciNeedShownEvent read FOnNeedShown write FOnNeedShown;
    property OnPainted: TDSciPaintedEvent read FOnPainted write FOnPainted;
    property OnUserListSelection: TDSciUserListSelectionEvent read FOnUserListSelection write FOnUserListSelection;
    property OnURIDropped: TDSciURIDroppedEvent read FOnURIDropped write FOnURIDropped;
    property OnDwellStart: TDSciDwellStartEvent read FOnDwellStart write FOnDwellStart;
    property OnDwellEnd: TDSciDwellEndEvent read FOnDwellEnd write FOnDwellEnd;
    property OnZoom: TDSciZoomEvent read FOnZoom write FOnZoom;
    property OnHotSpotClick: TDSciHotSpotClickEvent read FOnHotSpotClick write FOnHotSpotClick;
    property OnHotSpotDoubleClick: TDSciHotSpotDoubleClickEvent read FOnHotSpotDoubleClick write FOnHotSpotDoubleClick;
    property OnCallTipClick: TDSciCallTipClickEvent read FOnCallTipClick write FOnCallTipClick;
    property OnAutoCSelection: TDSciAutoCSelectionEvent read FOnAutoCSelection write FOnAutoCSelection;
    property OnIndicatorClick: TDSciIndicatorClickEvent read FOnIndicatorClick write FOnIndicatorClick;
    property OnIndicatorRelease: TDSciIndicatorReleaseEvent read FOnIndicatorRelease write FOnIndicatorRelease;
    property OnAutoCCancelled: TDSciAutoCCancelledEvent read FOnAutoCCancelled write FOnAutoCCancelled;
    property OnAutoCCharDeleted: TDSciAutoCCharDeletedEvent read FOnAutoCCharDeleted write FOnAutoCCharDeleted;
  end;

implementation

{ TDScintilla }

constructor TDScintilla.Create(AOwner: TComponent);
begin
  FHelper := TDSciHelper.Create(SendEditor);
  FLines := TDSciLines.Create(FHelper);

  inherited Create(AOwner);

  DllModule := cDSciLexerDll;
end;

destructor TDScintilla.Destroy;
begin
  FLines.Free;
  FHelper.Free;

  inherited Destroy;
end;

procedure TDScintilla.SetLines(const Value: TDSciLines);
begin
  FLines.Assign(Value);
end;

procedure TDScintilla.WMNotify(var AMessage: TWMNotify);
begin
  if not HandleWMNotify(AMessage) then
    inherited;
end;

function TDScintilla.HandleWMNotify(var AMessage: TWMNotify): Boolean;
var
  lSciNotify: PDSciSCNotification;
begin
  Result := HandleAllocated and (AMessage.NMHdr^.hwndFrom = Self.Handle);

  if not Result then
    Exit;

  lSciNotify := PDSciSCNotification(AMessage.NMHdr);

  case lSciNotify^.NotifyHeader.code of
  SCN_STYLENEEDED:
    if Assigned(FOnStyleNeeded) then
      FOnStyleNeeded(Self, lSciNotify^.position);

  SCN_CHARADDED:
    if Assigned(FOnCharAdded) then
      FOnCharAdded(Self, lSciNotify^.ch);

  SCN_SAVEPOINTREACHED:
    if Assigned(FOnSavePointReached) then
      FOnSavePointReached(Self);

  SCN_SAVEPOINTLEFT:
    if Assigned(FOnSavePointLeft) then
      FOnSavePointLeft(Self);

  SCN_MODIFYATTEMPTRO:
    if Assigned(FOnModifyAttemptRO) then
      FOnModifyAttemptRO(Self);

  SCN_UPDATEUI:
    if Assigned(FOnUpdateUI) then
      FOnUpdateUI(Self);

  SCN_MODIFIED:
    if Assigned(FOnModified) then
      FOnModified(Self, lSciNotify^.position, lSciNotify^.modificationType,
        FHelper.GetStrFromPtr(lSciNotify^.text), lSciNotify^.length, lSciNotify^.linesAdded, lSciNotify^.line,
        lSciNotify^.foldLevelNow, lSciNotify^.foldLevelPrev);

  SCN_MACRORECORD:
    if Assigned(FOnMacroRecord) then
      FOnMacroRecord(Self, lSciNotify^.message, lSciNotify^.wParam, lSciNotify^.lParam);

  SCN_MARGINCLICK:
    if Assigned(FOnMarginClick) then
      FOnMarginClick(Self, lSciNotify^.modifiers, lSciNotify^.position, lSciNotify^.margin);

  SCN_NEEDSHOWN:
    if Assigned(FOnNeedShown) then
      FOnNeedShown(Self, lSciNotify^.position, lSciNotify^.length);

  SCN_PAINTED:
    if Assigned(FOnPainted) then
      FOnPainted(Self);

  SCN_USERLISTSELECTION:
    if Assigned(FOnUserListSelection) then
      FOnUserListSelection(Self, lSciNotify^.listType, FHelper.GetStrFromPtr(lSciNotify^.text));

  SCN_URIDROPPED:
    if Assigned(FOnURIDropped) then
      FOnURIDropped(Self, FHelper.GetStrFromPtr(lSciNotify^.text));

  SCN_DWELLSTART:
    if Assigned(FOnDwellStart) then
      FOnDwellStart(Self, lSciNotify^.position);

  SCN_DWELLEND:
    if Assigned(FOnDwellEnd) then
      FOnDwellEnd(Self, lSciNotify^.position);

  SCN_ZOOM:
    if Assigned(FOnZoom) then
      FOnZoom(Self);

  SCN_HOTSPOTCLICK:
    if Assigned(FOnHotSpotClick) then
      FOnHotSpotClick(Self, lSciNotify^.modifiers, lSciNotify^.position);

  SCN_HOTSPOTDOUBLECLICK:
    if Assigned(FOnHotSpotDoubleClick) then
      FOnHotSpotDoubleClick(Self, lSciNotify^.modifiers, lSciNotify^.position);

  SCN_CALLTIPCLICK:
    if Assigned(FOnCallTipClick) then
      FOnCallTipClick(Self, lSciNotify^.position);

  SCN_AUTOCSELECTION:
    if Assigned(FOnAutoCSelection) then
      FOnAutoCSelection(Self, FHelper.GetStrFromPtr(lSciNotify^.text));

  SCN_INDICATORCLICK:
    if Assigned(FOnIndicatorClick) then
      FOnIndicatorClick(Self, lSciNotify^.modifiers, lSciNotify^.position);

  SCN_INDICATORRELEASE:
    if Assigned(FOnIndicatorRelease) then
      FOnIndicatorRelease(Self, lSciNotify^.modifiers, lSciNotify^.position);

  SCN_AUTOCCANCELLED:
    if Assigned(FOnAutoCCancelled) then
      FOnAutoCCancelled(Self);

  SCN_AUTOCCHARDELETED:
    if Assigned(FOnAutoCCharDeleted) then
      FOnAutoCCharDeleted(Self);
  end;
end;

end.

