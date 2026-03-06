@echo off
setlocal enabledelayedexpansion

echo Starting MindGuardian AI Chatbot Backend...

cd /d "%~dp0ai_service"

:: Check for Python (py or python)
set PYTHON_CMD=
py --version >nul 2>&1
if !errorlevel! equ 0 (
    set PYTHON_CMD=py
) else (
    python --version >nul 2>&1
    if !errorlevel! equ 0 (
        set PYTHON_CMD=python
    )
)

if "%PYTHON_CMD%"=="" (
    echo [ERROR] Python is not found in your PATH.
    echo Please install Python from https://www.python.org/
    pause
    exit /b 1
)

:: Create venv if missing
if not exist "venv\Scripts\activate.bat" (
    echo Creating virtual environment...
    %PYTHON_CMD% -m venv venv
)

echo Activating existing virtual environment...
:: Use explicit paths to bypass activation issues
set VENV_PYTHON=venv\Scripts\python.exe
set VENV_PIP=venv\Scripts\pip.exe

echo Installing Python dependencies...
"%VENV_PYTHON%" -m pip install --upgrade pip >nul 2>&1
"%VENV_PIP%" install -r requirements.txt

:: Check if textblob corpora are needed
"%VENV_PYTHON%" -c "import textblob; textblob.TextBlob('test').sentiment" >nul 2>&1
if !errorlevel! neq 0 (
    echo Downloading required TextBlob corpora...
    "%VENV_PYTHON%" -m textblob.download_corpora
)

echo Launching application...
"%VENV_PYTHON%" app.py

if !errorlevel! neq 0 (
    echo [ERROR] AI Service crashed or failed to start.
    echo Check the messages above for details.
)

pause

