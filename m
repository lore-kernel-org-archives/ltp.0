From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Feb 2019 17:20:12 +0100
Subject: [LTP] [PATCH 2/4] ima, commands/{df,mkfs}: Use tst_mount
In-Reply-To: <20190220162014.5467-1-pvorel@suse.cz>
References: <20190220162014.5467-1-pvorel@suse.cz>
Message-ID: <20190220162014.5467-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to reduce duplicity.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/df/df01.sh                  | 18 +++---------------
 testcases/commands/mkfs/mkfs01.sh              | 15 +--------------
 .../security/integrity/ima/tests/ima_setup.sh  |  9 ++-------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index ecd66fbd6..4f77500b8 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -55,26 +55,14 @@ setup()
 		tst_test_cmds mkfs.${FS_TYPE}
 	fi
 
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
-	fi
-
+	tst_mkfs $FS_TYPE $TST_DEVICE
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
index 68d40830a..25d185a05 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -54,19 +54,6 @@ setup()
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
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index fe6098135..e51d3d70b 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -55,13 +55,8 @@ mount_loop_device()
 
 	tst_test_cmds mkfs.$FS_TYPE
 	tst_mkfs $FS_TYPE $TST_DEVICE
-	ROD_SILENT mkdir -p mntpoint
-	mount ${TST_DEVICE} mntpoint
-	ret=$?
-	if [ $ret -ne 0 ]; then
-		tst_brk TBROK "failed to mount device (mount exit = $ret)"
-	fi
-	cd mntpoint
+	tst_mount
+	cd $TST_MOUNT
 }
 
 print_ima_config()
-- 
2.20.1

