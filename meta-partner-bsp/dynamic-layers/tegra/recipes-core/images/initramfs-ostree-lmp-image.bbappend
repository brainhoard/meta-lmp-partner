#@TYPE: Recipe
#@NAME: NVIDIA Tegra Initramfs
#@DESCRIPTION: NVIDIA Tegra Initramfs

IMAGE_FSTYPES:remove:tegra = " cpio.gz.cboot cpio.gz.cboot.bup-payload"
IMAGE_FSTYPES:append:tegra186 = " cpio.gz.cboot cpio.gz.cboot.bup-payload"
IMAGE_FSTYPES:append:tegra194 = " cpio.gz.cboot cpio.gz.cboot.bup-payload"
IMAGE_FSTYPES:append:tegra210 = " "
