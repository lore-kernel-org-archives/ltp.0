From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 3 Nov 2016 18:55:17 +0800
Subject: [LTP] [PATCH 2/3] syscalls/umount02: Cleanup && Convert to new API
In-Reply-To: <1478170518-5952-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1478170518-5952-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1478170518-5952-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/umount/umount02.c | 128 ++++++++++------------------
 1 file changed, 43 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount02.c b/testcases/kernel/syscalls/umount/umount02.c
index 7d469fd..7ff125a 100644
--- a/testcases/kernel/syscalls/umount/umount02.c
+++ b/testcases/kernel/syscalls/umount/umount02.c
@@ -29,119 +29,77 @@
  *****************************************************************************/
 
 #include <errno.h>
+#include <string.h>
 #include <sys/mount.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/fcntl.h>
-#include <pwd.h>
+#include "tst_test.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "umount02";
-
-#define DIR_MODE	S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH
-#define FILE_MODE	S_IRWXU | S_IRWXG | S_IRWXO
-#define MNTPOINT        "mntpoint"
+#define MNTPOINT	"mntpoint"
 
 static char long_path[PATH_MAX + 2];
 static int mount_flag;
 static int fd;
 
-static const char *device;
-
-static struct test_case_t {
-	char *err_desc;
-	char *mntpoint;
+static struct tcase {
+	const char *err_desc;
+	const char *mntpoint;
 	int exp_errno;
-	char *exp_retval;
-} testcases[] = {
-	{"Already mounted/busy", MNTPOINT, EBUSY, "EBUSY"},
-	{"Invalid address space", NULL, EFAULT, "EFAULT"},
-	{"Directory not found", "nonexistent", ENOENT, "ENOENT"},
-	{"Invalid  device", "./", EINVAL, "EINVAL"},
-	{"Pathname too long", long_path, ENAMETOOLONG, "ENAMETOOLONG"}
+} tcases[] = {
+	{"Already mounted/busy", MNTPOINT, EBUSY},
+	{"Invalid address space", NULL, EFAULT},
+	{"Directory not found", "nonexistent", ENOENT},
+	{"Invalid  device", "./", EINVAL},
+	{"Pathname too long", long_path, ENAMETOOLONG}
 };
 
-int TST_TOTAL = ARRAY_SIZE(testcases);
-
-int main(int ac, char **av)
+static void verify_umount(unsigned int n)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	struct tcase *tc = &tcases[n];
 
-	setup();
+	TEST(umount(tc->mntpoint));
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; ++i) {
-			TEST(umount(testcases[i].mntpoint));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "umount() succeeds unexpectedly");
+		return;
+	}
 
-			if ((TEST_RETURN == -1) &&
-			    (TEST_ERRNO == testcases[i].exp_errno)) {
-				tst_resm(TPASS, "umount(2) expected failure; "
-					 "Got errno - %s : %s",
-					 testcases[i].exp_retval,
-					 testcases[i].err_desc);
-			} else {
-				tst_resm(TFAIL, "umount(2) failed to produce "
-					 "expected error; %d, errno:%s got %d",
-					 testcases[i].exp_errno,
-					 testcases[i].exp_retval, TEST_ERRNO);
-			}
-		}
+	if (tc->exp_errno != TEST_ERRNO) {
+		tst_res(TFAIL | TTERRNO, "umount() should fail with %s",
+			tst_strerrno(tc->exp_errno));
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS | TTERRNO, "umount() fails as expected: %s",
+		tc->err_desc);
 }
 
 static void setup(void)
 {
-	const char *fs_type;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_require_root();
-
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
 	memset(long_path, 'a', PATH_MAX + 1);
 
-	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
-
-	if (mount(device, MNTPOINT, fs_type, 0, NULL))
-		tst_brkm(TBROK | TERRNO, cleanup, "mount() failed");
+	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
+	SAFE_MKDIR(MNTPOINT, 0775);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;
 
-	fd = SAFE_OPEN(cleanup, MNTPOINT "/file", O_CREAT | O_RDWR);
-
-	TEST_PAUSE;
+	fd = SAFE_CREAT(MNTPOINT "/file", 0777);
 }
 
 static void cleanup(void)
 {
 	if (fd > 0 && close(fd))
-		tst_resm(TWARN | TERRNO, "Failed to close file");
-
-	if (mount_flag && tst_umount(MNTPOINT))
-		tst_resm(TWARN | TERRNO, "umount() failed");
-
-	if (device)
-		tst_release_device(device);
+		tst_res(TWARN | TERRNO, "Failed to close file");
 
-	tst_rmdir();
+	if (mount_flag)
+		tst_umount(MNTPOINT);
 }
+
+static struct tst_test test = {
+	.tid = "umount02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_device = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_umount,
+};
-- 
1.8.4.2



