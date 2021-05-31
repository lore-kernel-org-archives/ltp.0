From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 May 2021 18:50:50 +0200
Subject: [LTP] [PATCH 1/3] build.sh: Rewrite to allow running certain step
In-Reply-To: <20210531165052.8731-1-pvorel@suse.cz>
References: <20210531165052.8731-1-pvorel@suse.cz>
Message-ID: <20210531165052.8731-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

i.e. only autotools / configure / make / make install

Required for GitHub Actions CI.

+ add missing -i in docs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 195 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 110 insertions(+), 85 deletions(-)

diff --git a/build.sh b/build.sh
index 9335595ca..b3b1eb962 100755
--- a/build.sh
+++ b/build.sh
@@ -15,17 +15,56 @@ CC="${CC:-gcc}"
 DEFAULT_PREFIX="$HOME/ltp-install"
 DEFAULT_BUILD="native"
 DEFAULT_TREE="in"
+
 CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite $CONFIGURE_OPT_EXTRA"
 # TODO: open posix testsuite is currently broken in out-tree-build. Enable it once it's fixed.
 CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite $CONFIGURE_OPT_EXTRA"
+
+SRC_DIR="$(cd $(dirname $0); pwd)"
+BUILD_DIR="$SRC_DIR/../ltp-build"
+
 MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
+MAKE_OPTS_OUT_TREE="$MAKE_OPTS -C $BUILD_DIR -f $SRC_DIR/Makefile top_srcdir=$SRC_DIR top_builddir=$BUILD_DIR"
 
-build_32()
+run_configure()
 {
-	local dir
+	local configure="$1"
+	shift
+
+	export CC CFLAGS LDFLAGS PKG_CONFIG_LIBDIR
+	echo "CC='$CC' CFLAGS='$CFLAGS' LDFLAGS='$LDFLAGS' PKG_CONFIG_LIBDIR='$PKG_CONFIG_LIBDIR'"
+
+	echo "=== configure $configure $@ ==="
+	if ! $configure $@; then
+		echo "== ERROR: configure failed, config.log =="
+		cat config.log
+		exit 1
+	fi
+
+	echo "== include/config.h =="
+	cat include/config.h
+}
+
+configure_in_tree()
+{
+	run_configure ./configure $CONFIGURE_OPTS_IN_TREE --prefix=$prefix $@
+}
+
+configure_out_tree()
+{
+	mkdir -p $BUILD_DIR
+	cd $BUILD_DIR
+	run_configure $SRC_DIR/configure $CONFIGURE_OPTS_OUT_TREE $@
+}
+
+configure_32()
+{
+	local tree="$1"
+	local prefix="$2"
 	local arch="$(uname -m)"
+	local dir
 
-	echo "===== 32-bit ${1}-tree build into $PREFIX ====="
+	echo "===== 32-bit ${tree}-tree build into $prefix ====="
 
 	if [ -z "$PKG_CONFIG_LIBDIR" ]; then
 		if [ "$arch" != "x86_64" ]; then
@@ -46,114 +85,67 @@ build_32()
 	fi
 
 	CFLAGS="-m32 $CFLAGS" LDFLAGS="-m32 $LDFLAGS"
-	build $1 $2
+
+	eval configure_${tree}_tree
 }
 
-build_native()
+configure_native()
 {
-	echo "===== native ${1}-tree build into $PREFIX ====="
-	build $1 $2
+	local tree="$1"
+	local prefix="$2"
+
+	echo "===== native ${tree}-tree build into $prefix ====="
+	eval configure_${tree}_tree
 }
 
-build_cross()
+configure_cross()
 {
+	local tree="$1"
+	local prefix="$2"
 	local host=$(basename "${CC%-gcc}")
+
 	if [ "$host" = "gcc" ]; then
 		echo "Invalid CC variable for cross compilation: $CC (clang not supported)" >&2
 		exit 1
 	fi
 
-	echo "===== cross-compile ${host} ${1}-tree build into $PREFIX ====="
-	build $1 $2 "--host=$host"
+	echo "===== cross-compile ${host} ${1}-tree build into $prefix ====="
+	eval configure_${tree}_tree "--host=$host"
 }
 
-build()
+build_in_tree()
 {
-	local tree="$1"
-	local install="$2"
-	shift 2
-
-	echo "=== autotools ==="
-	make autotools
-
-	if [ "$tree" = "in" ]; then
-		build_in_tree $install $@
-	else
-		build_out_tree $install $@
-	fi
+	make $MAKE_OPTS
 }
 
 build_out_tree()
 {
-	local install="$1"
-	shift
-
-	local tree="$PWD"
-	local build="$tree/../ltp-build"
-	local make_opts="$MAKE_OPTS -C $build -f $tree/Makefile top_srcdir=$tree top_builddir=$build"
-
-	mkdir -p $build
-	cd $build
-	run_configure $tree/configure $CONFIGURE_OPTS_OUT_TREE $@
-
-	echo "=== build ==="
-	make $make_opts
-
-	if [ "$install" = 1 ]; then
-		echo "=== install ==="
-		make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
-	else
-		echo "make install skipped, use -i to run it"
-	fi
+	cd $BUILD_DIR
+	make $MAKE_OPTS_OUT_TREE
 }
 
