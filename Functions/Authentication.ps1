function Get-ZscalerAPISession
{
    $cloud = $global:ZscalerEnvironment.cloud
    $apikey = $global:ZscalerEnvironment.apikey
    $username = $global:ZscalerEnvironment.username
    $password = $global:ZscalerEnvironment.password

    #
    # set the URI
    #
    $uri = ("https://admin.{0}.net/api/v1/authenticatedSession" -f $cloud)

    #
    # set up obfuscation, timestamps, and all of this other mess
    #
    $date = (get-date).ToUniversalTime()
    $instant = [decimal](get-date -date $date -UFormat %s)
    $now = [math]::Truncate($instant * 1000)
    $length = ([string]$now).Length
    $n = ([string]$now).Substring($length - 6)
    $r = ([string]($n -shr 1)).PadLeft(6)

    #
    # construct the secret
    #
    $secret = ""
    [char[]]$n | ForEach-Object {
        $secret += $apikey.Substring([string]$_, 1)
    }
    [char[]]$r | ForEach-Object {
        $position = ([int]([string]$_)) + 2
        $secret += $apikey.Substring($position, 1)
    }

    #
    # construct our parameters variable
    #
    $parameters = @{
        apiKey = $secret
        username = $username
        password = $password
        timestamp = $now
    }

    #
    # send login request
    #
    $result = Invoke-WebRequest -Uri $uri -Method Post -Body (ConvertTo-Json $parameters) -ContentType "application/json" -SessionVariable webession
    # Set-ItemProperty -InputObject $global:ZscalerEnvironment -Name webession -Value $websession
    $global:ZscalerEnvironment.webession = $webession
}

function Set-ZscalerEnvironment
{
    param(
        [string]$cloud,
        [string]$apikey,
        [string]$username,
        [string]$password
    )

    $global:ZscalerEnvironment = [PSCustomObject]@{
        cloud = $cloud
        username = $username
        password = $password
        apikey = $apikey
        webession = $webession
    }

    # $global:ZscalerEnvironment = New-Object psobject -Property $properties
}
