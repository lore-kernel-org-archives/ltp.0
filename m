From: Leo Liang <ycliang@andestech.com>
Date: Tue, 24 Aug 2021 20:19:56 +0800
Subject: [LTP] [PATCH v7, 4/4] Make argument to tst_umount an absolute path
Message-ID: <YSTj7CB6PdG2HZsQ@ubuntu02>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_umount only takes mount point as an argument,
so modify the argument to an absolute path for tst_umount.

df01.sh uses tst_umount as clean up function,
modify its default TST_MNTPOINT to $PWD/mntpoint in tst_test.sh

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/kernel/fs/quota_remount/quota_remount_test01.sh    | 2 +-
 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh | 2 +-
 testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh    | 2 +-
 testcases/lib/tst_test.sh                                    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 33015616d..ab9c5c6b9 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -632,7 +632,7 @@ tst_run()
 		cd "$TST_TMPDIR"
 	fi
 
-	TST_MNTPOINT="${TST_MNTPOINT:-mntpoint}"
+	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 
 		TST_DEVICE=$(tst_device acquire)
-- 
2.17.0
