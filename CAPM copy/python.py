from pathlib import Path
import shutil

arquivo = Path(input("Caminho do arquivo de annotations.cds: ").strip().strip('"'))

if not arquivo.is_file():
    print("Arquivo não encontrado.")
    raise SystemExit

codigo = arquivo.read_text(encoding="utf-8")

trecho_antigo = """        ]
    }],
    UI.Identification"""

trecho_novo = """        ]
    },
    {
        $Type : 'UI.ReferenceFacet',
        Target : 'Items/@UI.LineItem',
        Label : 'Ticket Items'
    }],
    UI.Identification"""

if trecho_antigo not in codigo:
    print("Não encontrei o trecho esperado. Nenhuma alteração foi feita.")
    raise SystemExit

backup = arquivo.with_suffix(arquivo.suffix + ".bak")
shutil.copy2(arquivo, backup)

codigo = codigo.replace(trecho_antigo, trecho_novo, 1)
arquivo.write_text(codigo, encoding="utf-8")

print("Facet inserida com sucesso!")
print(f"Backup criado em: {backup}")