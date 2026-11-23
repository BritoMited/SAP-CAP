import os

files_to_check = [
    "srv/crudService.js",
    "db/schema.cds"
]

# Procura também por ficheiros .cds na pasta srv se houver
for root, dirs, files in os.walk("srv"):
    for file in files:
        if file.endswith(".cds"):
            files_to_check.append(os.path.join(root, file))

output_content = ""

for filepath in files_to_check:
    if os.path.exists(filepath):
        output_content += f"\n\n--- INICIO DO FICHEIRO: {filepath} ---\n\n"
        with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
            output_content += f.read()
        output_content += f"\n\n--- FIM DO FICHEIRO: {filepath} ---\n\n"

with open("diagnostico_cap.txt", "w", encoding="utf-8") as out:
    out.write(output_content)

print("Ficheiro 'diagnostico_cap.txt' gerado com sucesso na raiz do projeto!")