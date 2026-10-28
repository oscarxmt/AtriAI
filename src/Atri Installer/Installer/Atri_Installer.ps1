

Write-Host "[+] Starting Atri Installer..."

# Setting env variables for windows
$TEMP = $env:TEMP
$LocalAppData = $env:LOCALAPPDATA

Write-Host "[+] Finding the latest version of Atri..."

$LatestReleaseURI = "" # put the lastest release URI HERE LOL

Write-host "[+] Downloading the latest version of Atri..."

curl.exe $LatestReleaseURI --output "$TEMP\Atri_Installer.zip"

Write-Host "[+] Installing Atri..."

Move-Item -Path "$TEMP\Atri_Installer.zip" -Destination "$LocalAppData\Atri_Installer.zip" -Force
Expand-Archive -Path "$LocalAppData\Atri_Installer.zip" -DestinationPath "$LocalAppData\Atri_Installer" -Force

if (Test-Path "$LocalAppData\Atri_Installer" -PathType Container) {

    Write-Host "[+] Atri Installer has been successfully installed. On this machine, you can find it at $LocalAppData\Atri_Installer"

} 
else {
    Write-Host "[-] Atri Installer installation failed. QUITTING..."
    exit
}

Write-host "[+] Cleaning up temporary files..."
Remove-Item -Path "$TEMP\Atri_Installer.zip" -Force
Remove-Item -Path "$LocalAppData\Atri_Installer.zip" -Force

$Start_App_Prompt = Read-Host "[?] Do you want to run Atri (Y/N)"

$User_Formatted_Prompt = $Start_App_Prompt.ToLower()

if $User_Formatted_Prompt -eq "y" {
    Write-Host "[+] Starting Atri..."
    Start-Process -Filepath "$LocalAppData\Atri_Installer\" # give the main executable name here after the path
    exit
} 
else {
    Write-Host "[+] You can start Atri later by running the executable located at $LocalAppData\Atri_Installer\Atri.exe"
    Write-Host "[+] Exiting..."
    exit
}