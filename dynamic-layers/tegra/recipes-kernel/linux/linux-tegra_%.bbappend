FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://can.cfg \
    file://hw-random-tegra.cfg \
"

PV = "${LINUX_VERSION}+git${SRCPV}"

KCONFIG_MODE = "--alldefconfig"

LINUX_VERSION_EXTENSION ?= "-lmp-${LINUX_KERNEL_TYPE}"

# Kernel config
# https://git.yoctoproject.org/yocto-kernel-cache/tree/features
# KERNEL_FEATURES:append = " \
#     "

KERNEL_CONFIG_NAME ?= "${KERNEL_PACKAGE_NAME}-config-${KERNEL_ARTIFACT_NAME}"
KERNEL_CONFIG_LINK_NAME ?= "${KERNEL_PACKAGE_NAME}-config"

do_deploy:append() {
    # Publish final kernel config with a proper datetime-based link
    cp -a ${B}/.config ${DEPLOYDIR}/${KERNEL_CONFIG_NAME}
    ln -sf ${KERNEL_CONFIG_NAME} ${DEPLOYDIR}/${KERNEL_CONFIG_LINK_NAME}
}
