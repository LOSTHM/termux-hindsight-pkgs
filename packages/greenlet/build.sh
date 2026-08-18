TERMUX_PKG_HOMEPAGE=https://github.com/python-greenlet/greenlet
TERMUX_PKG_DESCRIPTION="Lightweight coroutines for in-process concurrent programming"
TERMUX_PKG_LICENSE="custom"
TERMUX_PKG_LICENSE_FILE="LICENSE, LICENSE.PSF"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="3.3.2"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/g/greenlet/greenlet-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=2eaf067fc6d886931c7962e8c6bede15d2f01965560f3359b27c80bde2d151f2
TERMUX_PKG_DEPENDS="python, python-pip"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
TERMUX_PKG_BUILD_IN_SRC=true
# NOTE: pinned to 3.3.2 because hindsight-api-slim requires greenlet>=3.2.4,<3.4.0;
#  official termux python-greenlet (3.5.x) does NOT satisfy the upper bound.
# skip default make (repo Makefiles often have lint targets needing host tools);
# pip/cross-pip install performs the actual build
termux_step_make() {
	:
}
