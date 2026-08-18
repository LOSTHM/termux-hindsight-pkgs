TERMUX_PKG_HOMEPAGE=https://github.com/MagicStack/uvloop
TERMUX_PKG_DESCRIPTION="Ultra fast asyncio event loop"
TERMUX_PKG_LICENSE="MIT OR Apache-2.0"
TERMUX_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="0.22.1"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/u/uvloop/uvloop-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=6c84bae345b9147082b17371e3dd5d42775bddce91f885499017f4607fdaf39f
TERMUX_PKG_DEPENDS="python, python-pip"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="'Cython~=3.0'"
TERMUX_PKG_BUILD_IN_SRC=true

# uvloop bundles libuv; its setup.py honors LIBUV_CONFIGURE_HOST to run
# libuv's configure in cross-compiling mode (skips run-tests that fail
# when target binaries cannot execute on the build host)
termux_step_pre_configure() {
	export LIBUV_CONFIGURE_HOST=aarch64-linux-android
}

# skip default make (repo Makefiles often have lint targets needing host tools);
# pip/cross-pip install performs the actual build
termux_step_make() {
	:
}
