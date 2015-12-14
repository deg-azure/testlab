#$cred = Get-Credential
#Add-AzureAccount -Credential $cred

#Import-AzurePublishSettingsFile path
#$aaa = Add-AzureAccount
#Create VM based on available Image
#List available Images
#Get-AzureVMImage | where-object { $_.Category -eq "User" } | Select ImageName, Label, CreatedTime, DataDiskConfigurations

#Clear-Host
Write-Host "`nCreate new, clean, empty, fresh & beautiful VM in Azure`n"

Write-Host "Operating system:`n1 - Windows 10 (MS Office 2013)`n2 - Windows 8.1 (MS Office 2013)`n3 - Windows 7 (MS Office 2010)`n`n99: Standalone environments`n`n0 - Main menu`n`nIn order to exit the tool press Ctrl+C (STRG+C)`n"
do {
    try {
        $numOk = $true
	[int]$OSName = Read-Host "Make your choice"
    If (($OSName -ne 0 -and $OSName -ne 1 -and $OSName -ne 2 -and $OSName -ne 3) -and $OSName -ne 99) {Write-Host "Invalid value" }
        } # end try
    catch {
    $numOK = $false
    Write-Host "Invalid value"
     }
    } # end do 
until (($OSName -eq 0 -or $OSName -eq 1 -or $OSName -eq 2 -or $OSName -eq 3 -or $OSName -eq 99) -and $numOK)
Write-Host "---------------------------------------------------------------------`n"
$ConfigurationFile_System = ""

switch ($OSName) 
    { 
        1 {
	$ImageName= "DeG-Win10-Image"
        $VMName = "W10"
        $ConfigurationFile_System = "windows10.ps1"
        } 
        2 {
	#$ImageName= "DeG-Win81-Image"
	$ImageName= "deg-win81-image-20150730"
        $VMName = "W81"
        $ConfigurationFile_System = "windows8.ps1"
        } 
        3 {
	$ImageName= "DeG-Win7-Image-v2"
        $VMName = "W7"
        $ConfigurationFile_System = "windows7.ps1"
        } 
        0 {
        . .\MainScript.ps1
        } 
        99 { Clear-Host; Show-StdMenu; } 
	default {
	$ImageName= "DeG-Win81-Image"
        $VMName = "W81"
        $ConfigurationFile_System = "windows8.ps1"
        }
    }

Write-Host "Language of operating system:`n1 - English (Great Britain)`n2 - English (USA)`n3 - German`n4 - Spanish`n5 - Portuguese`n6 - Brazilian`n7 - Polish`n8 - Czech`n9 - Slovak`n10 - Hungarian`n11 - Italian`n`n99: Standalone environments`n`n0 - Main menu`n`nIn order to exit the tool press Ctrl+C (STRG+C)`n"
do {
    try {
        $numOk = $true
	[int]$OSLanguage = Read-Host "Make your choice"
    If (($OSLanguage -lt 0 -or $OSLanguage -gt 11) -and $OSLanguage -ne 99) {Write-Host "Invalid value" }
        } # end try
    catch {
    $numOK = $false
    Write-Host "Invalid value"
     }
    } # end do 
until (($OSLanguage -ge 0 -and $OSLanguage -lt 12 -or $OSLanguage -eq 99) -and $numOK)
Write-Host "---------------------------------------------------------------------`n"
$ConfigurationFile_Language1 = "RegSet_ENU.ps1"
$ConfigurationFile_Language2 = "RegSet_ENU.cmd"

