From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Mar 2019 10:49:18 +0100
Subject: [LTP] [PATCH v2 3/4] shell: Move mkfs.foo into tst_mkfs()
In-Reply-To: <20190314094919.12723-1-pvorel@suse.cz>
References: <20190314094919.12723-1-pvorel@suse.cz>
Message-ID: <20190314094919.12723-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ remove unused local ret variable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/df/df01.sh                              | 6 ------
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 1 -
 testcases/lib/tst_test.sh                                  | 3 ++-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 5d9eda802..1ffecd2da 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -49,12 +49,6 @@ parse_args()
 
 setup()
 {
-	local ret
-
-	if [ -n "$TST_FS_TYPE" ]; then
-		tst_test_cmds mkfs.${TST_FS_TYPE}
-	fi
-
 	tst_mkfs $TST_FS_TYPE $TST_DEVICE
 	tst_mount
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1ebd8484d..bfdcfaef7 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -53,7 +53,6 @@ mount_loop_device()
 {
 	local ret
 
-	tst_test_cmds mkfs.$TST_FS_TYPE
 	tst_mkfs $TST_FS_TYPE $TST_DEVICE
 	tst_mount
 	cd $TST_MNTPOINT
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8e7a5b6d6..ecd162e60 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -299,8 +299,9 @@ tst_mkfs()
 		tst_brk TBROK "No device specified"
 	fi
 
-	tst_res TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
+	tst_test_cmds mkfs.$fs_type
 
+	tst_res TINFO "Formatting $device with $fs_type extra opts='$fs_opts'"
 	ROD_SILENT mkfs.$fs_type $fs_opts $device
 }
 
-- 
2.21.0

