From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Mon,  8 Oct 2018 12:46:20 -0300
Subject: [LTP] [PATCH] syscalls/fsetxattr02.c: Fix missing ramdisk module
	error
In-Reply-To: <CABdQkv-px744Mc-RVH=Tpa+TPqhs3tYn-D8=JgzBdjmwMtpDVA@mail.gmail.com>
References: <CABdQkv-px744Mc-RVH=Tpa+TPqhs3tYn-D8=JgzBdjmwMtpDVA@mail.gmail.com>
Message-ID: <20181008154620.25237-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test depends on CONFIG_BLK_DEV_RAM kernel config option. If not,
then errors like:

safe_macros.c:225: BROK: fsetxattr02.c:214:
open(mntpoint/fsetxattr02blk,0,00) failed: ENXIO safe_macros.c:225:
BROK: fgetxattr02.c:244: open(fgetxattr02blk,0,00) failed: ENXIO

might happen. By using recent "needs_drivers" option we are able to
mitigate this.

Link: https://bugs.linaro.org/show_bug.cgi?id=4011
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index b0d4a84fb..89279c384 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -58,6 +58,8 @@
 #define BLK      MNTPOINT"/fsetxattr02blk"
 #define SOCK     "fsetxattr02sock"
 
+#define DRVRAMDISK "brd"
+
 struct test_case {
 	char *fname;
 	int fd;
@@ -241,6 +243,11 @@ static void cleanup(void)
 	}
 }
 
+static const char *const needed_drivers[] = {
+	DRVRAMDISK,
+	NULL,
+};
+
 static struct tst_test test = {
 	.setup = setup,
 	.test = verify_fsetxattr,
@@ -249,6 +256,7 @@ static struct tst_test test = {
 	.needs_devfs = 1,
 	.mntpoint = MNTPOINT,
 	.needs_root = 1,
+	.needs_drivers = needed_drivers,
 };
 
 #else /* HAVE_SYS_XATTR_H */
-- 
2.19.0.rc2

