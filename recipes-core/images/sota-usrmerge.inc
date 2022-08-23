#@TYPE: Image
#@NAME: SOTA usrmerge
#@DESCRIPTION: SOTA usrmerge rootfs folder preperation

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
