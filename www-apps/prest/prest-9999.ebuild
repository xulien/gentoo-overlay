# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GIT_COMMIT="44fc5580b38bb6375655ba4cb44e81648ed5bf26"
EGO_PN="github.com/prest/prest"

DESCRIPTION="pREST is a way to serve a RESTful API from any databases written in Go"

DEPEND="dev-lang/go"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 arm"

EGO_VENDOR=(
	github.com/BurntSushi/toml v0.3.0 
	github.com/auth0/go-jwt-middleware v0.0.0-20170425171159-5493cabe49f7 
	github.com/clbanning/mxj v1.8.1 
	github.com/codegangsta/negroni v1.0.0 
	github.com/cznic/ql v1.2.0 
	github.com/dgrijalva/jwt-go v3.2.0+incompatible 
	github.com/fatih/color v1.7.0 
	github.com/fsnotify/fsnotify v1.4.7 
	github.com/go-sql-driver/mysql v1.4.0 
	github.com/gopherjs/gopherjs v0.0.0-20180825215210-0210a2f0f73c 
	github.com/gorilla/context v1.1.1 
	github.com/gorilla/mux v1.6.2 
	github.com/hashicorp/hcl v1.0.0 
	github.com/inconshreveable/mousetrap v1.0.0 
	github.com/jmoiron/sqlx v0.0.0-20180614180643-0dae4fefe7c0 
	github.com/jtolds/gls v4.2.1+incompatible 
	github.com/lib/pq v1.0.0 
	github.com/magiconair/properties v1.8.0 
	github.com/mattn/go-colorable v0.0.9 
	github.com/mattn/go-isatty v0.0.4 
	github.com/mattn/go-sqlite3 v1.9.0 
	github.com/mitchellh/go-homedir v1.0.0 
	github.com/mitchellh/mapstructure v1.0.0 
	github.com/nuveo/log v0.0.0-20180612162145-f88607104ac8 
	github.com/pelletier/go-toml v1.2.0 
	github.com/pmezard/go-difflib v1.0.0 
	github.com/prest/adapters v0.0.0-20180822123645-94d74c9aeb62 
	github.com/prest/cmd v0.0.0-20180710121315-d1de3d3fa1da
	github.com/prest/config v0.0.0-20180822131905-619b86188d0a
	github.com/prest/controllers v0.0.0-20180904124317-b69fb390b8f4 
	github.com/prest/helpers v0.0.0-20180627002842-07dcf603c9a1 
	github.com/prest/middlewares v0.0.0-20180320134728-7080d6f0e4de 
	github.com/prest/statements v0.0.0-20170809141047-0a7bec557aa6 
	github.com/prest/template v0.0.0-20180813172605-d3da479a18c2 
	github.com/smartystreets/assertions v0.0.0-20180820201707-7c9eb446e3cf 
	github.com/smartystreets/goconvey v0.0.0-20180222194500-ef6db91d284a 
	github.com/spf13/afero v1.1.1 
	github.com/spf13/cast v1.2.0 
	github.com/spf13/cobra v0.0.3 
	github.com/spf13/jwalterweatherman v0.0.0-20180814060501-14d3d4c51834 
	github.com/spf13/pflag v1.0.2 
	github.com/spf13/viper v1.1.0 
	github.com/stretchr/testify v1.2.2 
	github.com/urfave/negroni v1.0.0 
	golang.org/x/sys v0.0.0-20180903190138-2b024373dcd9 
	golang.org/x/text v0.3.0 
	google.golang.org/appengine v1.1.0 
	gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127 
	gopkg.in/mattes/migrate.v1 v1.3.2 
	gopkg.in/yaml.v2 v2.2.1 
)

SRC_URI="https://${EGO_PN}/archive/master.tar.gz -> ${PN}-master.tar.gz
	${EGO_VENDOR_URI}"
RESTRICT="mirror"

S=${WORKDIR}/${PN}-master

src_compile() {
	export GOPATH="${S}"
	go get
	go build -o prest ${S}/main.go || die
}

src_install() {
	dobin prest
}
