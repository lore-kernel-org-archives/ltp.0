From: Leo Liang <ycliang@andestech.com>
Date: Wed, 4 Aug 2021 09:55:43 +0800
Subject: [LTP] [PATCH v6, 4/4] Make argument to tst_umount an absolute path
Message-ID: <20210804015539.GA22997@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_umount only takes mount point as an argument,
so modify the argument to an absolute path for tst_umount.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/kernel/fs/quota_remount/quota_remount_test01.sh    | 2 +-
 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh | 2 +-
 testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index e84716c03..1b4bdbb99 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -32,7 +32,7 @@ do_setup()
 do_clean()
 {
 	[ "$mounted" ] || return
-	tst_umount $MNTDIR
+	tst_umount $PWD/$MNTDIR
 	mounted=
 }
 
diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
index 9d86778b6..23a5ec556 100755
--- a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
+++ b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -83,7 +83,7 @@ cleanup()
 {
 	[ -n "$mounted" ] || return 0
 
-	tst_umount $TST_DEVICE
+	tst_umount $TST_MNTPOINT
 
 	TST_DEVICE="$device_backup"
 	TST_FS_TYPE="$fs_type_backup"
diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index 7f06c2488..fd5ee06c8 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -38,7 +38,7 @@ mount_debugfs()
 		if ! grep -q debugfs /proc/filesystems ; then
 			tst_res TCONF "debugfs not supported"
 		fi
-		DEBUGFS_PATH="./tst_debug"
+		DEBUGFS_PATH="$PWD/tst_debug"
 		mkdir "$DEBUGFS_PATH"
 		if mount -t debugfs xxx "$DEBUGFS_PATH" ; then
 			tst_res TINFO "debugfs mounted at $DEBUGFS_PATH"
-- 
2.17.0

