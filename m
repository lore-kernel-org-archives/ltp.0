From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  2 Aug 2021 19:35:34 +0200
Subject: [LTP] [PATCH v7 5/7] build.sh: Add support for make test{, -c,
 -shell}
In-Reply-To: <20210802173536.19525-1-pvorel@suse.cz>
References: <20210802173536.19525-1-pvorel@suse.cz>
Message-ID: <20210802173536.19525-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v6.

 build.sh | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/build.sh b/build.sh
index 240ce8e68..1767cc21b 100755
--- a/build.sh
+++ b/build.sh
@@ -119,6 +119,17 @@ build_out_tree()
 	make $MAKE_OPTS_OUT_TREE
 }
 
+test_in_tree()
+{
+	make $1
+}
+
+test_out_tree()
+{
+	cd $BUILD_DIR
+	make $MAKE_OPTS_OUT_TREE $1
+}
+
 install_in_tree()
 {
 	make $MAKE_OPTS install
@@ -165,6 +176,9 @@ RUN:
 autotools   run only 'make autotools'
 configure   run only 'configure'
 build       run only 'make'
+test        run only 'make test' (not supported for cross-compile build)
+test-c      run only 'make test-c' (not supported for cross-compile build)
+test-shell  run only 'make test-shell' (not supported for cross-compile build)
 install     run only 'make install'
 
 Default configure options:
@@ -192,7 +206,7 @@ while getopts "c:hio:p:r:t:" opt; do
 		esac;;
 	p) prefix="$OPTARG";;
 	r) case "$OPTARG" in
-		autotools|configure|build|install) run="$OPTARG";;
+		autotools|configure|build|test|test-c|test-shell|install) run="$OPTARG";;
 		*) echo "Wrong run type '$OPTARG'" >&2; usage; exit 1;;
 		esac;;
 	t) case "$OPTARG" in
@@ -218,6 +232,14 @@ if [ -z "$run" -o "$run" = "build" ]; then
 	eval build_${tree}_tree
 fi
 
+if [ -z "$run" -o "$run" = "test" -o "$run" = "test-c" -o "$run" = "test-shell" ]; then
+	if [ "$build" = "cross" ]; then
+		echo "cross-compile build, skipping running tests" >&2
+	else
+		eval test_${tree}_tree $run
+	fi
+fi
+
 if [ -z "$run" -o "$run" = "install" ]; then
 	if [ "$install" = 1 ]; then
 		eval install_${tree}_tree
-- 
2.32.0

