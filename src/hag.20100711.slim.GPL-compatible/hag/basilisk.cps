{
    Basilisk Library for CobraCore

        NOTE: This library is horrible. It is depricated in favour of
        Lexini. The theme compiler needs to be updated to remove this
        dependency.
    
    ---------------------------------------
    
    Copyright (c) 2007 - 2008 Ben Golightly

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
    THS_BASILISK_VERSION = "2.7.3.1" ; Export
    THS_BASILISK_BUILD = "20080913" ; Export
    
    { Methods }
    THS_NULL = 0
    THS_METH_ASSIGN_INT = 1
    THS_METH_ASSIGN_FLO = 2
    THS_METH_ASSIGN_STR = 3
    THS_METH_ASSIGN_BOO = 4
    THS_METH_FUNCTION = 5
    THS_METH_COND_IF = 6
    THS_METH_COND_ENDIF = 7
    
    { Math Expression Operators }
    OPERATOR_NULL = 0
    OPERATOR_ADD = 1
    OPERATOR_SUB = 2
    OPERATOR_MUL = 3
    OPERATOR_DIV = 4
    OPERATOR_POW = 5
    
    { Boolean Expression Operators }
    BOPERATOR_AND = 1
    BOPERATOR_OR = 2
    BOPERATOR_XOR = 3
    BOPERATOR_NOT = 4
    
    { Expression Calculation Modes }
    EXPR_MODE_FALSE = 0
    EXPR_MODE_TRUE = 1
    EXPR_MODE_LTHAN = 2
    EXPR_MODE_GTHAN = 3
    EXPR_MODE_EQUAL = 4
    EXPR_MODE_NEQUAL = 5
    
    { Sanity Values }
    BRACKET_TIMEOUT = 1000  
    
    { Virtual Variable Types }
    VVAR_INTEGER 	= 1 ; Export
    VVAR_REAL 		= 2 ; Export
    VVAR_STRING		= 3 ; Export
    VVAR_BOOLEAN 	= 4 ; Export
    
Type VirtualVariables = Record
    VName : String
    VType : Integer
    VInt : Integer
    VFlo : Real
    VStr : String
    VBoo : Boolean
    VGrp : Integer // Group
EndType ; Export   

Var
    VirtualVariableList : List of VirtualVariables ; Export
    VirtualVariable : ^VirtualVariables ; Export
    
    THS_unitDebug : Boolean   
    THS_TotalLinesParsed : Integer ; Export
    THS_TotalFilesParsed : Integer ; Export

	VVARMODE_CALCULATE_BOOLEAN_EXPRESSIONS : 	Boolean = TRUE	 	// e.g. ? mybool = NOT otherbool   ? mybool = bool1 AND bool2 OR bool3
	VVARMODE_CALCULATE_STRING_EXPRESSIONS : 	Boolean = TRUE 		// e.g. $ mystring = foo {:myvar:} bar
    VVARMODE_CALCULATE_INTEGER_EXPRESSIONS : 	Boolean = TRUE	 	// e.g. ! myint = myvar + 4
    VVARMODE_CALCULATE_REAL_EXPRESSIONS : 		Boolean = TRUE 		// e.g. ~ myreal = 1.2 + myvar
    VVARMODE_ALWAYS_OVERRIDE_DUPLICATES : 		Boolean = TRUE 		// e.g. !*myoverride is auto
    VVARMODE_FRIENDLY_EXPRESSIONS : 		    Boolean = TRUE 		// e.g. ! int = 1+2+(3*foobar) to ! int = 1 + 2 + ( 3 * foobar )    
    VVARMODE_REPLACE_CONSTS : 					Boolean = TRUE		// using ReadSettingsReplaceConsts
    VVARMODE_STRICT :       					Boolean = FALSE		// e.g. non-existant cause errors
    
    

Procedure InitBasilisk(debug_enabled: Boolean) ; Export
Begin
    THS_unitDebug = debug_enabled
End

Procedure Error(msg: String, prefix: String="")
Begin
	If THS_unitDebug Then MessageBox(msg,prefix+"Basilisk Library Error")
End

Function ToBool(LOCA_int: integer) : Boolean
{
	Cobra uses -1 as TRUE, however I use positive 1 for TRUE.
}
Begin
    If (LOCA_int > 0)
        result=TRUE
    Else
        result=FALSE
    Endif 
End 

Function StrToBool(val: String) : Boolean
Begin
	Conditions
    	(val="TRUE") 	: result = TRUE
        (val="FALSE") 	: result = FALSE
    	(val="1") 		: result = TRUE
        (val="0")	 	: result = FALSE
        (val="") 		: result = FALSE
        Default			: result = TRUE ; Error("Not a Boolean: "+val)
    EndConditions
End

Function TrimSpaces(LOCA_text: String) : String ; Export
{
	Trims all tabs and spaces at the ends of a string
}
Begin
    While ((Left(LOCA_text,1)=" ") or (Left(LOCA_text,1)=Chr(9)) or (Right(LOCA_text,1)=" ") or (Right(LOCA_text,1)=Chr(9)))
        If (Left(LOCA_text,1)=" ") Then
            LOCA_text = Right(LOCA_text,Length(LOCA_text)-1)
        Endif
        If (Left(LOCA_text,1)=Chr(9)) Then
            LOCA_text = Right(LOCA_text,Length(LOCA_text)-1)
        Endif
        If (Right(LOCA_text,1)=" ") Then
            LOCA_text = Left(LOCA_text,Length(LOCA_text)-1)
        Endif
        If (Right(LOCA_text,1)=Chr(9)) Then
            LOCA_text = Left(LOCA_text,Length(LOCA_text)-1)
        Endif
    Wend
    Result=LOCA_text
End
    
Function ReadSettings(filePath: string, grp:Integer=0, memfile:Element=NULL) : Integer ; Export
{
	Reads a file and maps all settings to Virtual Variables
    
    Returns time taken
}
Var
    Method, Method2 : Integer
    fileStream : Element
    fileIn : String
    fileInVarib : String
    fileInValuS : String
    fileInValuI : Integer
    fileInValuF : Real
    fileInValuB : Boolean
    virtOverride : Boolean
    
    rstime : Integer
    
    stateTrue : Boolean = TRUE // If things are currently True
    doTrue : Boolean = FALSE // Result of a conditional
    thisCond, lastCond : Integer // Counters for how many levels conditonals are nested   
Begin    
    rstime = Millisecs()
    
    If (Not FileExists(filePath)) and (memfile = NULL) Then
        Error("Error in reading settings - File not found at '"+FilePath+"'.")
        rstime = -1
    Else
    	Inc(THS_TotalFilesParsed)
            
        If memfile=NULL then
            fileStream = ReadFile(filePath)
        Else
            fileStream = memfile
        Endif
        
        While not EOF(fileStream)
        	Inc(THS_TotalLinesParsed)
        
            fileIn = ReadLn(fileStream)
            fileIn = TrimSpaces(fileIn)

            { Mode - assignments(int/real/string/bool), function, conditional }        
            Method = ReadSettingsGetMethod(fileIn)                            
            fileIn = Right(fileIN,Length(fileIN)-1)
            fileIn = TrimSpaces(fileIn)

            { Special Trims }            
            Method2 = ReadSettingsGetMethod(fileIn)
            If (Method2 >= THS_METH_COND_IF)
                If Method2 = THS_METH_COND_IF then fileIn = ParameterAsString(ExpressionParameters(fileIn),1)
                If Method2 = THS_METH_COND_ENDIF then fileIn = ParameterAsString(ExpressionParameters(fileIn),1)
                If VVARMODE_REPLACE_CONSTS then fileIn = ReadSettingsReplaceConsts(fileIn)            
                fileIn = TrimSpaces(fileIn)
            Endif

            { Check for over-writting VirtVars }
            If ( (Left(fileIn,1)="*") and (Method < THS_METH_FUNCTION) ) then
            	virtOverride = TRUE
           		fileIn = Right(fileIN,Length(fileIN)-1)
            	fileIn = TrimSpaces(fileIn)
            Else virtOverride = FALSE


            
            { Main Logic }
            
            If Not (Method = THS_NULL)
                If (Method2 < THS_METH_COND_IF) then
                    If stateTrue Then
                    
                        { Functions and Assignment }
                    
                        FileInValuS = Right(fileIn,(Length(fileIn)-Instr(fileIn,"=")))            
                        FileInValuS = TrimSpaces(FileInValuS)

        				If VVARMODE_REPLACE_CONSTS then FileInValuS = ReadSettingsReplaceConsts(FileInValuS)
                                    
                        If Method = THS_METH_ASSIGN_BOO then
                        	If VVARMODE_CALCULATE_BOOLEAN_EXPRESSIONS then FileInValuS = Upper(ToString(CalculateBooleanExpression(FileInValuS)))
                         	FileInValuS = Replace(FileInValuS, "TRUE", "1", FALSE)
                            FileInValuS = Replace(FileInValuS, "FALSE", "0", FALSE)
                        Else
                            If (Method = THS_METH_ASSIGN_STR) and VVARMODE_CALCULATE_STRING_EXPRESSIONS then FileInValuS = ToString(CalculateStringExpression(FileInValuS))
                            If (Method = THS_METH_ASSIGN_INT) and VVARMODE_CALCULATE_INTEGER_EXPRESSIONS then FileInValuS = ToString(CalculateIntegerExpression(FileInValuS))
                            If (Method = THS_METH_ASSIGN_FLO) and VVARMODE_CALCULATE_REAL_EXPRESSIONS then FileInValuS = ToString(CalculateRealExpression(FileInValuS))
                        Endif
                
                        If Method = THS_METH_ASSIGN_INT then FileInValuI = ToInt(FileInValuS)
                        If Method = THS_METH_ASSIGN_FLO then FileInValuF = ToReal(FileInValuS)
                        //If Method = THS_METH_ASSIGN_STR then FileInValuS = FileInValuS <- Redundant
                        If Method = THS_METH_ASSIGN_BOO then FileInValuB = ToBool(ToInt(FileInValuS))

                        FileInVarib = Left(fileIn,(Instr(fileIn,"=")-1))
                        FileInVarib = TrimSpaces(FileInVarib)

                        If virtOverride and VirtualVariableExists(FileInVarib) then FreeVirtualVariable(FileInVarib)
                                
                        If Method = THS_METH_ASSIGN_INT then MapVirtualInteger(FileInVarib,FileInValuI,grp)
                        If Method = THS_METH_ASSIGN_FLO then MapVirtualReal(FileInVarib,FileInValuF,grp)
                        If Method = THS_METH_ASSIGN_STR then MapVirtualString(FileInVarib,FileInValuS,grp)
                        If Method = THS_METH_ASSIGN_BOO then MapVirtualBoolean(FileInVarib,FileInValuB,grp)
                        If Method = THS_METH_FUNCTION then ReadSettingsFunction(filePath,FileInVarib,ExpressionParameters(FileInValuS),grp)
                        
                    Endif
                Else
                
                    { Conditionals }
                    If Method2 = THS_METH_COND_IF then
                        If Method = THS_METH_ASSIGN_INT then doTrue = IntegerExpressionIsTrue(fileIn)
                        If Method = THS_METH_ASSIGN_FLO then doTrue = RealExpressionIsTrue(fileIn)
                        If Method = THS_METH_ASSIGN_STR then doTrue = StringExpressionIsTrue(fileIn)
                        If Method = THS_METH_ASSIGN_BOO then doTrue = BooleanExpressionIsTrue(fileIn)
                        
		                Inc(thisCond)
		                If (doTrue) then Inc(lastCond) // Only do anything if things are currently true
    	                If thisCond = lastCond then stateTrue = TRUE Else stateTrue = FALSE // If all conditionals up until now have been TRUE...
                     Endif
                     
                     If Method2 = THS_METH_COND_ENDIF then
		                Conditions
			                (thisCond = lastCond):  // The endif is the end of a condition that has completed TRUEly
				                Dec(thisCond)
				                Dec(lastCond)
			                (thisCond > lastCond):	// End of a FALSE condition or a condition in a branch that isn't TRUE
				                Dec(thisCond)
				                If lastCond = thisCond then stateTrue = TRUE // If this endif ends the a FALSE conditonal and the parent is TRUE
		                EndConditions
                     Endif
                     
                Endif
            Endif
        Wend
        Closefile(fileStream)
        rstime = Millisecs() - rstime
    Endif
    
    result = rstime
    
End

Function ReadSettingsGetMethod(fileIn: string) : Integer
Var
    l1, l3, l5 : String
    Method : Integer
Begin
    Method = THS_NULL 
    l1 = Left(fileIn,1)
    l3 = Left(fileIn,3)
    l5 = Left(fileIn,5)
    
    If (l1)="!" then Method = THS_METH_ASSIGN_INT
    If (l1)="~" then Method = THS_METH_ASSIGN_FLO
    If (l1)="$" then Method = THS_METH_ASSIGN_STR
    If (l1)="?" then Method = THS_METH_ASSIGN_BOO
    If (l1)=":" then Method = THS_METH_FUNCTION
    If Lower(l3)="if " then Method = THS_METH_COND_IF
    If Lower(l5)="endif" then Method = THS_METH_COND_ENDIF
    
    Result = Method
End

Procedure ReadSettingsFunction(filePath: string, funcname: string, cmds:string, grp:Integer=0)
Begin
    If VVARMODE_CALCULATE_STRING_EXPRESSIONS then cmds = CalculateStringExpression(cmds)
    
	Conditions
    	(funcname = "MODE"):
        	ReadSettingsMode(ParameterAsString(cmds, 1), ParameterAsString(cmds, 2))
    	(funcname = "IMPORT"):
        	ReadSettings(DirectoryUp(filePath) + ParameterAsString(cmds, 1), grp)
        (funcname = "FREE"):
        	FreeVirtualVariable(ParameterAsString(cmds, 1))
        (funcname = "DUMP"):
        	VirtualVariableDump(ParameterAsString(cmds, 1))
        (funcname = "MSG"):
           	    MessageBox(ParameterAsString(cmds, 1),ParameterAsString(cmds, 2))
        (funcname = "DMSG"):
        	    Error(ParameterAsString(cmds, 1),"(Debug) ")
        Default:
        	Error("Error reading settings function - unknown command '"+funcname+"' in "+filePath+".")
    EndConditions
End

Procedure ReadSettingsMode(mode: String, val: String) ; Export
Begin
	Conditions
    	(mode = "CALCULATE_STRING_EXPRESSIONS"):	 		VVARMODE_CALCULATE_STRING_EXPRESSIONS = StrToBool(val)
    	(mode = "CALCULATE_INTEGER_EXPRESSIONS"): 			VVARMODE_CALCULATE_INTEGER_EXPRESSIONS = StrToBool(val)
        (mode = "CALCULATE_REAL_EXPRESSIONS"): 				VVARMODE_CALCULATE_REAL_EXPRESSIONS = StrToBool(val)
        (mode = "CALCULATE_BOOLEAN_EXPRESSIONS"): 			VVARMODE_CALCULATE_BOOLEAN_EXPRESSIONS = StrToBool(val)
        (mode = "ALWAYS_OVERRIDE_DUPLICATES"): 				VVARMODE_ALWAYS_OVERRIDE_DUPLICATES = StrToBool(val)
        (mode = "FRIENDLY_EXPRESSIONS"): 				    VVARMODE_FRIENDLY_EXPRESSIONS = StrToBool(val)                        
        (mode = "REPLACE_CONSTS"): 							VVARMODE_REPLACE_CONSTS = StrToBool(val)
        (mode = "SUPPRESS_ERRORS"): 						THS_unitDebug = Not StrToBool(val)
        (mode = "STRICT"): 						            VVARMODE_STRICT = StrToBool(val)
        
        Default:
        	Error("Error reading settings function - unknown mode '"+mode+"'")
    EndConditions
End

Function ReadSettingsReplaceConsts(txt: String) : String ; Export
Begin
	{ Logic }
	txt = Replace(txt, "TRUE",  "1", FALSE)
	txt = Replace(txt, "FALSE", "0", FALSE)
    txt = Replace(txt, "CONST_TRUE",  "1", FALSE)
	txt = Replace(txt, "CONST_FALSE", "0", FALSE)
    txt = Replace(txt, "CONST_YES",   "1", FALSE)
    txt = Replace(txt, "CONST_NO",    "0", FALSE)
    
    { AntiAliasing } // Makes font property expressions more readable
    txt = Replace(txt, "CONST_0xAA",    "0", FALSE)
    txt = Replace(txt, "CONST_1xAA",    "1", FALSE)
    txt = Replace(txt, "CONST_2xAA",    "2", FALSE)
    txt = Replace(txt, "CONST_3xAA",    "3", FALSE)
    txt = Replace(txt, "CONST_4xAA",    "4", FALSE)
    
    { Window Flags }
	txt = Replace(txt, "CONST_WIN_SHOWBORDER",   "1", FALSE)
    txt = Replace(txt, "CONST_WIN_STAYONTOP",    "2", FALSE)
	txt = Replace(txt, "CONST_WIN_SHOWCLOSE",    "4", FALSE)
    txt = Replace(txt, "CONST_WIN_SHOWMINIMIZE", "8", FALSE)
    
    { Window Mode }
    txt = Replace(txt, "CONST_WIN_WINDOWED",     "0", FALSE)
    txt = Replace(txt, "CONST_WIN_FULLSCREEN",   "1", FALSE)
    
    { Fonts }
    txt = Replace(txt, "CONST_FNT_NORMAL",        "0", FALSE)
    txt = Replace(txt, "CONST_FNT_BOLD",          "1", FALSE)
    txt = Replace(txt, "CONST_FNT_ITALIC",        "2", FALSE)
    txt = Replace(txt, "CONST_FNT_UNDERLINED",    "4", FALSE)
    txt = Replace(txt, "CONST_FNT_STRIKETHROUGH", "8", FALSE)
    
    { Maths }
    txt = Replace(txt, "CONST_PI", Pi, FALSE)
    
    { Date }
    txt = Replace(txt, "MGLOB_DATE_YY",         DateTimeToString(Now,'%yy'), FALSE)
    txt = Replace(txt, "MGLOB_DATE_YYYY",       DateTimeToString(Now,'%yyyy'), FALSE)
    txt = Replace(txt, "MGLOB_DATE_MONTH",      DateTimeToString(Now,'%m'), FALSE)
    txt = Replace(txt, "MGLOB_DATE_DAY",        DateTimeToString(Now,'%d'), FALSE)
    txt = Replace(txt, "MGLOB_DATE_HOUR",       DateTimeToString(Now,'%hh'), FALSE)
    txt = Replace(txt, "MGLOB_DATE_MINUTE",     DateTimeToString(Now,'%nn'), FALSE)
    txt = Replace(txt, "MGLOB_DATE_SECOND",     DateTimeToString(Now,'%ss'), FALSE)
    
    { System }
    txt = Replace(txt, "CONST_SYS_VERSION",    THS_BASILISK_VERSION, FALSE)
    txt = Replace(txt, "CONST_SYS_BUILD",      THS_BASILISK_BUILD, FALSE)
    txt = Replace(txt, "MGLOB_SYS_FILESPARSED", ToString(THS_TotalFilesParsed), FALSE)
    txt = Replace(txt, "MGLOB_SYS_LINESPARSED", ToString(THS_TotalLinesParsed), FALSE)
    txt = Replace(txt, "MGLOB_SYS_VVARCOUNT",   ToString(CountVirtualVariables(-1)), FALSE)
    
    Result = txt
End

Procedure MapVirtualInteger(locnam: string, locval : integer, grp : Integer=0) ; Export
Begin
	If VVARMODE_ALWAYS_OVERRIDE_DUPLICATES then FreeVirtualVariable(locnam)
    
    VirtualVariable = NewItem(VirtualVariableList)
    If Assigned(VirtualVariable)
    VirtualVariable.VName = locnam
    VirtualVariable.VType = THS_METH_ASSIGN_INT
    VirtualVariable.VInt = locval
    VirtualVariable.VGrp = grp
    Else
        Error("Fatal Memory Error with MapVirtualInteger - Could not assign VirtualVariable '"+locnam+"'.")
    Endif
End

Procedure MapVirtualReal(locnam: string, locval : real, grp : Integer=0) ; Export
Begin
	If VVARMODE_ALWAYS_OVERRIDE_DUPLICATES then FreeVirtualVariable(locnam)

    VirtualVariable = NewItem(VirtualVariableList)
    If Assigned(VirtualVariable)
    VirtualVariable.VName = locnam
    VirtualVariable.VType = THS_METH_ASSIGN_FLO
    VirtualVariable.VFlo = locval
    VirtualVariable.VGrp = grp
    Else
        Error("Fatal Memory Error with MapVirtualReal - Could not assign VirtualReal '"+locnam+"'.")
    Endif
End

Procedure MapVirtualString(locnam: string, locval : string, grp : Integer=0) ; Export
Begin
	If VVARMODE_ALWAYS_OVERRIDE_DUPLICATES then FreeVirtualVariable(locnam)
    
    VirtualVariable = NewItem(VirtualVariableList)
    If Assigned(VirtualVariable)
    VirtualVariable.VName = locnam
    VirtualVariable.VType = THS_METH_ASSIGN_STR
    VirtualVariable.VStr = locval
    VirtualVariable.VGrp = grp
    Else
        Error("Fatal Memory Error in MapVirtualString - Could not assign VirtualString '"+locnam+"'.")
    Endif
End

Procedure MapVirtualBoolean(locnam: string, locval : boolean, grp : Integer=0) ; Export
Begin
	If VVARMODE_ALWAYS_OVERRIDE_DUPLICATES then FreeVirtualVariable(locnam)
    
    VirtualVariable = NewItem(VirtualVariableList)
    If Assigned(VirtualVariable)
    VirtualVariable.VName = locnam
    VirtualVariable.VType = THS_METH_ASSIGN_BOO
    VirtualVariable.VBoo = locval
    VirtualVariable.VGrp = grp
    Else
        Error("Fatal Memory Error in Internal Function MapVirtualBoolean - Could not assign VirtualBoolean '"+locnam+"'.")
    Endif
End

Function VirtualVariableExists(locnam: String) : Boolean ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            Result = TRUE
        Endif
    EndLoop
End

Function VirtualVariableType(locnam: String) : Integer ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            Result = VirtualVariable.VType
        Endif
    EndLoop
End

Function VirtualVariableAsString(locnam: String) : String ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            Case VirtualVariable.VType of
            	(THS_METH_ASSIGN_INT): result = ToString(VirtualVariable.VInt)
                (THS_METH_ASSIGN_FLO): result = ToString(VirtualVariable.VFlo)
                (THS_METH_ASSIGN_STR): result = ToString(VirtualVariable.VStr)
                (THS_METH_ASSIGN_BOO): result = Upper(ToString(VirtualVariable.VBoo))
                Default: Error("VirtualVariable not found: "+locnam); result = ""
                Exit
            EndCase
        Endif
    EndLoop
End

Function VirtualInteger(locnam: String, nu: Integer=0, grp: Integer=0) : Integer ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            If (VirtualVariable.VType = THS_METH_ASSIGN_INT) Then
                Result = VirtualVariable.VInt
                Exit
            Else
                Error("VirtualVariable type mismatch: Variable '"+locnam+"' is not an Integer.")
                Result = 0
                Exit
            Endif
        Endif
    EndLoop
    
    If VVARMODE_STRICT then Error("Warning: VirtualInteger '"+locnam+"' did not exist. Assuming creation.","Strict ")
    MapVirtualInteger(locnam, nu, grp)
    Result = nu
End

Function VirtualReal(locnam: String, nu: Real=0.0, grp: Integer=0) : Real ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            If (VirtualVariable.VType = THS_METH_ASSIGN_FLO) Then
                Result = VirtualVariable.VFlo
                Exit
            Else
                Error("VirtualVariable type mismatch: Variable '"+locnam+"' is not a Real.")
                Result = 0
                Exit
            Endif
        Endif
    EndLoop
    
    If VVARMODE_STRICT then Error("Warning: VirtualReal '"+locnam+"' did not exist. Assuming creation.","Strict ")
    MapVirtualReal(locnam, nu, grp)
    Result = nu
End

Function VirtualString(locnam: String, nu: String="", grp: Integer=0) : String ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            If (VirtualVariable.VType = THS_METH_ASSIGN_STR) Then
                Result = VirtualVariable.VStr
                Exit
            Else
                Error("VirtualVariable type mismatch: Variable '"+locnam+"' is not a String.")
                Result = ""
                Exit
            Endif
        Endif
    EndLoop
    
    If VVARMODE_STRICT then Error("Warning: VirtualString '"+locnam+"' did not exist. Assuming creation.","Strict ")
    MapVirtualString(locnam, nu, grp)
    Result = nu
End

Function VirtualBoolean(locnam: String, nu: Boolean=FALSE, grp: Integer=0) : Boolean ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            If (VirtualVariable.VType = THS_METH_ASSIGN_BOO) Then
                Result = VirtualVariable.VBoo
                Exit
            Else
                Error("VirtualVariable type mismatch: Variable '"+locnam+"' is not a Boolean.")
                Result = FALSE
                Exit
            Endif
        Endif
    EndLoop
    
    If VVARMODE_STRICT then Error("Warning: VirtualBoolean '"+locnam+"' did not exist. Assuming creation.","Strict ")
    MapVirtualBoolean(locnam, nu, grp)
    Result = nu
End

Function FreeVirtualVariable(locnam: String) : Boolean ; Export
Begin
    Loop VirtualVariable Through VirtualVariableList
        If (locnam = VirtualVariable.VName) Then
            Result = TRUE
            Free(VirtualVariable)
            Exit
        Endif
    EndLoop
End

Function CountVirtualVariables(grp: Integer = 0) : Integer ; Export
Var
	vvc : Integer = 0
Begin
	If (grp > -1) then
    	Loop VirtualVariable Through VirtualVariableList
	        If (grp = VirtualVariable.VGrp) Then Inc(vvc)
	    EndLoop
    Else
    	vvc = CountList(VirtualVariableList)
    Endif
    result = vvc
End

Function CountVirtualVariablesPrefixed(locname: String) : Integer ; Export
Var
	strlen : Integer
Begin
    result = 0
	strlen = Length(locname)
    
    Loop VirtualVariable Through VirtualVariableList
        If (locname = Left(VirtualVariable.VName,strlen)) Then
            Inc(result)
        Endif
    EndLoop	
End

Function CountVirtualVariablesNamed(locname: String) : Integer ; Export
Begin
	result = 0
    
    Loop VirtualVariable Through VirtualVariableList
        If (locname = VirtualVariable.VName) Then
            Inc(result)
        Endif
    EndLoop	
End

Procedure FreeVirtualVariables(grp: Integer = 0) ; Export
Begin
    ClearVirtualVariables(grp)
End

Procedure ClearVirtualVariables(grp: Integer = 0) ; Export
Begin
	If (grp > -1) then
    	Loop VirtualVariable Through VirtualVariableList
	        If (grp = VirtualVariable.VGrp) Then Free(VirtualVariable)
	    EndLoop
    Else
    	Loop VirtualVariable Through VirtualVariableList
	        Free(VirtualVariable)
	    EndLoop
    Endif
End

Procedure FreeVirtualVariablesPrefixed(locname: String) ; Export
Var
	strlen : Integer
Begin
	strlen = Length(locname)
    
    Loop VirtualVariable Through VirtualVariableList
        If (locname = Left(VirtualVariable.VName,strlen)) Then
            Free(VirtualVariable)
        Endif
    EndLoop	
End

Procedure VirtualVariableDump(fpath: String="vvdump.txt") ; Export
Var
	fileOut : Element
    vvt, vvv : String
Begin
	DeleteFile(fpath)
	fileOut = WriteFile(fpath)
    
    WriteLn(fileOut,"TopHat Stuff Basilisk Library for CobraCore")
    WriteLn(fileOut,"Virtual Varible Dump")
    WriteLn(fileOut,"")
    
    WriteLn(fileOut,"VirtualVariable Debugging: "+ToString(THS_unitDebug))
    WriteLn(fileOut,"Files Parsed: "+ToString(THS_TotalFilesParsed))
    WriteLn(fileOut,"Lines Parsed: "+ToString(THS_TotalLinesParsed))
    WriteLn(fileOut,"VirtualVariables Mapped: "+ToString(CountVirtualVariables(-1)))
    WriteLn(fileOut,"Version: " + THS_BASILISK_VERSION)
    WriteLn(fileOut,"Build: " + THS_BASILISK_BUILD)
    
    WriteLn(fileOut,"")
    
	Loop VirtualVariable Through VirtualVariableList
    	Case VirtualVariable.VType of
        	(VVAR_INTEGER):
           		vvt = "Integer"
                vvv = ToString(VirtualVariable.VInt)
    		(VVAR_REAL):
            	vvt = "Real"
                vvv = ToString(VirtualVariable.VFlo)
    		(VVAR_STRING):
            	vvt = "String"
                vvv = "'"+VirtualVariable.VStr+"'"
    		(VVAR_BOOLEAN):
            	vvt = "Boolean"
                vvv = ToString(VirtualVariable.VBoo)
            Default:
            	vvt = "[VV-TYPE ERROR]"
                vvv = "[VV-TYPE ERROR]"
        EndCase 
    
	  	WriteLn(fileOut,"VirtualVariable '" + VirtualVariable.VName + "'")
        WriteLn(fileOut,"	Type:  " + vvt + "")
        WriteLn(fileOut,"	Value: " + vvv + "")
        WriteLn(fileOut,"	Group: " + ToString(VirtualVariable.VGrp) + "")
        WriteLn(fileOut,"")
	EndLoop
    
    WriteLn(fileOut,"<* END *>")
    WriteLn(fileOut,"")
    CloseFile(fileOut)
End

Procedure SaveVirtualVariables(fpath: String="vvsave.txt", manov: Boolean=FALSE, grp: Integer=0) ; Export
Var
	fileOut : Element
    vvt, vvv : String
Begin
	DeleteFile(fpath)
	fileOut = WriteFile(fpath)
    
    WriteLn(fileOut,"# TopHat Stuff Basilisk Library for CobraCore")
    WriteLn(fileOut,"# Virtual Varible Dump")
    WriteLn(fileOut,"# Group: "+grp)
    WriteLn(fileOut,"")
    
    If manov then
        WriteLn(fileOut,": MODE = (ALWAYS_OVERRIDE_DUPLICATES, FALSE)")
        WriteLn(fileOut,"")
    Endif
    
	Loop VirtualVariable Through VirtualVariableList
    	Case VirtualVariable.VType of
        	(VVAR_INTEGER):
           		vvt = "!"
                vvv = ToString(VirtualVariable.VInt)
    		(VVAR_REAL):
            	vvt = "~"
                vvv = ToString(VirtualVariable.VFlo)
    		(VVAR_STRING):
            	vvt = "$"
                vvv = VirtualVariable.VStr
    		(VVAR_BOOLEAN):
            	vvt = "?"
                vvv = Upper(ToString(VirtualVariable.VBoo))
            Default:
            	vvt = "#"
                vvv = "Invalid"
        EndCase
        
        If manov then vvt = vvt+"*" else vvt=vvt+" " 
        
        If (grp>-1) then
            If (grp = VirtualVariable.VGrp) then WriteLn(fileOut,vvt+"" + VirtualVariable.VName + " = "+vvv)
        Else
            WriteLn(fileOut,vvt+"" + VirtualVariable.VName + " = "+vvv)
        Endif
	EndLoop
    
    WriteLn(fileOut,"")
    CloseFile(fileOut)
End


Function CalculateIntegerExpression(expression: String) : Integer ; Export
Var
	i : Integer
    operation : Integer = OPERATOR_ADD
    exitem : String
    number : Integer
    value : Integer = 0
    doop : Boolean
    
    // Brackets
    blvl : Integer
    j : Integer
    subexpr : String
Begin
    If VVARMODE_FRIENDLY_EXPRESSIONS then expression = FriendlyExpression(expression) 
    
	For i = 1 to (CountSubstr(expression," ")+1)    
		exitem = StringField(expression," ",i)
        doop = FALSE
        
        Conditions
        	(exitem = "+") : operation = OPERATOR_ADD
            (exitem = "-") : If operation = OPERATOR_SUB then operation = OPERATOR_ADD else operation = OPERATOR_SUB
            (exitem = "*") : operation = OPERATOR_MUL
            (exitem = "/") : operation = OPERATOR_DIV
            (exitem = "^") : operation = OPERATOR_POW 
            (exitem = "SUM") : operation = OPERATOR_ADD
            (exitem = "POWER") : operation = OPERATOR_POW
            (exitem = "(") :            
                blvl = 1 
                j = i + 1
                subexpr = ""                
                While (blvl > 0)
                    exitem = StringField(expression," ",j)
                    Inc(j)
                    Conditions
                        (exitem = "(") : Inc(blvl)
                        (exitem = ")") : Dec(blvl)                        
                    EndConditions
                    If (blvl > 0) then AppendStr(subexpr," "+exitem)                    
                    If (j > BRACKET_TIMEOUT) then blvl = 0; Error("Calculation timed out: suspected bracket mismatch in "+expression) 
                Wend
                i = j                
                number = CalculateIntegerExpression(TrimSpaces(subexpr)) ; doop = TRUE
                
            (IsNumber(exitem) = TRUE) : number = ToInt(exitem) ; doop = TRUE
            (IsString(exitem) = TRUE) : number = ToInt(VirtualVariableAsString(exitem)) ; doop = TRUE
            (Left(exitem,1) = "$") : number = CalculateIntegerExpression(VirtualString(Right(exitem,Length(exitem)-1))) ; doop = TRUE
            Default: Error("Invalid simple expression: '"+expression+"' (Try FRIENDLY_EXPRESSIONS or watch your minuses)")        
        EndConditions
        
        If doop then
        	Case operation of
            	(OPERATOR_ADD): value = value + number
                (OPERATOR_SUB): value = value - number
                (OPERATOR_MUL): value = value * number
                (OPERATOR_DIV): If (number<>0) then value = value / number else Error("Divide by zero error in expression: "+expression)
                (OPERATOR_POW): value = value ^ number
            EndCase
        Endif                
    Next    
	result = value
End


Function CalculateRealExpression(expression: String) : Real ; Export
Var
	i : Integer
    operation : Integer = OPERATOR_ADD
    exitem : String
    number : Real = 0.0
    value : Real = 0.0
    doop : Boolean

    // Brackets
    blvl : Integer
    j : Integer
    subexpr : String
Begin
    If VVARMODE_FRIENDLY_EXPRESSIONS then expression = FriendlyExpression(expression)
    
	For i = 1 to (CountSubstr(expression," ")+1)    
		exitem = StringField(expression," ",i)
        doop = FALSE
        
        Conditions
        	(exitem = "+") : operation = OPERATOR_ADD
            (exitem = "-") : If operation = OPERATOR_SUB then operation = OPERATOR_ADD else operation = OPERATOR_SUB
            (exitem = "*") : operation = OPERATOR_MUL
            (exitem = "/") : operation = OPERATOR_DIV
            (exitem = "^") : operation = OPERATOR_POW 
            (exitem = "SUM") : operation = OPERATOR_ADD
            (exitem = "POW") : operation = OPERATOR_POW
            (exitem = "(") :            
                blvl = 1 
                j = i + 1
                subexpr = ""                
                While (blvl > 0)
                    exitem = StringField(expression," ",j)
                    Inc(j)
                    Conditions
                        (exitem = "(") : Inc(blvl)
                        (exitem = ")") : Dec(blvl)                        
                    EndConditions
                    If (blvl > 0) then AppendStr(subexpr," "+exitem)                    
                    If (j > BRACKET_TIMEOUT) then blvl = 0; Error("Calculation timed out: suspected bracket mismatch in "+expression) 
                Wend
                i = j                
                number = CalculateRealExpression(TrimSpaces(subexpr)) ; doop = TRUE
                  
            (IsNumber(exitem) = TRUE) : number = ToReal(exitem) ; doop = TRUE
            (IsString(exitem) = TRUE) : number = ToReal(VirtualVariableAsString(exitem)) ; doop = TRUE
            (Left(exitem,1) = "$") : number = CalculateRealExpression(VirtualString(Right(exitem,Length(exitem)-1))) ; doop = TRUE
            Default: Error("Invalid simple expression: '"+expression+"' (Try FRIENDLY_EXPRESSIONS or watch your minuses)")        
        EndConditions
        
        If doop then
        	Case operation of
            	(OPERATOR_ADD): value = value + number
                (OPERATOR_SUB): value = value - number
                (OPERATOR_MUL): value = value * number
                (OPERATOR_DIV): If (number<>0) then value = value / number else Error("Divide by zero error in expression: "+expression)
                (OPERATOR_POW): value = value ^ number
            EndCase
        Endif                
    Next    
	result = value
End

Function CalculateStringExpression(expression: String) : String ; Export
Var
    tag : String
Begin
   { [foo] -> VirtualString("foo") }
   
	If (Instr(expression,"]") > 0) then
    	While (Instr(expression,"]") > 0)
        	tag = (Mid( expression, Instr(expression,"[")+1, (Instr(expression,"]")) - (Instr(expression,"[")) -1))
        	expression = Left(expression,Instr(expression,"[")-1) + VirtualVariableAsString(tag) + Right(expression,Length(expression) - Instr(expression,"]") ) 
        Wend 
    Endif

	result = expression
End

Function CalculateBooleanExpression(expression: String) : Boolean ; Export
Var
	i : Integer
    operation : Integer = BOPERATOR_OR
    exitem : String
    flag : Boolean = FALSE
    value : Boolean
    doop : Boolean
    
    // Brackets
    blvl : Integer
    j : Integer
    subexpr : String
Begin
    If VVARMODE_FRIENDLY_EXPRESSIONS then expression = FriendlyExpression(expression)
    
	For i = 1 to (CountSubstr(expression," ")+1)    
		exitem = StringField(expression," ",i)
        doop = FALSE
        
        Conditions
        	(exitem = "AND") : operation = BOPERATOR_AND
            (exitem = "OR")  : operation = BOPERATOR_OR
            (exitem = "XOR") : operation = BOPERATOR_XOR
            (exitem = "NOT") : operation = BOPERATOR_NOT
            (exitem = "(") :            
                blvl = 1 
                j = i + 1
                subexpr = ""                
                While (blvl > 0)
                    exitem = StringField(expression," ",j)
                    Inc(j)
                    Conditions
                        (exitem = "(") : Inc(blvl)
                        (exitem = ")") : Dec(blvl)                        
                    EndConditions
                    If (blvl > 0) then AppendStr(subexpr," "+exitem)                    
                    If (j > BRACKET_TIMEOUT) then blvl = 0; Error("Calculation timed out: suspected bracket mismatch in "+expression) 
                Wend
                i = j                
                flag = CalculateBooleanExpression(TrimSpaces(subexpr)) ; doop = TRUE
                                
            (IsBoolean(exitem) = TRUE) : flag = StrToBool(exitem) ; doop = TRUE
            (IsString(exitem) = TRUE) : flag = VirtualBoolean(exitem,FALSE) ; doop = TRUE
            Default: Error("Invalid simple expression: '"+expression+"' (Try FRIENDLY_EXPRESSIONS or watch your minuses)")        
        EndConditions
        
        If doop then
        	Case operation of
            	(BOPERATOR_AND): value = value AND flag
                (BOPERATOR_OR):  value = value OR flag
                (BOPERATOR_XOR): value = value XOR flag
                (BOPERATOR_NOT): value = (NOT flag)
            EndCase
        Endif                
    Next    
	result = value
End

Function IntegerExpressionIsTrue(expression: String) : Boolean ; Export
Var
	leftExp, rightExp : String
    leftVal, rightVal : Integer
    mode : Integer = 0
    delim : String = ""
Begin
    If (Instr(expression,"TRUE")>0) then mode = EXPR_MODE_TRUE
    If (Instr(expression,"FALSE")>0) then mode = EXPR_MODE_FALSE
    If (Instr(expression,"<")>0) then mode = EXPR_MODE_LTHAN ; delim = "<"
    If (Instr(expression,">")>0) then mode = EXPR_MODE_GTHAN ; delim = ">"
    If (Instr(expression,"=")>0) then mode = EXPR_MODE_EQUAL ; delim = "="
    If (Instr(expression,"!")>0) then mode = EXPR_MODE_NEQUAL ; delim = "!"
    
	If (mode = EXPR_MODE_FALSE) then
    	Result = FALSE
    Else
    	If (mode = EXPR_MODE_TRUE) then
        	Result = TRUE
        Else
  			leftExp = TrimSpaces(Left(expression,Instr(expression,delim)-1))
	        rightExp = TrimSpaces(Right(expression,Length(expression)-Instr(expression,delim)))
			leftVal = CalculateIntegerExpression(leftExp)
	        rightVal = CalculateIntegerExpression(rightExp)
        
	        Case mode of
	        	(EXPR_MODE_LTHAN):
	            	If (leftVal < rightVal) then Result = TRUE else Result = FALSE 
	           (EXPR_MODE_GTHAN):
	            	If (leftVal > rightVal) then Result = TRUE else Result = FALSE
                (EXPR_MODE_EQUAL):
                    If (leftVal = rightVal) then Result = TRUE else Result = FALSE
                (EXPR_MODE_NEQUAL):
                    If (leftVal <> rightVal) then Result = TRUE else Result = FALSE
	            Default:
	            	Error("Invalid Simple Expression in Listener Condition: '"+expression+"'")
	              	Result = TRUE
	        EndCase
        Endif
    Endif
End

Function RealExpressionIsTrue(expression: String) : Boolean ; Export
Var
	leftExp, rightExp : String
    leftVal, rightVal : Real
    mode : Integer = 0
    delim : String = ""
Begin
    If (Instr(expression,"TRUE")>0) then mode = EXPR_MODE_TRUE
    If (Instr(expression,"FALSE")>0) then mode = EXPR_MODE_FALSE
    If (Instr(expression,"<")>0) then mode = EXPR_MODE_LTHAN ; delim = "<"
    If (Instr(expression,">")>0) then mode = EXPR_MODE_GTHAN ; delim = ">"
    If (Instr(expression,"=")>0) then mode = EXPR_MODE_EQUAL ; delim = "="
    If (Instr(expression,"!")>0) then mode = EXPR_MODE_NEQUAL ; delim = "!"
    
	If (mode = EXPR_MODE_FALSE) then
    	Result = FALSE
    Else
    	If (mode = EXPR_MODE_TRUE) then
        	Result = TRUE
        Else
  			leftExp = TrimSpaces(Left(expression,Instr(expression,delim)-1))
	        rightExp = TrimSpaces(Right(expression,Length(expression)-Instr(expression,delim)))
			leftVal = CalculateRealExpression(leftExp)
	        rightVal = CalculateRealExpression(rightExp)
        
	        Case mode of
	        	(EXPR_MODE_LTHAN):
	            	If (leftVal < rightVal) then Result = TRUE else Result = FALSE 
	           (EXPR_MODE_GTHAN):
	            	If (leftVal > rightVal) then Result = TRUE else Result = FALSE
                (EXPR_MODE_EQUAL):
                    If (leftVal = rightVal) then Result = TRUE else Result = FALSE
                (EXPR_MODE_NEQUAL):
                    If (leftVal <> rightVal) then Result = TRUE else Result = FALSE
	            Default:
	            	Error("Invalid Simple Expression in Listener Condition: '"+expression+"'")
	              	Result = TRUE
	        EndCase
        Endif
    Endif
End

Function StringExpressionIsTrue(expression: String) : Boolean ; Export
Var
	leftExp, rightExp : String
    leftVal, rightVal : String
    mode : Integer = 0
    delim : String = ""
Begin
    If (Instr(expression,"=")>0) then mode = EXPR_MODE_EQUAL ; delim = "="
    If (Instr(expression,"!")>0) then mode = EXPR_MODE_NEQUAL ; delim = "!"
    
	If (mode = EXPR_MODE_FALSE) then
    	Result = FALSE
    Else
 		leftExp = TrimSpaces(Left(expression,Instr(expression,delim)-1))
        leftVal = CalculateStringExpression(leftExp)
	    rightExp = TrimSpaces(Right(expression,Length(expression)-Instr(expression,delim)))
        rightVal = CalculateStringExpression(rightExp)
        
	    Case mode of
	        (EXPR_MODE_NEQUAL):
	            If (leftVal <> rightVal) then Result = TRUE else Result = FALSE 
            (EXPR_MODE_EQUAL):
                If (leftVal = rightVal) then Result = TRUE else Result = FALSE
	        Default:
	            Error("Invalid Simple Expression in Listener Condition: '"+expression+"'")
	            Result = TRUE
	     EndCase
    Endif
End

Function BooleanExpressionIsTrue(expression: String) : Boolean ; Export
Var
	leftExp, rightExp : String
    leftVal, rightVal : Boolean
    mode : Integer = 0
    delim : String = ""
Begin
    If (Instr(expression," ")=0) then expression = Upper(ToString(CalculateBooleanExpression(expression)))
    If (Instr(expression,"TRUE")>0) then mode = EXPR_MODE_TRUE
    If (Instr(expression,"FALSE")>0) then mode = EXPR_MODE_FALSE
    If (Instr(expression,"=")>0) then mode = EXPR_MODE_EQUAL ; delim = "="
    If (Instr(expression,"!")>0) then mode = EXPR_MODE_NEQUAL ; delim = "!"
    
	If (mode = EXPR_MODE_FALSE) then
    	Result = FALSE
    Else
    	If (mode = EXPR_MODE_TRUE) then
        	Result = TRUE
        Else
  			leftExp = TrimSpaces(Left(expression,Instr(expression,delim)-1))
            leftVal = CalculateBooleanExpression(leftExp)
	        rightExp = TrimSpaces(Right(expression,Length(expression)-Instr(expression,delim)))
            rightVal = CalculateBooleanExpression(rightExp)
        
	        Case mode of
	        	(EXPR_MODE_NEQUAL):
	            	If (leftVal <> rightVal) then Result = TRUE else Result = FALSE 
                (EXPR_MODE_EQUAL):
                    If (leftVal = rightVal) then Result = TRUE else Result = FALSE
	            Default:
	            	Error("Invalid Simple Expression in Listener Condition: '"+expression+"'")
	              	Result = TRUE
	        EndCase
        Endif
    Endif
End

Function ExpressionParameters(expression: String, prefixComma: Boolean = TRUE) : String ; Export
{
 	Trims brackets, prefixes comma, so that Parameters are prepared ready to read.
}
Begin
	expression = Right(expression,Length(expression)-Instr(expression, "("))
    expression = Left(expression,Length(expression)-1)
    if prefixComma then expression = "," + expression 
    result = expression	
End

Function ExpressionAttributes(expression: String) : String ; Export
{
 	Obtains attributes from an XML expression such as <form attribute1="value" attribute2="value"> or <item attribute1="value" />
}
Var
    lq : Integer = 0
Begin
	expression = Right(expression,Length(expression)-Instr(expression, " "))

	lq = LastChar(expression, Chr(34))
    
    expression = Left(expression,lq)
    result = expression	
End

Function AttributeAsString(expression: String, pname: String) : String ; Export
Var
	namepos : Integer
    leftQuot, rightQuot : Integer
Begin
	namepos = Instr(expression,pname)
    leftQuot = Instr(expression,Chr(34),namepos)
    rightQuot = Instr(expression,Chr(34),leftQuot+1)
    expression = Mid(expression, leftQuot+1, rightQuot-leftQuot-1)     
    Result = expression
End

Function AttributeAsInteger(expression: String, pname: String) : Integer ; Export
Var
	namepos : Integer
    leftQuot, rightQuot : Integer
Begin
	namepos = Instr(expression,pname)
    leftQuot = Instr(expression,Chr(34),namepos)
    rightQuot = Instr(expression,Chr(34),leftQuot+1)
    expression = Mid(expression, leftQuot+1, rightQuot-leftQuot-1)     
    Result = ToInt(expression)
End

Function AttributeAsReal(expression: String, pname: String) : Real ; Export
Var
	namepos : Integer
    leftQuot, rightQuot : Integer
Begin
	namepos = Instr(expression,pname)
    leftQuot = Instr(expression,Chr(34),namepos)
    rightQuot = Instr(expression,Chr(34),leftQuot+1)
    expression = Mid(expression, leftQuot+1, rightQuot-leftQuot-1)     
    Result = ToReal(expression)
End

Function AttributeAsBoolean(expression: String, pname: String) : Boolean ; Export
Var
	namepos : Integer
    leftQuot, rightQuot : Integer
Begin
	namepos = Instr(expression,pname)
    leftQuot = Instr(expression,Chr(34),namepos)
    rightQuot = Instr(expression,Chr(34),leftQuot+1)
    expression = Mid(expression, leftQuot+1, rightQuot-leftQuot-1)     
    Result = StrToBool(expression)
End

Function ParameterAsString(param: String, pindex: Integer, calc: Boolean=FALSE) : String ; Export
Var
    firstComma, currentComma, nextComma: Integer
    i: Integer
Begin
	{ Loop to index of the value we desire }
    currentComma = 0
	For i = 1 to (pindex+1)
		currentComma = Instr(param,",",currentComma+1)
    	If i = pindex then firstComma = currentComma
        If i = (pindex+1) then nextComma = currentComma
    Next
    
    { Extract... }
    param = TrimSpaces(Mid(param,firstComma+1,nextComma-firstComma-1))
    If calc then param = CalculateStringExpression(param)         
     
    Result = param
End

Function ParameterAsInteger(param: String, pindex: Integer, calc: Boolean=FALSE) : Integer ; Export
Var
    firstComma, currentComma, nextComma: Integer
    i: Integer
    v: Integer
Begin
	{ Loop to index of the value we desire }
    currentComma = 0
	For i = 1 to (pindex+1)
		currentComma = Instr(param,",",currentComma+1)
    	If i = pindex then firstComma = currentComma
        If i = (pindex+1) then nextComma = currentComma
    Next
    
    { Extract... }
    param = TrimSpaces(Mid(param,firstComma+1,nextComma-firstComma-1))
    If calc Then v = CalculateIntegerExpression(param) Else v = ToInt(param)         
     
    Result = v
End

Function ParameterAsReal(param: String, pindex: Integer, calc: Boolean=FALSE) : Real ; Export
Var
    firstComma, currentComma, nextComma: Integer
    i: Integer
    v: Real
Begin
	{ Loop to index of the value we desire }
    currentComma = 0
	For i = 1 to (pindex+1)
		currentComma = Instr(param,",",currentComma+1)
    	If i = pindex then firstComma = currentComma
        If i = (pindex+1) then nextComma = currentComma
    Next
    
    { Extract... }
    param = TrimSpaces(Mid(param,firstComma+1,nextComma-firstComma-1))
    If calc Then v = CalculateRealExpression(param) Else v = ToReal(param)          
     
    Result = v
End

Function ParameterAsBoolean(param: String, pindex: Integer, calc: Boolean=FALSE) : Boolean ; Export
Var
    firstComma, currentComma, nextComma: Integer
    i: Integer
    v : Boolean
Begin
	{ Loop to index of the value we desire }
    currentComma = 0
	For i = 1 to (pindex+1)
		currentComma = Instr(param,",",currentComma+1)
    	If i = pindex then firstComma = currentComma
        If i = (pindex+1) then nextComma = currentComma
    Next
    
    { Extract... }
    param = TrimSpaces(Mid(param,firstComma+1,nextComma-firstComma-1))
    If calc Then v = CalculateBooleanExpression(param) Else v = ToBool(ToInt(param))          
     
    Result = v
End

Function DirectoryUp(dpath: String, levels: Integer=1) : String ; Export
Var
    lq : Integer = 0
Begin
	dpath = Replace(dpath,"/","\",FALSE)
    dpath = Left(dpath, Length(dpath)-1)
    
    lq = LastChar(dpath, "\")
    
    dpath = Left(dpath,lq)
    If (levels > 1) then dpath = DirectoryUp(dpath, levels-1) 
        
    result = dpath
End

Function DirectoryRoot(dpath: String) : String ; Export
Begin
	dpath = Replace(dpath,"/","\",FALSE)
    dpath = Left(dpath, Instr(dpath, "\"))        
    result = dpath
End

Function DirectoryComplete(dpath: String) : String ; Export
Begin
	dpath = Replace(dpath,"/","\",FALSE)
    If (Right(dpath, 1) <> "\") then AppendStr(dpath,"\")        
    result = dpath
End

Function FriendlyExpression(expression: String) : String ; Export
Begin
    expression = Replace(expression, " +", "+", FALSE)
    expression = Replace(expression, "+ ", "+", FALSE)
    expression = Replace(expression, "+", " + ", FALSE)
    expression = Replace(expression, " *", "*", FALSE)
    expression = Replace(expression, "* ", "*", FALSE)
    expression = Replace(expression, "*", " * ", FALSE)
    expression = Replace(expression, " /", "/", FALSE)
    expression = Replace(expression, "/ ", "/", FALSE)
    expression = Replace(expression, "/", " / ", FALSE)
    expression = Replace(expression, " ^", "^", FALSE)
    expression = Replace(expression, "^ ", "^", FALSE)
    expression = Replace(expression, "^", " ^ ", FALSE)
    expression = Replace(expression, " (", "(", FALSE)
    expression = Replace(expression, "( ", "(", FALSE)
    expression = Replace(expression, "(", " ( ", FALSE)
    expression = Replace(expression, " )", ")", FALSE)
    expression = Replace(expression, ") ", ")", FALSE)
    expression = Replace(expression, ")", " ) ", FALSE)
    
    { Negative is special, as can mean negative number or the operation}
    expression = Replace(expression, " - ", "- ", FALSE)
    expression = Replace(expression, "- ", " - ", FALSE)
    
    expression = TrimSpaces(expression)
    Result = expression
End

Function LastChar(haystack: String, needle: String) : Integer ; Export
Var
	i : Integer
    lq : Integer = 0
Begin
    For i = 1 to CountSubStr(haystack, needle)
    	lq = Instr(haystack, needle,lq+1)
    Next
    Result = lq	
End

Function StrIsNumber(a: String) : Boolean ; Export
Begin
    result = IsNumber(a)
End

Function IsNumber(a: String) : Boolean
Var
    b : String
Begin
    b = Left(a,1)
    If ((b="0") or (b="1") or (b="2") or (b="3") or (b="4") or (b="5") or (b="6") or (b="7") or (b="8") or (b="9")) then
        result = TRUE
    Else
        If b="-" then
            b = Left(a,2)
            b = Right(b,1)
            If ((b="0") or (b="1") or (b="2") or (b="3") or (b="4") or (b="5") or (b="6") or (b="7") or (b="8") or (b="9")) then
                result = TRUE
            Else
                result = FALSE
            Endif
        Else
            result = FALSE
        Endif
    Endif 
End

Function StrIsString(a: String) : Boolean ; Export
Begin
    result = IsString(a)
End

Function IsString(a: String) : Boolean
Var
    b : Integer
Begin
    b = Asc(Left(a,1))
    
    Conditions
        ((b >= 65) and (b <= 90)) : result = TRUE
        ((b >= 97) and (b <= 122)) : result = TRUE
        (b = 95) : result = TRUE // Underscore
        Default: result = FALSE
    EndConditions
End

Function StrIsBoolean(a: String) : Boolean ; Export
Begin
    result = IsBoolean(a)
End

Function IsBoolean(a: String) : Boolean
Begin
	If (a = "TRUE") or (a = "FALSE") or (a = "1") or (a = "0") then result = TRUE
End

Procedure SwapIntegers(ByRef a:Integer, ByRef b:Integer) ; Export
Begin
	a = a Xor b
    b = b Xor a
    a = a Xor b
End 

Procedure SwapReals(ByRef a:Real, ByRef b:Real) ; Export
Begin
	a = a + b
    b = a - b
    a = a - b
End

Procedure SwapStrings(ByRef a:String, ByRef b:String) ; Export
Var
	c : String
Begin
	c = b
	b = a
    a = c
End

Procedure SwapBooleans(ByRef a:Boolean, ByRef b:Boolean) ; Export
Begin
	a = a Xor b
    b = b Xor a
    a = a Xor b
End

Procedure AppendStr(ByRef str: String, val: String) ; Export
Begin
	str = str + val
End

Procedure IncInt(ByRef int: Integer, val: Integer) ; Export
Begin
	int = int + val
End

Procedure IncReal(ByRef rea: Real, val: Real) ; Export
Begin
	rea = rea + val
End


Begin
	// Debug On by Default
    InitBasilisk(TRUE)
End
