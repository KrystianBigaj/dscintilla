### DScintilla ###
DScintilla is a simple (but complete) [Scintilla](http://www.scintilla.org/) wrapper for Delphi VCL (Win32). Interface updated from Scintilla v3.43 in svn [r75](https://code.google.com/p/dscintilla/source/detail?r=75) (19 June 2014).

Since [r31](https://code.google.com/p/dscintilla/source/detail?r=31) you don't need to use patched Scintilla, you can use latest `SciLexer.dll` from http://www.scintilla.org (or compile yourself from sources).

In case of using older DScintilla and newer `SciLexer.dll` everything should work fine - you will get fixes/improvements of new Scintilla version. You'll miss only new features in interface, but you will be always able to use them by using `SendEditor` function.

Supported Delphi versions: D6-XE7+ (D6-D2007 requires [JEDI-JCL](http://jcl.delphi-jedi.org/) dependency).

Because this is a wrapper for Scintilla, so you can read/see more at:
  * http://www.scintilla.org/ScintillaDownload.html
  * http://www.scintilla.org/ScintillaRelated.html
  * http://www.scintilla.org/ScintillaDoc.html

Simple usage: http://stackoverflow.com/search?q=dscintilla


---


### Installation ###
  1. Get (or compile) latest version of `SciLexer.dll`. You can get precompiled `SciLexer.dll` from http://www.scintilla.org/SciTEDownload.html (Windows Executables/A full download...)
  1. Put `SciLexer.dll` to path where Delphi will be able load it. It could be for example: `C:\Program Files (x86)\CodeGear\RAD Studio\6.0\bin`. Alternatively you could copy `SciLexer.dll` to for example `C:\Windows\SysWOW64` (or if you are still using x86 then it will be `C:\Windows\System32`)
  1. Add `X:\Y\Z\DScintilla\Sources` to your Delphi "Library path"
  1. Open in Delphi `X:\Y\Z\DScintilla\Packages\DScintillaRuntime.dpk`, then Build package
  1. Open in Delphi `X:\Y\Z\DScintilla\Packages\DScintillaDesign.dpk`, then Build and Install package
After installation you should have a `TDScintilla` VCL component installed in your `Component Palette` (page `DScintilla`).

### TODOs ###
  * ~~Scintilla methods are not fully translated and tested~~
  * ~~Better support for TDScintilla.Lines for non-Unicode Delphi versions (Load/Save encodings/BOM)~~
  * ~~Packages (dpk)~~
  * Demos
  * Docs
  * ...