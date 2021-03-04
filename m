From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Date: Thu, 4 Mar 2021 10:13:04 +0800
Subject: [LTP] [PATCH 2/2] syscalls/getppid02: Convert to the new API
In-Reply-To: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
References: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
Message-ID: <20210304021304.1126635-2-ruansy.fnst@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The logic is same as syscalls/getpid02, which is to check whether
parent's pid equals child's ppid.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/getppid/getppid02.c | 122 ++++--------------
 1 file changed, 27 insertions(+), 95 deletions(-)

diff --git a/testcases/kernel/syscalls/getppid/getppid02.c b/testcases/kernel/syscalls/getppid/getppid02.c
index ae3c8eb26..d0bf984dd 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -1,106 +1,38 @@
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
  */
 
-/*
- * NAME
- * 	getppid02.c
- *
- * DESCRIPTION
- * 	Testcase to check the basic functionality of the getppid() syscall.
- *
- * USAGE:  <for command-line>
- *  getppid02 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+/*\
+ * [DESCRIPTION]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- * 	None
- */
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <err.h>
-#include <errno.h>
-#include "test.h"
-#include "safe_macros.h"
+ * Check that getppid() in child returns the same pid as getpid() in parent.
+\*/
 
-char *TCID = "getppid02";
-int TST_TOTAL = 1;
+#include <errno.h>
 
-void setup(void);
-void cleanup(void);
+#include "tst_test.h"
 
-int main(int ac, char **av)
+static void verify_getppid(void)
 {
-
-	int lc;
-	int status;
-	pid_t pid, ppid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		ppid = getpid();
-		pid = FORK_OR_VFORK();
-		if (pid == -1)
-			tst_brkm(TBROK, cleanup, "fork failed");
-
-		if (pid == 0) {
-			TEST(getppid());
-
-			if (TEST_RETURN != ppid)
-				errx(1, "getppid failed (%ld != %d)",
-				     TEST_RETURN, ppid);
-			else
-				printf("return value and parent's pid "
-				       "value match\n");
-			exit(0);
-		} else {
-			SAFE_WAIT(cleanup, &status);
-			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-				tst_resm(TFAIL,
-					 "getppid functionality incorrect");
-		}
+	pid_t proc_id;
+	pid_t pid;
+	pid_t pproc_id;
+
+	proc_id = getpid();
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		pproc_id = getppid();
+
+		if (pproc_id != proc_id)
+			tst_res(TFAIL, "child's ppid(%d) not equal to parent's pid(%d)",
+				pproc_id, proc_id);
+		else
+			tst_res(TPASS, "getppid() functionality is correct");
 	}
-	cleanup();
-
-	tst_exit();
 }
 
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.forks_child = 1,
+	.test_all = verify_getppid,
+};
-- 
2.30.1



