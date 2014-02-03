program SciIFGen;

uses
  Forms,
  uIFGenForm in 'uIFGenForm.pas' {Form4},
  uIFGen in 'uIFGen.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.

