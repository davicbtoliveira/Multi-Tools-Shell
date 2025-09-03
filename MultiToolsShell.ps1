Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Formulário Principal
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Text = "MultiToolsShell v3.0"
$mainForm.Size = New-Object System.Drawing.Size(800, 600)
$mainForm.StartPosition = "CenterScreen"
$mainForm.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)
$mainForm.ForeColor = [System.Drawing.Color]::White
$mainForm.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Categorias
$categories = @(
    "Rede e Conectividade",
    "Sistema e Hardware",
    "Usuários e Segurança",
    "Monitoramento e Logs",
    "Otimização e Performance",
    "Assistente de Diagnóstico",
    "Manutenção Avançada",
    "Ajuda e Documentação",
    "Sair"
)

# Botões
$yPosition = 20
foreach ($category in $categories) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $category
    $btn.Size = New-Object System.Drawing.Size(200, 40)
    $btn.Location = New-Object System.Drawing.Point(20, $yPosition)
    $btn.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
    $btn.ForeColor = [System.Drawing.Color]::White
    $btn.FlatStyle = "Flat"
    $btn.Add_Click({ Button-Click $this.Text })
    $mainForm.Controls.Add($btn)
    $yPosition += 50
}

# Área de Texto para Output
$outputBox = New-Object System.Windows.Forms.RichTextBox
$outputBox.Location = New-Object System.Drawing.Point(250, 20)
$outputBox.Size = New-Object System.Drawing.Size(520, 520)
$outputBox.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$outputBox.ForeColor = [System.Drawing.Color]::LightGreen
$outputBox.Font = New-Object System.Drawing.Font("Consolas", 9)
$outputBox.ReadOnly = $true
$mainForm.Controls.Add($outputBox)

# Label de Status
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Location = New-Object System.Drawing.Point(20, 450)
$statusLabel.Size = New-Object System.Drawing.Size(200, 50)
$statusLabel.Text = "Pronto..."
$mainForm.Controls.Add($statusLabel)

# Inicializa o log
$logFile = "MultiToolsShell_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
function Write-Log {
    param($Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $logFile -Append
}

# Função para atualizar status
function Update-Status {
    param($text)
    $statusLabel.Text = $text
    $mainForm.Refresh()
}

# Função para mostrar output
function Write-OutputBox {
    param($text)
    $outputBox.AppendText("$text`r`n")
    $outputBox.ScrollToCaret()
}

# Verifica privilégios administrativos
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Função chamada quando botão é clicado
function Button-Click {
    param($buttonText)
    $outputBox.Clear()
    Update-Status "Executando: $buttonText"
    
    try {
        switch ($buttonText) {
            "Rede e Conectividade" { Show-NetworkMenu }
            "Sistema e Hardware" { Get-SystemInfo }
            "Usuários e Segurança" { Get-UserInfo }
            "Monitoramento e Logs" { Get-Logs }
            "Otimização e Performance" { Show-OptimizationMenu }
            "Assistente de Diagnóstico" { Show-DiagnosticMenu }
            "Manutenção Avançada" { Show-MaintenanceMenu }
            "Ajuda e Documentação" { Show-Help }
            "Sair" { $mainForm.Close() }
        }
    } catch {
        Write-OutputBox "Erro: $_"
        Write-Log "Erro na execução de ${buttonText}: $_"
    }
    Update-Status "Pronto..."
}

# Funções de Submenu (usando formulários modais)
function Show-SubMenu {
    param($title, $options, $actionMap)
    $subForm = New-Object System.Windows.Forms.Form
    $subForm.Text = $title
    $subForm.Size = New-Object System.Drawing.Size(400, 400)
    $subForm.StartPosition = "CenterParent"
    $subForm.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)
    $subForm.ForeColor = [System.Drawing.Color]::White
    $yPosition = 20
    foreach ($option in $options) {
        $btn = New-Object System.Windows.Forms.Button
        $btn.Text = $option
        $btn.Size = New-Object System.Drawing.Size(350, 40)
        $btn.Location = New-Object System.Drawing.Point(20, $yPosition)
        $btn.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
        $btn.ForeColor = [System.Drawing.Color]::White
        $btn.FlatStyle = "Flat"
        $btn.Add_Click({ 
            $action = $actionMap[$this.Text]
            if ($action) { &$action }
            $subForm.Close()
        })
        $subForm.Controls.Add($btn)
        $yPosition += 50
    }
    $subForm.ShowDialog()
}

