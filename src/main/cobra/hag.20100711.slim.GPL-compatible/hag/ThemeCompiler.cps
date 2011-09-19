{
    Hag Theme Compiler - Version 20100216

    Compiles human-readable theme data (e.g. colours, fonts) into a neatly packaged
    binary file of predictable structure for hag.
    
    This enables hag to load themes a lot faster and removes basilisk as a dependency. 
    
    The compiled version of this file should be placed into the root of the "hag"
    resource folder (whatever you've named it as)
    
    ---------------------------------------

    Usage:
	    ThemeCompiler.exe theme.bsd

    Example: (compile.bat)
	    ThemeCompiler.exe themes\gui\xp\xp.bsd
    
}
Program (icon:"icons\gear.ico") 
    Uses
        basilisk,
        pure2d

Const
    COMPATIBLE = 2  // Compatible version - files with a different compatible int are
                    // either too old or too new for this version of the theme compiler.
                    // Note that the purpose of the compatible const is to prevent the
                    // compiler or a program that uses hag from crashing - as long as
                    // the compatible flags are compatible, the compiler will compile
                    // themes that were written for older or newer compiler versions
                    // without crashing or refusing. It may ignore some styles, however.
                    //
                    // The compiler will refuse to compile themes that have incompatible
                    // compatible integers, but a program using hag will make an attempt
                    // to read any compiled themes even if they are incompatible, and
                    // log a warning.
    
    REVISION = "20100219" 

    { GUI Element Types }
    GET_BUTTON              = 0
    GET_PROGRESSBAR         = 1
    GET_RADIOGROUP          = 2 
    GET_RADIOBUTTON         = 3
    GET_CHECKBOX            = 4
    GET_TEXTBOX             = 5
    GET_TEXT                = 6
    GET_RICHTEXT            = 7 // Not Yet Implemented
    GET_IMAGE               = 8 // Not Yet Implemented
    GET_DROPDOWN            = 9
    GET_LISTBOX             = 10    
    GET_TIMER               = 11
    GET_TAB                 = 12
    GET_FRAME               = 13
    GET_MENU                = 14 // Not Yet Implemented
    MAX_GETS                = 15

Function HexAs6(hexval:String) : String
Begin
    hexval = Upper(hexval)
    
    If (Length(hexval)=3) Then hexval = (Mid(hexval,1,1)+""+Mid(hexval,1,1)) +""+ (Mid(hexval,2,1)+""+Mid(hexval,2,1)) +""+ (Mid(hexval,3,1)+""+Mid(hexval,3,1))
    If (Not (Length(hexval)=6)) Then MessageBox("Hex #"+hexval+" could not be converted to a Length 6 Hexidecimal value.","HAG Theme Compiler")
    
    result = hexval 
End

Function HexR(hexval:String) : String
Begin
    result = Mid(hexval,1,2) 
End

Function HexG(hexval:String) : String
Begin
    result = Mid(hexval,3,2) 
End

Function HexB(hexval:String) : String
Begin
    result = Mid(hexval,5,2) 
End

Function HexInt(hexval:String) : Integer
Var
    lefthex, righthex : String
    leftval, rightval : Integer 
Begin
    lefthex = Left(hexval,1)
    righthex = Right(hexval,1)
    If (Asc(lefthex) > 64) Then
        leftval = (Asc(lefthex) - 55)
    Else
        leftval = ToInt(lefthex)
    Endif
    
    If (Asc(righthex) > 64) Then
        rightval = (Asc(righthex) - 55)
    Else
        rightval = ToInt(righthex)
    Endif
    
    result = (leftval*16)+rightval
End

Var
    inFileName: String
    outFileName: String
    fs : Element
    m : Integer
    hex: String 
Begin

    m = Millisecs

    If ParamCount() = 0 then
        MessageBox("Usage: ThemeCompiler.exe theme.bsd","HAG Theme Compiler")
    Else
        
        inFileName = ParamStr(1)
        If FileExists(inFileName) = FALSE then
            MessageBox("Not Found: "+inFileName,"HAG Theme Compiler")
        Else 
            
            outFileName = Left(inFileName,Length(inFileName)-4) + ".bin"
        
            ReadSettings("const.bsd")
            ReadSettings(inFileName)
            
            If VirtualInteger("Compatible") <> COMPATIBLE then
                MessageBox("The theme you are trying to compile is either too old or too new for this version of the theme compiler. Please ammend the theme and/or update the Hag Theme Compiler","HAG Theme Compiler")
            Else
            
            
                If FileExists(outFileName) then DeleteFile(outFileName)
            
                fs = WriteFile(outFileName)
            
                    WriteInt(fs,Now)
                
                    { Header }
                    WriteStr(fs,VirtualString("Name"))
                    WriteStr(fs,VirtualString("Author"))
                    WriteStr(fs,VirtualString("Desc"))
                    WriteStr(fs,VirtualString("Version"))
                    WriteWord(fs,VirtualInteger("Compatible"))

                    { What information is contained: }                    
                    If VirtualVariableExists("button") then WriteByte(fs,GET_BUTTON)
                    If VirtualVariableExists("radiobutton") then WriteByte(fs,GET_RADIOBUTTON)
                    If VirtualVariableExists("checkbox") then WriteByte(fs,GET_CHECKBOX)
                    If VirtualVariableExists("textbox") then WriteByte(fs,GET_TEXTBOX)
                    If VirtualVariableExists("text") then WriteByte(fs,GET_TEXT)
                    If VirtualVariableExists("dropdown") then WriteByte(fs,GET_DROPDOWN)
                    If VirtualVariableExists("tab") then WriteByte(fs,GET_TAB)
                    If VirtualVariableExists("frame") then WriteByte(fs,GET_FRAME)
                    If VirtualVariableExists("listbox") then WriteByte(fs,GET_LISTBOX)
                    WriteByte(fs,255) // End Of Info                    

                    
                    If VirtualVariableExists("button") and (VirtualBoolean("button")=TRUE) then
                
                        { Buttons }
                        WriteStr(fs,VirtualString("button_normal_fontName"))
                        WriteByte(fs,VirtualInteger("button_normal_fontSize"))
                        WriteByte(fs,VirtualInteger("button_normal_fontStyle"))
                        hex = HexAs6(VirtualString("button_normal_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("button_normal_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("button_normal_textAlignment"))
                        WriteBool(fs,VirtualBoolean("button_normal_textAAliasing"))

                        WriteStr(fs,VirtualString("button_hover_fontName"))
                        WriteByte(fs,VirtualInteger("button_hover_fontSize"))
                        WriteByte(fs,VirtualInteger("button_hover_fontStyle"))
                        hex = HexAs6(VirtualString("button_hover_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("button_hover_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("button_hover_textAlignment"))
                        WriteBool(fs,VirtualBoolean("button_hover_textAAliasing"))                

                        WriteStr(fs,VirtualString("button_focus_fontName"))
                        WriteByte(fs,VirtualInteger("button_focus_fontSize"))
                        WriteByte(fs,VirtualInteger("button_focus_fontStyle"))
                        hex = HexAs6(VirtualString("button_focus_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("button_focus_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("button_focus_textAlignment"))
                        WriteBool(fs,VirtualBoolean("button_focus_textAAliasing"))                

                        WriteStr(fs,VirtualString("button_active_fontName"))
                        WriteByte(fs,VirtualInteger("button_active_fontSize"))
                        WriteByte(fs,VirtualInteger("button_active_fontStyle"))
                        hex = HexAs6(VirtualString("button_active_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("button_active_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("button_active_textAlignment"))
                        WriteBool(fs,VirtualBoolean("button_active_textAAliasing"))

                        WriteStr(fs,VirtualString("button_disabled_fontName"))
                        WriteByte(fs,VirtualInteger("button_disabled_fontSize"))
                        WriteByte(fs,VirtualInteger("button_disabled_fontStyle"))
                        hex = HexAs6(VirtualString("button_disabled_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("button_disabled_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("button_disabled_textAlignment"))
                        WriteBool(fs,VirtualBoolean("button_disabled_textAAliasing"))
                        
                Endif
                
                
                If VirtualVariableExists("radiobutton") and (VirtualBoolean("radiobutton")=TRUE) then

                        { Radio Buttons : Unselected }
                        WriteStr(fs,VirtualString("radiobutton_normal_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_normal_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_normal_unselected_textAAliasing"))

                        WriteStr(fs,VirtualString("radiobutton_hover_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_hover_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_hover_unselected_textAAliasing"))

                        WriteStr(fs,VirtualString("radiobutton_active_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_active_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_active_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_active_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_active_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_active_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_active_unselected_textAAliasing"))

                        WriteStr(fs,VirtualString("radiobutton_disabled_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_disabled_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_disabled_unselected_textAAliasing"))

                        { Radio Buttons : Selected }
                        WriteStr(fs,VirtualString("radiobutton_normal_selected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_selected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_normal_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_normal_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_normal_selected_textAAliasing"))

                        WriteStr(fs,VirtualString("radiobutton_hover_selected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_selected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_hover_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_hover_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_hover_selected_textAAliasing"))

                        WriteStr(fs,VirtualString("radiobutton_active_selected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_active_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_active_selected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_active_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_active_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_active_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_active_selected_textAAliasing"))

                        WriteStr(fs,VirtualString("radiobutton_disabled_selected_fontName"))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_selected_fontStyle"))
                        hex = HexAs6(VirtualString("radiobutton_disabled_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("radiobutton_disabled_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("radiobutton_disabled_selected_textAAliasing"))

                Endif                  


                If VirtualVariableExists("checkbox") and (VirtualBoolean("checkbox")=TRUE) then

                        { Checkbox : Unselected }
                        WriteStr(fs,VirtualString("checkbox_normal_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_normal_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_normal_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_normal_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_normal_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_normal_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_normal_unselected_textAAliasing"))

                        WriteStr(fs,VirtualString("checkbox_hover_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_hover_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_hover_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_hover_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_hover_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_hover_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_hover_unselected_textAAliasing"))

                        WriteStr(fs,VirtualString("checkbox_active_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_active_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_active_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_active_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_active_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_active_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_active_unselected_textAAliasing"))

                        WriteStr(fs,VirtualString("checkbox_disabled_unselected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_unselected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_unselected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_disabled_unselected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_unselected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_unselected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_disabled_unselected_textAAliasing"))

                        { Checkbox : Selected }
                        WriteStr(fs,VirtualString("checkbox_normal_selected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_normal_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_normal_selected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_normal_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_normal_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_normal_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_normal_selected_textAAliasing"))

                        WriteStr(fs,VirtualString("checkbox_hover_selected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_hover_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_hover_selected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_hover_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_hover_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_hover_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_hover_selected_textAAliasing"))

                        WriteStr(fs,VirtualString("checkbox_active_selected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_active_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_active_selected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_active_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_active_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_active_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_active_selected_textAAliasing"))

                        WriteStr(fs,VirtualString("checkbox_disabled_selected_fontName"))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_selected_fontSize"))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_selected_fontStyle"))
                        hex = HexAs6(VirtualString("checkbox_disabled_selected_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_selected_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("checkbox_disabled_selected_textAlignment"))
                        WriteBool(fs,VirtualBoolean("checkbox_disabled_selected_textAAliasing"))

                Endif 

                If VirtualVariableExists("textbox") and (VirtualBoolean("textbox")=TRUE) then
                
                    { Text Box }                
                    WriteStr(fs,VirtualString("textbox_default_fontName"))
                    WriteByte(fs,VirtualInteger("textbox_default_fontSize"))
                    hex = HexAs6(VirtualString("textbox_default_fontColor_rgb"))
                    WriteByte(fs,HexInt(HexR(hex)))
                    WriteByte(fs,HexInt(HexG(hex)))
                    WriteByte(fs,HexInt(HexB(hex)))
                    WriteByte(fs,VirtualInteger("textbox_default_fontColor_alpha"))

                    hex = HexAs6(VirtualString("textbox_disabled_fontColor_rgb"))
                    WriteByte(fs,HexInt(HexR(hex)))
                    WriteByte(fs,HexInt(HexG(hex)))
                    WriteByte(fs,HexInt(HexB(hex)))
                    WriteByte(fs,VirtualInteger("textbox_disabled_fontColor_alpha"))

                    hex = HexAs6(VirtualString("textbox_selection_fontColor_rgb"))
                    WriteByte(fs,HexInt(HexR(hex)))
                    WriteByte(fs,HexInt(HexG(hex)))
                    WriteByte(fs,HexInt(HexB(hex)))
                    WriteByte(fs,VirtualInteger("textbox_selection_fontColor_alpha"))
                    hex = HexAs6(VirtualString("textbox_selection_backColor_rgb"))
                    WriteByte(fs,HexInt(HexR(hex)))
                    WriteByte(fs,HexInt(HexG(hex)))
                    WriteByte(fs,HexInt(HexB(hex)))
                    WriteByte(fs,VirtualInteger("textbox_selection_backColor_alpha")) 
                    
                    hex = HexAs6(VirtualString("textbox_cursor_color_rgb"))
                    WriteByte(fs,HexInt(HexR(hex)))
                    WriteByte(fs,HexInt(HexG(hex)))
                    WriteByte(fs,HexInt(HexB(hex)))
                    WriteByte(fs,VirtualInteger("textbox_cursor_color_alpha"))
                    WriteByte(fs,VirtualInteger("textbox_cursor_width"))
                    WriteByte(fs,VirtualInteger("textbox_cursor_height"))
                    
                    WriteByte(fs,VirtualInteger("textbox_pointer_width"))
                    
                Endif
                
                
                If VirtualVariableExists("text") and (VirtualBoolean("text")=TRUE) then
                
                        { Tabs }
                        WriteStr(fs,VirtualString("text_normal_fontName"))
                        WriteByte(fs,VirtualInteger("text_normal_fontSize"))
                        WriteByte(fs,VirtualInteger("text_normal_fontStyle"))
                        hex = HexAs6(VirtualString("text_normal_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("text_normal_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("text_normal_textAlignment"))
                        WriteBool(fs,VirtualBoolean("text_normal_textAAliasing"))

                        WriteStr(fs,VirtualString("text_title_fontName"))
                        WriteByte(fs,VirtualInteger("text_title_fontSize"))
                        WriteByte(fs,VirtualInteger("text_title_fontStyle"))
                        hex = HexAs6(VirtualString("text_title_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("text_title_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("text_title_textAlignment"))
                        WriteBool(fs,VirtualBoolean("text_title_textAAliasing"))

                        WriteStr(fs,VirtualString("text_href_fontName"))
                        WriteByte(fs,VirtualInteger("text_href_fontSize"))
                        WriteByte(fs,VirtualInteger("text_href_fontStyle"))
                        hex = HexAs6(VirtualString("text_href_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("text_href_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("text_href_textAlignment"))
                        WriteBool(fs,VirtualBoolean("text_href_textAAliasing"))
                        
                Endif

                If VirtualVariableExists("dropdown") and (VirtualBoolean("dropdown")=TRUE) then
                
                        { Drop Downs }
                        WriteStr(fs,VirtualString("dropdown_normal_fontName"))
                        WriteByte(fs,VirtualInteger("dropdown_normal_fontSize"))
                        WriteByte(fs,VirtualInteger("dropdown_normal_fontStyle"))
                        hex = HexAs6(VirtualString("dropdown_normal_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("dropdown_normal_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("dropdown_normal_textAlignment"))
                        WriteBool(fs,VirtualBoolean("dropdown_normal_textAAliasing"))

                        WriteStr(fs,VirtualString("dropdown_hover_fontName"))
                        WriteByte(fs,VirtualInteger("dropdown_hover_fontSize"))
                        WriteByte(fs,VirtualInteger("dropdown_hover_fontStyle"))
                        hex = HexAs6(VirtualString("dropdown_hover_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("dropdown_hover_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("dropdown_hover_textAlignment"))
                        WriteBool(fs,VirtualBoolean("dropdown_hover_textAAliasing"))

                        WriteStr(fs,VirtualString("dropdown_active_fontName"))
                        WriteByte(fs,VirtualInteger("dropdown_active_fontSize"))
                        WriteByte(fs,VirtualInteger("dropdown_active_fontStyle"))
                        hex = HexAs6(VirtualString("dropdown_active_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("dropdown_active_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("dropdown_active_textAlignment"))
                        WriteBool(fs,VirtualBoolean("dropdown_active_textAAliasing"))

                        WriteStr(fs,VirtualString("dropdown_disabled_fontName"))
                        WriteByte(fs,VirtualInteger("dropdown_disabled_fontSize"))
                        WriteByte(fs,VirtualInteger("dropdown_disabled_fontStyle"))
                        hex = HexAs6(VirtualString("dropdown_disabled_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("dropdown_disabled_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("dropdown_disabled_textAlignment"))
                        WriteBool(fs,VirtualBoolean("dropdown_disabled_textAAliasing"))
                        
                        { Drop Downs : Boxes }
                        WriteByte(fs,VirtualInteger("dropdown_box_above_yoffset") + 128)
                        WriteByte(fs,VirtualInteger("dropdown_box_below_yoffset") + 128)
                        
                        WriteStr(fs,VirtualString("dropdown_box_normal_fontName"))
                        WriteByte(fs,VirtualInteger("dropdown_box_normal_fontSize"))
                        WriteByte(fs,VirtualInteger("dropdown_box_normal_fontStyle"))
                        hex = HexAs6(VirtualString("dropdown_box_normal_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("dropdown_box_normal_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("dropdown_box_normal_textAlignment"))
                        WriteBool(fs,VirtualBoolean("dropdown_box_normal_textAAliasing"))

                        WriteStr(fs,VirtualString("dropdown_box_hover_fontName"))
                        WriteByte(fs,VirtualInteger("dropdown_box_hover_fontSize"))
                        WriteByte(fs,VirtualInteger("dropdown_box_hover_fontStyle"))
                        hex = HexAs6(VirtualString("dropdown_box_hover_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("dropdown_box_hover_fontColor_alpha"))
                        hex = HexAs6(VirtualString("dropdown_box_hover_backColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("dropdown_box_hover_backColor_alpha"))
                        WriteByte(fs,VirtualInteger("dropdown_box_hover_textAlignment"))
                        WriteBool(fs,VirtualBoolean("dropdown_box_hover_textAAliasing"))
                        
                Endif
                
                
                If VirtualVariableExists("tab") and (VirtualBoolean("tab")=TRUE) then
                
                        { Tabs }
                        WriteStr(fs,VirtualString("tab_inactive_fontName"))
                        WriteByte(fs,VirtualInteger("tab_inactive_fontSize"))
                        WriteByte(fs,VirtualInteger("tab_inactive_fontStyle"))
                        hex = HexAs6(VirtualString("tab_inactive_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("tab_inactive_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("tab_inactive_textAlignment"))
                        WriteBool(fs,VirtualBoolean("tab_inactive_textAAliasing"))

                        WriteStr(fs,VirtualString("tab_hover_fontName"))
                        WriteByte(fs,VirtualInteger("tab_hover_fontSize"))
                        WriteByte(fs,VirtualInteger("tab_hover_fontStyle"))
                        hex = HexAs6(VirtualString("tab_hover_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("tab_hover_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("tab_hover_textAlignment"))
                        WriteBool(fs,VirtualBoolean("tab_hover_textAAliasing"))

                        WriteStr(fs,VirtualString("tab_active_fontName"))
                        WriteByte(fs,VirtualInteger("tab_active_fontSize"))
                        WriteByte(fs,VirtualInteger("tab_active_fontStyle"))
                        hex = HexAs6(VirtualString("tab_active_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("tab_active_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("tab_active_textAlignment"))
                        WriteBool(fs,VirtualBoolean("tab_active_textAAliasing"))
                        
                Endif
                

                If VirtualVariableExists("frame") and (VirtualBoolean("frame")=TRUE) then
                
                        { Frames }
                        WriteStr(fs,VirtualString("frame_tab_fontName"))
                        WriteByte(fs,VirtualInteger("frame_tab_fontSize"))
                        WriteByte(fs,VirtualInteger("frame_tab_fontStyle"))
                        hex = HexAs6(VirtualString("frame_tab_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("frame_tab_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("frame_tab_textAlignment"))
                        WriteBool(fs,VirtualBoolean("frame_tab_textAAliasing"))

                        WriteStr(fs,VirtualString("frame_roundborder_fontName"))
                        WriteByte(fs,VirtualInteger("frame_roundborder_fontSize"))
                        WriteByte(fs,VirtualInteger("frame_roundborder_fontStyle"))
                        hex = HexAs6(VirtualString("frame_roundborder_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("frame_roundborder_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("frame_roundborder_textAlignment"))
                        WriteBool(fs,VirtualBoolean("frame_roundborder_textAAliasing"))
                        
                        WriteStr(fs,VirtualString("frame_roundsolid_fontName"))
                        WriteByte(fs,VirtualInteger("frame_roundsolid_fontSize"))
                        WriteByte(fs,VirtualInteger("frame_roundsolid_fontStyle"))
                        hex = HexAs6(VirtualString("frame_roundsolid_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("frame_roundsolid_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("frame_roundsolid_textAlignment"))
                        WriteBool(fs,VirtualBoolean("frame_roundsolid_textAAliasing"))

                        WriteStr(fs,VirtualString("frame_squareborder_fontName"))
                        WriteByte(fs,VirtualInteger("frame_squareborder_fontSize"))
                        WriteByte(fs,VirtualInteger("frame_squareborder_fontStyle"))
                        hex = HexAs6(VirtualString("frame_squareborder_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("frame_squareborder_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("frame_squareborder_textAlignment"))
                        WriteBool(fs,VirtualBoolean("frame_squareborder_textAAliasing"))

                        WriteStr(fs,VirtualString("frame_squaresolid_fontName"))
                        WriteByte(fs,VirtualInteger("frame_squaresolid_fontSize"))
                        WriteByte(fs,VirtualInteger("frame_squaresolid_fontStyle"))
                        hex = HexAs6(VirtualString("frame_squaresolid_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("frame_squaresolid_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("frame_squaresolid_textAlignment"))
                        WriteBool(fs,VirtualBoolean("frame_squaresolid_textAAliasing"))
                        
                        WriteStr(fs,VirtualString("frame_mockwindow_fontName"))
                        WriteByte(fs,VirtualInteger("frame_mockwindow_fontSize"))
                        WriteByte(fs,VirtualInteger("frame_mockwindow_fontStyle"))
                        hex = HexAs6(VirtualString("frame_mockwindow_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("frame_mockwindow_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("frame_mockwindow_textAlignment"))
                        WriteBool(fs,VirtualBoolean("frame_mockwindow_textAAliasing"))

                        WriteStr(fs,VirtualString("frame_header_fontName"))
                        WriteByte(fs,VirtualInteger("frame_header_fontSize"))
                        WriteByte(fs,VirtualInteger("frame_header_fontStyle"))
                        hex = HexAs6(VirtualString("frame_header_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("frame_header_fontColor_alpha"))
                        WriteByte(fs,VirtualInteger("frame_header_textAlignment"))
                        WriteBool(fs,VirtualBoolean("frame_header_textAAliasing"))
                                                                        
                Endif
                

                If VirtualVariableExists("listbox") and (VirtualBoolean("listbox")=TRUE) then

                        { ListBox Items }                        
                        WriteStr(fs,VirtualString("listbox_normal_fontName"))
                        WriteByte(fs,VirtualInteger("listbox_normal_fontSize"))
                        WriteByte(fs,VirtualInteger("listbox_normal_fontStyle"))
                        hex = HexAs6(VirtualString("listbox_normal_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("listbox_normal_fontColor_alpha"))
                        hex = HexAs6(VirtualString("listbox_normal_backColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,255)
                        WriteByte(fs,VirtualInteger("listbox_normal_textAlignment"))
                        WriteBool(fs,VirtualBoolean("listbox_normal_textAAliasing"))

                        WriteStr(fs,VirtualString("listbox_hover_fontName"))
                        WriteByte(fs,VirtualInteger("listbox_hover_fontSize"))
                        WriteByte(fs,VirtualInteger("listbox_hover_fontStyle"))
                        hex = HexAs6(VirtualString("listbox_hover_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("listbox_hover_fontColor_alpha"))
                        hex = HexAs6(VirtualString("listbox_hover_backColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,255)
                        WriteByte(fs,VirtualInteger("listbox_hover_textAlignment"))
                        WriteBool(fs,VirtualBoolean("listbox_hover_textAAliasing"))
                        
                        WriteStr(fs,VirtualString("listbox_active_fontName"))
                        WriteByte(fs,VirtualInteger("listbox_active_fontSize"))
                        WriteByte(fs,VirtualInteger("listbox_active_fontStyle"))
                        hex = HexAs6(VirtualString("listbox_active_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("listbox_active_fontColor_alpha"))
                        hex = HexAs6(VirtualString("listbox_active_backColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,255)
                        WriteByte(fs,VirtualInteger("listbox_active_textAlignment"))
                        WriteBool(fs,VirtualBoolean("listbox_active_textAAliasing"))
                        
                        WriteStr(fs,VirtualString("listbox_disabled_fontName"))
                        WriteByte(fs,VirtualInteger("listbox_disabled_fontSize"))
                        WriteByte(fs,VirtualInteger("listbox_disabled_fontStyle"))
                        hex = HexAs6(VirtualString("listbox_disabled_fontColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,VirtualInteger("listbox_disabled_fontColor_alpha"))
                        hex = HexAs6(VirtualString("listbox_disabled_backColor_rgb"))
                        WriteByte(fs,HexInt(HexR(hex)))
                        WriteByte(fs,HexInt(HexG(hex)))
                        WriteByte(fs,HexInt(HexB(hex)))
                        WriteByte(fs,255)
                        WriteByte(fs,VirtualInteger("listbox_disabled_textAlignment"))
                        WriteBool(fs,VirtualBoolean("listbox_disabled_textAAliasing"))
                        
                Endif



                WriteByte(fs,255) // Completed OK.
            
                Closefile(fs)
                
                If FileExists("log/themecompiler.log") then DeleteFile("log/themecompiler.log")
                fs = WriteFile("log/themecompiler.log")
                    WriteLn(fs,"Compile took: "+ToString(Millisecs-m)+" Millisecs")
                    WriteLn(fs,"Compat ver: "+ToString(COMPATIBLE))
                    WriteLn(fs,"Compiler Revision: "+REVISION)
                CloseFile(fs)

                
                
            
            Endif
        Endif
        
    Endif

End
