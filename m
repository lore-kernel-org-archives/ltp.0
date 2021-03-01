From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  1 Mar 2021 23:02:21 +0100
Subject: [LTP] [PATCH 6/7] tst_test.sh: Run cleanup also after test timeout
In-Reply-To: <20210301220222.22705-1-pvorel@suse.cz>
References: <20210301220222.22705-1-pvorel@suse.cz>
Message-ID: <20210301220222.22705-7-pvorel@suse.cz>
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
Originally posted in 
https://patchwork.ozlabs.org/project/ltp/patch/20210202101942.31328-1-pvorel@suse.cz/

* renamed function
* use signal names instead of numbers in kill parameters

 testcases/lib/tst_test.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 58056e28b..097f672a1 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
 . tst_security.sh
 
 # default trap function
-trap "tst_brk TBROK 'test interrupted'" INT
+trap "tst_brk TBROK 'test interrupted or timed out'" INT
 
 _tst_cleanup_timer()
 {
@@ -442,6 +442,14 @@ _tst_multiply_timeout()
 	return 0
 }
 
+_tst_run_timer()
+{
+	tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
+	kill -INT -$pid
+	sleep 5
+	kill -KILL -$pid
+}
+
 _tst_setup_timer()
 {
 	TST_TIMEOUT=${TST_TIMEOUT:-300}
@@ -465,8 +473,7 @@ _tst_setup_timer()
 	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
 
 	_tst_cleanup_timer
-
-	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &
+	sleep $sec && _tst_run_timer &
 
 	_tst_setup_timer_pid=$!
 }
-- 
2.30.1

