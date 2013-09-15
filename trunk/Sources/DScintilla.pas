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
 * Portions created by the Initial Developer are Copyright (C) 2010-2013
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 * - Michal Gajek
 * - Marko Njezic
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

  SysUtils, Classes, Messages, Graphics, Controls, Math;

type

{ TDScintilla }

  TDScintilla = class(TDScintillaCustom)
  private
    FHelper: TDSciHelper;
    FLines: TDSciLines;

    FStoredDocPointer: TDSciDocument;
    FInitDefaultsDelayed: Boolean;

    FOnInitDefaults: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnSCNotificationEvent: TDSciNotificationEvent;

    FOnUpdateUI: TDSciUpdateUIEvent;
    FOnSavePointReached: TDSciSavePointReachedEvent;
    FOnZoom: TDSciZoomEvent;
    FOnUserListSelection: TDSciUserListSelectionEvent;
    FOnUserListSelection2: TDSciUserListSelection2Event;
    FOnDwellEnd: TDSciDwellEndEvent;
    FOnPainted: TDSciPaintedEvent;
    FOnModifyAttemptRO: TDSciModifyAttemptROEvent;
    FOnAutoCCharDeleted: TDSciAutoCCharDeletedEvent;
    FOnAutoCCancelled: TDSciAutoCCancelledEvent;
    FOnModified: TDSciModifiedEvent;
    FOnModified2: TDSciModified2Event;
    FOnStyleNeeded: TDSciStyleNeededEvent;
    FOnSavePointLeft: TDSciSavePointLeftEvent;
    FOnIndicatorRelease: TDSciIndicatorReleaseEvent;
    FOnNeedShown: TDSciNeedShownEvent;
    FOnMacroRecord: TDSciMacroRecordEvent;
    FOnCharAdded: TDSciCharAddedEvent;
    FOnCallTipClick: TDSciCallTipClickEvent;
    FOnHotSpotClick: TDSciHotSpotClickEvent;
    FOnMarginClick: TDSciMarginClickEvent;
    FOnHotSpotDoubleClick: TDSciHotSpotDoubleClickEvent;
    FOnHotSpotReleaseClick: TDSciHotSpotReleaseClickEvent;
    FOnDwellStart: TDSciDwellStartEvent;
    FOnIndicatorClick: TDSciIndicatorClickEvent;
    FOnAutoCSelection: TDSciAutoCSelectionEvent;

    procedure SetLines(const Value: TDSciLines);

  protected
    procedure CreateWnd; override;
    procedure Loaded; override;

    /// <summary>Initializes Scintilla control after creating window</summary>
    procedure InitDefaults; virtual;
    procedure DoInitDefaults;

    /// <summary>Handles SCEN_CHANGE message from Scintilla</summary>
    procedure CNCommand(var AMessage: TWMCommand); message CN_COMMAND;

    /// <summary>Handles notification messages from Scintilla</summary>
    procedure CNNotify(var AMessage: TWMNotify); message CN_NOTIFY; // Thanks to Marko Njezic there is no need to patch Scintilla anymore :)

    procedure DoNeedShown(const ASCNotification: TDSciSCNotification); virtual;
    function DoSCNotification(const ASCNotification: TDSciSCNotification): Boolean; virtual;

    procedure WMCreate(var AMessage: TWMCreate); message WM_CREATE;
    procedure WMDestroy(var AMessage: TWMDestroy); message WM_DESTROY;

    procedure DoStoreDocState; virtual;
    procedure DoRestoreDocState; virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  public

    // -------------------------------------------------------------------------
    // Scintilla methods -------------------------------------------------------
    // -------------------------------------------------------------------------

    {$I DScintillaMethodsDecl.inc}

  public

    // -------------------------------------------------------------------------
    // Scintilla properties ----------------------------------------------------
    // -------------------------------------------------------------------------

    {$I DScintillaPropertiesDecl.inc}

    /// <summary>Calls TWinControl.SetFocus</summary>
    procedure SetFocus; reintroduce; overload;

    procedure EnsureRangeVisible(APosStart, APosEnd: Integer);

  published

    property Lines: TDSciLines read FLines write SetLines;

    property OnInitDefaults: TNotifyEvent read FOnInitDefaults write FOnInitDefaults;

    // Scintilla events - see documentation at http://www.scintilla.org/ScintillaDoc.html#Notifications

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnSCNotificationEvent: TDSciNotificationEvent read FOnSCNotificationEvent write FOnSCNotificationEvent;

    property OnStyleNeeded: TDSciStyleNeededEvent read FOnStyleNeeded write FOnStyleNeeded;
    property OnCharAdded: TDSciCharAddedEvent read FOnCharAdded write FOnCharAdded;
    property OnSavePointReached: TDSciSavePointReachedEvent read FOnSavePointReached write FOnSavePointReached;
    property OnSavePointLeft: TDSciSavePointLeftEvent read FOnSavePointLeft write FOnSavePointLeft;
    property OnModifyAttemptRO: TDSciModifyAttemptROEvent read FOnModifyAttemptRO write FOnModifyAttemptRO;
    property OnUpdateUI: TDSciUpdateUIEvent read FOnUpdateUI write FOnUpdateUI;
    property OnModified: TDSciModifiedEvent read FOnModified write FOnModified; // deprecated - use OnModified2
    property OnModified2: TDSciModified2Event read FOnModified2 write FOnModified2;
    property OnMacroRecord: TDSciMacroRecordEvent read FOnMacroRecord write FOnMacroRecord;
    property OnMarginClick: TDSciMarginClickEvent read FOnMarginClick write FOnMarginClick;

    // Note: if you are using OnNeedShown, then you must perform similar task as in DoNeedShown
    // In general you need to call EnsureRangeVisible(...)
    // See: https://code.google.com/p/dscintilla/issues/detail?id=4
    property OnNeedShown: TDSciNeedShownEvent read FOnNeedShown write FOnNeedShown;
    property OnPainted: TDSciPaintedEvent read FOnPainted write FOnPainted;
    property OnUserListSelection: TDSciUserListSelectionEvent read FOnUserListSelection write FOnUserListSelection; // deprecated - use OnUserListSelection2
    property OnUserListSelection2: TDSciUserListSelection2Event read FOnUserListSelection2 write FOnUserListSelection2;
    property OnDwellStart: TDSciDwellStartEvent read FOnDwellStart write FOnDwellStart;
    property OnDwellEnd: TDSciDwellEndEvent read FOnDwellEnd write FOnDwellEnd;
    property OnZoom: TDSciZoomEvent read FOnZoom write FOnZoom;
    property OnHotSpotClick: TDSciHotSpotClickEvent read FOnHotSpotClick write FOnHotSpotClick;
    property OnHotSpotDoubleClick: TDSciHotSpotDoubleClickEvent read FOnHotSpotDoubleClick write FOnHotSpotDoubleClick;
    property OnHotSpotReleaseClick: TDSciHotSpotReleaseClickEvent read FOnHotSpotReleaseClick write FOnHotSpotReleaseClick;
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
end;