switch ($OSLanguage) 
    { 
        1 {$VMName= $VMName + "ENG-"
        $ConfigurationFile_Language1 = "RegSet_ENG.ps1"
        $ConfigurationFile_Language2 = "RegSet_ENG.xml"
} 
        2 {$VMName= $VMName + "ENU-"
        $ConfigurationFile_Language1 = "RegSet_ENU.ps1"
        $ConfigurationFile_Language2 = "RegSet_ENU.xml"
} 
        3 {$VMName= $VMName + "DEU-"
        $ConfigurationFile_Language1 = "RegSet_DEU.ps1"
        $ConfigurationFile_Language2 = "RegSet_DEU.xml"
} 
        4 {$VMName= $VMName + "ESP-"
        $ConfigurationFile_Language1 = "RegSet_ESP.ps1"
        $ConfigurationFile_Language2 = "RegSet_ESP.xml"
} 
        5 {$VMName= $VMName + "PTG-"
        $ConfigurationFile_Language1 = "RegSet_PTG.ps1"
        $ConfigurationFile_Language2 = "RegSet_PTG.xml"
} 
        6 {$VMName= $VMName + "PTB-"
        $ConfigurationFile_Language1 = "RegSet_PTB.ps1"
        $ConfigurationFile_Language2 = "RegSet_PTB.xml"
} 
        7 {$VMName= $VMName + "PLK-"
        $ConfigurationFile_Language1 = "RegSet_PLK.ps1"
        $ConfigurationFile_Language2 = "RegSet_PLK.xml"
} 
        8 {$VMName= $VMName + "CSY-"
        $ConfigurationFile_Language1 = "RegSet_CSY.ps1"
        $ConfigurationFile_Language2 = "RegSet_CSY.xml"
} 
        9 {$VMName= $VMName + "SKY-"
        $ConfigurationFile_Language1 = "RegSet_SKY.ps1"
        $ConfigurationFile_Language2 = "RegSet_SKY.xml"
} 
        10 {$VMName= $VMName + "HUN-"
        $ConfigurationFile_Language1 = "RegSet_HUN.ps1"
        $ConfigurationFile_Language2 = "RegSet_HUN.xml"
} 
        11 {$VMName= $VMName + "ITA-"
        $ConfigurationFile_Language1 = "RegSet_ITA.ps1"
        $ConfigurationFile_Language2 = "RegSet_ITA.xml"
} 
        0 {
        . .\MainScript.ps1
        } 
        99 { Clear-Host; Show-StdMenu; } 
        default {$VMName= $VMName + "ENG-"
        $ConfigurationFile_Language1 = "RegSet_ENG.ps1"
        $ConfigurationFile_Language2 = "RegSet_ENG.xml"
}
    }
    
Write-Host "---------------------------------------------------------------------"
Write-Host ""

$VMName= $VMName + (Get-Date -UFormat "%m%d%H%M")

	#schedule stoppping the machine
	 Write-Host "Schedule stopping the VM:`n1 - 17:00`n2 - 18:00`n3 - 19:00`n4 - 20:00`n5 - 21:00`n6 - 22:00`n"
    	do {
        try {
            $numOk = $true
	    [int]$ArbZeit = Read-Host "Make your choice"
        If ($ArbZeit -lt 1 -or $ArbZeit -gt 6) {Write-Host "Invalid value" }
            } # end try
        catch {
        $numOK = $false
        Write-Host "Invalid value"
         }
        } # end do 
	until (($ArbZeit -ge 1 -and $ArbZeit -le 6) -and $numOK)

	 switch ($ArbZeit)     	{ 
        1 {             $StopTime = Get-Date "17:00"  } 
        2 {             $StopTime = Get-Date "18:00"  } 
        3 {             $StopTime = Get-Date "19:00"  } 
        4 {             $StopTime = Get-Date "20:00"  } 
        5 {             $StopTime = Get-Date "21:00"  } 
        6 {             $StopTime = Get-Date "22:00"  } 
	default { }
	}

    Write-Host "---------------------------------------------------------------------"
    Write-Host ""

Write-Host "`nCreating VM:" $VMName"..."

$adminPassword = "Sokrates123"
$vm1 = New-AzureVMConfig -Name $VMName -InstanceSize "Large" -Image $ImageName | Add-AzureEndpoint -LocalPort 3389 -Name 'RDP' -Protocol tcp | Add-AzureEndpoint -LocalPort 5986 -Name 'PowerShell' -Protocol tcp -PublicPort 5986 | Add-AzureProvisioningConfig -Windows -AdminUserName "Installer" -Password $adminPassword -DisableAutomaticUpdates | New-AzureVM -ServiceName $VMName -ServiceDescription ("DeG.Test " + $VMName + " " + $global:CurrentUser) -ServiceLabel $VMName -Location "West Europe" –WaitForBoot

