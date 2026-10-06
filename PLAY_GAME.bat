@echo off
chcp 65001 >nul
title 🌿 Memory Garden - Dang Khoi Dong...
color 0A

echo.
echo  ==============================================================
echo     🌿 MEMORY GARDEN - GAME LAT THE GHI NHO DOI KHANG 🌿
echo  ==============================================================
echo.
echo   [1/3] Dang kiem tra Node.js...

set "NODE_EXE=C:\Program Files\nodejs\node.exe"
if not exist "%NODE_EXE%" (
    where node >nul 2>&1
    if %errorlevel% neq 0 (
        color 0C
        echo.
        echo  [LOI] Khong tim thay Node.js tren may!
        echo  Vui long cai dat Node.js tai: https://nodejs.org
        echo.
        pause
        exit /b
    )
    set "NODE_EXE=node"
)

echo   [OK] Da tim thay Node.js!
echo.
echo   [2/3] Dang kiem tra thu vien...
cd /d "%~dp0"

if not exist "node_modules\" (
    echo   Dang cai dat thu vien lan dau (npm install)...
    call npm install
)

echo.
echo   [3/3] Dang khoi dong Game Server...
echo.

:: Tat cac tien trinh cu tren cong 3000 neu co
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :3000 ^| findstr LISTENING 2^>nul') do taskkill /f /pid %%a >nul 2>&1

:: Chay server chay ngam
start "" /b "%NODE_EXE%" server.js

:: Cho 2 giay de server khoi dong
timeout /t 2 /nobreak >nul

:: Mo trinh duyet vao game
echo   [THANH CONG] Dang mo game tren trinh duyet...
start http://localhost:3000

echo.
echo  ==============================================================
echo   Game dang chay tai: http://localhost:3000
echo.
echo   - De moi ban be trong mang Wi-Fi: hay gui dia chi IP cua ban
echo   - De tat game: Dong cua so mau den (Terminal) nay
echo  ==============================================================
echo.

"%NODE_EXE%" server.js
