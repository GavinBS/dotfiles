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

function excel {
    param (
        [string]$Path
    )
    $excelPath = "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
    if (Test-Path $excelPath) {
        Start-Process $excelPath -ArgumentList $Path
    } else {
        Write-Error "找不到 EXCEL.EXE，请检查路径。"
    }
}


function Set-Proxy {
    $Env:http_proxy = "http://127.0.0.1:10808"
    $Env:https_proxy = "http://127.0.0.1:10808"
    Write-Host "代理已设置为 http://127.0.0.1:10808"
}

function Unset-Proxy {
    Remove-Item Env:http_proxy -ErrorAction SilentlyContinue
    Remove-Item Env:https_proxy -ErrorAction SilentlyContinue
    Write-Host "代理已取消"
}


