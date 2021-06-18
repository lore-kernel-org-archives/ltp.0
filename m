From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 17:42:05 +0800
Subject: [LTP] [PATCH 2/7] io_cancel01: Add .needs_kconfigs and more
 detailed description
In-Reply-To: <20210618094210.183027-1-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
Message-ID: <20210618094210.183027-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add .needs_kconfigs and more detailed description to distinguish it from io_cancel02.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/io_cancel/io_cancel01.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel01.c b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
index 11f789b78..8bd65bd4a 100644
--- a/testcases/kernel/syscalls/io_cancel/io_cancel01.c
+++ b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
@@ -8,8 +8,8 @@
 /*\
  * [Description]
  *
- * Calls io_cancel() with one of the data structures points to invalid data and
- * expects it to return EFAULT.
+ * Test io_cancel invoked via syscall(2) with one of the data structures
+ * points to invalid data and expects it to return EFAULT.
  */

 #include <linux/aio_abi.h>
@@ -21,10 +21,15 @@
 static void run(void)
 {
 	aio_context_t ctx;
+
 	memset(&ctx, 0, sizeof(ctx));
 	TST_EXP_FAIL(tst_syscall(__NR_io_cancel, ctx, NULL, NULL), EFAULT);
 }

 static struct tst_test test = {
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AIO=y",
+		NULL
+	},
 	.test_all = run,
 };
--
2.17.1

