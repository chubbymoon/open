' -- ��ȷ�����ı��ı��뷽ʽΪ "GBK" --
Set objShell = WScript.CreateObject("WScript.Shell")

'�뽫��һ���е� "searchPath = "���ֵ, �޸�ΪҪ������·����
searchPath = "E:\test �ļ���"
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


