@echo off

echo Compiling XP.bsd
ThemeCompiler.exe themes\gui\XP\XP.bsd
type log\themecompiler.log

echo -----------------------------

echo Compiling plastic.bsd
ThemeCompiler.exe themes\gui\plastic\plastic.bsd
type log\themecompiler.log

echo -----------------------------

echo Compiling dark.bsd
ThemeCompiler.exe themes\gui\dark\dark.bsd
type log\themecompiler.log

pause