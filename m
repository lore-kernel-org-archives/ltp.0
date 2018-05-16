From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 14:39:23 +0200
Subject: [LTP] [RFC PATCH 1/2] lib/tst_test.sh: TST_TESTFUNC_DATA and
	TST_TESTFUNC_DATA_IFS
In-Reply-To: <20180516123924.11047-1-pvorel@suse.cz>
References: <20180516123924.11047-1-pvorel@suse.cz>
Message-ID: <20180516123924.11047-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is specific only for shell.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
If we accept it, it's a question if pass iteration number as well
(and if yes, maybe it should be in $1 and data in $2).

Kind regards,
Petr
---
 doc/test-writing-guidelines.txt | 23 +++++++++++++++++++++++
 testcases/lib/tst_test.sh       | 20 ++++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 8e405a034..2184f6365 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1485,6 +1485,29 @@ Otherwise, if '$TST_CNT' is set but there is no '$\{TST_TESTFUNC\}1', etc.,
 the '$TST_TESTFUNC' is executed '$TST_CNT' times and the test number is passed
 to it in the '$1'.
 
+[source,sh]
+-------------------------------------------------------------------------------
+#!/bin/sh
+#
+# Example test with tests using TST_TESTFUNC_DATA
+#
+
+TST_TESTFUNC=do_test
+TST_TESTFUNC_DATA="foo bar"
+. tst_test.sh
+
+do_test()
+{
+	1) tst_res TPASS "Test passed with data '$1'";;
+}
+
+tst_run
+-------------------------------------------------------------------------------
+
+It's possible to pass data for function with '$TST_TESTFUNC_DATA'. Optional
+'$TST_TESTFUNC_DATA_IFS' variable is supported to set '$IFS' for splitting.
+'$TST_TESTFUNC_DATA' cannot be mixed with '$TST_CNT'.
+
 2.3.2 Library variables
 ^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34b6..31bf51e10 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -246,7 +246,7 @@ tst_rescmp()
 
 tst_run()
 {
-	local tst_i
+	local tst_i ifs
 
 	if [ -n "$TST_TEST_PATH" ]; then
 		for tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
@@ -255,7 +255,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			IPV6);;
+			IPV6|TESTFUNC_DATA|TESTFUNC_DATA_IFS);;
 			*) tst_res TWARN "Reserved variable TST_$tst_i used!";;
 			esac
 		done
@@ -364,6 +364,18 @@ tst_run()
 					TST_COUNT=$((TST_COUNT+1))
 				done
 			fi
+		elif [ -n "$TST_TESTFUNC_DATA" ]; then
+			if [ -n "$TST_TESTFUNC_DATA_IFS" ]; then
+				ifs="$IFS"
+				IFS="$TST_TESTFUNC_DATA_IFS"
+			fi
+			for tst_i in $TST_TESTFUNC_DATA; do
+				[ -n "$ifs" ] && IFS="$ifs"
+				local res=$(tst_resstr)
+				$TST_TESTFUNC $tst_i
+				tst_rescmp "$res"
+				TST_COUNT=$((TST_COUNT+1))
+			done
 		else
 			local res=$(tst_resstr)
 			$TST_TESTFUNC
@@ -400,6 +412,10 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 		tst_brk TBROK "TST_TESTFUNC is not defined"
 	fi
 
+	if [ -n "$TST_CNT" -a -n "$TST_TESTFUNC_DATA" ]; then
+		tst_brk TBROK "TST_CNT cannot be mixed with TST_TESTFUNC_DATA"
+	fi
+
 	if [ -n "$TST_CNT" ]; then
 		if ! tst_is_int "$TST_CNT"; then
 			tst_brk TBROK "TST_CNT must be integer"
-- 
2.16.3

