From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  4 Dec 2020 14:09:23 +0100
Subject: [LTP] [PATCH 1/1] build.sh: PKG_CONFIG_LIBDIR auto-detection for
 x86_64
Message-ID: <20201204130923.14693-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

That allows not having to remove 64bit pkg-config
on distros which support both (or define PKG_CONFIG_LIBDIR itself).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested:
https://travis-ci.org/github/pevik/ltp/builds/747398921

Kind regards,
Petr

 build.sh | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/build.sh b/build.sh
index 45669bd91..452cc6f4c 100755
--- a/build.sh
+++ b/build.sh
@@ -22,7 +22,29 @@ MAKE_OPTS="-j$(getconf _NPROCESSORS_ONLN)"
 
 build_32()
 {
+	local dir
+	local arch="$(uname -m)"
+
 	echo "===== 32-bit ${1}-tree build into $PREFIX ====="
+
+	if [ -z "$PKG_CONFIG_LIBDIR" ]; then
+		if [ "$arch" != "x86_64" ]; then
+			echo "ERROR: auto-detection not supported platform $arch, export PKG_CONFIG_LIBDIR!"
+			exit 1
+		fi
+
+		for dir in /usr/lib/i386-linux-gnu/pkgconfig \
+			/usr/lib32/pkgconfig /usr/lib/pkgconfig; do
+			if [ -d "$dir" ]; then
+				PKG_CONFIG_LIBDIR="$dir"
+				break
+			fi
+		done
+		if [ -z "$PKG_CONFIG_LIBDIR" ]; then
+			echo "WARNING: PKG_CONFIG_LIBDIR not found, build might fail"
+		fi
+	fi
+
 	CFLAGS="-m32 $CFLAGS" LDFLAGS="-m32 $LDFLAGS"
 	build $1 $2
 }
@@ -108,8 +130,8 @@ run_configure()
 	local configure=$1
 	shift
 
-	export CC CFLAGS LDFLAGS
-	echo "CC='$CC' CFLAGS='$CFLAGS' LDFLAGS='$LDFLAGS'"
+	export CC CFLAGS LDFLAGS PKG_CONFIG_LIBDIR
+	echo "CC='$CC' CFLAGS='$CFLAGS' LDFLAGS='$LDFLAGS' PKG_CONFIG_LIBDIR='$PKG_CONFIG_LIBDIR'"
 
 	echo "=== configure $configure $@ ==="
 	if ! $configure $@; then
@@ -147,7 +169,7 @@ in       in-tree build
 out      out-of-tree build
 
 BUILD TYPES:
-32       32-bit build
+32       32-bit build (PKG_CONFIG_LIBDIR auto-detection for x86_64)
 cross    cross-compile build (requires set compiler via -c switch)
 native   native build
 EOF
-- 
2.29.2

