Function Save-TEConfig {
<#
.Synopsis
   Used to store information about your Thousand Eyes instance.
.DESCRIPTION
   Used to store information about your Thousand Eyes instance. The domain and api token are given.
.EXAMPLE
   Save-TEConfig -Token "Token" -Email "user@example.com" 
.NOTES
   Implemented using Export-CLIXML saving the configurations. Stores .xml in $env:appdata\PSThousandEyes\
#>
[cmdletbinding()]
param(
    [Parameter(Mandatory=$true,
               HelpMessage='You can find the token in your profile.',
               Position=0)]
    [ValidateNotNullOrEmpty()]
    $Token,

    [Parameter(Mandatory=$true,
               HelpMessage='Please provide an email address associated with the given token',
               Position=1)]
    [ValidateNotNullOrEmpty()]
    $Email
)

$Parameters = @{
    Token=(ConvertTo-SecureString -string $Token -AsPlainText -Force)
    Email=$Email;
}
$ConfigPath = "$env:appdata\PSThousandEyes\PSThousandEyesConfig.xml"
if (-not (Test-Path (Split-Path $ConfigPath))) {
    New-Item -ItemType Directory -Path (Split-Path $ConfigPath) | Out-Null
}
$Parameters | Export-Clixml -Path $ConfigPath
Remove-Variable Parameters
}
