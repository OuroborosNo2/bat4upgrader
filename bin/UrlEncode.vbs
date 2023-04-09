'UrlEncode By Demon
 
Function UrlEncode(str)
    Dim i,c,s,length
    length = Len(str)
    For i = 1 To length
        s = Mid(str,i,1)
        c = "&H" & Hex(AscW(Mid(str,i,1)))
        If ( c >= AscW("A") And c <= AscW("Z") ) Or _
            ( c >= AscW("a") And c <= AscW("z") ) Or _
            ( c >= AscW("0") And c <= AscW("9") ) Or _
            ( c = AscW("-") Or c = AscW("_") Or c = AscW(".") ) Or _
            ( c = Asc(":") Or c = Asc("/") ) Then
            UrlEncode = UrlEncode & s
        ElseIf c = AscW(" ") Then
            UrlEncode = UrlEncode & "+"
        Else
            If c >= &H0001 And c <= &H007F Then
                UrlEncode = UrlEncode & s
            ElseIf c > &H07FF Then
                UrlEncode = UrlEncode & "%" & Hex(&HE0 Or (c\(2^12) And &H0F))
                UrlEncode = UrlEncode & "%" & Hex(&H80 Or (c\(2^6) And &H3F))
                UrlEncode = UrlEncode & "%" & Hex(&H80 Or (c\(2^0) And &H3F))
            Else
                UrlEncode = UrlEncode & "%" & Hex(&HC0 Or (c\(2^6) And &H1F))
                UrlEncode = UrlEncode & "%" & Hex(&H80 Or (c\(2^0) And &H3F))
            End If
        End If
    Next
End Function
 
WScript.Echo UrlEncode(WScript.Arguments(0))
