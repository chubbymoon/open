@echo off
setlocal enabledelayedexpansion

REM -- ��ȷ�����ı��ı��뷽ʽΪ "GBK" -- 

REM ָ����Ҫ�����ļ���·��
set "myPaths=%~1"

REM ���չؼ��� (˫ģʽ)
if "%~2" == "" (
    REM ģʽһ��cmd��������
    set "in_mode=1"
    echo �ҽ�������ض�·���£�����ȫ���ؼ��ֵ��ļ�
    echo ·��: 
    REM ��ʾ·��
    for /f "tokens=1-3 delims=|" %%a in ("!myPaths!") do (
        if not "%%a"=="" (
            echo   %%a
        )
        if not "%%b"=="" (
            echo   %%b
        )
        if not "%%c"=="" (
            echo   %%c
        )
    )
    REM ���ܹؼ��֣���������
    echo.
    set /p "UserInput=������ؼ��֣�"
    for /f "tokens=1,*" %%a in ("!UserInput!") do (
        set "keywords1=%%a"
        set "keywordsOther=%%b"
    
    )
) else (
    REM ģʽ�������д�������
    set "in_mode=2"
    REM ���ܹؼ��֣����֧������
    set "keywords1=%~2"
    set "keywordsOther=%~3"
    
)

if "%keywords1%" == "" (
    echo.
    echo �ؼ���Ϊ�գ�
)

REM ������Ҫ����ȫ���ؼ���
set "keywords=%keywords1% %keywordsOther%"

REM ����ָ��·���°����ؼ��ֵ��ļ�
for /f "tokens=1-3 delims=|" %%a in ("!myPaths!") do (
    
    if not "%%a"=="" (
        set "myPath=%%a"
        call :findfile
    )

    if not "%%b"=="" (
        set "myPath=%%b"
        call :findfile
    )

    if not "%%c"=="" (
        set "myPath=%%c"
        call :findfile
        )
    
)

if "%myPath%"=="" (
    echo.
    echo δָ��·����
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

REM �ű����ģ��ļ�������
:findfile
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
goto :eof

REM �Ƚ�ָ���ļ������ַ�����
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
