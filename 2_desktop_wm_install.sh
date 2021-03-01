#!/usr/local/bin/bash

################# Configuracion General para Desktops ###########################
config_sys () { 
    # Permisos Fuentes
    chmod 775 /usr/local/share/fonts
    
    # Configuracion rc.conf
    sysrc dbus_enable="YES"
    sysrc hald_enable="YES"

    # ProcFS FSTAB
    PROC=`grep "procfs" /etc/fstab`
    if [ -z $PROC ];
    then
        echo -e 'proc\t/proc\tprocfs\trw\t0\t0' >> /etc/fstab
    fi
}
#################################################################################

################################ LIGHTDM #########################################
lightdm () {
    read -p "Desea instalar lightdm (S/N): " LDM
    if [ "${LDM}" == "S" ];
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
    LG="/usr/local/etc/gdm/locale.conf"
    echo -e 'LANG="es_AR.UTF-8"' > $LG
    echo -e 'LC_CTYPE="es_AR.UTF-8"' >> $LG
    echo -e 'LC_MESSAGES="es_AR.UTF-8"' >> $LG

    # GDM
    pkg install -y gdm
    sysrc gdm_enable="YES"
    # Idioma teclado GDM
    KB="/usr/local/share/gdm/greeter/autostart/keyboard.desktop"
    echo -e "[Desktop Entry]" > $KB
    echo -e "Type=Application" >> $KB
    echo -e "Name=Set Login Keyboard" >> $KB
    echo -e "Exec=/usr/local/bin/setxkbmap -display :0 'es'" >> $KB
    echo -e "NoDisplay=true" >> $KB
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
    read -p "Desea instalar SDDM (S/N): " DM
    if [ "${DM}" == "S" ];
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

    XS="/usr/local/share/xsessions/qtile.desktop"
    echo -e '[Desktop Entry]' > $XS
    echo -e 'Name=Qtile' >> $XS
    echo -e 'Comment=Qtile Session' >> $XS
    echo -e 'Exec=qtile start' >> $XS
    echo -e 'Type=Application' >> $XS
    echo -e 'Keywords=wm;tiling' >> $XS
}
##################################################################################

################################# MENU ###########################################
menu () {
    ESCRITORIOS="GNOME XFCE Mate KDE Qtile Salir"
    echo -e "\nSeleccione el escritorio o window manager a instalar:"
    select escritorio in $ESCRITORIOS;
    do
        if [ $escritorio == "GNOME" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            gnome
        elif [ $escritorio == "XFCE" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            xfce
        elif [ $escritorio == "Mate" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            mate
        elif [ $escritorio == "KDE" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            kde
        elif [ $escritorio == "Qtile" ];
        then
            echo -e "\nInstalando $escritorio"
            sleep 2
            qtile
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

# Script configuracion desktop
HOMEDIR=`grep "1001" /etc/passwd | awk -F : '{ print $6 }'`
USER=`grep "1001" /etc/passwd | awk -F : '{ print $1 }'`
mv 4_config_desktop.sh "$HOMEDIR"
chmod +x "$HOMEDIR/"4_config_desktop.sh
chown "$USER" "$HOMEDIR/"4_config_desktop.sh

reboot
