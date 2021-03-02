#!/bin/sh

# Actualizar Sistema
freebsd-update fetch
freebsd-update install

# Instalar y actualizar pkg
pkg -y
pkg update -q
pkg upgrade -y

# Instalar sudo y nano
pkg install -y sudo
pkg install -y nano

# Habilitar Wheel en sudo
echo -e "%wheel ALL=(ALL) ALL\n" >> /usr/local/etc/sudoers.d/admin

# Instalar Xorg
pkg install -y xdg-user-dirs
pkg install -y xorg

KB="/usr/local/etc/X11/xorg.conf.d/keyboard.conf"
echo -e 'Section "InputClass"' > $KB
echo -e '\tIdentifier "KeyboardDefaults"' >> $KB
echo -e '\tMatchIsKeyboard "on"' >> $KB
echo -e '\tOption "XkbLayout" "es"' >> $KB
echo -e '\tOption "XkbVariant" "winkeys"' >> $KB
echo -e 'EndSection' >> $KB

# Drivers VMWARE 
read -p "Se instala en maquina virtual (S/N): " MV
if [ "${MV}" == "S" ];
then
    read -p "Indicar plataforma virtual 1=VirtualBox - 2=VMWare: " PLAT
    if [ "${PLAT}" -eq 1 ] 2>/dev/null;
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
        echo -e 'fuse_load="YES"' >> /boot/loader.conf
        # Configuracion fstab
        mkdir /mnt/hgfs
        echo -e '.host:/\t/mnt/hgfs\tvmhgfs-fuse\tfailok,rw,allow_other,mountprog=/usr/local/bin/vmhgfs-fuse\t0\t0' >> /etc/fstab
    fi
fi

read -p "Desea instalar los drivers de video Intel? (S/N): " VI
if [ "${VI}" == "S" ];
then
    pkg install -y xf86-video-intel
fi
read -p "Desea instalar los drivers de video AMD? (S/N): " VA
if [ "${VA}" == "S" ];
then
    pkg install -y xf86-video-amdgpu
fi

# Establecer locale global
sed -i '' '1,/umask=022:/ s/umask=022:/umask=022:\\\n\t:charset=UTF-8:\\\n\t:lang=es_AR.UTF-8:/' "/etc/login.conf"

reboot 