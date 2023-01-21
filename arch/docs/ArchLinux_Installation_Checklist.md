# Arch Installation Checklist

## WiFi

```bash
wpa_supplicant -B -i wlan0 -c <(wpa_passphrase Your_SSID WPA_PSK)
dhcpcd wlan0
```

## Partitioning

### Layout

```txt
+-------------------------+-------------------------+-------------------------+
| ESP partition:          | Boot partition:         | LVM partition:          |
|                         |                         |                         |
| /boot/efi               | /boot                   | rootpv                  |
|                         |                         |                         |
| /dev/nvme0n1p1          | /dev/nvme0n1p2          | /dev/nvme0n1p3          |
+-------------------------+-------------------------+-------------------------+
|                                /dev/nvme0n1                                 |
+-----------------------------------------------------------------------------+

+-------------------------+-------------------------+-------------------------+-------------------------+
| Volume 1:               | Volume 2:               | Volume 3:               | Volume 4:               |
|                         |                         |                         |                         |
| swap                    | root                    | var                     | home                    |
|                         |                         |                         |                         |
| /dev/mapper/rootvg-swap | /dev/mapper/rootvg-root | /dev/mapper/rootvg-var  | /dev/mapper/rootvg-home |
+-------------------------+-------------------------+-------------------------+-------------------------+
| /dev/nvme0n1p3                            rootpv                                                      |
+-------------------------------------------------------------------------------------------------------+

```

### Parted

```bash
parted -a optimal /dev/nvme0n1
unit mib
mklabel gpt

mkpart primary 1 257
name 1 efi
set 1 esp on

mkpart primary 257 1025
name 2 boot
set 2 boot on

mkpart primary 1025 -1
name 3 rootpv
set 3 lvm on

print
quit
```

## Disk Encryption

```bash
# Encryption on my SSD Evo 970 plus will slow my device, so I decided to encrypt only sensitive data

# Default
# cryptsetup -c aes-xts-plain64 -s 256 --use-random luksFormat /dev/nvme0n1p3

# A bit stronger but slower
# cryptsetup -c aes-xts-plain64 -s 512 --use-random luksFormat /dev/nvme0n1p3

# cryptsetup luksOpen /dev/nvme0n1 rootpv-encrypted
```

## LVM

```bash
# If encrypted:
# pvcreate /dev/mapper/rootpv-encrypted
# vgcreate rootvg /dev/mapper/rootpv-encrypted
pvcreate /dev/nvme0n1p3
vgcreate rootvg /dev/nvme0n1p3
lvcreate -L 32GiB -n swap rootvg
lvcreate -l 50GiB -n root rootvg
lvcreate -l 50GiB -n var rootvg
lvcreate -l 100GiB -n home rootvg
```

## File System

```bash
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 -L boot /dev/nvme0n1p2
mkfs.ext4 -L root /dev/mapper/rootvg-root
mkfs.ext4 -L var /dev/mapper/rootvg-var
mkfs.ext4 -L home /dev/mapper/rootvg-home

mkswap /dev/mapper/datavg-swap
swapon /dev/mapper/datavg-swap

mount /dev/mapper/rootvg-root /mnt
mkdir -p /mnt/{boot,home,var}

mount /dev/nvme0n1p2 /mnt/boot

mkdir -p /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi

mount /dev/mapper/rootvg-home /mnt/home
mount /dev/mapper/rootvg-var /mnt/var
```

## Mount all in one command

```bash
swapon /dev/mapper/datavg-swap              \
&& mount /dev/mapper/rootvg-root /mnt       \
&& mount /dev/nvme0n1p2 /mnt/boot           \
&& mount /dev/nvme0n1p1 /mnt/boot/efi       \
&& mount /dev/mapper/rootvg-home /mnt/home  \
&& mount /dev/mapper/rootvg-var /mnt/var
```

## Install

```bash
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
```

## Chrooting

```bash
arch-chroot /mnt
```

## Initial software

```bash
pacman -Su
pacman -Sy vim lvm2 mkinitcpio wpa_supplicant dhcpcd openssh grub efibootmgr intel-ucode sudo
```

## Locale

```bash
vim /etc/locale.gen

grep -v '^#' /etc/locale.gen
> en_US.UTF-8 UTF-8
> es_ES.UTF-8 UTF-8
> ru_RU.UTF-8 UTF-8

locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "LANGUAGE=en_US.UTF-8" >> /etc/locale.conf
echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf
echo "LC_CTYPE=en_US.UTF-8" >> /etc/locale.conf
```

## Hostname

```bash
vim /etc/hostname
laptop-dev

vim /etc/hosts
127.0.0.1 localhost
::1       localhost
127.0.1.1 laptop-dev.localdomain laptop-dev
```

## Bootloader

```bash
sed -i "s/^MODULES=.*/MODULES=(ext4)/g" /etc/mkinitcpio.conf
sed -i "s/^HOOKS=.*/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/g" /etc/mkinitcpio.conf

mkinitcpio -P

mount -o remount /sys/firmware/efi/efivars -o rw,nosuid,nodev,noexec,noatime
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux /dev/nvme0n1

vim /etc/default/grub
> GRUB_PRELOAD_MODULES="... lvm"

grub-mkconfig -o /boot/grub/grub.cfg
```

## Users

```bash
groupadd {username}
useradd -g {username} -G wheel -m {username}
passwd
passwd {username}
```

## Sudoers

```bash
EDITOR=vim visudo
# Uncomment: `%wheel ALL=(ALL) ALL`
# Optional:  `%wheel ALL=(ALL) NOPASSWD:ALL`
```

## Finish

```bash
logout
umount -R /mnt
swapoff -a
reboot
```
