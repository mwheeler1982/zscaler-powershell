function Get-ZscalerSSLExemptedUrls
{
    # construct the URI
    $uri = ("https://admin.{0}.net/api/v1/sslSettings/exemptedUrls" -f $global:ZscalerEnvironment.cloud)

    # send the request
    return Invoke-RestMethod -uri $uri -Method Get -WebSession $global:ZscalerEnvironment.webession -ContentType 'application/json'
}

function Set-ZscalerSSLExemptedUrls
{
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