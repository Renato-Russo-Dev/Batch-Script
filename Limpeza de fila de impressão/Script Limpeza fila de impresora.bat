@echo off

:: Verifica se o script está sendo executado como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando permissões de administrador...
    powershell start-process -verb runas -filepath "%~f0"
    exit /b
)

echo.
echo Limpando fila de impressão...
echo.

:: Para o serviço de spooler de impressão
net stop spooler
echo Serviço de spooler de impressão parado.

:: Remove todos os arquivos na pasta de spool
del /Q /F %systemroot%\System32\spool\PRINTERS\*.* 
echo Arquivos de spool removidos.

:: Reinicia o serviço de spooler de impressão
net start spooler
echo Serviço de spooler de impressão reiniciado.

echo.
echo Fila de impressão limpa com sucesso.
pause
