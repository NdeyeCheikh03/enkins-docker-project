# Utiliser l'image officielle Python
FROM python:3.13.0-alpine3.20

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le script Python dans le conteneur
COPY sum.py .

# Assurer que le conteneur reste actif en exécutant un shell interactif
CMD ["tail", "-f", "/dev/null"]
