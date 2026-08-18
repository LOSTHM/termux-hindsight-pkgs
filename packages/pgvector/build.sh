TERMUX_PKG_HOMEPAGE=https://github.com/pgvector/pgvector
TERMUX_PKG_DESCRIPTION="Open-source vector similarity search for Postgres"
TERMUX_PKG_LICENSE="PostgreSQL"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="0.8.6"
TERMUX_PKG_SRCURL=https://github.com/pgvector/pgvector/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=10bf9938906e5d643bbc4a7eea104b6f57ba4898e5b76b20e60484ea1d5a7f8f
TERMUX_PKG_DEPENDS="postgresql"
TERMUX_PKG_BUILD_IN_SRC=true

# vector.so calls acos/log etc.: bionic needs explicit -lm
termux_step_pre_configure() {
	export LDFLAGS="$LDFLAGS -lm"
}

termux_step_make() {
	# OPTFLAGS="" → portable build; default -march=native is rejected by
	# clang (termux CC) with "unsupported argument 'native'"
	make PG_CONFIG=$TERMUX_PREFIX/bin/pg_config \
		OPTFLAGS="" \
		LDFLAGS="$LDFLAGS" \
		-j"${TERMUX_PKG_MAKE_PROCESSES}"
}

termux_step_make_install() {
	make PG_CONFIG=$TERMUX_PREFIX/bin/pg_config OPTFLAGS="" LDFLAGS="$LDFLAGS" install
}