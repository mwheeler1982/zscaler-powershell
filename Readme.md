# zscaler-powershell

### Zscaler Powershell Modules
This module is intended to be a starting point when interacting with the Zscaler APIs

### Quickstart 
- Set your environment
    - `Set-ZscalerEnvironment -cloud "<your_cloud>" -apikey "<your_apikey>" -username "<api_username>" -password "<api_password>"`
- Authenticate and get a session
    - `Get-ZscalerAPISession`
- Make API Requests!

### Setting up your environment
- To instantiate your environment, you can use the `Get-ZscalerEnvironmentFromFile` command like this:
##### Windows
```
    Get-ZscalerEnvironmentFromFile .\.Zscaler\config
``` 

##### Mac OSX
```
    Get-ZscalerEnvironmentFromFile ./.Zscaler/config
``` 
 
 Where the argument is the path to your config file. The config file needs to look like this, with values filled in specific to your Zscaler cloud and account:
 ```
    cloud = zscalerthree
    username = username-goes-here
    password = password-goes-here
    apikey = apikey-goes-here
```

# Zscaler Module Commands
## Add-ZscalerUrlFilteringRule
### Syntax
```powershell
Add-ZscalerUrlFilteringRule [-name] <string> [-order] <int> [[-rank] <int>] [-state] <string> [-action] <string> [-protocols] <string[]> [-requestMethods] <string[]> [-urlCategories] <string[]> [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>action</nobr> | None |  | true | false |  |
| <nobr>name</nobr> | None |  | true | false |  |
| <nobr>order</nobr> | None |  | true | false |  |
| <nobr>protocols</nobr> | None |  | true | false |  |
| <nobr>rank</nobr> | None |  | false | false |  |
| <nobr>requestMethods</nobr> | None |  | true | false |  |
| <nobr>state</nobr> | None |  | true | false |  |
| <nobr>urlCategories</nobr> | None |  | true | false |  |
## Get-ZscalerActivationStatus
### Synopsis
Determine if there are pending changes to be activated
### Syntax
```powershell

Get-ZscalerActivationStatus [<CommonParameters>]





```
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerActivationStatus

status  
------  
ACTIVE
```
**EXAMPLE 2**
```powershell
Get-ZscalerActivationStatus

status  
------  
PENDING
```
## Get-ZscalerAPISession
### Synopsis
Logs into the Zscaler API and gets an active session
### Syntax
```powershell

Get-ZscalerAPISession [<CommonParameters>]





```
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerAPISession
```


## Get-ZscalerBlacklistUrl
### Syntax
```powershell
Get-ZscalerBlacklistUrl
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
## Get-ZscalerDepartment
### Synopsis
Gets information about Departments configured within ZIA
### Syntax
```powershell

Get-ZscalerDepartment [[-id] <String>] [[-search] <String>] [<CommonParameters>]





```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>id</nobr> |  | Retrieve a department by its department ID | false | false |  |
| <nobr>search</nobr> |  | Search within the "name" and "comments" attributes for the search term. This is a case-insensitive partial string match search. | false | false |  |
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerDepartment

id          name               comments  
--          ----               --------  
11211611    IT                 IT  
11172659    Service Admin
```
**EXAMPLE 2**
```powershell
Get-ZscalerDepartment -id 11211611

id          name    comments  
--          ----    --------  
11211611    IT      IT
```
**EXAMPLE 3**
```powershell
Get-ZscalerDepartment -search Admin

isNonEditable       id          name  
-------------       --          ----  
True           11172659    Service Admin
```
## Get-ZscalerEnvironmentFromFile
### Synopsis
Reads Zscaler API Environment information from a file, then feeds to Set-ZscalerEnvironment
### Syntax
```powershell

Get-ZscalerEnvironmentFromFile [-FileName] <String> [<CommonParameters>]





```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>FileName</nobr> |  | File name containing the Zsclaer API environment variables. Example file looks like this: cloud = zscalerthree apikey = ABCDEFGHIJ username = admin@123.zscalerthree.net password = P4ssw0rd | true | false |  |
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerEnvironmentFromFile -FileName .\.Zscaler\config
```


## Get-ZscalerGreTunnelInfo
### Syntax
```powershell
Get-ZscalerGreTunnelInfo
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
## Get-ZscalerGroup
### Synopsis
Gets information about Departments configured within ZIA
### Syntax
```powershell

Get-ZscalerGroup [[-id] <String>] [[-search] <String>] [<CommonParameters>]





