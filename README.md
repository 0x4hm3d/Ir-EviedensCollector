# EDR-Live-Response
PowerShell Data Collection Script for use with Carbon Black Enterprise Response To use, simply configure the $dest and $tools variables to reflect appropriate paths.
his Powershell script is updated to follow the collection process modelled by Corey Harrell's	

##  [REQUIRED TOOLS]
		Rawcopy -- https://github.com/jschicht/RawCopy
		Handel -- https://download.sysinternals.com/files/Handle.zip
		Autorunsc -- Command line version of Autoruns - https://technet.microsoft.com/en-us/sysinternals/bb963902.aspx
		7-Zip -- Part of the 7-Zip archiver, 7za can be downloaded from here: http://www.7-zip.org/
		WinPmem -- MemoryImager https://github.com/Velocidex/WinPmem/releases/
		DumpIt -- MememoryImager https://github.com/thimbleweed/All-In-USB/tree/master/utilities/DumpIt

##  [VARIOUS ANALYSIS TOOLS]
		RegRipper -- Tool for extracting data from Registry and NTUSER.dat files. https://github.com/keydet89/RegRipper2.8
		WinPrefetchView -- utility to read Prefetch files. http://www.nirsoft.net/utils/win_prefetch_view.html
		MFTDump -- tool to dump the contents of the $MFT. http://malware-hunters.net/2012/09/
		Triforce ANJP -- tool to examining the MFT, LogFile, and USN. https://www.gettriforce.com/product/anjp-free/
		Volatility Memory Analysis https://github.com/volatilityfoundation/volatility
                                    "AND MANY DFIR TOOLS YOU CAN USE IT"

## CB Live Response - Best Automated Artifact Collection script/utility
        For Carbon Black Users just follow the instructions...
        Download the zip file from https://github.com/0x4hm3d/EDR-Live-Response.  Click on the Clone/Download button
        Create the Folders in " C:\IR " in a server dedicated for storage of IR artifacts
        Share out C:\IR as IR folder, grant only to admin
        Launch Live Response Console in CbR/CbD
        Execute all the following commands in Live Response Console
        
## Commands via CBLR
	- Alert the User 
		execfg msg * Security Team need to take over your machine to investigate an incident.  Please save your work.  You can reach us at xxx-xxxxxx, or email 			secops@cbdemo.com for details.
	- Display existing map drives
        	execfg net use 
	- Clear existing map drives to Z
        	execfg net use z: /delete
        	execfg net use z: \\XXX\IR /User:MACHINENAME\admin xxxxxx
	- Show new mapped drive
        	execfg net use
	- Change directory to c:\drive
        	cd c:\
	- Show directory listings
        	dir
	- Create temp folder in the C:/ drives
        	mkdir c:\temp
	- Upload ir-EviedensCollector.ps1 script from the workstation  and Folder of the TOOLS will be use to collect artifact with the same named
        	put c:\temp
	- Confirm that ir-EviedensCollector.ps1 and Tools is uploaded successfully
        	dir c:\temp
	- Set powershell execution policy to unrestricted
        	execfg powershell Set-Executionpolicy Unrestricted
	- Confirmed unrestricted is set
        	execfg powershell Get-Executionpolicy
	- Run the script and wait until collected artifacts finshed
        	execfg powershell c:\temp\extract_artifacts.ps1
	- Check the progress in the Z:\IR\ folder
