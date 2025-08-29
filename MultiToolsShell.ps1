# MultiToolsShell.ps1
# Ferramenta Multi Tools Shell v1.0 - PowerShell
# Criado por: Mandraquinho - By Douglas Furlan

function Show-Credits {
    Clear-Host
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "         MultiTools Shell v1.0" -ForegroundColor Cyan
    Write-Host "          Criado por: Mandraquinho" -ForegroundColor Cyan
    Write-Host "            By Douglas Furlan" -ForegroundColor Cyan
    Write-Host "            Data: $(Get-Date -Format 'dd/MM/yyyy')" -ForegroundColor Cyan
    Write-Host "=============================================`n" -ForegroundColor Cyan
    Start-Sleep -Seconds 3
}

function Get-PublicIPAndGeo {
    try {
        $response = Invoke-RestMethod -Uri "https://ipinfo.io/json" -ErrorAction Stop
        return @{
            PublicIP = $response.ip
            Location = $response.city + ", " + $response.region + ", " + $response.country
        }
    }
    catch {
        return @{
            PublicIP = "Não disponível"
            Location = "Não disponível"
        }
    }
}

function Show-SystemStatus {
    Clear-Host
    Write-Host "==================== STATUS DO SISTEMA ====================" -ForegroundColor Cyan
    Write-Host "Computador : $env:COMPUTERNAME"
    Write-Host "Usuário    : $env:USERNAME"
    
    # IP local, pega o primeiro válido
    $ipLocal = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
        $_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1'
    } | Select-Object -First 1 -ExpandProperty IPAddress)
    if (-not $ipLocal) { $ipLocal = "Não disponível" }
    Write-Host "IP Local   : $ipLocal"

    # IP público e localização via API
    $publicInfo = Get-PublicIPAndGeo
    Write-Host "IP Público : $($publicInfo.PublicIP)"
    Write-Host "Geo Local  : $($publicInfo.Location)"

    Write-Host "Sistema    : $((Get-CimInstance Win32_OperatingSystem).Caption)"
    
    $ramFreeMB = [math]::Round(((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1KB),2)
    Write-Host "RAM Livre  : $ramFreeMB MB"

    $disk = Get-PSDrive C
    $freeGB = [math]::Round(($disk.Free/1GB),2)
    $totalGB = [math]::Round(($disk.Used + $disk.Free)/1GB,2)
    Write-Host "Disco C:   $freeGB GB livres / $totalGB GB total"

    Write-Host "Data/Hora  : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
    Write-Host "=============================================================`n"
}

function Show-Menu {
    Write-Host "===================== MENU PRINCIPAL =======================" -ForegroundColor Green
    Write-Host "[R] Rede e Conectividade"
    Write-Host "[S] Sistema e Hardware"
    Write-Host "[U] Usuários e Segurança"
    Write-Host "[M] Monitoramento e Logs"
    Write-Host "[O] Otimização e Performance"
    Write-Host "[T] Ferramentas Avançadas"
    Write-Host "[H] Ajuda e Documentação"
    Write-Host "[X] Sair"
    Write-Host "=============================================================`n"
    Write-Host "Digite a letra da categoria desejada:" -NoNewline
}

function Rede-Conectividade {
    Clear-Host
    Write-Host "=== Rede e Conectividade ===`n" -ForegroundColor Yellow
    Write-Host "1. Mostrar Configuração IP"
    Write-Host "2. Testar Conectividade (ping google.com)"
    Write-Host "3. Redefinir TCP/IP"
    Write-Host "0. Voltar"
    Write-Host "`nEscolha uma opção:" -NoNewline

    $input = Read-Host
    switch ($input) {
        '1' {
            Write-Host "`nConfiguração IP atual:`n"
            ipconfig
            Pause
            Rede-Conectividade
        }
        '2' {
            Write-Host "`nTestando conectividade com google.com...`n"
            Test-Connection google.com -Count 4
            Pause
            Rede-Conectividade
        }
        '3' {
            Write-Host "`nRedefinindo configurações TCP/IP...`n"
            netsh int ip reset
            Write-Host "Reinicie o computador para aplicar as mudanças."
            Pause
            Rede-Conectividade
        }
        '0' { return }
        default {
            Write-Host "Opção inválida!" -ForegroundColor Red
            Start-Sleep -Seconds 1.5
            Rede-Conectividade
        }
    }
}

