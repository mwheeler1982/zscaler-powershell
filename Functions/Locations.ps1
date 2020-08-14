function Get-ZscalerLocation
{
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