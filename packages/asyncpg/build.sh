TERMUX_PKG_HOMEPAGE=https://github.com/MagicStack/asyncpg
TERMUX_PKG_DESCRIPTION="Fast PostgreSQL Database Client Library for Python/asyncio"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="0.31.0"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/a/asyncpg/asyncpg-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=c989386c83940bfbd787180f2b1519415e2d3d6277a70d9d0f0145ac73500735
TERMUX_PKG_DEPENDS="python, python-pip"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="'Cython>=3.0'"
TERMUX_PKG_BUILD_IN_SRC=true

# bionic libm is a separate lib: Cython-generated code calling math funcs
# (log10 etc.) needs explicit -lm link or the builtin symbol check fails
termux_step_pre_configure() {
	export LDFLAGS="$LDFLAGS -lm"
}
# skip default make (repo Makefiles often have lint targets needing host tools);
# pip/cross-pip install performs the actual build
termux_step_make() {
	:
}
