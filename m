From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 17:42:07 +0800
Subject: [LTP] [PATCH 4/7] io_getevents01: Add .needs_kconfigs and more
 detailed description
In-Reply-To: <20210618094210.183027-1-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
Message-ID: <20210618094210.183027-5-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add .needs_kconfigs and more detailed description to distinguish it from
io_getevents02.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/io_getevents/io_getevents01.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/io_getevents/io_getevents01.c b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
index ad85cdaa5..9dba4addf 100644
--- a/testcases/kernel/syscalls/io_getevents/io_getevents01.c
+++ b/testcases/kernel/syscalls/io_getevents/io_getevents01.c
@@ -8,7 +8,8 @@
 /*\
  * [Description]
  *
- * Calls io_getevents() when ctx is invalid and expects it to return EINVAL.
+ * Test io_getevents invoked via syscall(2) with invalid ctx and expects it to
+ * return EINVAL.
  */

 #include <linux/aio_abi.h>
@@ -20,10 +21,15 @@
 static void run(void)
 {
 	aio_context_t ctx;
+
 	memset(&ctx, 0, sizeof(ctx));
 	TST_EXP_FAIL(tst_syscall(__NR_io_getevents, ctx, 0, 0, NULL, NULL), EINVAL);
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

