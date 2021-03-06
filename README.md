#   IR Forensic Eviedens Collector
    Ir-EviedensCollector is a PowerShell script utilized to pull several forensic artifacts from a live Windows 8, 10, Server 2012R2, 
    and Server 2019 systems on your network, Remotrly or by EDR. simply configure the $dest and $tools variables to reflect appropriate paths
#   Artifacts it grabs:
	  - Disk Information
	  - System Information
	  - User Information
	  - Network Configuration
	  - Netstat info
	  - Route Table, ARP Table, DNS Cache, HOSTS file
	  - Running Processes
	  - Services
	  - Event Logs (System, Security, Application, etc)
	  - Prefetch Files
	  - $MFT
	  - NTFS $LogFile
	  - Amcache.hve
	  - Registry Files
	  - User NTUSER.dat files
	  - Internet History Files (IE, Firefox, Chrome, Edge from user profiles used within last 15 days)
	   When done collecting the artifacts, it will 7zip the data and grep the info off the box for off-line analysis.

#   [NOTE]: 
    As expected: Must be ran a user that will have Admin creds on the remote system. The assumption is that the target system is part of a domain.

##  REQUIRED TOOLS
	  - Rawcopy -- https://github.com/jschicht/RawCopy
	  - Handel -- https://download.sysinternals.com/files/Handle.zip
	  - Autorunsc -- Command line version of Autoruns - https://technet.microsoft.com/en-us/sysinternals/bb963902.aspx
	  - 7-Zip -- Part of the 7-Zip archiver, 7za can be downloaded from here: http://www.7-zip.org/
	  - WinPmem -- MemoryImager https://github.com/Velocidex/WinPmem/releases/
	  - DumpIt -- MememoryImager https://github.com/thimbleweed/All-In-USB/tree/master/utilities/DumpIt

##  VARIOUS ANALYSIS TOOLS
	  1- RegRipper -- Tool for extracting data from Registry and NTUSER.dat files. https://github.com/keydet89/RegRipper2.8
	  2- WinPrefetchView -- utility to read Prefetch files. http://www.nirsoft.net/utils/win_prefetch_view.html
	  3- MFTDump -- tool to dump the contents of the $MFT. http://malware-hunters.net/2012/09/
	  4- PECmd - utility to parse Prefetch files. http://binaryforay.blogspot.com/2016/01/pecmd-v0600-released.htm
	  5- Triforce ANJP -- tool to examining the MFT, LogFile, and USN. https://www.gettriforce.com/product/anjp-free/
	  6- Volatility Memory Analysis https://github.com/volatilityfoundation/volatility
                                    "AND MANY DFIR TOOLS YOU CAN USE IT"

## CB Live Response - Best Automated Artifact Collection script/utility
    For Carbon Black Users just follow the instructions...
    Download the zip file from https://github.com/0x4hm3d/Ir-EviedensCollector.  Click on the Clone/Download button
    Create the Folders in " C:\IR " in a server dedicated for storage of IR artifacts
    Share out C:\IR as IR folder, grant only to admin
    Launch Live Response Console in CbR/CbD
    Execute all the following commands in Live Response Console
        
## Commands via CBLR
	- Alert the User 
		execfg msg * Security Team need to take over your machine to investigate an incident.  Please save your work.  
		You can reach us at xxx-xxxxxx, or email xxxx@cbdemo.com for details.
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
        	execfg powershell c:\temp\Ir-EviedensCollector.ps1
	- Check the progress in the Z:\IR\ folder
