From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Nov 2017 16:34:37 -0800
Subject: [LTP] [PATCH 5/6] syscalls/mkdir03: convert to new API and use
	.needsrofs for EROFS check
In-Reply-To: <20171109003438.130802-1-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
Message-ID: <20171109003438.130802-6-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The mkdir03 test is converted to the new API along with removing the
need to manually acquire and mount a loopback devices for EROFS checks.
This now makes it possible for the test to run on Android systems as
well.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/mkdir/mkdir03.c | 147 +++++++++---------------------
 1 file changed, 42 insertions(+), 105 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 823ee9dd1..97932c18c 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -29,19 +29,12 @@
 #include <fcntl.h>
 #include <sys/mount.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-static void setup(void);
-struct test_case_t;
-static void mkdir_verify(struct test_case_t *tc);
-static void bad_addr_setup(struct test_case_t *tc);
-static void cleanup(void);
-static int mount_flag;
+#include "tst_test.h"
 
 #define TST_EEXIST	"tst_eexist"
 #define TST_ENOENT	"tst_enoent/tst"
-#define TST_ENOTDIR	"tst_enotdir/tst"
+#define TST_ENOTDIR_FILE "tst_enotdir"
+#define TST_ENOTDIR_DIR	"tst_enotdir/tst"
 #define MODE		0777
 
 #define MNT_POINT	"mntpoint"
@@ -49,122 +42,66 @@ static int mount_flag;
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define TST_EROFS      "mntpoint/tst_erofs"
 
-char *TCID = "mkdir03";
-
-static char long_dir[PATH_MAX+2];
+static char long_dir[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};
 static char loop_dir[PATH_MAX] = ".";
-static const char *device;
 
-static struct test_case_t {
+static struct tcase {
 	char *pathname;
-	int mode;
 	int exp_errno;
-	void (*setupfunc) (struct test_case_t *tc);
 } TC[] = {
 #if !defined(UCLINUX)
-	{NULL, MODE, EFAULT, bad_addr_setup},
+	{NULL, EFAULT},
 #endif
-	{long_dir, MODE, ENAMETOOLONG, NULL},
-	{TST_EEXIST, MODE, EEXIST, NULL},
-	{TST_ENOENT, MODE, ENOENT, NULL},
-	{TST_ENOTDIR, MODE, ENOTDIR, NULL},
-	{loop_dir, MODE, ELOOP, NULL},
-	{TST_EROFS, MODE, EROFS, NULL},
+	{long_dir, ENAMETOOLONG},
+	{TST_EEXIST, EEXIST},
+	{TST_ENOENT, ENOENT},
+	{TST_ENOTDIR_DIR, ENOTDIR},
+	{loop_dir, ELOOP},
+	{TST_EROFS, EROFS},
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-
-int main(int ac, char **av)
-{
-	int i, lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++)
-			mkdir_verify(&TC[i]);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	int i;
-	const char *fs_type;
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fs_type = tst_dev_fs_type();
-	device = tst_acquire_device(cleanup);
-
-	if (!device)
-		tst_brkm(TCONF, cleanup, "Failed to acquire device");
-
-	memset(long_dir, 'a', PATH_MAX+1);
-
-	SAFE_TOUCH(cleanup, TST_EEXIST, MODE, NULL);
-
-	SAFE_TOUCH(cleanup, "tst_enotdir", MODE, NULL);
-
-	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
-	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
-	for (i = 0; i < 43; i++)
-		strcat(loop_dir, "/test_eloop");
-
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
-	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
-	mount_flag = 1;
-}
-
-#if !defined(UCLINUX)
-static void bad_addr_setup(struct test_case_t *tc)
-{
-	tc->pathname = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
-				 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-}
-#endif
-
-static void mkdir_verify(struct test_case_t *tc)
+static void verify_mkdir(unsigned int n)
 {
-	if (tc->setupfunc != NULL)
-		tc->setupfunc(tc);
-
-	TEST(mkdir(tc->pathname, tc->mode));
+	struct tcase *tc = TC + n;
 
+	TEST(mkdir(tc->pathname, MODE));
 	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL, "mkdir() returned %ld, expected -1, errno=%d",
-			 TEST_RETURN, tc->exp_errno);
+		tst_res(TFAIL, "mkdir() returned %ld, expected -1, errno=%d",
+			TEST_RETURN, tc->exp_errno);
 		return;
 	}
 
 	if (TEST_ERRNO == tc->exp_errno) {
-		tst_resm(TPASS | TTERRNO, "mkdir() failed as expected");
+		tst_res(TPASS | TTERRNO, "mkdir() failed as expected");
 	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "mkdir() failed unexpectedly; expected: %d - %s",
+		tst_res(TFAIL | TTERRNO,
+			"mkdir() failed unexpectedly; expected: %d - %s",
 			 tc->exp_errno, strerror(tc->exp_errno));
 	}
 }
 
-static void cleanup(void)
+static void setup(void)
 {
-	if (mount_flag && tst_umount(MNT_POINT) < 0)
-		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
-
-	if (device)
-		tst_release_device(device);
+	int i;
+#if !defined(UCLINUX)
+	TC[0].pathname = SAFE_MMAP(0, 1, PROT_NONE,
+				   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+#endif
+	SAFE_TOUCH(TST_EEXIST, MODE, NULL);
+	SAFE_TOUCH(TST_ENOTDIR_FILE, MODE, NULL);
 
-	tst_rmdir();
+	SAFE_MKDIR("test_eloop", DIR_MODE);
+	SAFE_SYMLINK("../test_eloop", "test_eloop/test_eloop");
+	for (i = 0; i < 43; i++)
+		strcat(loop_dir, "/test_eloop");
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(TC),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = MNT_POINT,
+	.setup = setup,
+	.test = verify_mkdir,
+};
-- 
2.15.0.448.gf294e3d99a-goog

