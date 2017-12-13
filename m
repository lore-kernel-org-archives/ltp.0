From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Dec 2017 14:13:34 +0100
Subject: [LTP] [RFC PATCH 3/3] build.sh: Allow to overwrite prefix
Message-ID: <20171213131334.26863-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

with LTP_PREFIX environment variable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Note about using environment variables and parameters not prefixed with '-' (no options):
I like getopt(s) and the reason I didn't use them is:
* I don't like short opts which provides getopts build-in (the one we use in LTP).
* Long getopts are supported by getopt binary from util-linux which I didn't
  want to depend on.
---
 build.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/build.sh b/build.sh
index 29da4d29e..bf791d083 100755
--- a/build.sh
+++ b/build.sh
@@ -9,9 +9,9 @@
 
 set -e
 
-PREFIX="$HOME/ltp-install"
+LTP_PREFIX="${LTP_PREFIX:-$HOME/ltp-install}"
 
-CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite --prefix=$PREFIX"
+CONFIGURE_OPTS_IN_TREE="--with-open-posix-testsuite --with-realtime-testsuite --prefix=$LTP_PREFIX"
 
 # TODO: open posix testsuite is currently broken in out-tree-build. Enable it once it's fixed.
 CONFIGURE_OPTS_OUT_TREE="--with-realtime-testsuite"
@@ -20,13 +20,13 @@ MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
 
 build_32()
 {
-	echo "===== 32-bit in-tree build into $PREFIX ====="
+	echo "===== 32-bit in-tree build into $LTP_PREFIX ====="
 	build_in_tree CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32"
 }
 
 build_native()
 {
-	echo "===== native in-tree build into $PREFIX ====="
+	echo "===== native in-tree build into $LTP_PREFIX ====="
 	build_in_tree
 }
 
@@ -37,7 +37,7 @@ build_cross()
 	[ -n "$host" ] || \
 		{ echo "Missing CROSS_COMPILE and CC variables. You need to set at least one" >&2; exit 1; }
 
-	echo "===== cross-compile ${host} in-tree build into $PREFIX ====="
+	echo "===== cross-compile ${host} in-tree build into $LTP_PREFIX ====="
 	build_in_tree "--host=$host" CROSS_COMPILE="${host}-"
 }
 
@@ -47,7 +47,7 @@ build_out_tree()
 	local build="$tree/../ltp-build"
 	local make_opts="$MAKE_OPTS -C $build -f $tree/Makefile top_srcdir=$tree top_builddir=$build"
 
-	echo "===== native out-of-tree build into $PREFIX ====="
+	echo "===== native out-of-tree build into $LTP_PREFIX ====="
 	mkdir -p $build
 
 	echo "=== autotools ==="
@@ -64,7 +64,7 @@ build_out_tree()
 	cat include/config.h
 
 	make $make_opts
-	make $make_opts DESTDIR="$PREFIX" SKIP_IDCHECK=1 install
+	make $make_opts DESTDIR="$LTP_PREFIX" SKIP_IDCHECK=1 install
 }
 
 build_in_tree()
@@ -106,6 +106,9 @@ native  native in-tree build
 out     out-of-tree build
 
 Default build is native in-tree build.
+
+LTP is installed into '$LTP_PREFIX'.
+The destination can be changed by setting LTP_PREFIX environment variable.
 EOF
 }
 
-- 
2.15.0