if ($vm1.OperationStatus -eq "Succeeded") {
    Write-Host "VM has been successfully created.`n"
	   $dir = New-Item -ItemType Directory -Force -Path ("$([Environment]::GetFolderPath("Desktop"))\$($global:CurrentUser)")
            Write-Host "Creating RDP-File..."
            $rdpfile = Get-AzureRemoteDesktopFile -ServiceName $VMName -Name $VMName -LocalPath "$([Environment]::GetFolderPath("Desktop"))\$($global:CurrentUser)\$($VMName).rdp"
            if ($rdpfile.OperationStatus -eq "Succeeded") { 
                Write-Host "RDP-File has been successfully created. The file $($VMName).rdp has been saved on your desktop.`n" 
            }
            Else { Write-Host "Problem appeared during creation of RDP-for the VM.`n"  }
		
            Write-Host "Creating script for stopping the VM..."
	    $stopItem = New-Item ("$([Environment]::GetFolderPath("Desktop"))\$($global:CurrentUser)\Stop_$($VMName).cmd") -type file -force -value ("powershell $toolpath\Stop_VM.ps1 $($VMName)")
            Write-Host "Creating script for starting the VM..."
	    $startItem = New-Item ("$([Environment]::GetFolderPath("Desktop"))\$($global:CurrentUser)\Start_$($VMName).cmd") -type file -force -value ("powershell $toolpath\Start_VM.ps1 $($VMName)")

    #Create Automation-Runbook
    Write-Host "Creating automation schedule for stopping the VM $($VMName)..."
    
    $CurrentTime = Get-Date
    While ($CurrentTime -gt $StopTime) { $StopTime = $StopTime.AddDays(1) }

    $automationAccountName = "DeG-Automation2"

    $runbookNameStop = "Stop-VM"
    $scheduleNameStop = "Stop $($VMName)"

    $params = @{"VMName"="$($VMName)";"ServiceName"="$($VMName)"}
    $aasStop = New-AzureAutomationSchedule -AutomationAccountName $automationAccountName -Name $scheduleNameStop -StartTime $StopTime -DayInterval 1
    $aasrStop = Register-AzureAutomationScheduledRunbook –AutomationAccountName $automationAccountName –Name $runbookNameStop –ScheduleName $scheduleNameStop –Parameters $params

    #Write-Host "Automation task schedules for VM $($VMName) has been successfully created."

    Write-Host "`nStarting VM: $($VMName)..."
    $FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 5000
            }
        #$Cloudservice = Get-AzureService | where {$_.Label -eq $VMName}
        $vmx = Get-AzureVM -ServiceName $VMName -Name $VMName
    }
    Until ($vmx.Status -eq "ReadyRole" -and $vmx.InstanceStatus -eq "ReadyRole" -and $vmx.OperationStatus -eq "OK" -and $vmx.PowerState -eq "Started")

Write-Host "1InstanceStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).InstanceStatus
Write-Host "PowerState: " (Get-AzureVM -Name $VMName -ServiceName $VMName).PowerState
Write-Host "Status: " (Get-AzureVM -Name $VMName -ServiceName $VMName).Status
Write-Host "GuestAgentStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).GuestAgentStatus
Write-Host "OperationStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).OperationStatus

#Start-Sleep -Milliseconds 10000

