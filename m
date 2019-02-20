From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Feb 2019 17:20:14 +0100
Subject: [LTP] [PATCH 4/4] shell: Use $FS_TYPE and $TST_DEVICE as default
	params in tst_mkfs()
In-Reply-To: <20190220162014.5467-1-pvorel@suse.cz>
References: <20190220162014.5467-1-pvorel@suse.cz>
Message-ID: <20190220162014.5467-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt                            | 4 ++++
 testcases/commands/df/df01.sh                              | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 testcases/lib/tst_test.sh                                  | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 5aa7e0279..81fa3b0bc 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2004,6 +2004,10 @@ The 'tst_mkfs' helper will format device with the filesystem.
 -------------------------------------------------------------------------------
 # format test device with ext2
 tst_mkfs ext2 $TST_DEVICE
+# default params are $FS_TYPE $TST_DEVICE
+tst_mkfs
+# optional parameters
+tst_mkfs ext4 /dev/device -T largefile
 -------------------------------------------------------------------------------
 
 Mounting and unmounting filesystems
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index b93fb7ad7..426ba7560 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -49,7 +49,7 @@ parse_args()
 
 setup()
 {
-	tst_mkfs $FS_TYPE $TST_DEVICE
+	tst_mkfs
 	tst_mount
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
 }
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index e000390e4..100813b4d 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -53,7 +53,7 @@ mount_loop_device()
 {
 	local ret
 
-	tst_mkfs $FS_TYPE $TST_DEVICE
+	tst_mkfs
 	tst_mount
 	cd $TST_MOUNT
 }
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 9ac45e04a..055eecbd6 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -283,8 +283,8 @@ tst_umount()
 
 tst_mkfs()
 {
-	local fs_type=$1
-	local device=$2
+	local fs_type=${1:-$FS_TYPE}
+	local device=${2:-$TST_DEVICE}
 	shift 2
 	local fs_opts="$@"
 
-- 
2.20.1

