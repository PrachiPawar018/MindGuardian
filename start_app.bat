@echo off
setlocal enabledelayedexpansion

echo ==========================================
echo Starting MindGuardian Components...
echo ==========================================

:: Start Backend (Node.js)
start cmd /k "title MindGuardian Backend && cd /d "%~dp0backend" && npm run dev"

:: Start AI Service (Python with venv)
start cmd /k "title MindGuardian AI Service && cd /d "%~dp0ai_service" && call venv\Scripts\activate.bat && py -m pip install -q -r requirements.txt >nul 2>&1 && py app.py"

:: Start Frontend (React/Vite)
start cmd /k "title MindGuardian Frontend && cd /d "%~dp0frontend" && npm run dev"

echo.
echo ==========================================
echo All services are starting...
echo ==========================================
echo Backend:   http://localhost:5000
echo AI Service: http://localhost:5001
echo Frontend:   http://localhost:5173
echo.
echo Close individual windows to stop services.
echo ==========================================
pause
