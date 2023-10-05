@echo off
setlocal enabledelayedexpansion

REM 无参数情况打开脚本所在路径
if "%~1" == "" (
  cd /d "%~dp0"
  start .
  exit /b
)

REM 注释：请将下一行中的 "E:\test 文件夹" 修改为指定目录！！！
set "my_path=E:\test 文件夹"

REM 定义需要查找的多个关键字
set "keywords=%~1 %~2"

for /r "%my_path%" %%f in (*%~1*) do (
    REM 提取包含关键字的文件名
    set "file_name=%%~nxf"
    REM 使用 findstr 命令查找该文件名中是否包含所有的关键字
    set "found=1"
    for %%k in (%keywords%) do (
    echo !file_name! | findstr /i /c:"%%k" >nul || set "found=0"
    )
    
    REM 判断查找结果, 提取路径最短、名称排序第一的文件路径
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
REM 打开匹配的文件或提示未找到
if not "!matched!" == "" (
  start "" "!matched!"
)else (
  start "" ".NotFound.bat"
)