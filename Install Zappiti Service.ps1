Write-Host 'Please Wait.. Installing Zappiti Server Service'
Write-Host 'Downloading Chocolatey Package Manager.'
#Download and Install Choclatey Package Manager
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host 'Done.. Creating Service with NSSM'
#Install Non-Sucking Service Manager from Choclatey
choco install nssm
#Create Service with NSSM
$nssm = 'C:\ProgramData\chocolatey\lib\NSSM\tools\nssm.exe'
$ServiceName = 'Zappiti Server'
$ServicePath = 'C:\Program Files (x86)\Groupe ARCHISOFT\Zappiti Server\Zappiti.Server.WPF.exe'
$ServiceArgument= C:\Program Files (x86)\Groupe ARCHISOFT\Zappiti Server
&$nssm install $ServiceName $ServicePath $ServiceArguments AppDirectory 'C:\Program Files (x86)\Groupe ARCHISOFT\Zappiti Server'
&nssm set $ServiceName Description Zappiti Video Server
Start-Sleep -Seconds .5
# check the status... should be stopped
&$nssm status $ServiceName
##Don't Start Yet##
Write-Host 'Please Set the service to run as an administrator account. This should be the same account you login to the Zappiti Server with so to keep your collections from breaking when lauching as a service vs in the session (during upgrades etc) Enter .\Username'
$credential = Get-Credential
Set-Service -Name "Zappiti Server" -Credential $credential
#start things up!
&$nssm start $ServiceName
# verify it's running
&$nssm status $ServiceName
