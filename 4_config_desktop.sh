#!/usr/local/bin/bash

if [ $EUID -eq 0 ];
then
   echo "Este script debe usarse con un usuario regular."
   echo "Saliendo..."
   exit 1
fi

if [ -z "$DISPLAY" ];
then
    echo -e "Debe ejecutarse dentro del entorno grafico.\n"
    echo "Saliendo..."
    exit 2
fi

gnome () {
    # Establecer valores usando gsettings o dconf write
    # gsettings set org.gnome.desktop.interface gtk-theme 'Qogir-manjaro-win-dark'
    # dconf write /org/gnome/desktop/interface/gtk-theme "'Qogir-manjaro-win-dark'"

    ############################################## Extensiones ##################################################################################
    # User themes
    dconf write /org/gnome/shell/enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.  github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com']"
    
    # ArcMenu
    dconf write /org/gnome/shell/enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.  github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'arcmenu@arcmenu.com']"
    dconf write /org/gnome/shell/extensions/arcmenu/available-placement "[true, false, false]"
    dconf write /org/gnome/mutter/overlay-key "'Super_L'"
    dconf write /org/gnome/desktop/wm/keybindings/panel-main-menu "['<Alt>F1']"
    dconf write /org/gnome/shell/extensions/arcmenu/pinned-app-list "['Web', '', 'org.gnome.Epiphany.desktop', 'Terminal', '', 'org.gnome.Terminal. desktop', 'ArcMenu Settings', 'ArcMenu_ArcMenuIcon', 'gnome-extensions prefs arcmenu@arcmenu.com']"
    dconf write /org/gnome/shell/extensions/arcmenu/menu-hotkey "'Super_L'"
    
    # Dash to Dock
    dconf write /org/gnome/shell/enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.  github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'arcmenu@arcmenu.com', 'dash-to-dock@micxgx.gmail.com']"
    dconf write /org/gnome/shell/extensions/arcmenu/available-placement "[false, false, true]"
    dconf write /org/gnome/shell/extensions/dash-to-dock/preferred-monitor 0
    dconf write /org/gnome/shell/extensions/dash-to-dock/dock-position "'BOTTOM'"
    dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed false
    dconf write /org/gnome/shell/extensions/dash-to-dock/autohide true
    dconf write /org/gnome/shell/extensions/dash-to-dock/show-trash false
    dconf write /org/gnome/shell/extensions/dash-to-dock/show-show-apps-button false
    dconf write /org/gnome/shell/extensions/dash-to-dock/transparency-mode "'DYNAMIC'"
    dconf write /org/gnome/shell/extensions/dash-to-dock/customize-alphas true
    dconf write /org/gnome/shell/extensions/dash-to-dock/min-alpha 0.10
    dconf write /org/gnome/shell/extensions/dash-to-dock/max-alpha 0.60
    
    # Drop down Terminal
    dconf write /org/gnome/shell/enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.  github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'arcmenu@arcmenu.com', 'dash-to-dock@micxgx.gmail.com', 'drop-down-terminal-x@bigbn.pro']"
    dconf write /pro/bigbn/drop-down-terminal-x/other-shortcut "['F12']"
    dconf write /pro/bigbn/drop-down-terminal-x/enable-tabs true
    dconf write /pro/bigbn/drop-down-terminal-x/use-default-colors true
    ##############################################################################################################################################

    # Teclado
    dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'es+winkeys')]"

    # Ventanas
    dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"
    dconf write /org/gnome/mutter/center-new-windows true

    # Tema
    dconf write /org/gnome/desktop/interface/gtk-theme "'Prof-Gnome-Dark-3.6'"
    dconf write /org/gnome/shell/extensions/user-theme/name "'Prof-Gnome-Dark-3.6'"
    dconf write /org/gnome/desktop/interface/cursor-theme "'Qogir-manjaro-dark'"
    dconf write /org/gnome/desktop/interface/icon-theme "'Qogir-manjaro-dark'"

    # Wallpaper
    dconf write /org/gnome/desktop/background/picture-uri "'file:///usr/local/share/backgrounds/wallpapers/Varios/varios%2031.png'"

    # Establecer fuentes
    dconf write /org/gnome/desktop/interface/font-name "'Ubuntu 11'"
    dconf write /org/gnome/desktop/interface/document-font-name "'Ubuntu 11'"
    dconf write /org/gnome/desktop/interface/monospace-font-name "'Ubuntu Mono 10'"
    dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'Ubuntu Bold 11'"

    # Aplicaciones favoritas
    dconf write /org/gnome/shell/favorite-apps "['org.gnome.Nautilus.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Boxes.desktop', 'org.gnome. Evolution.desktop', 'libreoffice-calc.desktop', 'chromium.desktop', 'firefox.desktop', 'brave-browser.desktop', 'org.qbittorrent.qBittorrent.    desktop', 'code-oss.desktop', 'codeblocks.desktop', 'Alacritty.desktop', 'clementine.desktop', 'vlc.desktop', 'org.gnome.tweaks.desktop']"

    # Suspender
    # En 2 horas enchufado
    dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-timeout 7200
    # En 30 minutos con bateria
    dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-timeout 1800

    # Autostart Apps
    #if [ ! -d ~/.config/autostart ]; then
    #    mkdir -p ~/.config/autostart
    #fi
    #cp /usr/share/applications/plank.desktop ~/.config/autostart/    
}

