# Système d'exploitation
OS_NAME=$(shell uname -s)

# Nommage et paramétrage du compilateur
CC=gcc
CFLAGS=-W -Wall -pedantic
LDFLAGS=-lm

# Chemin vers l'application (build)
BUILD_PATH=build/$(OS_NAME)

# Nom de l'exécutable
EXEC=test

# Règle par défaut
.DEFAULT_GOAL := all

# ------------------------------------ Liste des cibles ------------------------------------

# Création du répertoire de build
$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)

# Efface les fichiers temporaires et les fichiers finaux
clean:
	rm -rf $(BUILD_PATH)

# Compilation de 'lib/fonctions.c'
$(BUILD_PATH)/fonctions.o: lib/fonctions.c | $(BUILD_PATH)
	$(CC) $(CFLAGS) -c lib/fonctions.c -I ./lib -o $(BUILD_PATH)/fonctions.o

# Compilation de 'src/main.c'
$(BUILD_PATH)/main.o: src/main.c lib/fonctions.h | $(BUILD_PATH)
	$(CC) $(CFLAGS) -c src/main.c -I ./lib -o $(BUILD_PATH)/main.o

# Edition de liens
$(BUILD_PATH)/$(EXEC): $(BUILD_PATH)/fonctions.o $(BUILD_PATH)/main.o | $(BUILD_PATH)
	$(CC) $(LDFLAGS)  $(BUILD_PATH)/fonctions.o $(BUILD_PATH)/main.o -o $(BUILD_PATH)/$(EXEC)

# Compile et assemble l'application
all: $(BUILD_PATH)/$(EXEC)
