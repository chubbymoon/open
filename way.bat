@echo off
setlocal enabledelayedexpansion
@rem -- ��ȷ�����ı��ı��뷽ʽΪ "GBK" -- 

REM ָ����Ҫ�����ļ���·��
set "myPath=%~1"
    
REM ���չؼ��� (˫ģʽ)
if "%~2" == "" (
    REM ģʽһ��cmd��������
    echo �ҽ�������ض�·���£�����ȫ���ؼ��ֵ��ļ�
    echo ·��: "%myPath%"
    echo.
    set /p "UserInput=������ؼ��֣�"
    for /f "tokens=1,*" %%a in ("!UserInput!") do (
        set "keywords1=%%a"
        set "keywordsOther=%%b"
    set "in_mode=1"
    )
) else (
    REM ģʽ�������д�������
    set "keywords1=%~2"
    set "keywordsOther=%~3"
    set "in_mode=2"
)

if "%keywords1%" == "" (
    echo.
    echo �ؼ���Ϊ��
)

REM ������Ҫ���ҹؼ���
set "keywords=%keywords1% %keywordsOther%"

REM ����ָ��·���°����ؼ��ֵ��ļ�
for /r "%myPath%" %%f in (*%keywords1%*) do (
    REM ��ȡ�����ؼ��ֵ��ļ���
    set "file_full_name=%%~nxf"
    REM ʹ�� findstr ������Ҹ��ļ������Ƿ�������еĹؼ���
    set "found=1"
    for %%k in (%keywords%) do (
    echo !file_full_name! | findstr /i /c:"%%k" >nul || set "found=0"
    )
    REM �жϲ��ҽ��, ��ȡ����ƥ�� [���ļ���(������׺��)��̵�ǰ����, ƥ��ȫ·�����������������λ�ļ�]
    if !found!==1 (
        if "!matched!" == "" (
            set "matched=%%f"
        ) else (
            set "refind_name=%%~nf"
            for %%a in ("!matched!") do set "matched_name=%%~na"
            set "name1=!refind_name!"
            set "name2=!matched_name!"
            call :shorter_name
            if !name1_len! lss !name2_len! (
              set "matched=%%f"
            )
        )
    )
)

REM ��ƥ����ļ�����ʾδ�ҵ�
if not "!matched!" == "" (
    start "" "!matched!"
    echo.
    echo OK��
    echo.
    for %%a in ("!matched!") do set "matched_name=%%~na"
    echo �Ѵ�: !matched_name!
    echo.
    echo.
    echo �ô����Զ��ر���... 
    TIMEOUT /t 3 > NUL
)else (
    if "%in_mode%" == "1" (
        REM ģʽһ��cmd��������
        echo.
        echo û���ҵ���ص��ļ�Ү��
        echo.
        echo.
        echo �ô����Զ��ر���...   
        TIMEOUT /t 3 > NUL
    ) else if "%in_mode%" == "2" (
        start "" ".NotFound.bat"
    )
)

EXIT

:shorter_name
set count=0
set "arg1=!name1!"
call :get_str_len
set /a name1_len=%count%

set count=0
set "arg1=!name2!"
call :get_str_len
set /a name2_len=%count%

goto :eof

:get_str_len
if not "!arg1:~%count%,1!" == "" (
    set /a count+=1
    goto get_str_len
)

goto :eof
