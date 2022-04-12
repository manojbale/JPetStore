function Get-Proxies () 
{
    Write-Host "Proxy current user: "
    Write-Host Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer, ProxyEnable
    Write-Host "\n Proxy System: "
    Write-Host Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer, ProxyEnable
    Write-Host "\n Proxy System: "
    Write-Host Get-ItemProperty -Path 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer, ProxyEnable
    Write-Host "\n Proxy proxyadmin: "
    $sidProxyAdmin = (New-Object System.Security.Principal.NTAccount('proxyadmin')).Translate([System.Security.Principal.SecurityIdentifier]).Value
    Write-Host Get-ItemProperty -Path 'registry::HKEY_USERS\$($sidProxyAdmin)\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer, ProxyEnable
    Write-Host "\n Proxy AzDevOps: "
    $sidAzDevOps = (New-Object System.Security.Principal.NTAccount('AzDevOps')).Translate([System.Security.Principal.SecurityIdentifier]).Value
    Write-Host Get-ItemProperty -Path 'registry::HKEY_USERS\$($sidAzDevOps)\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer, ProxyEnable
}

function OpenCloseIE()
{
Write-Host "open IE"
$ie = Start-Process -file iexplore -arg 'http://www.google.com' -PassThru
sleep 5
$ie.Kill()
}

function CreateProxyKeys($sid)
{
    $registryPath = "registry::HKEY_USERS\$($sid)\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
    New-Item $registryPath -Force | Out-Null
    New-ItemProperty $registryPath -Name ProxyServer -Value 1 -Force | Out-Null
    New-ItemProperty $registryPath -Name ProxyEnable -Value 1 -Force | Out-Null
    New-ItemProperty "$registryPath\Connections" -Name DefaultConnectionSettings -Value 1 -Force | Out-Null
}

function Set-Proxy_func($proxy, $bypassUrls, $registryPath)
{
    $proxyBytes = [system.Text.Encoding]::ASCII.GetBytes($proxy)
    $bypassBytes = [system.Text.Encoding]::ASCII.GetBytes($bypassUrls)
    $defaultConnectionSettings = [byte[]]@(@(70,0,0,0,0,0,0,0,11,0,0,0,$proxyBytes.Length,0,0,0)+$proxyBytes+@($bypassBytes.Length,0,0,0)+$bypassBytes+ @(1..36 | % {0}))
    Set-ItemProperty -Path $registryPath -Name ProxyServer -Value $proxy
    Set-ItemProperty -Path $registryPath -Name ProxyEnable -Value 1
    Set-ItemProperty -Path "$registryPath\Connections" -Name DefaultConnectionSettings -Value $defaultConnectionSettings
    netsh winhttp set proxy $proxy bypass-list=$bypassUrls
}

function Refresh-System
{
    $signature = @'
    [DllImport("wininet.dll", SetLastError = true, CharSet=CharSet.Auto)]
    public static extern bool InternetSetOption(IntPtr hInternet, int dwOption, IntPtr lpBuffer, int dwBufferLength);
'@
    $INTERNET_OPTION_SETTINGS_CHANGED   = 39
    $INTERNET_OPTION_REFRESH            = 37
    $type = Add-Type -MemberDefinition $signature -Name wininet -Namespace pinvoke -PassThru
    $a = $type::InternetSetOption(0, $INTERNET_OPTION_SETTINGS_CHANGED, 0, 0)
    $b = $type::InternetSetOption(0, $INTERNET_OPTION_REFRESH, 0, 0)
    return $a -and $b
}


function Refresh-Environment
{
    if (! ("Win32.NativeMethods" -as [Type]))
    {
        Add-Type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
            [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
            public static extern IntPtr SendMessageTimeout( IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
"@
    }
    $HWND_BROADCAST = [IntPtr] 0xffff; $WM_SETTINGCHANGE = 0x1a; $result = [UIntPtr]::Zero
    [Win32.Nativemethods]::SendMessageTimeout($HWND_BROADCAST, $WM_SETTINGCHANGE, [UIntPtr]::Zero, "Environment", 2, 5000, [ref] $result) | out-null
}

function Set-Proxy 
{
    [CmdletBinding()]
    [Alias('proxy')]
    [OutputType([string])]
    Param
    (
        # server address
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
            $server,
        # port number
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 1)]
            $port
    )

    #Test if the TCP Port on the server is open before applying the settings
    If ((Test-NetConnection -ComputerName $server -Port $port).TcpTestSucceeded) 
    {
        Write-Host "Create new user"
        $Username = "AzDevOps"
        New-LocalUser -Name $Username -NoPassword
        Write-Host "Setting proxy"

        [Environment]::SetEnvironmentVariable("HTTP_PROXY", "http//$($server):$($port)", "Machine")
        [Environment]::SetEnvironmentVariable("HTTP_PROXY", "http//$($server):$($port)", "User")

        Refresh-Environment

        $registryPathCurrentUser = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
        $registryPathMachine_1 = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
        $registryPathMachine_2 = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings"
        $registryPathMachine_3 = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings"

        $sidProxyAdmin = (New-Object System.Security.Principal.NTAccount('proxyadmin')).Translate([System.Security.Principal.SecurityIdentifier]).Value
        $registryPathProxyAdmin = "registry::HKEY_USERS\$($sidProxyAdmin)\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
        $sidAzDevOps = (New-Object System.Security.Principal.NTAccount('AzDevOps')).Translate([System.Security.Principal.SecurityIdentifier]).Value
        $registryPathAzDevOps = "registry::HKEY_USERS\$($sidAzDevOps)\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

        Set-Proxy_func "$($server):$($port)" "" $registryPathCurrentUser
        Set-Proxy_func "$($server):$($port)" "" $registryPathMachine_1
        Set-Proxy_func "$($server):$($port)" "" $registryPathMachine_2
        Set-Proxy_func "$($server):$($port)" "" $registryPathMachine_3
        Set-Proxy_func "$($server):$($port)" "" $registryPathProxyAdmin
        #Set-Proxy_func "$($server):$($port)" "" $registryPathAzDevOps

        Refresh-System
        OpenCloseIE

        Get-Proxies #Show the configuration
        $user= [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        Write-Host "UserName: $user"
        $ProgressPreference = 'SilentlyContinue'
        New-Item -ItemType Directory -Force -Path C:/tmp
        Invoke-WebRequest -Uri "https://vstsagentpackage.azureedge.net/agent/2.198.3/vsts-agent-win-x64-2.198.3.zip" -OutFile "C:/tmp/vsts-agent-win-x64-2.198.3.zip"
    }
    Else 
    {
        Write-Error -Message "The proxy address is not valid:  $($server):$($port)"
    }

}

Set-Proxy 20.121.66.56 8889
