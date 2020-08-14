Function Get-ZscalerUsers
{
    # parameters
    param(
        [Parameter(Mandatory=$false)][string]$id,
        [Parameter(Mandatory=$false)][string]$name,
        [Parameter(Mandatory=$false)][string]$dept,
        [Parameter(Mandatory=$false)][string]$group,
        [Parameter(Mandatory=$false)][int]$page,
        [Parameter(Mandatory=$false)][int]$pageSize
    )

    # set the URI
    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/users" -f $global:ZscalerEnvironment.cloud)

    # construct the rest of the URI
    # first, see if they asked for an ID. If so, short-circuit the rest of the logic
    if ($id) {
        # ID specified
        $request.Path += ("/{0}" -f $id)
    } else {
        # no ID Specified. Build query string parameters array
        $parameters = [ordered]@{}
        if ($name) { $parameters.Add("name", $name) }
        if ($dept) { $parameters.Add("dept", $dept) }
        if ($group) { $parameters.Add("group", $group) }
        if ($page) { $parameters.Add("page", $page) }
        if ($pageSize) { $parameters.Add("pageSize", $pagesize) }
    }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}