From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 May 2018 21:34:29 +0200
Subject: [LTP] [RFC PATCH v3 1/2] tst_test.sh: Add TST_TEST_DATA and
	TST_TEST_DATA_IFS
Message-ID: <20180522193430.20117-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is specific only for shell.

Each run of tst_run gets passed sequence number of a test being run
as '$1' and corresponding part of data from TST_TEST_DATA as '$2'.

Also create internal functions tst_run_tests() and tst_run_test()
to reduce duplicity.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* Don't pass $TST_TEST_DATA as whole argument for $TST_CNT (Cyril)
* Create tst_run_tests() for cleanup (Cyril).
* Create tst_run_test() - more cleanup

Maybe we should try to "hide" somehow these API functions (underscore at
the front?).


Kind regards,
Petr
---
 doc/test-writing-guidelines.txt | 74 +++++++++++++++++++++++++++++++++++++----
 testcases/lib/tst_test.sh       | 61 +++++++++++++++++++++------------
 2 files changed, 106 insertions(+), 29 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index de47443eb..531b828ff 100644
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
index 464c4c41e..7680aa462 100644
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
@@ -348,27 +348,17 @@ tst_run()
 
 	#TODO check that test reports some results for each test function call
 	while [ $TST_ITERATIONS -gt 0 ]; do
-		if [ -n "$TST_CNT" ]; then
-			if type test1 > /dev/null 2>&1; then
-				for tst_i in $(seq $TST_CNT); do
-					local res=$(tst_resstr)
-					$TST_TESTFUNC$tst_i
-					tst_rescmp "$res"
-					TST_COUNT=$((TST_COUNT+1))
-				done
-			else
-				for tst_i in $(seq $TST_CNT); do
-					local res=$(tst_resstr)
-					$TST_TESTFUNC $tst_i
-					tst_rescmp "$res"
-					TST_COUNT=$((TST_COUNT+1))
-				done
-			fi
+		if [ -n "$TST_TEST_DATA" ]; then
+			tst_i=1
+			tst_check_cmds cut
+			while true; do
+				tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$tst_i)"
+				[ -z "$tst_data" ] && break
+				tst_run_tests "$tst_data"
+				tst_i=$((tst_i+1))
+			done
 		else
-			local res=$(tst_resstr)
-			$TST_TESTFUNC
-			tst_rescmp "$res"
-			TST_COUNT=$((TST_COUNT+1))
+			tst_run_tests
 		fi
 		TST_ITERATIONS=$((TST_ITERATIONS-1))
 	done
@@ -376,6 +366,31 @@ tst_run()
 	tst_do_exit
 }
 
+tst_run_tests()
+{
+	local tst_data="$1"
+	local tst_i
+
+	for tst_i in $(seq ${TST_CNT:-1}); do
+		if type test1 > /dev/null 2>&1; then
+			tst_run_test "$TST_TESTFUNC$tst_i" $tst_i "$tst_data"
+		else
+			tst_run_test "$TST_TESTFUNC" $tst_i "$tst_data"
+		fi
+	done
+}
+
+tst_run_test()
+{
+	local res=$(tst_resstr)
+	local tst_fnc="$1"
+	shift
+
+	$tst_fnc "$@"
+	tst_rescmp "$res"
+	TST_COUNT=$((TST_COUNT+1))
+}
+
 if [ -z "$TST_ID" ]; then
 	filename=$(basename $0)
 	TST_ID=${filename%%.*}
@@ -400,6 +415,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 		tst_brk TBROK "TST_TESTFUNC is not defined"
 	fi
 
+	TST_TEST_DATA_IFS="${TST_TEST_DATA_IFS:- }"
+
 	if [ -n "$TST_CNT" ]; then
 		if ! tst_is_int "$TST_CNT"; then
 			tst_brk TBROK "TST_CNT must be integer"
-- 
2.16.3

