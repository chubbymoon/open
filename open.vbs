' -- run.vbs --
Set objShell = WScript.CreateObject("WScript.Shell")

file = "way.bat"
strArguments = ""

' 判断是否有参数传入
If WScript.Arguments.Count > 0 Then
    For Each arg In WScript.Arguments
        strArguments = strArguments & " """ & EncodeParameter(arg) & """"
    Next
Else
    ' 如果没有参数传入，则打开脚本所在目录
    strCurrentDirectory = objShell.CurrentDirectory
    objShell.Run "explorer.exe """ & strCurrentDirectory & """"
    WScript.Quit
End If

objShell.Run "cmd /c" & file & strArguments, 0, True

Function EncodeParameter(str)
  EncodeParameter = Replace(str, "%", "%%")
End Function