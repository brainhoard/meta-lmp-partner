#@TYPE: Recipe
#@NAME: ModemAgent
#@DESCRIPTION: ModemAgent for monitoring Sierra Wireless modem modules

SUMMARY = "An agent for monitoring Sierra Wireless modem modules"
HOMEPAGE = "https://github.com/brainhoard/modemAgent"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/brainhoard/modemAgent.git;branch=master;protocol=https"

SRCREV = "${AUTOREV}"
PV = "3.0+git${SRCPV}"

S = "${WORKDIR}/git"

inherit python3native python3-dir systemd

DEPENDS = " \
    base-passwd \
    "

RDEPENDS:${PN} = " \
    libmbim \
    libqmi \
    mosquitto \
    mosquitto-clients \
    python3-core \
    python3-paho-mqtt \
    python3-pyudev \
    python3-pyserial \
    "

# RCONFLICTS:${PN} = " \
#     modemmanager \
#     "

SYSTEMD_SERVICE:${PN} = "qmi-proxy.service"

do_compile() {
    python3 -m compileall ${S}
}

do_install() {

    install -d ${D}${sbindir}
    install -d ${D}${libexecdir}
    install -d ${D}${systemd_user_unitdir}
    install -d ${D}${systemd_system_unitdir}
    install -d ${D}${sysconfdir}/udev/rules.d
    install -d ${D}${PYTHON_SITEPACKAGES_DIR}

    install -m 0644 ${S}/libLoggingMqtt.py ${D}${PYTHON_SITEPACKAGES_DIR}
    install -m 0644 ${S}/libModemAt.py ${D}${PYTHON_SITEPACKAGES_DIR}
    install -m 0644 ${S}/libModemQmi.py ${D}${PYTHON_SITEPACKAGES_DIR}

    install -m 0664 -g plugdev ${S}/modemAgent-modem0.conf ${D}${sysconfdir}
    install -m 0664 -g plugdev ${S}/modemAgent-modem1.conf ${D}${sysconfdir}

    install -m 0644 ${S}/modemAgentUdev.rules ${D}${sysconfdir}/udev/rules.d/25-modemAgentUdev.rules
    install -m 0755 ${S}/modemAgentUdev.sh ${D}${libexecdir}

    install -m 0644 ${S}/mbim-proxy.service ${D}${systemd_system_unitdir}
    install -m 0644 ${S}/qmi-proxy.service ${D}${systemd_system_unitdir}

    install -m 0755 ${S}/modemAgent.py ${D}${sbindir}
    install -m 0644 ${S}/modemAgent@.service ${D}${systemd_system_unitdir}

    install -m 0755 ${S}/modemAgentConf.py ${D}${sbindir}
    install -m 0644 ${S}/modemAgentConf@.service ${D}${systemd_system_unitdir}

    install -m 0755 ${S}/modemAgentProf.py ${D}${sbindir}

    install -m 0755 ${S}/modemAgentWwan.py ${D}${sbindir}
    install -m 0644 ${S}/modemAgentWwan.service ${D}${systemd_system_unitdir}

	sed -i \
        -e 's:#BASE_BINDIR#:${base_bindir}:g' \
        -e 's:#BINDIR#:${bindir}:g' \
        -e 's:#DATADIR#:${datadir}:g' \
        -e 's:#LIBDIR#:${libdir}:g' \
        -e 's:#LIBEXECDIR#:${libexecdir}:g' \
        -e 's:#LOCALSTATEDIR#:${localstatedir}:g' \
        -e 's:#SBINDIR#:${sbindir}:g' \
        -e 's:#SYSCONFDIR#:${sysconfdir}:g' \
        -e 's:#SYSTEMD_SYSTEM_UNITDIR#:${systemd_system_unitdir}:g' \
        -e 's:#SYSTEMD_UNITDIR#:${systemd_unitdir}:g' \
        -e 's:#SYSTEMD_USER_UNITDIR#:${systemd_user_unitdir}:g' \
        ${D}${sysconfdir}/udev/rules.d/25-modemAgentUdev.rules \
        ${D}${systemd_system_unitdir}/*.service
}

FILES:${PN} = " \
    ${sbindir} \
    ${libexecdir} \
    ${sysconfdir} \
    ${systemd_user_unitdir} \
    ${systemd_system_unitdir} \
    ${PYTHON_SITEPACKAGES_DIR} \
    "
