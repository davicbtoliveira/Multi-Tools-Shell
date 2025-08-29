UMulti Tools Shell - Versão 2.0

O Multi Tools Shell é uma ferramenta em PowerShell desenvolvida para simplificar e acelerar o diagnóstico e a manutenção de sistemas Windows.
Com uma interface de linha de comando prática, reúne funcionalidades essenciais para técnicos e usuários avançados, tornando o gerenciamento do sistema mais ágil e centralizado.

A versão 2.0 traz melhorias de estabilidade e novas funções integradas diretamente em seus módulos, mantendo o menu organizado e objetivo.

----------------------------------------------------
Módulos e Funcionalidades

Análise de Rede
- Exibe endereços IP local e público.
- Mostra a geolocalização do IP público (cidade, região e país).
- Executa testes de conectividade (ping, tracert, DNS).
- Redefine configurações de TCP/IP para corrigir falhas comuns.
- Novo (2.0): Acesso rápido a ferramentas de rede do Windows (ncpa.cpl e configurações avançadas).

Informações de Sistema e Hardware
- Apresenta detalhes do sistema operacional e do processador.
- Mostra uso de memória RAM e espaço em disco.
- Exibe informações de drivers e dispositivos conectados.
- Novo (2.0): Atalho direto para Gerenciamento de Disco e Gerenciador de Dispositivos.

Segurança e Usuários
- Lista usuários locais e seus status.
- Verifica atualizações do sistema.
- Gerencia contas locais (habilitar/desabilitar).
- Novo (2.0): Acesso direto ao Editor de Registro.
- Novo (2.0): Atalho para Gerenciamento de Serviços.

Monitoramento
- Exibe eventos recentes do sistema.
- Monitora desempenho de processos em tempo real.
- Gera relatórios de consumo de CPU, RAM e disco.
- Novo (2.0): Exporta logs de desempenho para análise posterior.

Otimização de Desempenho
- Limpa arquivos temporários e cache.
- Limpa diretórios de sistema como TEMP e Prefetch.
- Executa verificação de integridade do sistema (SFC/DISM).
- Novo (2.0): Atalho rápido para Liberador de Espaço em Disco.

Ferramentas de Suporte
- Executa diagnósticos detalhados de hardware.
- Prepara relatórios em HTML para análise.
- Coleta informações para suporte remoto.
- Novo (2.0): Backup rápido de pastas selecionadas.
- Novo (2.0): Atualização automática – busca e instala a versão mais recente no GitHub.

----------------------------------------------------
Como Utilizar

Pré-requisitos
- Sistema Operacional: Windows 10/11 ou Windows Server 2016+.
- PowerShell: versão 5.1 ou superior.
- Permissões: executar como Administrador.

Instalação e Execução
1. Baixe o arquivo MultiToolsShell.ps1.
2. Salve em uma pasta e abra o PowerShell como Administrador.
3. Navegue até a pasta com: cd "C:\caminho\da\pasta"
4. Execute: PowerShell -ExecutionPolicy Bypass -File "MultiToolsShell.ps1"

Navegação
- R → Rede e Conectividade
- S → Sistema e Hardware
- U → Usuários e Segurança
- M → Monitoramento e Logs
- O → Otimização
- T → Ferramentas de Suporte
- H → Ajuda
- X → Sair

----------------------------------------------------
Observações

- O projeto está em constante evolução, sujeito a melhorias e otimizações futuras.
- Contribuições e sugestões são bem-vindas.
