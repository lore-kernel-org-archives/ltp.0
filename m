From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri,  7 May 2021 12:32:58 +0200
Subject: [LTP] [PATCH v2 2/2] shell: Prevent orphan timeout sleep processes
In-Reply-To: <20210507103258.232174-1-lkml@jv-coder.de>
References: <20210507103258.232174-1-lkml@jv-coder.de>
Message-ID: <20210507103258.232174-3-lkml@jv-coder.de>
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

Co-authored-by: Li Wang <liwang@redhat.com>
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/lib/tst_test.sh | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 951518785..7ceddff04 100644
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
+	#trap "kill $sleep_pid; exit" TERM
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
2.25.1

