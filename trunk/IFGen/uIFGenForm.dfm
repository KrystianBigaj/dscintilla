object Form4: TForm4
  Left = 549
  Top = 50
  Caption = 'Scintilla Delphi Code Gen'
  ClientHeight = 563
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'OpenSymbol'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  ShowHint = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  DesignSize = (
    680
    563)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 680
    Height = 563
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Scintilla.iface'
      object memIFace: TMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 534
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'DScintillaTypes.pas'
      ImageIndex = 1
      object memTypes: TMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 534
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'DScintilla.pas'
      ImageIndex = 2
      object memProps: TMemo
        Left = 0
        Top = 0
        Width = 672
        Height = 534
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Custom code'
      ImageIndex = 3
      DesignSize = (
        672
        534)
      object lblType: TLabel
        Left = 79
        Top = 8
        Width = 80
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'lblType'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 3
        Top = 60
        Width = 7
        Height = 13
        Caption = 'D'
      end
      object Label2: TLabel
        Left = 3
        Top = 87
        Width = 5
        Height = 13
        Caption = '1'
      end
      object Label3: TLabel
        Left = 3
        Top = 114
        Width = 5
        Height = 13
        Caption = '2'
      end
      object Label4: TLabel
        Left = 3
        Top = 141
        Width = 7
        Height = 13
        Caption = 'R'
      end
      object cb: TCheckListBox
        Left = 3
        Top = 238
        Width = 156
        Height = 293
        OnClickCheck = cbClickCheck
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 16
        PopupMenu = PopupMenu1
        Style = lbOwnerDrawFixed
        TabOrder = 0
        OnClick = cbClick
        OnDrawItem = cbDrawItem
      end
      object memCode: TMemo
        Left = 165
        Top = 328
        Width = 504
        Height = 203
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        WantTabs = True
        WordWrap = False
        OnChange = edtDefChange
      end
      object edtDef: TEdit
        Left = 165
        Top = 5
        Width = 504
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = edtDefChange
      end
      object chkShowHidden: TCheckBox
        Left = 3
        Top = 188
        Width = 156
        Height = 17
        Caption = 'Show hidden'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 3
        OnClick = chkShowHiddenClick
      end
      object edtFilter: TEdit
        Left = 3
        Top = 211
        Width = 156
        Height = 21
        TabOrder = 4
        TextHint = 'Search'
        OnChange = edtFilterChange
      end
      object chkConfigUnicode: TCheckBox
        Left = 70
        Top = 34
        Width = 26
        Height = 17
        Hint = 'Unicode'
        Caption = '&U'
        TabOrder = 5
        OnClick = chkConfigClick
      end
      object chkConfigDisabled: TCheckBox
        Left = 36
        Top = 34
        Width = 28
        Height = 17
        Hint = 'Disabled'
        Caption = '&D'
        TabOrder = 6
        OnClick = chkConfigClick
      end
      object chkConfigHidden: TCheckBox
        Left = 3
        Top = 34
        Width = 27
        Height = 17
        Hint = 'Hidden'
        Caption = '&H'
        TabOrder = 7
        OnClick = chkConfigClick
      end
      object btnDel: TButton
        Left = 3
        Top = 3
        Width = 38
        Height = 25
        Caption = '&Delete'
        Enabled = False
        TabOrder = 8
        OnClick = btnDelClick
      end
      object btnSave: TButton
        Left = 47
        Top = 3
        Width = 34
        Height = 25
        Caption = '&Save'
        Enabled = False
        TabOrder = 9
        OnClick = btnSaveClick
      end
      object chkOnlyEnums: TCheckBox
        Left = 3
        Top = 165
        Width = 78
        Height = 17
        Caption = 'Only enums'
        TabOrder = 10
        OnClick = chkShowHiddenClick
      end
      object chkConfigEnumSet: TCheckBox
        Left = 102
        Top = 34
        Width = 27
        Height = 17
        Hint = 'EnumSet'
        Caption = '&E'
        TabOrder = 11
        OnClick = chkConfigClick
      end
      object cfgDefaultValue: TEdit
        Left = 16
        Top = 57
        Width = 143
        Height = 21
        Hint = 'DefaultValue'
        TabOrder = 12
        TextHint = 'DefaultValue'
        OnExit = cfgDefaultValueChange
      end
      object cfgPara1Enum: TComboBox
        Left = 16
        Top = 84
        Width = 143
        Height = 21
        Hint = 'Param1Enum'
        ItemHeight = 0
        TabOrder = 13
        TextHint = 'Param1 Enum'
        OnExit = cfgPara1EnumExit
      end
      object cfgPara2Enum: TComboBox
        Left = 16
        Top = 111
        Width = 143
        Height = 21
        Hint = 'Param2Enum'
        ItemHeight = 0
        TabOrder = 14
        TextHint = 'Param2 Enum'
        OnExit = cfgPara1EnumExit
      end
      object cfgReturnEnum: TComboBox
        Left = 16
        Top = 138
        Width = 143
        Height = 21
        Hint = 'ReturnEnum'
        ItemHeight = 0
        TabOrder = 15
        TextHint = 'ReturnEnum'
        OnExit = cfgPara1EnumExit
      end
      object memDoc: TMemo
        Left = 165
        Top = 33
        Width = 504
        Height = 72
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 16
      end
      object memDef: TMemo
        Left = 165
        Top = 110
        Width = 504
        Height = 212
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 17
      end
      object chkConfigForcePublicProp: TCheckBox
        Left = 132
        Top = 34
        Width = 27
        Height = 17
        Hint = 'ForcePublicProp'
        Caption = '&P'
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Segoe Print'
        Font.Style = [fsBold, fsStrikeOut]
        ParentFont = False
        TabOrder = 18
        OnClick = chkConfigClick
      end
    end
  end
  object btnRegen: TButton
    Left = 597
    Top = 1
    Width = 75
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Regenerate'
    TabOrder = 1
    OnClick = btnRegenClick
  end
  object tmrSearch: TTimer
    Enabled = False
    Interval = 320
    OnTimer = tmrSearchTimer
    Left = 344
    Top = 80
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 368
    object ClearHideflagforallitems1: TMenuItem
      Caption = 'Clear Hide flag for all items'
      OnClick = ClearHideflagforallitems1Click
    end
  end
end
