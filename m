From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 10:49:17 +0100
Subject: [LTP] [PATCH v2 2/4] ima, commands/{df,mkfs}: Use tst_mount()
In-Reply-To: <20190314094919.12723-1-pvorel@suse.cz>
References: <20190314094919.12723-1-pvorel@suse.cz>
Message-ID: <20190314094919.12723-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to reduce duplicity.
That required to rename variable s/FS_TYPE/TST_FS_TYPE/.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/df/df01.sh                 | 26 +++++-------------
 testcases/commands/mkfs/mkfs01.sh             | 27 +++++--------------
 .../security/integrity/ima/tests/ima_setup.sh | 15 ++++-------
 3 files changed, 19 insertions(+), 49 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index ecd66fbd6..5d9eda802 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -40,41 +40,29 @@ OPTIONS
 EOF
 }
 
-FS_TYPE=ext2
+TST_FS_TYPE=ext2
 
 parse_args()
 {
-	FS_TYPE="$2"
+	TST_FS_TYPE="$2"
 }
 
 setup()
 {
 	local ret
 
-	if [ -n "$FS_TYPE" ]; then
-		tst_test_cmds mkfs.${FS_TYPE}
-	fi
-
-	tst_mkfs ${FS_TYPE} ${TST_DEVICE}
-
-	ROD_SILENT mkdir -p mntpoint
-
-	mount ${TST_DEVICE} mntpoint
-	ret=$?
-	if [ $ret -eq 32 ]; then
-		tst_brk TCONF "Cannot mount ${FS_TYPE}, missing driver?"
-	fi
-
-	if [ $ret -ne 0 ]; then
-		tst_brk TBROK "Failed to mount device: mount exit = $ret"
+	if [ -n "$TST_FS_TYPE" ]; then
+		tst_test_cmds mkfs.${TST_FS_TYPE}
 	fi
 
+	tst_mkfs $TST_FS_TYPE $TST_DEVICE
+	tst_mount
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
 }
 
 cleanup()
 {
-	tst_umount ${TST_DEVICE}
+	tst_umount $TST_DEVICE
 }
 
 df_test()
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 68d40830a..88f7f0baa 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -42,31 +42,18 @@ EOF
 
 parse_args()
 {
-	FS_TYPE="$2"
+	TST_FS_TYPE="$2"
 }
 
 setup()
 {
-	if [ -n "$FS_TYPE" ]; then
-		tst_test_cmds mkfs.${FS_TYPE}
+	if [ -n "$TST_FS_TYPE" ]; then
+		tst_test_cmds mkfs.${TST_FS_TYPE}
 	fi
 
 	ROD_SILENT mkdir -p mntpoint
 }
 
-mkfs_mount()
-{
-	mount ${TST_DEVICE} mntpoint
-	local ret=$?
-	if [ $ret -eq 32 ]; then
-		tst_brk TCONF "Cannot mount ${FS_TYPE}, missing driver?"
-	fi
-
-	if [ $ret -ne 0 ]; then
-		tst_brk TBROK "Failed to mount device: mount exit = $ret"
-	fi
-}
-
 mkfs_verify_type()
 {
 	if [ -z "$1" ]; then
@@ -82,7 +69,7 @@ mkfs_verify_type()
 
 mkfs_verify_size()
 {
-	mkfs_mount
+	tst_mount
 	local blocknum=`df -P -B 1k mntpoint | tail -n1 | awk '{print $2}'`
 	tst_umount "$TST_DEVICE"
 
@@ -171,17 +158,17 @@ mkfs_test()
 
 test1()
 {
-	mkfs_test "" "$FS_TYPE" "" "$TST_DEVICE"
+	mkfs_test "" "$TST_FS_TYPE" "" "$TST_DEVICE"
 }
 
 test2()
 {
-	mkfs_test "" "$FS_TYPE" "" "$TST_DEVICE" "16000"
+	mkfs_test "" "$TST_FS_TYPE" "" "$TST_DEVICE" "16000"
 }
 
 test3()
 {
-	mkfs_test "" "$FS_TYPE" "-c" "$TST_DEVICE"
+	mkfs_test "" "$TST_FS_TYPE" "-c" "$TST_DEVICE"
 }
 
 test4()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index fe6098135..1ebd8484d 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -28,7 +28,7 @@ TST_NEEDS_ROOT=1
 
 SYSFS="/sys"
 UMOUNT=
-FS_TYPE="ext3"
+TST_FS_TYPE="ext3"
 
 mount_helper()
 {
@@ -53,15 +53,10 @@ mount_loop_device()
 {
 	local ret
 
-	tst_test_cmds mkfs.$FS_TYPE
-	tst_mkfs $FS_TYPE $TST_DEVICE
-	ROD_SILENT mkdir -p mntpoint
-	mount ${TST_DEVICE} mntpoint
-	ret=$?
-	if [ $ret -ne 0 ]; then
-		tst_brk TBROK "failed to mount device (mount exit = $ret)"
-	fi
-	cd mntpoint
+	tst_test_cmds mkfs.$TST_FS_TYPE
+	tst_mkfs $TST_FS_TYPE $TST_DEVICE
+	tst_mount
+	cd $TST_MNTPOINT
 }
 
 print_ima_config()
-- 
2.21.0

