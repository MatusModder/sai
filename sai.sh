# use arch-install-scripts to install the system
# run the dialog where user can choose the language, keyboard layout, timezone, hostname, username, password, and root password
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --menu "Please choose your language" 0 0 0 \
	"1" "English" \
	"2" "Deutsch" \
	"3" "Français" \
	"4" "Español" \
	"5" "Italiano" 2>/tmp/lang.txt

# get the language from the dialog
lang=`cat /tmp/lang.txt`

# if language is not 1,2,3,4, or 5, exit
if [ "$lang" -ne 1 ] && [ "$lang" -ne 2 ] && [ "$lang" -ne 3 ] && [ "$lang" -ne 4 ] && [ "$lang" -ne 5 ]; then
	echo "Invalid language selection"
	exit
fi

# if language is 1, set the language to English
if [ "$lang" -eq 1 ]; then
	LANGUAGE="en_US.UTF-8"
fi

# if language is 2, set the language to Deutsch
if [ "$lang" -eq 2 ]; then
	LANGUAGE="de_DE.UTF-8"
fi

# if language is 3, set the language to Français
if [ "$lang" -eq 3 ]; then
	LANGUAGE="fr_FR.UTF-8"
fi

# if language is 4, set the language to Español
if [ "$lang" -eq 4 ]; then
	LANGUAGE="es_ES.UTF-8"
fi

# if language is 5, set the language to Italiano
if [ "$lang" -eq 5 ]; then
	LANGUAGE="it_IT.UTF-8"
fi

# set the keyboard layout to the selected language
KEYBOARD="$LANGUAGE"

# set the timezone to the selected language
TIMEZONE="$LANGUAGE"

# run the dialog where user can choose the timezone
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --menu "Please choose your timezone" 0 0 0 \
	"1" "UTC" \
	"2" "US/Eastern" \
	"3" "US/Central" \
	"4" "US/Mountain
    "5" "US/Pacific" \
    "6" "US/Alaska" \
    "7" "US/Hawaii" \
    "8" "Europe/London" \
    "9" "Europe/Paris" \
    "10" "Europe/Moscow" \
    "11" "Europe/Madrid" \
    "12" "Europe/Berlin" \
# ask user to choose layout with loadkeys in dialog
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --menu "Please choose your keyboard layout" 0 0 0 \
	"1" "English" \
	"2" "Deutsch" \
	"3" "Français" \
	"4" "Español" \
	"5" "Italiano" 2>/tmp/keyboard.txt
# ask user to choose gpt, mbr or gpt-mbr, gpt-noswap, or mbr-noswap
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --menu "Please choose your partitioning" 0 0 0 \
    "1" "gpt" \
    "2" "mbr" \
    "3" "gpt-mbr" \
    "4" "gpt-noswap" \
    "5" "mbr-noswap" 2>/tmp/part.txt
