From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Nov 2018 20:38:44 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] tst_test.sh: Suppress wait output
Message-ID: <20181130193844.10801-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Not only kill command in _tst_do_exit(), also wait has some output is needed to redirect to /dev/null:

/opt/ltp/testcases/bin/tst_test.sh: line 65:  5337 Terminated \
sleep $sec && tst_res TBROK "test killed, timeout!" && kill -9 -$pid  (wd: /opt/ltp/testcases/bin)

Fixes: fbea02ab5 ("lib/tst_test.sh: setup timeout per test run for the
shell tests")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

I'm sorry, you were right with redirecting wait in your original patch.


Kind regards,
Petr
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8bf5f84d1..1a5d925f9 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -62,7 +62,7 @@ _tst_do_exit()
 
 	if [ -n "$_tst_setup_timer_pid" ]; then
 		kill $_tst_setup_timer_pid 2>/dev/null
-		wait $_tst_setup_timer_pid
+		wait $_tst_setup_timer_pid 2>/dev/null
 	fi
 
 	if [ $TST_FAIL -gt 0 ]; then
-- 
2.19.1

