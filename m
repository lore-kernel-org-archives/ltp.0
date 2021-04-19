From: Zenghui Gao <gaozh.jy@fujitsu.com>
Date: Mon, 19 Apr 2021 05:44:31 -0400
Subject: [LTP] [PATCH v2] syscalls/wait02.c: Convert to new API
Message-ID: <20210419094431.2418-1-gaozh.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Take use of macros and clean up.

Signed-off-by: Zenghui Gao <gaozh.jy@fujitsu.com>
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 testcases/kernel/syscalls/wait/wait02.c | 112 +++++++-----------------
 1 file changed, 30 insertions(+), 82 deletions(-)

diff --git a/testcases/kernel/syscalls/wait/wait02.c b/testcases/kernel/syscalls/wait/wait02.c
index 5695c071c..0217099ca 100644
--- a/testcases/kernel/syscalls/wait/wait02.c
+++ b/testcases/kernel/syscalls/wait/wait02.c
@@ -1,103 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *    AUTHOR		: William Roske
  *    CO-PILOT		: Dave Fenner
+ */
+/*\
+ * [Description]
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- *
+ * For a terminated child, test whether wait(2) can get its pid
+ * and exit status correctly.
  */
 
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "wait02";
-int TST_TOTAL = 1;
-
-static void wait_verify(void);
+#include <stdlib.h>
+#include "tst_test.h"
 
-int main(int ac, char **av)
+static void verify_wait(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	int status, exit_child = 1;
+	pid_t fpid;
 
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
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	fpid = SAFE_FORK();
+	if (fpid == 0)
+		exit(exit_child);
 
-	TEST_PAUSE;
-}
+	TST_EXP_PID_SILENT(wait(&status));
 
-static void wait_verify(void)
-{
-	int fork_pid, status, exit_child = 1;
+	if (!TST_PASS)
+		return;
 
-	fork_pid = FORK_OR_VFORK();
-	if (fork_pid == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "fork() Failure");
-	} else if (fork_pid == 0) {
-		sleep(1);
-		exit(exit_child);
+	if (fpid != TST_RET) {
+		tst_res(TFAIL, "wait(&status) returned wrong pid %ld, expected %d",
+			TST_RET, fpid);
+		return;
 	}
 
-	TEST(wait(&status));
-
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "wait(1) Failed");
-	} else if (WIFEXITED(status) && WEXITSTATUS(status) == exit_child) {
-		tst_resm(TPASS, "wait(&status) returned %ld", TEST_RETURN);
-	} else {
-		tst_resm(TFAIL,
-			 "wait(1) Failed, exit_child - 0x%x, status - 0x%x",
-			 exit_child, status);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == exit_child) {
+		tst_res(TPASS, "wait(&status) succeeded");
+		return;
 	}
-}
 
-static void cleanup(void)
-{
+	tst_res(TFAIL, "wait(&status) got wrong exit status 0x%x", status);
 }
+
+static struct tst_test test = {
+	.test_all = verify_wait,
+	.forks_child = 1,
+};
-- 
2.18.1