# Rede e Conectividade
function Show-NetworkMenu {
    $options = @(
        "Mostrar Configuração IP",
        "Testar Conectividade (Ping google.com)",
        "Rastrear Rota (Tracert google.com)",
        "Testar Rede EBA (Ping 10.67.6.32)",
        "Redefinir TCP/IP",
        "Redefinir Winsock",
        "Limpar Cache DNS",
        "Listar Adaptadores de Rede",
        "Testar Conectividade (Ping 8.8.8.8)",
        "Voltar"
    )
    $actionMap = @{
        "Mostrar Configuração IP" = { Get-NetworkInfo }
        "Testar Conectividade (Ping google.com)" = { Test-PingGoogle }
        "Rastrear Rota (Tracert google.com)" = { Test-Tracert }
        "Testar Rede EBA (Ping 10.67.6.32)" = { Test-Rede }
        "Redefinir TCP/IP" = { Reset-TCPIP }
        "Redefinir Winsock" = { Reset-Winsock }
        "Limpar Cache DNS" = { Clear-DNSCache }
        "Listar Adaptadores de Rede" = { Get-NetAdapters }
        "Testar Conectividade (Ping 8.8.8.8)" = { Test-PingPublic }
        "Voltar" = { }
    }
    Show-SubMenu "Rede e Conectividade" $options $actionMap
}

function Get-NetworkInfo {
    Write-OutputBox "=== CONFIGURAÇÃO DE REDE ==="
    $ipLocal = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1' } | Select-Object -First 1 -ExpandProperty IPAddress)
    Write-OutputBox "IP Local: $ipLocal"
    try {
        $publicInfo = Invoke-RestMethod -Uri "https://ipinfo.io/json"
        Write-OutputBox "IP Público: $($publicInfo.ip)"
        Write-OutputBox "Geo Local: $($publicInfo.city), $($publicInfo.region), $($publicInfo.country)"
        Write-Log "IP público obtido: $($publicInfo.ip)"
    } catch {
        Write-OutputBox "IP Público: Não disponível"
        Write-Log "Erro ao obter IP público: $_"
    }
    Write-Log "Configuração de rede exibida."
}

function Test-PingGoogle {
    Write-OutputBox "=== TESTE DE CONECTIVIDADE (PING GOOGLE.COM) ==="
    $result = Test-Connection google.com -Count 4 -ErrorAction Stop
    Write-OutputBox ($result | Format-Table -AutoSize | Out-String)
    Write-Log "Teste de conectividade (ping google.com) executado."
}

function Test-Tracert {
    Write-OutputBox "=== RASTREAMENTO DE ROTA (TRACERT GOOGLE.COM) ==="
    $result = tracert google.com
    Write-OutputBox ($result | Out-String)
    Write-Log "Rastreamento de rota (tracert) executado."
}

function Test-Rede {
    Write-OutputBox "=== TESTE DE REDE EBA (PING 10.67.6.32) ==="
    $result = Test-Connection 10.67.6.32 -Count 4 -ErrorAction Stop
    Write-OutputBox ($result | Format-Table -AutoSize | Out-String)
    Write-Log "Teste de rede (ping 10.67.6.32) executado."
}

function Reset-TCPIP {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    netsh int ip reset
    Write-OutputBox "TCP/IP redefinido. Reinicie o computador."
    Write-Log "TCP/IP redefinido."
}

