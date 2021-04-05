#!/usr/local/bin/bash

pkg install -y git

############ Archivos de configuracion de entorno de usuario ####################
HOMEDIR=$(grep "1001" /etc/passwd | awk -F : '{ print $6 }')
USER=$(grep "1001" /etc/passwd | awk -F : '{ print $1 }')
mv -f 4_config_desktop.sh "$HOMEDIR"
chmod +x "$HOMEDIR/"4_config_desktop.sh
chown "$USER" "$HOMEDIR/"4_config_desktop.sh
#################################################################################


############################### Cambio de shell #################################
# ROOT
chsh -s /bin/sh
# UUID 1001
chsh -s /usr/local/bin/bash "$USER"
#################################################################################

################################ Wallpapers #####################################
wallpapers () {
    echo -e "\nInstalando wallpapers..."
    git clone https://github.com/gastongmartinez/wallpapers.git
    WALL="/usr/local/share/backgrounds/"
    if [[ ! -d "$WALL" ]];
    then
        mkdir "$WALL"
    fi
    mv -f wallpapers/ "$WALL"
}
#################################################################################

################################## Iconos #######################################
iconos () {
    echo -e "\nInstalando iconos..."
    for ICON in ./Iconos/*.xz
    do
        tar -xf "$ICON" -C /usr/local/share/icons/
    done
}
#################################################################################


################################ Temas GTK ######################################
temasGTK () {
    echo -e "\nInstalando temas GTK..."
    for TEMA in ./TemasGTK/*.xz
    do
        tar -xf "$TEMA" -C /usr/local/share/themes/
    done
}
#################################################################################

############################## Theming ##########################################
personalizacion () {
    read -rp "Desea instalar temas para la personalizacion del escritorio (S/N): " TEM
    if [ "${TEM}" == "S" ];
    then
        OPCIONES="Wallpapers Iconos TemasGTK Salir"
        echo -e "\nSeleccione los recursos a instalar:"
        select OP in $OPCIONES;
        do
            if [ "$OP" == "Wallpapers" ];
            then
                sleep 2
                wallpapers
            elif [ "$OP" == "Iconos" ];
            then
                sleep 2
                iconos
            elif [ "$OP" == "TemasGTK" ];
            then
                sleep 2
                temasGTK
            else
                break
            fi
            echo -e "\nSeleccione los recursos a instalar:"
            REPLY=""
        done
    fi
}   
#################################################################################

################# Configuracion General para Desktops ###########################
config_sys () { 
    # Permisos Fuentes
    chmod 775 /usr/local/share/fonts
    
    # Configuracion rc.conf
    sysrc dbus_enable="YES"
    sysrc hald_enable="YES"

    # ProcFS FSTAB
    PROC=$(grep "procfs" /etc/fstab)
    if [ -z "$PROC" ];
    then
        echo -e 'proc\t/proc\tprocfs\trw\t0\t0' >> /etc/fstab
    fi
}
#################################################################################

################################ LIGHTDM #########################################
lightdm () {
    read -rp "Desea instalar lightdm (S/N): " LDM
    if [ "$LDM" == "S" ];
    then
        pkg install -y lightdm
        pkg install -y lightdm-gtk-greeter
        pkg install -y lightdm-gtk-greeter-settings
        pkg install -y slick-greeter
        sed -i '' 's/#greeter-session=example-gtk-gnome/greeter-session=slick-greeter/g' "/usr/local/etc/lightdm/lightdm.conf"
        sysrc lightdm_enable="YES"
    fi
}
##################################################################################

################################## MATE ##########################################
mate () {
    lightdm

    pkg install -y mate
    pkg install -y mate-common
    pkg install -y brisk-menu
}
##################################################################################

################################# GNOME ############################################
gnome () {
    pkg install -y gnome3
    pkg install -y gnome-desktop
    pkg install -y chrome-gnome-shell
    sysrc gnome_enable="YES"

    # Idioma
    {
        echo -e 'LANG="es_AR.UTF-8"\n'
        echo -e 'LC_CTYPE="es_AR.UTF-8"\n'
        echo -e 'LC_MESSAGES="es_AR.UTF-8"\n'
    } >> /usr/local/etc/gdm/locale.conf
    

    # GDM
    pkg install -y gdm
    sysrc gdm_enable="YES"
    # Idioma teclado GDM
    {
        echo -e "[Desktop Entry]\n"
        echo -e "Type=Application\n"
        echo -e "Name=Set Login Keyboard\n"
        echo -e "Exec=/usr/local/bin/setxkbmap -display :0 'es'\n"
        echo -e "NoDisplay=true\n"
    } >> /usr/local/share/gdm/greeter/autostart/keyboard.desktop
    

    # Extensiones
    mv Extensiones "$HOMEDIR/"
    for ARCHIVO in "$HOMEDIR"/Extensiones/*.zip
    do
        UUID=$(unzip -c "$ARCHIVO" metadata.json | grep uuid | cut -d \" -f4)
        mkdir -p "$HOMEDIR"/.local/share/gnome-shell/extensions/"$UUID"
        unzip -q "$ARCHIVO" -d "$HOMEDIR"/.local/share/gnome-shell/extensions/"$UUID"/
    done
    chown -R "$USER":"$USER" "$HOMEDIR"/.local/
    rm -rf "$HOMEDIR"/Extensiones/
}
####################################################################################

################################## XFCE ############################################
xfce () {
    lightdm

    pkg install -y xfce
    pkg install -y xfce4-goodies
}
####################################################################################

################################### KDE ############################################
kde () {
    read -rp "Desea instalar SDDM (S/N): " DM
    if [ "$DM" == "S" ];
    then
        pkg install -y sddm
        sysrc sddm_enable="YES"
    fi

    pkg install -y kde5 
    pkg install -y plasma5-plasma 
    pkg install -y kde-baseapps
    pkg install -y kdeutils
    pkg install -y kdeadmin
    pkg install -y plasma5-kdeplasma-addons
    pkg install -y kdegraphics
    pkg install -y krusader
    pkg install -y kdeconnect-kde
    pkg install -y knotes
    pkg install -y kfind
    pkg install -y kalarm
    pkg install -y dolphin-plugins
    pkg install -y yakuake
    # pkg install -y kmymoney
    pkg install -y kruler
    pkg install -y kcolorchooser
    pkg install -y ktouch
    pkg install -y kdiff3
    pkg install -y kdevelop
    # pkg install -y kalgebra
    # pkg install -y cantor
    pkg install -y latte-dock
}
####################################################################################

################################## Qtile #########################################
qtile () {
    pkg install -y dmenu
    pkg install -y rofi
    pkg install -y nitrogen
    pkg install -y picom
    pkg install -y lxappearance
    pkg install -y qtile

    {
        echo -e '[Desktop Entry]\n'
        echo -e 'Name=Qtile\n'
        echo -e 'Comment=Qtile Session\n'
        echo -e 'Exec=qtile start\n'
        echo -e 'Type=Application\n'
        echo -e 'Keywords=wm;tiling\n'
    } >> /usr/local/share/xsessions/qtile.desktop
    
}
##################################################################################

############################### Awesome ##########################################
awesome () {
    pkg install -y awesome
    pkg install -y awesome-vicious     
}
##################################################################################

################################# MENU ###########################################
menu () {
    ESCRITORIOS="GNOME XFCE Mate KDE Qtile Awesome Salir"
    echo -e "\nSeleccione el escritorio o window manager a instalar:"
    select escritorio in $ESCRITORIOS;
    do
        if [ "$escritorio" == "GNOME" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            gnome
        elif [ "$escritorio" == "XFCE" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            xfce
        elif [ "$escritorio" == "Mate" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            mate
        elif [ "$escritorio" == "KDE" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            kde
        elif [ "$escritorio" == "Qtile" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            qtile
        elif [ "$escritorio" == "Awesome" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            awesome
        else
            break
        fi
        echo -e "\nSeleccione el escritorio a instalar:"
        REPLY=""
    done
}
############################################################

config_sys

menu

personalizacion

reboot
