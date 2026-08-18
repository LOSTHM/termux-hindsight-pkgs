TERMUX_PKG_HOMEPAGE=https://github.com/openai/tiktoken
TERMUX_PKG_DESCRIPTION="Fast BPE tokeniser for use with OpenAI's models"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="0.14.0"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/t/tiktoken/tiktoken-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=231dec90efcdccf1b565a1416107736f1e09b1a08fe736ef9d6363e626d03874
TERMUX_PKG_DEPENDS="python, python-pip"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="wheel, setuptools-rust"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
	termux_setup_rust
}

termux_step_post_configure() {
	export CARGO_BUILD_TARGET=${CARGO_TARGET_NAME}
	export PYO3_CROSS_LIB_DIR=$TERMUX_PREFIX/lib
}