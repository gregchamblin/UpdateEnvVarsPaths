#Returns a WindowsIdentity object that represents the current Windows user.
$CurrentWindowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
#creating a new object of type WindowsPrincipal, and passing the Windows Identity to the constructor.
$CurrentWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($CurrentWindowsIdentity)
#Return True if specific user is Admin else return False
if ($CurrentWindowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) 
    {
        $pyver = Read-Host -Promt "Change to Python version (no Decimal)"
        $NewPy = "python" + $pyver

        #Get Current Path
        $Environment = [System.Environment]::GetEnvironmentVariable("Path","Machine")

        if ("C:\Program Files\python38" -in $Environment.Split(";"))
            {
                $Environment = $Environment -replace "python38", $NewPy
            }
        elseif ("C:\Program Files\python39" -in $Environment.Split(";"))
            {
                $Environment = $Environment -replace "python39", $NewPy
            }
        elseif ("C:\Program Files\python310" -in $Environment.Split(";"))
            {
                $Environment = $Environment -replace "python310", $NewPy
            }

        $Environment = $Environment -replace ";;", ";"
        $Environment = $Environment -replace ";;", ";"

        #Add Items to Environment
        # $AddPathItems = ";" + $NewPyPath + ";" + $NewPyScriptsPath
        # $Environment = $Environment.Insert($Environment.Length,$AddPathItems)

        #Set Updated Path
        [System.Environment]::SetEnvironmentVariable("Path", $Environment, "Machine")

        [System.Environment]::GetEnvironmentVariable("Path","Machine").split(";")

        wt -w 0 nt
    }
else 
    {
        Write-Host "ERROR: Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again." -ForegroundColor Red
    }

