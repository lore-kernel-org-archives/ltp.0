From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  3 Jun 2020 13:54:23 +0200
Subject: [LTP] [PATCH] syscalls/mknod07: whiteout creation no longer
 requires privileges
Message-ID: <588f29555a93919a5ea47e5cf786eca6a08f85f1.1591185180.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit a3c751a50fe6 ("vfs: allow unprivileged whiteout creation"),
privileges are no longer required to create whiteout (0,0) char device.

Use /dev/null instead for EPERM test.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/mknod/mknod07.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index 69cff02d95d1..829199061532 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -43,6 +43,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mount.h>
+#include <sys/sysmacros.h>
 
 #include "test.h"
 #include "safe_macros.h"
@@ -69,13 +70,14 @@ static struct test_case_t {
 	char *pathname;
 	int mode;
 	int exp_errno;
+	int major, minor;
 } test_cases[] = {
-	{ "testdir_1/tnode_1", SOCKET_MODE, EACCES },
-	{ "testdir_1/tnode_2", FIFO_MODE, EACCES },
-	{ "tnode_3", CHR_MODE, EPERM },
-	{ "tnode_4", BLK_MODE, EPERM },
-	{ "mntpoint/tnode_5", SOCKET_MODE, EROFS },
-	{ elooppathname, FIFO_MODE, ELOOP },
+	{ "testdir_1/tnode_1", SOCKET_MODE, EACCES, 0, 0 },
+	{ "testdir_1/tnode_2", FIFO_MODE, EACCES, 0, 0 },
+	{ "tnode_3", CHR_MODE, EPERM, 1, 3 },
+	{ "tnode_4", BLK_MODE, EPERM, 0, 0 },
+	{ "mntpoint/tnode_5", SOCKET_MODE, EROFS, 0, 0 },
+	{ elooppathname, FIFO_MODE, ELOOP, 0, 0 },
 };
 
 char *TCID = "mknod07";
@@ -149,7 +151,8 @@ static void setup(void)
 
 static void mknod_verify(const struct test_case_t *test_case)
 {
-	TEST(mknod(test_case->pathname, test_case->mode, 0));
+	TEST(mknod(test_case->pathname, test_case->mode,
+		makedev(test_case->major, test_case->minor)));
 
 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL, "mknod succeeded unexpectedly");
-- 
2.18.1

