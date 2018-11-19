From: Greg Hackmann <ghackmann@google.com>
Date: Mon, 19 Nov 2018 13:15:27 -0800
Subject: [LTP] [PATCH] syscalls/fgetxattr02.c: make sure test can create and
 open device nodes
Message-ID: <20181119211528.85893-1-ghackmann@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fgetxattr02 needs to create and open device nodes, so make sure it has
access to a filesystem mounted without nodev.  This is based on a
previous commmit e02373767 ("syscalls/fsetxattr02.c: Fix the failure of
opening device files") which fixed a similar issue in fsetxattr02.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 .../kernel/syscalls/fgetxattr/fgetxattr02.c   | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
index 888e29a23..02e81810a 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
@@ -54,14 +54,15 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 
+#define MNTPOINT "mntpoint"
 #define OFFSET    11
 #define FILENAME "fgetxattr02testfile"
 #define DIRNAME  "fgetxattr02testdir"
 #define SYMLINK  "fgetxattr02symlink"
 #define SYMLINKF "fgetxattr02symlinkfile"
-#define FIFO     "fgetxattr02fifo"
-#define CHR      "fgetxattr02chr"
-#define BLK      "fgetxattr02blk"
+#define FIFO     MNTPOINT"/fgetxattr02fifo"
+#define CHR      MNTPOINT"/fgetxattr02chr"
+#define BLK      MNTPOINT"/fgetxattr02blk"
 #define SOCK     "fgetxattr02sock"
 
 struct test_case {
@@ -159,6 +160,8 @@ static struct test_case tc[] = {
 
 static void verify_fgetxattr(unsigned int i)
 {
+	const char *fname = strstr(tc[i].fname, "fgetxattr02") + OFFSET;
+
 	TEST(fgetxattr(tc[i].fd, tc[i].key, tc[i].ret_value, tc[i].size));
 
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
@@ -168,11 +171,11 @@ static void verify_fgetxattr(unsigned int i)
 
 		if (tc[i].exp_ret == TST_RET) {
 			tst_res(TPASS, "fgetxattr(2) on %s passed",
-					tc[i].fname + OFFSET);
+					fname);
 		} else {
 			tst_res(TFAIL,
 				"fgetxattr(2) on %s passed unexpectedly %ld",
-				tc[i].fname + OFFSET, TST_RET);
+				fname, TST_RET);
 		}
 
 		if (strncmp(tc[i].ret_value, XATTR_TEST_VALUE,
@@ -182,7 +185,7 @@ static void verify_fgetxattr(unsigned int i)
 		}
 
 		tst_res(TPASS, "fgetxattr(2) on %s got the right value",
-				tc[i].fname + OFFSET);
+				fname);
 	}
 
 	/*
@@ -195,12 +198,11 @@ static void verify_fgetxattr(unsigned int i)
 
 	if (tc[i].exp_err == TST_ERR) {
 		tst_res(TPASS | TTERRNO, "fgetxattr(2) on %s passed",
-				tc[i].fname + OFFSET);
+				fname);
 		return;
 	}
 
-	tst_res(TFAIL | TTERRNO, "fgetxattr(2) failed on %s",
-			tc[i].fname + OFFSET);
+	tst_res(TFAIL | TTERRNO, "fgetxattr(2) failed on %s", fname);
 }
 
 static void setup(void)
@@ -268,7 +270,8 @@ static struct tst_test test = {
 	.test = verify_fgetxattr,
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tc),
-	.needs_tmpdir = 1,
+	.needs_devfs = 1,
+	.mntpoint = MNTPOINT,
 	.needs_root = 1,
 };
 
-- 
2.19.1.1215.g8438c0b245-goog

