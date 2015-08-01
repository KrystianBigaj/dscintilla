=== DScintilla

DScintilla is a simple (but complete) Scintilla wrapper for Delphi VCL (Win32).
Supported Delphi versions: D6-XE7+ (D6-D2007 requires JEDI-JCL dependency).

Because this is a wrapper for Scintilla, so you can read/see more at:

http://www.scintilla.org/ScintillaDownload.html
http://www.scintilla.org/ScintillaRelated.html
http://www.scintilla.org/ScintillaDoc.html

=== Installation

1. Get (or compile) latest version of SciLexer.dll. You can get precompiled SciLexer.dll from http://www.scintilla.org/SciTEDownload.html (Windows Executables/A full download...)
   You can also get SciLexerDll\SciLexer.dll
   However it's always recommended to use latest SciLexer.dll
2. Put SciLexer.dll to path where Delphi will be able load it. It could be for example: C:\Windows\SysWOW64 (or if you are still using x86 then it will be C:\Windows\System32)
3. Add C:\XYZ\DScintilla\Sources to your Delphi "Library path"
4. Open in Delphi C:\XYZ\Packages\DScintillaRuntime.dpk, then Build package
5. Open in Delphi C:\XYZ\Packages\DScintillaDesign.dpk, then Build and Install package

After installation you should have a TDScintilla VCL component installed in your Component Palette (page DScintilla).

=== Info

E-mail: krystian.bigaj@gmail.com
Project page: https://github.com/krystianbigaj/dscintilla
