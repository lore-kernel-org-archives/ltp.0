From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Feb 2020 17:08:31 +0100
Subject: [LTP] [PATCH 1/1] build: Disable make install for most of builds
Message-ID: <20200207160831.27493-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

build.sh: add -i option which enables make install (default off)
Enable it in Debian powerpc64le cross-compilation (out of tree)
and latest Fedora.

This 1) speedup builds 2) fixes often "No space left on device" on s390x.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml |  7 ++++---
 build.sh    | 32 +++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 3ef42f029..df233f43e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -14,7 +14,7 @@ matrix:
 
         # cross compilation builds
         - os: linux
-          env: DISTRO=debian:stable VARIANT=cross-compile.ppc64le TREE=out
+          env: DISTRO=debian:stable VARIANT=cross-compile.ppc64le TREE=out MAKE_INSTALL=1
           compiler: powerpc64le-linux-gnu-gcc
 
         - os: linux
@@ -46,7 +46,7 @@ matrix:
 
         # other builds
         - os: linux
-          env: DISTRO=fedora:latest
+          env: DISTRO=fedora:latest MAKE_INSTALL=1
           compiler: clang
 
         - os: linux
@@ -99,6 +99,7 @@ before_install:
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
+    - if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
     - if [ ! "$TREE" ]; then TREE="in"; fi
     - case $VARIANT in cross-compile*) BUILD="cross";; i386) BUILD="32";; *) BUILD="native";; esac
-    - docker run -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC"
+    - docker run -t ltp /bin/sh -c "cd travis && ./$INSTALL.sh && if [ \"$VARIANT\" ]; then ./$INSTALL.$VARIANT.sh; fi && ../build.sh -o $TREE -t $BUILD -c $CC $INSTALL_OPT"
diff --git a/build.sh b/build.sh
index c6d146335..e12a0b27d 100755
--- a/build.sh
+++ b/build.sh
@@ -46,20 +46,24 @@ build_cross()
 build()
 {
 	local tree="$1"
-	shift
+	local install="$2"
+	shift 2
 
 	echo "=== autotools ==="
 	make autotools
 
 	if [ "$tree" = "in" ]; then
-		build_in_tree $@
+		build_in_tree $install $@
 	else
-		build_out_tree $@
+		build_out_tree $install $@
 	fi
 }
 
 build_out_tree()
 {
+	local install="$1"
+	shift
+
 	local tree="$PWD"
 	local build="$tree/../ltp-build"
 	local make_opts="$MAKE_OPTS -C $build -f $tree/Makefile top_srcdir=$tree top_builddir=$build"
@@ -71,8 +75,12 @@ build_out_tree()
 	echo "=== build ==="
 	make $make_opts
 
-	echo "=== install ==="
-	make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
+	if [ "$install" = 1 ]; then
+		echo "=== install ==="
+		make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
+	else
+		echo "make install skipped, use -i to run it"
+	fi
 }
 
 build_in_tree()
@@ -82,8 +90,12 @@ build_in_tree()
 	echo "=== build ==="
 	make $MAKE_OPTS
 
-	echo "=== install ==="
-	make $MAKE_OPTS install
+	if [ "$install" = 1 ]; then
+		echo "=== install ==="
+		make $MAKE_OPTS install
+	else
+		echo "make install skipped, use -i to run it"
+	fi
 }
 
 run_configure()
@@ -139,11 +151,13 @@ EOF
 PREFIX="$DEFAULT_PREFIX"
 build="$DEFAULT_BUILD"
 tree="$DEFAULT_TREE"
+install=0
 
-while getopts "c:ho:p:t:" opt; do
+while getopts "c:hio:p:t:" opt; do
 	case "$opt" in
 	c) CC="$OPTARG";;
 	h) usage; exit 0;;
+	i) install=1;;
 	o) case "$OPTARG" in
 		in|out) tree="$OPTARG";;
 		*) echo "Wrong build tree '$OPTARG'" >&2; usage; exit 1;;
@@ -166,4 +180,4 @@ echo
 echo "=== compiler version ==="
 $CC --version
 
-eval build_$build $tree
+eval build_$build $tree $install
-- 
2.24.1

