From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 3 Nov 2016 18:55:16 +0800
Subject: [LTP] [PATCH 1/3] syscalls/umount01: Cleanup && Convert to new API
Message-ID: <1478170518-5952-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/umount/umount01.c | 104 +++++++++-------------------
 1 file changed, 34 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index 4597651..a8da4f4 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -22,92 +22,56 @@
 
 #include <errno.h>
 #include <sys/mount.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "test.h"
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
+#define MNTPOINT	"mntpoint"
 
-char *TCID = "umount01";
-int TST_TOTAL = 1;
+static int mount_flag;
 
-#define DEFAULT_FSTYPE	"ext2"
-#define DIR_MODE	S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH
-
-static const char *mntpoint = "mntpoint";
-static const char *fs_type;
-static const char *device;
-
-int main(int ac, char **av)
+static void verify_umount(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(mount(device, mntpoint, fs_type, 0, NULL));
+	if (mount_flag != 1) {
+		SAFE_MOUNT(tst_device->dev, MNTPOINT,
+			tst_device->fs_type, 0, NULL);
+		mount_flag = 1;
+	}
 
-		if (TEST_RETURN != 0) {
-			tst_brkm(TBROK, cleanup, "mount(2) Failed errno = %d :"
-				 "%s ", TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			TEST(umount(mntpoint));
+	TEST(umount(MNTPOINT));
 
-			if (TEST_RETURN != 0 && TEST_ERRNO == EBUSY) {
-				tst_resm(TINFO, "umount() failed with EBUSY "
-				         "possibly some daemon (gvfsd-trash) "
-				         "is probing newly mounted dirs");
-			}
+	if (TEST_RETURN != 0 && TEST_ERRNO == EBUSY) {
+		tst_res(TINFO, "umount() Failed with EBUSY "
+			"possibly some daemon (gvfsd-trash) "
+			"is probing newly mounted dirs");
+	}
 
-			if (TEST_RETURN != 0) {
-				tst_brkm(TFAIL, NULL, "umount(2) Failed while "
-					 " unmounting %s errno = %d : %s",
-					 mntpoint, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TPASS, "umount(2) Passed ");
-			}
-		}
+	if (TEST_RETURN != 0) {
+		tst_res(TFAIL | TTERRNO, "umount() Failed");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "umount() Passed");
+	mount_flag = 0;
 }
 
 static void setup(void)
 {
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
 
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	if (mkdir(mntpoint, DIR_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(%s, %#o) failed; "
-			 "errno = %d: %s", mntpoint, DIR_MODE, errno,
-			 strerror(errno));
-	}
-
-	TEST_PAUSE;
+	SAFE_MKDIR(MNTPOINT, 0775);
 }
 
 static void cleanup(void)
 {
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
+	if (mount_flag)
+		tst_umount(MNTPOINT);
 }
+
+static struct tst_test test = {
+	.tid = "umount01",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_device = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_umount,
+};
-- 
1.8.4.2