Write-Host "2InstanceStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).InstanceStatus
Write-Host "PowerState: " (Get-AzureVM -Name $VMName -ServiceName $VMName).PowerState
Write-Host "Status: " (Get-AzureVM -Name $VMName -ServiceName $VMName).Status
Write-Host "GuestAgentStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).GuestAgentStatus
Write-Host "OperationStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).OperationStatus


    Write-Host "VM: $($VMName) has been started.`n"

    Write-Host "Invoking configuration scripts..."
    $ScriptStatus = Get-AzureVM -Name $VMName -ServiceName $VMName | Set-AzureVMCustomScriptExtension -StorageAccountName "degshare" -ContainerName "scripts" -FileName "EnableDisableUserAccounts.ps1", "netZ.cmd", "main.ps1", $ConfigurationFile_System, $ConfigurationFile_Language1, $ConfigurationFile_Language2, "launcher.cmd", "teamviewer.cmd", "PDFAssociate.cmd", "PDFAssociate.reg" -Run "main.ps1" | Update-AzureVM

 $FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 5000
            }
        #$Cloudservice = Get-AzureService | where {$_.Label -eq $VMName}
        $vmx = Get-AzureVM -ServiceName $VMName -Name $VMName
    }
    Until ($vmx.Status -eq "ReadyRole" -and $vmx.InstanceStatus -eq "ReadyRole" -and $vmx.OperationStatus -eq "OK" -and $vmx.PowerState -eq "Started")

Write-Host "3InstanceStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).InstanceStatus
Write-Host "PowerState: " (Get-AzureVM -Name $VMName -ServiceName $VMName).PowerState
Write-Host "Status: " (Get-AzureVM -Name $VMName -ServiceName $VMName).Status
Write-Host "GuestAgentStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).GuestAgentStatus
Write-Host "OperationStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).OperationStatus

$vmx = Get-AzureVM -ServiceName $VMName -Name $VMName | Update-AzureVM
#Start-Sleep -Milliseconds 10000

 $FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 5000
            }
        #$Cloudservice = Get-AzureService | where {$_.Label -eq $VMName}
        $vmx = Get-AzureVM -ServiceName $VMName -Name $VMName
    }
    Until ($vmx.Status -eq "ReadyRole" -and $vmx.InstanceStatus -eq "ReadyRole" -and $vmx.OperationStatus -eq "OK" -and $vmx.PowerState -eq "Started")

Write-Host "4InstanceStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).InstanceStatus
Write-Host "PowerState: " (Get-AzureVM -Name $VMName -ServiceName $VMName).PowerState
Write-Host "Status: " (Get-AzureVM -Name $VMName -ServiceName $VMName).Status
Write-Host "GuestAgentStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).GuestAgentStatus
Write-Host "OperationStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).OperationStatus

$ScriptStatus = Get-AzureVM -Name $VMName -ServiceName $VMName | Set-AzureVMCustomScriptExtension -StorageAccountName "degshare" -ContainerName "scripts" -FileName "EnableDisableUserAccounts.ps1", "netZ.cmd", "main.ps1", $ConfigurationFile_System, $ConfigurationFile_Language1, $ConfigurationFile_Language2, "launcher.cmd", "teamviewer.cmd", "PDFAssociate.cmd", "PDFAssociate.reg" -Run "main.ps1" | Update-AzureVM

 $FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 5000
            }
        #$Cloudservice = Get-AzureService | where {$_.Label -eq $VMName}
        $vmx = Get-AzureVM -ServiceName $VMName -Name $VMName
    }
    Until ($vmx.Status -eq "ReadyRole" -and $vmx.InstanceStatus -eq "ReadyRole" -and $vmx.OperationStatus -eq "OK" -and $vmx.PowerState -eq "Started")

    if ($ScriptStatus.OperationStatus -eq "Succeeded") { Write-Host "Configuration scripts (part 1) executed.`n" }
    else { Write-Host "An error appeared (Schwerer Fehler) during an execution of configuration scripts.`n" }

    Write-Host "Importing access certificates...`n"
    . .\GetVMCert.ps1 $VMName $VMName
   If ($OSName -eq 1 -or $OSName -eq 2) {    Start-Sleep -Milliseconds 15000  } Else {    Start-Sleep -Milliseconds 10000  }

