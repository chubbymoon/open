@echo off
setlocal enabledelayedexpansion

REM �޲�������򿪽ű�����·��
if "%~1" == "" (
  cd /d "%~dp0"
  start .
  exit /b
)

REM ע�ͣ��뽫��һ���е� "E:\test �ļ���" �޸�Ϊָ��Ŀ¼������
set "my_path=E:\test �ļ���"

REM ������Ҫ���ҵĶ���ؼ���
set "keywords=%~1 %~2"

for /r "%my_path%" %%f in (*%~1*) do (
    REM ��ȡ�����ؼ��ֵ��ļ���
    set "file_name=%%~nxf"
    REM ʹ�� findstr ������Ҹ��ļ������Ƿ�������еĹؼ���
    set "found=1"
    for %%k in (%keywords%) do (
    echo !file_name! | findstr /i /c:"%%k" >nul || set "found=0"
    )
    
    REM �жϲ��ҽ��, ��ȡ·����̡����������һ���ļ�·��
    if !found!==1 (
        if not "!matched!" == "" (
            set "len_name=%%f"
            set "len_name=!len_name:~3!"
            set "matched_name=!matched:~3!"
            if !len_name! lss !len_matched_name! (
              set "matched=%%f"
            )
        ) else (
            set "matched=%%f"
        )
    )
)
REM ��ƥ����ļ�����ʾδ�ҵ�
if not "!matched!" == "" (
  start "" "!matched!"
)else (
  start "" ".NotFound.bat"
)