From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri,  6 Aug 2021 19:47:30 +0300
Subject: [LTP] [PATCH v2 16/16] syscalls/sched_getscheduler02: convert to
 new API
In-Reply-To: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
References: <20210806164730.51040-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210806164730.51040-17-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_getscheduler/sched_getscheduler02.c | 109 ++++--------------
 1 file changed, 24 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
index c43240108..effd18adb 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
@@ -1,106 +1,45 @@
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
- *	sched_getscheduler02.C
- *
- * DESCRIPTION
- *	To check for the errno ESRCH
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	Pass an invalid pid to sched_getscheduler() and test for ESRCH.
- *
- * USAGE:  <for command-line>
- *  sched_getscheduler02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
- *
- * RESTRICTION
- *	None
+ * Pass an invalid pid to sched_getscheduler() and test for ESRCH.
  */
 
 #include <stdio.h>
-#include <sched.h>
 #include <errno.h>
-#include "test.h"
 
-char *TCID = "sched_getscheduler02";
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "tst_sched.h"
 
 static pid_t unused_pid;
 
-void setup(void);
-void cleanup(void);
+static struct sched_variants variants[] = {
+	{ .sched_getscheduler = libc_sched_getscheduler, .desc = "libc" },
+	{ .sched_getscheduler = sys_sched_getscheduler, .desc = "syscall" },
+};
 
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		TEST(sched_getscheduler(unused_pid));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "sched_getscheduler(2) passed "
-				 "unexpectedly");
-			continue;
-		}
-
-		if (errno != ESRCH) {
-			tst_resm(TFAIL, "Expected ESRCH, got %d", errno);
-		} else {
-			tst_resm(TPASS, "call failed with ESRCH");
-		}
-	}
-	cleanup();
-	tst_exit();
+	tst_res(TINFO, "Testing %s variant", variants[tst_variant].desc);
 
+	unused_pid = tst_get_unused_pid();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
-	unused_pid = tst_get_unused_pid(cleanup);
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct sched_variants *tv = &variants[tst_variant];
 
-	TEST_PAUSE;
+	TST_EXP_FAIL(tv->sched_getscheduler(unused_pid), ESRCH,
+		     "sched_getscheduler(%d)", unused_pid);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *	       completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_variants = ARRAY_SIZE(variants),
+	.test_all = run,
+};
-- 
2.25.1