# partition disks with fdisk
partition_disks() {
	# get the partitioning from the dialog
	part=`cat /tmp/part.txt`
	# if partitioning is not 1,2,3,4, or 5, exit
	if [ "$part" -ne 1 ] && [ "$part" -ne 2 ] && [ "$part" -ne 3 ] && [ "$part" -ne 4 ] && [ "$part" -ne 5 ]; then
		echo "Invalid partitioning selection"
		exit
	fi
	# if partitioning is 1, set the partitioning to gpt
	if [ "$part" -eq 1 ]; then
		PARTITIONING="gpt"
	fi
	# if partitioning is 2, set the partitioning to mbr
	if [ "$part" -eq 2 ]; then
		PARTITIONING="mbr"
	fi
	# if partitioning is 3, set the partitioning to gpt-mbr
	if [ "$part" -eq 3 ]; then
		PARTITIONING="gpt-mbr"
	fi
	# if partitioning is 4, set the partitioning to gpt-noswap
	if [ "$part" -eq 4 ]; then
		PARTITIONING="gpt-noswap"
	fi
	# if partitioning is 5, set the partitioning to mbr-noswap
	if [ "$part" -eq 5 ]; then
		PARTITIONING="mbr-noswap"
	fi
	# run fdisk to partition disks
	fdisk -l
	# ask user to choose disk to partition
	dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --menu "Please choose your disk" 0 0 0 \
		"1" "/dev/sda" \
		"2" "/dev/sdb" \
		"3" "/dev/sdc" \
		"4" "/dev/sdd" \
		"5" "/dev/sde" 2>/tmp/disk.txt
	# get the disk from the dialog
	disk=`cat /tmp/disk.txt`
	# if disk is not 1,2,3,4, or 5, exit
	if [ "$disk" -ne 1 ] && [ "$disk" -ne 2 ] && [ "$disk" -ne 3 ] && [ "$disk" -ne 4 ] && [ "$disk" -ne 5 ]; then
		echo "Invalid disk selection"
		exit
	fi
	# if disk is 1, set the disk to /dev/sda
	if [ "$disk" -eq 1 ]; then
		DISK="/dev/sda"
	fi
	# if disk is 2, set the disk to /dev/sdb
	if [ "$disk" -eq 2 ]; then
		DISK="/dev/sdb"
	fi
	# if disk is 3, set the disk to /dev/sdc
	if [ "$disk" -eq 3 ]; then
		DISK="/dev/sdc"
	fi
	# if disk is 4, set the disk to /dev/sdd
	if [ "$disk" -eq 4 ]; then
		DISK="/dev/sdd"
	fi
	# if disk is 5, set the disk to /dev/sde
	if [ "$disk" -eq 5 ]; then
		DISK="/dev/sde"
	fi
	# run fdisk to partition disks
	fdisk $DISK
# ask user what filesystem to use on patrtitions
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --menu "Please choose your filesystem" 0 0 0 \
	"1" "ext4" \
	"2" "ext3" \
	"3" "ext2" \
	"4" "btrfs" \
	"5" "xfs" 2>/tmp/filesystem.txt
# format the partitions with the selected filesystem

format_partitions() {
	# get the filesystem from the dialog
	filesystem=`cat /tmp/filesystem.txt`
	# if filesystem is not 1,2,3,4, or 5, exit
	if [ "$filesystem" -ne 1 ] && [ "$filesystem" -ne 2 ] && [ "$filesystem" -ne 3 ] && [ "$filesystem" -ne 4 ] && [ "$filesystem" -ne 5 ]; then
		echo "Invalid filesystem selection"
		exit
	fi
	# if filesystem is 1, set the filesystem to ext4
	if [ "$filesystem" -eq 1 ]; then
		FILESYSTEM="ext4"
	fi
	# if filesystem is 2, set the filesystem to ext3
	if [ "$filesystem" -eq 2 ]; then
		FILESYSTEM="ext3"
	fi
	# if filesystem is 3, set the filesystem to ext2
	if [ "$filesystem" -eq 3 ]; then
		FILESYSTEM="ext2"
	fi
	# if filesystem is 4, set the filesystem to btrfs
	if [ "$filesystem" -eq 4 ]; then
		FILESYSTEM="btrfs"
	fi
	# if filesystem is 5, set the filesystem to xfs
	if [ "$filesystem" -eq 5 ]; then
		FILESYSTEM="xfs"
	fi
	# format the partitions with the selected filesystem
	mkfs.$FILESYSTEM -L boot /dev/sda1
	mkfs.$FILESYSTEM -L root /dev/sda2
	mkfs.$FILESYSTEM -L swap /dev/sda3
# ask user to choose kernel with dialog and pacstrap it with base packages
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --menu "Please choose your kernel" 0 0 0 \
	"1" "linux-lts" \
	"2" "linux-hardened" \
	"3" "linux-zen" \
	"4" "linux-vanilla" \
	"5" "linux-grsec" 2>/tmp/kernel.txt
# get the kernel from the dialog
kernel=`cat /tmp/kernel.txt`
# if kernel is not 1,2,3,4, or 5, exit
if [ "$kernel" -ne 1 ] && [ "$kernel" -ne 2 ] && [ "$kernel" -ne 3 ] && [ "$kernel" -ne 4 ] && [ "$kernel" -ne 5 ]; then
# pacstrap the selected kernel and base packages to new root mounted ad /mnt
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --yesno "Would you like to install the base packages?" 0 0
if [ $? -eq 0 ]; then
	pacstrap /mnt base base-devel $kernel
	else
		exit
	fi	
	echo "Invalid kernel selection"
	exit
fi
# if kernel is 1, set the kernel to linux-lts
if [ "$kernel" -eq 1 ]; then
	KERNEL="linux-lts"
fi
# if kernel is 2, set the kernel to linux-hardened
if [ "$kernel" -eq 2 ]; then
	KERNEL="linux-hardened"
fi
# if kernel is 3, set the kernel to linux-zen
if [ "$kernel" -eq 3 ]; then
	KERNEL="linux-zen"
fi
# if kernel is 4, set the kernel to linux-vanilla
if [ "$kernel" -eq 4 ]; then
	KERNEL="linux-vanilla"
fi
# if kernel is 5, set the kernel to linux-grsec
if [ "$kernel" -eq 5 ]; then
	KERNEL="linux-grsec"
fi
# pacstrap the base system with base packages
pacstrap /mnt base base-devel linux-headers $KERNEL
# generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab
# copy the fstab file to the new system
cp /mnt/etc/fstab /mnt/etc/fstab.bak
# chroot into new system and ask user for hostname, timezone, locale, and keyboard
arch-chroot /mnt
# set hostname
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --inputbox "Please enter your hostname" 0 0 "arch" 2>/tmp/hostname.txt
# get the hostname from the dialog
hostname=`cat /tmp/hostname.txt`
# set the hostname
echo "$hostname" > /etc/hostname
# set the timezone
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --inputbox "Please enter your timezone" 0 0 "America/New_York" 2>/tmp/timezone.txt
# get the timezone from the dialog
timezone=`cat /tmp/timezone.txt`
# set the timezone
ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
# set the locale
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --inputbox "Please enter your locale" 0 0 "en_US.UTF-8" 2>/tmp/locale.txt
# get the locale from the dialog
locale=`cat /tmp/locale.txt`
# set the locale
echo "LANG=$locale" > /etc/locale.conf
locale-gen
# set the keyboard
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --inputbox "Please enter your keyboard" 0 0 "us" 2>/tmp/keyboard.txt
# get the keyboard from the dialog
keyboard=`cat /tmp/keyboard.txt`
# set the keyboard
echo "KEYMAP=$keyboard" > /etc/vconsole.conf
# ask for new root password and set it
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --inputbox "Please enter your new root password" 0 0 2>/tmp/rootpassword.txt
# get the root password from the dialog
rootpassword=`cat /tmp/rootpassword.txt`
# set the root password
echo "root:$rootpassword" | chpasswd
# install sudo, grub, and vim
pacman -S --noconfirm sudo grub vim
# generate grub config
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S --noconfirm efibootmgr
# if its efi filesystem, install grub-efi
if [ "$filesystem" -eq 4 ]; then
	pacman -S --noconfirm grub-efi-x86_64
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
fi
# if its bios filesystem, install grub
if [ "$filesystem" -eq 1 ] || [ "$filesystem" -eq 2 ] || [ "$filesystem" -eq 3 ]; then
	pacman -S --noconfirm grub-bios
	grub-install --target=i386-pc /dev/sda
fi
# add new user and add it to sudoers
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --inputbox "Please enter your new user" 0 0 2>/tmp/newuser.txt
# get the new user from the dialog
newuser=`cat /tmp/newuser.txt`
# add the new user
useradd -m -g users -G wheel -s /bin/bash $newuser
# set the new user password
dialog --title "Arch Linux Installation" --backtitle "Arch Linux Installation" --inputbox "Please enter your new user password" 0 0 2>/tmp/newuserpassword.txt
# get the new user password from the dialog
newuserpassword=`cat /tmp/newuserpassword.txt`
