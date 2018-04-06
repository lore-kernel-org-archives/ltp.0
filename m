From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Apr 2018 14:31:13 +0200
Subject: [LTP] [RFC PATCH v6 2/7] tst_test.sh: Introduce TST_NO_DEFAULT_RUN
In-Reply-To: <20180406123118.21309-1-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
Message-ID: <20180406123118.21309-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TST_NO_DEFAULT_RUN is somehow similar to TST_NO_DEFAULT_MAIN. It's meant
to be used for libraries and tools using tst_test.sh. It helps to use
part of test framework functionality without actually wanting to run any test (yet).

For tests with defined TST_NO_DEFAULT_RUN and sourcing tst_test.sh all
functions and variables are defined, but checks for requested variables
are skipped.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_test.sh | 90 ++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 78bd328a2..6c2ee6a51 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) Linux Test Project, 2014-2017
+# Copyright (c) Linux Test Project, 2014-2018
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -371,67 +371,69 @@ tst_run()
 	tst_do_exit
 }
 
-if TST_TEST_PATH=$(which $0) 2>/dev/null; then
-	if ! grep -q tst_run "$TST_TEST_PATH"; then
-		tst_brk TBROK "Test $0 must call tst_run!"
-	fi
-fi
-
 if [ -z "$TST_ID" ]; then
 	filename=$(basename $0)
 	TST_ID=${filename%%.*}
 fi
 export TST_ID="$TST_ID"
 
-if [ -z "$TST_TESTFUNC" ]; then
-	tst_brk TBROK "TST_TESTFUNC is not defined"
+if [ -z "$LTPROOT" ]; then
+	export LTPROOT="$PWD"
+	export TST_DATAROOT="$LTPROOT/datafiles"
+else
+	export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
 fi
 
-if [ -n "$TST_CNT" ]; then
-	if ! tst_is_int "$TST_CNT"; then
-		tst_brk TBROK "TST_CNT must be integer"
+if [ -z "$TST_NO_DEFAULT_RUN" ]; then
+	if TST_TEST_PATH=$(which $0) 2>/dev/null; then
+		if ! grep -q tst_run "$TST_TEST_PATH"; then
+			tst_brk TBROK "Test $0 must call tst_run!"
+		fi
 	fi
 
-	if [ "$TST_CNT" -le 0 ]; then
-		tst_brk TBROK "TST_CNT must be > 0"
+	if [ -z "$TST_TESTFUNC" ]; then
+		tst_brk TBROK "TST_TESTFUNC is not defined"
 	fi
-fi
 
-if [ -n "$TST_POS_ARGS" ]; then
-	if ! tst_is_int "$TST_POS_ARGS"; then
-		tst_brk TBROK "TST_POS_ARGS must be integer"
-	fi
+	if [ -n "$TST_CNT" ]; then
+		if ! tst_is_int "$TST_CNT"; then
+			tst_brk TBROK "TST_CNT must be integer"
+		fi
 
-	if [ "$TST_POS_ARGS" -le 0 ]; then
-		tst_brk TBROK "TST_POS_ARGS must be > 0"
+		if [ "$TST_CNT" -le 0 ]; then
+			tst_brk TBROK "TST_CNT must be > 0"
+		fi
 	fi
-fi
 
-if [ -z "$LTPROOT" ]; then
-	export LTPROOT="$PWD"
-	export TST_DATAROOT="$LTPROOT/datafiles"
-else
-	export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
-fi
+	if [ -n "$TST_POS_ARGS" ]; then
+		if ! tst_is_int "$TST_POS_ARGS"; then
+			tst_brk TBROK "TST_POS_ARGS must be integer"
+		fi
 
-TST_ARGS="$@"
+		if [ "$TST_POS_ARGS" -le 0 ]; then
+			tst_brk TBROK "TST_POS_ARGS must be > 0"
+		fi
+	fi
 
-while getopts ":hi:$TST_OPTS" tst_name; do
-	case $tst_name in
-	'h') TST_PRINT_HELP=1;;
-	*);;
-	esac
-done
+	TST_ARGS="$@"
 
-shift $((OPTIND - 1))
+	while getopts ":hi:$TST_OPTS" tst_name; do
+		case $tst_name in
+		'h') TST_PRINT_HELP=1;;
+		*);;
+		esac
+	done
 
-if [ -n "$TST_POS_ARGS" ]; then
-	if [ -z "$TST_PRINT_HELP" -a $# -ne "$TST_POS_ARGS" ]; then
-		tst_brk TBROK "Invalid number of positional paramters:"\
-			      "have ($@) $#, expected ${TST_POS_ARGS}"
-	fi
-else
-	if [ -z "$TST_PRINT_HELP" -a $# -ne 0 ]; then
-		tst_brk TBROK "Unexpected positional arguments '$@'"
+	shift $((OPTIND - 1))
+
+	if [ -n "$TST_POS_ARGS" ]; then
+		if [ -z "$TST_PRINT_HELP" -a $# -ne "$TST_POS_ARGS" ]; then
+			tst_brk TBROK "Invalid number of positional paramters:"\
+					  "have ($@) $#, expected ${TST_POS_ARGS}"
+		fi
+	else
+		if [ -z "$TST_PRINT_HELP" -a $# -ne 0 ]; then
+			tst_brk TBROK "Unexpected positional arguments '$@'"
+		fi
 	fi
 fi
-- 
2.16.2

