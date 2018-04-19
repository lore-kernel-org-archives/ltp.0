From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Apr 2018 21:55:01 +0200
Subject: [LTP] [RFC PATCH v3 08/10] ima/{ima_measurements,
	ima_violations}.sh: Avoid running on tmpfs
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180419195503.7194-9-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If $TMPDIR is on tmpfs, create loop device, format it to ext3 and run
tests in it.

The reason is that measure.policy excludes tmpfs (TMPFS_MAGIC,
"dont_measure fsmagic=0x01021994"), but TST_TMPDIR is often on tmpfs
filesystem. Lets test on ext3 created on loop device.

http://lists.linux.it/pipermail/ltp/2018-January/006970.html
http://lists.linux.it/pipermail/ltp/2018-March/007488.html

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_measurements.sh        |  1 +
 .../security/integrity/ima/tests/ima_setup.sh      | 40 ++++++++++++++++++++--
 .../security/integrity/ima/tests/ima_violations.sh |  4 +++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 0bceeb71f..294e29d30 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -22,6 +22,7 @@
 TST_NEEDS_CMDS="awk"
 TST_SETUP="setup"
 TST_CNT=3
+TST_NEEDS_DEVICE=1
 
 . ima_setup.sh
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index c08e2579e..03851167f 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -28,6 +28,7 @@ TST_NEEDS_ROOT=1
 
 SYSFS="/sys"
 UMOUNT=
+FS_TYPE="ext3"
 
 mount_helper()
 {
@@ -39,15 +40,30 @@ mount_helper()
 	[ -n "$dir" ] && { echo "$dir"; return; }
 
 	if ! mkdir -p $default_dir; then
-		tst_brk TBROK "Failed to create $default_dir"
+		tst_brk TBROK "failed to create $default_dir"
 	fi
 	if ! mount -t $type $type $default_dir; then
-		tst_brk TBROK "Failed to mount $type"
+		tst_brk TBROK "failed to mount $type"
 	fi
 	UMOUNT="$default_dir $UMOUNT"
 	echo $default_dir
 }
 
+mount_loop_device()
+{
+	local ret
+
+	tst_check_cmds mkfs.$FS_TYPE
+	tst_mkfs $FS_TYPE $TST_DEVICE
+	ROD_SILENT mkdir -p mntpoint
+	mount ${TST_DEVICE} mntpoint
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		tst_brk TBROK "failed to mount device (mount exit = $ret)"
+	fi
+	cd mntpoint
+}
+
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
@@ -57,7 +73,14 @@ ima_setup()
 	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
 	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
 
-	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
+	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
+		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
+		mount_loop_device
+	fi
+
+	if [ -n "$TST_SETUP_CALLER" ]; then
+		$TST_SETUP_CALLER
+	fi
 }
 
 ima_cleanup()
@@ -66,4 +89,15 @@ ima_cleanup()
 	for dir in $UMOUNT; do
 		umount $dir
 	done
+
+	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
+		cd $TST_TMPDIR
+		tst_umount $TST_DEVICE
+	fi
 }
+
+# loop device is needed to use only for tmpfs
+TMPDIR="${TMPDIR:-/tmp}"
+if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
+	unset TST_NEEDS_DEVICE
+fi
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 0e9afa7ff..8742f4593 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -21,6 +21,7 @@
 
 TST_SETUP="setup"
 TST_CNT=3
+TST_NEEDS_DEVICE=1
 
 . ima_setup.sh
 . daemonlib.sh
@@ -149,6 +150,9 @@ test3()
 	close_file_read
 
 	validate $num_violations $count $search
+
+	# wait for ima_mmap to exit, so we can umount
+	tst_sleep 2s
 }
 
 tst_run
-- 
2.16.3

