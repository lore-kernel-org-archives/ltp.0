From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 18:18:19 +0200
Subject: [LTP] [RFC PATCH v2 1/2] tst_test.sh: Add TST_TEST_DATA and
	TST_TEST_DATA_IFS
In-Reply-To: <20180516161820.3077-1-pvorel@suse.cz>
References: <20180516161820.3077-1-pvorel@suse.cz>
Message-ID: <20180516161820.3077-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is specific only for shell.

+ for consistency the test number is now passed also to functions as the
'$1' in tests using $TST_CNT in separate functions (so that
TST_TEST_DATA is always passed as the '$2').
This is also updated in doc.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 74 +++++++++++++++++++++++++++++++++++++----
 testcases/lib/tst_test.sh       | 22 +++++++++---
 2 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 0bf698183..031823742 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1442,12 +1442,12 @@ TST_CNT=2
 
 test1()
 {
-	tst_res TPASS "Test 1 passed"
+	tst_res TPASS "Test $1 passed"
 }
 
 test2()
 {
-	tst_res TPASS "Test 2 passed"
+	tst_res TPASS "Test $1 passed"
 }
 
 tst_run
@@ -1455,7 +1455,8 @@ tst_run
 
 If '$TST_CNT' is set, the test library looks if there are functions named
 '$\{TST_TESTFUNC\}1', ..., '$\{TST_TESTFUNC\}$\{TST_CNT\}' and if these are
-found they are executed one by one.
+found they are executed one by one. The test number is passed to it in the '$1'.
+
 
 [source,sh]
 -------------------------------------------------------------------------------
@@ -1471,8 +1472,8 @@ TST_CNT=2
 do_test()
 {
 	case $1 in
-	1) tst_res TPASS "Test 1 passed";;
-	2) tst_res TPASS "Test 2 passed";;
+	1) tst_res TPASS "Test $1 passed";;
+	2) tst_res TPASS "Test $1 passed";;
 	esac
 }
 
@@ -1483,6 +1484,65 @@ Otherwise, if '$TST_CNT' is set but there is no '$\{TST_TESTFUNC\}1', etc.,
 the '$TST_TESTFUNC' is executed '$TST_CNT' times and the test number is passed
 to it in the '$1'.
 
+[source,sh]
+-------------------------------------------------------------------------------
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA and
+# $TST_TEST_DATA_IFS
+#
+
+TST_TESTFUNC=do_test
+TST_TEST_DATA="foo:bar:d dd"
+TST_TEST_DATA_IFS=":"
+. tst_test.sh
+
+do_test()
+{
+	tst_res TPASS "Test $1 passed with data '$2'"
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo'
+# test 2 TPASS: Test 2 passed with data 'bar'
+# test 3 TPASS: Test 3 passed with data 'd dd'
+
+-------------------------------------------------------------------------------
+
+It's possible to pass data for function with '$TST_TEST_DATA'. Optional
+'$TST_TEST_DATA_IFS' is used for splitting, default value is space.
+
+[source,sh]
+-------------------------------------------------------------------------------
+#!/bin/sh
+#
+# Example test with tests in a single function, using $TST_TEST_DATA and $TST_CNT
+#
+
+TST_TESTFUNC=do_test
+TST_CNT=2
+TST_TEST_DATA="foo:bar:d dd"
+. tst_test.sh
+
+do_test()
+{
+	case $1 in
+	1) tst_res TPASS "Test $1 passed with data '$2'";;
+	2) tst_res TPASS "Test $1 passed with data '$2'";;
+	esac
+}
+
+tst_run
+# output:
+# test 1 TPASS: Test 1 passed with data 'foo:bar:d'
+# test 2 TPASS: Test 2 passed with data 'foo:bar:d'
+
+-------------------------------------------------------------------------------
+When '$TST_TEST_DATA' is used with '$TST_CNT', it's passed as whole string in
+'$2' ($1 is for the test number), '$TST_TEST_DATA_IFS' is ignored. Similar
+would be when using these variables with separate functions.
+
 2.3.2 Library variables
 ^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -1587,8 +1647,8 @@ these can be listed with passing help '-h' option to any test.
 The function that prints the usage is passed in '$TST_USAGE', the help for
 the options implemented in the library is appended when usage is printed.
 
-Lastly the fucntion '$PARSE_ARGS' is called with the option name in '$1' and,
-if option has argument, its value in '$2'.
+Lastly the fucntion '$PARSE_ARGS' is called with the option name in the '$1'
+and, if option has argument, its value in the '$2'.
 
 [source,sh]
 -------------------------------------------------------------------------------
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d49d34b6..422350ed4 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -246,7 +246,7 @@ tst_rescmp()
 
 tst_run()
 {
-	local tst_i
+	local tst_i tst_data
 
 	if [ -n "$TST_TEST_PATH" ]; then
 		for tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
@@ -255,7 +255,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			IPV6);;
+			IPV6|TEST_DATA|TEST_DATA_IFS);;
 			*) tst_res TWARN "Reserved variable TST_$tst_i used!";;
 			esac
 		done
@@ -352,18 +352,30 @@ tst_run()
 			if type test1 > /dev/null 2>&1; then
 				for tst_i in $(seq $TST_CNT); do
 					local res=$(tst_resstr)
-					$TST_TESTFUNC$tst_i
+					$TST_TESTFUNC$tst_i $tst_i $TST_TEST_DATA
 					tst_rescmp "$res"
 					TST_COUNT=$((TST_COUNT+1))
 				done
 			else
 				for tst_i in $(seq $TST_CNT); do
 					local res=$(tst_resstr)
-					$TST_TESTFUNC $tst_i
+					$TST_TESTFUNC $tst_i $TST_TEST_DATA
 					tst_rescmp "$res"
 					TST_COUNT=$((TST_COUNT+1))
 				done
 			fi
+		elif [ -n "$TST_TEST_DATA" ]; then
+			tst_i=1
+			tst_check_cmds cut
+			while true; do
+				tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$tst_i)"
+				[ -z "$tst_data" ] && break
+				local res=$(tst_resstr)
+				$TST_TESTFUNC $tst_i "$tst_data"
+				tst_rescmp "$res"
+				TST_COUNT=$((TST_COUNT+1))
+				tst_i=$((tst_i+1))
+			done
 		else
 			local res=$(tst_resstr)
 			$TST_TESTFUNC
@@ -400,6 +412,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 		tst_brk TBROK "TST_TESTFUNC is not defined"
 	fi
 
+	TST_TEST_DATA_IFS="${TST_TEST_DATA_IFS:- }"
+
 	if [ -n "$TST_CNT" ]; then
 		if ! tst_is_int "$TST_CNT"; then
 			tst_brk TBROK "TST_CNT must be integer"
-- 
2.16.3

