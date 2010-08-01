program DScintillaCustomDemo;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {frmMain},
  DScintillaCustom in '..\..\Sources\DScintillaCustom.pas';

{$R *.res}

begin
  Application.Initialize;
  {$IF CompilerVersion > 15}
  Application.MainFormOnTaskbar := True;
  {$IFEND}
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