mate () {
    # Tema
    #gsettings set org.mate.interface gtk-theme 'Nordic'
    #gsettings set org.mate.interface gtk-theme 'Qogir-manjaro-win-dark'
    #gsettings set org.mate.Marco.general theme 'Qogir-manjaro-dark'
    #gsettings set org.mate.interface icon-theme 'Qogir-manjaro-dark'
    #gsettings set org.mate.peripherals-mouse cursor-theme 'Qogir-manjaro-dark'

    # Remover panel inferior
    dconf write /org/mate/panel/general/toplevel-id-list "['top']"

    # Wallpaper
    #gsettings set org.mate.background picture-filename "/SOME/PATH/IMAGE.jpg"

    # Caja: vista de detalles
    gsettings set org.mate.caja.preferences default-folder-viewer 'list-view'

    # Habilitar Delete en Caja
    gsettings set org.mate.caja.preferences enable-delete true

    # Habilitar archivos ocultos Caja
    gsettings set org.mate.caja.preferences show-hidden-files true

    # Iconos escritorio
    gsettings set org.mate.caja.desktop computer-icon-visible false
    gsettings set org.mate.caja.desktop home-icon-visible false
    gsettings set org.mate.caja.desktop trash-icon-visible false
    #gsettings set org.mate.caja.desktop volumes-visible false

    # Remover menu Mate
    gsettings set org.mate.panel.menubar show-applications false
    gsettings set org.mate.panel.menubar show-desktop false
    gsettings set org.mate.panel.menubar show-icon false
    gsettings set org.mate.panel.menubar show-places false

    # Agregar Brisk-Menu
    dconf write /org/mate/panel/objects/object-0/object-type "'applet'"
    dconf write /org/mate/panel/objects/object-0/panel-right-stick false
    dconf write /org/mate/panel/objects/object-0/position 0
    dconf write /org/mate/panel/objects/object-0/toplevel-id "'top'"
    dconf write /org/mate/panel/objects/object-0/applet-iid "'BriskMenuFactory::BriskMenu'"
    dconf write /org/mate/panel/general/object-id-list "['notification-area', 'clock', 'show-desktop', 'window-list', 'workspace-switcher',     'object-0']"

    # Establecer fuentes
    dconf write /org/mate/desktop/interface/font-name "'Ubuntu 10'"
    dconf write /org/mate/desktop/interface/document-font-name "'Ubuntu 10'"
    dconf write /org/mate/caja/desktop/font "'Ubuntu 10'"
    dconf write /org/mate/marco/general/titlebar-font "'Ubuntu 10'"
    dconf write /org/mate/desktop/interface/monospace-font-name "'Ubuntu Mono 10'"

    # Autostart
    if [ ! -d ~/.config/autostart ]; then
        mkdir -p ~/.config/autostart
    fi
    cp /usr/local/share/applications/plank.desktop ~/.config/autostart/
    cp /usr/local/share/applications/albert.desktop ~/.config/autostart/
}

