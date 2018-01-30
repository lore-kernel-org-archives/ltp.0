From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Jan 2018 08:43:49 +0100
Subject: [LTP] [RFC PATCH 1/2] build.sh: Allow to choose in-tree or out-tree
	for all build types
In-Reply-To: <20180130074350.4032-1-pvorel@suse.cz>
References: <20180130074350.4032-1-pvorel@suse.cz>
Message-ID: <20180130074350.4032-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

where build types are: native, 32-bit and cross-compile.
Added new option -o TREE, removed 'out' parameter from -t.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 65 ++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/build.sh b/build.sh
index 6dd7ddf93..4e8357982 100755
--- a/build.sh
+++ b/build.sh
@@ -10,7 +10,8 @@
 set -e
 
 DEFAULT_PREFIX="$HOME/ltp-install"
-DEFAULT_BUILD="build_native"
+DEFAULT_BUILD="native"
+DEFAULT_TREE="in"
 CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite"
 # TODO: open posix testsuite is currently broken in out-tree-build. Enable it once it's fixed.
 CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite"
@@ -19,14 +20,14 @@ CC=
 
 build_32()
 {
-	echo "===== 32-bit in-tree build into $PREFIX ====="
-	build_in_tree CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32"
+	echo "===== 32-bit ${1}-tree build into $PREFIX ====="
+	build $1 CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32"
 }
 
 build_native()
 {
-	echo "===== native in-tree build into $PREFIX ====="
-	build_in_tree
+	echo "===== native ${1}-tree build into $PREFIX ====="
+	build $1
 }
 
 build_cross()
@@ -35,8 +36,23 @@ build_cross()
 	[ -n "$host" ] || \
 		{ echo "Missing CC variable, pass it with -c option." >&2; exit 1; }
 
-	echo "===== cross-compile ${host} in-tree build into $PREFIX ====="
-	build_in_tree "--host=$host" CROSS_COMPILE="${host}-"
+	echo "===== cross-compile ${host} ${1}-tree build into $PREFIX ====="
+	build $1 "--host=$host" CROSS_COMPILE="${host}-"
+}
+
+build()
+{
+	local tree="$1"
+	shift
+
+	echo "=== autotools ==="
+	make autotools
+
+	if [ "$tree" = "in" ]; then
+		build_in_tree $@
+	else
+		build_out_tree $@
+	fi
 }
 
 build_out_tree()
@@ -45,24 +61,19 @@ build_out_tree()
 	local build="$tree/../ltp-build"
 	local make_opts="$MAKE_OPTS -C $build -f $tree/Makefile top_srcdir=$tree top_builddir=$build"
 
-	echo "===== native out-of-tree build into $PREFIX ====="
 	mkdir -p $build
-
-	echo "=== autotools ==="
-	make autotools
-
 	cd $build
-	run_configure $tree/configure $CONFIGURE_OPTS_OUT_TREE CC="$CC"
+	run_configure $tree/configure $CONFIGURE_OPTS_OUT_TREE CC="$CC" $@
 
+	echo "=== build ==="
 	make $make_opts
+
+	echo "=== install ==="
 	make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
 }
 
 build_in_tree()
 {
-	echo "=== autotools ==="
-	make autotools
-
 	run_configure ./configure $CONFIGURE_OPTS_IN_TREE CC="$CC" --prefix=$PREFIX $@
 
 	echo "=== build ==="
@@ -92,12 +103,13 @@ usage()
 {
 	cat << EOF
 Usage:
-$0 [ -c CC ] [ -p DIR ] [ -t TYPE ]
+$0 [ -c CC ] [ -o TREE ] [ -p DIR ] [ -t TYPE ]
 $0 -h
 
 Options:
 -h       Print this help
 -c CC    Define compiler (\$CC variable)
+-o TREE  Specify build tree, default: $DEFAULT_TREE
 -p DIR   Change installation directory. For in-tree build is this value passed
          to --prefix option of configure script. For out-of-tree build is this
          value passed to DESTDIR variable (i.e. sysroot) of make install
@@ -107,27 +119,32 @@ Options:
          Default for out-of-tree build: '$DEFAULT_PREFIX/opt/ltp'
 -t TYPE  Specify build type, default: $DEFAULT_BUILD
 
+BUILD TREE:
+in       in-tree build
+out      out-of-tree build
+
 BUILD TYPES:
 32       32-bit in-tree build
 cross    cross-compile in-tree build (requires set compiler via -c switch)
 native   native in-tree build
-out      out-of-tree build
 EOF
 }
 
 PREFIX="$DEFAULT_PREFIX"
 build="$DEFAULT_BUILD"
+tree="$DEFAULT_TREE"
 
-while getopts "c:hp:t:" opt; do
+while getopts "c:ho:p:t:" opt; do
 	case "$opt" in
 	c) CC="$OPTARG";;
 	h) usage; exit 0;;
+	o) case "$OPTARG" in
+		in|out) tree="$OPTARG";;
+		*) echo "Wrong build tree '$OPTARG'" >&2; usage; exit 1;;
+		esac;;
 	p) PREFIX="$OPTARG";;
 	t) case "$OPTARG" in
-		32) build="build_32";;
-		cross) build="build_cross";;
-		native) build="build_native";;
-		out) build="build_out_tree";;
+		32|cross|native) build="$OPTARG";;
 		*) echo "Wrong build type '$OPTARG'" >&2; usage; exit 1;;
 		esac;;
 	?) usage; exit 1;;
@@ -135,4 +152,4 @@ while getopts "c:hp:t:" opt; do
 done
 
 cd `dirname $0`
-$build
+eval build_$build $tree
-- 
2.16.0

