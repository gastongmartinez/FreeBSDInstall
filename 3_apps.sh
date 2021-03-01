#!/usr/local/bin/bash

############################### Paquetes ################################
PKGS=(
    #### Compresion ####
    'file-roller'
    'p7zip'
    'unrar'

    #### Fuentes ####
    'terminus-font'
    'dejavu'
    'powerline-fonts'
    'nerd-fonts'
    'ubuntu-font'
    
    #### WEB ####
    'chromium'
    'firefox'
    'thunderbird'
    'wget'
    'qbittorrent'
    'remmina'

    #### Shells ####
    'fish'
    'zsh'
    'zsh-completions'
    'bash-completion'

    #### Terminales ####
    'alacritty'

    #### Archivos ####
    'rsync'
    'fd'
    'mc'
    'vifm'
    'lf'
    'meld'
    'stow'
    'ripgrep'
    'fusefs-exfat'

    #### Sistema ####
    'conky'
    'htop'
    'bashtop'
    'lsblk'
    'neofetch'
    'plank'

    #### Editores ####
    'vim'
    'neovim'
    'vscode'
    'emacs'
    'libreoffice'
    'es-libreoffice'
    
    #### Multimedia ####
    'vlc'
    'clementine-player'
    'mpv'

    #### Juegos ####
    'chromium-bsu'

    #### Redes ####
    'wireshark'
    'nmap'

    #### Diseño ####
    'gimp'
    'inkscape'
    'krita'
    'blender'
    'freecad'

    #### DEV ####
    'git'
    'gcc'
    'codeblocks'
    'filezilla'
    'go'
    'rust'
    'python39'
    'openjdk15'
    'pycharm-ce'
)

# Instalacion de paquetes 
for PAC in "${PKGS[@]}"; do
    pkg install -y "$PAC"
done

#######################################################################

