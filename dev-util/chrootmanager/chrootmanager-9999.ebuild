# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""

inherit cargo

DESCRIPTION=""
HOMEPAGE="https://github.com/xulien/chrootmanager"

if [ ${PV} == "9999" ] ; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/xulien/chrootmanager"
fi

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"

src_unpack() {
        if [[ "${PV}" == *9999* ]]; then
                git-r3_src_unpack
                cargo_live_src_unpack
        else
                cargo_src_unpack
        fi
}