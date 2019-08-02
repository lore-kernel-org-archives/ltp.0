From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  2 Aug 2019 17:04:44 +0200
Subject: [LTP] [PATCH v2 3/4] build.sh: Respect user defined CFLAGS and
 LDFLAGS
In-Reply-To: <20190802150445.10984-1-pvorel@suse.cz>
References: <20190802150445.10984-1-pvorel@suse.cz>
Message-ID: <20190802150445.10984-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Therefore it was needed to export them and not pass as a parameter.

It will be used for travis settings in next commit, but also can be
handy for using build.sh in local development.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/build.sh b/build.sh
index 634ef51b5..3da2adf55 100755
--- a/build.sh
+++ b/build.sh
@@ -21,7 +21,8 @@ CC=gcc
 build_32()
 {
 	echo "===== 32-bit ${1}-tree build into $PREFIX ====="
-	build $1 CFLAGS="-m32" LDFLAGS="-m32"
+	export CFLAGS="-m32 $CFLAGS" LDFLAGS="-m32 $LDFLAGS"
+	build $1
 }
 
 build_native()
@@ -63,7 +64,7 @@ build_out_tree()
 
 	mkdir -p $build
 	cd $build
-	run_configure $tree/configure $CONFIGURE_OPTS_OUT_TREE CC="$CC" $@
+	run_configure $tree/configure $CONFIGURE_OPTS_OUT_TREE CC="$CC" CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS" LDFLAGS="$LDFLAGS" $@
 
 	echo "=== build ==="
 	make $make_opts
-- 
2.22.0

