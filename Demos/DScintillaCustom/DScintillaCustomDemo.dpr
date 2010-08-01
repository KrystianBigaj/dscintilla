program DScintillaCustomDemo;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {frmMain},
  DScintillaCustom in '..\..\Sources\DScintillaCustom.pas';

{$R *.res}

begin
  Application.Initialize;

  // Application.MainFormOnTaskbar added in D2007
  {$IF CompilerVersion > 18}
  Application.MainFormOnTaskbar := True;
  {$IFEND}
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
