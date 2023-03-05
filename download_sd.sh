#!/bin/sh
set -x

if [ "$1" = "sda" ]; then
    echo "sd card location is error, It can not be an sda"
    exit 1;
fi

TOPDIR=${PWD}

# download uboot
sudo dd if=./output/images/u-boot-dtb.imx of=/dev/${1} seek=1 bs=1K conv=fsync

# download kernel
sudo mount /dev/${1}1 /mnt
sudo cp ${PWD}/output/images/zImage /mnt
sudo cp ${PWD}/output/images/imx6ull-14x14-evk.dtb /mnt/imx6ull-alientek.dtb
sudo sync
sudo umount /mnt

#download system
sudo mount /dev/${1}2 /mnt
sudo tar -xf ${PWD}/output/images/rootfs.tar -C /mnt
sudo sync
sudo umount /mnt