destructor TDScintilla.Destroy;
begin
  Assert(FStoredDocPointer = nil);

  inherited Destroy;

  FreeAndNil(FLines);
  FreeAndNil(FHelper);
end;

procedure TDScintilla.SetLines(const Value: TDSciLines);
begin
  FLines.Assign(Value);
end;

procedure TDScintilla.WMCreate(var AMessage: TWMCreate);
begin
  inherited;

  // Restore document state, if it was stored in WMDestroy
  if FStoredDocPointer <> nil then
    DoRestoreDocState;
end;

procedure TDScintilla.WMDestroy(var AMessage: TWMDestroy);
begin
  // We can only store document state, if we know that window will be recreaded
  // Designer destroying window with csRecreating, but later destroys class,
  // so skip that case
  if {$IF Defined(csRecreating)}(csRecreating in ControlState) and{$IFEND}
    not (csDestroying in ComponentState) and
    not (csDesigning in ComponentState)
  then
    DoStoreDocState;

  inherited;
end;

procedure TDScintilla.DoStoreDocState;
begin
  FStoredDocPointer := GetDocPointer;
  if FStoredDocPointer <> nil then
    AddRefDocument(FStoredDocPointer);
end;

procedure TDScintilla.DoRestoreDocState;
begin
  SetDocPointer(FStoredDocPointer);

  ReleaseDocument(FStoredDocPointer);
  FStoredDocPointer := nil;
