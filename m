From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 2 Aug 2019 18:34:41 +0800
Subject: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before test
Message-ID: <1564742081-2234-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

stx_attributes_mask shows what's supported in stx_attributes.
we should check four attrbutes whether supports on tested filesystem
and report the non-supported attributes  before test.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx04.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 71de734f5..e4b198c07 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -138,23 +138,37 @@ static void caid_flags_setup(void)
 	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
 
 	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP)
-			tst_brk(TCONF, "Flags not supported");
+	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
-	}
 
 	clear_flags = 1;
 }
 
 static void setup(void)
 {
+	struct statx buf;
+
 	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
 	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
 
 	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
 		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
 
+	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO,
+			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
+
+	/* Mask to show which attributes are supported on filesystem. */
+	if ((buf.stx_attributes_mask & FS_COMPR_FL) == 0)
+		tst_brk(TCONF, "filesystem doesn't support FS_COMPR_FL");
+	if ((buf.stx_attributes_mask & FS_APPEND_FL) == 0)
+		tst_brk(TCONF, "filesystem doesn't support FS_APPEND_FL");
+	if ((buf.stx_attributes_mask & FS_IMMUTABLE_FL) == 0)
+		tst_brk(TCONF, "filesystem doesn't support FS_IMMUTABLE_FL");
+	if ((buf.stx_attributes_mask & FS_NODUMP_FL) == 0)
+		tst_brk(TCONF, "filesystem doesn't support FS_NODUMP_FL");
+
 	caid_flags_setup();
 }
 
-- 
2.18.1