function Sistema-Hardware {
    Clear-Host
    Write-Host "=== Sistema e Hardware ===`n" -ForegroundColor Yellow
    Write-Host "Sistema Operacional: $((Get-CimInstance Win32_OperatingSystem).Caption)"
    Write-Host "Versão do SO: $((Get-CimInstance Win32_OperatingSystem).Version)"
    Write-Host "Processador: $((Get-CimInstance Win32_Processor).Name)"
    $memTotalMB = [math]::Round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB),2)
    Write-Host "Memória Total (MB): $memTotalMB"
    $freeDiskGB = [math]::Round((Get-PSDrive C).Free/1GB,2)
    Write-Host "Espaço livre em C: $freeDiskGB GB"
    Pause
}

function Usuarios-Seguranca {
    Clear-Host
    Write-Host "=== Usuários e Segurança ===`n" -ForegroundColor Yellow
    Write-Host "Usuários locais:`n"
    Get-LocalUser | Format-Table Name, Enabled
    Pause
}

function Monitoramento-Logs {
    Clear-Host
    Write-Host "=== Monitoramento e Logs ===`n" -ForegroundColor Yellow
    Write-Host "Eventos recentes do sistema:`n"
    Get-EventLog -LogName System -Newest 10 | Format-Table TimeGenerated, EntryType, Source, Message -AutoSize
    Pause
}

function Otimizacao-Performance {
    Clear-Host
    Write-Host "=== Otimização e Performance ===`n" -ForegroundColor Yellow
    Write-Host "Limpando arquivos temporários..."
    # Limpar %TEMP%, $env:TEMP e Prefetch
    $paths = @(
        "$env:TEMP\*",
        "$env:SystemRoot\Prefetch\*"
    )
    foreach ($path in $paths) {
        Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Arquivos temporários limpos."
    Pause
}

function Ferramentas-Avancadas {
    Clear-Host
    Write-Host "=== Ferramentas Avançadas ===`n" -ForegroundColor Yellow
    Write-Host "1. Verificar atualizações do Windows"
    Write-Host "2. Verificar integridade do sistema (sfc /scannow)"
    Write-Host "0. Voltar"
    Write-Host "`nEscolha uma opção:" -NoNewline
    $opt = Read-Host
    switch ($opt) {
        '1' {
            Write-Host "`nBuscando atualizações do Windows..."
            if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
                Import-Module PSWindowsUpdate
                Get-WindowsUpdate
            } else {
                Write-Host "Módulo PSWindowsUpdate não instalado. Rode 'Install-Module PSWindowsUpdate' para instalar."
            }
            Pause
            Ferramentas-Avancadas
        }
        '2' {
            Write-Host "`nVerificando integridade do sistema (sfc /scannow)..."
            sfc /scannow
            Pause
            Ferramentas-Avancadas
        }
        '0' { return }
        default {
            Write-Host "Opção inválida!" -ForegroundColor Red
            Start-Sleep -Seconds 1.5
            Ferramentas-Avancadas
        }
    }
}

function Show-Help {
    Clear-Host
    Write-Host "=== Ajuda e Documentação ===`n" -ForegroundColor Yellow
    Write-Host "Use as letras indicadas para navegar entre as categorias."
    Write-Host "Exemplo: Digite 'R' para Rede e Conectividade."
    Write-Host "Pressione X para sair."
    Pause
}

function Pause {
    Write-Host "`nPressione Enter para continuar..." -NoNewline
    [void][System.Console]::ReadKey($true)
}

# Programa principal

Show-Credits

while ($true) {
    Show-SystemStatus
    Show-Menu

    $choice = Read-Host
    switch ($choice.ToUpper()) {
        'R' { Rede-Conectividade }
        'S' { Sistema-Hardware }
        'U' { Usuarios-Seguranca }
        'M' { Monitoramento-Logs }
        'O' { Otimizacao-Performance }
        'T' { Ferramentas-Avancadas }
        'H' { Show-Help }
        'X' { break }
        default {
            Write-Host "Opção inválida! Tente novamente." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}

Write-Host "`nSaindo do programa. Até mais!" -ForegroundColor Green
