function Get-ZscalerWhitelistUrl
{
    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/security" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Set-ZscalerWhitelistUrl
{
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
    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/security/advanced" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}