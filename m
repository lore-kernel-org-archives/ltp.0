From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  4 Dec 2017 13:25:49 +0100
Subject: [LTP] [RFC PATCH v3 1/5] travis: Add build script and use it in
	travis
In-Reply-To: <20171204122553.15338-1-pvorel@suse.cz>
References: <20171204122553.15338-1-pvorel@suse.cz>
Message-ID: <20171204122553.15338-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This script handles native build, 32-bit cross-compile build and
out-of-tree build.

Script is for travis build, but can be used for local builds as well.

For usage run
./build.sh -h

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml |   2 +-
 build.sh    | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100755 build.sh

diff --git a/.travis.yml b/.travis.yml
index d937f9dcf..f2d51f131 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -72,4 +72,4 @@ notifications:
     email:
         secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
 
-script: make autotools && ./configure --prefix $HOME/ltp --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
+script: ./build.sh
diff --git a/build.sh b/build.sh
new file mode 100755
index 000000000..5aaa79ad0
--- /dev/null
+++ b/build.sh
@@ -0,0 +1,110 @@
+#!/bin/sh
+# Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+# Script for travis builds.
+#
+# TODO: Implement comparison of installed files. List of installed files can
+# be used only for local builds as Travis currently doesn't support sharing
+# file between jobs, see
+# https://github.com/travis-ci/travis-ci/issues/6054
+
+set -e
+
+PREFIX="$HOME/ltp-install"
+
+CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite --prefix=$PREFIX"
+
+# TODO: open posix testsuite is currently broken in out-tree-build. Enable it once it's fixed.
+CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite"
+
+MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
+
+build_32()
+{
+	echo "===== 32-bit in-tree build into $PREFIX ====="
+	build_in_tree CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32"
+}
+
+build_native()
+{
+	echo "===== native in tree build into $PREFIX ====="
+	build_in_tree
+}
+
+build_out_tree()
+{
+	local tree="$PWD"
+	local build="$tree/../ltp-build"
+	local make_opts="$MAKE_OPTS -C $build -f $tree/Makefile top_srcdir=$tree top_builddir=$build"
+
+	echo "===== native out-of-tree build into $PREFIX ====="
+	mkdir -p $build
+
+	echo "=== autotools ==="
+	make autotools
+
+	cd $build
+	if ! $tree/configure $CONFIGURE_OPTS; then
+		echo "== ERROR: configure failed, config.log =="
+		cat config.log
+		exit 1
+	fi
+
+	echo "== config.log =="
+	cat config.log
+
+    make $make_opts
+    make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
+}
+
+build_in_tree()
+{
+	echo "=== autotools ==="
+	make autotools
+
+	echo "=== configure ==="
+	if ! ./configure $CONFIGURE_OPTS_IN_TREE $@; then
+		echo "== ERROR: configure failed, config.log =="
+		cat config.log
+		exit 1
+	fi
+
+	echo "== config.log =="
+	cat config.log
+
+	echo "=== build ==="
+	make $MAKE_OPTS
+
+	echo "=== install ==="
+	make $MAKE_OPTS install
+}
+
+usage()
+{
+	cat << EOF
+Usage:
+$0 [ BUILD_TYPE ]
+$0 -h|--help|help
+
+Options:
+-h|--help|help  Print this help
+
+BUILD TYPES:
+32      32-bit in-tree build
+native  native in-tree build
+out     out-of-tree build
+
+Default build is native in-tree build.
+EOF
+}
+
+case "$1" in
+	-h|--help|help) usage; exit 0;;
+	32) build="build_32";;
+	out) build="build_out_tree";;
+	*) build="build_native";;
+esac
+
+cd `dirname $0`
+$build
+
+# vim: set ft=sh ts=4 sts=4 sw=4 noet:
-- 
2.15.0