```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>id</nobr> |  | Retrieve a department by its department ID | false | false |  |
| <nobr>search</nobr> |  | Search within the "name" and "comments" attributes for the search term. This is a case-insensitive partial string match search. | false | false |  |
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerGroup

id          name  
--          ----  
11211613    IT  
11172658    Service Admin  
11221783    Splunk\_Users
```
**EXAMPLE 2**
```powershell
Get-ZscalerGroup -id 11221783

id          name  
--          ----  
11221783    Splunk\_Users
```
**EXAMPLE 3**
```powershell
Get-ZscalerGroup -search Splunk

id          name  
--          ----  
11221783    Splunk\_Users
```
## Get-ZscalerLocation
### Synopsis
Gets information on ZIA configured locations
### Syntax
```powershell

Get-ZscalerLocation [[-id] <String>] [[-search] <String>] [[-brief] <Boolean>] [<CommonParameters>]





```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>id</nobr> |  | Retrieve a location by its ID | false | false |  |
| <nobr>search</nobr> |  | Search within the "name" and "comments" attributes for the search term. This is a case-insensitive partial string match search. | false | false |  |
| <nobr>brief</nobr> |  | Show only IDs and Location names in a brief, table format. | false | false | False |
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerLocation

id                            : 11549625  
name                          : Network 1  
ipAddresses                   : \{1.1.1.1\}  
zappSslScanEnabled            : True  
surrogateRefreshTimeInMinutes : 0  
staticLocationGroups          : \{@\{id=11336000; name=Texas\}\}  
dynamiclocationGroups         : \{\}  
  
id                            : 11183521  
name                          : Lab 1  
country                       : UNITED\_STATES  
state                         : Houston TX  
tz                            : UNITED\_STATES\_AMERICA\_CHICAGO  
ipAddresses                   : \{2.2.2.2\}  
sslScanEnabled                : True  
zappSslScanEnabled            : True  
urrogateRefreshTimeInMinutes : 0  
staticLocationGroups          : \{@\{id=11336000; name=Texas\}\}  
dynamiclocationGroups         : \{\}
```
**EXAMPLE 2**
```powershell
Get-ZscalerLocation -brief $true

id          name  
--          ----  
-3          Road Warrior  
11549625    Network 1  
11183521    Lab 1
```
**EXAMPLE 3**
```powershell
Get-ZscalerLocation -id 11183521

id                            : 11183521  
name                          : Lab 1  
country                       : UNITED\_STATES  
state                         : Houston TX  
tz                            : UNITED\_STATES\_AMERICA\_CHICAGO  
ipAddresses                   : \{2.2.2.2\}  
sslScanEnabled                : True  
zappSslScanEnabled            : True  
urrogateRefreshTimeInMinutes : 0  
staticLocationGroups          : \{@\{id=11336000; name=Texas\}\}  
dynamiclocationGroups         : \{\}  
```  
parameters

## Get-ZscalerSessionCookie
### Synopsis
Outputs the Zscaler API session cookie value if one exists
### Syntax
```powershell

Get-ZscalerSessionCookie [<CommonParameters>]





```
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerSessionCookie

JSESSIONID=1E62Z35CE94DC34A801DC822D6CEEC1R
```
## Get-ZscalerSSLExemptedUrl
### Syntax
```powershell
Get-ZscalerSSLExemptedUrl
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
## Get-ZscalerSublocation
### Synopsis
Gets information on a sublocation configured within ZIA
### Syntax
```powershell

Get-ZscalerSublocation [-id] <String> [<CommonParameters>]





```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>id</nobr> |  | The parent location for which to retrieve sublocations. Parent IDs can be retrieved using Get-ZscalerLocation | true | false |  |
### Examples
**EXAMPLE 1**
```powershell
Get-ZscalerSublocation -id 11183521

id                            : 13233859  
name                          : Sublocation 1  
parentId                      : 11183521  
country                       : UNITED\_STATES  
state                         : Houston TX  
tz                            : UNITED\_STATES\_AMERICA\_CHICAGO  
ipAddresses                   : \{100.100.20.0-100.100.20.255\}  
sslScanEnabled                : True  
zappSslScanEnabled            : True  
surrogateRefreshTimeInMinutes : 0  
  