function Reset-Winsock {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    netsh winsock reset
    Write-OutputBox "Winsock redefinido. Reinicie o computador."
    Write-Log "Winsock redefinido."
}

function Clear-DNSCache {
    ipconfig /flushdns
    Write-OutputBox "Cache DNS limpo."
    Write-Log "Cache DNS limpo."
}

function Get-NetAdapters {
    Write-OutputBox "=== ADAPTADORES DE REDE ==="
    $adapters = Get-NetAdapter | Select-Object Name, Status, MacAddress
    Write-OutputBox ($adapters | Format-Table -AutoSize | Out-String)
    Write-Log "Adaptadores de rede listados."
}

function Test-PingPublic {
    Write-OutputBox "=== TESTE DE CONECTIVIDADE (PING 8.8.8.8) ==="
    $result = Test-Connection 8.8.8.8 -Count 5 -ErrorAction Stop
    Write-OutputBox ($result | Format-Table -AutoSize | Out-String)
    Write-Log "Teste de conectividade (ping 8.8.8.8) executado."
}

# Sistema e Hardware
function Get-SystemInfo {
    Write-OutputBox "=== INFORMAÇÕES DO SISTEMA ==="
    Write-OutputBox "Computador: $env:COMPUTERNAME"
    Write-OutputBox "Usuário: $env:USERNAME"
    Write-OutputBox "SO: $((Get-CimInstance Win32_OperatingSystem).Caption)"
    Write-OutputBox "Processador: $((Get-CimInstance Win32_Processor).Name)"
    $memGB = [math]::Round(((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB), 2)
    Write-OutputBox "Memória Total: $memGB GB"
    $ramFreeMB = [math]::Round(((Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1KB), 2)
    Write-OutputBox "RAM Livre: $ramFreeMB MB"
    $disk = Get-PSDrive C -ErrorAction SilentlyContinue
    if ($disk) {
        $freeGB = [math]::Round(($disk.Free / 1GB), 2)
        $totalGB = [math]::Round(($disk.Used + $disk.Free) / 1GB, 2)
        Write-OutputBox "Disco C: $freeGB GB livres / $totalGB GB total"
    }
    Write-Log "Informações de sistema e hardware exibidas."
}

# Usuários e Segurança
function Get-UserInfo {
    Write-OutputBox "=== USUÁRIOS LOCAIS ==="
    $users = Get-LocalUser | Select-Object Name, Enabled, @{Name="LastLogon"; Expression={if($_.LastLogon) {$_.LastLogon.ToString("dd/MM/yyyy")} else {"Nunca"}}}
    foreach ($user in $users) {
        $status = if ($user.Enabled) {"Ativo"} else {"Desativado"}
        Write-OutputBox "$($user.Name) - $status - Último logon: $($user.LastLogon)"
    }
    Write-Log "Lista de usuários locais exibida."
}

# Monitoramento e Logs
function Get-Logs {
    Write-OutputBox "=== ÚLTIMOS EVENTOS DO SISTEMA ==="
    $events = Get-EventLog -LogName System -Newest 5 -ErrorAction Stop
    foreach ($event in $events) {
        Write-OutputBox "$($event.TimeGenerated.ToString('dd/MM HH:mm')) - $($event.EntryType) - $($event.Source)"
    }
    Write-Log "Últimos eventos do sistema exibidos."
}

# Otimização e Performance
function Show-OptimizationMenu {
    $options = @(
        "Limpar Arquivos Temporários",
        "Limpar Cache de Navegadores",
        "Listar Programas na Inicialização",
        "Voltar"
    )
    $actionMap = @{
        "Limpar Arquivos Temporários" = { Clear-TempFiles }
        "Limpar Cache de Navegadores" = { Clear-BrowserCache }
        "Listar Programas na Inicialização" = { Get-StartupPrograms }
        "Voltar" = { }
    }
    Show-SubMenu "Otimização e Performance" $options $actionMap
}

function Clear-TempFiles {
    $paths = @("$env:TEMP\*", "$env:SystemRoot\Prefetch\*")
    foreach ($p in $paths) { Remove-Item -Path $p -Recurse -Force -ErrorAction SilentlyContinue }
    Write-OutputBox "Arquivos temporários limpos."
    Write-Log "Arquivos temporários limpos."
}

function Clear-BrowserCache {
    $chromeCache = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*"
    $edgeCache = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*"
    Remove-Item $chromeCache,$edgeCache -Recurse -Force -ErrorAction SilentlyContinue
    Write-OutputBox "Cache do Chrome/Edge limpo."
    Write-Log "Cache do Chrome/Edge limpo."
}

function Get-StartupPrograms {
    Write-OutputBox "=== PROGRAMAS NA INICIALIZAÇÃO ==="
    $startups = Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location
    Write-OutputBox ($startups | Format-Table -AutoSize | Out-String)
    Write-Log "Programas na inicialização listados."
}

# Assistente de Diagnóstico
function Show-DiagnosticMenu {
    $options = @(
        "Verificar Disco (CHKDSK)",
        "Verificar Arquivos do Sistema (SFC)",
        "Diagnóstico de Memória",
        "Verificar Integridade da Imagem (DISM)",
        "Otimizar Disco (TRIM para SSD ou Desfragmentação para HDD)",
        "Testar Velocidade do Disco (WinSAT)",
        "Relatório de Energia",
        "Logs de Aplicativos",
        "Status Licença do Windows",
        "Voltar"
    )
    $actionMap = @{
        "Verificar Disco (CHKDSK)" = { Run-CHKDSK }
        "Verificar Arquivos do Sistema (SFC)" = { Run-SFC }
        "Diagnóstico de Memória" = { Run-MemoryDiagnostic }
        "Verificar Integridade da Imagem (DISM)" = { Run-DISM }
        "Otimizar Disco (TRIM para SSD ou Desfragmentação para HDD)" = { Optimize-Disk }
        "Testar Velocidade do Disco (WinSAT)" = { Run-WinSAT }
        "Relatório de Energia" = { Run-PowerReport }
        "Logs de Aplicativos" = { Get-AppLogs }
        "Status Licença do Windows" = { Get-LicenseStatus }
        "Voltar" = { }
    }
    Show-SubMenu "Assistente de Diagnóstico" $options $actionMap
}

function Run-CHKDSK {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    $result = chkdsk C: /f
    Write-OutputBox ($result | Out-String)
    Write-Log "CHKDSK executado."
}

function Run-SFC {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    $result = sfc /scannow
    Write-OutputBox ($result | Out-String)
    Write-Log "SFC executado."
}

function Run-MemoryDiagnostic {
    Start-Process mdsched
    Write-OutputBox "Diagnóstico de memória iniciado."
    Write-Log "Diagnóstico de memória iniciado."
}

function Run-DISM {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    $result = DISM /Online /Cleanup-Image /ScanHealth
    Write-OutputBox ($result | Out-String)
    Write-Log "DISM ScanHealth executado."
}

function Optimize-Disk {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    $disk = Get-PhysicalDisk | Where-Object { $_.DeviceID -eq (Get-Partition -DriveLetter C).DiskNumber }
    if ($disk.MediaType -eq "SSD") {
        Write-OutputBox "Disco C: é um SSD. Executando TRIM..."
        $result = defrag C: /L
        Write-OutputBox ($result | Out-String)
        Write-OutputBox "TRIM executado com sucesso."
        Write-Log "TRIM executado no disco C: (SSD)."
    } else {
        Write-OutputBox "Disco C: é um HDD. Executando desfragmentação..."
        $result = defrag C:
        Write-OutputBox ($result | Out-String)
        Write-OutputBox "Desfragmentação concluída."
        Write-Log "Desfragmentação executada no disco C: (HDD)."
    }
}

function Run-WinSAT {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    $result = winsat disk
    Write-OutputBox ($result | Out-String)
    Write-Log "Teste de velocidade do disco (WinSAT) executado."
}

function Run-PowerReport {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    powercfg /energy
    Write-OutputBox "Relatório gerado em C:\Windows\System32\energy-report.html"
    Write-Log "Relatório de energia gerado."
}

function Get-AppLogs {
    Write-OutputBox "=== LOGS DE APLICATIVOS ==="
    $events = Get-EventLog -LogName Application -Newest 10
    Write-OutputBox ($events | Format-Table TimeGenerated, EntryType, Source, Message -AutoSize | Out-String)
    Write-Log "Logs de aplicativos exibidos."
}

function Get-LicenseStatus {
    $result = slmgr /xpr
    Write-OutputBox ($result | Out-String)
    Write-Log "Status da licença do Windows exibido."
}

# Manutenção Avançada
function Show-MaintenanceMenu {
    $options = @(
        "Limpar Arquivos Temporários (CleanMgr)",
        "Restaurar Sistema",
        "Gerenciar Processos (Task Manager)",
        "Backup de Drivers",
        "Verificar Atualizações do Windows",
        "Gerenciar Usuários Locais",
        "Ativar/Desativar Firewall",
        "Criar Ponto de Restauração",
        "Executar Comando Personalizado (CMD)",
        "Atualizar Todos os Programas (Winget)",
        "Voltar"
    )
    $actionMap = @{
        "Limpar Arquivos Temporários (CleanMgr)" = { Run-CleanMgr }
        "Restaurar Sistema" = { Run-Restore }
        "Gerenciar Processos (Task Manager)" = { Run-TaskManager }
        "Backup de Drivers" = { Backup-Drivers }
        "Verificar Atualizações do Windows" = { Check-WindowsUpdates }
        "Gerenciar Usuários Locais" = { Run-UserManager }
        "Ativar/Desativar Firewall" = { Manage-Firewall }
        "Criar Ponto de Restauração" = { Create-RestorePoint }
        "Executar Comando Personalizado (CMD)" = { Run-CustomCMD }
        "Atualizar Todos os Programas (Winget)" = { Update-Winget }
        "Voltar" = { }
    }
    Show-SubMenu "Manutenção Avançada" $options $actionMap
}

function Run-CleanMgr {
    Start-Process cleanmgr -ArgumentList "/sagerun:1"
    Write-OutputBox "Limpeza de arquivos temporários iniciada."
    Write-Log "Limpeza de arquivos temporários (CleanMgr) iniciada."
}

function Run-Restore {
    Start-Process rstrui
    Write-OutputBox "Restauração do sistema iniciada."
    Write-Log "Restauração do sistema iniciada."
}

function Run-TaskManager {
    Start-Process taskmgr
    Write-OutputBox "Gerenciador de tarefas iniciado."
    Write-Log "Gerenciador de tarefas iniciado."
}

function Backup-Drivers {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    Write-OutputBox "Iniciando backup de drivers com pnputil..."
    Start-Process pnputil -ArgumentList "/export-driver * $env:USERPROFILE\Desktop\DriverBackup"
    Write-OutputBox "Drivers exportados para $env:USERPROFILE\Desktop\DriverBackup"
    Write-Log "Backup de drivers executado."
}

function Check-WindowsUpdates {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    Write-OutputBox "Verificando atualizações do Windows..."
    $result = Get-WindowsUpdateLog
    Write-OutputBox ($result | Out-String)
    Write-Log "Log de atualizações do Windows gerado."
}

function Run-UserManager {
    Start-Process lusrmgr.msc
    Write-OutputBox "Gerenciador de usuários locais iniciado."
    Write-Log "Gerenciador de usuários locais iniciado."
}

function Manage-Firewall {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    $subForm = New-Object System.Windows.Forms.Form
    $subForm.Text = "Gerenciar Firewall"
    $subForm.Size = New-Object System.Drawing.Size(300, 200)
    $subForm.StartPosition = "CenterParent"
    $subForm.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)
    $subForm.ForeColor = [System.Drawing.Color]::White

    $btnEnable = New-Object System.Windows.Forms.Button
    $btnEnable.Text = "Ativar Firewall"
    $btnEnable.Size = New-Object System.Drawing.Size(250, 40)
    $btnEnable.Location = New-Object System.Drawing.Point(20, 20)
    $btnEnable.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
    $btnEnable.ForeColor = [System.Drawing.Color]::White
    $btnEnable.FlatStyle = "Flat"
    $btnEnable.Add_Click({
        netsh advfirewall set allprofiles state on
        Write-OutputBox "Firewall ativado."
        Write-Log "Firewall ativado."
        $subForm.Close()
    })
    $subForm.Controls.Add($btnEnable)

    $btnDisable = New-Object System.Windows.Forms.Button
    $btnDisable.Text = "Desativar Firewall"
    $btnDisable.Size = New-Object System.Drawing.Size(250, 40)
    $btnDisable.Location = New-Object System.Drawing.Point(20, 70)
    $btnDisable.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
    $btnDisable.ForeColor = [System.Drawing.Color]::White
    $btnDisable.FlatStyle = "Flat"
    $btnDisable.Add_Click({
        netsh advfirewall set allprofiles state off
        Write-OutputBox "Firewall desativado."
        Write-Log "Firewall desativado."
        $subForm.Close()
    })
    $subForm.Controls.Add($btnDisable)

    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Text = "Cancelar"
    $btnCancel.Size = New-Object System.Drawing.Size(250, 40)
    $btnCancel.Location = New-Object System.Drawing.Point(20, 120)
    $btnCancel.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
    $btnCancel.ForeColor = [System.Drawing.Color]::White
    $btnCancel.FlatStyle = "Flat"
    $btnCancel.Add_Click({ $subForm.Close() })
    $subForm.Controls.Add($btnCancel)

    $subForm.ShowDialog()
}

function Create-RestorePoint {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    Checkpoint-Computer -Description "Ponto de Restauração Manual"
    Write-OutputBox "Ponto de restauração criado."
    Write-Log "Ponto de restauração criado."
}

function Run-CustomCMD {
    Start-Process cmd
    Write-OutputBox "Prompt de comando personalizado iniciado."
    Write-Log "Prompt de comando personalizado iniciado."
}

function Update-Winget {
    if (-not (Test-Admin)) { throw "Permissões administrativas necessárias." }
    $result = winget update --all
    Write-OutputBox ($result | Out-String)
    Write-Log "Atualização de programas via winget executada."
}

# Ajuda e Documentação
function Show-Help {
    Write-OutputBox "=== AJUDA E DOCUMENTAÇÃO ==="
    Write-OutputBox "Ferramenta de administração e suporte técnico para sistemas Windows."
    Write-OutputBox "Selecione uma categoria à esquerda para executar ações."
    Write-OutputBox "Nota: A otimização de disco usa TRIM para SSDs e desfragmentação para HDDs."
    Write-OutputBox "Data: $(Get-Date -Format 'dd/MM/yyyy')"
    Write-Log "Ajuda exibida."
}

# Verifica privilégios administrativos
if (-not (Test-Admin)) {
    [System.Windows.Forms.MessageBox]::Show("Este programa requer privilégios administrativos. Execute como administrador.", "Erro", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    Write-Log "Script encerrado: privilégios administrativos insuficientes."
    exit
}

# Iniciar a interface
Write-OutputBox "=== MULTITOOLSSHELL v3.0 ==="
Write-OutputBox "Data: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
Write-OutputBox "=================================`n"
Write-OutputBox "Selecione uma opção no menu à esquerda"
Write-Log "Script iniciado."

$mainForm.ShowDialog()