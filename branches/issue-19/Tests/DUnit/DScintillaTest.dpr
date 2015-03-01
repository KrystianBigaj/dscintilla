program DScintillaTest;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  TestDScintilla in 'TestDScintilla.pas',
  DScintillaTypes in '..\..\Sources\DScintillaTypes.pas',
  DScintillaUtils in '..\..\Sources\DScintillaUtils.pas',
  DScintillaCustom in '..\..\Sources\DScintillaCustom.pas',
  DScintilla in '..\..\Sources\DScintilla.pas',
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner;

{R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
end.

