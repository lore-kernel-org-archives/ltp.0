From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 10:09:33 +0200
Subject: [LTP] [PATCH 3/3] shell API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <20210825080933.12949-1-pvorel@suse.cz>
References: <20210825080933.12949-1-pvorel@suse.cz>
Message-ID: <20210825080933.12949-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To follow the conventions in the new API.

Keep the old name in the legacy API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index acf62c9ac..b68fae0b8 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -49,8 +49,8 @@ _tst_do_exit()
 		[ "$TST_TMPDIR_RHOST" = 1 ] && tst_cleanup_rhost
 	fi
 
-	if [ -n "$TST_NEEDS_CHECKPOINTS" -a -f "$LTP_IPC_PATH" ]; then
-		rm $LTP_IPC_PATH
+	if [ -n "$TST_NEEDS_CHECKPOINTS" -a -f "$TST_IPC_PATH" ]; then
+		rm $TST_IPC_PATH
 	fi
 
 	_tst_cleanup_timer
@@ -582,14 +582,14 @@ _tst_init_checkpoints()
 {
 	local pagesize
 
-	LTP_IPC_PATH="/dev/shm/ltp_${TST_ID}_$$"
+	TST_IPC_PATH="/dev/shm/ltp_${TST_ID}_$$"
 	pagesize=$(tst_getconf PAGESIZE)
 	if [ $? -ne 0 ]; then
 		tst_brk TBROK "tst_getconf PAGESIZE failed"
 	fi
-	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
-	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
-	export LTP_IPC_PATH
+	ROD_SILENT dd if=/dev/zero of="$TST_IPC_PATH" bs="$pagesize" count=1
+	ROD_SILENT chmod 600 "$TST_IPC_PATH"
+	export TST_IPC_PATH
 }
 
 tst_run()
-- 
2.32.0

