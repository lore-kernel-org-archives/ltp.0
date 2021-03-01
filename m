From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  1 Mar 2021 23:02:20 +0100
Subject: [LTP] [PATCH 5/7] tst_test.sh: Introduce tst_set_timeout(timeout)
In-Reply-To: <20210301220222.22705-1-pvorel@suse.cz>
References: <20210301220222.22705-1-pvorel@suse.cz>
Message-ID: <20210301220222.22705-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to sync with C API. This allows to setup timer after test has started.
It's useful when test length depends on input decided during setup.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3.

 doc/test-writing-guidelines.txt | 16 ++++++++++++----
 testcases/lib/tst_test.sh       | 23 ++++++++++++++++++-----
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index dd1911ceb..50696e14a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2393,8 +2393,8 @@ tst_run
 '$TST_TEST_DATA' can be used with '$TST_CNT'. If '$TST_TEST_DATA_IFS' not specified,
 space as default value is used. Of course, it's possible to use separate functions.
 
-2.3.2 Library environment variables for shell
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+2.3.2 Library environment variables and functions for shell
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Similarily to the C library various checks and preparations can be requested
 simply by setting right '$TST_NEEDS_FOO'.
@@ -2415,11 +2415,19 @@ simply by setting right '$TST_NEEDS_FOO'.
 | 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must be int >= 1,
                        or -1 (special value to disable timeout), default is 300.
                        Variable is meant be set in tests, not by user.
-                       It's equivalent of `tst_test.timeout` in C.
+                       It's an equivalent of `tst_test.timeout` in C, can be set
+                       via 'tst_set_timeout(timeout)' after test has started.
+|=============================================================================
+
+[options="header"]
+|=============================================================================
+| Function name              | Action done
+| 'tst_set_timeout(timeout)' | Maximum timeout set for the test in sec.
+                               See 'TST_TIMEOUT' variable.
 |=============================================================================
 
 NOTE: Network tests (see testcases/network/README.md) use additional variables
-in 'tst_net.sh'.
+and functions in 'tst_net.sh'.
 
 Checking for presence of commands
 +++++++++++++++++++++++++++++++++
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 69f007d89..58056e28b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2020
+# Copyright (c) Linux Test Project, 2014-2021
 # Author: Cyril Hrubis <chrubis@suse.cz>
 #
 # LTP test library for shell.
@@ -23,6 +23,14 @@ export TST_LIB_LOADED=1
 # default trap function
 trap "tst_brk TBROK 'test interrupted'" INT
 
+_tst_cleanup_timer()
+{
+	if [ -n "$_tst_setup_timer_pid" ]; then
+		kill $_tst_setup_timer_pid 2>/dev/null
+		wait $_tst_setup_timer_pid 2>/dev/null
+	fi
+}
+
 _tst_do_exit()
 {
 	local ret=0
@@ -48,10 +56,7 @@ _tst_do_exit()
 		[ "$TST_TMPDIR_RHOST" = 1 ] && tst_cleanup_rhost
 	fi
 
-	if [ -n "$_tst_setup_timer_pid" ]; then
-		kill $_tst_setup_timer_pid 2>/dev/null
-		wait $_tst_setup_timer_pid 2>/dev/null
-	fi
+	_tst_cleanup_timer
 
 	if [ $TST_FAIL -gt 0 ]; then
 		ret=$((ret|1))
@@ -459,6 +464,8 @@ _tst_setup_timer()
 
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
+	_tst_cleanup_timer
+
 	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &
 
 	_tst_setup_timer_pid=$!
@@ -492,6 +499,12 @@ tst_require_module()
 	tst_res TINFO "Found module at '$TST_MODPATH'"
 }
 
+tst_set_timeout()
+{
+	TST_TIMEOUT="$1"
+	_tst_setup_timer
+}
+
 tst_run()
 {
 	local _tst_i
-- 
2.30.1

