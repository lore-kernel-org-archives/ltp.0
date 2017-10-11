From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 16:41:26 +0200
Subject: [LTP] [PATCH v3 12/16] syscallse/setxattr02: Convert to the new
	library
In-Reply-To: <20171011144130.29728-1-chrubis@suse.cz>
References: <20171011144130.29728-1-chrubis@suse.cz>
Message-ID: <20171011144130.29728-12-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/setxattr/setxattr02.c | 120 ++++++++----------------
 1 file changed, 41 insertions(+), 79 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 6d39236a3..0b6ecb3fa 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -57,10 +57,7 @@
 #ifdef HAVE_SYS_XATTR_H
 # include <sys/xattr.h>
 #endif
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "setxattr02";
+#include "tst_test.h"
 
 #ifdef HAVE_SYS_XATTR_H
 #define XATTR_TEST_KEY "user.testkey"
@@ -75,9 +72,6 @@ char *TCID = "setxattr02";
 #define BLK      "setxattr02blk"
 #define SOCK     "setxattr02sock"
 
-static void setup(void);
-static void cleanup(void);
-
 struct test_case {
 	char *fname;
 	char *key;
@@ -145,91 +139,59 @@ static struct test_case tc[] = {
 	 },
 };
 
-int TST_TOTAL = sizeof(tc) / sizeof(tc[0]);
-
-int main(int argc, char *argv[])
+static void verify_setxattr(unsigned int i)
 {
-	int lc;
-	int i;
+	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size, tc[i].flags));
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	if (TEST_RETURN == -1 && TEST_ERRNO == EOPNOTSUPP)
+		tst_brk(TCONF, "setxattr() not supported");
 
-	setup();
+	if (!tc[i].exp_err) {
+		if (TEST_RETURN) {
+			tst_res(TFAIL | TTERRNO,
+				"setxattr() failed with %li", TEST_RETURN);
+			return;
+		}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+		tst_res(TPASS, "setxattr() passed");
+		return;
+	}
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value,
-				      tc[i].size, tc[i].flags));
+	if (TEST_RETURN == 0) {
+		tst_res(TFAIL, "setxattr() passed unexpectedly");
+		return;
+	}
 
-			if (TEST_ERRNO == tc[i].exp_err) {
-				tst_resm(TPASS | TTERRNO, "expected behavior");
-			} else {
-				tst_resm(TFAIL | TTERRNO, "unexpected behavior "
-					 "- expected errno %d - Got",
-					 tc[i].exp_err);
-			}
-		}
+	if (TEST_ERRNO != tc[i].exp_err) {
+		tst_res(TFAIL | TTERRNO, "setxattr() should fail with %s",
+			tst_strerrno(tc[i].exp_err));
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TPASS | TTERRNO, "setxattr() failed");
 }
 
 static void setup(void)
 {
-	int fd;
-	dev_t dev;
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	/* Test for xattr support */
-	fd = SAFE_CREAT(cleanup, "testfile", 0644);
-	close(fd);
-	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
-		if (errno == ENOTSUP)
-			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
-				 "mount without user_xattr option");
-	unlink("testfile");
-
-	/* Create test files */
-	fd = SAFE_CREAT(cleanup, FILENAME, 0644);
-	close(fd);
-
-	SAFE_MKDIR(cleanup, DIRNAME, 0644);
-
-	SAFE_SYMLINK(cleanup, FILENAME, SYMLINK);
-
-	if (mknod(FIFO, S_IFIFO | 0777, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create FIFO(%s) failed",
-			 FIFO);
-
-	dev = makedev(1, 3);
-	if (mknod(CHR, S_IFCHR | 0777, dev) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create char special(%s)"
-			 " failed", CHR);
-
-	if (mknod(BLK, S_IFBLK | 0777, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create block special(%s)"
-			 " failed", BLK);
-
-	if (mknod(SOCK, S_IFSOCK | 0777, 0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create socket(%s) failed",
-			 SOCK);
-
-	TEST_PAUSE;
+	dev_t dev = makedev(1, 3);
+
+	SAFE_TOUCH(FILENAME, 0644, NULL);
+	SAFE_MKDIR(DIRNAME, 0644);
+	SAFE_SYMLINK(FILENAME, SYMLINK);
+	SAFE_MKNOD(FIFO, S_IFIFO | 0777, 0);
+	SAFE_MKNOD(CHR, S_IFCHR | 0777, dev);
+	SAFE_MKNOD(BLK, S_IFBLK | 0777, 0);
+	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_setxattr,
+	.tcnt = ARRAY_SIZE(tc),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
+
 #else /* HAVE_SYS_XATTR_H */
-int main(int argc, char *argv[])
-{
-	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
-}
+TST_TEST_TCONF("<sys/xattr.h> does not exist");
 #endif
-- 
2.13.5

