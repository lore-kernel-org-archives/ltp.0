From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jun 2021 20:38:26 +0200
Subject: [LTP] [RFC PATCH 2/3] build.sh: Add support for make check
In-Reply-To: <20210603183827.24339-1-pvorel@suse.cz>
References: <20210603183827.24339-1-pvorel@suse.cz>
Message-ID: <20210603183827.24339-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 build.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/build.sh b/build.sh
index 240ce8e68..c892fa87b 100755
--- a/build.sh
+++ b/build.sh
@@ -119,6 +119,17 @@ build_out_tree()
 	make $MAKE_OPTS_OUT_TREE
 }
 
+check_in_tree()
+{
+	make check
+}
+
+check_out_tree()
+{
+	cd $BUILD_DIR
+	make $MAKE_OPTS_OUT_TREE check
+}
+
 install_in_tree()
 {
 	make $MAKE_OPTS install
@@ -165,6 +176,7 @@ RUN:
 autotools   run only 'make autotools'
 configure   run only 'configure'
 build       run only 'make'
+check       run only 'make check'
 install     run only 'make install'
 
 Default configure options:
@@ -192,7 +204,7 @@ while getopts "c:hio:p:r:t:" opt; do
 		esac;;
 	p) prefix="$OPTARG";;
 	r) case "$OPTARG" in
-		autotools|configure|build|install) run="$OPTARG";;
+		autotools|configure|build|check|install) run="$OPTARG";;
 		*) echo "Wrong run type '$OPTARG'" >&2; usage; exit 1;;
 		esac;;
 	t) case "$OPTARG" in
@@ -218,6 +230,10 @@ if [ -z "$run" -o "$run" = "build" ]; then
 	eval build_${tree}_tree
 fi
 
+if [ -z "$run" -o "$run" = "check" ]; then
+	eval check_${tree}_tree
+fi
+
 if [ -z "$run" -o "$run" = "install" ]; then
 	if [ "$install" = 1 ]; then
 		eval install_${tree}_tree
-- 
2.31.1

