#!/usr/local/bin/bash

VERIF=`pwd | grep FreeBSDInstall`
if [ -n "$VERIF" ];
then
    echo -e "\nADVERTENCIA!!!\n"
    echo -e "ADVERTENCIA!!!\n"
    echo -e "ADVERTENCIA!!!\n"
    echo -e "Este script eliminara el directorio donde esta ubicado con todo su contenido.\n"

    read -p "Desea proceder? (S/N): " SN
    if [ "${SN}" == "S" ];
    then
        # Eliminar archivo de configuracion de usuario
        HOMEDIR=`grep "1001" /etc/passwd | awk -F : '{ print $6 }'`
        rm -f "$HOMEDIR/"4_config_desktop.sh
        # Eliminar repositorio FreeBSDInstall
        rm -rf "`pwd`"
        cd ~
        $SHELL
    fi
else
    echo -e "\nADVERTENCIA!!!\n"
    echo -e "\nSolo se puede utilizar este script dentro del directorio FreeBSDInstall.\n"
fi


