Invoke-Expression (&starship init powershell)

Invoke-Expression (& { (zoxide init powershell | Out-String) })


Remove-Item Alias:\cd
Set-Alias cd z

Remove-Item Alias:\ls
Set-Alias ls eza

Set-Alias vi nvim
Set-Alias vim nvim

Set-Alias lzg lazygit


function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

function Set-HttpProxy {
    param (
        [ValidateSet("on", "off")]
        [string]$Mode = "on",

        [string]$ProxyHost = "127.0.0.1",
        [int]$Port = 10808
    )

    if ($Mode -eq "on") {
        $proxyUrl = "http://${ProxyHost}:${Port}"
        Write-Host "启用 HTTP 代理: $proxyUrl"

        # 设置当前 PowerShell 环境变量（curl、pip、npm 等有效）
        $env:HTTP_PROXY  = $proxyUrl
        $env:HTTPS_PROXY = $proxyUrl

        # 设置系统级代理（winget、IE、部分 WinAPI 应用生效）
        netsh winhttp set proxy "${ProxyHost}:${Port}" | Out-Null
    }
    else {
        Write-Host "关闭代理"

        Remove-Item Env:HTTP_PROXY  -ErrorAction SilentlyContinue
        Remove-Item Env:HTTPS_PROXY -ErrorAction SilentlyContinue

        netsh winhttp reset proxy | Out-Null
    }

    Write-Host "`n当前 winhttp 状态："
    netsh winhttp show proxy
}


