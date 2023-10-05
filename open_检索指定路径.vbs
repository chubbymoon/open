' -- 请确保该文本的编码方式为 "GBK" --
Set objShell = WScript.CreateObject("WScript.Shell")

'请将下一行中的 "searchPath = "后的值, 修改为要搜索的路径！
searchPath = "E:\test 文件夹"
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


