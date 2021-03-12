From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Mar 2021 18:31:59 +0100
Subject: [LTP] [PATCH 1/3] tst_test.sh: Run cleanup also after test timeout
In-Reply-To: <20210312173201.27708-1-pvorel@suse.cz>
References: <20210312173201.27708-1-pvorel@suse.cz>
Message-ID: <20210312173201.27708-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also timeout requires to run a test cleanup (e.g. zram01.sh).
Thus send first SIGINT, but keep also SIGKILL for safety reasons
(after 5 sec to give some time to the cleanup function and
_tst_check_security_modules()).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 58056e28b..1aa940f61 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
 . tst_security.sh
 
 # default trap function
-trap "tst_brk TBROK 'test interrupted'" INT
+trap "tst_brk TBROK 'test interrupted or timed out'" INT
 
 _tst_cleanup_timer()
 {
@@ -442,6 +442,26 @@ _tst_multiply_timeout()
 	return 0
 }
 
+_tst_kill_test()
+{
+	local i=10
+
+	tst_res TBROK "Test timeouted, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
+	kill -INT -$pid
+	tst_sleep 100ms
+
+	while kill -0 $pid 2>&1 > /dev/null && [ $i -gt 0 ]; do
+		tst_res TINFO "Test is still running, waiting ${i}s"
+		sleep 1
+		i=$((i-1))
+	done
+
+	if kill -0 $pid 2>&1 > /dev/null; then
+		tst_res TBROK "Test still running, sending SIGKILL"
+		kill -KILL -$pid
+	fi
+}
+
 _tst_setup_timer()
 {
 	TST_TIMEOUT=${TST_TIMEOUT:-300}
@@ -465,8 +485,7 @@ _tst_setup_timer()
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
 	_tst_cleanup_timer
-
-	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &
+	sleep $sec && _tst_kill_test &
 
 	_tst_setup_timer_pid=$!
 }
-- 
2.30.1

