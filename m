From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 May 2020 23:15:13 +0200
Subject: [LTP] [PATCH 1/2] tst_net.sh: Print output on unexpected PASS/FAIL
Message-ID: <20200518211514.20445-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This helps debugging.

Use $TMPDIR and PID to guarantee writable directory and unique file
without the need to require TST_NEEDS_TMPDIR=1.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 011b62267..bfed4a44d 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -250,22 +250,32 @@ tst_net_run()
 
 EXPECT_RHOST_PASS()
 {
-	tst_rhost_run -c "$*" > /dev/null
+	local log="$TMPDIR/log.$$"
+
+	tst_rhost_run -c "$*" > $log
 	if [ $? -eq 0 ]; then
 		tst_res_ TPASS "$* passed as expected"
 	else
 		tst_res_ TFAIL "$* failed unexpectedly"
+		cat $log
 	fi
+
+	rm -f $log
 }
 
 EXPECT_RHOST_FAIL()
 {
-	tst_rhost_run -c "$* 2> /dev/null"
+	local log="$TMPDIR/log.$$"
+
+	tst_rhost_run -c "$*" > $log
 	if [ $? -ne 0 ]; then
 		tst_res_ TPASS "$* failed as expected"
 	else
 		tst_res_ TFAIL "$* passed unexpectedly"
+		cat $log
 	fi
+
+	rm -f $log
 }
 
 # Get test interface names for local/remote host.
-- 
2.26.2

