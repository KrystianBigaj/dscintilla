{-----------------------------------------------------------------------------
 Unit Name: uIFGenForm
 Author:    Krystian
 Date:      28-lis-2009
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit uIFGenForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, uIFGen, ExtCtrls, CheckLst, Menus;

type
  TForm4 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    memIFace: TMemo;
    memTypes: TMemo;
    memProps: TMemo;
    btnRegen: TButton;
    TabSheet4: TTabSheet;
    cb: TCheckListBox;
    memCode: TMemo;
    edtDef: TEdit;
    chkShowHidden: TCheckBox;
    edtFilter: TEdit;
    tmrSearch: TTimer;
    chkConfigUnicode: TCheckBox;
    chkConfigDisabled: TCheckBox;
    chkConfigHidden: TCheckBox;
    btnDel: TButton;
    btnSave: TButton;
    chkOnlyEnums: TCheckBox;
    chkConfigEnumSet: TCheckBox;
    cfgDefaultValue: TEdit;
    cfgPara1Enum: TComboBox;
    cfgPara2Enum: TComboBox;
    cfgReturnEnum: TComboBox;
    memDoc: TMemo;
    memDef: TMemo;
    lblType: TLabel;
    chkConfigForcePublicProp: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PopupMenu1: TPopupMenu;
    ClearHideflagforallitems1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnRegenClick(Sender: TObject);
    procedure cbClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure chkShowHiddenClick(Sender: TObject);
    procedure cbClickCheck(Sender: TObject);
    procedure cbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure edtFilterChange(Sender: TObject);
    procedure tmrSearchTimer(Sender: TObject);
    procedure edtDefChange(Sender: TObject);
    procedure chkConfigClick(Sender: TObject);
    procedure cfgDefaultValueChange(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure cfgPara1EnumExit(Sender: TObject);
    procedure ClearHideflagforallitems1Click(Sender: TObject);
  private
    FLoading: Boolean;
    FSciGen: TSciGen;
    procedure RegenerateSciCode;

    function GetFNName: String;

    procedure RefreshCB;
  end;

var
  Form4: TForm4;

implementation

uses
  StrUtils;

resourcestring
  rsTKBScintilla = 'TDScintilla';

{$R *.dfm}

const
  cSCI_IFACE = 'Scintilla.iface';
  cSCI_TYPES = '..\Sources\DScintillaTypes.pas';
  cSCI_API = '..\Sources\DScintilla.pas';
  cSCI_API_INCs = '..\Sources\DScintilla';

const
  cSCI_MARKER_BEGIN = '{$REGION ''SciGen.%s''}';
  cSCI_MARKER_END = '{$ENDREGION}';

function ReplaceMarker(AList: TStrings; AMarkerLineBegin, AMarkerLineEnd: String; ACode: String): Boolean;
var
  lIdx: Integer;
begin
  // Find begin marker
  lIdx := 0;

  while (lIdx < AList.Count) and (Trim(AList[lIdx]) <> AMarkerLineBegin) do
    Inc(lIdx);

  // If not found, then exit
  Result := lIdx < AList.Count;

  if not Result then
    Exit;

  Inc(lIdx);

  // Add generated tag

//  AList.Insert(lIdx, Format('%s// Generated %s', [
//    StringOfChar(' ', Length(AList[lIdx - 1]) - Length(TrimLeft(AList[lIdx - 1]))), // Indent same as marker
//    DateTimeToStr(Now)
//  ]));

  Inc(lIdx);

  // Remove to end marker

  while (lIdx < AList.Count) and (Trim(AList[lIdx]) <> AMarkerLineEnd) do
    AList.Delete(lIdx);

  // Add code
  AList.Insert(lIdx, '');
  Inc(lIdx);

  ACode := StringReplace(ACode, '%s', rsTKBScintilla, [rfReplaceAll]);
  AList.Insert(lIdx, ACode);
end;

procedure TForm4.btnDelClick(Sender: TObject);
begin
  if FLoading then
    Exit;

  if cb.ItemIndex > -1 then
    if DeleteFile(GetCustomFile(cb.Items[cb.ItemIndex])) then
      RefreshCB;
end;

procedure TForm4.btnSaveClick(Sender: TObject);
var
  lSL: TStringList;
begin
  if FLoading then
    Exit;

  if cb.ItemIndex = -1 then
    Exit;

  lSL := TStringList.Create;
  try
    lSL.Add(Trim(edtDef.Text));
    lSL.AddStrings(memCode.Lines);

    lSL.SaveToFile(GetCustomFile(cb.Items[cb.ItemIndex]));
  finally
    lSL.Free;
  end;

  RefreshCB;
end;

procedure TForm4.btnRegenClick(Sender: TObject);
begin
  RegenerateSciCode;
end;

procedure TForm4.cbClick(Sender: TObject);
var
  lGen: TSciGen;
  lName: String;
  lItem: TSciGen.TCodeItem;

  function AdIf(N, S: String): String;
  begin
    if S = '' then
      Exit('');

    Result := Format('%s%s%s', [N, sLineBreak, S]);
  end;

begin
  if FLoading then
    Exit;

  FLoading := True;
  try
    edtDef.Clear;
    memCode.Clear;
    memDoc.Clear;
    memDef.Clear;
    btnSave.Enabled := False;
    btnDel.Enabled := False;
    edtDef.Font.Color := clWindowText;
    memCode.Font.Color := clWindowText;

    chkConfigUnicode.Enabled := False;
    chkConfigDisabled.Enabled := False;
    chkConfigHidden.Enabled := False;
    chkConfigEnumSet.Enabled := False;
    chkConfigForcePublicProp.Enabled := False;
    cfgDefaultValue.Enabled := False;
    cfgPara1Enum.Enabled := False;
    cfgPara2Enum.Enabled := False;
    cfgReturnEnum.Enabled := False;

    chkConfigUnicode.Checked := False;
    chkConfigDisabled.Checked := False;
    chkConfigHidden.Checked := False;
    chkConfigEnumSet.Checked := False;
    chkConfigForcePublicProp.Checked := False;
    cfgDefaultValue.Text := '';
    cfgPara1Enum.Text := '';
    cfgPara2Enum.Text := '';
    cfgReturnEnum.Text := '';

    lblType.Caption := '';

    if cb.ItemIndex = -1 then
      Exit;

    lName := cb.Items[cb.ItemIndex];

    for lItem in FSciGen.Code do
      if lName = lItem.ItemName then
      begin
        lGen := TSciGen.Create;
        try
          lGen.AddCodeItem(lItem, False);
{$IFNDEF SIMPLE_WRAPPER}
          lGen.SecondPass;
{$ENDIF}

          edtDef.Text := Trim(lGen.ProtectedDef +{or} lGen.PublicDef);

          memDef.Text :=
            AdIf('ProtectedDef', lGen.ProtectedDef)
            + AdIf('PublicDef', lGen.PublicDef)
{$IFNDEF SIMPLE_WRAPPER}
            + AdIf('PublishedDef', lGen.PublishedDef)
{$ENDIF}
            + AdIf('PublicPropertesDef', lGen.PublicPropertesDef)
{$IFNDEF SIMPLE_WRAPPER}
            + AdIf('PublishedPropertesDef', lGen.PublishedPropertesDef)
            + AdIf('EnumsDef', lGen.EnumsDef)
            + AdIf('EnumsCodeDef', lGen.EnumsCodeDef)
{$ENDIF}
            ;

          memCode.Text :=
            lGen.ProtectedCode
            + lGen.PublicCode
{$IFNDEF SIMPLE_WRAPPER}
            + lGen.EnumsCodeDecl
{$ENDIF}
            ;

          memDoc.Text := lItem.Doc;
        finally
          lGen.Free;
        end;

        btnSave.Enabled := True;
        btnDel.Enabled := FileExists(GetCustomFile(lItem.ItemName));

        case lItem.CodeType of
        ctFunc:
          lblType.Caption := 'Function';
        ctProc:
          lblType.Caption := 'Procedure';
        ctGet:
          lblType.Caption := 'Getter';
        ctSet:
          lblType.Caption := 'Setter';
        ctEnu:
          lblType.Caption := 'Enum';
        end;

        chkConfigUnicode.Enabled := True;
        chkConfigDisabled.Enabled := True;
        chkConfigHidden.Enabled := True;
        chkConfigEnumSet.Enabled := True;
        chkConfigForcePublicProp.Enabled := True;
        cfgDefaultValue.Enabled := True;
        cfgPara1Enum.Enabled := True;
        cfgPara2Enum.Enabled := True;
        cfgReturnEnum.Enabled := True;

        chkConfigUnicode.Checked := TSciGen.GetValue(lItem.ItemName, chkConfigUnicode.Hint) = '1';
        chkConfigDisabled.Checked := TSciGen.GetValue(lItem.ItemName, chkConfigDisabled.Hint) = '1';
        chkConfigHidden.Checked := TSciGen.GetValue(lItem.ItemName, chkConfigHidden.Hint) = '1';
        chkConfigEnumSet.Checked := TSciGen.GetValue(lItem.ItemName, chkConfigEnumSet.Hint) = '1';
        chkConfigForcePublicProp.Checked := TSciGen.GetValue(lItem.ItemName, chkConfigForcePublicProp.Hint) = '1';

        cfgDefaultValue.Text := TSciGen.GetValue(lItem.ItemName, cfgDefaultValue.Hint);

        cfgPara1Enum.Text := TSciGen.GetValue(lItem.ItemName, cfgPara1Enum.Hint);
        cfgPara2Enum.Text := TSciGen.GetValue(lItem.ItemName, cfgPara2Enum.Hint);
        cfgReturnEnum.Text := TSciGen.GetValue(lItem.ItemName, cfgReturnEnum.Hint);
      end;

      _SaveFS;
  finally
    FLoading := False;
  end;
end;

procedure TForm4.cbClickCheck(Sender: TObject);
begin
  if cb.ItemIndex = -1 then
    Exit;

  if cb.Checked[cb.ItemIndex] then
    btnSave.Click
  else
    btnDel.Click;
end;

procedure TForm4.cbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  lItem: TSciGen.TCodeItem;
begin
  lItem := cb.Items.Objects[Index] as TSciGen.TCodeItem;

  if (lItem.CodeType = ctProc) and not lItem.Param1.IsSet and not lItem.Param2.IsSet then
    cb.Canvas.Brush.Color := clLime;

  if chkShowHidden.Checked then
    if TSciGen.GetValue(cb.Items[Index], 'Hidden') = '1' then
      cb.Canvas.Font.Color := clGrayText;

  if lItem.CodeType = ctEnu then
    cb.Canvas.Font.Style := cb.Canvas.Font.Style + [fsBold];

  if TSciGen.GetValue(cb.Items[Index], 'Disabled') = '1' then
    cb.Canvas.Font.Style := cb.Canvas.Font.Style + [fsStrikeOut];

  cb.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, cb.Items[Index]);
end;

procedure TForm4.cfgDefaultValueChange(Sender: TObject);
begin
  if FLoading then
    Exit;

  TSciGen.SetValue(
    GetFNName,
    TEdit(Sender).Hint,
    TEdit(Sender).Text
  );

  RefreshCB;
  cb.Invalidate;
end;

procedure TForm4.cfgPara1EnumExit(Sender: TObject);
begin
  if FLoading then
    Exit;

  TSciGen.SetValue(
    GetFNName,
    TComboBox(Sender).Hint,
    TComboBox(Sender).Text
  );

  RefreshCB;
  cb.Invalidate;
end;

procedure TForm4.chkConfigClick(Sender: TObject);

  function BoolToStr(B: Boolean): String;
  begin
    if B then
      Result := '1'
    else
      Result := '';
  end;

begin
  if FLoading then
    Exit;

  TSciGen.SetValue(
    GetFNName,
    TCheckBox(Sender).Hint,
    BoolToStr(TCheckBox(Sender).Checked)
  );

  RefreshCB;
  cb.Invalidate;
end;

procedure TForm4.chkShowHiddenClick(Sender: TObject);
begin
  if FLoading then
    Exit;

  RefreshCB;
end;

procedure TForm4.ClearHideflagforallitems1Click(Sender: TObject);
var
  lItem: TSciGen.TCodeItem;
begin
  if MessageBox(0, 'Are you sure?', '', MB_YESNO) = ID_NO then
    Exit;


  for lItem in FSciGen.Code do
    TSciGen.SetValue(lItem.ItemName, 'Hidden', '');

  RefreshCB;
end;

procedure TForm4.edtDefChange(Sender: TObject);
var
  lStr: String;
begin
  if FLoading then
    Exit;

  edtDef.Font.Color := clRed;
  memCode.Font.Color := clRed;

  if Sender = edtDef then
  begin
    lStr := edtDef.Text;
    Insert('TDScintilla.', lStr, Pos(' ', lStr) + 1);

    memCode.Lines[0] := lStr;
  end;
end;

procedure TForm4.edtFilterChange(Sender: TObject);
begin
  tmrSearch.Enabled := False;

  if edtFilter.Text = '' then
    RefreshCB
  else
    tmrSearch.Enabled := True;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  RegenerateSciCode;
end;

procedure TForm4.FormDeactivate(Sender: TObject);
begin
//  edtDef.SetFocus;
end;

function TForm4.GetFNName: String;
begin
  if cb.ItemIndex = -1 then
    Result := ''
  else
    Result := cb.Items[cb.ItemIndex];
end;

procedure SaveStringToFile(Name: String; S: String);
begin
  S := StringReplace(S, '%s', rsTKBScintilla, [rfReplaceAll]);
  with TStringStream.Create(S) do
  try
    SaveToFile(cSCI_API_INCs + Name + '.inc');
  finally
    Free;
  end;
end;

procedure TForm4.RegenerateSciCode;
var
  lFile: TStringList;
begin
  btnRegen.Enabled := False;
  try
    FreeAndNil(FSciGen);

    FSciGen := GetDelphiCode(cSCI_IFACE);

    memIFace.Lines.LoadFromFile(cSCI_IFACE);
    lFile := TStringList.Create;
    try
      lFile.LoadFromFile(cSCI_TYPES);
      ReplaceMarker(lFile, '// <scigen>', '// </scigen>', FSciGen.ConstDef);
//      ReplaceMarker(lFile, 'Enums', FSciGen.EnumsDef);
//      ReplaceMarker(lFile, 'EnumsUtils', FSciGen.EnumsCodeDef);
//      ReplaceMarker(lFile, 'EnumsUtils.Code', FSciGen.EnumsCodeDecl);
      lFile.SaveToFile(cSCI_TYPES);
    finally
      lFile.Free;
    end;

//    lFile := TStringList.Create;
//    try
//      lFile.LoadFromFile(cSCI_API);
//      ReplaceMarker(lFile, 'Properties', FSciGen.ProtectedDef);
//      ReplaceMarker(lFile, 'Methods', FSciGen.PublicDef);
//      ReplaceMarker(lFile, 'PublicPropertes', FSciGen.PublicPropertesDef);
//      ReplaceMarker(lFile, 'PublishedPropertes', FSciGen.PublishedPropertesDef);
//
//      ReplaceMarker(lFile, 'Properties.Code', FSciGen.ProtectedCode);
//      ReplaceMarker(lFile, 'Methods.Code', FSciGen.PublicCode);

      SaveStringToFile('PropertiesDecl', FSciGen.ProtectedDef);
      SaveStringToFile('MethodsDecl', FSciGen.PublicDef);

      SaveStringToFile('PropertiesCode', FSciGen.ProtectedCode);
      SaveStringToFile('MethodsCode', FSciGen.PublicCode);
//
//      lFile.SaveToFile(cSCI_API);
//    finally
//      lFile.Free;
//    end;

    memTypes.Lines.LoadFromFile(cSCI_TYPES);
    memProps.Lines.LoadFromFile(cSCI_API);

    RefreshCB;
  finally
    btnRegen.Enabled := True;
  end;
end;

procedure TForm4.tmrSearchTimer(Sender: TObject);
begin
  tmrSearch.Enabled := False;

  RefreshCB;
end;

procedure TForm4.RefreshCB;
var
  lItem: TSciGen.TCodeItem;
  lIdx: Integer;
  lOldStr: String;
  lTopIdx: Integer;

  lSearch: Boolean;
  lSearchStr: String;
begin
  if FLoading then
    Exit;

  cb.Items.BeginUpdate;
  try
    FLoading := True;

    lIdx := cb.ItemIndex;
    lTopIdx := cb.TopIndex;
    if lIdx > -1 then
      lOldStr := cb.Items[lIdx]
    else
      lOldStr := '';

    cb.Items.Clear;

    lSearchStr := UpperCase(edtFilter.Text);
    lSearch := lSearchStr <> '';

    cfgPara1Enum.Items.Assign(FSciGen.EnumNames);
    cfgPara2Enum.Items.Assign(FSciGen.EnumNames);
    cfgReturnEnum.Items.Assign(FSciGen.EnumNames);

    for lItem in FSciGen.Code do
      if not lSearch or (Pos(lSearchStr, UpperCase(lItem.ItemName)) > 0) then
        if chkShowHidden.Checked or not (TSciGen.GetValue(lItem.ItemName, 'Hidden') = '1') then
          if not chkOnlyEnums.Checked or (lItem.CodeType = ctEnu) then
            cb.Checked[cb.Items.AddObject(lItem.ItemName, lItem)] :=
              FileExists(GetCustomFile(lItem.ItemName));

    if lIdx >= cb.Items.Count then
      Dec(lIdx);

    cb.TopIndex := lTopIdx;
    if lOldStr <> '' then
    begin
      lTopIdx := cb.Items.IndexOf(lOldStr);

      if lTopIdx > -1 then
        lIdx := lTopIdx;
    end;

    FLoading := False;
    cb.ItemIndex := lIdx;

    cbClick(nil);
  finally
    cb.Items.EndUpdate;

    FLoading := False;
  end;

  chkShowHidden.Caption := Format('Showing %d/%d', [cb.Items.Count, FSciGen.Code.Count]);
end;

end.

