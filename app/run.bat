@echo off

:: configuracion de entorno para windows
if not exist ..\.env\Scripts\python.exe (
     echo Installanding Piton...
     python -m venv ..\.env
     ..\.env\Scripts\activate.bat
     python -m pip install --upgrade pip
     pip install --no-cache-dir -r req.txt
     echo.
     echo escrit de instalacion terminado!!
     pause>nul
     goto ned
)

:: por defecto, debe encontrarse en modo 'dev'
..\.env\Scripts\python.exe app.py dev
rem ..\.env\Scripts\python.exe app.py Gevent

:ned
