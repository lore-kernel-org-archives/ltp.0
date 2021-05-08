From: Li Wang <liwang@redhat.com>
Date: Sat,  8 May 2021 13:51:07 +0800
Subject: [LTP] [PATCH v3 2/4] shell: Prevent orphan timeout sleep processes
Message-ID: <20210508055109.16914-3-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The implementation of the timeout handling failed to terminate the sleep
process, because the command "sleep $sec && _tst_kill_test &" spawns two
processes: A shell, that is used to execute the sleep and after sleep
terminates it executes _tst_kill_test. The pid stored in $! is the pid of
the shell process.
When the test finished, the timeout process is supposed to be killed, but
only the shell process is killed, not the sleep. If the output of the test
is piped somewhere else, the pipe stays open, until the sleep finished,
because it still has stdout open.
Additionally, if a lot of short tests with high timeouts are executed,
a lot of sleep processes will linger around.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/shell/timeout03.sh |  4 ++--
 lib/newlib_tests/shell/timeout04.sh |  2 +-
 testcases/lib/tst_test.sh           | 30 ++++++++++++++++++++---------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
index 30aa0a149..cd548d9a2 100755
--- a/lib/newlib_tests/shell/timeout03.sh
+++ b/lib/newlib_tests/shell/timeout03.sh
@@ -32,7 +32,7 @@ do_test()
 {
 	tst_res TINFO "testing killing test after TST_TIMEOUT"
 
-	tst_sleep 2
+	sleep 2
 	tst_res TFAIL "test: running after TST_TIMEOUT"
 }
 
@@ -40,7 +40,7 @@ cleanup()
 {
 	tst_res TPASS "test run cleanup after timeout"
 
-	tst_sleep 15 # must be higher than wait time in _tst_kill_test
+	sleep 15 # must be higher than wait time in _tst_kill_test
 	tst_res TFAIL "cleanup: running after TST_TIMEOUT"
 }
 
diff --git a/lib/newlib_tests/shell/timeout04.sh b/lib/newlib_tests/shell/timeout04.sh
index 0a6ba053c..c702905f3 100755
--- a/lib/newlib_tests/shell/timeout04.sh
+++ b/lib/newlib_tests/shell/timeout04.sh
@@ -9,7 +9,7 @@ TST_TIMEOUT=1
 
 do_test()
 {
-	tst_res TINFO "Start"
+    tst_res TINFO "Start"
     sleep 5
     tst_res TFAIL "End"
 }
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 951518785..ed2699175 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -23,14 +23,6 @@ export TST_LIB_LOADED=1
 # default trap function
 trap "tst_brk TBROK 'test interrupted or timed out'" INT
 
-_tst_cleanup_timer()
-{
-	if [ -n "$_tst_setup_timer_pid" ]; then
-		kill $_tst_setup_timer_pid 2>/dev/null
-		wait $_tst_setup_timer_pid 2>/dev/null
-	fi
-}
-
 _tst_do_exit()
 {
 	local ret=0
@@ -463,6 +455,25 @@ _tst_kill_test()
 	fi
 }
 
+_tst_cleanup_timer()
+{
+	if [ -n "$_tst_setup_timer_pid" ]; then
+		kill -TERM $_tst_setup_timer_pid 2>/dev/null
+		wait $_tst_setup_timer_pid 2>/dev/null
+	fi
+}
+
+_tst_timeout_process()
+{
+	local sleep_pid
+
+	sleep $sec &
+	sleep_pid=$!
+	trap "kill $sleep_pid; exit" TERM
+	wait $sleep_pid
+	_tst_kill_test
+}
+
 _tst_setup_timer()
 {
 	TST_TIMEOUT=${TST_TIMEOUT:-300}
@@ -486,7 +497,8 @@ _tst_setup_timer()
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
 	_tst_cleanup_timer
-	sleep $sec && _tst_kill_test &
+
+	_tst_timeout_process &
 
 	_tst_setup_timer_pid=$!
 }
-- 
2.30.2

