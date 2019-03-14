From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 10:49:19 +0100
Subject: [LTP] [PATCH v2 4/4] shell: Use $TST_FS_TYPE and $TST_DEVICE in
	tst_mkfs()
In-Reply-To: <20190314094919.12723-1-pvorel@suse.cz>
References: <20190314094919.12723-1-pvorel@suse.cz>
Message-ID: <20190314094919.12723-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as default parameters.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt                            | 4 ++++
 testcases/commands/df/df01.sh                              | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 testcases/lib/tst_test.sh                                  | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index d28728d10..73fc687d5 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2032,6 +2032,10 @@ The 'tst_mkfs' helper will format device with the filesystem.
 -------------------------------------------------------------------------------
 # format test device with ext2
 tst_mkfs ext2 $TST_DEVICE
+# default params are $TST_FS_TYPE $TST_DEVICE
+tst_mkfs
+# optional parameters
+tst_mkfs ext4 /dev/device -T largefile
 -------------------------------------------------------------------------------
 
 Mounting and unmounting filesystems
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 1ffecd2da..9b0be76fe 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -49,7 +49,7 @@ parse_args()
 
 setup()
 {
-	tst_mkfs $TST_FS_TYPE $TST_DEVICE
+	tst_mkfs
 	tst_mount
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
 }
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index bfdcfaef7..52551190a 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -53,7 +53,7 @@ mount_loop_device()
 {
 	local ret
 
-	tst_mkfs $TST_FS_TYPE $TST_DEVICE
+	tst_mkfs
 	tst_mount
 	cd $TST_MNTPOINT
 }
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index ecd162e60..af16ce1cf 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -286,8 +286,8 @@ tst_umount()
 
 tst_mkfs()
 {
-	local fs_type=$1
-	local device=$2
+	local fs_type=${1:-$TST_FS_TYPE}
+	local device=${2:-$TST_DEVICE}
 	shift 2
 	local fs_opts="$@"
 
-- 
2.21.0

