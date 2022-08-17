#@TYPE: Recipe
#@NAME: Busybox Recipe
#@DESCRIPTION: Busybox Recipe

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://busybox.conf file://busybox.cfg \
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'pam', 'file://busybox-pam.cfg', '', d)} \
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'selinux', 'file://busybox-selinux.cfg', '', d)} \
    "

DEPENDS:append = " \
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'pam', 'libpam', '', d)} \
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'selinux', 'libselinux', '', d)} \
    "

RDEPENDS_${PN}:append = "\
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'pam', 'libpam', '', d)} \
    ${@bb.utils.contains_any('DISTRO_FEATURES', 'selinux', 'libselinux', '', d)} \
    "

FILES_${PN}:append = " ${sysconfdir}"

BUSYBOX_SPLIT_SUID = "0"

do_install:append() {
    install -m 0644 ${WORKDIR}/busybox.conf ${D}${sysconfdir}
}
