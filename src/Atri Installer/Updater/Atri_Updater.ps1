Write-host "[+] Preparing Atri Updater..."

$LatestReleaseURI = "" # put the lastest release URI HERE LOL
$TEMP = $env:TEMP
$Arti_Installer_Path = "$env:LOCALAPPDATA\Atri_Installer"


if (Test-Path $Arti_Installer_Path -PathType Container -eq "false") {
    Write-Host "[-] Could not find Atri path.... QUITTING..."
    exit
}

$Start_App_Prompt = Read-Host "[?] Do you want to update Atri (Y/N) "
$User_Formatted_Prompt = $Start_App_Prompt.ToLower()

if $User_Formatted_Prompt -eq "n" {
    Write-Host "[+] QUITTING..."
    exit
}

Write-Host "[+] Removing old Atri app..."
Remove-Item -Path $Arti_Installer_Path -Recurse -Force


curl.exe $LatestReleaseURI --output "$TEMP\Atri_Installer.zip"
Move-Item -Path "$TEMP\Atri_Installer.zip" -Destination "$Arti_Installer_Path\Atri_Installer.zip" -Force
Expand-Archive -Path "$Arti_Installer_Path\Atri_Installer.zip" -DestinationPath "$Arti_Installer_Path" -Force

Read-Host ""

if (Test-Path $Arti_Installer_Path -PathType Container -eq "false") {
    Write-Host "[-] Atri update could not be finished. QUITTING..."
    exit
}

Write-Host "[+] Atri has been successfully updated."