end;

procedure TDScintilla.CreateWnd;
begin
  inherited CreateWnd;

  // Set UTF8 early, so Lines with non ANSI char loads from .dfm correctly
  // Later in InitDefaults/OnInitDefaults can be overwritten
  SetCodePage(SC_CP_UTF8);

  // Delay calling DoInitDefaults when loading component from .dfm
  // OnInitDefaults might not be set yet, so you can miss this event
  FInitDefaultsDelayed := csLoading in ComponentState;
  if not FInitDefaultsDelayed then
    DoInitDefaults;
end;

procedure TDScintilla.Loaded;
begin
  inherited Loaded;

  if FInitDefaultsDelayed then
  begin
    FInitDefaultsDelayed := False;
    DoInitDefaults;
  end;
end;

procedure TDScintilla.InitDefaults;
begin
  // By default set Unicode-UTF8 mode
  SetKeysUnicode(True);
  SetCodePage(SC_CP_UTF8);
end;

procedure TDScintilla.DoInitDefaults;
begin
  InitDefaults;

  { If anywhere in the parent control hierarchy a reparenting operation
    is performed, this can lead to the Scintilla handle being destroyed
    (and later recreated). This in turn leads to loss of styles etc.,
    which is pretty bad. This event gives the caller a chance to
    reinitialize all that stuff. }
  if Assigned(OnInitDefaults) then
    OnInitDefaults(Self);
end;

procedure TDScintilla.CNNotify(var AMessage: TWMNotify);
begin
  if HandleAllocated and (AMessage.NMHdr^.hwndFrom = Self.Handle) then
    DoSCNotification(PDSciSCNotification(AMessage.NMHdr)^)
  else
    inherited;
end;

procedure TDScintilla.CNCommand(var AMessage: TWMCommand);
begin
  if AMessage.NotifyCode = SCEN_CHANGE then
  begin
    if Assigned(OnChange) then
      OnChange(Self);
  end else
    inherited;
end;

procedure TDScintilla.DoNeedShown(const ASCNotification: TDSciSCNotification);
begin
  if Assigned(FOnNeedShown) then
    FOnNeedShown(Self, ASCNotification.position, ASCNotification.length)
  else
  begin
    // Fix for: https://code.google.com/p/dscintilla/issues/detail?id=4
    //
    // SciTE does same thing: scite/src/SciTEBase.cxx ... case SCN_NEEDSHOWN: { ...
    // Also docs tells that it need to be done:
    // http://www.scintilla.org/ScintillaDoc.html#SCN_NEEDSHOWN
    EnsureRangeVisible(ASCNotification.position, ASCNotification.position + ASCNotification.length);
  end;
end;

