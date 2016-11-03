From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 3 Nov 2016 18:55:18 +0800
Subject: [LTP] [PATCH 3/3] syscalls/umount03: Cleanup && Convert to new API
In-Reply-To: <1478170518-5952-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1478170518-5952-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1478170518-5952-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/umount/umount03.c | 105 +++++++++-------------------
 1 file changed, 32 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 322005e..1ade141 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -20,107 +20,66 @@
  *	is not the super-user.
  *
  * RESTRICTIONS
- *	test must be run with the -D option
  *	test doesn't support -c option to run it in parallel, as mount
  *	syscall is not supposed to run in parallel.
  */
 
 #include <errno.h>
+#include <pwd.h>
 #include <sys/mount.h>
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/fcntl.h>
-#include <sys/wait.h>
-#include <pwd.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include <unistd.h>
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "umount03";
-
-#define FSTYPE_LEN	20
-#define DIR_MODE	S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH
 #define MNTPOINT	"mntpoint"
 
-static const char *device;
 static int mount_flag;
 
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void verify_umount(void)
 {
-	int lc;
+	TEST(umount(MNTPOINT));
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(umount(MNTPOINT));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "umout() didn't fail (ret=%ld)",
-				 TEST_RETURN);
-			continue;
-		}
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "umount() succeeds unexpectedly");
+		return;
+	}
 
-		if (TEST_ERRNO == EPERM) {
-			tst_resm(TPASS | TTERRNO, "umount() failed with EPERM");
-		} else {
-			tst_resm(TFAIL | TTERRNO,
-			         "umount() did not fail with EPERM(%d)", EPERM);
-		}
+	if (EPERM != TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO, "umount() should fail with EPERM");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS | TTERRNO, "umount() fails as expected");
 }
 
 static void setup(void)
 {
-	const char *fs_type;
-	struct passwd *ltpuser;
+	struct passwd *pw;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
-	ltpuser = SAFE_GETPWNAM(NULL, "nobody");
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-
-	if (mount(device, MNTPOINT, fs_type, 0, NULL))
-		tst_brkm(TBROK | TERRNO, cleanup, "mount() failed");
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
+	SAFE_MKDIR(MNTPOINT, 0775);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
 
-	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
-	TEST_PAUSE;
+	pw = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(pw->pw_uid);
 }
 
 static void cleanup(void)
 {
 	if (seteuid(0))
-		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
-
-	if (mount_flag && tst_umount(MNTPOINT))
-		tst_resm(TWARN | TERRNO, "umount() failed");
+		tst_res(TWARN | TERRNO, "seteuid(0) Failed");
 
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
+	if (mount_flag)
+		tst_umount(MNTPOINT);
 }
+
+static struct tst_test test = {
+	.tid = "umount03",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_device = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_umount,
+};
-- 
1.8.4.2



