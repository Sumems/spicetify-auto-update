@echo off
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "Manage-SpicetifyAutoUpdate.ps1"
