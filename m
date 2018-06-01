From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 09:28:38 +0200
Subject: [LTP] [RFC PATCH v6 5/5] tst_test.sh: Add TST_TEST_DATA and
	TST_TEST_DATA_IFS
In-Reply-To: <20180601072838.13196-1-pvorel@suse.cz>
References: <20180601072838.13196-1-pvorel@suse.cz>
Message-ID: <20180601072838.13196-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is specific only for shell.

Each run of tst_run gets passed sequence number of a test being run
as '$1' and corresponding part of data from TST_TEST_DATA as '$2'.

Also create internal functions _tst_run_tests() and _tst_run_test()
to reduce duplicity.

Introduced dependencies: cut tr wc.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 79 +++++++++++++++++++++++++++++++++++++----
 testcases/lib/tst_test.sh       | 59 +++++++++++++++++++-----------
 2 files changed, 110 insertions(+), 28 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index fb7dcb591..62b31aae0 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1442,20 +1442,23 @@ TST_CNT=2
 
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
+# output:
+# foo 1 TPASS: Test 1 passed
+# foo 2 TPASS: Test 2 passed
 -------------------------------------------------------------------------------
 
 If '$TST_CNT' is set, the test library looks if there are functions named
 '$\{TST_TESTFUNC\}1', ..., '$\{TST_TESTFUNC\}$\{TST_CNT\}' and if these are
-found they are executed one by one.
+found they are executed one by one. The test number is passed to it in the '$1'.
 
 [source,sh]
 -------------------------------------------------------------------------------
@@ -1471,18 +1474,80 @@ TST_CNT=2
 do_test()
 {
 	case $1 in
-	1) tst_res TPASS "Test 1 passed";;
-	2) tst_res TPASS "Test 2 passed";;
+	1) tst_res TPASS "Test $1 passed";;
+	2) tst_res TPASS "Test $1 passed";;
 	esac
 }
 
 tst_run
+# output:
+# foo 1 TPASS: Test 1 passed
+# foo 2 TPASS: Test 2 passed
 -------------------------------------------------------------------------------
 
 Otherwise, if '$TST_CNT' is set but there is no '$\{TST_TESTFUNC\}1', etc.,
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
+# foo 1 TPASS: Test 1 passed with data 'foo'
+# foo 2 TPASS: Test 1 passed with data 'bar'
+# foo 3 TPASS: Test 1 passed with data 'd dd'
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
+TST_TEST_DATA="foo bar"
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
+# foo 1 TPASS: Test 1 passed with data 'foo'
+# foo 2 TPASS: Test 2 passed with data 'foo'
+# foo 3 TPASS: Test 1 passed with data 'bar'
+# foo 4 TPASS: Test 2 passed with data 'bar'
+-------------------------------------------------------------------------------
+
+'$TST_TEST_DATA' can be used with '$TST_CNT'. If '$TST_TEST_DATA_IFS' not specified,
+space as default value is used. Of course, it's possible to use separate functions.
+
 2.3.2 Library variables
 ^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -1587,8 +1652,8 @@ these can be listed with passing help '-h' option to any test.
 The function that prints the usage is passed in '$TST_USAGE', the help for
 the options implemented in the library is appended when usage is printed.
 
-Lastly the fucntion '$PARSE_ARGS' is called with the option name in '$1' and,
-if option has argument, its value in '$2'.
+Lastly the fucntion '$PARSE_ARGS' is called with the option name in the '$1'
+and, if option has argument, its value in the '$2'.
 
 [source,sh]
 -------------------------------------------------------------------------------
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 621e3eec0..228da5644 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -255,6 +255,8 @@ _tst_get_used_var()
 tst_run()
 {
 	local _tst_i
+	local _tst_data
+	local _tst_max
 	local _tst_name
 
 	if [ -n "$TST_TEST_PATH" ]; then
@@ -264,7 +266,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			IPV6);;
+			IPV6|TEST_DATA|TEST_DATA_IFS);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -359,27 +361,15 @@ tst_run()
 
 	#TODO check that test reports some results for each test function call
 	while [ $TST_ITERATIONS -gt 0 ]; do
-		if [ -n "$TST_CNT" ]; then
-			if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
-				for _tst_i in $(seq $TST_CNT); do
-					local _tst_res=$(_tst_resstr)
-					$TST_TESTFUNC$_tst_i
-					_tst_rescmp "$_tst_res"
-					TST_COUNT=$((TST_COUNT+1))
-				done
-			else
-				for _tst_i in $(seq $TST_CNT); do
-					local _tst_res=$(_tst_resstr)
-					$TST_TESTFUNC $_tst_i
-					_tst_rescmp "$_tst_res"
-					TST_COUNT=$((TST_COUNT+1))
-				done
-			fi
+		if [ -n "$TST_TEST_DATA" ]; then
+			tst_check_cmds cut tr wc
+			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
+			for _tst_i in $(seq $_tst_max); do
+				_tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_i)"
+				_tst_run_tests "$_tst_data"
+			done
 		else
-			local _tst_res=$(_tst_resstr)
-			$TST_TESTFUNC
-			_tst_rescmp "$_tst_res"
-			TST_COUNT=$((TST_COUNT+1))
+			_tst_run_tests
 		fi
 		TST_ITERATIONS=$((TST_ITERATIONS-1))
 	done
@@ -387,6 +377,31 @@ tst_run()
 	_tst_do_exit
 }
 
+_tst_run_tests()
+{
+	local _tst_data="$1"
+	local _tst_i
+
+	for _tst_i in $(seq ${TST_CNT:-1}); do
+		if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
+			_tst_run_test "$TST_TESTFUNC$_tst_i" $_tst_i "$_tst_data"
+		else
+			_tst_run_test "$TST_TESTFUNC" $_tst_i "$_tst_data"
+		fi
+	done
+}
+
+_tst_run_test()
+{
+	local _tst_res=$(_tst_resstr)
+	local _tst_fnc="$1"
+	shift
+
+	$_tst_fnc "$@"
+	_tst_rescmp "$_tst_res"
+	TST_COUNT=$((TST_COUNT+1))
+}
+
 if [ -z "$TST_ID" ]; then
 	_tst_filename=$(basename $0)
 	TST_ID=${_tst_filename%%.*}
@@ -411,6 +426,8 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 		tst_brk TBROK "TST_TESTFUNC is not defined"
 	fi
 
+	TST_TEST_DATA_IFS="${TST_TEST_DATA_IFS:- }"
+
 	if [ -n "$TST_CNT" ]; then
 		if ! tst_is_int "$TST_CNT"; then
 			tst_brk TBROK "TST_CNT must be integer"
-- 
2.16.3

