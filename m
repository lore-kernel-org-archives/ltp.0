From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 19 May 2021 08:31:08 +0200
Subject: [LTP] [PATCH 1/2] shell: Fix timeout process termination for zsh
Message-ID: <20210519063109.224352-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

NOTE: This fix should be part of the release,
because it fixes something broken in this release only!

On zsh an exit in the trap for SIGTERM is ignored,
but wait returns with TERM exit status (143).
This can only improve the situation for other processe,
e.g. if the wait is killed by the SIGTERM from the main process,
it will still terminate the timeout process now.

Fixes: a30410f6ad77 ("shell: Prevent orphan timeout sleep processes")

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/lib/tst_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 3a5651c01..1b25f4c44 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -472,6 +472,7 @@ _tst_timeout_process()
 	sleep_pid=$!
 	trap "kill $sleep_pid; exit" TERM
 	wait $sleep_pid
+	[ $? -eq 143 ] && exit
 	trap - TERM
 	_tst_kill_test
 }
-- 
2.25.1

