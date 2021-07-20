From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:20 +0300
Subject: [LTP] [PATCH 12/16] syscalls/sched_setscheduler01: convert to new
 API
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-13-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_setscheduler/sched_setscheduler01.c | 171 +++++-------------
 1 file changed, 42 insertions(+), 129 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
index 1cbce15d0..2feaa60d5 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
@@ -1,160 +1,73 @@
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
- *
- * DESCRIPTION
- *	Testcase to test whether sched_setscheduler(2) sets the errnos
- *	correctly.
+/*\
+ * [Description]
  *
- * ALGORITHM
- *	1.	Call sched_setscheduler with an invalid pid, and expect
- *	ESRCH to be returned.
- *	2.	Call sched_setscheduler with an invalid scheduling policy,
- *	and expect EINVAL to be returned.
- *	3.	Call sched_setscheduler with an invalid "param" address,
- *	which lies outside the address space of the process, and expect
- *	EFAULT to be returned.
- *	4.	Call sched_setscheduler with an invalid priority value
- *	in "param" and expect EINVAL to be returned
+ * Testcase to test whether sched_setscheduler(2) sets the errnos
+ * correctly.
  *
- * USAGE:  <for command-line>
- *  sched_setscheduler01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * [Algorithm]
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS
- *	None
+ * 1. Call sched_setscheduler with an invalid pid, and expect
+ * ESRCH to be returned.
+ * 2. Call sched_setscheduler with an invalid scheduling policy,
+ * and expect EINVAL to be returned.
+ * 3. Call sched_setscheduler with an invalid "param" address,
+ * which lies outside the address space of the process, and expect
+ * EFAULT to be returned.
+ * 4.Call sched_setscheduler with an invalid priority value
+ * in "param" and expect EINVAL to be returned
  */
+
 #include <stdio.h>
 #include <errno.h>
-#include <sched.h>
 #include <pwd.h>
-#include "test.h"
 
-#define SCHED_INVALID	99
-
-char *TCID = "sched_setscheduler01";
+#include "tst_test.h"
+#include "tst_sched.h"
 
-struct sched_param param;
-struct sched_param param1 = { 1 };
-
-void setup(void);
-void cleanup(void);
+#define SCHED_INVALID	99
 
+static struct sched_param p;
+static struct sched_param p1 = { .sched_priority = 1 };
 static pid_t unused_pid;
 static pid_t init_pid = 1;
 static pid_t zero_pid;
 
-struct test_case_t {
+struct test_cases_t {
 	pid_t *pid;
 	int policy;
 	struct sched_param *p;
 	int error;
-} TC[] = {
+} tcases[] = {
 	/* The pid is invalid - ESRCH */
-	{
-	&unused_pid, SCHED_OTHER, &param, ESRCH},
-	    /* The policy is invalid - EINVAL */
-	{
-	&init_pid, SCHED_INVALID, &param, EINVAL},
-#ifndef UCLINUX
-	    /* Skip since uClinux does not implement memory protection */
-	    /* The param address is invalid - EFAULT */
-	{
-	&init_pid, SCHED_OTHER, (struct sched_param *)-1, EFAULT},
-#endif
-	    /* The priority value in param invalid - EINVAL */
-	{
-	&zero_pid, SCHED_OTHER, &param1, EINVAL}
+	{&unused_pid, SCHED_OTHER, &p, ESRCH},
+	/* The policy is invalid - EINVAL */
+	{&init_pid, SCHED_INVALID, &p, EINVAL},
+	/* The param address is invalid - EFAULT */
+	{&init_pid, SCHED_OTHER, (struct sched_param *)-1, EFAULT},
+	/* The priority value in param invalid - EINVAL */
+	{&zero_pid, SCHED_OTHER, &p1, EINVAL}
 };
 
-int TST_TOTAL = ARRAY_SIZE(TC);
-
-int main(int ac, char **av)
+static void setup(void)
 {
-	int lc;
-
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		setup();
-
-		/* loop through the test cases */
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			TEST(sched_setscheduler(*(TC[i].pid), TC[i].policy,
-						TC[i].p));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - "
-					 "errno = %d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "unexpected error - %d : %s - "
-					 "expected %d", TEST_ERRNO,
-					 strerror(TEST_ERRNO), TC[i].error);
-			}
-		}
-	}
-	cleanup();
-
-	tst_exit();
-
+	unused_pid = tst_get_unused_pid();
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(unsigned int n)
 {
-	unused_pid = tst_get_unused_pid(cleanup);
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	struct test_cases_t *tc = &tcases[n];
 
-	TEST_PAUSE;
+	TST_EXP_FAIL(tst_sched_setscheduler(*tc->pid, tc->policy, tc->p), tc->error);
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
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
-- 
2.25.1

