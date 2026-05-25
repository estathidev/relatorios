import os
from github import Github
from datetime import datetime, timedelta
import sys # Importa o módulo sys para sys.exit()

# --- Configurações ---
# Seu token de acesso pessoal do GitHub (PAT)
# É ALTAMENTE RECOMENDADO USAR VARIÁVEIS DE AMBIENTE para tokens!
# Ex: export GITHUB_TOKEN="seu_token_aqui" (no seu terminal)
GITHUB_TOKEN = os.getenv("GITHUB_TOKEN")

# Seu nome de usuário do GitHub
GITHUB_USERNAME = "estathidev"

# Nome da organização do GitHub
GITHUB_ORG_NAME = "SolutionIPD"

# Mês e ano para a busca (Abril de 2026)
MES_ANO = "2026-04"

# Diretório onde os relatórios de commits serão salvos
OUTPUT_DIR = "/home/thiago/relatorios/auto_avaliacoes/Autoavaliacao_2026_04/dados_brutos"

# --- Lógica do Script ---

if not GITHUB_TOKEN:
    print("Erro: GITHUB_TOKEN não encontrado.")
    print("Por favor, defina a variável de ambiente GITHUB_TOKEN ou insira seu token diretamente no script (não recomendado para produção).")
    sys.exit(1) # Usa sys.exit() para uma saída limpa

# Inicializa a conexão com o GitHub
g = Github(GITHUB_TOKEN)

# Garante que o diretório de saída exista
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Calcula o primeiro e último dia do mês
primeiro_dia_str = f"{MES_ANO}-01"
primeiro_dia = datetime.strptime(primeiro_dia_str, "%Y-%m-%d")
ultimo_dia = primeiro_dia + timedelta(days=31) # Garante que pegue o mês inteiro
ultimo_dia = ultimo_dia.replace(day=1) - timedelta(days=1) # Ajusta para o último dia do mês

print(f"Coletando commits de '{GITHUB_USERNAME}' na organização '{GITHUB_ORG_NAME}' para o período de {primeiro_dia.strftime('%Y-%m-%d')} a {ultimo_dia.strftime('%Y-%m-%d')}...")
print("--------------------------------------------------")

try:
    org = g.get_organization(GITHUB_ORG_NAME)
    repos = org.get_repos()

    total_commits_found = 0
    projects_with_commits = 0

    for repo in repos:
        repo_name = repo.name
        output_file = os.path.join(OUTPUT_DIR, f"commits_{repo_name}.txt")
        
        print(f"Processando repositório: {repo_name}")
        
        repo_commits = []
        # Busca commits do autor dentro do período especificado
        # A API do GitHub pode ter limites de paginação, este loop tenta buscar todos.
        for commit in repo.get_commits(author=GITHUB_USERNAME, since=primeiro_dia, until=ultimo_dia):
            repo_commits.append(f"{commit.sha[:7]} - {commit.commit.author.date.strftime('%Y-%m-%d')} | {commit.commit.message.splitlines()[0]}")

        if repo_commits:
            with open(output_file, 'w', encoding='utf-8') as f:
                for commit_line in repo_commits:
                    f.write(commit_line + '\n')
            print(f"  -> {len(repo_commits)} commits salvos em: {output_file}")
            total_commits_found += len(repo_commits)
            projects_with_commits += 1
        else:
            print("  -> Nenhum commit encontrado.")

    print("--------------------------------------------------")
    print(f"Processo de coleta de commits concluído.")
    print(f"Total de commits encontrados: {total_commits_found}")
    print(f"Total de projetos com commits: {projects_with_commits}")
    print(f"Os arquivos estão em: {OUTPUT_DIR}")

except Exception as e:
    print(f"Ocorreu um erro: {e}")
    print("Verifique se seu GITHUB_TOKEN tem as permissões corretas (repo, read:org) e se o nome da organização está correto.")