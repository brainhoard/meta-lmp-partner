#@TYPE: Image
#@NAME: LMP Gateway Image
#@DESCRIPTION: LMP Gateway Image

include sota-usrmerge.inc

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
