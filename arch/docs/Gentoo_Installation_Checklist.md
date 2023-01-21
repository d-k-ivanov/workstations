### Preface

> Notebook Dell 7510 have a few of BIOS bugs. So if you face the probmem when NVMe drive not found in system, you just need to switch to SATA Raid -> Reboot -> And switch back <br>
> I've disabled Intel P30 video and run Nvidia only, because I need native driver for CUDA. 

### Boot media

First of all we need UEFI installation media. I prefert to use SystemRescueCD:
```bash
# Download ISO 
https://sourceforge.net/projects/systemrescuecd/files/sysresccd-x86/x.x.x/systemrescuecd-x86-x.x.x.iso/download
mkdir -p /tmp/cdrom
mount -o loop,exec /path/to/systemrescuecd-x86-x.x.x.iso /tmp/cdrom
# Plug in the USB stick
cd /tmp/cdrom
bash ./usb_inst.sh
cd ~
umount /tmp/cdrom
```

### Partition scheme

```bash
# Partition scheme:
# /dev/nvme0n1p1 (bootloader)  2M      Just in case, but I don't think it's really needed on modern EFI systems.
# /dev/nvme0n1p2 fat32-UFFI    1024M   EFI Partition to hold more than one kernel. Yes I know that Handbook recommends 128M.
# /dev/nvme0n1p3 root-ext4     100% 
# For swap I will use swapfile, because there is no performance advantage to either a contiguous swap file or a partition, both are treated the same way.

parted -a optimal /dev/nvme0n1
(parted) mklabel gpt

# Partition 1: Bootloader
(parted) unit mib
(parted) mkpart primary 1 3
(parted) name 1 grub 
(parted) set 1 bios_grub on

# Partition 1: Boot
(parted) mkpart primary 3 1027
(parted) name 2 boot
(parted) set 2 boot on

# Partition 1: Root
(parted) mkpart primary 1027 -1
(parted) name 4 rootfs
```

### Filesystems

```bash
mkfs.fat -F 32 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

### Mounting

```bash
mount /dev/nvme0n1p3 /mnt/gentoo
mount /dev/nvme0n1p2 /mnt/gentoo/boot

# System remount for chrooting
mount -t proc proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
```

### Install Stage

```bash
cd /mnt/gentoo/
wget http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds/current-stage3-amd64-systemd/stage3-amd64-systemd-<YYYYMMDD>.tar.bz2
tar xvjpf stage3-amd64-systemd-<YYYYMMDD>.tar.bz2 --xattrs
```

### Chrooting

- [make.conf](/data/gentoo/make.conf.txt)

```bash
# See link above to get contents of make.conf
vim /mnt/gentoo/etc/portage/make.conf
mkdir /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp -L /etc/resolv.conf /mnt/gentoo/etc/
chroot /mnt/gentoo /bin/bash 
source /etc/profile
export PS1="(chrooted) $PS1"
```

### Update

```bash
emerge-webrsync
emerge --sync
# Should be systemd profile
eselect profile set 12
emerge --ask --update --deep --newuse @world
```

### Timezone

```bash
echo "Europe/Moscow" > /etc/timezone
emerge --config sys-libs/timezone-data
```

### Locale

```bash
vim /etc/locale.gen
#---- locale.gen ----
en_US.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
#--------------------

eselect locale list
eselect locale set 2
env-update && source /etc/profile
```

### fstab

```bash
fallocate -l 8192M /swapfile
dd if=/dev/zero of=/swapfile bs=1M count=8192
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
blkid

#----    fstab   ----
UUID="XXX" /boot         vfat rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro 0 2
UUID="XXX" /             ext4 rw,relatime,data=ordered                                                                             0 1
UUID="XXX" /home/storage ext4 rw,relatime,data=ordered                                                                             1 1
#Swap
/swapfile  none          swap defaults                                                                                             0 0
#--------------------
```

### Kernel

- [.config](https://d-k-ivanov.github.io/data/gentoo/config-4.12.txt)

```bash
emerge --ask sys-kernel/gentoo-sources sys-apps/pciutils sys-kernel/genkernel-next
eselect kernel list
eselect kernel set 'N'
cd /usr/src/linux
# See link above to get 4.12 kernel config for Dell 7510
touch /usr/src/linux/.config
make olddefconfig
make && make modules_install
make install
genkernel --install initramfs
```

### Network

```bash
emerge --ask dbus
hostnamectl set-hostname your-hostname.your-network
vim /etc/hosts
#----    hosts   ----
127.0.0.1   your-hostname.your-network your-hostname localhost
::1         your-hostname.your-network your-hostname localhost
#--------------------

emerge --ask net-misc/dhcpcd
```

### Grub

Make sure that you have "GRUB_PLATFORMS="efi-64" in /etc/portage/make.conf (see above)
- [grub](https://d-k-ivanov.github.io/data/gentoo/grub.txt)
- [terminus32.pf2](https://d-k-ivanov.github.io/data/gentoo/terminus32.pf2)

```bash
emerge --ask --update --newuse --verbose sys-boot/grub:2
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
# See link above to contents
vim /etc/default/grub

cd /boot/grub/fonts/
wget https://d-k-ivanov.github.io/data/gentoo/terminus32.pf2

mkdir /boot/efi/EFI/boot
mkdir /boot/EFI/boot
cp /boot/EFI/grub/grubx64.efi /boot/EFI/bootx64.efi

grub-mkconfig -o /boot/grub/grub.cfg
```

### Console

```bash
emerge --ask media-fonts/terminus-font
echo "FONT=ter-p32n.psf.gz" > /etc/vconsole.conf
```

### Post install

```bash
useradd -m -G users,wheel,audio,portage,usb,video -s /bin/bash <username>
passwd <username>

# I like to own whole /home directory
chown -R <username>:<username> /home

emerge --ask sys-process/cronie sys-apps/mlocate sudo
emerge --ask media-fonts/terminus-font
```

### Unmount and reboot

```bash
exit
umount -l /mnt/gentoo/dev{/shm,/pts,}
umount -R /mnt/gentoo
reboot
```
