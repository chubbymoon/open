@echo off
setlocal enabledelayedexpansion

REM ע��: �뽫��һ���е� "E:\test�ļ���" �޸�Ϊָ��Ŀ¼!
set path="E:\test�ļ���"
set search=%1
set search=!search:"=!

for /r %path% %%f in (*%search%*) do (
start "" "%%f"
)