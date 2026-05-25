#!/bin/bash

# Defina o diretório principal onde seus projetos/repositórios estão localizados.
# Altere "$HOME" para o caminho real da sua "solution" se for diferente.
# Exemplos comuns: "$HOME/projects", "$HOME/git", "$HOME/workspace", ou apenas "$HOME" para procurar em todo o diretório do usuário.
SOLUTIONS_DIR="$HOME" # <--- Ajustado para procurar em todo o seu diretório home

echo "Procurando por repositórios Git em: $SOLUTIONS_DIR" >&2
echo "--------------------------------------------------" >&2

if [ ! -d "$SOLUTIONS_DIR" ]; then
  echo "Erro: O diretório '$SOLUTIONS_DIR' não foi encontrado." >&2
  echo "Por favor, edite este script e defina a variável 'SOLUTIONS_DIR' com o caminho correto." >&2
  exit 1
fi

# Encontra todos os diretórios .git e imprime o diretório pai de cada um (a raiz do repositório)
# O -maxdepth 3 evita descer muito em diretórios de sistema/cache.
# O -not -path "*/.gemini/*" exclui os diretórios de histórico do Gemini.
find "$SOLUTIONS_DIR" -maxdepth 3 -type d -name ".git" -not -path "*/.gemini/*" -print0 | while IFS= read -r -d $'\0' gitdir; do
    repo_path=$(dirname "$gitdir")
    # Ignora o próprio diretório home se ele for encontrado como um repositório
    [ "$repo_path" == "$HOME" ] && continue
    echo "$repo_path"
done

echo "--------------------------------------------------" >&2
echo "Busca concluída." >&2