-build_in_tree()
+install_in_tree()
 {
-	local install="$1"
-	shift
-
-	run_configure ./configure $CONFIGURE_OPTS_IN_TREE --prefix=$PREFIX $@
-
-	echo "=== build ==="
-	make $MAKE_OPTS
-
-	if [ "$install" = 1 ]; then
-		echo "=== install ==="
-		make $MAKE_OPTS install
-	else
-		echo "make install skipped, use -i to run it"
-	fi
+	make $MAKE_OPTS install
 }
 
-run_configure()
+install_out_tree()
 {
-	local configure=$1
-	shift
-
-	export CC CFLAGS LDFLAGS PKG_CONFIG_LIBDIR
-	echo "CC='$CC' CFLAGS='$CFLAGS' LDFLAGS='$LDFLAGS' PKG_CONFIG_LIBDIR='$PKG_CONFIG_LIBDIR'"
-
-	echo "=== configure $configure $@ ==="
-	if ! $configure $@; then
-		echo "== ERROR: configure failed, config.log =="
-		cat config.log
-		exit 1
-	fi
-
-	echo "== include/config.h =="
-	cat include/config.h
+	cd $BUILD_DIR
+	make $MAKE_OPTS_OUT_TREE DESTDIR="$prefix" SKIP_IDCHECK=1 install
 }
 
 usage()
 {
 	cat << EOF
 Usage:
-$0 [ -c CC ] [ -o TREE ] [ -p DIR ] [ -t TYPE ]
+$0 [ -c CC ] [ -i ] [ -o TREE ] [ -p DIR ] [-r RUN ] [ -t TYPE ]
 $0 -h
 
 Options:
 -h       Print this help
--c CC    Define compiler (\$CC variable)
+-c CC    Define compiler (\$CC variable), needed only for configure step
+-i       Run 'make install', needed only for install step
 -o TREE  Specify build tree, default: $DEFAULT_TREE
 -p DIR   Change installation directory. For in-tree build is this value passed
          to --prefix option of configure script. For out-of-tree build is this
@@ -162,17 +154,24 @@ Options:
          DIR/PREFIX (i.e. DIR/opt/ltp).
          Default for in-tree build: '$DEFAULT_PREFIX'
          Default for out-of-tree build: '$DEFAULT_PREFIX/opt/ltp'
--t TYPE  Specify build type, default: $DEFAULT_BUILD
+-r RUN   Run only certain step (usable for CI), default: all
+-t TYPE  Specify build type, default: $DEFAULT_BUILD, only for configure step
 
-BUILD TREE:
+TREE:
 in       in-tree build
 out      out-of-tree build
 
-BUILD TYPES:
+TYPES:
 32       32-bit build (PKG_CONFIG_LIBDIR auto-detection for x86_64)
 cross    cross-compile build (requires set compiler via -c switch)
 native   native build
 
+RUN:
+autotools   run only 'make autotools'
+configure   run only 'configure'
+build       run only 'make'
+install     run only 'make install'
+
 Default configure options:
 in-tree:    $CONFIGURE_OPTS_IN_TREE
 out-of-tree $CONFIGURE_OPTS_OUT_TREE
@@ -181,12 +180,13 @@ configure options can extend the default with \$CONFIGURE_OPT_EXTRA environment
 EOF
 }
 
-PREFIX="$DEFAULT_PREFIX"
+prefix="$DEFAULT_PREFIX"
 build="$DEFAULT_BUILD"
 tree="$DEFAULT_TREE"
-install=0
+install=
+run=
 
-while getopts "c:hio:p:t:" opt; do
+while getopts "c:hio:p:r:t:" opt; do
 	case "$opt" in
 	c) CC="$OPTARG";;
 	h) usage; exit 0;;
@@ -195,7 +195,11 @@ while getopts "c:hio:p:t:" opt; do
 		in|out) tree="$OPTARG";;
 		*) echo "Wrong build tree '$OPTARG'" >&2; usage; exit 1;;
 		esac;;
-	p) PREFIX="$OPTARG";;
+	p) prefix="$OPTARG";;
+	r) case "$OPTARG" in
+		autotools|configure|build|install) run="$OPTARG";;
+		*) echo "Wrong run type '$OPTARG'" >&2; usage; exit 1;;
+		esac;;
 	t) case "$OPTARG" in
 		32|cross|native) build="$OPTARG";;
 		*) echo "Wrong build type '$OPTARG'" >&2; usage; exit 1;;
@@ -204,7 +208,7 @@ while getopts "c:hio:p:t:" opt; do
 	esac
 done
 
-cd `dirname $0`
+cd $SRC_DIR
 
 echo "=== ver_linux ==="
 ./ver_linux
@@ -213,4 +217,25 @@ echo
 echo "=== compiler version ==="
 $CC --version
 
-eval build_$build $tree $install
+if [ -z "$run" -o "$run" = "autotools" ]; then
+	make autotools
+fi
+
+if [ -z "$run" -o "$run" = "configure" ]; then
+	eval configure_$build $tree $prefix
+fi
+
+if [ -z "$run" -o "$run" = "build" ]; then
+	echo "=== build ==="
+	eval build_${tree}_tree
+fi
+
+if [ -z "$run" -o "$run" = "install" ]; then
+	if [ "$install" = 1 ]; then
+		eval install_${tree}_tree
+	else
+		echo "make install skipped, use -i to run it"
+	fi
+fi
+
+exit $?
-- 
2.31.1

