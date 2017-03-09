From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Mar 2017 16:13:03 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/6] syscalls/clock_nanosleep2_01: Rewrite.
Message-ID: <20170309151308.17512-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test only calls clock_nanosleep2_01 with absolute timeout. There is
absolutely no reason to do that 50 times with 1s sleep time as the
original test had to be interrupted by gdb in order to trigger the
problem.

So this commit changes the sleep time to 0.1s which saves 50 seconds on
syscall testrun and also converts the test to the new test library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../clock_nanosleep2/clock_nanosleep2_01.c         | 165 ++++++---------------
 1 file changed, 42 insertions(+), 123 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
index 04fe7a1..968a77d 100644
--- a/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep2/clock_nanosleep2_01.c
@@ -1,143 +1,62 @@
-/******************************************************************************/
-/* Copyright (c) M. Koehrer <mathias_koehrer@arcor.de>, 2009                  */
-/*                                                                            */
-/* LKML Reference: http://lkml.org/lkml/2009/4/9/89                           */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-/******************************************************************************/
-/*                                                                            */
-/* File:        clock_nanosleep2_01.c                                         */
-/*                                                                            */
-/* Description: This tests the clock_nanosleep2-out() syscall                 */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* clock_nanosleep2_01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                   */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   clock_nanosleep2_01                                           */
-/******************************************************************************/
-#define _GNU_SOURCE
+/******************************************************************************
+ * Copyright (c) M. Koehrer <mathias_koehrer@arcor.de>, 2009                  *
+ * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>                          *
+ *                                                                            *
+ * This program is free software;  you can redistribute it and/or modify      *
+ * it under the terms of the GNU General Public License as published by       *
+ * the Free Software Foundation; either version 2 of the License, or          *
+ * (at your option) any later version.                                        *
+ *                                                                            *
+ * This program is distributed in the hope that it will be useful,            *
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
+ * the GNU General Public License for more details.                           *
+ *                                                                            *
+ * You should have received a copy of the GNU General Public License          *
+ * along with this program;  if not, write to the Free Software Foundation,   *
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
+ *                                                                            *
+ ******************************************************************************/
+/*
+ * This tests the clock_nanosleep2() syscall.
+ */
 #include <stdio.h>
 #include <time.h>
 #include <unistd.h>
 #include <sys/syscall.h>
-#include <linux/unistd.h>
 
-#include "test.h"
+#include "tst_test.h"
 #include "linux_syscall_numbers.h"
 
-char *TCID = "clock_nanosleep2_01";
-int testno;
-int TST_TOTAL = 1;
-
-/* Extern Global Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    cleanup                                                       */
-/*                                                                            */
-/* Description: Performs all one time clean up for this test on successful    */
-/*              completion,  premature exit or  failure. Closes all temporary */
-/*              files, removes all temporary directories exits the test with  */
-/*              appropriate return code by calling tst_exit() function.       */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits calling tst_exit(). Non '0' return code.   */
-/*              On success - Exits calling tst_exit(). With '0' return code.  */
-/*                                                                            */
-/******************************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-	tst_exit();
-}
-
-/* Local  Functions */
-/******************************************************************************/
-/*                                                                            */
-/* Function:    setup                                                         */
-/*                                                                            */
-/* Description: Performs all one time setup for this test. This function is   */
-/*              typically used to capture signals, create temporary dirs      */
-/*              and temporary files that may be used in the course of this    */
-/*              test.                                                         */
-/*                                                                            */
-/* Input:       None.                                                         */
-/*                                                                            */
-/* Output:      None.                                                         */
-/*                                                                            */
-/* Return:      On failure - Exits by calling cleanup().                      */
-/*              On success - returns 0.                                       */
-/*                                                                            */
-/******************************************************************************/
-void setup(void)
-{
-	/* Capture signals if any */
-	/* Create temporary directories */
-	TEST_PAUSE;
-	tst_tmpdir();
-}
+#define NSEC_IN_SEC 1000000000
 
 const clockid_t CLOCK_TO_USE = CLOCK_MONOTONIC;
 static int clock_nanosleep2(clockid_t clock_id, int flags,
 			    const struct timespec *req, struct timespec *rem)
 {
-	return ltp_syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
+	return tst_syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
 }
 
-int main(int ac, char **av)
+static void verify_clock_nanosleep2(void)
 {
-	int i;
-	int lc;
 	struct timespec ts;
 
-	tst_parse_opts(ac, av, NULL, NULL);
+	clock_gettime(CLOCK_TO_USE, &ts);
+	ts.tv_nsec += NSEC_IN_SEC/10;
+	if (ts.tv_nsec >= NSEC_IN_SEC) {
+		ts.tv_sec += 1;
+		ts.tv_nsec %= NSEC_IN_SEC;
+	}
 
-	setup();
+	TEST(clock_nanosleep2(CLOCK_TO_USE, TIMER_ABSTIME, &ts, NULL));
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(clock_gettime(CLOCK_TO_USE, &ts));
-			for (i = 0; i <= 50; i++) {
-				ts.tv_sec++;
-				TEST(clock_nanosleep2
-				     (CLOCK_TO_USE, TIMER_ABSTIME, &ts, NULL));
-				if (TEST_ERRNO) {
-					tst_brkm(TFAIL,
-						 cleanup, "%s failed - errno = %d : %s",
-						 TCID, TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-				}
-				tst_resm(TINFO, "Iteration = %i", i);
-			}
-			tst_resm(TPASS, "clock_nanosleep2() passed");
-		}
-	}
-	tst_exit();
+	if (TEST_RETURN)
+		tst_res(TFAIL | TTERRNO, "clock_nanosleep2() failed");
+	else
+		tst_res(TPASS, "clock_nanosleep2() passed");
 }
+
+static struct tst_test test = {
+	.tid = "clock_nanosleep2_01",
+	.test_all = verify_clock_nanosleep2,
+};
-- 
2.10.2

