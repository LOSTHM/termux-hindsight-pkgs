TERMUX_PKG_HOMEPAGE=https://github.com/samuelcolvin/watchfiles
TERMUX_PKG_DESCRIPTION="Simple, modern and high performance file watching and code reload in python"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="1.2.0"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/w/watchfiles/watchfiles-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=c995fba777f1ea992f090f9236e9284cf7a5d1a0130dd5a3d82c598cacd76838
TERMUX_PKG_DEPENDS="python, python-pip"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="wheel"
TERMUX_PKG_PYTHON_CROSS_BUILD_DEPS="maturin"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	termux_setup_rust
	export CARGO_BUILD_TARGET="${CARGO_TARGET_NAME}"
	export PYO3_CROSS_LIB_DIR="${TERMUX_PREFIX}/lib"
	export ANDROID_API_LEVEL="${TERMUX_PKG_API_LEVEL}"
	export CFLAGS_${CARGO_TARGET_NAME//-/_}+=" -I$TERMUX_PREFIX/include/python$TERMUX_PYTHON_VERSION"
}

# default make runs the repo Makefile's lint target (uv run ruff) — skip it;
# cross-pip install below performs the actual build
termux_step_make() {
	:
}

termux_step_make_install() {
	# Needed by maturin
	export ANDROID_API_LEVEL="$TERMUX_PKG_API_LEVEL"
	# --no-build-isolation is needed to ensure that maturin is not built for
	# cross-python and picked up for execution instead of maturin built for
	# build-python
	cross-pip install --no-build-isolation --no-deps . --prefix $TERMUX_PREFIX
}