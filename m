From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 10 Dec 2019 09:04:17 +0100
Subject: [LTP] [PATCH v4 1/3] tst_test.sh: Add tst_require_module command
In-Reply-To: <20191210080419.128773-1-lkml@jv-coder.de>
References: <20191210080419.128773-1-lkml@jv-coder.de>
Message-ID: <20191210080419.128773-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Adds a new library function tst_require_module, that can be used, when a
test needs a module dynamically at runtime

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 doc/test-writing-guidelines.txt |  3 +++
 testcases/lib/tst_test.sh       | 39 +++++++++++++++++++--------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 546bb7a49..3360f0920 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2184,6 +2184,9 @@ module in a few possible paths.
 If module was found the path to it will be stored into '$TST_MODPATH'
 variable, if module wasn't found the test will exit with 'TCONF'.
 
+Alternatively the 'tst_require_module()' function can be used to do the same
+at runtime.
+
 2.3.3 Optional command line parameters
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 70c1ef2e3..afee6aac5 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -461,6 +461,27 @@ _tst_require_root()
 	fi
 }
 
+tst_require_module()
+{
+	local _tst_module=$1
+
+	for tst_module in "$_tst_module" \
+	                  "$LTPROOT/testcases/bin/$_tst_module" \
+	                  "$TST_STARTWD/$_tst_module"; do
+
+			if [ -f "$tst_module" ]; then
+				TST_MODPATH="$tst_module"
+				break
+			fi
+	done
+	
+	if [ -n "$TST_MODPATH" ]; then
+		tst_res TINFO "Found module at '$TST_MODPATH'"
+	else
+		tst_brk TCONF "Failed to find module '$_tst_module'"
+	fi
+}
+
 tst_run()
 {
 	local _tst_i
@@ -552,23 +573,7 @@ tst_run()
 		TST_DEVICE_FLAG=1
 	fi
 
-	if [ -n "$TST_NEEDS_MODULE" ]; then
-		for tst_module in "$TST_NEEDS_MODULE" \
-		                  "$LTPROOT/testcases/bin/$TST_NEEDS_MODULE" \
-		                  "$TST_STARTWD/$TST_NEEDS_MODULE"; do
-
-				if [ -f "$tst_module" ]; then
-					TST_MODPATH="$tst_module"
-					break
-				fi
-		done
-
-		if [ -z "$TST_MODPATH" ]; then
-			tst_brk TCONF "Failed to find module '$TST_NEEDS_MODULE'"
-		else
-			tst_res TINFO "Found module at '$TST_MODPATH'"
-		fi
-	fi
+	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
 	if [ -n "$TST_SETUP" ]; then
 		$TST_SETUP
-- 
2.20.1

