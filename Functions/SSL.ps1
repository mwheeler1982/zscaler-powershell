function Get-ZscalerSSLExemptedUrl
{
    <#
    .SYNOPSIS
    Retrieves a list of SSL (and other policy) exempted URLs

    .EXAMPLE
    PS> Get-ZscalerSSLExemptedUrl

    urls
    ----
    {ax.itunes.com, .okta.com, .albert.apple.com...}

    .EXAMPLE
    PS> (Get-ZscalerSSLExemptedUrl).urls

    .okta.com
    .phobos.apple.com
    .securemetrics.apple.com
    albert.apple.com
    imap.gmail.com
    itunes.apple.com
    mail.cypressmaf.com
    mzstatic.com
    phobos.apple.com
    securemetrics.apple.com
    smtp.gmail.com
    #>
    # construct the URI
    $uri = ("https://admin.{0}.net/api/v1/sslSettings/exemptedUrls" -f $global:ZscalerEnvironment.cloud)

    # send the request
    return Invoke-RestMethod -uri $uri -Method Get -WebSession $global:ZscalerEnvironment.webession -ContentType 'application/json'
}

function Set-ZscalerSSLExemptedUrl
{
    <#
    .SYNOPSIS
    Adds or Removes URLs from the list of SSL (and other policy) exempted URLs
    
    .PARAMETER action
    Action to perform on the incoming list. Either add URLs to remove URLs from the list. Must be either "add" or "remove"

    .PARAMETER urls
    List of URLs to add or remove from the list. Must either be an array or comma separated list of domains

    .EXAMPLE
    PS> Set-ZscalerSSLExemptedUrl -action add -urls engadget.com,zscaler.com

    urls
    ----
    {engadget.com, zscaler.com}
    

    .EXAMPLE
    PS> Set-ZscalerSSLExemptedUrl -action remove -urls engadget.com,zscaler.com

    urls
    ----
    {engadget.com, zscaler.com}

    #>
    param(
        [Parameter(Mandatory=$true)][string]$action,
        [Parameter(Mandatory=$true)][string[]]$urls
    )

    # construct the URI
    $uri = ("https://admin.{0}.net/api/v1/sslSettings/exemptedUrls" -f $global:ZscalerEnvironment.cloud)

    # construct the URL parameter array
    $urlList = @{urls = $urls}

    # make sure they specify either add or remove
    switch -CaseSensitive ($action)
    {
        'add' {$urlAction = "ADD_TO_LIST"; Break}
        'remove' {$urlAction = "REMOVE_FROM_LIST"; Break}
        default {
            throw "Action must be either Add or Remove"
        }
    }

    # add the type of request to the URI
    $uri = ("{0}?action={1}" -f ($uri, $urlAction))

    # send the request
    return Invoke-RestMethod -uri $uri -Method Post -WebSession $global:ZscalerEnvironment.webession -Body (ConvertTo-Json $urlList) -ContentType 'application/json'
}