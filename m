From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 10:49:16 +0100
Subject: [LTP] [PATCH v2 1/4] shell: Add tst_mount() helper
In-Reply-To: <20190314094919.12723-1-pvorel@suse.cz>
References: <20190314094919.12723-1-pvorel@suse.cz>
Message-ID: <20190314094919.12723-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and TST_FS_TYPE, TST_MNTPOINT, TST_MNT_PARAMS variables.
TST_FS_TYPE is going to replace FS_TYPE in next commits.
+ document changes.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
[pvorel: Thanks Cyril to point out correct variable names]
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 12 ++++++++----
 testcases/lib/tst_test.sh       | 25 ++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a5fe58960..d28728d10 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2034,12 +2034,16 @@ The 'tst_mkfs' helper will format device with the filesystem.
 tst_mkfs ext2 $TST_DEVICE
 -------------------------------------------------------------------------------
 
-Umounting filesystems
-+++++++++++++++++++++
+Mounting and unmounting filesystems
++++++++++++++++++++++++++++++++++++
+
+The 'tst_mount' and 'tst_umount' helpers are a safe way to mount/umount a filesystem.
 
-The 'tst_umount' helper is a safe way to umount a filesystem.
+The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to '$TST_MNTPOINT',
+using optional '$TST_MNT_PARAMS'. It creates before mounting the '$TST_MNTPOINT'
+directory if not exists and fails if mounting was unsuccessful.
 
-If the path passed to the function is not mounted (present in '/proc/mounts')
+If the path passed to the 'tst_umount' is not mounted (present in '/proc/mounts')
 it's noop.
 
 Otherwise it retries to umount the filesystem a few times on a failure, which
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index f36051f55..8e7a5b6d6 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -235,6 +235,28 @@ TST_RTNL_CHK()
 	tst_brk TBROK "$@ failed: $output"
 }
 
+tst_mount()
+{
+	local mnt_opt mnt_err
+
+	if [ -n "$TST_FS_TYPE" ]; then
+		mnt_opt="-t $TST_FS_TYPE"
+		mnt_err=" $TST_FS_TYPE type"
+	fi
+
+	ROD_SILENT mkdir -p $TST_MNTPOINT
+	mount $mnt_opt $TST_DEVICE $TST_MNTPOINT $TST_MNT_PARAMS
+	local ret=$?
+
+	if [ $ret -eq 32 ]; then
+		tst_brk TCONF "Cannot mount${mnt_err}, missing driver?"
+	fi
+
+	if [ $ret -ne 0 ]; then
+		tst_brk TBROK "Failed to mount device${mnt_err}: mount exit = $ret"
+	fi
+}
+
 tst_umount()
 {
 	local device="$1"
@@ -401,7 +423,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			NEEDS_DRIVERS);;
+			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
 			NET_MAX_PKT);;
@@ -462,6 +484,7 @@ tst_run()
 		cd "$TST_TMPDIR"
 	fi
 
+	TST_MNTPOINT="${TST_MNTPOINT:-mntpoint}"
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		if [ -z ${TST_TMPDIR} ]; then
 			tst_brk TBROK "Use TST_NEEDS_TMPDIR must be set for TST_NEEDS_DEVICE"
-- 
2.21.0

