function Get-ZscalerWhitelistUrl
{
    <#
    .SYNOPSIS
    Retrieves the list of Whitelisted URLs

    .EXAMPLE
    PS> Get-ZscalerWhitelistUrl

    whitelistUrls
    -------------
    {bbc.com, slashdot.org}

    #>
    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/security" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Set-ZscalerWhitelistUrl
{
    <#
    .SYNOPSIS
    Sets the list of Whitelisted URLs

    .PARAMETER urls
    Array of URLs to set the whitelist. This will overwrite the existing whitelist with the new values.

    .PARAMETER force
    Submitting an empty list will wipe out the Whitelist. Use this option to force that operation to happen, otherwise an error will be thrown.

    .EXAMPLE
    PS> Set-ZscalerWhitelistUrl -urls @("bbc.com", "slashdot.org")

    whitelistUrls
    -------------
    {bbc.com, slashdot.org}

    .EXAMPLE
    PS> Set-ZscalerWhitelistUrl
    Submitting an empty list of URLs will completely erase the whitelist. Please use the -force \True option if this is what you really want to do.

    .EXAMPLE
    PS> Set-ZscalerWhitelistUrl -force $true

    #>
    # parameters
    param(
        [Parameter(Mandatory=$false)][bool]$force,
        [Parameter(Mandatory=$false)][string[]]$urls
    )

    if (!$urls -and !$force)
    {
        # make sure they actually want to empty the list
        Throw "Submitting an empty list of URLs will completely erase the whitelist. Please use the -force \$true option if this is what you really want to do."
    }

    $urlList = @{whitelistUrls = $urls}

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/security" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Put -WebSession $global:ZscalerEnvironment.webession -Body (ConvertTo-Json $urlList) -ContentType 'application/json'
}

function Get-ZscalerBlacklistUrl
{
    <#
    .SYNOPSIS
    Retrieves the list of Blacklisted URLs

    .EXAMPLE
    PS> Get-ZscalerBlacklistUrl

    blacklistUrls
    -------------
    {bbc.com, slashdot.org}

    #>
    
    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/security/advanced" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}