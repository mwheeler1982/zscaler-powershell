function Get-ZscalerUrlLookup
{
    <#
    .SYNOPSIS
    Performs a URL Category lookup for the specified domains

    .PARAMETER domains
    Array or comma separated list of domains for which the lookup should be performed

    .EXAMPLE
    PS> Get-ZscalerUrlLookup -domains zscaler.com,ipchicken.com,slashdot.org

    url           urlClassifications      urlClassificationsWithSecurityAlert
    ---           ------------------      -----------------------------------
    zscaler.com   {PROFESSIONAL_SERVICES} {}
    ipchicken.com {INTERNET_SERVICES}     {}
    slashdot.org  {NEWS_AND_MEDIA}        {}

    .EXAMPLE
    PS> $domains = @("zscaler.com", "ipchicken.com", "slashdot.org")
    PS> Get-ZscalerUrlLookup -domains $domains

    url           urlClassifications      urlClassificationsWithSecurityAlert
    ---           ------------------      -----------------------------------
    zscaler.com   {PROFESSIONAL_SERVICES} {}
    ipchicken.com {INTERNET_SERVICES}     {}
    slashdot.org  {NEWS_AND_MEDIA}        {}

    .EXAMPLE
    PS> $domains = Get-Content .\domains.txt
    PS> Get-ZscalerUrlLookup -domains $domains

    url           urlClassifications      urlClassificationsWithSecurityAlert
    ---           ------------------      -----------------------------------
    zscaler.com   {PROFESSIONAL_SERVICES} {}
    ipchicken.com {INTERNET_SERVICES}     {}
    slashdot.org  {NEWS_AND_MEDIA}        {}

    .EXAMPLE
    PS> Get-Content domains.txt
    zscaler.com
    ipchicken.com
    slashdot.org
    PS> Get-ZscalerUrlLookup -domains (get-content domains.txt)

    url           urlClassifications      urlClassificationsWithSecurityAlert
    ---           ------------------      -----------------------------------
    zscaler.com   {PROFESSIONAL_SERVICES} {}
    ipchicken.com {INTERNET_SERVICES}     {}
    slashdot.org  {NEWS_AND_MEDIA}        {}

    #>
    # parameters
    param(
        [Parameter(Mandatory=$true)][string[]]$domains
    )

    $request = [System.UriBuilder]("https://admin.{0}.net/api/v1/urlLookup" -f $global:ZscalerEnvironment.cloud)

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Post -WebSession $global:ZscalerEnvironment.webession -Body (ConvertTo-Json $domains) -ContentType 'application/json'
}

function Get-ZscalerUrlCategory
{
    <#
    .SYNOPSIS
    Gets the list of URL categories

    .PARAMETER customOnly
    Set to $true if you only want to retrieve the custom URL lists, not the predefined ones

    .PARAMETER id
    Get the URL category by its ID (e.g. NEWS_AND_MEDIA or CUSTOM_01)

    .PARAMETER brief
    Do not retrieve full information on the categories. Only retrieve a name-value pair of categories. Does not appear to be currently working.

    .EXAMPLE
    PS> Get-ZscalerUrlCategory -customOnly $true
    id                               : CUSTOM_01
    configuredName                   : Test blah blah
    urls                             : {ip.bingo, such.wtf, mwheeler.net}
    dbCategorizedUrls                : {}
    customCategory                   : True
    editable                         : True
    description                      : CUSTOM_01_DESC
    type                             : URL_CATEGORY
    val                              : 128
    customUrlsCount                  : 3
    urlsRetainingParentCategoryCount : 0

    PS> Get-ZscalerUrlCategory -id NEWS_AND_MEDIA
    id                               : NEWS_AND_MEDIA
    superCategory                    : NEWS_AND_MEDIA
    keywords                         : {}
    keywordsRetainingParentCategory  : {}
    urls                             : {}
    dbCategorizedUrls                : {}
    customCategory                   : False
    editable                         : True
    description                      : NEWS_AND_MEDIA_DESC
    type                             : URL_CATEGORY
    val                              : 59
    customUrlsCount                  : 0
    urlsRetainingParentCategoryCount : 0


    #>
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
    } else {
        $parameters = [ordered]@{}
        if ($customOnly) { $parameters.Add("customOnly", $customOnly) }
    }

    # return the result
    return Invoke-RestMethod -uri $request.Uri -Method Get -WebSession $global:ZscalerEnvironment.webession -Body $parameters -ContentType 'application/json'
}

