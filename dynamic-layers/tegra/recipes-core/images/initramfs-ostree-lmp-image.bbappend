#@TYPE: Image
#@NAME: LMP Initramfs
#@DESCRIPTION: LMP Initramfs

IMAGE_FSTYPES:remove:tegra = " cpio.gz.cboot cpio.gz.cboot.bup-payload"
IMAGE_FSTYPES:append:tegra186 = " cpio.gz.cboot cpio.gz.cboot.bup-payload"
IMAGE_FSTYPES:append:tegra194 = " cpio.gz.cboot cpio.gz.cboot.bup-payload"
IMAGE_FSTYPES:append:tegra210 = " "

PACKAGE_INSTALL:append:tegra210 = " \
    u-boot-ostree-scr \
    "
