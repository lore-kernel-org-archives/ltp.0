From: Chenbo Feng <fengc@google.com>
Date: Fri, 11 May 2018 16:10:27 -0700
Subject: [LTP] [PATCH] syscall/open11: use the new ltp test library
Message-ID: <20180511231027.64305-1-fengc@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Migrate the open11 test to use the new tst_test framework. Change the
character file node location into the device mount point so the test
will no longer fail if the original filesystem have MNT_NODEV flag set.

Signed-off-by: Chenbo Feng <fengc@google.com>
---
 testcases/kernel/syscalls/open/open11.c | 114 ++++++++++--------------
 1 file changed, 45 insertions(+), 69 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 78002f37d..abe4e3a08 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -73,10 +73,7 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "open11";
+#include "tst_test.h"
 
 /* Define test files */
 #define T_REG "t_reg"			/* regular file with content */
@@ -86,21 +83,18 @@ char *TCID = "open11";
 #define T_SYMLINK_REG "t_symlink_reg"	/* symlink to T_REG */
 #define T_DIR "t_dir"			/* test dir */
 #define T_SYMLINK_DIR "t_symlink_dir"	/* symlink to T_DIR */
-#define T_DEV "t_dev"			/* test device special file */
+#define T_DEV "mntpoint/t_dev"			/* test device special file */
+#define MNT_POINT      "mntpoint"
 
 #define T_MSG "this is a test string"
 
-static void setup(void);
-static void cleanup(void);
-
-struct test_case {
+static struct tcase {
 	char *desc;
 	char *path;
 	int flags;
 	mode_t mode;
 	int err;
-};
-struct test_case tc[] = {
+} tcases[] = {
 	/*
 	 * Test open(2) regular file
 	 */
@@ -267,8 +261,8 @@ struct test_case tc[] = {
 		.err = 0,
 	},
 	/*
-	 * test open(2) with O_CREAT
-	 */
+	* test open(2) with O_CREAT
+	*/
 	{	/* open hard link file O_RDONLY | O_CREAT */
 		.desc = "Open link file O_RDONLY | O_CREAT",
 		.path = T_LINK_REG,
@@ -325,79 +319,61 @@ struct test_case tc[] = {
 	},
 };
 
-int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	int i;
-	int fd;
-	int ret;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(open(tc[i].path, tc[i].flags, tc[i].mode));
-			fd = TEST_RETURN;
-
-			if (tc[i].err == -1 || TEST_ERRNO == tc[i].err) {
-				tst_resm(TPASS, "%s", tc[i].desc);
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "%s - expected errno %d - Got",
-					 tc[i].desc, tc[i].err);
-			}
-			if (fd > 0) {
-				ret = close(fd);
-				if (ret < 0)
-					tst_resm(TWARN, "%s - close failed: %s",
-						 tc[i].desc, strerror(errno));
-			}
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
 	int fd;
 	int ret;
 
-	tst_require_root();
-
-	tst_tmpdir();
-
 	/* Create test files */
-	fd = SAFE_OPEN(cleanup, T_REG, O_WRONLY | O_CREAT, 0644);
+	fd = SAFE_OPEN(T_REG, O_WRONLY | O_CREAT, 0644);
 	ret = write(fd, T_MSG, sizeof(T_MSG));
 	if (ret == -1) {
 		close(fd);
-		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", T_REG);
+		tst_brk(TBROK | TERRNO, "Write %s failed", T_REG);
 	}
 	close(fd);
 
-	fd = SAFE_CREAT(cleanup, T_REG_EMPTY, 0644);
+	fd = SAFE_CREAT(T_REG_EMPTY, 0644);
 	close(fd);
 
-	SAFE_LINK(cleanup, T_REG, T_LINK_REG);
-	SAFE_SYMLINK(cleanup, T_REG, T_SYMLINK_REG);
-	SAFE_MKDIR(cleanup, T_DIR, 0755);
-	SAFE_SYMLINK(cleanup, T_DIR, T_SYMLINK_DIR);
+	SAFE_LINK(T_REG, T_LINK_REG);
+	SAFE_SYMLINK(T_REG, T_SYMLINK_REG);
+	SAFE_MKDIR(T_DIR, 0755);
+	SAFE_SYMLINK(T_DIR, T_SYMLINK_DIR);
 
-	ret = mknod(T_DEV, S_IFCHR, makedev(1, 5));
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create char dev %s failed",
-			 T_DEV);
+	SAFE_MKNOD(T_DEV, S_IFCHR, makedev(1, 5));
 
-	TEST_PAUSE;
 }
 
-static void cleanup(void)
+static void verify_open(unsigned int n)
 {
-	tst_rmdir();
+	int fd;
+	int ret;
+	struct tcase *tc = &tcases[n];
+
+	TEST(open(tc->path, tc->flags, tc->mode));
+	fd = TEST_RETURN;
+
+	if (tc->err == -1 || TEST_ERRNO == tc->err) {
+		tst_res(TPASS, "%s", tc->desc);
+	} else {
+		tst_res(TFAIL | TTERRNO,
+			 "%s - expected errno %d - Got",
+			 tc->desc, tc->err);
+	}
+	if (fd > 0) {
+		ret = close(fd);
+		if (ret < 0)
+			tst_res(TWARN, "%s - close failed: %s",
+				 tc->desc, strerror(errno));
+	}
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.mntpoint = MNT_POINT,
+	.mount_device = 1,
+	.setup = setup,
+	.test = verify_open,
+};
-- 
2.17.0.441.gb46fe60e1d-goog

