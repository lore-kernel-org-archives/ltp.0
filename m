From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 30 Sep 2020 12:40:58 +0100
Subject: [LTP] [PATCH v3] utimensat01: Use FS (default ext2) with timestamps
 and attributes
Message-ID: <20200930114058.5860-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If tmpdir is mounted on tmpfs then the test will fail with ENOTTY as
this FS apparently does not support file attributes (inode
flags). Instead we can test on the default FS which is ext2, but may
be changed by the user.

We can not set all_filesystems because utimensat will fail to reset
the timestamp to zero on at least exFAT and NTFS (FUSE and kernel
versions). It is not clear yet what the expected behavior is or how
the test could fail gracefully and requires investigation.

Also if we now get ENOTTY then it is assumed the file system does not
support attributes and the test fails with TCONF. However the
underlying FS could return some other errno (e.g. EINVAL on FUSE
NTFS), but it is not clear what to expect, if anything and also
requires further investigation.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V3: Use default FS

 .../kernel/syscalls/utimensat/utimensat01.c   | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index fe490f441..ac267e7d9 100644
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
@@ -198,7 +204,11 @@ static void reset_time(char *pathname, int dfd, int flags, int i)
 	struct stat sb;
 
 	memset(&ts, 0, sizeof(ts));
-	tv->utimensat(dfd, pathname, &ts, flags);
+	TEST(tv->utimensat(dfd, pathname, &ts, flags));
+	if (TST_RET) {
+		tst_res(TINFO | TTERRNO, "%2d: utimensat(%d, %s, {0, 0}, %d) failed",
+			i, dfd, pathname, flags);
+	}
 
 	TEST(stat(pathname, &sb));
 	if (TST_RET) {
@@ -305,5 +315,6 @@ static struct tst_test test = {
 	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.needs_root = 1,
-	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
 };
-- 
2.28.0

