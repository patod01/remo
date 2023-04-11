@echo off

:: por defecto, debe encontrarse en modo 'dev'
..\.env\Scripts\python.exe app.py dev
rem ..\.env\Scripts\python.exe app.py Gevent
pause>nul
