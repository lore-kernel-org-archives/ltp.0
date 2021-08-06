From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:27 +0300
Subject: [LTP] [PATCH v2 13/16] syscalls/sched_setscheduler02: convert to
 new API
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-14-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_setscheduler/sched_setscheduler02.c | 165 +++++-------------
 1 file changed, 44 insertions(+), 121 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
index 36952d9cb..ddebdac94 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
@@ -1,148 +1,71 @@
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
+ * Copyright (c) 2021, BELLSOFT. All rights reserved.
+ * Copyright (c) International Business Machines  Corp., 2001
  */
 
-/*
- * NAME
- *	sched_setscheduler01.c
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	Testcase to test whether sched_setscheduler(2) sets the errnos
- *	correctly.
+ * Testcase to test whether sched_setscheduler(2) sets the errnos
+ * correctly.
  *
- * ALGORITHM
- *	1.	Call sched_setscheduler as a non-root uid, and expect EPERM
- *	to be returned.
+ * [Algorithm]
  *
- * USAGE:  <for command-line>
- *  sched_setscheduler02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Call sched_setscheduler as a non-root uid, and expect EPERM
+ * to be returned.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	Must run test as root.
  */
-#include <stdio.h>
+
+#include <stdlib.h>
 #include <errno.h>
-#include <sched.h>
 #include <pwd.h>
 #include <sys/types.h>
-#include <sys/wait.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
+#include "tst_sched.h"
 
 #define SCHED_INVALID	99
 #define INVALID_PID	999999
 
-char *TCID = "sched_setscheduler02";
-int TST_TOTAL = 1;
-
-void setup(void);
-void cleanup(void);
-
 static uid_t nobody_uid;
 
-int main(int ac, char **av)
-{
-	int lc;
-	pid_t pid;
-	struct sched_param param;
-	int status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		if ((pid = FORK_OR_VFORK()) == -1) {
-			tst_brkm(TBROK, cleanup, "fork failed");
-		}
-
-		if (pid == 0) {	/* child */
-			param.sched_priority = 1;
-
-			SAFE_SETEUID(cleanup, nobody_uid);
+static struct sched_variants variants[] = {
+	{ .sched_setscheduler = libc_sched_setscheduler, .desc = "libc" },
+	{ .sched_setscheduler = sys_sched_setscheduler, .desc = "syscall" },
+};
 
-			TEST(sched_setscheduler(pid, SCHED_FIFO, &param));
-
-			if (TEST_ERRNO) {
-			}
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "sched_setscheduler(2) passed "
-					 "with non root priveledges");
-			} else if (TEST_ERRNO != EPERM) {
-				tst_resm(TFAIL, "Expected EPERM, got %d",
-					 TEST_ERRNO);
-			} else {
-				tst_resm(TPASS, "got EPERM");
-			}
-		} else {	/* parent */
-			/* let the child carry on */
-			wait(&status);
-			if (WIFEXITED(status) != 0) {	/* Exit with errors */
-				exit(WEXITSTATUS(status));
-			} else {
-				exit(0);
-			}
-		}
-
-		SAFE_SETEUID(cleanup, 0);
-	}
-	cleanup();
-	tst_exit();
-
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void setup(void)
 {
-	struct passwd *pw;
+	struct passwd *pw = SAFE_GETPWNAM("nobody");
 
-	tst_require_root();
+	tst_res(TINFO, "Testing %s variant", variants[tst_variant].desc);
 
-	pw = SAFE_GETPWNAM(NULL, "nobody");
 	nobody_uid = pw->pw_uid;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
+static void run(void)
 {
-
+	struct sched_variants *tv = &variants[tst_variant];
+	pid_t pid = SAFE_FORK();
+
+	if (!pid) {
+		struct sched_param p = { .sched_priority = 1 };
+
+		SAFE_SETEUID(nobody_uid);
+		TST_EXP_FAIL(tv->sched_setscheduler(0, SCHED_FIFO, &p), EPERM,
+			     "sched_setscheduler(0, SCHED_FIFO, %d)",
+			     p.sched_priority);
+		SAFE_SETEUID(0);
+		exit(0);
+	}
+	tst_reap_children();
 }
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.needs_root = 1,
+	.setup = setup,
+	.test_variants = ARRAY_SIZE(variants),
+	.test_all = run,
+};
-- 
2.25.1

