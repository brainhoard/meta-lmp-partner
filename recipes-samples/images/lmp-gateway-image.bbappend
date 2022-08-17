#@TYPE: Image
#@NAME: LMP Gateway Image
#@DESCRIPTION: LMP Gateway Image

CORE_IMAGE_BASE_INSTALL:append = " \
    can-utils \
    canutils \
    i2c-tools \
    klish \
    modemmanager \
    networkmanager \
    nvme-cli \
    spitools \
    kernel-modules \
    "

CORE_IMAGE_BASE_INSTALL:append:tegra = " \
    packagegroup-core-buildessential \
    "

CORE_IMAGE_BASE_INSTALL:append:tegra210 = " \
    u-boot-tools \
    u-boot-ostree-scr \
    "

# u-boot-ostree-scr-fit
# packagegroup-core-buildessential
# packagegroup-self-hosted # DISTRO_FEATURES x11

KERNEL_MODULE_AUTOLOAD:append = " binfmt-misc"

KERNEL_MODULE_PROBECONF:append = " g-mass-storage"
module_conf:g-mass-storage = "options g-mass-storage removeable=y"

IMAGE_CMD:append:ota () {
    if [ "${OSTREE_BOOTLOADER}" = "syslinux" ]; then
        mkdir -p ${OTA_SYSROOT}/boot/extlinux
        ln -s ../loader/syslinux.cfg ${OTA_SYSROOT}/boot/extlinux/extlinux.conf
    fi
}

# do_image_ota[depends] += " \
# ${@'u-boot-tegra:do_populate_sysroot' if d.getVar('OSTREE_BOOTLOADER') == 'syslinux' else ''} \
# virtual/kernel:do_deploy ostree-native:do_populate_sysroot \
# "

# prepare for image_types_ostree.bbclass
ROOTFS_PREPROCESS_COMMAND:append:sota = "rootfs_sota_raw;"
rootfs_sota_raw() {

    mkdir -p ${IMAGE_ROOTFS}/var/usrlocal
    ln -sfr ${IMAGE_ROOTFS}/var/usrlocal ${IMAGE_ROOTFS}/usr/local

    mkdir -p ${IMAGE_ROOTFS}/var/rootdirs
    for d in home media mnt opt srv
    do
        if [ -d ${IMAGE_ROOTFS}/$d ]
        then
            mv ${IMAGE_ROOTFS}/$d ${IMAGE_ROOTFS}/var/rootdirs
        else
            mkdir -p ${IMAGE_ROOTFS}/var/rootdirs/$d
        fi
        ln -sfr ${IMAGE_ROOTFS}/var/rootdirs/$d ${IMAGE_ROOTFS}/$d
    done

    if [ -d ${IMAGE_ROOTFS}/root ]; then
        mv ${IMAGE_ROOTFS}/root ${IMAGE_ROOTFS}/var/rootdirs/home
    else
        mkdir -p ${IMAGE_ROOTFS}/var/rootdirs/home/root
    fi
    ln -sfr ${IMAGE_ROOTFS}/var/rootdirs/home/root ${IMAGE_ROOTFS}/root
}

ROOTFS_POSTPROCESS_COMMAND:append:sota = "rootfs_sota_bake;"
rootfs_sota_bake() {
    :
}
