From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:20:00 +0200
Subject: [LTP] [PATCH v5 3/4] build.sh: Add support for make test
In-Reply-To: <20210714142001.20566-1-pvorel@suse.cz>
References: <20210714142001.20566-1-pvorel@suse.cz>
Message-ID: <20210714142001.20566-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/build.sh b/build.sh
index 240ce8e68..9cb26e899 100755
--- a/build.sh
+++ b/build.sh
@@ -119,6 +119,17 @@ build_out_tree()
 	make $MAKE_OPTS_OUT_TREE
 }
 
+test_in_tree()
+{
+	make test
+}
+
+test_out_tree()
+{
+	cd $BUILD_DIR
+	make $MAKE_OPTS_OUT_TREE test
+}
+
 install_in_tree()
 {
 	make $MAKE_OPTS install
@@ -165,6 +176,7 @@ RUN:
 autotools   run only 'make autotools'
 configure   run only 'configure'
 build       run only 'make'
+test        run only 'make test' (not supported for cross-compile build)
 install     run only 'make install'
 
 Default configure options:
@@ -192,7 +204,7 @@ while getopts "c:hio:p:r:t:" opt; do
 		esac;;
 	p) prefix="$OPTARG";;
 	r) case "$OPTARG" in
-		autotools|configure|build|install) run="$OPTARG";;
+		autotools|configure|build|test|install) run="$OPTARG";;
 		*) echo "Wrong run type '$OPTARG'" >&2; usage; exit 1;;
 		esac;;
 	t) case "$OPTARG" in
@@ -218,6 +230,14 @@ if [ -z "$run" -o "$run" = "build" ]; then
 	eval build_${tree}_tree
 fi
 
+if [ -z "$run" -o "$run" = "test" ]; then
+	if [ "$build" = "cross" ]; then
+		echo "cross-compile build, skipping running tests" >&2
+	else
+		eval test_${tree}_tree
+	fi
+fi
+
 if [ -z "$run" -o "$run" = "install" ]; then
 	if [ "$install" = 1 ]; then
 		eval install_${tree}_tree
-- 
2.32.0

