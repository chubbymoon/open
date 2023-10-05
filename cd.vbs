' -- 请确保该文本的编码方式为 "GBK" --
Set objShell = WScript.CreateObject("WScript.Shell")

'请将下一行中的 "searchPath = "后的值, 修改为要搜索的路径！
searchPath = "D:\常用文件夹"


' -- 为保障程序的稳定性，一般用户请勿修改以下内容 --
searchWay = "way.bat"
strKeys = ""

' 判断是否有参数传入
If WScript.Arguments.Count > 0 Then
    For Each arg In WScript.Arguments
        strKeys = strKeys & " """ & arg & """"
    Next
    searchPath = " """ & searchPath & """"
Else
    ' 如果没有参数传入，则打开脚本所在目录
    strCurrentDirectory = objShell.CurrentDirectory
    objShell.Run "explorer.exe """ & strCurrentDirectory & """"
    WScript.Quit
End If

objShell.Run "cmd /c" & searchWay & searchPath & strKeys, 0, True
