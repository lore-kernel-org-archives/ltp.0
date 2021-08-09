From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  9 Aug 2021 14:12:37 +0200
Subject: [LTP] [PATCH 1/2] shell: Add checkpoints api for new lib
Message-ID: <20210809121238.1585673-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The checkpoint api is even mentioned in shell-test-api.txt,
but with the old library used.
This also fixes the documentation.

memcg_lib.sh must be adapted in the same commit, because it already sets
TST_NEEDS_CHECKPOINTS=1 and had the ipc initialization code. This would
run the ipc initialization code twice.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 doc/shell-test-api.txt                        |  4 +-
 .../controllers/memcg/functional/memcg_lib.sh |  8 ----
 testcases/lib/tst_test.sh                     | 41 ++++++++++++++++++-
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index bf297ab07..8d1bab5a1 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -729,14 +729,14 @@ The shell library provides an implementation of the checkpoint interface
 compatible with the C version. All 'TST_CHECKPOINT_*' functions are available.
 
 In order to initialize checkpoints '$TST_NEEDS_CHECKPOINTS' must be set to '1'
-before the inclusion of 'test.sh':
+before the inclusion of 'tst_test.sh':
 
 [source,sh]
 -------------------------------------------------------------------------------
 #!/bin/sh
 
 TST_NEEDS_CHECKPOINTS=1
-. test.sh
+. tst_test.sh
 -------------------------------------------------------------------------------
 
 Since both the implementations are compatible, it's also possible to start
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index dad66c798..e5fa215c3 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -69,14 +69,6 @@ memcg_setup()
 		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
 	fi
 
-	# Setup IPC
-	LTP_IPC_PATH="/dev/shm/ltp_${TCID}_$$"
-	LTP_IPC_SIZE=$PAGESIZE
-	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$LTP_IPC_SIZE" count=1
-	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
-	export LTP_IPC_PATH
-	# Setup IPC end
-
 	ROD mkdir /dev/memcg
 	ROD mount -t cgroup -omemory memcg /dev/memcg
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6aa2c487..d4a1ab736 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -253,6 +253,27 @@ TST_RTNL_CHK()
 	tst_brk TBROK "$@ failed: $output"
 }
 
+TST_CHECKPOINT_WAIT()
+{
+	ROD tst_checkpoint wait 10000 "$1"
+}
+
+TST_CHECKPOINT_WAKE()
+{
+	ROD tst_checkpoint wake 10000 "$1" 1
+}
+
+TST_CHECKPOINT_WAKE2()
+{
+	ROD tst_checkpoint wake 10000 "$1" "$2"
+}
+
+TST_CHECKPOINT_WAKE_AND_WAIT()
+{
+	TST_CHECKPOINT_WAKE "$1"
+	TST_CHECKPOINT_WAIT "$1"
+}
+
 tst_mount()
 {
 	local mnt_opt mnt_err
@@ -558,6 +579,20 @@ tst_set_timeout()
 	_tst_setup_timer
 }
 
+_tst_init_checkpoints()
+{
+	local pagesize
+
+	LTP_IPC_PATH="/dev/shm/ltp_${TCID}_$$"
+	pagesize=$(tst_getconf PAGESIZE)
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "tst_getconf PAGESIZE failed"
+	fi
+	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
+	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
+	export LTP_IPC_PATH
+}
+
 tst_run()
 {
 	local _tst_i
@@ -577,7 +612,9 @@ tst_run()
 			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
 			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
-			NET_SKIP_VARIABLE_INIT);;
+			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
+			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
+			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -652,6 +689,8 @@ tst_run()
 
 	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
+	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
+
 	if [ -n "$TST_SETUP" ]; then
 		if type $TST_SETUP >/dev/null 2>/dev/null; then
 			TST_DO_CLEANUP=1
-- 
2.25.1

