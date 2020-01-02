#!/bin/bash

(
  echo g;
  echo n;
  echo 1;
  echo;
  echo +1G;
  echo t;
  echo 1;
  echo n;
  echo 2;
  echo;
  echo +8G;
  echo t;
  echo 2;
  echo 19;
  echo n;
  echo 3;
  echo;
  echo;
  echo w;
) | fdisk /dev/sda
mkfs.ext4 /dev/sda3 -L "Arch"
mount /dev/sda3 /mnt
mkfs.fat /dev/sda1
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
mkswap /dev/sda2 -L "swap"
swapon /dev/sda2
echo -e "#Russia\nServer = https://mirror.rol.ru/archlinux/\$repo/os/\$arch\nServer = https://mirror.yandex.ru/archlinux/$repo/os/$arch" >> /etc/pacman.d/mirrorlist1
cat /etc/pacman.d/mirrorlist >> /etc/pacman.d/mirrorlist1
mv /etc/pacman.d/mirrorlist1 /etc/pacman.d/mirrorlist
rm /etc/pacman.d/mirrorlist1
pacman -Syy
pacstrap /mnt base linux linux-firmware base-devel
genfstab -L -p -P /mnt >> /mnt/etc/fstab
(echo pacman -S nano neofetch screenfetch mc --noconfirm
echo loadkeys ru
echo setfont cyr-sun16
echo echo -e "en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8" >> nano /etc/locale.gen
echo locale-gen
echo echo "LANG=ru_RU.UTF-8" >> /etc/locale.conf
echo export LANG=ru_RU.UTF-8
echo echo -e "KEYMAP=ru\nFONT=cyr-sun16" >> /etc/vconsole.conf
echo ln -sf /usr/share/zoneinfo/Europe/Saratov /etc/localtime
echo hwclock --systohc
echo echo "potato-pc" >> /etc/hostname
echo echo -e "127.0.0.1	localhost\n::1			localhost\n127.0.1.1	potato-pc.localdomain	potato-pc" >> /etc/hosts 
echo useradd -G wheel -s /bin/bash -m igorek
echo echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers1
echo cat /etc/sudoers >> /etc/sudoers1
echo mv /etc/sudoers1 /etc/sudoers
echo rm /etc/sudoers1
echo passwd
echo passwd igorek
echo pacman -S  efibootmgr iw wpa_supplicant dialog netctl dhcpcd --noconfirm
echo pacman -S networkmanager network-manager-applet ppp --noconfirm
echo bootctl install
echo echo -e "default arch\ntimeout 5\neditor 1" >> /boot/loader/loader.conf
echo echo -e "title Arch Linux\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\noptions root=/dev/sda3 rw" >> /boot/loader/entries/arch.conf
) | arch-chroot /mnt