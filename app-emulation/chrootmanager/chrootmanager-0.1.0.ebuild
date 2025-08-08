# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	sha2-0.10.9
	thiserror-2.0.12
	toml-0.9.4
	home-0.5.11
	tokio-1.47.1
	serde-1.0.219
	log-0.4.27
	reqwest-0.12.22
	clap-4.5.43
	env_logger-0.11.8
	xml-rs-0.8.27
	tokio-stream-0.1.17
	inquire-0.7.5
	colored-3.0.0
"

inherit cargo desktop

DESCRIPTION="Gentoo chroot management tool"
HOMEPAGE="https://github.com/xulien/chrootmanager"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/xulien/chrootmanager.git"
	inherit git-r3
else
	SRC_URI="https://github.com/xulien/chrootmanager/archive/v${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris)"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	sys-apps/util-linux
	app-arch/tar
	sys-fs/squashfs-tools
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

BDEPEND="
	>=virtual/rust-1.70.0
"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	# No features to configure at workspace level
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_install() {
	newbin target/release/chrootmanager chrootmanager

	# Install documentation if it exists
	if [[ -f README.md ]]; then
		dodoc README.md
	fi

	# Create a simple documentation file
	cat > "${T}"/README << EOF
Chroot Manager - Gentoo chroot management tool

Usage: chrootmanager --help

This tool helps manage Gentoo chroots for development and testing.
Commands:
  create    Create a new chroot
  list      List existing chroots
  mirror    Setup mirrors

For more information, see: ${HOMEPAGE}
EOF
	dodoc "${T}"/README
}

pkg_postinst() {
	elog "Chroot Manager has been installed successfully."
	elog ""
	elog "Usage: chrootmanager --help"
	elog ""
	elog "Available commands:"
	elog "  chrootmanager create    - Create a new chroot"
	elog "  chrootmanager list      - List existing chroots"
	elog "  chrootmanager mirror    - Setup mirrors"
}