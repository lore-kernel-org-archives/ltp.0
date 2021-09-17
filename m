From: QI Fuli <fukuri.sai@gmail.com>
Date: Fri, 17 Sep 2021 19:19:06 +0900
Subject: [LTP] [PATCH v2 1/2] syscalls/dup3_01: Rewrite and convert to new
 API
In-Reply-To: <20210917101907.2657-1-qi.fuli@fujitsu.com>
References: <20210917101907.2657-1-qi.fuli@fujitsu.com>
Message-ID: <20210917101907.2657-2-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

    - divide into two testcases
    - convert to new API

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/dup3/dup3_01.c | 159 +++++++----------------
 1 file changed, 47 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index 6a44ec809..3b3d9ae0d 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -1,120 +1,55 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) Ulrich Drepper <drepper@redhat.com>                          */
-/* Copyright (c) International Business Machines  Corp., 2009                 */
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
-/* File:        dup3_01.c                                                     */
-/*                                                                            */
-/* Description: This Program tests the new system call introduced in 2.6.27.  */
-/*              Ulrich??s comment as in:                                       */
-/* http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=336dd1f70ff62d7dd8655228caed4c5bfc818c56 */
-/*              says:                                                         */
-/* This patch adds the new dup3 syscall.  It extends the old dup2 syscall by  */
-/* one parameter which is meant to hold a flag value.  Support for the        */
-/* O_CLOEXEC flag is added in this patch. The following test must be adjusted */
-/* for architectures other than x86 and x86-64 and in case the                */
-/* syscall numbers changed.                                                   */
-/*                                                                            */
-/* Usage:  <for command-line>                                                 */
-/* dup3_01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                               */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   dup3_01                                                       */
-/*                                                                            */
-/* Author:      Ulrich Drepper <drepper@redhat.com>                           */
-/*                                                                            */
-/* History:     Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>   */
-/*              Ported to LTP                                                 */
-/*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
-/******************************************************************************/
-#include <fcntl.h>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Ulrich Drepper <drepper@redhat.com>
+ * Copyright (c) International Business Machines  Corp., 2009
+ * Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>
+ * Ported to LTP - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>
+ */
+/*\
+ * [Description]
+ * Testcase to check whether dup3() supports O_CLOEXEC flag.
+ */
+
+#define _GNU_SOURCE
+
 #include <stdio.h>
-#include <time.h>
-#include <unistd.h>
-#include <sys/syscall.h>
+#include <stdbool.h>
 #include <errno.h>
-
-#include "test.h"
-#include "lapi/fcntl.h"
-#include "lapi/syscalls.h"
-
-char *TCID = "dup3_01";
-int TST_TOTAL = 1;
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
-
-void setup(void)
-{
-	TEST_PAUSE;
-	tst_tmpdir();
-}
-
-int main(int argc, char *argv[])
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+
+static struct tcase {
+	int o_flag;
+	bool coe_flag;
+	char *desc;
+} tcases [] = {
+	{0, true, "dup3(1, 4, 0)"},
+	{O_CLOEXEC, false, "dup3(1, 4, O_CLOEXEC)"},
+};
+
+static void run(unsigned int i)
 {
-	int fd, coe;
+	int fd, ret;
+	struct tcase *tc = tcases + i;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	TEST(dup3(1, 4, tc->o_flag));
 
-	if ((tst_kvercmp(2, 6, 27)) < 0)
-		tst_brkm(TCONF, NULL,
-			 "This test can only run on kernels that are 2.6.27 and higher");
-	setup();
-
-	fd = ltp_syscall(__NR_dup3, 1, 4, 0);
-	if (fd == -1) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(0) failed");
-	}
-	coe = fcntl(fd, F_GETFD);
-	if (coe == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
+	fd = TST_RET;
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "%s failed", tc->desc);
+		return;
 	}
-	if (coe & FD_CLOEXEC) {
-		tst_brkm(TFAIL, cleanup, "dup3(0) set close-on-exec flag");
-	}
-	close(fd);
 
-	fd = ltp_syscall(__NR_dup3, 1, 4, O_CLOEXEC);
-	if (fd == -1) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "dup3(O_CLOEXEC) failed");
-	}
-	coe = fcntl(fd, F_GETFD);
-	if (coe == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "fcntl failed");
-	}
-	if ((coe & FD_CLOEXEC) == 0) {
-		tst_brkm(TFAIL, cleanup,
-			 "dup3(O_CLOEXEC) set close-on-exec flag");
-	}
-	close(fd);
-	tst_resm(TPASS, "dup3(O_CLOEXEC) PASSED");
+	ret = SAFE_FCNTL(fd, F_GETFD);
+	if ((ret & FD_CLOEXEC) == tc->coe_flag)
+		tst_res(TFAIL, "%s set close-on-exec flag", tc->desc);
+	else
+		tst_res(TPASS, "%s PASSED", tc->desc);
+
+	SAFE_CLOSE(fd);
+};
 
-	cleanup();
-	tst_exit();
-}
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+};
-- 
2.31.1

