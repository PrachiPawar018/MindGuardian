@echo off
setlocal enabledelayedexpansion

echo ==========================================
echo MindGuardian AI Chatbot Backend Startup
echo ==========================================

cd /d "%~dp0ai_service"

:: Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not found in your PATH.
    echo Please install Python from https://www.python.org/
    pause
    exit /b 1
)

:: Use a local venv inside ai_service for better isolation
if not exist "venv\Scripts\activate.bat" (
    echo Creating local virtual environment in %CD%\venv...
    python -m venv venv
)

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Checking/Installing Python dependencies...
python -m pip install --upgrade pip
pip install -r requirements.txt

:: Check if textblob corpora are needed
python -c "import textblob; textblob.TextBlob('test').sentiment" >nul 2>&1
if %errorlevel% neq 0 (
    echo Downloading required TextBlob corpora...
    python -m textblob.download_corpora
)

echo Launching application on port 5001...
python app.py

if %errorlevel% neq 0 (
    echo [ERROR] AI Service crashed or failed to start.
    echo Check the messages above for details.
)

pause

