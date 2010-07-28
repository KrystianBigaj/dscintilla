program DScintillaCustomDemo;

uses
  Forms,
  uMainForm in 'uMainForm.pas' {frmMain},
  DScintillaCustom in '..\..\Sources\DScintillaCustom.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
