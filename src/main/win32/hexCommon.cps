{
    
    Copyright (C) 2010 Ben Golightly

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
}
Unit
    Uses
        lexini

Type hexStrings = Record
    s : String = ""
    
    { By only pointing to strings, when sorting a list, two nodes can simply
      swap pointers, rather than creating new string buffers }
    
EndType ; export

Var
    gfx_width               : Integer ; export
    gfx_height              : Integer ; export
    gfx_depth               : Integer ; export
    gfx_fullscreen          : Boolean ; export
    gfx_flags               : Integer ; export
    gfx_vsync               : Integer ; export
    
    music_enabled           : Boolean ; export
    music_volume            : Real    ; export

    settings_paths          : String  ; export
    settings_palette        : String  ; export
    settings_tileset        : String  ; export
    
    hag_baseDir             : String  ; export
    hag_theme               : String  ; export
    hag_debug               : Boolean ; export
    
    compress_enabled        : Boolean ; export
    compress_cmdCompress    : String  ; export
    compress_cmdDecompress  : String  ; export
    
    path_worlds             : String ; export
    path_scripts            : String ; export
    path_images             : String ; export
    path_palettes           : String ; export
    path_tilesets           : String ; export
    path_races              : String ; export
    path_people             : String ; export
    path_places             : String ; export
    path_credits            : String ; export
    path_mainMenu_logo      : String ; export
    path_mainMenu_music     : String ; export
    path_mainMenu_background: String ; export
    path_wgenMenu_background: String ; export
    path_gplLogo            : String ; export
    path_thsLogo            : String ; export  

    iniCfg: ^iniFiles
    iniPaths: ^iniFiles

Procedure common_LoadCfg() ; export
Begin
    
    // cfg.ini
    iniCfg = IniLoad("cfg.ini")
    
    IniSelectSection(iniCfg, "graphics")
    gfx_width               = IniAsInteger("width",               0)
    gfx_height              = IniAsInteger("height",              0)
    gfx_depth               = IniAsInteger("depth",               0)
    gfx_fullscreen          = IniAsBoolean("fullscreen",       TRUE)
    gfx_flags               = IniAsInteger("flags",               0)
    gfx_vsync               = IniAsInteger("vsync",               0)

    IniSelectSection(iniCfg, "music")
    music_enabled           = IniAsBoolean("enabled")
    music_volume            = IniAsReal   ("volume")
    
    IniSelectSection(iniCfg, "settings")
    settings_paths          = IniAsString ("paths")
    settings_palette        = IniAsString ("palette",  "default.ini")
    settings_tileset        = IniAsString ("tileset",  "default.bmp")
    
    IniSelectSection(iniCfg, "gui")
    hag_baseDir             = IniAsString ("baseDir")
    hag_theme               = IniAsString ("theme")
    hag_debug               = IniAsBoolean("debug",            TRUE)
    
    IniSelectSection(iniCfg, "compression")
    compress_enabled        = IniAsBoolean("enabled",         FALSE)
    compress_cmdCompress    = IniAsString ("cmdCompress")
    compress_cmdDecompress  = IniAsString ("cmdDecompress")
    
    
    // paths.ini
    iniPaths = IniLoad(settings_paths)
    
    IniSelectSection(iniPaths, "paths")    
    path_worlds             = IniAsString ("worlds")
    path_scripts            = IniAsString ("scripts")
    path_images             = IniAsString ("images")
    path_palettes           = IniAsString ("palettes")
    path_tilesets           = IniAsString ("tilesets")
    path_races              = IniAsString ("races")
    path_people             = IniAsString ("people")
    path_places             = IniAsString ("places")
    path_credits            = IniAsString ("credits")
    path_mainMenu_logo      = IniAsString ("mainMenuLogo")
    path_mainMenu_music     = IniAsString ("mainMenuMusic")
    path_mainMenu_background= IniAsString ("mainMenuBackground")
    path_wgenMenu_background= IniAsString ("wgenMenuBackground")
    path_gplLogo            = IniAsString ("gplLogo")
    path_thsLogo            = IniAsString ("thsLogo")
    
End

Function FileGetContents(fn: String) : String ; export
Var
    mf: Element
Begin
    result = ""
    If Not FileExists(fn) then exit
    
    mf = ReadFile(fn)
    If mf = NULL then exit
    
    While Not EOF(mf)
        result = result + ReadLn(mf) + Chr(10)    
    Wend
    
End

Function GetFileSize(fn: String) : Integer ; export
Var
    mf: Element
Begin
    result = 0
    If FileExists(fn) = FALSE then exit
    mf = ReadFile(fn)
    result = FileSize(mf)
    Closefile(mf)
End

Function Sanitize_WorldName(s: String): String ; export
Var
    c, i: Integer
Begin
    result = ""
    
    For i = 1 to Length(s)
        c = Asc(Mid(s, i, 1))        
        Conditions
            ((c >= 48) and (c <= 57)): result = result + Chr(c) // 0-9
            ((c >= 65) and (c <= 90)): result = result + Chr(c) // A-Z
            ((c >= 97) and (c <= 122)): result = result + Chr(c) // A-Z
            (c = 32): result = result + "_" // space
        EndConditions         
    Next
End

Begin
End