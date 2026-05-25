# 📊 Repositório de Relatórios

Bem-vindo ao repositório central de relatórios! Este espaço foi criado para organizar, versionar e facilitar a geração de documentos técnicos, acompanhamento de demandas e autoavaliações.

## 📁 Estrutura do Repositório

A organização das pastas foi estruturada para separar claramente diferentes contextos de trabalho:

* **`auto_avaliacoes/`**: Contém os relatórios periódicos de acompanhamento e produtividade (ex: `Autoavaliacao_2026_04`).
  * **`scripts/`**: Armazena os scripts de automação em Bash e Python (como `coletar_commits.sh` e `coletar_commits_github.py`) utilizados para varrer repositórios e extrair dados da API do GitHub.
* **`demandas/`**: Destinado aos relatórios e mini-relatórios técnicos focados em planejamento, bugs e tarefas específicas de engenharia e monitoramento (ex: documentação sobre pluviógrafos, inclinômetros e sensores).

*(Existem também scripts úteis avulsos na raiz, como utilitários de setup de ambiente).*

## 🛠️ Tecnologias Utilizadas

* **Quarto:** Utilizado para escrever a documentação (arquivos `.qmd`) combinando Markdown com capacidades de exportação avançadas para HTML e PDF.
* **Python & Bash:** Usados nos scripts de coleta de métricas e gerenciamento de arquivos.

## 🚀 Como gerar os relatórios (Renderização)

Os relatórios base deste repositório utilizam a extensão `.qmd`. Para transformá-los no documento final (PDF ou HTML), navegue até a raiz do repositório em seu terminal e execute:

```bash
# Exemplo de renderização:
quarto render demandas/20260525_Demandas_Instruments/Demandas_Instruments.qmd
```

> **Nota sobre PDFs:** O Quarto utiliza LaTeX para gerar PDFs. Caso ocorra um erro de dependência na primeira execução, rode `quarto install tinytex` no terminal para instalar o motor básico de PDF.

---