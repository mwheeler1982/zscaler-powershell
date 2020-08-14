function Get-ZscalerUrlLookup
{
    # parameters
    param(
        [Parameter(Mandatory=$false)][string[]]$domains
    )

    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/urlLookup" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Post -WebSession $global:ZscalerEnvironment.webession -Body (ConvertTo-Json $domains) -ContentType 'application/json'
}

function Get-ZscalerUrlCategory
{
    # parameters
    param(
        [Parameter(Mandatory=$false)][bool]$customOnly,
        [Parameter(Mandatory=$false)][string]$id,
        [Parameter(Mandatory=$false)][bool]$brief
    )

    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/urlCategories" -f $global:ZscalerEnvironment.cloud)

    # set the parameters
    # first, see if they asked for an ID. If so, short-circuit the rest of the logic
    if ($id) {
        # ID specified
        $request.Path += ("/{0}" -f $id)
    } elseif ($brief){
        $request.Path += ("/lite")
        write-host ("URI is: {0}" -f $request.Uri)
    } else {
        $parameters = [ordered]@{}
        if ($customOnly) { $parameters.Add("customOnly", $customOnly) }
    }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Get-ZscalerUrlFilteringRule
{
    # parameters
    param(
        [Parameter(Mandatory=$false)][string]$id
    )

    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/urlFilteringRules" -f $global:ZscalerEnvironment.cloud)

    # construct the rest of the URI
    if ($id) {
        # ID specified
        $request.Path += ("/{0}" -f $id)
    }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Add-ZscalerUrlFilteringRule
{
    # parameters
    param(
        [Parameter(Mandatory=$true)][string]$name,
        [Parameter(Mandatory=$true)][int]$order,
        [Parameter(Mandatory=$false)][int]$rank,
        [Parameter(Mandatory=$true)][string]$state,
        [Parameter(Mandatory=$true)][string]$action,
        [Parameter(Mandatory=$true)][string[]]$protocols,
        [Parameter(Mandatory=$true)][string[]]$requestMethods,
        [Parameter(Mandatory=$true)][string[]]$urlCategories
    )

    $parameters = [ordered]@{}
    $parameters.Add("name", $name)
    $parameters.Add("order", $order)
    #rank is 7 unless they specify one
    if ($rank) {
        $parameters.Add("rank", $rank)
    } else {
        $parameters.Add("rank", 7)
    }
    $parameters.Add("state", $state)
    $parameters.Add("action", $action)
    $parameters.Add("protocols", $protocols)
    $parameters.Add("requestMethods", $requestMethods)
    $parameters.Add("urlCategories", $urlCategories)

    # build the request
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/urlFilteringRules" -f $global:ZscalerEnvironment.cloud)

    # send the request
    return Invoke-RestMethod -uri $request.Uri -Method Post -WebSession $global:ZscalerEnvironment.webession -Body (ConvertTo-Json $parameters) -ContentType 'application/json'
}

function Remove-ZscalerUrlFilteringRule
{
    # parameters
    param(
        [Parameter(Mandatory=$true)][string]$id
    )

    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/urlFilteringRules" -f $global:ZscalerEnvironment.cloud)

    # construct the rest of the URI
    $request.Path += ("/{0}" -f $id)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Delete -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}