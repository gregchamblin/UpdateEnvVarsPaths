#Returns a WindowsIdentity object that represents the current Windows user.
$CurrentWindowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
#creating a new object of type WindowsPrincipal, and passing the Windows Identity to the constructor.
$CurrentWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($CurrentWindowsIdentity)
#Return True if specific user is Admin else return False
if ($CurrentWindowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) 
    {
        $pyver = 0
        do {
            $inputValid = [int]::TryParse((Read-Host 'Change to Python version (no Decimal)'), [ref]$pyver)
            if (-not $inputValid) {
                Write-Host "Your input was not an integer. Change to Python version (no Decimal)"
            }
        } while (-not $inputValid)
        
        # $pyver = Read-Host -Promt "Change to Python version (no Decimal)"
        $NewPy = "python" + $pyver

        #Get Current Path
        $Environment = [System.Environment]::GetEnvironmentVariable("Path","Machine")

        #Update Python Path
        $Environment = $Environment -replace "python\d{2,3}", $NewPy

        #Set Updated Path
        [System.Environment]::SetEnvironmentVariable("Path", $Environment, "Machine")

        wt -w 0 nt

        [Environment]::Exit(0)
    }
else 
    {
        Write-Host "ERROR: Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again." -ForegroundColor Red
    }

