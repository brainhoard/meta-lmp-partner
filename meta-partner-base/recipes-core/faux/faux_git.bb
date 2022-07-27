#@TYPE: Recipe
#@NAME: Faux Library
#@DESCRIPTION: Faux Library

DESCRIPTION = "Faux Library"

SRC_URI = "git://github.com/pkun/faux.git;branch=master;protocol=https"

SRC_URI[sha256sum] = "1100668da0dce42a52971e4e57e494382de5740326e7080dc077af901379a490"

SRCREV = "${AUTOREV}"

PV = "1.1.0+git${SRCPV}"

S = "${WORKDIR}/git"

LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://LICENCE;md5=763c2d89173e7008fab9b7ecf2605ab5"

inherit autotools

EXTRA_OECONF = ""
