From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 29 Apr 2021 19:50:20 +0800
Subject: [LTP] [PATCH 2/3] syscalls/io_setup: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <20210429115021.24128-1-xieziyao@huawei.com>
References: <20210429115021.24128-1-xieziyao@huawei.com>
Message-ID: <20210429115021.24128-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of using the libaio wrapper function, the system call is changed to be invoked via syscall(2).

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/io_setup/io_setup01.c     | 94 +++++--------------
 1 file changed, 26 insertions(+), 68 deletions(-)

diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index 28aee7831..6927aeafc 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -1,92 +1,50 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) Crackerjack Project., 2007
- *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
- *   Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
+ * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
  */

-/* Porting from Crackerjack to LTP is done
- * by Masatake YAMATO <yamato@redhat.com>
+/*\
+ * [Description]
  *
- * Description:
- * 1) io_setup(2) succeeds if both nr_events and ctxp are valid.
- * 2) io_setup(2) fails and returns -EINVAL if ctxp is not initialized to 0.
- * 3) io_setup(2) fails and returns -EINVAL if nr_events is invalid.
- * 4) io_setup(2) fails and returns -EFAULT if ctxp is NULL.
- * 5) io_setup(2) fails and returns -EAGAIN if nr_events exceeds the limit
- *    of available events.
+ * - io_setup(2) fails and returns -EFAULT if ctxp is NULL;
+ * - io_setup(2) fails and returns -EINVAL if ctxp is not initialized to 0;
+ * - io_setup(2) fails and returns -EINVAL if nr_events is -1;
+ * - io_setup(2) fails and returns -EAGAIN if nr_events exceeds the limit
+ *   of available events;
+ * - io_setup(2) succeeds if both nr_events and ctxp are valid;
  */

-#include <errno.h>
-#include <string.h>
-#include <unistd.h>
+#include <linux/aio_abi.h>
+
 #include "config.h"
 #include "tst_test.h"
-
-#ifdef HAVE_LIBAIO
-#include <libaio.h>
-
-static void verify_failure(unsigned int nr, io_context_t *ctx, int init_val, long exp_err)
-{
-	if (ctx)
-		memset(ctx, init_val, sizeof(*ctx));
-
-	TEST(io_setup(nr, ctx));
-	if (TST_RET == 0) {
-		tst_res(TFAIL, "io_setup() passed unexpectedly");
-		io_destroy(*ctx);
-		return;
-	}
-
-	if (TST_RET == -exp_err) {
-		tst_res(TPASS, "io_setup() failed as expected, returned -%s",
-			tst_strerrno(exp_err));
-	} else {
-		tst_res(TFAIL, "io_setup() failed unexpectedly, returned -%s "
-			"expected -%s", tst_strerrno(-TST_RET),
-			tst_strerrno(exp_err));
-	}
-}
-
-static void verify_success(unsigned int nr, io_context_t *ctx, int init_val)
-{
-	memset(ctx, init_val, sizeof(*ctx));
-
-	TEST(io_setup(nr, ctx));
-	if (TST_RET == -ENOSYS)
-		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
-	if (TST_RET != 0) {
-		tst_res(TFAIL, "io_setup() failed unexpectedly with %li (%s)",
-			TST_RET, tst_strerrno(-TST_RET));
-		return;
-	}
-
-	tst_res(TPASS, "io_setup() passed as expected");
-	io_destroy(*ctx);
-}
+#include "lapi/syscalls.h"

 static void verify_io_setup(void)
 {
-	io_context_t ctx;
-	unsigned int aio_max = 0;
+	aio_context_t ctx;
+	TST_EXP_FAIL(tst_syscall(__NR_io_setup, 1, NULL), EFAULT);

-	verify_success(1, &ctx, 0);
-	verify_failure(1, &ctx, 1, EINVAL);
-	verify_failure(-1, &ctx, 0, EINVAL);
-	verify_failure(1, NULL, 0, EFAULT);
+	memset(&ctx, 1, sizeof(ctx));
+	TST_EXP_FAIL(tst_syscall(__NR_io_setup, 1, &ctx), EINVAL);
+	memset(&ctx, 0, sizeof(ctx));
+	TST_EXP_FAIL(tst_syscall(__NR_io_setup, -1, &ctx), EINVAL);

+	unsigned aio_max = 0;
 	if (!access("/proc/sys/fs/aio-max-nr", F_OK)) {
 		SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%u", &aio_max);
-		verify_failure(aio_max + 1, &ctx, 0, EAGAIN);
+		TST_EXP_FAIL(tst_syscall(__NR_io_setup, aio_max + 1, &ctx), EAGAIN);
 	} else {
 		tst_res(TCONF, "the aio-max-nr file did not exist");
 	}
+
+	TST_EXP_PASS(tst_syscall(__NR_io_setup, 1, &ctx));
+	TST_EXP_PASS(tst_syscall(__NR_io_destroy, ctx));
 }

 static struct tst_test test = {
 	.test_all = verify_io_setup,
 };
-
-#else
-	TST_TEST_TCONF("test requires libaio and it's development packages");
-#endif
--
2.17.1

