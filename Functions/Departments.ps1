function Get-ZscalerDepartment
{
    # parameters
    param(
        [Parameter(Mandatory=$false)][string]$id,
        [Parameter(Mandatory=$false)][string]$search
    )

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/departments" -f $global:ZscalerEnvironment.cloud)

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