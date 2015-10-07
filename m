From: Cedric Hnyda <chnyda@suse.com>
Date: Wed,  7 Oct 2015 16:03:18 +0200
Subject: [LTP]  [PATCH v2] syscall/renameat2: Fix filesystem
Message-ID: <1444226598-15717-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The flag RENAME_EXCHANGE for the syscall renameat2 is not supported
on BTRFS filesystem. The filesystem type is now tested if the
syscall returns EINVAL.

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 testcases/kernel/syscalls/renameat2/renameat201.c | 13 ++++++++++++-
 testcases/kernel/syscalls/renameat2/renameat202.c | 12 +++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
index 18db090..614e287 100644
--- a/testcases/kernel/syscalls/renameat2/renameat201.c
+++ b/testcases/kernel/syscalls/renameat2/renameat201.c
@@ -36,6 +36,7 @@
 #define _GNU_SOURCE
 
 #include "test.h"
+#include "tst_fs_type.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 #include "renameat2.h"
@@ -52,7 +53,7 @@ char *TCID = "renameat201";
 
 static int olddirfd;
 static int newdirfd;
-
+static long fs_type;
 
 static struct test_case {
 	int *olddirfd;
@@ -108,6 +109,8 @@ static void setup(void)
 
 	tst_tmpdir();
 
+	fs_type = tst_fs_type(cleanup, ".");
+
 	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
 	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
 
@@ -136,6 +139,14 @@ static void renameat2_verify(const struct test_case *test)
 	TEST(renameat2(*(test->olddirfd), test->oldpath,
 			*(test->newdirfd), test->newpath, test->flags));
 
+	if ((test->flags & RENAME_EXCHANGE) && EINVAL == TEST_ERRNO
+		&& fs_type == TST_BTRFS_MAGIC) {
+		tst_resm(TCONF,
+			"RENAME_EXCHANGE flag is not implemeted on %s",
+			tst_fs_type_name(fs_type));
+		return;
+	}
+
 	if (test->exp_errno && TEST_RETURN != -1) {
 		tst_resm(TFAIL, "renameat2() succeeded unexpectedly");
 		return;
diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index e695e85..0b0a3be 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -25,6 +25,7 @@
 #define _GNU_SOURCE
 
 #include "test.h"
+#include "tst_fs_type.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
 #include "renameat2.h"
@@ -43,6 +44,7 @@ static int fd = -1;
 static int cnt;
 
 static const char content[] = "content";
+static long fs_type;
 
 
 int TST_TOTAL = 1;
@@ -85,6 +87,8 @@ static void setup(void)
 
 	tst_tmpdir();
 
+	fs_type = tst_fs_type(cleanup, ".");
+
 	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
 	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
 
@@ -120,8 +124,14 @@ static void renameat2_verify(void)
 	char *emptyfile;
 	char *contentfile;
 
+	if (TEST_ERRNO == EINVAL && TST_BTRFS_MAGIC == fs_type) {
+		tst_brkm(TCONF, cleanup,
+			"RENAME_EXCHANGE flag is not implemeted on %s",
+			tst_fs_type_name(fs_type));
+	}
+
 	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL, "renameat2() failed unexpectedly");
+		tst_resm(TFAIL | TTERRNO, "renameat2() failed unexpectedly");
 		return;
 	}
 
-- 
2.1.4

