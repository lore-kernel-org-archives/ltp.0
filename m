From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 9 Aug 2018 00:01:09 +0800
Subject: [LTP] [PATCH] syscalls/fsetxattr02.c: Fix the failure of opening
	device files
Message-ID: <1533744069-24715-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If temporary directory(TMPDIR/TEMPDIR) is on the mountpoint which
is mounted with nodev option or temporary directory is mounted with
with nodev option directly(e.g. tmpfs is mounted on /tmp), open(2)
has no permission to open device files in the temporary directory
and returned EACCES.  as below:
--------------------------------------------------------------------
safe_macros.c:225: BROK: fsetxattr02.c:215: open(fsetxattr02chr,0,00) failed: EACCES
--------------------------------------------------------------------

We try to fix this issue by creating device files in /dev/ instead.

This is the same issue reported by open11, please see the mail:
http://lists.linux.it/pipermail/ltp/2018-July/008641.html

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index a1be652..356e527 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -52,11 +52,13 @@
 #define FILENAME "fsetxattr02testfile"
 #define DIRNAME  "fsetxattr02testdir"
 #define SYMLINK  "fsetxattr02symlink"
-#define FIFO     "fsetxattr02fifo"
-#define CHR      "fsetxattr02chr"
-#define BLK      "fsetxattr02blk"
+#define FIFO     "/dev/fsetxattr02fifo"
+#define CHR      "/dev/fsetxattr02chr"
+#define BLK      "/dev/fsetxattr02blk"
 #define SOCK     "fsetxattr02sock"
 
+static char *dev_files[3] = {FIFO, CHR, BLK};
+
 struct test_case {
 	char *fname;
 	int fd;
@@ -240,6 +242,11 @@ static void cleanup(void)
 		if (tc[i].fd > 0)
 			SAFE_CLOSE(tc[i].fd);
 	}
+
+	for (i = 0; i < ARRAY_SIZE(dev_files); i++) {
+		if (!access(dev_files[i], F_OK))
+			SAFE_UNLINK(dev_files[i]);
+	}
 }
 
 static struct tst_test test = {
-- 
1.8.3.1



