' -- ��ȷ�����ı��ı��뷽ʽΪ "GBK" --
Set objShell = WScript.CreateObject("WScript.Shell")
Set WshShell = CreateObject("WScript.Shell")
desktop = WshShell.SpecialFolders("Desktop")

'�뽫��һ���е� "searchPath = desktop", ��ʾҪ������·��Ϊ���棡
searchPath = desktop
searchWay = "way.bat"
keywords = ""

'�Ա�����������Ԥ����(��ӿո�)
For Each arg In WScript.Arguments
    keywords = keywords & " """ & arg & """"
Next
searchPath = " """ & searchPath & """"

' �ж��Ƿ��в�������
If WScript.Arguments.Count > 0 Then
    objShell.Run "cmd /c" & searchWay & searchPath & keywords, 0, True
Else
    objShell.Run "cmd /c" & searchWay & searchPath & keywords, 1, True
End If
