TERMUX_PKG_HOMEPAGE=https://pandas.pydata.org/
TERMUX_PKG_DESCRIPTION="Powerful, flexible and easy to use open source data analysis and manipulation tool"
TERMUX_PKG_LICENSE="BSD-3-Clause"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="2.2.3"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/p/pandas/pandas-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=4f18ba62b61d7e192368b84517265a99b4d7ee8912f8708660fb4a366cc82667
TERMUX_PKG_DEPENDS="python, python-pip, python-numpy"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="meson-python, 'Cython>=3.0', versioneer"
# NOTE: no TERMUX_PKG_BUILD_IN_SRC — meson-python rejects source==build dir

# pandas sdist builds with meson-python + Cython; numpy comes from the
# termux python-numpy package (headers + runtime). Meson probes that need
# host python (generate_version.py + np.get_include) are patched away:
#   meson-build-fixed-version.patch   -> version hardcoded
#   pandas-meson-numpy-path.patch     -> numpy include path hardcoded
termux_step_pre_configure() {
	# meson >=1.14 rejects empty string 'deps' -> replace all occurrences
	find "$TERMUX_PKG_SRCDIR" -name meson.build -exec \
		sed -i "s/ext_dict\.get('deps', '')/ext_dict.get('deps', [])/g" {} +
}

termux_step_make() {
	:
}