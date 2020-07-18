#teams new module is on posh 
#Register-PackageSource -Name PoshTestGallery -Location https://www.poshtestgallery.com/api/v2/ -ProviderName PowerShellGet
#Install-Module -Name MicrosoftTeams -RequiredVersion 1.0.24

Function ModulesCheck {
    Write-Host "Checking for Modules..." -ForegroundColor Yellow
    $Modules = get-installedmodule
    $ImportedModules = get-module

    #AZ
    If ($Modules.Name.Contains("Az")) {
        $Index = $Modules.Name.IndexOf("Az")
        Write-Host "Az (Azure) Module found - Version"$Modules.Version[$index] -ForegroundColor Cyan
    }
    If (!$Modules.Name.Contains("Az")) {
        Write-Host "Az (Azure) Module not found, if required Install with" -ForegroundColor Red
        Write-Host "Add-Module `"Az`""
    }
    #AzureAD
    If ($Modules.Name.Contains("AzureAD")) {
        $Index = $Modules.Name.IndexOf("AzureAD")
        Write-Host "AzureAD Module found - Version"$Modules.Version[$index] -ForegroundColor Cyan
    }
    If (!$Modules.Name.Contains("AzureAD")) {
        Write-Host "AzureAD Module not found, if required Install with:" -ForegroundColor Red
        Write-Host "Add-Module `"AzureAD`""
        If ($Modules.Name.Contains("AzureADPreview")) {
            $Index = $Modules.Name.IndexOf("AzureADPreview")
            Write-Host "AzureAD PREVIEW Module found - Version"$Modules.Version[$index] -ForegroundColor Cyan
        }

    }
    #MSOL
    If ($Modules.Name.Contains("MSOnline")) {
        $Index = $Modules.Name.IndexOf("MSOnline")
        Write-Host "MSOL Module found - Version"$Modules.Version[$index] -ForegroundColor Cyan
    }
    If (!$Modules.Name.Contains("MSOnline")) {
        Write-Host "MSOL Module not found, if required Install with:" -ForegroundColor Red
        Write-Host "Add-Module `"MSOnline`""
    }
    #Exchange V2
    If ($Modules.Name.Contains("ExchangeOnlineManagement")) {
        $Index = $Modules.Name.IndexOf("ExchangeOnlineManagement")
        Write-Host "Exchange V2 Module found - Version"$Modules.Version[$index] -ForegroundColor Cyan
    }
    If (!$Modules.Name.Contains("ExchangeOnlineManagement")) {
        Write-Host "Exchange V2 Module not found, if required Install with:" -ForegroundColor Red
        Write-Host "Add-Module `"ExchangeOnlineManagement`""
    }
    #Teams
    If ($Modules.Name.Contains("MicrosoftTeams")) {
        $Index = $Modules.Name.IndexOf("MicrosoftTeams")
        Write-Host "Teams Module found - Version"$Modules.Version[$index] -ForegroundColor Cyan
    }
    If (!$Modules.Name.Contains("MicrosoftTeams")) {
        Write-Host "Teams Module not found, if required Install with:" -ForegroundColor Red
        Write-Host "Add-Module `"MicrosoftTeams`""
    }
    #Skype
    If ($ImportedModules.Name.Contains("SkypeOnlineConnector")) {
        $Index = $ImportedModules.Name.IndexOf("SkypeOnlineConnector")
        Write-Host "Skype Module found - Version"$ImportedModules.Version[$index] -ForegroundColor Cyan
    }
    If (!$ImportedModules.Name.Contains("SkypeOnlineConnector")) {
        Write-Host "SkypeOnlineConnector Module not found." -ForegroundColor Red
        Write-Host "Some Teams functionality is still controlled via the skype module" -ForegroundColor Gray
        Write-Host "It is old and shit so needs to be installed from:" -ForegroundColor Gray
        Write-Host "https://www.microsoft.com/en-us/download/details.aspx?id=39366" -ForegroundColor White
        Write-Host "Then imported with:" -ForegroundColor Gray -NoNewline
        Write-Host "Import-Module SkypeOnlineConnector" -foregroundcolor White
    }
    Write-Host "----------------------" -ForegroundColor Cyan

}

Function Update-AllModules {
    write-host "Requires Admin - escalating session" -ForegroundColor Yellow
    powershell -Command "Start-Process powershell -ArgumentList '-Command Get-InstalledModule | Update-Module' -Verb RunAs"
    write-host "Restart Powershell environment when done. This can take a while"
}

Function Add-Module($modulename) {
    write-host "Trying Install for" $modulename
    write-host "Requires Admin - escalating session" -ForegroundColor Yellow
    powershell -Command "Start-Process powershell -ArgumentList '-Command Install-Module $modulename' -Verb RunAs -Wait"
    ModulesCheck
}

Function ProfileNotes {
    Write-Host "Notes" -ForegroundColor Yellow
    Write-Host "To Update all Modules run " -ForegroundColor gray -NoNewline
    write-host "Update-AllModules" -foregroundcolor Magenta
    Write-Host "EXO V2 uses Connect-ExchangeOnline and the Get-EXO styleprefix" -ForegroundColor Gray
    Write-Host "----------------------" -ForegroundColor Cyan
}

Write-Host "Running Profile..." -foregroundcolor Yellow
Write-Host "----------------------" -ForegroundColor Cyan

ModulesCheck
ProfileNotes
