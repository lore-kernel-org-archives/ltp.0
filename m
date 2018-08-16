From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 16 Aug 2018 16:45:47 +0800
Subject: [LTP] [PATCH v2 4/4] syscalls/fsetxattr02.c: Fix the failure of
	opening device files
In-Reply-To: <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180815114220.GA26923@rei>
 <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1534409147-29519-4-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If temporary directory is on the mountpoint which is mounted with nodev
option(or it is mounted with with nodev option directly), open(2) has no
permission to open device files in the temporary directory and returns
EACCES.  as below:
--------------------------------------------------------------------
safe_macros.c:225: BROK: fsetxattr02.c:215: open(fsetxattr02chr,0,00) failed: EACCES
--------------------------------------------------------------------

We prepare a suitable filesystem to test device special files by setting
.needs_devfs flag.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index a1be652..0f769ce 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -48,13 +48,14 @@
 #define XATTR_TEST_VALUE "this is a test value"
 #define XATTR_TEST_VALUE_SIZE 20
 
+#define MNTPOINT "mntpoint"
 #define OFFSET    11
 #define FILENAME "fsetxattr02testfile"
 #define DIRNAME  "fsetxattr02testdir"
 #define SYMLINK  "fsetxattr02symlink"
-#define FIFO     "fsetxattr02fifo"
-#define CHR      "fsetxattr02chr"
-#define BLK      "fsetxattr02blk"
+#define FIFO     MNTPOINT"/fsetxattr02fifo"
+#define CHR      MNTPOINT"/fsetxattr02chr"
+#define BLK      MNTPOINT"/fsetxattr02blk"
 #define SOCK     "fsetxattr02sock"
 
 struct test_case {
@@ -139,6 +140,9 @@ static struct test_case tc[] = {
 
 static void verify_fsetxattr(unsigned int i)
 {
+	/* acquire basename to avoid breaking OFFSET logic */
+	tc[i].fname = strstr(tc[i].fname, "fsetxattr02");
+
 	/* some tests might require existing keys for each iteration */
 	if (tc[i].needskeyset) {
 		SAFE_FSETXATTR(tc[i].fd, tc[i].key, tc[i].value, tc[i].size,
@@ -247,7 +251,8 @@ static struct tst_test test = {
 	.test = verify_fsetxattr,
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tc),
-	.needs_tmpdir = 1,
+	.needs_devfs = 1,
+	.mntpoint = MNTPOINT,
 	.needs_root = 1,
 };
 
-- 
1.8.3.1



