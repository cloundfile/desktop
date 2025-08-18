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

### INSTALAÇÃO DO POSTMAN ###
echo "🧪 Verificando instalação do Postman..."

if [ -f "/opt/Postman/Postman" ]; then
    echo "✅ Postman já está instalado em /opt/Postman"
else
    echo "⬇️ Instalando Postman..."

    # Baixa o Postman
    wget https://dl.pstmn.io/download/latest/linux_64 -O postman-linux-x64.tar.gz

    # Extrai o pacote
    tar -xvzf postman-linux-x64.tar.gz

    # Move para /opt
    sudo mv Postman /opt/Postman

    # Cria o atalho no /usr/bin
    sudo ln -sf /opt/Postman/Postman /usr/bin/postman

    # Cria o atalho no menu
    mkdir -p ~/.local/share/applications

    cat <<EOF > ~/.local/share/applications/postman.desktop
[Desktop Entry]
Name=Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Type=Application
Categories=Development;
EOF

    chmod +x ~/.local/share/applications/postman.desktop

    # Remove o arquivo .tar.gz após instalação
    rm -f postman-linux-x64.tar.gz

    echo "✅ Postman instalado com sucesso e adicionado ao menu!"
fi
