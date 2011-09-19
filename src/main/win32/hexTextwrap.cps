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
        cobra2d
    
Const
    WT_ARRAY_SIZE = 1024
    LINE_SPACING = 1.0

Var
    breakPoint: Array [WT_ARRAY_SIZE] of Integer
    breakPointString: String
    breakPointLength: Array [WT_ARRAY_SIZE] of Integer
    breakPointForce: Array [WT_ARRAY_SIZE] of Boolean

Function hTextWrap(x: Integer, y:Integer, w: Integer, s: String, buf: Element) : Integer ; export
Var
    i, l, c, t, j: Integer
    txtl, txth, txtx: Integer
    lineStart: Integer
Begin
    l = Length(s)
    
    // First breakpoint
    breakPoint[0] = 1
    t = 1
    
    // Find potential breakpoints (space or newline)
    For i = 1 to l
        c = Asc(Mid(s, i, 1))
        If (c = 10) or (c = 32) then
            
            // Remove linebreak
            If (c = 10) then
                s = Left(s, i-1) + " " + Right(s, l-i)
                breakPointForce[t] = TRUE
            Else
                breakPointForce[t] = FALSE
            Endif
        
            breakPoint[t] = i + 1                         
            Inc(t)
        Endif
        
        If t = (WT_ARRAY_SIZE - 2) then break 
    Next
    
    // End
    If t < (WT_ARRAY_SIZE - 2)
        breakPoint[t] = l + 1                         
        Inc(t)
    Endif
    
    // Determine breaks
    txtl = 0
    txtx = 0
    lineStart = 1
    
    For i = 1 to (t)
        breakPointString = Mid(s, breakPoint[i-1], breakPoint[i] - breakPoint[i-1])
        breakPointLength[i] = TextWidth(breakPointString, buf)
        If i = 1 then txth = TextHeight(breakPointString, buf)
        
        If (txtl + breakPointLength[i] > w) or (breakPointForce[i-1]) or (i = (t)) then
            
            // Reached limit - render line
            For j = lineStart to (i-1)
                Text(x + txtx, y, Mid(s, breakPoint[j-1], breakPoint[j] - breakPoint[j-1]), buf)
                txtx = txtx + breakPointLength[j] // Increment x
            Next
            
            If breakPointForce[i-1] = TRUE then breakPointForce[i-1] = FALSE // Stop forced linebreak
            lineStart = i                   // Increment line starting index
            y = y + (txth * LINE_SPACING)   // Increment y
            If i < (t) then Dec(i)          // Rewind loop
            txtl = 0                        // Reset Line length
            txtx = 0                        // Reset x
                    
        Else
            txtl = txtl + breakPointLength[i]
        Endif
    Next
    
    breakPointString = ""
    result = y

End

Begin
End