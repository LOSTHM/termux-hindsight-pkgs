TERMUX_PKG_HOMEPAGE=https://github.com/MagicStack/httptools
TERMUX_PKG_DESCRIPTION="Fast HTTP parser"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="0.8.0"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/h/httptools/httptools-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=6b2a32f18d97e16e90827d7a819ffa8dbd8cc245fc4e1fa9d1095b54ef4bd999
TERMUX_PKG_DEPENDS="python, python-pip"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="'Cython>=3.0'"
TERMUX_PKG_BUILD_IN_SRC=true
# skip default make (repo Makefiles often have lint targets needing host tools);
# pip/cross-pip install performs the actual build
termux_step_make() {
	:
}
