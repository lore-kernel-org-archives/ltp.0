From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 29 Apr 2021 19:50:19 +0800
Subject: [LTP] [PATCH 1/3] syscalls/io_destroy: Convert libaio wrapper
 function to kernel syscall
In-Reply-To: <20210429115021.24128-1-xieziyao@huawei.com>
References: <20210429115021.24128-1-xieziyao@huawei.com>
Message-ID: <20210429115021.24128-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of using the libaio wrapper function, the system call is changed to be invoked via syscall(2).

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/io_destroy/io_destroy01.c | 49 +++++--------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index bb89f61f5..6f14bb8e6 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -1,55 +1,30 @@
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
- * io_destroy(2) fails and returns -EINVAL if ctx is invalid.
+ * Call io_destroy with an invalid ctx and expects it to return EINVAL.
  */

-#include <errno.h>
-#include <string.h>
+#include <linux/aio_abi.h>
+
 #include "config.h"
 #include "tst_test.h"
-
-#ifdef HAVE_LIBAIO
-#include <libaio.h>
+#include "lapi/syscalls.h"

 static void verify_io_destroy(void)
 {
-	io_context_t ctx;
-
+	aio_context_t ctx;
 	memset(&ctx, 0xff, sizeof(ctx));
-	TEST(io_destroy(ctx));
-
-	if (TST_RET == 0) {
-		tst_res(TFAIL, "io_destroy() succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_RET == -ENOSYS) {
-		tst_res(TCONF, "io_destroy() not supported");
-		return;
-	}
-
-	if (TST_RET == -EINVAL) {
-		tst_res(TPASS, "io_destroy() failed as expected, returned -EINVAL");
-		return;
-	}
-
-	tst_res(TFAIL, "io_destroy() failed unexpectedly, returned -%s expected -EINVAL",
-		tst_strerrno(-TST_RET));
+	TST_EXP_FAIL(tst_syscall(__NR_io_destroy, ctx), EINVAL);
 }

 static struct tst_test test = {
 	.test_all = verify_io_destroy,
 };
-
-#else
-	TST_TEST_TCONF("test requires libaio and it's development packages");
-#endif
--
2.17.1

