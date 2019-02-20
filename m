From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Feb 2019 17:20:11 +0100
Subject: [LTP] [PATCH 1/4] shell: Add tst_mount() helper
Message-ID: <20190220162014.5467-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and TST_MOUNT, TST_MOUNT_PARAMS} variables.
+ document changes.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 12 ++++++++----
 testcases/lib/tst_test.sh       | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f2f72c4d6..5aa7e0279 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2006,12 +2006,16 @@ The 'tst_mkfs' helper will format device with the filesystem.
 tst_mkfs ext2 $TST_DEVICE
 -------------------------------------------------------------------------------
 
-Umounting filesystems
-+++++++++++++++++++++
+Mounting and unmounting filesystems
++++++++++++++++++++++++++++++++++++
+
+The 'tst_mount' and 'tst_umount' helpers are a safe way to mount/umount a filesystem.
 
-The 'tst_umount' helper is a safe way to umount a filesystem.
+The 'tst_mount' mounts '$TST_DEVICE' to '$TST_MOUNT', using optional '$TST_MOUNT_PARAMS'.
+It creates before mounting the '$TST_MOUNT' directory if not exists and fails
+if mounting was unsuccessful.
 
-If the path passed to the function is not mounted (present in '/proc/mounts')
+If the path passed to the 'tst_umount' is not mounted (present in '/proc/mounts')
 it's noop.
 
 Otherwise it retries to umount the filesystem a few times on a failure, which
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 3d2f5afde..4abea6665 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -235,6 +235,25 @@ TST_RTNL_CHK()
 	tst_brk TBROK "$@ failed: $output"
 }
 
+tst_mount()
+{
+	if [ -z "$FS_TYPE" ]; then
+		tst_brk TBROK "Missing FS_TYPE variable"
+	fi
+
+	ROD_SILENT mkdir -p $TST_MOUNT
+	mount -t $FS_TYPE $TST_DEVICE $TST_MOUNT $TST_MOUNT_PARAMS
+	local ret=$?
+
+	if [ $ret -eq 32 ]; then
+		tst_brk TCONF "Cannot mount $FS_TYPE, missing driver?"
+	fi
+
+	if [ $ret -ne 0 ]; then
+		tst_brk TBROK "Failed to mount device: mount exit = $ret"
+	fi
+}
+
 tst_umount()
 {
 	local device="$1"
@@ -401,7 +420,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			NEEDS_DRIVERS);;
+			NEEDS_DRIVERS|MOUNT|MOUNT_PARAMS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
@@ -461,6 +480,7 @@ tst_run()
 		cd "$TST_TMPDIR"
 	fi
 
+	TST_MOUNT="${TST_MOUNT:-mntpoint}"
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		if [ -z ${TST_TMPDIR} ]; then
 			tst_brk TBROK "Use TST_NEEDS_TMPDIR must be set for TST_NEEDS_DEVICE"
-- 
2.20.1