Write-Host "5InstanceStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).InstanceStatus
Write-Host "PowerState: " (Get-AzureVM -Name $VMName -ServiceName $VMName).PowerState
Write-Host "Status: " (Get-AzureVM -Name $VMName -ServiceName $VMName).Status
Write-Host "GuestAgentStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).GuestAgentStatus
Write-Host "OperationStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).OperationStatus

 $FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 5000
            }
        #$Cloudservice = Get-AzureService | where {$_.Label -eq $VMName}
        $vmx = Get-AzureVM -ServiceName $VMName -Name $VMName
    }
    Until ($vmx.Status -eq "ReadyRole" -and $vmx.InstanceStatus -eq "ReadyRole" -and $vmx.OperationStatus -eq "OK" -and $vmx.PowerState -eq "Started")

    Write-Host "Remote execution of additional scripts (part 2)...`n"
    If ($OSName -eq 1 -or $OSName -eq 2) {    $userName = "TEST-PC\Installer" } Else {    $userName = "Installer" }
	#$adminPassword = "Sokrates123"
	#Declare credentials to connect
	$securePWD = ConvertTo-SecureString $adminPassword -AsPlainText -Force
	$credential = New-Object System.Management.Automation.PSCredential($userName, $securePWD)
	#$session = Enter-PSSession -ConnectionUri $uri -Credential $credential
    If ($OSName -eq 1 -or $OSName -eq 2) {    Start-Sleep -Milliseconds 20000  } Else {    Start-Sleep -Milliseconds 10000  }

$FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 5000
            }
        #$Cloudservice = Get-AzureService | where {$_.Label -eq $VMName}
        $vmx = Get-AzureVM -ServiceName $VMName -Name $VMName
    }
    Until ($vmx.Status -eq "ReadyRole" -and $vmx.InstanceStatus -eq "ReadyRole" -and $vmx.OperationStatus -eq "OK" -and $vmx.PowerState -eq "Started")

    $FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 5000
            }
	$securePWD = ConvertTo-SecureString $adminPassword -AsPlainText -Force
	$credential = New-Object System.Management.Automation.PSCredential($userName, $securePWD)
    	$uri = Get-AzureWinRMUri -ServiceName $VMName -Name $VMName
        $session = New-PSSession -ConnectionUri $uri -Credential $credential

	Write-Host "InstanceStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).InstanceStatus
	Write-Host "PowerState: " (Get-AzureVM -Name $VMName -ServiceName $VMName).PowerState
	Write-Host "Status: " (Get-AzureVM -Name $VMName -ServiceName $VMName).Status
	Write-Host "GuestAgentStatus: " ((Get-AzureVM -Name $VMName -ServiceName $VMName).GuestAgentStatus).Status
	Write-Host "OperationStatus: " (Get-AzureVM -Name $VMName -ServiceName $VMName).OperationStatus

        Write-Host "Waiting for VM to restart..."
	Start-Sleep -Milliseconds 10000
	Write-Host ""
    }
    Until ($session.State -eq "Opened")

    Invoke-Command -Session $session -ScriptBlock { 
    while (!(Test-Path "C:\Scripts\launcher.cmd")) { Start-Sleep 10 }
    Start-Process "C:\Scripts\launcher.cmd" -Wait
    }
    Start-Sleep -Milliseconds 5000   

    Write-Host "`nVM: $($VMName) booting..."
    $FirstLoop = $true
    Do
    {
        if (!$FirstLoop)
            {
                Start-Sleep -Milliseconds 500
            }
        #$vmx = Get-AzureVM -ServiceName $VMName -Name $VMName
    }
    Until ((Get-AzureVM -ServiceName $VMName -Name $VMName).Status -eq "ReadyRole")

    Write-Host "`nVM: $($VMName) ready."

    Write-Host "All operations completed!`n"
    Read-Host -Prompt "Press Enter to go back to VM list"
    . .\MainScript.ps1
}
else
{
    Write-Host "During creation of VM: $($VMName) an error appeared (Schwerer Fehler).`n"
    Read-Host -Prompt "Press Enter to go back Main menu"
    . .\MainScript.ps1
}