id                            : 13233860  
name                          : other  
parentId                      : 11183521  
country                       : UNITED\_STATES  
state                         : Houston TX  
tz                            : UNITED\_STATES\_AMERICA\_CHICAGO  
sslScanEnabled                : True  
zappSslScanEnabled            : True  
otherSubLocation              : True  
surrogateRefreshTimeInMinutes : 0
```
## Get-ZscalerUrlCategory
### Syntax
```powershell
Get-ZscalerUrlCategory [[-customOnly] <bool>] [[-id] <string>] [[-brief] <bool>] [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>brief</nobr> | None |  | false | false |  |
| <nobr>customOnly</nobr> | None |  | false | false |  |
| <nobr>id</nobr> | None |  | false | false |  |
## Get-ZscalerUrlFilteringRule
### Syntax
```powershell
Get-ZscalerUrlFilteringRule [[-id] <string>] [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>id</nobr> | None |  | false | false |  |
## Get-ZscalerUrlLookup
### Syntax
```powershell
Get-ZscalerUrlLookup [[-domains] <string[]>] [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>domains</nobr> | None |  | false | false |  |
## Get-ZscalerUser
### Syntax
```powershell
Get-ZscalerUser [[-id] <string>] [[-name] <string>] [[-dept] <string>] [[-group] <string>] [[-page] <int>] [[-pageSize] <int>] [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>dept</nobr> | None |  | false | false |  |
| <nobr>group</nobr> | None |  | false | false |  |
| <nobr>id</nobr> | None |  | false | false |  |
| <nobr>name</nobr> | None |  | false | false |  |
| <nobr>page</nobr> | None |  | false | false |  |
| <nobr>pageSize</nobr> | None |  | false | false |  |
## Get-ZscalerWhitelistUrl
### Synopsis
Retrieves the list of Whitelisted URLs
### Syntax
```powershell

Get-ZscalerWhitelistUrl [<CommonParameters>]





```
### Examples
**EXAMPLE 1**
```powershell
set the URI
```


## Remove-ZscalerAPISession
### Synopsis
Logs out of the Zscaler API session
### Syntax
```powershell

Remove-ZscalerAPISession [<CommonParameters>]





```
### Examples
**EXAMPLE 1**
```powershell
Remove-ZscalerAPISession
```


## Remove-ZscalerUrlFilteringRule
### Syntax
```powershell
Remove-ZscalerUrlFilteringRule [-id] <string> [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>id</nobr> | None |  | true | false |  |
## Set-ZscalerActivateChanges
### Synopsis
Activate pending changes within the Zscaler management console
### Syntax
```powershell

Set-ZscalerActivateChanges [<CommonParameters>]





```
### Examples
**EXAMPLE 1**
```powershell
Set-ZscalerActivateChanges

status  
------  
ACTIVE
```
## Set-ZscalerEnvironment
### Synopsis
Sets the variables required to authenticate to the Zscaler API
### Syntax
```powershell

Set-ZscalerEnvironment [-cloud] <String> [-apikey] <String> [-username] <String> [-password] <String> [<CommonParameters>]





```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>cloud</nobr> |  | The Zscaler cloud you are logging into. Example: zscalerthree | true | false |  |
| <nobr>apikey</nobr> |  | Your Zscaler Cloud API Key | true | false |  |
| <nobr>username</nobr> |  | Your Zscaler API username | true | false |  |
| <nobr>password</nobr> |  | Your Zscaler API password | true | false |  |
### Examples
**EXAMPLE 1**
```powershell
Set-ZscalerEnvironment -cloud zscalerthree -apikey ABCDEFGHIJ -username admin@123.zscalerthree.net -password P4ssw0rd
```


## Set-ZscalerSSLExemptedUrl
### Syntax
```powershell
Set-ZscalerSSLExemptedUrl [-action] <string> [-urls] <string[]> [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>action</nobr> | None |  | true | false |  |
| <nobr>urls</nobr> | None |  | true | false |  |
## Set-ZscalerWhitelistUrl
### Syntax
```powershell
Set-ZscalerWhitelistUrl [[-force] <bool>] [[-urls] <string[]>] [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>force</nobr> | None |  | false | false |  |
| <nobr>urls</nobr> | None |  | false | false |  |
## Update-ZscalerUrlCategory
### Syntax
```powershell
Update-ZscalerUrlCategory [-id] <string> [-action] <string> [-configuredName] <string> [-urls] <string[]> [<CommonParameters>]
```
### Parameters
| Name  | Alias  | Description | Required? | Pipeline Input | Default Value |
| - | - | - | - | - | - |
| <nobr>action</nobr> | None |  | true | false |  |
| <nobr>configuredName</nobr> | None |  | true | false |  |
| <nobr>id</nobr> | None |  | true | false |  |
| <nobr>urls</nobr> | None |  | true | false |  |
