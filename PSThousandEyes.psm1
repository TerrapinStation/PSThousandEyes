#Get public and private function definition files.
    $Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
    $Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
    $ModuleRoot = $PSScriptRoot

#Dot source the files
    Foreach($import in @($Public + $Private))
    {
        Try
        {
            . $import.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import function $($import.fullname): $_"
        }
    }

#Create / Read config
    if(-not (Test-Path -Path "$PSScriptRoot\PSThousandEyes.xml" -ErrorAction SilentlyContinue))
    {
        Try
        {
            Write-Warning "Did not find config file $PSScriptRoot\PSThousandEyes.xml, attempting to create"
            [pscustomobject]@{
                Uri = $null
                Token = $null
                ArchiveUri = $null
            } | Export-Clixml -Path "$PSScriptRoot\PSThousandEyes.xml" -Force -ErrorAction Stop
        }
        Catch
        {
            Write-Warning "Failed to create config file $PSScriptRoot\PSThousandEyes.xml: $_"
        }
    }

#Initialize the config variable.  I know, I know...
    Try
    {
        #Import the config
        $PSThousandEyes = $null
        $PSThousandEyes = Get-PSThousandEyesConfig -Source PSThousandEyes.xml -ErrorAction Stop

    }
    Catch
    {   
        Write-Warning "Error importing PSThousandEyes config: $_"
    }

Export-ModuleMember -Function $Public.Basename