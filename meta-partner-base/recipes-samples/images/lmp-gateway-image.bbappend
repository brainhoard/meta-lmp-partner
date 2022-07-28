#@TYPE: Image
#@NAME: LMP Base
#@DESCRIPTION: LMP Base

CORE_IMAGE_BASE_INSTALL:append = " \
    i2c-tools \
    klish \
    libmbim \
    libqmi \
    modemmanager \
    mosquitto \
    mosquitto-clients \
    networkmanager \
    nvme-cli \
    packagegroup-core-buildessential \
    python3-numpy \
    python3-paho-mqtt \
    python3-pip \
    python3-pyserial \
    python3-pyserial-asyncio \
    python3-pyudev \
    python3-pyyaml \
    python3-xmltodict \
    spitools \
"

# packagegroup-core-buildessential
# packagegroup-self-hosted # DISTRO_FEATURES x11
