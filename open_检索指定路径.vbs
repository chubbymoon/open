' -- ��ȷ�����ı��ı��뷽ʽΪ "GBK" --
Set objShell = WScript.CreateObject("WScript.Shell")

'�뽫��һ���е� "searchPath1 = "���ֵ, �޸�ΪҪ������·����
searchPath1 = "D:\���Ŀ¼"
' ���õ���չ·��
searchPath2 = ""
searchPath3 = ""

' -- Ϊ���ϳ�����ȶ��ԣ�һ���û������޸�һ������ --
searchPaths = ""
searchPaths = searchPaths & searchPath1
searchPaths = searchPaths & "|" & searchPath2
searchPaths = searchPaths & "|" & searchPath3

searchPaths = " """ & searchPaths & """"

' ����������
searchWay = "way.bat"

keywords = ""

'�Ա�����������Ԥ����(��ӿո�)
For Each arg In WScript.Arguments
    keywords = keywords & " """ & arg & """"
Next

' �ж��Ƿ��в�������
If WScript.Arguments.Count > 0 Then
    objShell.Run "cmd /c" & searchWay & searchPaths & keywords, 0, True
Else
    objShell.Run "cmd /c" & searchWay & searchPaths & keywords, 1, True
End If


