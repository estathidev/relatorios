#!/bin/bash

# Define o diretório base para o Positron no home do usuário
POSITRON_DIR="$HOME/.positron"
CONTEXT_DIR="$POSITRON_DIR/context"

echo "Verificando e criando diretórios para o Positron..."

# Verifica se o diretório .positron existe, se não, cria
if [ ! -d "$POSITRON_DIR" ]; then
  mkdir -p "$POSITRON_DIR"
  echo "Diretório '$POSITRON_DIR' criado."
else
  echo "Diretório '$POSITRON_DIR' já existe."
fi

# Verifica se o diretório context existe dentro de .positron, se não, cria
if [ ! -d "$CONTEXT_DIR" ]; then
  mkdir -p "$CONTEXT_DIR"
  echo "Diretório '$CONTEXT_DIR' criado."
else
  echo "Diretório '$CONTEXT_DIR' já existe."
fi

echo "Estrutura de diretórios para o contexto do Positron está pronta."
echo "Você pode armazenar seus arquivos de contexto em '$CONTEXT_DIR'."
