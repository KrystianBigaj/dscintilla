Delphi needs to 'see' SciLexer.dll to load TDScintilla at design time.

Copy SciLexer.dll to path where Delphi will be able load it.
It could be for example: C:\Program Files (x86)\CodeGear\RAD Studio\6.0\bin.
Alternatively you could copy SciLexer.dll to for example: C:\Windows\SysWOW64
(or if you are still using x86 then it will be: C:\Windows\System32)

Please note that when you deploy your application,
then you must also include SciLexer.dll with your app
It can be placed in your .exe directory.

This SciLexer.dll has been extracted from SciTE (http://www.scintilla.org/SciTEDownload.html)
It's recommencted always to use latest SciLexer.dll