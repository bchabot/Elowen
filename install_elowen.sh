#!/bin/bash
# Elowen Core Installer - Linux/MacOS
echo -e "\033[0;36mInitializing Elowen Core Installation...\033[0m"

# 1. Create Folder Structure
mkdir -p core agents data ui docs
echo "Folders created."

# 2. Setup Virtual Environment
if [ ! -d "venv" ]; then
    echo -e "\033[0;33mCreating Virtual Environment...\033[0m"
    python3 -m venv venv
fi

# 3. Install Dependencies
echo -e "\033[0;33mInstalling 2025 Agentic Stack...\033[0m"
source venv/bin/activate
pip install --upgrade pip
pip install fastapi uvicorn google-generativeai python-dotenv langgraph pydantic

# 4. Create Boilerplate Files
if [ ! -f ".env" ]; then
    echo -e "GEMINI_API_KEY=your_key_here\nPORT=8000" > .env
fi

if [ ! -f "core/main.py" ]; then
cat <<EOF > core/main.py
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
EOF
fi

echo -e "\n\033[0;32mInstallation Complete!\033[0m"
echo "To start the core: source venv/bin/activate && uvicorn core.main:app --reload"
