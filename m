From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 27 Apr 2021 19:28:50 +0800
Subject: [LTP] [PATCH] syscalls/io_cancel: Convert io_cancel01 to the new API
Message-ID: <20210427112850.240192-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Cleanup and convert io_cancel01 to the new API;
2. Instead of using the libaio wrapper function, the system call is
changed to be invoked via syscall(2).

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/io_cancel/io_cancel01.c   | 123 +++---------------
 1 file changed, 21 insertions(+), 102 deletions(-)

diff --git a/testcases/kernel/syscalls/io_cancel/io_cancel01.c b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
index ed6af050b..d7ef90018 100644
--- a/testcases/kernel/syscalls/io_cancel/io_cancel01.c
+++ b/testcases/kernel/syscalls/io_cancel/io_cancel01.c
@@ -1,115 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
+ * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * [Description]
  *
- *   Copyright (c) Crackerjack Project., 2007
- *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * Basic tests for the io_cancel syscall.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * [Algorithm]
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Calls io_cancel with one of the data structures points to invalid data
+ * and expects it to return EFAULT.
  */

-/* Porting from Crackerjack to LTP is done
-   by Masatake YAMATO <yamato@redhat.com> */
-
-#include <errno.h>
-#include <string.h>
+#include <linux/aio_abi.h>

 #include "config.h"
-#include "test.h"
-
-char *TCID = "io_cancel01";
-
-int TST_TOTAL = 1;
-
-#ifdef HAVE_LIBAIO
-#include <libaio.h>
-
-static void cleanup(void)
-{
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
-   DESCRIPTION
-   io_cancel attempts to cancel an asynchronous I/O operation  previously
-   submitted  with  the io_submit system call.  ctx_id is the AIO context
-   ID of the operation to be cancelled.  If the AIO context is found, the
-   event  will be cancelled and then copied into the memory pointed to by
-   result without being placed into the completion queue.
+#include "tst_test.h"
+#include "lapi/syscalls.h"

-   RETURN VALUE
-   io_cancel returns 0 on success; otherwise, it returns one of  the  er-
-   rors listed in the "Errors" section.
-
-   ERRORS
-   EINVAL The AIO context specified by ctx_id is invalid.
-
-   EFAULT One of the data structures points to invalid data.
- */
-
-#define EXP_RET (-EFAULT)
-
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-
-	io_context_t ctx;
-
+	aio_context_t ctx;
 	memset(&ctx, 0, sizeof(ctx));
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(io_cancel(ctx, NULL, NULL));
-
-		switch (TEST_RETURN) {
-		case 0:
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			break;
-		case EXP_RET:
-			tst_resm(TPASS, "expected failure - "
-				 "returned value = %ld : %s", TEST_RETURN,
-				 strerror(-TEST_RETURN));
-			break;
-		case -ENOSYS:
-			tst_resm(TCONF, "io_cancel returned ENOSYS");
-			break;
-		default:
-			tst_resm(TFAIL, "unexpected returned value - %s (%i) - "
-				 "expected %s (%i)", strerror(-TEST_RETURN),
-				 (int)TEST_RETURN, strerror(-EXP_RET), EXP_RET);
-			break;
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_FAIL(tst_syscall(__NR_io_cancel, ctx, NULL, NULL), EFAULT);
 }

-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test requires libaio and it's development packages");
-}
-#endif
+static struct tst_test test = {
+	.test_all = run,
+};
--
2.17.1

