From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  2 Feb 2021 11:19:42 +0100
Subject: [LTP] [RFC PATCH v2 1/1] tst_test.sh: Run cleanup also on timeout
Message-ID: <20210202101942.31328-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also timeout requires to run a test cleanup (e.g. zram01.sh).
Thus send first SIGINT, but keep also SIGKILL for safety reasons
(after 5 sec to give cleanup function some time.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* put code into separate function
* s/timeout/timed out/

 testcases/lib/tst_test.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 69f007d89..bcf379c8e 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
 . tst_security.sh
 
 # default trap function
-trap "tst_brk TBROK 'test interrupted'" INT
+trap "tst_brk TBROK 'test interrupted or timed out'" INT
 
 _tst_do_exit()
 {
@@ -437,6 +437,14 @@ _tst_multiply_timeout()
 	return 0
 }
 
+_tst_handle_timeout()
+{
+	tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
+	kill -2 -$pid
+	sleep 5
+	kill -9 -$pid
+}
+
 _tst_setup_timer()
 {
 	TST_TIMEOUT=${TST_TIMEOUT:-300}
@@ -459,7 +467,7 @@ _tst_setup_timer()
 
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
-	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &
+	sleep $sec && _tst_handle_timeout &
 
 	_tst_setup_timer_pid=$!
 }
-- 
2.30.0

