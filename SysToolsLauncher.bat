@echo off
title MultiToolsShell Launcher

set SCRIPT_DIR=%~dp0

powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%MultiToolsShell.ps1"

pause
