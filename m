From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Apr 2019 18:52:24 +0200
Subject: [LTP] [PATCH v2 2/3] shell: Add $TST_DEVICE as default parameter to
	tst_umount
In-Reply-To: <20190405165225.27216-1-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
Message-ID: <20190405165225.27216-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ use it directly as a cleanup function in df01.sh

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt                            | 4 ++--
 testcases/commands/df/df01.sh                              | 7 +------
 testcases/commands/mkfs/mkfs01.sh                          | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 testcases/lib/tst_test.sh                                  | 2 +-
 5 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f1912dc12..fc64b418b 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2115,8 +2115,8 @@ The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to
 '$TST_MNT_PARAMS'. The '$TST_MNTPOINT' directory is created if it didn't
 exist prior to the function call.
 
-If the path passed to the 'tst_umount' is not mounted (present in '/proc/mounts')
-it's noop.
+If the path passed (optional, defaults to '$TST_DEVICE') to the 'tst_umount' is
+not mounted (present in '/proc/mounts') it's noop.
 Otherwise it retries to umount the filesystem a few times on a failure, which
 is a workaround since there are a daemons dumb enough to probe all newly
 mounted filesystems, which prevents them from umounting shortly after they
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 9b0be76fe..3876816dc 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -18,7 +18,7 @@
 
 TST_CNT=12
 TST_SETUP=setup
-TST_CLEANUP=cleanup
+TST_CLEANUP=tst_umount
 TST_TESTFUNC=test
 TST_OPTS="f:"
 TST_USAGE=usage
@@ -54,11 +54,6 @@ setup()
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
 }
 
-cleanup()
-{
-	tst_umount $TST_DEVICE
-}
-
 df_test()
 {
 	local cmd="$1 -P"
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 88f7f0baa..28af890b3 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -71,7 +71,7 @@ mkfs_verify_size()
 {
 	tst_mount
 	local blocknum=`df -P -B 1k mntpoint | tail -n1 | awk '{print $2}'`
-	tst_umount "$TST_DEVICE"
+	tst_umount
 
 	if [ $blocknum -gt "$2" ]; then
 		return 1
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index cbded42c2..da49eb1b2 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -105,7 +105,7 @@ ima_cleanup()
 
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		cd $TST_TMPDIR
-		tst_umount $TST_DEVICE
+		tst_umount
 	fi
 }
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 512732315..740253df1 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -259,7 +259,7 @@ tst_mount()
 
 tst_umount()
 {
-	local device="$1"
+	local device="${1:-$TST_DEVICE}"
 	local i=0
 
 	if ! grep -q "$device" /proc/mounts; then
-- 
2.21.0

