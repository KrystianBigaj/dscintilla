{-----------------------------------------------------------------------------
 Unit Name: uIFGen
 Author:    Krystian
 Date:      28-lis-2009
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit uIFGen;

interface

uses
  Classes, SysUtils, Generics.Collections;

type
  TSciGen = class
  public
    type
      TConstItem = record
        ConstName: String;
        ConstValue: String;
      end;

      TConstsList = TList<TConstItem>;

      TCodeItem = class;
      TCodeList = class;

      TCodeParam = class
      private
        FIdx: Integer;
        function GetParamType: String;
      public
        Owner: TCodeItem;
        IsSet: Boolean;
        FParamType: String;
        ParamName: String;

        constructor Create(AOwner: TCodeItem; AIdx: Integer);

        property ParamType: String read GetParamType write FParamType;
      end;

      TSciEnums = TList<String>;

      TSciEnumVals = TList<TConstItem>;

      TCodeType = (ctFunc, ctProc, ctGet, ctSet, ctEnu);
      TCodeItem = class
      private
        function GetReturnType: String;
      public
        FReturnType: String;

        Owner: TCodeList;
        CodeType: TCodeType;
        ItemName: String;
        ItemIndex: String;
        ConstName: String;

        EnumNames: TSciEnums;
        EnumVals: TSciEnumVals;

        Param1: TCodeParam;
        Param2: TCodeParam;

        Doc: String;

        property ReturnType: String read GetReturnType write FReturnType;

        function GetPropertyName: String;

        function GetEnumItemName: String;

        function GetEnumPrefix: String;
        function GetEnumNameVal(AIndex: Integer; AChar1: Char = ' '; AChar2: Char = ','): String;

        function IsEnum(AName: String): String;
        function AddEnumValue(AItem: TConstItem): Boolean;

        constructor Create(AOwner: TCodeList);
        destructor Destroy; override;
      end;

      TCodePropItem = record
        GetCode: TCodeItem;
        SetCode: TCodeItem;

        ItemName: String;
      end;

      TCodeList = class(TList<TCodeItem>)
        procedure Notify(const Item: TCodeItem; Action: TCollectionNotification); override;
      end;
      TCodeProps = TDictionary<String, TCodePropItem>;
  private

    function GetCodeParams(const ACodeItem: TCodeItem): String;
  public
    FLastEnum: TCodeItem;

    ConstDef: String;

    EnumsDef: String;
    EnumsCodeDef: String;
    EnumsCodeDecl: String;
    EnumNames: TStringList;

    ProtectedDef: String;
    PublicDef: String;
    PublishedDef: String;
    PublicPropertesDef: String;
    PublishedPropertesDef: String;

    ProtectedCode: String;
    PublicCode: String;

    Consts: TConstsList;
    Code: TCodeList;
    Props: TCodeProps;


    constructor Create;
    destructor Destroy; override;

{$IFNDEF SIMPLE_WRAPPER}
    procedure SecondPass;
{$ENDIF}
    procedure AddCodeItem(const ACodeItem: TCodeItem; AAddDoc: Boolean = True);

    class function GetValue(AName, AFeature: String): String;
    class procedure SetValue(AName, AFeature, AValue: String);

    class function GetIsCustomFile(AName: String): Boolean;
  end;

function GetDelphiCode(ASciIFaceFile: String): TSciGen;

function GetCustomFile(AName: String): String;

procedure _SaveFS;

implementation

uses
  Windows, StrUtils, Character;

const
  rsCustomsCode = 'CustomCode\%s';
  rsFeaturesFile = '!FeaturesCfg.txt';

var
  _FeatureSL: TStringList;

function GetCustomFile(AName: String): String;
begin
  Result := Format(rsCustomsCode, [AName]);
end;

function GetDelphiCode(ASciIFaceFile: String): TSciGen;
type
  TTokenType = (ttNull, ttSpace, ttString, ttInt, ttHex, ttBraceOpen, ttBraceClose, ttEqual, ttComma,
    ttComment, ttDocComment);

  TTokenTypes = set of TTokenType;
var
  lIn: TStringList;
  lRes: TSciGen;

  lLine: String;
  lLineIdx: Integer;

  lToken: String;
  lTokenType: TTokenType;
  lTokenIdx: Integer;
  lLastLineVar: Boolean;

  lDocComment: String;

  function NextLine: Boolean;
  begin
    Result := lLineIdx < lIn.Count;

    if Result then
    begin
      lLine := lIn[lLineIdx];
      Inc(lLineIdx);

      lTokenIdx := 1;
      lTokenType := ttNull;
      lToken := '';
    end;
  end;

  function NextTokenWS: Boolean;
  var
    lStart: Integer;

    procedure SetToken(AType: TTokenType; ASingleChar: Boolean = False);
    begin
      if ASingleChar then
        Inc(lTokenIdx);

      lTokenType := AType;
      lToken := Copy(lLine, lStart, lTokenIdx - lStart);
    end;

  begin
    Result := lTokenIdx <= Length(lLine);

    if not Result then
    begin
      lToken := '';
      lTokenType := ttNull;
    end else
    begin
      lStart := lTokenIdx;

      case lLine[lTokenIdx] of
      ' ', #9:
        begin
          while (lTokenIdx <= Length(lLine)) and CharInSet(lLine[lTokenIdx], [' ', #9]) do
            Inc(lTokenIdx);

          SetToken(ttSpace);
        end;

      ',':
        SetToken(ttComma, True);

      '(':
        SetToken(ttBraceOpen, True);

      ')':
        SetToken(ttBraceClose, True);

      '=':
        SetToken(ttEqual, True);

      'a'..'z', 'A'..'Z':
        begin
          while (lTokenIdx <= Length(lLine)) and CharInSet(lLine[lTokenIdx], ['a'..'z', 'A'..'Z', '_', '0'..'9']) do
            Inc(lTokenIdx);

          SetToken(ttString);
        end;

      '-', '0'..'9':
        begin
          Inc(lTokenIdx);
          if (lTokenIdx <= Length(lLine)) and (lLine[lTokenIdx] = 'x') then
          begin
            Inc(lTokenIdx);
            lStart := lTokenIdx;

            while (lTokenIdx <= Length(lLine)) and CharInSet(lLine[lTokenIdx], ['0'..'9', 'a'..'f', 'A'..'F']) do
              Inc(lTokenIdx);

            SetToken(ttHex);
            lToken := '$' + lToken;
          end else
          begin
            while (lTokenIdx <= Length(lLine)) and CharInSet(lLine[lTokenIdx], ['0'..'9']) do
              Inc(lTokenIdx);

            SetToken(ttInt);
          end;
        end;

      '#':
        begin
          Inc(lTokenIdx);

          if lTokenIdx > Length(lLine) then
            raise Exception.Create('Parser: Unexpected # end!');

          case lLine[lTokenIdx] of
          '#':
            begin
              Inc(lTokenIdx, 2);
              lStart := lTokenIdx;

              lTokenIdx := Length(lLine) + 1;
              SetToken(ttComment);
            end;

          ' ':
            begin
              Inc(lTokenIdx);
              lStart := lTokenIdx;

              lTokenIdx := Length(lLine) + 1;
              SetToken(ttDocComment);
            end;
          else
            raise Exception.Create('Parser: Unexpected # next char!');
          end;

        end;
      else
        raise Exception.Create('Parser: Unexpected next char!');
      end;
    end;
  end;

  function NextToken: Boolean;
  begin
    repeat
      Result := NextTokenWS;

      if not Result then
        Break;
    until not (lTokenType in [ttSpace]);
  end;

  procedure ExceptToken(ATokens: TTokenTypes; AMoveNext: Boolean = True);
  begin
    if AMoveNext and not NextToken then
      if not (ttNull in ATokens) then
        raise Exception.Create('EOL!');

    if not (lTokenType in ATokens) then
      raise Exception.CreateFmt('Unexpected token "%s"', [lToken]);
  end;

  procedure SkipLine;
  begin
    while NextToken do
      ;
  end;

  procedure ParseCat;
  begin
    SkipLine;
  end;

  function GetDoc(AIndent: Integer; AClearDoc: Boolean): String;
  var
    lSL: TStringList;
    lIndent: String;
    lDocIdx: Integer;
  begin
    if lDocComment = '' then
      Exit('');

    lSL := TStringList.Create;
    try
      lIndent := StringOfChar(' ', AIndent);

      lSL.Text := lDocComment;
      if AClearDoc then
        lDocComment := '';

      Result := '';
      for lDocIdx := 0 to lSL.Count - 1 do
      begin
        Result := Result + lIndent + lSL[lDocIdx];

        if lDocIdx = lSL.Count - 1 then
          Result := Result + '</summary>';

        Result := Result + sLineBreak;
      end;


    finally
      lSL.Free;
    end;
  end;

  procedure AddConst(AName, AValue: String; AClearDoc: Boolean; ADocIndent: Integer);
  var
    lConts: TSciGen.TConstItem;
    lContsStr: String;
  begin
    lConts.ConstName := AName;
    lConts.ConstValue := AValue;

    lRes.Consts.Add(lConts);

    if lLastLineVar and (lDocComment <> '') then
      lRes.ConstDef := lRes.ConstDef + sLineBreak;

    lRes.ConstDef := lRes.ConstDef + GetDoc(ADocIndent, AClearDoc);
    lContsStr := Format('  %s = %s;%s', [lConts.ConstName, lConts.ConstValue, sLineBreak]);

//    OutputDebugString(PChar(lContsStr));
    lRes.ConstDef := lRes.ConstDef + lContsStr;

    if lRes.FLastEnum <> nil then
      lRes.FLastEnum.AddEnumValue(lConts);

    lLastLineVar := True;
  end;

  procedure ParseVal;
  var
    lName, lValue: String;
  begin
    ExceptToken([ttString]);
    lName := lToken;

    ExceptToken([ttEqual]);

    ExceptToken([ttInt, ttHex]);
    lValue := lToken;

    AddConst(lName, lValue, True, 2);
  end;

  procedure ParseCode;
  var
    lCodeItem: TSciGen.TCodeItem;
    lType: string;

    procedure ReadParam(ATokenType: TTokenType; var AParam: TSciGen.TCodeParam);
    begin
      NextToken;
      AParam.IsSet := lTokenType = ttString;
      if AParam.IsSet then
      begin
        AParam.ParamType := lToken;

        ExceptToken([ttString]);
        AParam.ParamName := lToken;
        AParam.ParamName[1] := UpCase(AParam.ParamName[1]);
        AParam.ParamName := 'A' + AParam.ParamName;

        ExceptToken([ATokenType]);
      end else
        ExceptToken([ATokenType], False);
    end;

  begin

    lType := lToken;

    ExceptToken([ttString]);
    lCodeItem := TSciGen.TCodeItem.Create(lRes.Code);
    lCodeItem.ReturnType := lToken;

    if lType = 'get' then
      lCodeItem.CodeType := ctGet
    else
      if lType = 'set' then
        lCodeItem.CodeType := ctSet
      else
        if lType = 'fun' then
        begin

          if lCodeItem.ReturnType = 'void' then
            lCodeItem.CodeType := ctProc
          else
            lCodeItem.CodeType := ctFunc;

        end;

    ExceptToken([ttString]);
    lCodeItem.ItemName := lToken;

    ExceptToken([ttEqual]);

    ExceptToken([ttInt]);
    lCodeItem.ItemIndex := lToken;

    lCodeItem.ConstName := Format('SCI_%s', [UpperCase(lCodeItem.ItemName)]);
    AddConst(lCodeItem.ConstName, lCodeItem.ItemIndex, False, 2);

    ExceptToken([ttBraceOpen]);

    ReadParam(ttComma, lCodeItem.Param1);
    ReadParam(ttBraceClose, lCodeItem.Param2);

    lCodeItem.Doc := GetDoc(4, True);
    lRes.AddCodeItem(lCodeItem);
  end;

  procedure ParseEnum;
  var
    lCodeItem: TSciGen.TCodeItem;
  begin
    lCodeItem := TSciGen.TCodeItem.Create(lRes.Code);
    lCodeItem.CodeType := ctEnu;

    ExceptToken([ttString]);
    lCodeItem.ItemName := lToken;

    ExceptToken([ttEqual]);
    ExceptToken([ttString]);

    repeat
      lCodeItem.EnumNames.Add(lToken);

      ExceptToken([ttString, ttNull]);
    until lTokenType <> ttString;

    lRes.AddCodeItem(lCodeItem);
  end;

  function cleanHTML(s: String): String;
  begin
    s := StringReplace(s, '&', '&amp;', [rfReplaceAll]);
    s := StringReplace(s, '<', '&lt;', [rfReplaceAll]);
    s := StringReplace(s, '>', '&gt;', [rfReplaceAll]);
    Result := s;
  end;

  procedure ParseLine;
  begin
    if not NextToken then
    begin
      lDocComment := '';

      if lLastLineVar then
      begin
        lRes.ConstDef := lRes.ConstDef + sLineBreak;

        lLastLineVar := False;
      end;
    end else
      case lTokenType of
      ttComment:
        ; // ignore

      ttDocComment:
        if lDocComment = '' then
          lDocComment := lDocComment + '/// <summary>' + cleanHTML(lToken) + sLineBreak
        else
          lDocComment := lDocComment + '/// ' + cleanHTML(lToken) + sLineBreak;

      ttString:
        if lToken = 'cat' then
          ParseCat
        else if lToken = 'val' then
          ParseVal
        else if lToken = 'enu' then
          ParseEnum
        else if lToken = 'lex' then
          // todo:
        else if lToken = 'evt' then
          // todo:
        else
          ParseCode;
      end;

    SkipLine;
  end;

begin
  lLine := '';
  lLineIdx := 0;

  lToken := '';
  lTokenType := ttNull;
  lTokenIdx := 1;

  lLastLineVar := False;

  Result := TSciGen.Create;
  try
    lRes := Result;

    lIn := TStringList.Create;
    try
      lIn.LoadFromFile(ASciIFaceFile);

      while NextLine do
        ParseLine;

{$IFNDEF SIMPLE_WRAPPER}
      Result.SecondPass;
{$ENDIF}

    finally
      lIn.Free;
    end;
  except
    Result.Free;

    raise;
  end;
end;

{ TSciIFace }

function TransType(AType: String): String;
begin
  if (AType = 'int') or (AType = 'keymod') then
    Result := 'Integer'
  else
  if AType = 'string' then
    Result := 'PAnsiChar'
  else
  if AType = 'stringresult' then
    Result := 'PAnsiChar'
  else
  if AType = 'textrange' then
    Result := 'PDSciTextRange'
  else
  if AType = 'formatrange' then
    Result := 'PDSciRangeToFormat'
  else
  if AType = 'findtext' then
    Result := 'PDSciTextToFind'
  else
  if AType = 'position' then
    Result := 'Integer'
  else
  if AType = 'colour' then
    Result := 'TColor'
  else
  if AType = 'bool' then
    Result := 'Boolean'
  else
  if AType = 'cell' then
    Result := 'TDSciCell'
  else
  if AType = 'cells' then
    Result := 'TDSciCells'
  else
    Result := AType;
//    raise Exception.CreateFmt('Type "%s" must by custom-handled!');
end;

function TSciGen.GetCodeParams(const ACodeItem: TCodeItem): String;

  function GetParamStr(AParam: TCodeParam): String;
  begin
    Result := Format('%s: %s', [AParam.ParamName, TransType(AParam.ParamType)]);
  end;

begin
  if not ACodeItem.Param1.IsSet and not ACodeItem.Param2.IsSet then
    Exit('');

  if ACodeItem.Param1.IsSet and ACodeItem.Param2.IsSet then
    Exit(Format('(%s; %s)', [
      GetParamStr(ACodeItem.Param1),
      GetParamStr(ACodeItem.Param2)
    ]));

  if ACodeItem.Param1.IsSet then
    Exit(Format('(%s)', [GetParamStr(ACodeItem.Param1)]));

  if ACodeItem.Param2.IsSet then
    Exit(Format('(%s)', [GetParamStr(ACodeItem.Param2)]));
end;

class function TSciGen.GetIsCustomFile(AName: String): Boolean;
begin
  Result := FileExists(GetCustomFile(AName));
end;

class function TSciGen.GetValue(AName, AFeature: String): String;
var
  lVal: String;
  lSL: TStringList;
begin
  lVal := _FeatureSL.Values[AName];
  if lVal = '' then
    Exit('');

  lSL := TStringList.Create;
  try
    lSL.Delimiter := '|';
    lSL.StrictDelimiter := True;
    lSL.NameValueSeparator := '~';

    lSL.DelimitedText := lVal;

    Result := lSL.Values[AFeature];

  finally
    lSL.Free;
  end;
end;

{$IFNDEF SIMPLE_WRAPPER}
procedure TSciGen.SecondPass;
var
  lItem: TCodeItem;
  lIdx: Integer;
  lProp: TPair<String, TCodePropItem>;
  lPubDef: string;
  lEnum: String;

  function GetIsDisabledCode: String;
  begin
    if GetValue(lItem.ItemName, 'Disabled') = '1' then
      Result := '// '
    else
      Result := '';
  end;

  function GetReturnProp: String;
  begin
    if lProp.Value.GetCode <> nil then
      Result := TransType(lProp.Value.GetCode.ReturnType)
    else
      if (lProp.Value.SetCode <> nil) and (lProp.Value.SetCode.Param2.IsSet) then
        Result := TransType(lProp.Value.SetCode.Param2.ParamType)
      else
        if (lProp.Value.SetCode <> nil) and (lProp.Value.SetCode.Param1.IsSet) then
          Result := TransType(lProp.Value.SetCode.Param1.ParamType)
        else
          RaiseLastOSError;

  end;

  function GetReadProp: String;
  begin
    if lProp.Value.GetCode = nil then
      Result := ''
    else
      Result := Format(' read %s', [lProp.Value.GetCode.ItemName]);
  end;

  function GetWriteProp: String;
  begin
    if lProp.Value.SetCode = nil then
      Result := ''
    else
      Result := Format(' write %s', [lProp.Value.SetCode.ItemName]);
  end;

  function GetDefaultProp: String;
  var
    lDef: String;
  begin
    if lProp.Value.GetCode = nil then
      Exit('');

    lDef := GetValue(lProp.Value.GetCode.ItemName, 'DefaultValue');

    if lDef = '' then
      Result := ''
    else
      Result := Format(' default %s', [lDef]);
  end;

  function GetPropParam: String;
  begin
    Result := '';

    if Assigned(lProp.Value.SetCode) and
      lProp.Value.SetCode.Param1.IsSet and
      lProp.Value.SetCode.Param2.IsSet
    then
      Result := Format('[%s: %s]', [
        lProp.Value.SetCode.Param1.ParamName,
        TransType(lProp.Value.SetCode.Param1.ParamType)
      ])
    else
      if Assigned(lProp.Value.GetCode) and
        lProp.Value.GetCode.Param1.IsSet and
        not lProp.Value.GetCode.Param2.IsSet
      then
        Result := Format('[%s: %s]', [
          lProp.Value.GetCode.Param1.ParamName,
          TransType(lProp.Value.GetCode.Param1.ParamType)
        ])
      else
        if Assigned(lProp.Value.GetCode) and
          lProp.Value.GetCode.Param1.IsSet and
          lProp.Value.GetCode.Param2.IsSet
        then
          Result := Format('[%s: %s; %s: %s]', [
            lProp.Value.GetCode.Param1.ParamName,
            TransType(lProp.Value.GetCode.Param1.ParamType),
            lProp.Value.GetCode.Param2.ParamName,
            TransType(lProp.Value.GetCode.Param2.ParamType)
          ])

  end;

  function IsPublicProp: Boolean;
  begin
    Result := (lProp.Value.GetCode = nil) or
      (GetPropParam <> '')
      {lProp.Value.GetCode.Param1.IsSet or
      lProp.Value.GetCode.Param2.IsSet};

    if not Result then
      Result := GetValue(lProp.Value.GetCode.ItemName, 'ForcePublicProp') = '1';
  end;

  procedure AddEnumCode(S: String);
  begin
    EnumsCodeDecl := EnumsCodeDecl + GetIsDisabledCode + S + sLineBreak;
  end;

begin


  for lItem in Self.Code do
    if lItem.CodeType = ctEnu then
    begin
      EnumsDef := EnumsDef + Format('  %s%s = (%s', [
          GetIsDisabledCode, lItem.GetEnumItemName, sLineBreak
        ]);

      EnumNames.Add(lItem.GetEnumItemName);



      // <ENUM CODE - To Int>
      lEnum := Format('%sfunction %sToInt(AEnum: %s): Integer;%s', [
        GetIsDisabledCode, lItem.GetEnumItemName, lItem.GetEnumItemName, sLineBreak
      ]);
      EnumsCodeDef := EnumsCodeDef + lEnum;

      AddEnumCode(Trim(lEnum));
      AddEnumCode(       'begin');
      AddEnumCode(       '  case AEnum of');

      for lIdx := 0 to lItem.EnumVals.Count - 1 do
      begin
        AddEnumCode(Format('  %s', [lItem.GetEnumNameVal(lIdx, ':', ':')]));
        AddEnumCode(Format('    Result := %s;', [lItem.EnumVals[lIdx].ConstValue]));
      end;

      AddEnumCode(       '  else');
      AddEnumCode(Format('    Result := %s;', [lItem.EnumVals[0].ConstValue]));
      AddEnumCode(       '  end;');

      AddEnumCode(      'end;');
      AddEnumCode(      '');
      // </ENUM CODE>



      // <ENUM CODE - From Int>
      lEnum := Format('%sfunction %sFromInt(AEnum: Integer): %s;%s', [
        GetIsDisabledCode, lItem.GetEnumItemName, lItem.GetEnumItemName, sLineBreak
      ]);
      EnumsCodeDef := EnumsCodeDef + lEnum;

      AddEnumCode(Trim(lEnum));
      AddEnumCode(       'begin');
      AddEnumCode(       '  case AEnum of');

      for lIdx := 0 to lItem.EnumVals.Count - 1 do
      begin
        AddEnumCode(Format('  %s:', [lItem.EnumVals[lIdx].ConstValue]));
        AddEnumCode(Format('    Result := %s', [lItem.GetEnumNameVal(lIdx, ';', ';')]));
      end;

      AddEnumCode(       '  else');
      AddEnumCode(Format('    Result := %s;', [lItem.GetEnumNameVal(0, ';', ';')]));
      AddEnumCode(       '  end;');

      AddEnumCode(       'end;');
      AddEnumCode(       '');
      // </ENUM CODE>

      for lIdx := 0 to lItem.EnumVals.Count - 1 do
        EnumsDef := EnumsDef + Format('  %s  %s%s', [
          GetIsDisabledCode, lItem.GetEnumNameVal(lIdx), sLineBreak]);

      EnumsDef := EnumsDef + Format('  %s);%s', [
          GetIsDisabledCode,  sLineBreak
        ]);

      if GetValue(lItem.ItemName, 'EnumSet') = '1' then
      begin
        EnumsDef := EnumsDef + Format('  %s%sSet = set of TDScintilla%s;%s', [
            GetIsDisabledCode, lItem.GetEnumItemName, lItem.ItemName, sLineBreak
          ]);

        EnumNames.Add(lItem.GetEnumItemName + 'Set');

        // <ENUM SET CODE - To Int>
        lEnum := Format('%sfunction %sSetToInt(AEnum: %sSet): Integer;%s', [
          GetIsDisabledCode, lItem.GetEnumItemName, lItem.GetEnumItemName, sLineBreak
        ]);
        EnumsCodeDef := EnumsCodeDef + lEnum;

        AddEnumCode(Trim(lEnum));
        AddEnumCode(       'var');
        AddEnumCode(Format('  lEnum: %s;', [lItem.GetEnumItemName]));
        AddEnumCode(       'begin');
        AddEnumCode(       '  Result := 0;');
        AddEnumCode(       '');
        AddEnumCode(       '  for lEnum in AEnum do');
        AddEnumCode(Format('    Result := Result + %sToInt(lEnum);', [lItem.GetEnumItemName]));
        AddEnumCode(       'end;');
        AddEnumCode(       '');
        // </ENUM STE CODE>

        // <ENUM SET CODE - From Int>
        lEnum := Format('%sfunction %sSetFromInt(AEnum: Integer): %sSet;%s', [
          GetIsDisabledCode, lItem.GetEnumItemName, lItem.GetEnumItemName, sLineBreak
        ]);
        EnumsCodeDef := EnumsCodeDef + lEnum;

        AddEnumCode(Trim(lEnum));
        AddEnumCode(       'var');
        AddEnumCode(Format('  lEnum: %s;', [lItem.GetEnumItemName]));
        AddEnumCode(       'begin');
        AddEnumCode(       '  Result := [];');
        AddEnumCode(       '');
        AddEnumCode(Format('  for lEnum := Low(%s) to High(%s) do', [lItem.GetEnumItemName, lItem.GetEnumItemName]));
        AddEnumCode(Format('    if AEnum and %sToInt(lEnum) <> 0 then', [lItem.GetEnumItemName]));
        AddEnumCode(       '      Include(Result, lEnum);');
        AddEnumCode(       'end;');
        AddEnumCode(       '');
        // </ENUM SET CODE>
      end;

      EnumsDef := EnumsDef + sLineBreak;
    end;

  for lProp in Props do
  begin
    lPubDef :=
        Format('    %sproperty %s%s: %s%s%s%s;%s', [
          GetIsDisabledCode,
          lProp.Value.ItemName,
          GetPropParam,
          GetReturnProp,
          GetReadProp,
          GetWriteProp,
          GetDefaultProp,
          sLineBreak
        ]);

    if IsPublicProp then
      PublicPropertesDef := PublicPropertesDef + lPubDef
    else
      PublishedPropertesDef := PublishedPropertesDef + lPubDef;

  end;
end;
{$ENDIF}

class procedure TSciGen.SetValue(AName, AFeature, AValue: String);
var
  lSL: TStringList;
begin
  lSL := TStringList.Create;
  try
    lSL.Delimiter := '|';
    lSL.StrictDelimiter := True;
    lSL.NameValueSeparator := '~';

    lSL.DelimitedText := _FeatureSL.Values[AName];

    lSL.Values[AFeature] := AValue;

    _FeatureSL.Values[AName] := lSL.DelimitedText;

  finally
    lSL.Free;
  end;
end;

procedure TSciGen.AddCodeItem(const ACodeItem: TCodeItem; AAddDoc: Boolean);
var
  lNameParams: String;
  lDef, lCode: String;
  lCustomFile: string;
  lCustomStr: TStringList;
  lCustomStrIdx: Integer;
  lProperty: TCodePropItem;

  function GetSendParamStr(AParam: TCodeParam): String;
{$IFNDEF SIMPLE_WRAPPER}
  var
    lEnum: String;
{$ENDIF}
  begin
    if AParam.IsSet then
    begin
{$IFNDEF SIMPLE_WRAPPER}
      lEnum := GetValue(ACodeItem.ItemName, Format('Param%dEnum', [AParam.FIdx]));

      if lEnum <> '' then
      begin
        if SameText(LeftStr(lEnum, 6), 'TDScintilla') then
          Result := Format('%sToInt(%s)', [lEnum, AParam.ParamName])
        else
          Result := Format('TODO_%s(%s)', [lEnum, AParam.ParamName])
      end else
{$ENDIF}
      if TransType(AParam.ParamType) = 'Integer' then
        Result := AParam.ParamName
      else
        Result := Format('Integer(%s)', [AParam.ParamName]);
    end else
      Result := '0';
  end;

  function GetSend: String;
  begin
    Result := Format('SendEditor(%s, %s, %s)', [
      ACodeItem.ConstName,
      GetSendParamStr(ACodeItem.Param1),
      GetSendParamStr(ACodeItem.Param2)
    ]);
  end;

  function GetSendRet: String;
{$IFNDEF SIMPLE_WRAPPER}
  var
    lEnum: String;
{$ENDIF}
  begin
{$IFNDEF SIMPLE_WRAPPER}
    lEnum := GetValue(ACodeItem.ItemName, 'ReturnEnum');

    if lEnum <> '' then
      Result := Format('%sFromInt(%s)', [lEnum, GetSend])
    else
{$ENDIF}
    if ACodeItem.ReturnType = 'bool' then
      Result := Format('Boolean(%s)', [GetSend])
    else
    if ACodeItem.ReturnType = 'colour' then
      Result := Format('TColor(%s)', [GetSend])
    else
      Result := GetSend;
  end;

  function GetIsDisabledCode: String;
  begin
    if GetValue(ACodeItem.ItemName, 'Disabled') = '1' then
      Result := '// '
    else
      Result := '';
  end;

begin
  Code.Add(ACodeItem);

  if ACodeItem.CodeType = ctEnu then
  begin
    FLastEnum := ACodeItem;
  end;

  if AAddDoc then
    lDef := ACodeItem.Doc
  else
    lDef := '';

  lCode := '';

  lCustomFile := GetCustomFile(ACodeItem.ItemName);
  if FileExists(lCustomFile) then
  begin

    lCustomStr := TStringList.Create;
    try
      lCustomStr.LoadFromFile(lCustomFile);

      lDef := lDef + '    ' + GetIsDisabledCode + lCustomStr[0] + sLineBreak + sLineBreak;
      lCustomStr.Delete(0);

      for lCustomStrIdx := 0 to lCustomStr.Count - 1 do
        lCustomStr[lCustomStrIdx] := GetIsDisabledCode + lCustomStr[lCustomStrIdx];

      lCode := Format(lCustomStr.Text, ['%s']);
    finally
      lCustomStr.Free;
    end;

  end else
  begin
    lNameParams := Format('%s%s',
      [ACodeItem.ItemName, GetCodeParams(ACodeItem)]);

    case ACodeItem.CodeType of
    ctProc, ctSet:
      begin
        lDef := lDef + Format('    %sprocedure %s;%s%s', [
            GetIsDisabledCode, lNameParams, sLineBreak, sLineBreak
          ]);

        lCode := lCode + Format('%sprocedure %%s.%s;%s', [
            GetIsDisabledCode, lNameParams, sLineBreak
          ]);

        lCode := lCode + GetIsDisabledCode + 'begin' + sLineBreak;

        lCode := lCode + GetIsDisabledCode + Format('  %s;', [GetSend]) + sLineBreak;

        lCode := lCode + GetIsDisabledCode + 'end;' + sLineBreak + sLineBreak;
      end;

    ctFunc, ctGet:
      begin
        lDef := lDef + Format('    %sfunction %s: %s;%s%s', [
            GetIsDisabledCode, lNameParams, TransType(ACodeItem.ReturnType), sLineBreak, sLineBreak
          ]);

        lCode := lCode + Format('%sfunction %%s.%s: %s;%s', [
          GetIsDisabledCode, lNameParams, TransType(ACodeItem.ReturnType), sLineBreak
        ]);

        lCode := lCode + GetIsDisabledCode + 'begin' + sLineBreak;
        lCode := lCode + GetIsDisabledCode + Format('  Result := %s;', [GetSendRet]) + sLineBreak;
        lCode := lCode + GetIsDisabledCode + 'end;' + sLineBreak + sLineBreak;
      end;

    end;
  end;

  if ACodeItem.CodeType in [ctGet, ctSet] then
  begin
    if not Props.TryGetValue(ACodeItem.GetPropertyName, lProperty) then
    begin
      lProperty.GetCode := nil;
      lProperty.SetCode := nil;
      lProperty.ItemName := ACodeItem.GetPropertyName;
    end;

    case ACodeItem.CodeType of
    ctGet:
      lProperty.GetCode := ACodeItem;

    ctSet:
      lProperty.SetCode := ACodeItem;
    end;

    Props.AddOrSetValue(ACodeItem.GetPropertyName, lProperty);
  end;

  case ACodeItem.CodeType of
  ctProc, ctFunc:
    begin
      PublicDef := PublicDef + lDef;
      PublicCode := PublicCode + lCode;
    end;

  ctSet, ctGet:
    begin
      ProtectedDef := ProtectedDef + lDef;
      ProtectedCode := ProtectedCode + lCode;
    end;
  end;
end;

constructor TSciGen.Create;
begin
  Consts := TConstsList.Create;
  Code := TCodeList.Create;
  Props := TCodeProps.Create;
  EnumNames := TStringList.Create;
end;

destructor TSciGen.Destroy;
begin
  EnumNames.Free;
  Consts.Free;
  Code.Free;
  Props.Free;

  inherited Destroy;
end;

procedure _SaveFS;
begin
  _FeatureSL.SaveToFile(Format(rsCustomsCode, [rsFeaturesFile]));
end;

{ TSciGen.TCodeList }

procedure TSciGen.TCodeList.Notify(const Item: TCodeItem;
  Action: TCollectionNotification);
begin
  inherited;

  if Action = cnRemoved then
    if Item.Owner = Self then
      Item.Free;
end;

{ TSciGen.TCodeItem }

function TSciGen.TCodeItem.AddEnumValue(AItem: TConstItem): Boolean;
var
  lPrefix: String;
begin
  lPrefix := IsEnum(AItem.ConstName);

  Result := lPrefix <> '';

  if Result then
  begin
    if (TSciGen.GetValue(ItemName, 'EnumSet') = '1') and
      (StrToInt(AItem.ConstValue) = 0)
    then
      Exit;

    EnumVals.Add(AItem);
  end;
end;

constructor TSciGen.TCodeItem.Create(AOwner: TCodeList);
begin
  inherited Create;

  Owner := AOwner;
  EnumVals := TSciEnumVals.Create;
  EnumNames := TSciEnums.Create;

  Param1 := TCodeParam.Create(Self, 1);
  Param2 := TCodeParam.Create(Self, 2);
end;

destructor TSciGen.TCodeItem.Destroy;
begin
  EnumNames.Free;
  EnumVals.Free;

  inherited Destroy;
end;

function TSciGen.TCodeItem.GetEnumItemName: String;
begin
  Result := Format('TDScintilla%s', [ItemName]);
end;

function TSciGen.TCodeItem.GetEnumNameVal(AIndex: Integer; AChar1: Char = ' '; AChar2: Char = ','): String;
begin
  Result :=
    GetEnumPrefix +
    Copy(EnumVals[AIndex].ConstName, Length(IsEnum(EnumVals[AIndex].ConstName)) + 1, MaxInt) +
    IfThen(AIndex = EnumVals.Count - 1, AChar1, AChar2);

  Result :=
    Result +
    StringOfChar(' ', 40 - Length(Result)) +
    Format('/// <summary>%s = %s%</summary>', [EnumVals[AIndex].ConstName, EnumVals[AIndex].ConstValue]);
end;

function TSciGen.TCodeItem.GetEnumPrefix: String;
var
  lIdx: Integer;
begin
  if CodeType <> ctEnu then
    RaiseLastOSError; // :[=hahaha], boring day...

  Result := 'sc';

  for lIdx := 1 to Length(ItemName) - 1 do
    if TCharacter.IsUpper(ItemName[lIdx]) then
      Result := Result + ItemName[lIdx];

  Result := LowerCase(Result);
end;

function TSciGen.TCodeItem.GetPropertyName: String;
begin
  case CodeType of
  ctGet:
    begin
      Result := ItemName;
      Delete(Result, Pos('Get', ItemName), 3);
    end;

  ctSet:
    begin
      Result := ItemName;
      Delete(Result, Pos('Set', ItemName), 3);
    end;
  else
    RaiseLastOSError;
  end;
end;

function TSciGen.TCodeItem.GetReturnType: String;
begin
{$IFNDEF SIMPLE_WRAPPER}
  Result := TSciGen.GetValue(ItemName, 'ReturnEnum');

  if Result = '' then
{$ENDIF}
    Result := FReturnType;
end;

function TSciGen.TCodeItem.IsEnum(AName: String): String;
var
  lName: String;
begin
  for lName in EnumNames do
    if SameText(lName, LeftStr(AName, Length(lName))) then
      Exit(lName);

  Result := '';
end;

{ TSciGen.TCodeParam }

constructor TSciGen.TCodeParam.Create(AOwner: TCodeItem; AIdx: Integer);
begin
  inherited Create;

  Owner := AOwner;
  FIdx := AIdx;
end;

function TSciGen.TCodeParam.GetParamType: String;
begin
{$IFNDEF SIMPLE_WRAPPER}
  Result := TSciGen.GetValue(Owner.ItemName, Format('Param%dEnum', [FIdx]));

  if Result = '' then
{$ENDIF}
    Result := FParamType;
end;

initialization
  _FeatureSL := TStringList.Create;
  try
    _FeatureSL.LoadFromFile(Format(rsCustomsCode, [rsFeaturesFile]));
  except
  end;

finalization
  _SaveFS;
  _FeatureSL.Free;

end.

