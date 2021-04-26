From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 26 Apr 2021 20:52:23 +0800
Subject: [LTP] [PATCH 2/3 v2] syscalls/close: Convert close02 to the new API
In-Reply-To: <20210426125224.150268-1-xieziyao@huawei.com>
References: <20210426125224.150268-1-xieziyao@huawei.com>
Message-ID: <20210426125224.150268-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cleanup and convert close02 to the new API.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
Cleanup with TST_EXP_FAIL() and remove setup() function.

 testcases/kernel/syscalls/close/close02.c | 122 +++-------------------
 1 file changed, 15 insertions(+), 107 deletions(-)

diff --git a/testcases/kernel/syscalls/close/close02.c b/testcases/kernel/syscalls/close/close02.c
index ddda5d9ec..50ca8006f 100644
--- a/testcases/kernel/syscalls/close/close02.c
+++ b/testcases/kernel/syscalls/close/close02.c
@@ -1,121 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 Ported by Wayne Boyer
  */

-/*
- * NAME
- * 	close02.c
- *
- * DESCRIPTION
- * 	Check that an invalid file descriptor returns EBADF
- *
- * ALGORITHM
- *	loop if that option is specified
- * 	   call close using the TEST macro and passing in an invalid fd
- *	   if the call succeedes
- *	      issue a FAIL message
- *	   else
- *	      log the errno
- *	      if the errno == EBADF
- *	         issue a PASS message
- *	      else
- *	         issue a FAIL message
- *	cleanup
- *
- * USAGE:  <for command-line>
- *  close02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+/*\
+ * [Description]
+ *
+ * Basic test for the close() syscall.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * [Algorithm]
  *
- * RESTRICTIONS
- * 	None
+ * Call close(-1) and expects it to return EBADF.
  */

 #include <stdio.h>
 #include <errno.h>
 #include <sys/stat.h>
-#include "test.h"
+#include "tst_test.h"

-void cleanup(void);
-void setup(void);
-
-char *TCID = "close02";
-int TST_TOTAL = 1;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/* The following loop checks looping state if -i option given */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		TEST(close(-1));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "Closed a non existent fildes");
-		} else {
-			if (TEST_ERRNO != EBADF) {
-				tst_resm(TFAIL, "close() FAILED to set errno "
-					 "to EBADF on an invalid fd, got %d",
-					 errno);
-			} else {
-				tst_resm(TPASS, "call returned EBADF");
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-
+	TST_EXP_FAIL(close(-1), EBADF);
 }

-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	umask(0);
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.test_all = run,
+};
--
2.17.1

