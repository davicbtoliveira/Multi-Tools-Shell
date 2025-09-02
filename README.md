# ⚙️ Multi Tools Shell v3.0
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)](https://docs.microsoft.com/powershell/)
[![Windows](https://img.shields.io/badge/Windows-10%2F11_or_Server_2016%2B-green?logo=windows)](https://www.microsoft.com/windows/)
---
🇧🇷 **Descrição (PT-BR)**
O **Multi Tools Shell** é uma poderosa ferramenta desenvolvida em **PowerShell** com o objetivo de **simplificar, acelerar e centralizar** atividades de administração em sistemas **Windows**.
Com uma **interface interativa de linha de comando**, o projeto foi pensado para técnicos de suporte, analistas de TI e usuários avançados que desejam um painel único com diagnósticos, automações e recursos integrados para manutenção, rede, segurança e performance do sistema.
A versão **3.0** traz melhorias significativas na usabilidade, mais módulos integrados, suporte para atualizações via `winget` e funcionalidades de backup e restauração do sistema.
---
## 🔧 Recursos Principais
- Diagnóstico rápido e completo de rede, sistema e hardware
- Informações detalhadas do computador e do usuário
- Testes de conectividade e verificação de adaptadores de rede
- Criação de pontos de restauração
- Limpeza de arquivos temporários e cache de navegadores
- Logs de eventos do sistema e aplicativos
- Otimização de inicialização e sistema com `CleanMgr`
- Backup de drivers e atualizações automáticas com `winget`
- Execução de comandos personalizados diretamente do script
- Tudo acessado por menu de navegação por teclas
---
## 🚀 Funcionalidades Detalhadas
### 🌐 Rede & Conectividade
- Mostra IP local e IP público com geolocalização
- `ping`, `tracert`, flush DNS, reset TCP/IP & Winsock
- Lista adaptadores de rede
### 💻 Sistema & Hardware
- Exibe nome do PC, nome do usuário, versão do Windows
- Detalha CPU, memória RAM total/disponível e espaço em disco
### 🔐 Usuários & Segurança
- Lista usuários locais, status (ativo/inativo), último login
- Acessa `lusrmgr.msc`, ativa/desativa firewall
- Cria pontos de restauração e exibe status da licença
### 📝 Monitoramento & Logs
- Mostra eventos recentes do sistema e logs de aplicativos
### 🧹 Otimização & Performance
- Limpeza de:
  - Pastas TEMP e Prefetch
  - Cache do Chrome e Edge
- Lista programas na inicialização
- Roda `cleanmgr` para limpeza avançada
### 🧠 Assistente de Diagnóstico
- Verifica:
  - Disco (`CHKDSK`)
  - Sistema (`SFC`)
  - Imagem do Windows (`DISM`)
- Roda:
  - Diagnóstico de memória
  - Benchmark de disco (`WinSAT`)
  - Relatório de energia (`powercfg /energy`)
### 🛠️ Manutenção Avançada
- Backup de drivers com `pnputil`
- Atualização de programas via `winget upgrade --all`
- Execução de comandos customizados (`CMD`)
- Acesso rápido ao Gerenciador de Tarefas e Restauração do Sistema
### 📖 Ajuda & Documentação
- Instruções embutidas por módulo
- Registro automático de logs
- Navegação simples e intuitiva
---
## 📋 Requisitos
- ✅ **PowerShell 5.1+**
- ✅ **Windows 10/11 ou Server 2016+**
- ⚠️ **Executar como Administrador**
---
## 🛠️ Instalação & Execução

```powershell
git clone https://github.com/Mandraquinho/Multi-Tools-Shell
cd Multi-Tools-Shell
PowerShell -ExecutionPolicy Bypass -File "MultiToolsShell.ps1"
Ou use o launcher .bat:

➡️ Clique com o botão direito em SysToolsLauncher.bat → Executar como administrador

🧭 Navegação por Teclas
Tecla	Módulo
R	Rede & Conectividade
S	Sistema & Hardware
U	Usuários & Segurança
M	Monitoramento & Logs
O	Otimização & Performance
D	Assistente de Diagnóstico
A	Manutenção Avançada
H	Ajuda & Documentação
X	Sair

🤝 Contribuições
Contribuições são bem-vindas!
Abra uma issue ou envie um pull request com melhorias, correções ou novos recursos.

👨‍💻 Créditos
👨‍🏫 Desenvolvido por: Douglas Furlan

🙋‍ Contribuições: Carlos Augusto

🔗 Links Oficiais
🧾 Repositório GitHub: github.com/Mandraquinho/Multi-Tools-Shell

💼 LinkedIn do Autor: Douglas Furlan

🌍 English Version
🇺🇸 Description (EN)
Multi Tools Shell is a powerful graphical PowerShell utility designed to simplify, accelerate, and centralize Windows system administration tasks.
With an interactive command-line menu, it was built for IT technicians, analysts, and power users looking for an all-in-one interface to perform diagnostics, cleanups, maintenance, and performance tuning.

Version 3.0 introduces major usability improvements, new integrated modules, winget software updating support, and driver backup tools.

🔧 Key Features
Quick network, system, and hardware diagnostics

Detailed info on the machine and user session

Connectivity tests and adapter checks

Restore point creation and firewall control

Temporary files and browser cache cleanup

Application and system event logs

Clean startup list and run CleanMgr utility

Driver backup and bulk updates with winget

Run custom CMD commands directly

All accessible via key-based navigation

🧭 Key Navigation
Key	Module
R	Network & Connectivity
S	System & Hardware
U	Users & Security
M	Monitoring & Logs
O	Optimization & Performance
D	Diagnostic Assistant
A	Advanced Maintenance
H	Help & Documentation
X	Exit

📦 Installation
bash
Copiar código
git clone https://github.com/Mandraquinho/Multi-Tools-Shell
cd Multi-Tools-Shell
PowerShell -ExecutionPolicy Bypass -File "MultiToolsShell.ps1"
Or run the .bat launcher as admin.

👨‍🏫 Developer: Douglas Furlan

🙋‍ Contributor: Carlos Augusto

🔗 Useful Links
🌐 GitHub Repo: github.com/Mandraquinho/Multi-Tools-Shell

💼 Author’s LinkedIn: Douglas Furlan
https://www.linkedin.com/in/douglasfurlans/