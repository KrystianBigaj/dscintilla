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
 * Portions created by the Initial Developer are Copyright (C) 2010-2011
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

unit DScintillaCustom;

interface

uses
  Windows, Classes, SysUtils, Controls, Messages;

const
  cDScintillaDll  = 'Scintilla.dll';
  cDSciLexerDll   = 'SciLexer.dll';

type

{ TDScintillaCustom }

  TDScintillaMethod = (smWindows, smDirect);

  TDScintillaFunction = function(APointer: Pointer; AMessage: Integer; WParam: Integer; LParam: Integer): Integer; cdecl;

  TDScintillaCustom = class(TWinControl)
  private
    FSciDllHandle: HMODULE;
    FSciDllModule: String;

    FDirectPointer: Pointer;
    FDirectFunction: TDScintillaFunction;
    FAccessMethod: TDScintillaMethod;

    procedure SetSciDllModule(const Value: String);

  protected
    procedure CreateWnd; override;
    procedure CreateParams(var Params: TCreateParams); override;

    procedure RecreateWndIf;

    procedure WMEraseBkgnd(var AMessage: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var AMessage: TWMGetDlgCode); message WM_GETDLGCODE;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DefaultHandler(var Message); override;

    /// <summary>Sends message to Scintilla control.
    /// For list of commands see DScintillaTypes.pas and documentation at:
    /// http://www.scintilla.org/ScintillaDoc.html</summary>
    function SendEditor(AMessage: Integer; WParam: Integer = 0; LParam: Integer = 0): Integer;

  published

    /// <summary>Name of Scintilla Dll which will be used.
    /// Changing DllModule recreates control!</summary>
    property DllModule: String read FSciDllModule write SetSciDllModule;

    /// <summary>Access method to Scintilla contol. Note from documentation:
    /// On Windows, the message-passing scheme used to communicate
    /// between the container and Scintilla is mediated by the operating system
    /// SendMessage function and can lead to bad performance
    /// when calling intensively.
    ///
    /// By default TDScintilla uses smDirect mode</summary>
    property AccessMethod: TDScintillaMethod read FAccessMethod write FAccessMethod default smDirect;

  published
    // TControl properties
    property Anchors;
    property PopupMenu;

    // TWinControl properties
    property Align;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BorderWidth;
    property Ctl3D;
    property ParentCtl3D;

    // TControl events
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragOver;
    property OnDragDrop;
    property OnMouseDown;

    // OnMouseEnter/OnMouseLeave added in D2006
    {$IF CompilerVersion > 17}
    property OnMouseEnter;
    property OnMouseLeave;
    {$IFEND}
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;

    // TWinControl events
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

implementation

{ TDScintillaCustom }

constructor TDScintillaCustom.Create(AOwner: TComponent);
begin
  FSciDllModule := cDSciLexerDll;
  FAccessMethod := smDirect;

  inherited Create(AOwner);

  ControlStyle := ControlStyle
    + [csOpaque, csClickEvents, csDoubleClicks, csCaptureMouse, csReflector]
    - [csSetCaption, csAcceptsControls];

  Width := 320;
  Height := 240;
end;

destructor TDScintillaCustom.Destroy;
begin
  inherited Destroy;

  if FSciDllHandle <> 0 then
  try
    FreeLibrary(FSciDllHandle);
  finally
    FSciDllHandle := 0;
  end;
end;

procedure TDScintillaCustom.SetSciDllModule(const Value: String);
begin
  if Value = FSciDllModule then
    Exit;

  FSciDllModule := Value;

  RecreateWndIf;
end;

procedure TDScintillaCustom.CreateWnd;
const
  /// <summary>Retrieve a pointer to a function that processes messages for this Scintilla.</summary>
  SCI_GETDIRECTFUNCTION = 2184;

  /// <summary>Retrieve a pointer value to use as the first argument when calling
  /// the function returned by GetDirectFunction.</summary>
  SCI_GETDIRECTPOINTER = 2185;

begin
  FSciDllHandle := LoadLibrary(PChar(FSciDllModule));
  if FSciDllHandle = 0 then
    RaiseLastOSError;

  inherited CreateWnd;

  FDirectFunction := TDScintillaFunction(Windows.SendMessage(
    Self.WindowHandle, SCI_GETDIRECTFUNCTION, 0, 0));
  FDirectPointer := Pointer(Windows.SendMessage(
    Self.WindowHandle, SCI_GETDIRECTPOINTER, 0, 0));
end;

procedure TDScintillaCustom.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  // Subclass Scintilla - WND Class was registred at DLL load proc
  CreateSubClass(Params, 'SCINTILLA');
end;

procedure TDScintillaCustom.RecreateWndIf;
begin
  if HandleAllocated then
    RecreateWnd;
end;

procedure TDScintillaCustom.WMEraseBkgnd(var AMessage: TWmEraseBkgnd);
begin
  if csDesigning in ComponentState then
    inherited
  else
    // Erase background not performed, prevent flickering
    AMessage.Result := 0;
end;

procedure TDScintillaCustom.WMGetDlgCode(var AMessage: TWMGetDlgCode);
begin
  inherited;

  // Allow key-codes like Enter, Tab, Arrows, and other to be passed to Scintilla
  AMessage.Result := AMessage.Result or DLGC_WANTARROWS or DLGC_WANTCHARS;
  AMessage.Result := AMessage.Result or DLGC_WANTTAB;
  AMessage.Result := AMessage.Result or DLGC_WANTALLKEYS;
end;

procedure TDScintillaCustom.DefaultHandler(var Message);
begin
  // In design mode there is an AV when clicking on control whithout this workaround
  // It's wParam HDC<>PAINTSTRUCT problem
  if {(csDesigning in ComponentState) and} (TMessage(Message).Msg = WM_PAINT) and (TMessage(Message).WParam <> 0) then
    TMessage(Message).WParam := 0;

  inherited;
end;

function TDScintillaCustom.SendEditor(AMessage: Integer; WParam: Integer; LParam: Integer): Integer;
begin
  HandleNeeded;

  if FAccessMethod = smWindows then
    Result := Windows.SendMessage(Self.Handle, AMessage, WParam, LParam)
  else
    Result := FDirectFunction(FDirectPointer, AMessage, WParam, LParam);
end;

end.

