#@TYPE: Image
#@NAME: LMP Base
#@DESCRIPTION: LMP Base

CORE_IMAGE_BASE_INSTALL:append = " \
    klish \
    libqmi \
    libmbim \
    modemmanager \
    networkmanager \
    nvme-cli \
    i2c-tools \
    spitools \
"
