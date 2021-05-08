From: Li Wang <liwang@redhat.com>
Date: Sat,  8 May 2021 13:51:08 +0800
Subject: [LTP] [PATCH v3 3/4] lib: ignore SIGINT in _tst_kill_test
Message-ID: <20210508055109.16914-4-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have to guarantee _tst_kill_test alive for a while to check if
the target test eixst or not, so ignore SIGINT in _tst_kill_test
is necessary, otherwise it will be stopped by the SIGINT sending
by itself.

The timeout03.sh verify this mechanism proccess well in output:

  timeout03 1 TBROK: Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  timeout03 1 TBROK: test interrupted or timed out
  timeout03 1 TPASS: test run cleanup after timeout
  timeout03 1 TINFO: Test is still running, waiting 10s
  timeout03 1 TINFO: Test is still running, waiting 9s
  timeout03 1 TINFO: Test is still running, waiting 8s
  timeout03 1 TINFO: Test is still running, waiting 7s
  timeout03 1 TINFO: Test is still running, waiting 6s
  timeout03 1 TINFO: Test is still running, waiting 5s
  timeout03 1 TINFO: Test is still running, waiting 4s
  timeout03 1 TINFO: Test is still running, waiting 3s
  timeout03 1 TINFO: Test is still running, waiting 2s
  timeout03 1 TINFO: Test is still running, waiting 1s
  timeout03 1 TBROK: Test still running, sending SIGKILL
  Killed

(This one based on Joerg's improvement work, better apply this after the two patches)

Fixes: 25ad54dbaea6("tst_test.sh: Run cleanup also after test timeout")
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Joerg Vehlow <lkml@jv-coder.de>
Acked-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index ed2699175..b6ca0cb26 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -439,6 +439,7 @@ _tst_kill_test()
 {
 	local i=10
 
+	trap '' INT
 	tst_res TBROK "Test timeouted, sending SIGINT! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
 	kill -INT -$pid
 	tst_sleep 100ms
-- 
2.30.2

