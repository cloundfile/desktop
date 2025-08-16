#!/bin/bash

# Instalação silenciosa do NVM (Node Version Manager)
echo "Iniciando a instalação do NVM..."

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Verifica se a instalação foi concluída com sucesso
if [ $? -eq 0 ]; then
    echo "NVM instalado com sucesso!"
    echo "Para começar a usar o NVM, adicione o seguinte ao seu ~/.bashrc, ~/.zshrc ou ~/.profile:"
    echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"'
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm'
else
    echo "Houve um erro na instalação do NVM."
fi

load_nvm

# Verifica se o Node.js já está instalado via NVM
if nvm ls node | grep -q 'N/A'; then
    echo "🔧 Node.js não encontrado. Instalando a versão mais recente..."
    nvm install node

    if [ $? -eq 0 ]; then
        echo "✅ Node.js instalado com sucesso!"
    else
        echo "❌ Falha ao instalar o Node.js."
        exit 1
    fi
else
    echo "✅ Node.js já está instalado:"
    nvm current
fi
