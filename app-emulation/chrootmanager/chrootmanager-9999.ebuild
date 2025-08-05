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
	strum-0.27.2
	log-0.4.27
	reqwest-0.12.22
	clap-4.5.42
	env_logger-0.11.8
	xml-rs-0.8.27
	tokio-stream-0.1.17
	inquire-0.7.5
	colored-3.0.0
	slint-build-1.12.1
	slint-1.12.1
"

inherit cargo desktop

DESCRIPTION="Gentoo chroot management tool with GUI and CLI"
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
IUSE="gui"

RDEPEND="
	sys-apps/util-linux
	app-arch/tar
	sys-fs/squashfs-tools
	gui? (
		x11-libs/libxcb
		x11-libs/libX11
		media-libs/fontconfig
		media-libs/freetype
	)
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
	# Compile CLI package
	cargo_src_compile --package cli

	# Compile GUI package if requested
	if use gui; then
		cargo_src_compile --package gui
	fi
}

src_install() {
	# Install CLI binary
	newbin target/release/cli chrootmanager-cli

	# Install GUI binary if built
	if use gui; then
		newbin target/release/gui chrootmanager-gui
		# Desktop file for GUI
		make_desktop_entry chrootmanager-gui "Chroot Manager" "utilities-terminal" "System;Utility;"
	fi

	# Install documentation if it exists
	if [[ -f README.md ]]; then
		dodoc README.md
	fi

	# Create a simple documentation file
	cat > "${T}"/README << EOF
Chroot Manager - Gentoo chroot management tool

CLI usage: chrootmanager-cli --help
$(use gui && echo "GUI usage: chrootmanager-gui")
EOF
	dodoc "${T}"/README
}

pkg_postinst() {
	elog "Chroot Manager has been installed."
	elog ""
	elog "CLI usage: chrootmanager-cli --help"
	if use gui; then
		elog "GUI usage: chrootmanager-gui"
	fi
}