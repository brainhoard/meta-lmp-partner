#@TYPE: Image
#@NAME: LMP Gateway Image
#@DESCRIPTION: LMP Gateway Image

CORE_IMAGE_BASE_INSTALL:append = " \
    packagegroup-core-buildessential \
    "

CORE_IMAGE_BASE_INSTALL:append:tegra210 = " \
    u-boot-tools \
    u-boot-ostree-scr \
    "

# u-boot-ostree-scr-fit
# packagegroup-core-buildessential
# packagegroup-self-hosted # DISTRO_FEATURES x11
