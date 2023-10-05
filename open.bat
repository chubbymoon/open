@echo off
setlocal enabledelayedexpansion

REM 注释: 请将下一行中的 "E:\test文件夹" 修改为指定目录!
set path="E:\test文件夹"
set search=%1
set search=!search:"=!

for /r %path% %%f in (*%search%*) do (
start "" "%%f"
)