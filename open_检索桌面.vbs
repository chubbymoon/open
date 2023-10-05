' -- 请确保该文本的编码方式为 "GBK" --
' -- 为保障程序的稳定性，一般用户请勿修改以下内容 --

Set objShell = WScript.CreateObject("WScript.Shell")
Set WshShell = CreateObject("WScript.Shell")
desktop = WshShell.SpecialFolders("Desktop")

' -- 为保障程序的稳定性，一般用户请勿修改以下内容 --
'下一行中的 "searchPath = desktop", 表示要搜索的路径为桌面！
searchPath = desktop
searchWay = "way.bat"
keywords = ""

'对变量做参数的预处理(添加空格)
For Each arg In WScript.Arguments
    keywords = keywords & " """ & arg & """"
Next
searchPath = " """ & searchPath & """"

' 判断是否有参数传入
If WScript.Arguments.Count > 0 Then
    objShell.Run "cmd /c" & searchWay & searchPath & keywords, 0, True
Else
    objShell.Run "cmd /c" & searchWay & searchPath & keywords, 1, True
End If
