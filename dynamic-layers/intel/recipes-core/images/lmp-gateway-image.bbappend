#@TYPE: Image
#@NAME: LMP Gateway Image
#@DESCRIPTION: LMP Gateway Image

CORE_IMAGE_BASE_INSTALL:append = " \
    packagegroup-core-buildessential \
    "
