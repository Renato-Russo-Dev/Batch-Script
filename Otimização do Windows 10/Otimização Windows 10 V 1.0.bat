@echo off
echo Iniciando script de otimizacao do Windows 10 v1.0...

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

:: Limpar arquivos temporários
echo Limpando arquivos temporarios...
del /q /s /f %temp%\*
del /q /s /f C:\Windows\Prefetch\*

echo Otimizacao concluida.

pause
