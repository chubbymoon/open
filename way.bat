@echo off
setlocal enabledelayedexpansion

REM -- 请确保该文本的编码方式为 "GBK" -- 

REM 指定需要查找文件的路径
set "myPaths=%~1"

REM 接收关键词 (双模式)
if "%~2" == "" (
    REM 模式一：cmd窗口输入
    set "in_mode=1"
    echo 我将帮你打开特定路径下，包含全部关键字的文件
    echo 路径: 
    REM 提示路径
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
    REM 接受关键字，个数不限
    echo.
    set /p "UserInput=请输入关键字："
    for /f "tokens=1,*" %%a in ("!UserInput!") do (
        set "keywords1=%%a"
        set "keywordsOther=%%b"
    
    )
) else (
    REM 模式二：运行窗口输入
    set "in_mode=2"
    REM 接受关键字，最多支持两个
    set "keywords1=%~2"
    set "keywordsOther=%~3"
    
)

if "%keywords1%" == "" (
    echo.
    echo 关键字为空！
)

REM 定义需要查找全部关键词
set "keywords=%keywords1% %keywordsOther%"

REM 检索指定路径下包含关键字的文件
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
    echo 未指定路径！
) 

REM 打开匹配的文件或提示未找到
if not "!matched!" == "" (
    start "" "!matched!"
    echo.
    echo OK！
    echo.
    for %%a in ("!matched!") do set "matched_name=%%~na"
    echo 已打开: !matched_name!
    echo.
    echo.
    echo 该窗口自动关闭中... 
    TIMEOUT /t 3 > NUL
)else (
    if "%in_mode%" == "1" (
        REM 模式一：cmd窗口输入
        echo.
        echo 没有找到相关的文件耶！
        echo.
        echo.
        echo 该窗口自动关闭中...   
        TIMEOUT /t 3 > NUL
    ) else if "%in_mode%" == "2" (
        start "" ".NotFound.bat"
    )
)
EXIT

REM 脚本核心：文件搜索器
:findfile
for /r "%myPath%" %%f in (*%keywords1%*) do (
    REM 提取包含关键字的文件名
    set "file_full_name=%%~nxf"
    REM 使用 findstr 命令查找该文件名中是否包含所有的关键字
    set "found=1"
    for %%k in (%keywords%) do (
    echo !file_full_name! | findstr /i /c:"%%k" >nul || set "found=0"
    )
    REM 判断查找结果, 提取最优匹配 [在文件名(不含后缀名)最短的前提下, 匹配全路径按照名称排序的首位文件]
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

REM 比较指定文件名的字符长度
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