xfce () {
    # Tema
    xfconf-query -c xsettings -p /Net/ThemeName -s Prof-Gnome-Dark
    xfconf-query -c xsettings -p /Net/IconThemeName -s Qogir-manjaro-dark
    xfconf-query -c xfwm4 -p /general/theme -s Qogir-manjaro-dark

    # Fuentes
    xfconf-query -c xsettings -p /Gtk/FontName -s 'Ubuntu 10'
    xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s 'Ubuntu Mono 10'
    xfconf-query -c xfwm4 -p /general/title_font -s 'Ubuntu Bold 11'

    # Ocultar iconos del escritorio
    xfconf-query -c xfce4-desktop -n -p /desktop-icons/style -t int -s 0

    # Thunar
    xfconf-query -c thunar -n -p /last-show-hidden -t bool -s true                      # Mostrar archivos ocultos
    xfconf-query -c thunar -n -p /default-view -t string -s 'ThunarDetailsView'         # Vista por defecto detalles
    xfconf-query -c thunar -n -p /last-sort-column -t string -s 'THUNAR_COLUMN_TYPE'    # Ordenar por tipo
    xfconf-query -c thunar -n -p /last-sort-order -t string -s 'GTK_SORT_ASCENDING'     # Orden ascendente
    xfconf-query -c thunar -n -p /misc-folders-first -t bool -s true                    # Mostrar carpetas primero
    xfconf-query -c thunar -n -p /last-details-view-column-order -t string -s "THUNAR_COLUMN_NAME,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_DATE_MODIFIED"                                                        # Orden de las columnas

    # Eliminar panel inferior (se aplica al reiniciar)
    xfconf-query -c xfce4-panel -p /panels/panel-2 -r -R
    xfconf-query -c xfce4-panel -p /panels -a -t int -s 1

    # Panel superior (se aplica al reiniciar)
    xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 28                                       # Establece altura
    PAGER=$(xfconf-query -c xfce4-panel -p /plugins -l -v | grep pager | cut -d " " -f1)            # Determina que pluguin es el PAGER 
    APP=$(xfconf-query -c xfce4-panel -p /plugins -l -v | grep applicationsmenu | cut -d " " -f1)   # Determina que pluguin es el 
    xfconf-query -c xfce4-panel -p "$PAGER" -r -R                                                   # Elimina PAGER
    xfconf-query -c xfce4-panel -p "$APP" -r -R                                                     # Elimina Menu    
    xfconf-query -c xfce4-panel -n -p /plugins/plugin-30 -t string -s whiskermenu                   # Crea el plugin 30 como whiskermenu
    ACTUAL=$(xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids -v | cut -f2 -d":")          # Recupera los plugins visibles
    ACTUALARR=("$ACTUAL")                                                                           # Convierte los plugins en un array
    NUEVO="xfconf-query -c xfce4-panel -n -p /panels/panel-1/plugin-ids -a -t int -s 30"            # Comando base para agregar whiskermenu
    for i in "${ACTUALARR[@]}"                                                                      # Recorre el array agregando los elementos
    do                                                                                              # existentes en el comando nuevo
        NUEVO+=" -t int -s $i"
    done
    bash -c "$NUEVO"                                                                                # Ejecuta el comando
  
    # Autostart
    if [ ! -d ~/.config/autostart ]; 
    then
        mkdir -p ~/.config/autostart
    fi
    PLANK=/usr/share/applications/plank.desktop
    if [ -f "$PLANK" ]; 
    then 
        cp "$PLANK" ~/.config/autostart/
    fi    
}

doom () {
    if [ -d ~/.emacs.d ]; then
        rm -Rf ~/.emacs.d
    fi
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}

CONFIGURAR="GNOME Mate XFCE DoomEmacs Salir"
echo -e "\nElija que configurar:"
select conf in $CONFIGURAR;
do
    if [ "$conf" == "GNOME" ];
    then
        echo -e "\nConfigurando $conf"
        sleep 2
        gnome
    elif [ "$conf" == "Mate" ];
    then
        echo -e "\nConfigurando $conf"
        sleep 2
        mate
    elif [ "$conf" == "XFCE" ];
    then
        echo -e "\nConfigurando $conf"
        sleep 2
        xfce
    elif [ "$conf" == "DoomEmacs" ];
    then
        echo -e "\nConfigurando $conf"
        sleep 2
        doom
    else
        break
    fi
    echo -e "\nElija el escritorio a configurar:"
    REPLY=""
done
