' -- ��ȷ�����ı��ı��뷽ʽΪ "GBK" --
Set objShell = WScript.CreateObject("WScript.Shell")
Set WshShell = CreateObject("WScript.Shell")
desktop = WshShell.SpecialFolders("Desktop")

'�뽫��һ���е� "searchPath = desktop", ��ʾҪ������·��Ϊ���棡
searchPath = desktop
searchWay = "way.bat"
strKeys = ""

' �ж��Ƿ��в�������
If WScript.Arguments.Count > 0 Then
    For Each arg In WScript.Arguments
        strKeys = strKeys & " """ & arg & """"
    Next
    searchPath = " """ & searchPath & """"
Else
    ' ���û�в������룬��򿪽ű�����Ŀ¼
    strCurrentDirectory = objShell.CurrentDirectory
    objShell.Run "explorer.exe """ & strCurrentDirectory & """"
    WScript.Quit
End If

objShell.Run "cmd /c" & searchWay & searchPath & strKeys, 0, True