function TDScintilla.DoSCNotification(const ASCNotification: TDSciSCNotification): Boolean;
begin
  Result := False;

  if Assigned(FOnSCNotificationEvent) then
    FOnSCNotificationEvent(Self, ASCNotification, Result);

  if Result then
    Exit;

  Result := True;

  case ASCNotification.NotifyHeader.code of
  SCN_STYLENEEDED:
    if Assigned(FOnStyleNeeded) then
      FOnStyleNeeded(Self, ASCNotification.position);

  SCN_CHARADDED:
    if Assigned(FOnCharAdded) then
      FOnCharAdded(Self, ASCNotification.ch);

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
      FOnUpdateUI(Self, ASCNotification.updated);

  SCN_MODIFIED:
    begin
      if Assigned(FOnModified) then
        FOnModified(Self, ASCNotification.position, ASCNotification.modificationType,
          FHelper.GetStrFromPtr(ASCNotification.text), ASCNotification.length,
          ASCNotification.linesAdded, ASCNotification.line,
          ASCNotification.foldLevelNow, ASCNotification.foldLevelPrev);

      if Assigned(FOnModified2) then
        FOnModified2(Self, ASCNotification.position, ASCNotification.modificationType,
          FHelper.GetStrFromPtr(ASCNotification.text), ASCNotification.length,
          ASCNotification.linesAdded, ASCNotification.line,
          ASCNotification.foldLevelNow, ASCNotification.foldLevelPrev,
          ASCNotification.token, ASCNotification.annotationLinesAdded);
    end;

  SCN_MACRORECORD:
    if Assigned(FOnMacroRecord) then
      FOnMacroRecord(Self, ASCNotification.message, ASCNotification.wParam,
        ASCNotification.lParam);

  SCN_MARGINCLICK:
    if Assigned(FOnMarginClick) then
      FOnMarginClick(Self, ASCNotification.modifiers,
        ASCNotification.position, ASCNotification.margin);

  SCN_NEEDSHOWN:
    DoNeedShown(ASCNotification);

  SCN_PAINTED:
    if Assigned(FOnPainted) then
      FOnPainted(Self);

  SCN_USERLISTSELECTION:
    begin
      if Assigned(FOnUserListSelection) then
        FOnUserListSelection(Self, ASCNotification.listType,
          FHelper.GetStrFromPtr(ASCNotification.text));

      if Assigned(FOnUserListSelection2) then
        FOnUserListSelection2(Self, ASCNotification.listType,
          FHelper.GetStrFromPtr(ASCNotification.text),
          ASCNotification.position);
    end;

  SCN_DWELLSTART:
    if Assigned(FOnDwellStart) then
      FOnDwellStart(Self, ASCNotification.position, ASCNotification.x, ASCNotification.y);

  SCN_DWELLEND:
    if Assigned(FOnDwellEnd) then
      FOnDwellEnd(Self, ASCNotification.position, ASCNotification.x, ASCNotification.y);

  SCN_ZOOM:
    if Assigned(FOnZoom) then
      FOnZoom(Self);

  SCN_HOTSPOTCLICK:
    if Assigned(FOnHotSpotClick) then
      FOnHotSpotClick(Self, ASCNotification.modifiers, ASCNotification.position);

  SCN_HOTSPOTDOUBLECLICK:
    if Assigned(FOnHotSpotDoubleClick) then
      FOnHotSpotDoubleClick(Self, ASCNotification.modifiers, ASCNotification.position);

  SCN_HOTSPOTRELEASECLICK:
    if Assigned(FOnHotSpotReleaseClick) then
      FOnHotSpotReleaseClick(Self, ASCNotification.modifiers, ASCNotification.position);

  SCN_CALLTIPCLICK:
    if Assigned(FOnCallTipClick) then
      FOnCallTipClick(Self, ASCNotification.position);

  SCN_AUTOCSELECTION:
    if Assigned(FOnAutoCSelection) then
      FOnAutoCSelection(Self, FHelper.GetStrFromPtr(ASCNotification.text),
        ASCNotification.lParam);

  SCN_INDICATORCLICK:
    if Assigned(FOnIndicatorClick) then
      FOnIndicatorClick(Self, ASCNotification.modifiers, ASCNotification.position);

  SCN_INDICATORRELEASE:
    if Assigned(FOnIndicatorRelease) then
      FOnIndicatorRelease(Self, ASCNotification.modifiers, ASCNotification.position);

  SCN_AUTOCCANCELLED:
    if Assigned(FOnAutoCCancelled) then
      FOnAutoCCancelled(Self);

  SCN_AUTOCCHARDELETED:
    if Assigned(FOnAutoCCharDeleted) then
      FOnAutoCCharDeleted(Self);
  else
    Result := False;
  end;
end;

// -----------------------------------------------------------------------------
// Scintilla methods -----------------------------------------------------------
// -----------------------------------------------------------------------------

{$I DScintillaMethodsCode.inc}

// -----------------------------------------------------------------------------
// Scintilla properties --------------------------------------------------------
// -----------------------------------------------------------------------------

{$I DScintillaPropertiesCode.inc}

procedure TDScintilla.SetFocus;
begin
  inherited SetFocus;
end;

procedure TDScintilla.EnsureRangeVisible(APosStart, APosEnd: Integer);
var
  lLineStart, lLineEnd, lLine: Integer;
begin
  lLineStart := LineFromPosition(Min(APosStart, APosEnd));
  lLineEnd := LineFromPosition(Max(APosStart, APosEnd));

  for lLine := lLineStart to lLineEnd do
    EnsureVisible(lLine);
end;

end.

