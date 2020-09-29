From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 29 Sep 2020 15:46:35 +0100
Subject: [LTP] [PATCH] utimensat01: Test all available FS and handle FS with
 no attributes
Message-ID: <20200929144635.28874-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If tmpdir is mounted on tmpfs then the test will fail with ENOTTY as
this FS apparently does not support file attributes (inode
flags). Instead we can test with all the available filesystems, some
of which may support file attributes.

Also if we now get ENOTTY then it is assumed the file system does not
support attributes (or at least the attribute we want to test) and the
test fails with TCONF. However the underlying FS could return some
other errno, but it is not clear what else to expect, if anything.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/syscalls/utimensat/utimensat01.c      | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index fe490f441..5410c345a 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -21,8 +21,9 @@
 #include "time64_variants.h"
 #include "tst_timer.h"
 
-#define TEST_FILE	"test_file"
-#define TEST_DIR	"test_dir"
+#define MNTPOINT 	"mntpoint"
+#define TEST_FILE	MNTPOINT"/test_file"
+#define TEST_DIR	MNTPOINT"/test_dir"
 
 static void *bad_addr;
 
@@ -182,7 +183,12 @@ static void change_attr(struct test_case *tc, int fd, int set)
 	if (!tc->attr)
 		return;
 
-	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
+	if (ioctl(fd, FS_IOC_GETFLAGS, &attr)) {
+		if (errno == ENOTTY)
+			tst_brk(TCONF | TERRNO, "Attributes not supported by FS");
+		else
+			tst_brk(TBROK | TERRNO, "ioctl(fd, FS_IOC_GETFLAGS, &attr) failed");
+	}
 
 	if (set)
 		attr |= tc->attr;
@@ -305,5 +311,7 @@ static struct tst_test test = {
 	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
 };
-- 
2.28.0

