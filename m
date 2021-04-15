From: Zenghui Gao <gaozh.jy@fujitsu.com>
Date: Thu, 15 Apr 2021 10:05:51 -0400
Subject: [LTP] [PATCH 1/2] syscalls/wait01.c: Convert to new API
Message-ID: <20210415140552.15762-1-gaozh.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Take use of macros and clean up.

Signed-off-by: Zenghui Gao <gaozh.jy@fujitsu.com>
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 testcases/kernel/syscalls/wait/wait01.c | 82 ++++---------------------
 1 file changed, 13 insertions(+), 69 deletions(-)

diff --git a/testcases/kernel/syscalls/wait/wait01.c b/testcases/kernel/syscalls/wait/wait01.c
index bd22c1191..3af95cf9b 100644
--- a/testcases/kernel/syscalls/wait/wait01.c
+++ b/testcases/kernel/syscalls/wait/wait01.c
@@ -1,81 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
-/*
- * Test Description:
- *  Verify that,
- *	The calling process does not have any unwaited-for children,
- *	ECHILD would return.
+/*\
+ * [Description]
+ *
+ * The calling process does not have any unwaited-for children,
+ * ECHILD would return.
  */
 
 #include <errno.h>
-#include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/types.h>
+#include "tst_test.h"
 
-#include "test.h"
-
-char *TCID = "wait01";
-int TST_TOTAL = 1;
-static void setup(void);
-static void wait_verify(void);
-static void cleanup(void);
-
-int main(int argc, char **argv)
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		wait_verify();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void wait_verify(void)
+static void verify_wait(void)
 {
-	TEST(wait(NULL));
-
-	if (TEST_RETURN != -1) {
-		tst_resm(TFAIL | TTERRNO, "wait failed unexpectedly: %ld",
-			TEST_RETURN);
-		return;
-	}
-
-	if (TEST_ERRNO == ECHILD) {
-		tst_resm(TPASS | TTERRNO, "wait failed as expected");
-	} else {
-		tst_resm(TFAIL | TTERRNO,
-			 "wait failed unexpectedly; expected: %d - %s",
-			 ECHILD, strerror(ECHILD));
-	}
+	TST_EXP_FAIL(wait(NULL), ECHILD);
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_wait,
+};
-- 
2.18.1



