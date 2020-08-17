function Get-ZscalerLocation
{
    <#
    .SYNOPSIS
    Gets information on ZIA configured locations

    .PARAMETER id
    Retrieve a location by its ID

    .PARAMETER search
    Search within the "name" and "comments" attributes for the search term. This is a case-insensitive partial string match search.

    .PARAMETER brief
    Show only IDs and Location names in a brief, table format.

    .EXAMPLE
    PS> Get-ZscalerLocation
    id                            : 11549625
    name                          : Network 1
    ipAddresses                   : {1.1.1.1}
    zappSslScanEnabled            : True
    surrogateRefreshTimeInMinutes : 0
    staticLocationGroups          : {@{id=11336000; name=Texas}}
    dynamiclocationGroups         : {}

    id                            : 11183521
    name                          : Lab 1
    country                       : UNITED_STATES
    state                         : Houston TX
    tz                            : UNITED_STATES_AMERICA_CHICAGO
    ipAddresses                   : {2.2.2.2}
    sslScanEnabled                : True
    zappSslScanEnabled            : True
    urrogateRefreshTimeInMinutes : 0
    staticLocationGroups          : {@{id=11336000; name=Texas}}
    dynamiclocationGroups         : {}

    .EXAMPLE
    PS> Get-ZscalerLocation -brief $true
    id          name
    --          ----
    -3          Road Warrior
    11549625    Network 1
    11183521    Lab 1

    .EXAMPLE
    PS> Get-ZscalerLocation -id 11183521
    id                            : 11183521
    name                          : Lab 1
    country                       : UNITED_STATES
    state                         : Houston TX
    tz                            : UNITED_STATES_AMERICA_CHICAGO
    ipAddresses                   : {2.2.2.2}
    sslScanEnabled                : True
    zappSslScanEnabled            : True
    urrogateRefreshTimeInMinutes : 0
    staticLocationGroups          : {@{id=11336000; name=Texas}}
    dynamiclocationGroups         : {}
    #>
    # parameters
    param(
        [Parameter(Mandatory=$false)][string]$id,
        [Parameter(Mandatory=$false)][string]$search,
        [Parameter(Mandatory=$false)][bool]$brief
    )

    # brief and ID can't be used together
    if ($brief -and $id) { Throw "-brief and -id cannot be used together."}

    # set the URI
    # use a different URI if they want brief mode
    if ($brief)
    {
        # brief mode
        $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/locations/lite" -f $global:ZscalerEnvironment.cloud)
    } else {
        # full info mode
        $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/locations" -f $global:ZscalerEnvironment.cloud)
    }
 
    # construct the rest of the URI
    # first, see if they asked for an ID. If so, short-circuit the rest of the logic
    if ($id) {
        # ID specified
        $request.Path += ("/{0}" -f $id)
    } else {
        # no ID Specified. Build query string parameters array
        $parameters = [ordered]@{}
        if ($search) { $parameters.Add("search", $search) }

    }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Get-ZscalerSublocation
{
    <#
    .SYNOPSIS
    Gets information on a sublocation configured within ZIA

    .PARAMETER id
    The parent location for which to retrieve sublocations. Parent IDs can be retrieved using Get-ZscalerLocation

    .EXAMPLE
    PS> Get-ZscalerSublocation -id 11183521

    id                            : 13233859
    name                          : Sublocation 1
    parentId                      : 11183521
    country                       : UNITED_STATES
    state                         : Houston TX
    tz                            : UNITED_STATES_AMERICA_CHICAGO
    ipAddresses                   : {100.100.20.0-100.100.20.255}
    sslScanEnabled                : True
    zappSslScanEnabled            : True
    surrogateRefreshTimeInMinutes : 0

    id                            : 13233860
    name                          : other
    parentId                      : 11183521
    country                       : UNITED_STATES
    state                         : Houston TX
    tz                            : UNITED_STATES_AMERICA_CHICAGO
    sslScanEnabled                : True
    zappSslScanEnabled            : True
    otherSubLocation              : True
    surrogateRefreshTimeInMinutes : 0

    #>

    # parameters
    param(
        [Parameter(Mandatory=$true)][string]$id
    )

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/locations/{1}/sublocations" -f ($global:ZscalerEnvironment.cloud, $id))

    # add paramters
    $parameters = [ordered]@{}
    if ($search) { $parameters.Add("search", $search) }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}