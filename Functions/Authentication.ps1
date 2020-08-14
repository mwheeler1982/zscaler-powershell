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
    $r = ([string]($n -shr 1)).PadLeft(6, 0)

    #
    # construct the secret
    #
    $secret = ""
    try {
        [char[]]$n | ForEach-Object {
            $secret += $apikey.Substring([string]$_, 1)
        }
        [char[]]$r | ForEach-Object {
            $position = ([int]([string]$_)) + 2
            $secret += $apikey.Substring($position, 1)
        }
    }
    catch {
        write-host "r is $r"
        write-host "position is $position"
        write-host "secret is $secret"
        write-host "var is $_"
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
    $result = Invoke-RestMethod -Uri $uri -Method Post -Body (ConvertTo-Json $parameters) -ContentType "application/json" -SessionVariable webession
    $global:ZscalerEnvironment.webession = $webession
}

function Remove-ZscalerAPISession
{
    # set the URI
    $uri = ("https://admin.{0}.net/api/v1/authenticatedSession" -f $global:ZscalerEnvironment.cloud)

    # log out of the authenticated session
    $result = Invoke-RestMethod -Uri $uri -Method Delete -WebSession $global:ZscalerEnvironment.webession -ContentType 'application/json'
    return
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
}

function Get-ZscalerSessionCookie
{
    $uri = ("https://admin.{0}.net/api/v1/authenticatedSession" -f $global:ZscalerEnvironment.cloud)
    return $Global:ZscalerEnvironment.webession.Cookies.GetCookies($uri)[0].ToString()
}
