{
    
    Lexini - The perfect way to parse .ini files for Cobra
    
    ---------------------------------------
    
    With a full lexer, tokeniser and parser, Lexini is robust enough
    to handle any syntax errors - and provides helpful feedback on the
    exact nature and location of the error.
    
    In addition to the usual integer, string and floating-point variables,
    Lexini supports binary (e.g. %101011) and hexadecimal (e.g. #FFF) values.
    
    Variables are seamlessly coerced into the requested data type,
    e.g. a hex value of #FF will return 255 as an integer, but
    "#FF" as a string. A TRUE/FALSE boolean flag returns "TRUE" or "FALSE"
    as a string.
    
    Exported functions:
    
        IniLoad(fileName: String), returns ^iniFiles
        IniSelectSection(iniFile, sectionName), returns TRUE on success
        IniFree(iniFile: ^iniFiles)
        
        IniAsInteger(variableName), returns Integer
        IniAsString(variableName), returns String
        IniAsReal(variableName), returns Real
        IniAsBoolean(variableName), returns Boolean
        
        (The four IniAs* functions above take an optional Second parameter to
         use as a default value in the event of an error)
        
    Syntax:
    
        ; comments
        [section]                ; required!
        integerVariable =123
        realVariable   = 0.123
        realVariable   = .123    ; Leading digits optional
        hexVariable    = #Ff     ; e.g. 255, case insensitive
        negativeHex    = -#FF    ; e.g. -255 
        singleFlag     = %1      ; e.g. true
        singleFlag     = %0      ; e.g. false
        multipleFlags  = %110101
        stringVariable = "My String with \"escaped strings\" example"      
    
    ---------------------------------------
    
    Copyright (c) 2010 Ben Golightly

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.
    
    ---------------------------------------        

}
Unit

Const

    // Version
    INI_VERSION = 20100711 ; export

    // Config
    SUPPRESS_ERRORS     = FALSE // supresses error messageboxes
    
    // Variable Types
    VAR_TYPE_NULL       = 0
    VAR_TYPE_INT        = 1
    VAR_TYPE_FLOAT      = 2
    VAR_TYPE_STRING     = 3
    VAR_TYPE_HEX        = 4
    VAR_TYPE_BIN        = 5
    VAR_TYPE_BIN_SINGLE = 6

    // Tokens
    TOKEN_INVALID       = 0
    TOKEN_INT           = 1
    TOKEN_FLOAT         = 2
    TOKEN_STRING        = 3 // does not include quotes
    TOKEN_HEX           = 4 // #hexadecimal
    TOKEN_BIN           = 5 // %binary
    TOKEN_EQUALS        = 6
    TOKEN_QUOTE         = 7 // "
    TOKEN_SECTION       = 8 // [section]
    TOKEN_IDENT         = 9 // variable names
    TOKEN_OPEN_BRACKET  = 10 // [
    TOKEN_CLOSE_BRACKET = 11 // ]
    TOKEN_NEWLINE       = 12
    TOKEN_END_STREAM    = 13 // End of token stream
    
    // Lexer States
    LEXER_STATE_NO_STR  = 0
    LEXER_STATE_IN_STR  = 1
    LEXER_STATE_END_STR = 2

    // Lexer States
    LEXER_STATE_NO_SEC  = 0
    LEXER_STATE_IN_SEC  = 1
    LEXER_STATE_END_SEC = 2

// Types used locally:

Type sStrings = Record
    s: String = ""
EndType ; export

Type iniVariables = Record
    name: ^sStrings
    vType: Integer  = VAR_TYPE_NULL
    iValue: Integer = 0
    rValue: Real    = 0.0
    sValue: ^sStrings    
EndType ; export

Type iniSections = Record
    name: ^sStrings
    variableList: List of iniVariables
EndType ; export

Type iniFiles = Record
    sectionList: List of iniSections
EndType ; export

// Types used by parser

Type iniParserIdents = Record
    name: String = ""
    lexeme: String = ""
    vType: Integer = VAR_TYPE_NULL
EndType

Type iniParserSections = Record
    name: String = ""
    identList: List of iniParserIdents
EndType

Type iniSourceLines = Record
    s : String = ""
EndType

Var
    iniSourceList   : List of iniSourceLines
    iniFileList     : List of iniFiles
    iniCurrLine     : ^iniSourceLines
    iniCurrSection  : ^iniSections
    iniCurrSectionExists: Boolean = FALSE
    
    iniLexer_index0    : Integer = 0
    iniLexer_index1    : Integer = 0
    iniLexer_currToken : Integer
    iniLexer_currLexeme: String = ""
    iniLexer_currStringState : Integer
    iniLexer_currSectionState: Integer
    
    iniParserSectionList: List of iniParserSections
    
    iniErrors: Integer

Function IniLoad(filename: String) : ^iniFiles ; export
Begin
    result = Ini_Load(filename)
End

Procedure IniFree(iniFile: ^iniFiles) ; export
Begin
    Ini_Free(iniFile)
End

Function IniSelectSection(iniFile: ^iniFiles, sectionName: String) : Boolean ; export
Begin
    result = Ini_SelectSection(iniFile, sectionName)
End

Function IniAsInt(variableName: String, fault: Integer = 0): Integer ; export
Begin
    result = IniAsInteger(variableName, fault)
End

Function IniAsInteger(variableName: String, fault: Integer = 0): Integer ; export
Var
    iniVariable: ^iniVariables
Begin
    result = fault
    If iniCurrSectionExists = FALSE then exit
    
    Loop iniVariable through iniCurrSection.variableList
        If iniVariable.name.s = variableName then 
            result = Ini_CoerceValueToInt(iniVariable)
            exit
        Endif
    EndLoop
End

Function IniAsReal(variableName: String, fault: Real = 0.0): Real ; export
Var
    iniVariable: ^iniVariables
Begin
    result = fault
    If iniCurrSectionExists = FALSE then exit
    
    Loop iniVariable through iniCurrSection.variableList
        If iniVariable.name.s = variableName then 
            result = Ini_CoerceValueToFloat(iniVariable)
            exit
        Endif
    EndLoop
End

Function IniAsString(variableName: String, fault: String = ""): String ; export
Var
    iniVariable: ^iniVariables
Begin
    result = fault
    If iniCurrSectionExists = FALSE then exit
    
    Loop iniVariable through iniCurrSection.variableList
        If iniVariable.name.s = variableName then 
            result = Ini_CoerceValueToString(iniVariable)
            exit
        Endif
    EndLoop
End

Function IniAsBoolean(variableName: String, fault: Boolean = FALSE): Boolean ; export
Var
    iniVariable: ^iniVariables
Begin
    result = fault
    If iniCurrSectionExists = FALSE then exit
    
    Loop iniVariable through iniCurrSection.variableList
        If iniVariable.name.s = variableName then 
            result = Ini_CoerceValueToBoolean(iniVariable)
            exit
        Endif
    EndLoop
End

Procedure Ini_Free(iniFile: ^iniFiles)
Var
    iniSection: ^iniSections
    iniVariable: ^iniVariables
Begin
    If ItemInList(iniFileList, iniFile) = -1 then exit
    
    Loop iniSection through iniFile.sectionList
        Loop iniVariable through iniCurrSection.variableList
            Free(iniVariable.name)
            Free(iniVariable.sValue)
            Free(iniVariable)
        EndLoop
    
        Free(iniSection.name)
        Free(iniSection)        
    EndLoop
End

Function Ini_SelectSection(iniFile: ^iniFiles, sectionName: String) : Boolean ; export
Var
    iniSection: ^iniSections
Begin
    result = FALSE
    iniCurrSectionExists = FALSE
    
    If ItemInList(iniFileList, iniFile) = -1 then exit
    
    Loop iniSection through iniFile.sectionList
        If iniSection.name.s = sectionName then
            result = TRUE
            iniCurrSectionExists = TRUE
            iniCurrSection = iniSection
        Endif
    EndLoop

End

Function Ini_Load(filename: String) : ^iniFiles ; export
{
    Asm_Assemble
    mfi: MemFile containing assembly code to assemble
    Returns a MemFile containing assembled machine code
    
    * Assembler is init'd if it hasn't been already
    * Each Line of code is put into the asmSourceList list
}
Var
    m: Integer
    s: String
    i: Integer
    
    iniSourceLine: ^iniSourceLines
    iniParserSection: ^iniParserSections
    iniParserIdent: ^iniParserIdents
    
    iniSection: ^iniSections
    iniVariable: ^iniVariables
    sString: ^sStrings
    
    currParserSection: ^iniParserSections
    existsParserSection: Boolean = FALSE
    
    currParserIdent: ^iniParserIdents
    existsIdent: Boolean = FALSE
    
    bracketOpen: Boolean = FALSE
    
    mf: Element
    
    bytes: Integer
    
Begin
    m = Millisecs
    
    If FileExists(filename) = FALSE then
        Ini_Error("File doesn't exist at '"+filename+"'")
        exit
    Endif
    
    mf = CreateMemFile()
    LoadToMemFile(mf, filename)
    If mf = NULL then
        Ini_Error("NULL input!")
        exit
    Endif
    
    // Strip whitespace & comments
    While Not EOF(mf)
        s = ReadLn(mf)
        s = Ini_StripComments(s)
        s = Ini_StripWhitespace(s)        
        iniSourceLine = NewItem(iniSourceList)
        iniSourceLine.s = s + Chr(10)
    Wend
    Closefile(mf)
    
    // Resets
    Ini_ResetLexer()
    iniErrors = 0
    
    
    While (TRUE)
        If (Ini_GetNextToken() = TOKEN_END_STREAM) then break 

        Case iniLexer_currToken of
            // QUOTE
            
            (TOKEN_SECTION):
                currParserSection = Ini_AddSection(iniLexer_currLexeme)
                existsParserSection = TRUE
            
            (TOKEN_IDENT):
                If existsParserSection = FALSE then
                    Ini_ExpectedError("[section] definition")
                    break
                Endif
                If existsIdent = TRUE then
                    Ini_UnexpectedError("identifier")
                    break
                Endif
                currParserIdent = Ini_AddIdent(currParserSection, iniLexer_currLexeme)
                existsIdent = TRUE
            
            (TOKEN_EQUALS):
                If existsIdent = FALSE then
                    Ini_UnexpectedError("=")
                    break
                Endif           
                
            (TOKEN_OPEN_BRACKET):
                If bracketOpen = TRUE then
                    Ini_UnexpectedError("[") ; break
                Else
                    bracketOpen = TRUE
                Endif
            
            (TOKEN_CLOSE_BRACKET):
                If bracketOpen = FALSE then
                    Ini_UnexpectedError("]") ; break
                Else
                    bracketOpen = FALSE
                Endif
                If (Ini_GetNextToken() <> TOKEN_NEWLINE) then Ini_ExpectedError("line break"); break
                
            (TOKEN_NEWLINE):
                If bracketOpen then Ini_ExpectedError("]"); break
                If existsIdent = TRUE then Ini_UnexpectedError("newline"); break
            
            (TOKEN_INVALID):
                Ini_UnexpectedError("unkown '"+iniLexer_currLexeme+"'"); break
            
            (TOKEN_QUOTE):
                
            Default:
            
            // remaining token types
                If existsIdent = FALSE then
                    Ini_UnexpectedError("value")
                    break
                Endif
                currParserIdent.lexeme = iniLexer_currLexeme
                existsIdent = FALSE
                
                Case iniLexer_currToken of
                    (TOKEN_INT): currParserIdent.vType = VAR_TYPE_INT
                    (TOKEN_FLOAT): currParserIdent.vType = VAR_TYPE_FLOAT
                    (TOKEN_STRING): currParserIdent.vType = VAR_TYPE_STRING
                    (TOKEN_BIN):
                        If Length(iniLexer_currLexeme) = 2 then
                            currParserIdent.vType = VAR_TYPE_BIN_SINGLE
                        Else
                            currParserIdent.vType = VAR_TYPE_BIN
                        Endif
                    (TOKEN_HEX): currParserIdent.vType = VAR_TYPE_HEX
                    Default: Ini_CodeError("Unkown token value type ("+iniLexer_currToken+")")
                EndCase
                            
        EndCase
    Wend
    
    
    If (iniErrors > 0) then
        Ini_Error("Aborted reading "+filename+" due to "+iniErrors+" error(s).")
    Else
        // Apply to persistant structures
        
        // New iniFile
        result = NewItem(iniFileList)
        
        // New iniSections
        Loop iniParserSection through iniParserSectionList
            iniSection = NewItem(result.sectionList)
            New(iniSection.name)
            iniSection.name.s = iniParserSection.name
            
            // New iniVariables
            Loop iniParserIdent through iniParserSection.identList
                iniVariable = NewItem(iniSection.variableList)
                New(iniVariable.name)
                New(iniVariable.sValue)
                iniVariable.name.s = iniParserIdent.name
                iniVariable.vType = iniParserIdent.vType
                
                Case iniVariable.vType of
                    (VAR_TYPE_INT):         iniVariable.iValue = ToInt(iniParserIdent.lexeme)
                    (VAR_TYPE_FLOAT):       iniVariable.rValue = ToReal(iniParserIdent.lexeme)
                    (VAR_TYPE_STRING):      iniVariable.sValue.s = iniParserIdent.lexeme
                    (VAR_TYPE_HEX):         iniVariable.sValue.s = iniParserIdent.lexeme
                    (VAR_TYPE_BIN):         iniVariable.sValue.s = iniParserIdent.lexeme
                    (VAR_TYPE_BIN_SINGLE):  iniVariable.iValue = BinStringToInt(iniParserIdent.lexeme)                
                EndCase
                
            EndLoop
            
        EndLoop
        

    Endif
         
    iniErrors = 0
    
    // Free
    Loop iniParserSection through iniParserSectionList
        Loop iniParserIdent through iniParserSection.identList
            Free(iniParserIdent)
        EndLoop
        Free(iniParserSection)
    EndLoop
    
    Loop iniParserSection through iniParserSectionList
        Free(iniParserSection)
    EndLoop
    
    Loop iniSourceLine through iniSourceList
        Free(iniSourceLine)
    EndLoop
    
End

Function Ini_AddSection(s: String): ^iniParserSections
Var
    iniParserSection: ^iniParserSections
Begin
    
    // Return existing
    Loop iniParserSection through iniParserSectionList
        If s = iniParserSection.name then
            result = iniParserSection
            exit
        Endif
    EndLoop
    
    // Create new
    iniParserSection = NewItem(iniParserSectionList)
    iniParserSection.name = s
    result = iniParserSection
    
End

Function Ini_AddIdent(section: ^iniParserSections, s: String): ^iniParserIdents
Var
    iniParserIdent: ^iniParserIdents
Begin
    
    // Return existing
    Loop iniParserIdent through section.identList
        If s = iniParserIdent.name then
            result = iniParserIdent
            exit
        Endif
    EndLoop
    
    // Create new
    iniParserIdent = NewItem(section.identList)
    iniParserIdent.name = s
    result = iniParserIdent
    
End

Function Ini_GetNextToken() : Integer
Var
    l, i: Integer
    c: String
    continue: Boolean = FALSE
Begin

    iniLexer_index0 = iniLexer_index1
    result = TOKEN_INVALID
    
    // Advance to next Line as necessary
    l = Length(iniCurrLine.s)
    If iniLexer_index0 >= l then
        If Ini_LexerNextLine() = FALSE then
            result = TOKEN_END_STREAM
            exit
        Endif
    Endif
    
    If (iniLexer_currStringState = LEXER_STATE_END_STR) then iniLexer_currStringState = LEXER_STATE_NO_STR
    If (iniLexer_currSectionState = LEXER_STATE_END_SEC) then iniLexer_currSectionState = LEXER_STATE_NO_SEC

    // Scan through all potential whitespace    
    If (iniLexer_currStringState <> LEXER_STATE_IN_STR) then
    
        While (TRUE)
            c = Mid(iniCurrLine.s, iniLexer_index0+1, 1)
            If Ini_CharIsWhiteSpace(c) = FALSE then break
            Inc(iniLexer_index0)
        Wend
        
    Endif
    
    iniLexer_index1 = iniLexer_index0
    
    
    
    // Scan through lexeme until a delimiter is met, incrementing index1    
    While (TRUE)
        Conditions
        (iniLexer_currStringState = LEXER_STATE_IN_STR):
            continue = FALSE
        
            l = Length(iniCurrLine.s)
        
            // Strings cannot span multiple lines
            If iniLexer_index1 >= l then
                iniLexer_currToken = TOKEN_INVALID
                result = iniLexer_currToken
                exit 
            Endif
            
            c = Mid(iniCurrLine.s, iniLexer_index1+1, 1)
            
            // Backslash
            If c = '\' then
                iniLexer_index1 = iniLexer_index1 + 2
                continue = TRUE
            Endif  
            
            // Double quote
            If (continue = FALSE) and (c = '"') then
                break            
            Endif
            
            If (continue = FALSE) then Inc(iniLexer_index1) 
        
        (iniLexer_currSectionState = LEXER_STATE_IN_SEC):
        
            l = Length(iniCurrLine.s)
        
            // Sections cannot span multiple lines
            If iniLexer_index1 >= l then
                iniLexer_currToken = TOKEN_INVALID
                result = iniLexer_currToken
                exit 
            Endif
            
            c = Mid(iniCurrLine.s, iniLexer_index1+1, 1) 
            
            // End section
            If (c = ']') then
                break            
            Endif
            
            Inc(iniLexer_index1) 
        
        Default:
            
            l = Length(iniCurrLine.s)
            If iniLexer_index1 >= l then break
            
            c = Mid(iniCurrLine.s, iniLexer_index1+1, 1)
            
            If Ini_CharIsDelim(c) then break
            
            Inc(iniLexer_index1)
        
        EndConditions       
    Wend
    
    If (iniLexer_index1 - iniLexer_index0) = 0 then Inc(iniLexer_index1)
    iniLexer_currLexeme = ""
    iniLexer_currToken = TOKEN_INVALID
    
    
    
    // Lexeme Isolatted, lies between index0 and index1
    For i = iniLexer_index0 to iniLexer_index1-1
    
        If (iniLexer_currStringState = LEXER_STATE_IN_STR) then
            If Mid(iniCurrLine.s, iniLexer_index1+1, 1) = '\' then
                Inc(i)
            Endif
        Endif
        
        iniLexer_currLexeme = iniLexer_currLexeme + Mid(iniCurrLine.s, i+1, 1)
    
    Next
    
    l = Length(iniLexer_currLexeme) 
    
        
    // Token Identification
    
    // A string token
    If (l > 1) or (Left(iniLexer_currLexeme, 1) <> '"') then
        If (iniLexer_currStringState = LEXER_STATE_IN_STR) then
            iniLexer_currToken = TOKEN_STRING
            result = iniLexer_currToken
            exit
        Endif
    Endif
    
    // A section token
    If (l > 1) then
        If (iniLexer_currSectionState = LEXER_STATE_IN_SEC) then
            iniLexer_currToken = TOKEN_SECTION
            result = iniLexer_currToken
            exit
        Endif
    Endif
    
    If l = 1 then
        // Single-character tokens
        
        Conditions
            
            (iniLexer_currLexeme = '"'):
                Case iniLexer_currStringState of
                    (LEXER_STATE_NO_STR):  iniLexer_currStringState = LEXER_STATE_IN_STR
                    (LEXER_STATE_IN_STR):  iniLexer_currStringState = LEXER_STATE_END_STR
                EndCase
                iniLexer_currToken = TOKEN_QUOTE
                
            (iniLexer_currLexeme = '['):
                iniLexer_currToken = TOKEN_OPEN_BRACKET
                iniLexer_currSectionState = LEXER_STATE_IN_SEC
            (iniLexer_currLexeme = ']'):
                iniLexer_currToken = TOKEN_CLOSE_BRACKET
                iniLexer_currSectionState = LEXER_STATE_END_SEC
            
            (iniLexer_currLexeme = '='):                iniLexer_currToken = TOKEN_EQUALS
            (iniLexer_currLexeme = Chr(10)):            iniLexer_currToken = TOKEN_NEWLINE
            (ini_CharIsNumeric(iniLexer_currLexeme)):   iniLexer_CurrToken = TOKEN_INT
            (ini_CharIsIdent(iniLexer_currLexeme)):     iniLexer_CurrToken = TOKEN_IDENT
            
        EndConditions
        
        
    Else
        // Multi-character tokens
        
        Conditions
            (ini_StringIsInt(iniLexer_currLexeme)):         iniLexer_CurrToken = TOKEN_INT
            (ini_StringIsFloat(iniLexer_currLexeme)):       iniLexer_CurrToken = TOKEN_FLOAT
            (ini_StringIsHex(iniLexer_currLexeme)):         iniLexer_CurrToken = TOKEN_HEX
            (ini_StringIsBinary(iniLexer_currLexeme)):      iniLexer_CurrToken = TOKEN_BIN
            (ini_StringIsIdent(iniLexer_currLexeme)):       iniLexer_CurrToken = TOKEN_IDENT
        EndConditions
        
    Endif
    
    result = iniLexer_currToken

End

Function Ini_LexerNextLine() : Boolean
Begin

    If iniCurrLine = LastItem(iniSourceList) then result = FALSE ; exit
    
    iniCurrLine = NextItem(iniSourceList, iniCurrLine)
    
    iniLexer_currStringState = LEXER_STATE_NO_STR
    iniLexer_index0 = 0
    iniLexer_index1 = 0
    
    result = TRUE

End

Function Ini_LexerLookAhead() : String
Var
    index: Integer
    c: String = ""
    tmp_iniCurrLine : ^iniSourceLines
Begin
    result = ""

    index = iniLexer_index1
    tmp_iniCurrLine = iniCurrLine
    
    
    If (iniLexer_currStringState <> LEXER_STATE_IN_STR)
        While (TRUE)
        
            If (index >= Length(iniCurrLine.s)) then
                If iniCurrLine = LastItem(iniSourceList) then
                    iniCurrLine = tmp_iniCurrLine
                    exit
                Else
                    iniCurrLine = NextItem(iniSourceList, iniCurrLine)
                Endif
                
                index = 0
            Endif
            
            c = Mid(iniCurrLine.s, index+1, 1)
            If (Ini_CharIsWhiteSpace(c) = FALSE) then break
            Inc(index)
                    
        Wend
    Endif
    
    result = c    

    // Reset line
    iniCurrLine = tmp_iniCurrLine
    
End

Procedure Ini_ResetLexer()
Begin
    iniCurrLine = FirstItem(iniSourceList)
    iniLexer_index0 = 0
    iniLexer_index1 = 0
    iniLexer_currToken = TOKEN_INVALID
    iniLexer_currStringState = LEXER_STATE_NO_STR
    iniLexer_currSectionState = LEXER_STATE_NO_SEC
End

Function Ini_StripComments(s: String) : String
Var
    bInStr: Boolean = FALSE
    i: Integer
    c, lastc: String = ""
Begin
    If (Instr(s, ';') = 0) then
        result = s
        exit
    Endif

    For i = 1 to Length(s)
        lastc = c
        c = Mid(s, i, 1)
        
        If (c = '"') and (lastc <> '\') then bInStr = Not bInStr
        
        If (c = ';') then
            If bInStr = FALSE then
                result = Left(s, i-1)
                exit
            Endif
        Endif 
    Next
    
    result = s

End

Function Ini_StripWhitespace(s: String) : String
Var
    i, l: Integer
    c, r: String
    
    lw, rw: Integer = 1
    ld: Boolean = FALSE
Begin
    result = s
    l = Length(s)
    If l = 0 then exit
    
    For i = 1 to l    
        c = Mid(s, i, 1)
        
        If Ini_CharIsWhitespace(c) then
            If ld = FALSE then
                lw = i + 1
            Endif
        Else
            ld = TRUE
            rw = i
        Endif
        
    Next
    
    result = Mid(s, lw, rw-lw+1)
    
    
End

Function Ini_CharIsNumeric(c: String) : Boolean
Var
    a: Integer
Begin
    a = Asc(c)    
    If (a >= 48) and (a <= 57) then result = TRUE else result = FALSE    
End

Function Ini_CharIsHex(c: String) : Boolean
Var
    a: Integer
Begin
    a = Asc(c)
    result = FALSE    
    If (a >= 48) and (a <= 57) then result = TRUE ; exit
    If (a >= 65) and (a <= 70) then result = TRUE ; exit
    If (a >= 97) and (a <= 102) then result = TRUE ; exit    
End

Function Ini_CharIsIdent(c: String) : Boolean
Var
    a: Integer
Begin
    a = Asc(c)
    result = FALSE    
    If (a >= 48) and (a <= 57) then result = TRUE  ; exit // 0 - 9
    If (a >= 65) and (a <= 90) then result = TRUE  ; exit // A - Z
    If (a >= 97) and (a <= 122) then result = TRUE ; exit // a - z
    If (a = 46) then result = TRUE // .
    If (a = 95) then result = TRUE // _    
End

Function Ini_CharIsDelim(c: String) : Boolean
Begin
    result = FALSE
    If (c = '"') then result = TRUE  ; exit
    If (c = '=') then result = TRUE  ; exit
    If (c = '[') then result = TRUE  ; exit
    If (c = ']') then result = TRUE  ; exit
    If (Asc(c) = 10) then result = TRUE  ; exit
    result = Ini_CharIsWhitespace(c)  
End

Function Ini_CharIsWhitespace(c: String) : Boolean
Var
    a: Integer
Begin
    a = Asc(c) // Tab = 9, Space = 32    
    If (a = 9) or (a = 32) then result = TRUE else result = FALSE
End    

Function Ini_StringIsInt(s: String) : Boolean ; export
Var
    l, i: Integer
    c: String
Begin
    result = FALSE
    l = Length(s)
    If l < 1 then exit
    
    For i = 1 to l
        c = Mid(s, i, 1)
        
        If Not (Ini_CharIsNumeric(c) or (c = '-')) then exit
        If (i <> 1) and (c = '-') then exit 
    Next
    
    result = TRUE        
End

Function Ini_StringIsFloat(s: String) : Boolean ; export
Var
    l, i: Integer
    radix: Integer = 0
    c: String
Begin
    result = FALSE
    l = Length(s)
    If l < 1 then exit
    
    For i = 1 to l
        c = Mid(s, i, 1)
        
        If Not (Ini_CharIsNumeric(c) or (c = '-') or (c = '.')) then exit
        If (i <> 1) and (c = '-') then exit
        
        If (c = '.') then
            Inc(radix)
            If i = l then exit
        Endif
        If radix > 1 then exit 
    Next
    
    result = TRUE        
End

Function Ini_StringIsIdent(s: String) : Boolean
Var
    l, i: Integer
    c: String
Begin
    result = FALSE
    l = Length(s)
    If l < 1 then exit
    
    For i = 1 to l
        c = Mid(s, i, 1)
        
        If (i = 1) and Ini_CharIsNumeric(c) then exit
        If Ini_CharIsIdent(c) = FALSE then exit 
    Next
    
    result = TRUE        
End

Function Ini_StringIsHex(s: String) : Boolean ; export
Var
    l, i: Integer
    c: String
    sCount: Integer = 0 // symbolCount
Begin
    result = FALSE
    l = Length(s)
    If l < 2 then exit
    
    For i = 1 to l
        c = Mid(s, i, 1)
        
        If Not (Ini_CharIsHex(c) or (c = '-') or (c = '#')) then exit
        If (i > 1) and (c = '-') then exit
        If (i > 2) and (c = '#') then exit
        If (c = '#') then Inc(sCount)
    Next
    
    result = TRUE
    
    If sCount <> 1 then result = FALSE        
End

Function Ini_StringIsBinary(s: String) : Boolean ; export
Var
    l, i: Integer
    c: String
    sCount: Integer = 0 // symbolCount
Begin
    result = FALSE
    l = Length(s)
    If l < 2 then exit
    
    For i = 1 to l
        c = Mid(s, i, 1)
        
        If Not (Ini_CharIsNumeric(c) or (c = '%')) then exit
        If (i > 1) and (c = '%') then exit
        If (c = '%') then Inc(sCount)
    Next
    
    result = TRUE
    
    If sCount <> 1 then result = FALSE        
End

Procedure Ini_Error(s: String)
Begin
    Inc(iniErrors)
    If SUPPRESS_ERRORS then exit
    MessageBox(s, "Lexini")
End

Procedure Ini_ExpectedError(s: String)
Begin
    Ini_CodeError("Expected "+s)
End

Procedure Ini_UnexpectedError(s: String)
Begin
    Ini_CodeError("Unexpected "+s)
End

Procedure Ini_CodeError(s: String)
Begin

    s = "Error: "+s+" at line "+(ItemInList(iniSourceList, iniCurrLine)+1)
    s = s + Chr(10) + Replace(iniCurrLine.s, Chr(9), ' ', FALSE) // tabs -> spaces
    
    // with a fixed-width font, this will display a caret at the error position
    //s = s + Chr(10) + RepStr(' ', iniLexer_index0)+'^'
    
    Ini_Error(s)

End

Function Ini_CoerceValueToInt(iniVariable: ^iniVariables) : Integer
Begin
    Case iniVariable.vType of
        (VAR_TYPE_INT): result = iniVariable.iValue
        (VAR_TYPE_FLOAT): result = ToInt(iniVariable.rValue)
        (VAR_TYPE_HEX): result = HexStringToInt(iniVariable.sValue.s)
        (VAR_TYPE_BIN): result = BinStringToInt(iniVariable.sValue.s)
        (VAR_TYPE_BIN_SINGLE): result = iniVariable.iValue    
        (VAR_TYPE_STRING):
            If Ini_StringIsFloat(iniVariable.sValue.s) then
                result = ToInt(iniVariable.sValue.s)
            Else
                result = 0
            Endif
        default:
            result = 0
    EndCase
End

Function Ini_CoerceValueToFloat(iniVariable: ^iniVariables) : Real
Begin
    Case iniVariable.vType of
        (VAR_TYPE_INT): result = ToReal(iniVariable.iValue)
        (VAR_TYPE_FLOAT): result = iniVariable.rValue
        (VAR_TYPE_HEX): result = ToReal(HexStringToInt(iniVariable.sValue.s))
        (VAR_TYPE_BIN): result = ToReal(BinStringToInt(iniVariable.sValue.s))
        (VAR_TYPE_BIN_SINGLE): result = ToReal(iniVariable.iValue)    
        (VAR_TYPE_STRING):
            If Ini_StringIsFloat(iniVariable.sValue.s) then
                result = ToReal(iniVariable.sValue.s)
            Else
                result = 0
            Endif
        default:
            result = 0.0
    EndCase
End

Function Ini_CoerceValueToString(iniVariable: ^iniVariables) : String
Begin
    result = ""

    Case iniVariable.vType of
        (VAR_TYPE_INT): result = ToString(iniVariable.iValue)
        (VAR_TYPE_FLOAT): result = ToString(iniVariable.rValue)
        (VAR_TYPE_HEX): result = iniVariable.sValue.s
        (VAR_TYPE_BIN): result = iniVariable.sValue.s
        (VAR_TYPE_BIN_SINGLE):
            If (iniVariable.iValue = 0) then result = "FALSE" else result = "TRUE"    
        (VAR_TYPE_STRING): result = iniVariable.sValue.s
        default:
            result = ""
    EndCase
End

Function Ini_CoerceValueToBoolean(iniVariable: ^iniVariables) : Boolean
Begin
    Case iniVariable.vType of
        (VAR_TYPE_INT): result = (iniVariable.iValue <> 0)
        (VAR_TYPE_FLOAT): result = (iniVariable.rValue <> 0.0)
        (VAR_TYPE_HEX): result = (HexStringToInt(iniVariable.sValue.s) <> 0)
        (VAR_TYPE_BIN): result = (BinStringToInt(iniVariable.sValue.s) <> 0)
        (VAR_TYPE_BIN_SINGLE):
            If (iniVariable.iValue = 0) then result = FALSE else result = TRUE    
        (VAR_TYPE_STRING):
            If Ini_StringIsFloat(iniVariable.sValue.s) then
                result = (ToInt(iniVariable.sValue.s) <> 0)
            Else
                result = (iniVariable.sValue.s = "TRUE")
            Endif
        default:
            result = ""
    EndCase
End

Function HexStringToInt(s: String): Integer
Var
    l, i, c: Integer
    polarity: Integer
    start: Integer
    total: Integer = 0
Begin
    l = Length(s)
    s = Upper(s)
    
    // Remove -, # (note assumes valid hex string, e.g. -#FF)
    If Left(s, 1) = '-' then
        polarity = -1
        start = 3
    Else
        polarity = 1
        start = 2
    Endif
    
    For i = start to l
        c = Asc(Mid(s, i, 1))
        If (c >= 48) and (c <= 57) then c = c - 48 // 0-9
        If (c >= 65) and (c <= 70) then c = c + 10 - 65 // A-F
        
        If (l - i) > 0 then
            total = total + (c * (16^(l - i)))
        Else
            total = total + c
        Endif         
    
    Next
    
    result = total * polarity   

End

Function BinStringToInt(s: String): Integer
Var
    l, i, c: Integer
    total: Integer = 0
Begin
    l = Length(s)

    For i = 2 to l
        c = Asc(Mid(s, i, 1))
        If (c = 48) then c = 0 else c = 1
        
        If (l - i) > 0 then
            total = total + (c * (2^(l - i)))
        Else
            total = total + c
        Endif         
    
    Next
    
    result = total

End

Begin
End