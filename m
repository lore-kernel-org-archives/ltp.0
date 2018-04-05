From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Apr 2018 16:01:51 +0200
Subject: [LTP] [RFC PATCH 5/8] syscalls/mkdirat02: Rewrite to the new library
In-Reply-To: <20180405140154.6218-1-chrubis@suse.cz>
References: <20180405140154.6218-1-chrubis@suse.cz>
Message-ID: <20180405140154.6218-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Make use of .needs_rofs

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/mkdirat/mkdirat02.c | 137 +++++++-------------------
 1 file changed, 34 insertions(+), 103 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
index 9dcf37fb1..b2f86efa8 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -21,142 +21,73 @@
  */
 
 #define _GNU_SOURCE
-
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-#include <sys/mount.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/mkdirat.h"
 
-static void setup(void);
-static void cleanup(void);
-
-#define TEST_FILE1	"mntpoint/test_file1"
+#define MNT_POINT	"mntpoint"
+#define TEST_DIR	"mntpoint/test_dir"
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 
-char *TCID = "mkdirat02";
-
 static int dir_fd;
 static int cur_fd = AT_FDCWD;
-static char test_file2[PATH_MAX] = ".";
-static const char *device;
-static int mount_flag_dir;
-static int mount_flag_cur;
+static char test_dir[PATH_MAX] = ".";
 
-static struct test_case_t {
+static struct tcase {
 	int *dirfd;
 	char *pathname;
 	int exp_errno;
-} TC[] = {
-	{&dir_fd, TEST_FILE1, EROFS},
-	{&cur_fd, TEST_FILE1, EROFS},
-	{&dir_fd, test_file2, ELOOP},
-	{&cur_fd, test_file2, ELOOP},
+} tcases[] = {
+	{&dir_fd, TEST_DIR, EROFS},
+	{&cur_fd, TEST_DIR, EROFS},
+	{&dir_fd, test_dir, ELOOP},
+	{&cur_fd, test_dir, ELOOP},
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-static void mkdirat_verify(const struct test_case_t *);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			mkdirat_verify(&TC[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
-	int i;
-	const char *fs_type;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	unsigned int i;
 
-	tst_tmpdir();
+	dir_fd = SAFE_OPEN(".", O_DIRECTORY);
 
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
+	SAFE_MKDIR("test_eloop", DIR_MODE);
+	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
 
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to acquire device");
-
-	SAFE_MKDIR(cleanup, "test_dir", DIR_MODE);
-	dir_fd = SAFE_OPEN(cleanup, "test_dir", O_DIRECTORY);
-
-	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
-	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
-
-	SAFE_MKDIR(cleanup, "test_dir/test_eloop", DIR_MODE);
-	SAFE_SYMLINK(cleanup, "../test_eloop",
-		     "test_dir/test_eloop/test_eloop");
 	/*
 	 * NOTE: the ELOOP test is written based on that the consecutive
 	 * symlinks limits in kernel is hardwired to 40.
 	 */
 	for (i = 0; i < 43; i++)
-		strcat(test_file2, "/test_eloop");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-
-	SAFE_MKDIR(cleanup, "test_dir/mntpoint", DIR_MODE);
-	SAFE_MOUNT(cleanup, device, "test_dir/mntpoint", fs_type, MS_RDONLY,
-		   NULL);
-	mount_flag_dir = 1;
-
-	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
-	SAFE_MOUNT(cleanup, device, "mntpoint", fs_type, MS_RDONLY, NULL);
-	mount_flag_cur = 1;
+		strcat(test_dir, "/test_eloop");
 }
 
-static void mkdirat_verify(const struct test_case_t *test)
+static void mkdirat_verify(unsigned int i)
 {
+	struct tcase *test = &tcases[i];
+
 	TEST(mkdirat(*test->dirfd, test->pathname, 0777));
 
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "mkdirat() returned %ld, expected -1, errno=%d",
-			 TEST_RETURN, test->exp_errno);
+		tst_res(TFAIL, "mkdirat() succeeded unexpectedly (%li)",
+			TEST_RETURN);
 		return;
 	}
 
 	if (TEST_ERRNO == test->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "mkdirat() failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "mkdirat() failed unexpectedly; expected: %d - %s",
-			 test->exp_errno, strerror(test->exp_errno));
+		tst_res(TPASS | TTERRNO, "mkdirat() failed as expected");
+		return;
 	}
-}
-
-static void cleanup(void)
-{
-	if (mount_flag_dir && tst_umount("mntpoint") < 0)
-		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
-
-	if (mount_flag_cur && tst_umount("test_dir/mntpoint") < 0)
-		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
 
-	if (device)
-		tst_release_device(device);
-
-	tst_rmdir();
+	tst_res(TFAIL | TTERRNO,
+		"mkdirat() failed unexpectedly; expected: %d - %s",
+		test->exp_errno, tst_strerrno(test->exp_errno));
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = mkdirat_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+};
-- 
2.13.6

