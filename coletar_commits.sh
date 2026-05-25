#!/bin/bash

# --- Configurações ---
# Usuário do Git para filtrar os commits
GIT_AUTHOR="estathidev"
# Mês para a busca (formato YYYY-MM)
MES_ANO="2026-04"
# Diretório onde os relatórios de commits serão salvos
OUTPUT_DIR="/home/thiago/relatorios/Autoavaliacao_2026_04/dados_brutos"
# Caminho para o script que lista os repositórios
LISTAR_REPOS_SCRIPT="/home/thiago/relatorios/listar_repositorios.sh"

# --- Lógica do Script ---

# Garante que o diretório de saída exista
mkdir -p "$OUTPUT_DIR"

# Calcula o primeiro e último dia do mês
PRIMEIRO_DIA=$(date -d "$MES_ANO-01" "+%Y-%m-%d")
ULTIMO_DIA=$(date -d "$MES_ANO-01 +1 month -1 day" "+%Y-%m-%d")

echo "Coletando commits de '$GIT_AUTHOR' para o período de $PRIMEIRO_DIA a $ULTIMO_DIA..."
echo "--------------------------------------------------"

# Executa o script para listar repositórios e itera sobre cada um
"$LISTAR_REPOS_SCRIPT" | while read -r repo_path; do
    repo_name=$(basename "$repo_path")
    output_file="$OUTPUT_DIR/commits_${repo_name}.txt"

    echo "Processando repositório: $repo_name"

    # Executa o git log usando `git -C` para rodar no diretório do repositório
    git -C "$repo_path" log --author="$GIT_AUTHOR" --since="$PRIMEIRO_DIA" --until="$ULTIMO_DIA" --pretty=format:'%h - %ad | %s' --date=short > "$output_file"

    # Se nenhum commit for encontrado, o arquivo fica vazio. Removemos para não poluir.
    if [ ! -s "$output_file" ]; then
        echo "  -> Nenhum commit encontrado. Arquivo de log removido."
        rm "$output_file"
    else
        echo "  -> Commits salvos em: $output_file"
    fi
done

echo "--------------------------------------------------"
echo "Processo de coleta de commits concluído."
echo "Os arquivos estão em: $OUTPUT_DIR"