## ----------------------------------------------------------------------------------------------------------------------------------------
##	Powershell Memory Capture Script for use with Carbon Black Enterprise Response
##
##  Version 1.0  Updated 1/12/2021
##
##  This Powershell script is designed as a separate memory only capture script.
##	
##	[REQUIRED TOOLS]
##  WinPmem -- MemoryImager https://github.com/Velocidex/WinPmem/releases/
##	Dumpit -- MemoryImager https://github.com/thimbleweed/All-In-USB/tree/master/utilities/DumpIt
##	Copyright 2021 !@hm3d Ahmed ElHabashi SOCL3 | IR | DFIR
##  TWITTER: @iahmedelhabashy 
##
## ----------------------------------------------------------------------------------------------------------------------------------------
echo "==============================================================================="
echo "==============================================================================="
Write-Host -Fore Red "
___  ___                                       _____             _                  
|  \/  |                                      /  __ \           | |                 
| .  . | ___ _ __ ___   ___  _ __ _   _ ______| /  \/ __ _ _ __ | |_ _   _ _ __ ___ 
| |\/| |/ _ \ '_ ` _ \ / _ \| '__| | | |______| |    / _` | '_ \| __| | | | '__/ _ \
| |  | |  __/ | | | | | (_) | |  | |_| |      | \__/\ (_| | |_) | |_| |_| | | |  __/
\_|  |_/\___|_| |_| |_|\___/|_|   \__, |       \____/\__,_| .__/ \__|\__,_|_|  \___|
                                   __/ |                  | |                       
                                  |___/                   |_|                       


!@hm3d Ahmed ElHabashi SOCL3 | IR | DFIR
TWITTER: @iahmedelhabashy
"		
## ----------------------------------------------------------------------------------------------------------------------------------------
## Set Target
## ----------------------------------------------------------------------------------------------------------------------------------------
		$target = $env:computername
		$targetName = Get-WMIObject Win32_ComputerSystem -ComputerName $target | Out-Null
		echo ""
		Write-Host -ForegroundColor Yellow "==[ $targetName - $target ]=="

## ----------------------------------------------------------------------------------------------------------------------------------------
## Configure Folder for memory collection - sets up folder based on computer's name and timestamp of artifact collection
## ----------------------------------------------------------------------------------------------------------------------------------------

	Write-Host -Fore Green "Configuring Folder"

		New-PSDrive -Name X -PSProvider filesystem -Root \\$target\c$ | Out-Null  

		$date = Get-Date -format yyyy-MM-dd_HHmm_
		$artFolder = $date + $target + "-Memory Image"
		
## ----------------------------------------------------------------------------------------------------------------------------------------		
## UPDATE THE FOLLOWING FOLDER TO CHANGE DESTINATION OF ARTIFACT DATA - POWERSHELL SUPPORTS NETWORK DRIVES
## ----------------------------------------------------------------------------------------------------------------------------------------
		
		$dest = "MemeoryArtifact"

## ----------------------------------------------------------------------------------------------------------------------------------------		
## LOCATION OF TOOLS - CAN BE USB OR NETWORK DRIVE 
## ----------------------------------------------------------------------------------------------------------------------------------------
		
		$tools = "C:\Windows\CarbonBlack\Tools\"

## ----------------------------------------------------------------------------------------------------------------------------------------

		$CompName = $target
		
		$OutLevel1 = "$dest\$CompName-$Date.html"

## ----------------------------------------------------------------------------------------------------------------------------------------
## Create Artifact Directories
## ----------------------------------------------------------------------------------------------------------------------------------------
	Write-Host -Fore Green "Creating Image Directory"
	$dirList = ("$dest\MemoryImage")
	New-Item -Path $dest -ItemType Directory
	New-Item -Path $dirList -ItemType Directory | Out-Null

## ----------------------------------------------------------------------------------------------------------------------------------------
## HTML File setup 
## ----------------------------------------------------------------------------------------------------------------------------------------
## HTML Logfile Header
## ----------------------------------------------------------------------------------------------------------------------------------------
	
	ConvertTo-Html -Head $head -Title "Memory Capture script for $CompName" -Body " Memory Capture Script <p> Computer Name : $CompName &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp </p> " > $OutLevel1

## ----------------------------------------------------------------------------------------------------------------------------------------	
# Record start time of collection
## ----------------------------------------------------------------------------------------------------------------------------------------

	date | select DateTime | ConvertTo-html -Body "Current Date and Time " >> $OutLevel1


## ---------------------------------------------------------------------------------------------------------------------------------------- 
## Gather Memory from Target System - Can use other memory capture tools
## ----------------------------------------------------------------------------------------------------------------------------------------

	Write-Host -Fore Green "Capturing memory"
	
	date | select DateTime | ConvertTo-html -Body "<H2> Ram Image Started </H2>" >> $OutLevel1
		$command = '$tools\winpmem.exe $dest\MemoryImage\$CompName.bin'
		#$command = '$tools\dumpit.exe'
		iex "& $command"
	
	 date | select DateTime | ConvertTo-html -Body "<H2> Ram Image Complete </H2>" >> $OutLevel1
## ---------------------------------------------------------------------------------------------------------------------------------------- 
## Compresed Memory Image with 7z
## ----------------------------------------------------------------------------------------------------------------------------------------
   Write-Host -Fore Green "Compresed Memory Image"  

     $command = '$tools\7z.exe a -tzip $dest C:\Windows\CarbonBlack\Tools\MemeoryArtifact\'
     #$command = 'C:\Windows\CarbonBlack\Tools>\7z.exe a -tzip C:\Windows\CarbonBlack\Tools\Memdump.zip C:\Windows\CarbonBlack\Tools\Artifacts\MemoryImage'
     iex "& $command"

	Write-Host -Fore Green "Done"
