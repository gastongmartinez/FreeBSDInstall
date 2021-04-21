#!/bin/sh

# Actualizar Sistema
freebsd-update fetch
freebsd-update install

# Instalar y actualizar pkg
pkg
pkg update
pkg upgrade

# Instalar sudo, nano y bash
pkg install -y sudo
pkg install -y nano
pkg install -y bash

# Habilitar Wheel en sudo
echo "%wheel ALL=(ALL) ALL" >> /usr/local/etc/sudoers.d/admin

# Instalar Xorg
pkg install -y xdg-user-dirs
pkg install -y xorg

{
    echo 'Section "InputClass"'
    printf "\t%s\n" 'Identifier "KeyboardDefaults"'
    printf "\t%s\n" 'MatchIsKeyboard "on"'
    printf "\t%s\n" 'Option "XkbLayout" "es"'
    printf "\t%s\n" 'Option "XkbVariant" "winkeys"'
    echo 'EndSection'
} >> /usr/local/etc/X11/xorg.conf.d/keyboard.conf


# Drivers VMWARE
printf "Se instala en maquina virtual (S/N): " 
read -r MV
if [ "$MV" = "S" ];
then
    printf "Indicar plataforma virtual 1=VirtualBox - 2=VMWare: "
    read -r PLAT
    if [ "$PLAT" -eq 1 ] 2>/dev/null;
    then
        # VirtualBox Guest utils
        pkg install -y emulators/virtualbox-ose-additions
        sysrc vboxguest_enable="YES"
        sysrc vboxservice_enable="YES"
    else
        # Open-VM-Tools (WMWare)
        # Instalacion de paquetes
        pkg install -y open-vm-tools
        pkg install -y xf86-video-vmware
        pkg install -y xf86-input-vmmouse
        # Configuracion rc.conf
        sysrc vmware_guest_vmblock_enable="YES"
        sysrc vmware_guest_vmhgfs_enable="YES"
        sysrc vmware_guest_vmmemctl_enable="YES"
        sysrc vmware_guest_vmxnet_enable="YES"
        sysrc vmware_guestd_enable="YES"
        # Configuracion loader.conf
        echo 'fuse_load="YES"' >> /boot/loader.conf
        # Configuracion fstab
        mkdir /mnt/hgfs
        printf "%s\t%s\t%s\t%s\t%s\t%s\n" ".host:/" "/mnt/hgfs" "vmhgfs-fuse" "failok,rw,allow_other,mountprog=/usr/local/bin/vmhgfs-fuse" "0" "0" >> /etc/fstab
    fi
fi

printf "Desea instalar los drivers de video Intel? (S/N): "
read -r VI
if [ "$VI" = "S" ];
then
    pkg install -y xf86-video-intel
fi
printf "Desea instalar los drivers de video AMD? (S/N): "
read -r VA
if [ "$VA" = "S" ];
then
    pkg install -y xf86-video-amdgpu
    pkg install -y xf86-video-ati
fi

# Establecer locale global
# sed -i '' '1,/umask=022:/ s/umask=022:/umask=022:\\\n\t:charset=UTF-8:\\\n\t:lang=es_AR.UTF-8:/' "/etc/login.conf" ## FreeBSD 12
sed -i '' '1,/lang=C.UTF-8:/ s/lang=C.UTF-8:/lang=es_AR.UTF-8:/' "/etc/login.conf" ## FreeBSD 13
cap_mkdb /etc/login.conf

reboot 