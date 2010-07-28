{-----------------------------------------------------------------------------
 Unit Name: uMainForm
 Author:    Krystian
 Date:      28-lip-2010
 Purpose:
 History:
-----------------------------------------------------------------------------}

unit uMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DScintillaCustom;

type

{ TfrmMain }

  TfrmMain = class(TForm)
    btnCreate: TButton;
    cbSciDll: TComboBox;
    lblError: TLabel;
    procedure btnCreateClick(Sender: TObject);
    procedure CheckDllChange(Sender: TObject);
  private
    FSci: TDScintillaCustom;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnCreateClick(Sender: TObject);
begin
  FreeAndNil(FSci);

  FSci := TDScintillaCustom.Create(Self);
  FSci.DllModule := cbSciDll.Text;
  FSci.Align := alClient;
  FSci.Parent := Self;

  btnCreate.Visible := False;
  cbSciDll.Visible := False;
  lblError.Visible := False;
end;

procedure TfrmMain.CheckDllChange(Sender: TObject);
var
  lModule: HMODULE;
begin
  lModule := LoadLibrary(PChar(cbSciDll.Text));
  try
    if lModule = 0 then
      lblError.Caption := SysErrorMessage(GetLastError);

    btnCreate.Enabled := lModule <> 0;
    lblError.Visible := lModule = 0;

  finally
    if lModule <> 0 then
      FreeModule(lModule);
  end;
end;

end.
