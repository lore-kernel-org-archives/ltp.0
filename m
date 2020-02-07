From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Feb 2020 17:28:42 +0100
Subject: [LTP] [PATCH 1/1] build: Disable make install for most of builds
In-Reply-To: <20200207160831.27493-1-pvorel@suse.cz>
References: <20200207160831.27493-1-pvorel@suse.cz>
Message-ID: <20200207162842.GB27725@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> build.sh: add -i option which enables make install (default off)
> Enable it in Debian powerpc64le cross-compilation (out of tree)
> and latest Fedora.

Hm, it requires a fix, below.

Script is getting ugly, but it's just a build script.

Verification:
https://travis-ci.org/pevik/ltp/builds/647410565

diff --git build.sh build.sh
index e12a0b27d..e3d268c83 100755
--- build.sh
+++ build.sh
@@ -24,13 +24,13 @@ build_32()
 {
 	echo "===== 32-bit ${1}-tree build into $PREFIX ====="
 	CFLAGS="-m32 $CFLAGS" LDFLAGS="-m32 $LDFLAGS"
-	build $1
+	build $1 $2
 }
 
 build_native()
 {
 	echo "===== native ${1}-tree build into $PREFIX ====="
-	build $1
+	build $1 $2
 }
 
 build_cross()
@@ -40,7 +40,7 @@ build_cross()
 		{ echo "Missing CC variable, pass it with -c option." >&2; exit 1; }
 
 	echo "===== cross-compile ${host} ${1}-tree build into $PREFIX ====="
-	build $1 "--host=$host" CROSS_COMPILE="${host}-"
+	build $1 $2 "--host=$host" CROSS_COMPILE="${host}-"
 }
 
 build()
@@ -85,6 +85,9 @@ build_out_tree()
 
 build_in_tree()
 {
+	local install="$1"
+	shift
+
 	run_configure ./configure $CONFIGURE_OPTS_IN_TREE --prefix=$PREFIX $@
 
 	echo "=== build ==="