function Get-ZscalerUrlFilteringRule
{
    <#
    .SYNOPSIS
    Gets URL Filtering Rules

    .PARAMETER id
    Retrieve a URL Filtering rule by its ID number

    .EXAMPLE
    PS> Get-ZscalerUrlFilteringRule -id 92605
    id             : 92605
    accessControl  : READ_WRITE
    name           : URL Filtering Rule-1
    order          : 1
    protocols      : {ANY_RULE}
    urlCategories  : {OTHER_ADULT_MATERIAL, ADULT_THEMES, LINGERIE_BIKINI, NUDITY...}
    state          : DISABLED
    rank           : 7
    requestMethods : {OPTIONS, GET, HEAD, POST...}
    blockOverride  : False
    action         : BLOCK

    #>
    
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
    <#
    .SYNOPSIS
    Adds a new URL Filtering Rule

    .PARAMETER name
    Name for the rule

    .PARAMETER order
    Rule order

    .PARAMETER rank
    Admin rank. If not specified, defaults to 7

    .PARAMETER state
    Rule state. Enabled or Disabled

    .PARAMETER action
    Rule action. Block or Allow

    .PARAMETER protocols
    Protocols for which the rule applies (ex. ANY_RULE)

    .PARAMETER requestMethods
    Request Methods for which the rule applies. Comma separated list or array (ex. OPTIONS,GET,HEAD,POST,PUT,DELETE,TRACE,CONNECT,OTHER )

    .PARAMETER urlCategories
    URL categories for the rule. Comma separated list or array (ex. QUESTIONABLE,GAMBLING)

    .EXAMPLE
    PS> Add-ZscalerUrlFilteringRule -name "New Filtering Rule" -order 1 -state ENABLED -action BLOCK -protocols ANY_RULE -requestMethods OPTIONS,GET,HEAD,POST,PUT,DELETE,TRACE,CONNECT,OTHER -urlCategories QUESTIONABLE,GAMBLING,CUSTOM_01
    id             : 103718
    name           : New Filtering Rule
    order          : 1
    protocols      : {ANY_RULE}
    urlCategories  : {QUESTIONABLE, GAMBLING, CUSTOM_01}
    state          : ENABLED
    rank           : 7
    requestMethods : {OPTIONS, GET, HEAD, POST...}
    blockOverride  : False
    action         : BLOCK

    #>
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
    <#
    .SYNOPSIS
    Removes a URL Filtering rule

    .PARAMETER id
    The ID number of the rule. You can get this ID from the Get-ZscalerUrlFilteringRule command

    .EXAMPLE
    PS> Remove-ZscalerUrlFilteringRule -id 103718

    #>
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

function Update-ZscalerUrlCategory
{
    <#
    .SYNOPSIS
    Adds or removes URLs from a custom category

    .PARAMETER id
    ID of the URL category (ex. CUSTOM_01)

    .PARAMETER action
    Direction to add or remove items from the category. Use 'add' or 'remove'

    .PARAMETER configuredName
    Name of the category. Required by the API

    .PARAMETER urls
    Comma separated list or array of URLs to add/remove from the list

    .PARAMETER dbCategorizedUrls
    Comma separated list or array of URLs to add/remove from the "Retain Parent Category" section.

    .EXAMPLE
    PS> Update-ZscalerUrlCategory -id CUSTOM_01 -action add -configuredName "Test Category" -urls gambling.com,badstuff.com

    id                               : CUSTOM_01
    configuredName                   : Test Category
    keywordsRetainingParentCategory  : {}
    urls                             : {ip.bingo, such.wtf, gambling.com, badstuff.com...}
    dbCategorizedUrls                : {}
    customCategory                   : True
    editable                         : True
    description                      : CUSTOM_01_DESC
    type                             : URL_CATEGORY
    val                              : 128
    customUrlsCount                  : 5
    urlsRetainingParentCategoryCount : 0

    .EXAMPLE
    PS> Update-ZscalerUrlCategory -id CUSTOM_01 -action remove -configuredName "Test Category" -urls gambling.com,badstuff.com

    id                               : CUSTOM_01
    configuredName                   : Test Category
    keywordsRetainingParentCategory  : {}
    urls                             : {ip.bingo, such.wtf, mwheeler.net}
    dbCategorizedUrls                : {}
    customCategory                   : True
    editable                         : True
    description                      : CUSTOM_01_DESC
    type                             : URL_CATEGORY
    val                              : 128
    customUrlsCount                  : 3
    urlsRetainingParentCategoryCount : 0
    
    #>
    param(
        [Parameter(Mandatory=$true)][string]$id,
        [Parameter(Mandatory=$true)][string]$action,
        [Parameter(Mandatory=$true)][string]$configuredName,
        [Parameter(Mandatory=$false)][string[]]$urls,
        [Parameter(Mandatory=$false)][string[]]$dbCategorizedUrls
    )

    # make sure they specified either URLs or DB Categorized URLs
    if (!$urls -and !$dbCategorizedUrls)
    {
        Throw "Must specify either -urls or -dbCategorizedUrls"
    }

    # construct the URI
    $uri = ("https://admin.{0}.net/api/v1/urlCategories" -f $global:ZscalerEnvironment.cloud)

    # construct the URL parameter array
    $parameters = @{}
    $parameters.Add("urls", $urls)
    $parameters.Add("dbCategorizedUrls", $dbCategorizedUrls)
    $parameters.Add("id", $id)
    $parameters.Add("configuredName", $configuredName)

    # make sure they specify either add or remove
    switch -CaseSensitive ($action)
    {
        'add' {$urlAction = "ADD_TO_LIST"; Break}
        'remove' {$urlAction = "REMOVE_FROM_LIST"; Break}
        default {
            throw "Action must be either Add or Remove"
        }
    }

    # add the type of request to the URI and the ID
    $uri = ("{0}/{1}?action={2}" -f ($uri, $id, $urlAction))

    # send the request 
    return Invoke-RestMethod -uri $uri -Method Put -WebSession $global:ZscalerEnvironment.webession -Body (ConvertTo-Json $parameters) -ContentType 'application/json'
}