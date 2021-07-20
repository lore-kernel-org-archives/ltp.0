From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 20 Jul 2021 16:33:23 +0300
Subject: [LTP] [PATCH 15/16] syscalls/sched_getscheduler01: convert to new
 API
In-Reply-To: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
References: <20210720133324.21752-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210720133324.21752-16-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 .../sched_getscheduler/sched_getscheduler01.c | 141 +++++-------------
 1 file changed, 37 insertions(+), 104 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
index f6bdf1a1b..e0da0510d 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler01.c
@@ -1,129 +1,62 @@
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
- *	sched_getscheduler01.C
+/*\
+ * [Description]
  *
- * DESCRIPTION
- *	Testcase to check sched_getscheduler() returns correct return value
+ * Testcase to check sched_getscheduler() returns correct return value.
  *
- * ALGORTIHM
- *	Call sched_setcheduler() to set the scheduling policy of the current
- *	process. Then call sched_getscheduler() to ensure that this is same
- *	as what set by the previous call to sched_setscheduler().
+ * [Algorithm]
  *
- *	Use SCHED_RR, SCHED_FIFO, SCHED_OTHER as the scheduling policies for
- *	sched_setscheduler().
+ * Call sched_setcheduler() to set the scheduling policy of the current
+ * process. Then call sched_getscheduler() to ensure that this is same
+ * as what set by the previous call to sched_setscheduler().
  *
- * USAGE:  <for command-line>
- *  sched_getscheduler01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * Use SCHED_RR, SCHED_FIFO, SCHED_OTHER as the scheduling policies for
+ * sched_setscheduler().
  *
- * RESTRICTION
- *	Must run test as root.
  */
 
 #include <errno.h>
-#include <sched.h>
 #include <stdio.h>
-#include "test.h"
-
-char *TCID = "sched_getscheduler01";
-int TST_TOTAL = 3;
 
-void setup(void);
-void cleanup(void);
+#include "tst_test.h"
+#include "tst_sched.h"
 
-struct test_case_t {
-	int prio;
+struct test_cases_t {
+	int priority;
 	int policy;
-} TC[] = {
-	/* set scheduling policy to SCHED_RR */
-	{
-	1, SCHED_RR},
-	    /* set scheduling policy to SCHED_OTHER */
-	{
-	0, SCHED_OTHER},
-	    /* set scheduling policy to SCHED_FIFO */
-	{
-	1, SCHED_FIFO}
+} tcases[] = {
+	{1, SCHED_RR},
+	{0, SCHED_OTHER},
+	{1, SCHED_FIFO}
 };
 
-int main(int ac, char **av)
+static void run(unsigned int n)
 {
-	int lc;
-	int i;
-	struct sched_param param;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
+	struct test_cases_t *tc = &tcases[n];
+	struct sched_param p = { .sched_priority = tc->priority };
 
-			param.sched_priority = TC[i].prio;
+	TST_EXP_PASS_SILENT(tst_sched_setscheduler(0, tc->policy, &p));
 
-			if (sched_setscheduler(0, TC[i].policy, &param) == -1)
-				tst_brkm(TBROK, cleanup,
-					 "sched_setscheduler failed");
+	TEST(tst_sched_getscheduler(0));
 
-			TEST(sched_getscheduler(0));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "call failed unexpectedly");
-				continue;
-			}
-
-			if (TEST_RETURN != TC[i].policy)
-				tst_resm(TFAIL,
-					 "policy value returned is not "
-					 "correct");
-			else
-				tst_resm(TPASS,
-					 "policy value returned is correct");
-		}
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "sched_getscheduler() failed unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (TST_RET == tc->policy)
+		tst_res(TPASS, "got expected policy %d", tc->policy);
+	else
+		tst_res(TFAIL, "got policy %ld, expected %d", TST_RET, tc->policy);
 }
 
-void setup(void)
-{
-
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
-- 
2.25.1

