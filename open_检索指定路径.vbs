' -- 请确保该文本的编码方式为 "GBK" --
Set objShell = WScript.CreateObject("WScript.Shell")

'请将下一行中的 "searchPath1 = "后的值, 修改为要搜索的路径！
searchPath1 = "D:\软件目录"
' 备用的扩展路径
searchPath2 = ""
searchPath3 = ""

' -- 为保障程序的稳定性，一般用户请勿修改一下内容 --
searchPaths = ""
searchPaths = searchPaths & searchPath1
searchPaths = searchPaths & "|" & searchPath2
searchPaths = searchPaths & "|" & searchPath3

searchPaths = " """ & searchPaths & """"

' 关联搜索器
searchWay = "way.bat"

keywords = ""

'对变量做参数的预处理(添加空格)
For Each arg In WScript.Arguments
    keywords = keywords & " """ & arg & """"
Next

' 判断是否有参数传入
If WScript.Arguments.Count > 0 Then
    objShell.Run "cmd /c" & searchWay & searchPaths & keywords, 0, True
Else
    objShell.Run "cmd /c" & searchWay & searchPaths & keywords, 1, True
End If


