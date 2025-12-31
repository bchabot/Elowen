# Elowen Core Installer - Windows 11
Write-Host "Initializing Elowen Core Installation..." -ForegroundColor Cyan

# 1. Create Folder Structure
$folders = "core", "agents", "data", "ui", "docs"
foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder
        Write-Host "Created folder: $folder"
    }
}

# 2. Setup Virtual Environment
if (!(Test-Path "venv")) {
    Write-Host "Creating Virtual Environment..." -ForegroundColor Yellow
    python -m venv venv
}

# 3. Install Dependencies
Write-Host "Installing 2025 Agentic Stack..." -ForegroundColor Yellow
& .\venv\Scripts\pip install --upgrade pip
& .\venv\Scripts\pip install fastapi uvicorn google-generativeai python-dotenv langgraph pydantic

# 4. Create Boilerplate Files
if (!(Test-Path ".env")) {
    "GEMINI_API_KEY=your_key_here`nPORT=8000" | Out-File -FilePath ".env" -Encoding utf8
}

if (!(Test-Path "core\main.py")) {
@"
from fastapi import FastAPI
import os
from dotenv import load_dotenv

load_dotenv()
app = FastAPI(title='Elowen Core')

@app.get('/')
async def health_check():
    return {
        'status': 'online',
        'identity': 'Elowen',
        'objective': 'Laplink Success Strategy'
    }
"@ | Out-File -FilePath "core\main.py" -Encoding utf8
}

Write-Host "`nInstallation Complete!" -ForegroundColor Green
Write-Host "To start the core: .\venv\Scripts\python -m uvicorn core.main:app --reload"
