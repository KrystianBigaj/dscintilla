object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'TDScintillaCustom - simple demo'
  ClientHeight = 243
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = CheckDllChange
  DesignSize = (
    527
    243)
  PixelsPerInch = 96
  TextHeight = 13
  object lblError: TLabel
    Left = 8
    Top = 39
    Width = 511
    Height = 42
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
    WordWrap = True
  end
  object btnCreate: TButton
    Left = 8
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Create TDScintillaCustom'
    TabOrder = 0
    OnClick = btnCreateClick
  end
  object cbSciDll: TComboBox
    Left = 167
    Top = 10
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'SciLexer.dll'
    OnChange = CheckDllChange
    Items.Strings = (
      'SciLexer.dll'
      'Scintilla.dll')
  end
end
