@echo off
title LureDesigner
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0spustit-server.ps1"
if errorlevel 1 pause
