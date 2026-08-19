TERMUX_PKG_HOMEPAGE=https://pandas.pydata.org/
TERMUX_PKG_DESCRIPTION="Powerful, flexible and easy to use open source data analysis and manipulation tool"
TERMUX_PKG_LICENSE="BSD-3-Clause"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@luuluka"
TERMUX_PKG_VERSION="3.0.5"
TERMUX_PKG_SRCURL=https://pypi.io/packages/source/p/pandas/pandas-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=dca3734d6ab7c906e6730f0788b0a1dbb9f2467731f9711f77995c8e9d62d712
TERMUX_PKG_DEPENDS="python, python-pip, python-numpy"
TERMUX_PKG_PYTHON_COMMON_BUILD_DEPS="meson-python, 'Cython>=3.0', versioneer"
# NOTE: no TERMUX_PKG_BUILD_IN_SRC — meson-python rejects source==build dir

# pandas sdist builds with meson-python + Cython; numpy comes from the
# termux python-numpy package (headers + runtime). Meson probes that need
# host python (generate_version.py + np.get_include) are patched away:
#   meson-build-fixed-version.patch   -> version hardcoded
#   pandas-meson-numpy-path.patch     -> numpy include path hardcoded
termux_step_pre_configure() {
	# pandas' ninja custom commands run with HOST python3 (/usr/bin/python3)
	# (e.g. generate_pxi.py -> `from Cython import Tempita`); install Cython
	# into the host python so those probes/build steps work.
	export PATH="$TERMUX_PREFIX/bin:$PATH"
	if /usr/bin/python3 -c "import Cython" 2>/dev/null; then
		echo "==> host python3 has Cython"
	else
		echo "==> installing Cython into host python3"
		/usr/bin/python3 -m pip install --break-system-packages Cython \
			|| echo "==> host pip install FAILED (continuing)"
	fi
	# hardcode numpy include path (meson probes np.get_include() via host python3)
	sed -i "s|incdir_numpy = run_command(.*|incdir_numpy = '/data/data/com.termux/files/usr/lib/python3.14/site-packages/numpy/_core/include'|" \
		"$TERMUX_PKG_SRCDIR/pandas/meson.build" 2>/dev/null || true
}

termux_step_make() {
	:
}