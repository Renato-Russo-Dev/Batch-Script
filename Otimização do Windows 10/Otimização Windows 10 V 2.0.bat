@echo off
echo Iniciando script de otimizacao do Windows 10 v2.0...

:: Verifica se o script está sendo executado como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando permissões de administrador...
    powershell start-process -verb runas -filepath "%~f0"
    exit /b
)

echo.
echo Limpando o sistema...

:: Desativar serviços específicos
echo Desativando serviços específicos...
sc config Spooler start=disabled
sc stop Spooler

sc config WinDefend start=disabled
sc stop WinDefend

sc config HvHost start=disabled
sc stop HvHost

sc config XblAuthManager start=disabled
sc stop XblAuthManager

sc config AppXSvc start=disabled
sc stop AppXSvc

sc config DcpSvc start=disabled
sc stop DcpSvc

sc config WpnUserService start=disabled
sc stop WpnUserService

sc config Fax start=disabled
sc stop Fax

sc config WMPNetworkSvc start=disabled
sc stop WMPNetworkSvc

sc config AdobeLM Service start=disabled
sc stop AdobeLM Service

sc config PolicyAgent start=disabled
sc stop PolicyAgent

sc config helpsv start=disabled
sc stop helpsv

sc config WiaRpc start=disabled
sc stop WiaRpc

sc config SensrSvc start=disabled
sc stop SensrSvc

sc config Audiosrv start=disabled
sc stop Audiosrv

sc config LanmanWorkstation start=disabled
sc stop LanmanWorkstation

sc config UmRdpService start=disabled
sc stop UmRdpService

sc config WalletService start=disabled
sc stop WalletService

sc config WSearch start=disabled
sc stop WSearch

:: Desativar Telemetria do Windows
echo Desativando Telemetria do Windows...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DisableEnterpriseAuthProxy /t REG_DWORD /d 1 /f

:: Desativar efeitos visuais
echo Desativando efeitos visuais...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v AccentColorInactive /t REG_DWORD /d 1 /f

:: Ativar fontes de tela com cantos arredondados
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f

:: Desativar Bitlocker
echo Desativando Bitlocker...
manage-bde -off C:

:: Desativar assistência remota
echo Desativando assistência remota...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f

:: Desativar proteção de sistema
echo Desativando proteção de sistema...
wmic.exe /namespace:\\root\default path SystemRestore call Disable

:: Limpar a Lixeira
echo Limpando a Lixeira...
rd /s /q %systemdrive%\$Recycle.Bin
echo Lixeira limpa.

:: Limpar arquivos temporários
echo Limpando arquivos temporários...
del /s /q /f %temp%\* > nul
rd /s /q %temp%
md %temp%
echo Arquivos temporários limpos.

:: Limpar arquivos Prefetch
echo Limpando arquivos Prefetch...
del /s /q /f %systemroot%\Prefetch\* > nul
echo Arquivos Prefetch limpos.

:: Limpar arquivos temporários do Windows
echo Limpando arquivos temporários do Windows...
del /s /q /f %systemroot%\Temp\* > nul
echo Arquivos temporários do Windows limpos.

:: Limpar área de transferência
echo Limpando a área de transferência...
cmd.exe /c "echo off | clip"
echo Área de transferência limpa.

:: Limpar despejos de memória
echo Limpando despejos de memória...
del /s /q /f %systemroot%\MEMORY.DMP > nul
del /s /q /f %systemroot%\Minidump\* > nul
echo Despejos de memória limpos.

:: Limpar fragmentos do verificador de disco
echo Limpando fragmentos do verificador de disco...
del /s /q /f %systemroot%\*.chk > nul
echo Fragmentos do verificador de disco limpos.

:: Limpar relatórios do Windows
echo Limpando relatórios do Windows...
del /s /q /f %systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WER\* > nul
del /s /q /f %systemroot%\ProgramData\Microsoft\Windows\WER\* > nul
echo Relatórios do Windows limpos.

:: Limpar registros de rastreamento de eventos do Windows
echo Limpando registros de rastreamento de eventos do Windows...
del /s /q /f %systemroot%\System32\LogFiles\WMI\* > nul
echo Registros de rastreamento de eventos do Windows limpos.

:: Limpar relatório de erro do Windows
echo Limpando relatório de erro do Windows...
del /s /q /f %systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\WER\ReportQueue\* > nul
del /s /q /f %systemroot%\ProgramData\Microsoft\Windows\WER\ReportQueue\* > nul
echo Relatório de erro do Windows limpo.

:: Limpar cache DNS
echo Limpando cache DNS...
ipconfig /flushdns
echo Cache DNS limpo.

:: Limpar arquivos de registro de drivers
echo Limpando arquivos de registro de drivers...
del /s /q /f %systemroot%\System32\LogFiles\* > nul
echo Arquivos de registro de drivers limpos.

:: Limpar arquivos de otimização de entrega do Windows
echo Limpando arquivos de otimização de entrega do Windows...
del /s /q /f %systemroot%\SoftwareDistribution\Download\* > nul
echo Arquivos de otimização de entrega do Windows limpos.

:: Limpar notificações do Windows
echo Limpando notificações do Windows...
del /s /q /f %systemroot%\AppData\Local\Microsoft\Windows\Notifications\WpnCoreData\* > nul
echo Notificações do Windows limpas.

:: Limpar utilização de dados de rede
echo Limpando utilização de dados de rede...
del /s /q /f %systemroot%\System32\sru\* > nul
echo Utilização de dados de rede limpa.

:: Limpar cache web do Windows
echo Limpando cache web do Windows...
del /s /q /f %systemroot%\System32\config\systemprofile\AppData\Local\Microsoft\Windows\INetCache\* > nul
echo Cache web do Windows limpo.

:: Limpar registros de eventos do Windows
echo Limpando registros de eventos do Windows...
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :ClearLog "%%G")
echo Registros de eventos do Windows limpos.

:ClearLog
echo Limpando log de eventos %1
wevtutil.exe cl %1
exit /b

echo.
echo Otimizacao concluida.
pause
