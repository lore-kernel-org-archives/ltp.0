From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 15:44:22 +0100
Subject: [LTP] [PATCH v4 1/3] tst_test.sh: Call cleanup function after test
 start
In-Reply-To: <20201217144424.19414-1-pvorel@suse.cz>
References: <20201217144424.19414-1-pvorel@suse.cz>
Message-ID: <20201217144424.19414-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It does not make sense to run the test cleanup function when the setup
function has been run.

And at least some network tests expect setup has been run before running
cleanup (e.g. tcp_fastopen_run.sh).

When shell API was introduced, cleanup function was run only if 1) setup
function was defined 2) and also run. That was inconsistent from C API,
thus e7dc14caa run it always.

But shell API is different from C API: tst_brk can be called from
tst_test.sh (or other library which is run before tst_run, e.g.
tst_net.sh). That was probably the reason, why detection via
$TST_SETUP_STARTED was introduced in initial shell API.

NOTE: using type is better than grep $TST_TEST_PATH, because cleanup
function can be in other library sourced by the test.

Fixes: e7dc14caa ("tst_test.sh: Run cleanup even setup is not defined")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 10 +++++++---
 testcases/lib/tst_test.sh       |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 99fb34628..f3a55cf26 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2251,11 +2251,15 @@ able to clean up correctly even in this situation. The easiest solution for
 this is to keep track of what was initialized and act accordingly in the
 cleanup.
 
-WARNING: Similar to the C library, calling tst_brk() in the $TST_CLEANUP does
+WARNING: Similar to the C library, calling 'tst_brk' in the $TST_CLEANUP does
          not exit the test and 'TBROK' is converted to 'TWARN'.
 
-Notice also the 'tst_run' function called at the end of the test that actually
-starts the test.
+Notice also the 'tst_run' shell API function called at the end of the test that
+actually starts the test.
+
+WARNING: cleanup function is called only after 'tst_run' has been started.
+Calling 'tst_brk' in shell libraries, e.g. 'tst_test.sh' or 'tst_net.sh' does
+not trigger calling it.
 
 [source,sh]
 -------------------------------------------------------------------------------
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2417da140..c205bc91b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,7 +28,7 @@ _tst_do_exit()
 	local ret=0
 	TST_DO_EXIT=1
 
-	if [ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
+	if [ -n "$TST_RUN_STARTED" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
 		$TST_CLEANUP
 	fi
 
@@ -599,7 +599,6 @@ tst_run()
 		fi
 		TST_ITERATIONS=$((TST_ITERATIONS-1))
 	done
-
 	_tst_do_exit
 }
 
@@ -608,6 +607,7 @@ _tst_run_tests()
 	local _tst_data="$1"
 	local _tst_i
 
+	TST_RUN_STARTED=1
 	for _tst_i in $(seq ${TST_CNT:-1}); do
 		if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
 			_tst_run_test "$TST_TESTFUNC$_tst_i" $_tst_i "$_tst_data"
-- 
2.29.2

