# EDR-Live-Response
PowerShell Data Collection Script for use with Carbon Black Enterprise Response
To use, simply configure the $dest and $tools variables to reflect appropriate paths.
##  Version 1.0  
##
##  This Powershell script is updated to follow the collection process modelled by Corey Harrell's
##  TR3Secure Data Collection Script: http://journeyintoir.blogspot.com/2013/09/tr3secure-data-collection-script.html and https://code.google.com/p/jiir-resources/downloads/list
##  References 
##	Malware Forensics: Investigating and Analyzing Malicious Code by Cameron H. Malin, Eoghan Casey, and James M. Aquilina 
## 	Windows Forensics Analysis (WFA) Second Edition by Harlan Carvey
## 	RFC 3227 - Guidelines for Evidence Collection and Archiving http://www.faqs.org/rfcs/rfc3227.html
##	Dual Purpose Volatile Data Collection Script http://journeyintoir.blogspot.com/2012/01/dual-purpose-volatile-data-collection.html
##	Corey Harrell (Journey Into Incident Response)
##  [REQUIRED TOOLS]
##		Rawcopy -- https://github.com/jschicht/RawCopy
##		Handel -- https://download.sysinternals.com/files/Handle.zip
##		Autorunsc -- Command line version of Autoruns - https://technet.microsoft.com/en-us/sysinternals/bb963902.aspx
##		7-Zip -- Part of the 7-Zip archiver, 7za can be downloaded from here: http://www.7-zip.org/
##		WinPmem -- MemoryImager https://github.com/Velocidex/WinPmem/releases/
##		DumpIt -- MememoryImager https://github.com/thimbleweed/All-In-USB/tree/master/utilities/DumpIt
##	[VARIOUS ANALYSIS TOOLS]
##		RegRipper -- Tool for extracting data from Registry and NTUSER.dat files. https://github.com/keydet89/RegRipper2.8
##		WinPrefetchView -- utility to read Prefetch files. http://www.nirsoft.net/utils/win_prefetch_view.html
##		MFTDump -- tool to dump the contents of the $MFT. http://malware-hunters.net/2012/09/
##		Triforce ANJP -- tool to examining the MFT, LogFile, and USN. https://www.gettriforce.com/product/anjp-free/
##		Volatility Memory Analysis https://github.com/volatilityfoundation/volatility
##
## 					                          "AND MANY DFIR TOOLS YOU CAN USE IT"
##
##		Other contributors are mentioned in the code where applicable
  
                                                                                                         

 /$$                   /$$$$$$$$         /$$                 /$$                                /$$$$$$            /$$ /$$                       /$$                        
|__/                  | $$_____/        |__/                | $$                               /$$__  $$          | $$| $$                      | $$                        
 /$$  /$$$$$$         | $$    /$$    /$$ /$$  /$$$$$$   /$$$$$$$  /$$$$$$  /$$$$$$$   /$$$$$$$| $$  \__/  /$$$$$$ | $$| $$  /$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$   /$$$$$$ 
| $$ /$$__  $$ /$$$$$$| $$$$$|  $$  /$$/| $$ /$$__  $$ /$$__  $$ /$$__  $$| $$__  $$ /$$_____/| $$       /$$__  $$| $$| $$ /$$__  $$ /$$_____/|_  $$_/   /$$__  $$ /$$__  $$
| $$| $$  \__/|______/| $$__/ \  $$/$$/ | $$| $$$$$$$$| $$  | $$| $$$$$$$$| $$  \ $$|  $$$$$$ | $$      | $$  \ $$| $$| $$| $$$$$$$$| $$        | $$    | $$  \ $$| $$  \__/
| $$| $$              | $$     \  $$$/  | $$| $$_____/| $$  | $$| $$_____/| $$  | $$ \____  $$| $$    $$| $$  | $$| $$| $$| $$_____/| $$        | $$ /$$| $$  | $$| $$      
| $$| $$              | $$$$$$$$\  $/   | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$  | $$ /$$$$$$$/|  $$$$$$/|  $$$$$$/| $$| $$|  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$/| $$      
|__/|__/              |________/ \_/    |__/ \_______/ \_______/ \_______/|__/  |__/|_______/  \______/  \______/ |__/|__/ \_______/ \_______/   \___/   \______/ |__/      
                                                                                                                                                                            
                                                                                                                                                                            
                                                                                                                                                                            
