From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  9 Oct 2019 08:16:18 +0200
Subject: [LTP] [PATCH 1/2] tst_test.sh: Add TST_USES_MODULE
In-Reply-To: <20191009061619.48677-1-lkml@jv-coder.de>
References: <20191009061619.48677-1-lkml@jv-coder.de>
Message-ID: <20191009061619.48677-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Adds a new library variable TST_USES_MODULE, that can be used, when a
test may need a module, but should not fail, if the module is not available.
---
 doc/test-writing-guidelines.txt |  4 ++-
 testcases/lib/tst_test.sh       | 50 ++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index cd0d28b8e..4a0652a8d 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2125,6 +2125,8 @@ simply by setting right '$TST_NEEDS_FOO'.
 | 'TST_NEEDS_CMDS'   | String with command names that has to be present for
                        the test (see below).
 | 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
+| 'TST_USES_MODULE'  | Same as TST_NEEDS_MODULE, except that a missing module
+|                    | is not an error.
 | 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
 |=============================================================================
 
@@ -2174,7 +2176,7 @@ Locating kernel modules
 +++++++++++++++++++++++
 
 The LTP build system can build kernel modules as well, setting
-'$TST_NEEDS_MODULE' to module name will cause to library to look for the
+'$TST_NEEDS_MODULE' to module name will cause the library to look for the
 module in a few possible paths.
 
 If module was found the path to it will be stored into '$TST_MODPATH'
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e0b24c6b9..c70a5abbe 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -396,6 +396,32 @@ _tst_require_root()
 	fi
 }
 
+_tst_find_module()
+{
+	local _tst_module=$1
+	local _tst_is_required=${2:-0}
+
+	for tst_module in "$_tst_module" \
+						"$LTPROOT/testcases/bin/$_tst_module" \
+						"$TST_STARTWD/$_tst_module"; do
+
+			if [ -f "$tst_module" ]; then
+				TST_MODPATH="$tst_module"
+				break
+			fi
+	done
+
+	if [ -z "$TST_MODPATH" ]; then
+		if [ $_tst_is_required -eq 1 ]; then
+			tst_brk TCONF "Failed to find module '$_tst_module'"
+		else
+			tst_res TINFO "Module '$_tst_module' not found."
+		fi
+	else
+		tst_res TINFO "Found module at '$TST_MODPATH'"
+	fi
+}
+
 tst_run()
 {
 	local _tst_i
@@ -410,7 +436,7 @@ tst_run()
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
-			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
+			NEEDS_CMDS|NEEDS_MODULE|USES_MODULE|MODPATH|DATAROOT);;
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
@@ -487,22 +513,12 @@ tst_run()
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
+	if [ -n "$TST_NEEDS_MODULE" ] && [ -n "$TST_USES_MODULE" ]; then
+		tst_brk TBROK "Setting TST_NEEDS_MODULE and TST_USES_MODULE at the same time is not allowed"
+	elif [ -n "$TST_NEEDS_MODULE" ]; then
+		_tst_find_module "$TST_NEEDS_MODULE" 1
+	elif [ -n "$TST_USES_MODULE" ]; then
+		_tst_find_module "$TST_USES_MODULE" 0
 	fi
 
 	if [ -n "$TST_SETUP" ]; then
-- 
2.20.1

