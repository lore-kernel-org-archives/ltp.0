From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Jan 2018 13:42:04 +0100
Subject: [LTP] [PATCH] endian_switch01: rewrite to newlib
Message-ID: <0db42a518baa79cd6139f566482e2dab11cfb4bd.1515587913.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also check that syscall is supported (doesn't return ENOSYS),
before running actual test. This is to address kernels where
this syscall is disabled by default:
  commit 727f13616c45 ("powerpc: Disable the fast-endian switch syscall by default")

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/switch/endian_switch01.c | 267 ++++++++++-----------
 1 file changed, 125 insertions(+), 142 deletions(-)
 rewrite testcases/kernel/syscalls/switch/endian_switch01.c (96%)

diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
dissimilarity index 96%
index 86aed891009e..3e5ff47fc2a9 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -1,142 +1,125 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/* Copyright 2008 Paul Mackerras, IBM Corp.                                   */
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
-/* File:        endian_switch01.c                                                    */
-/*                                                                            */
-/* Description: Test little-endian mode switch system call. Requires a 64-bit */
-/*              processor that supports little-endian mode,such as POWER6.    */
-/*                                                                            */
-/* Total Tests: 1                                                             */
-/*                                                                            */
-/* Test Name:   endian_switch01                                                      */
-/*                                                                            */
-/* Author:      Paul Mackerras <paulus@samba.org>                             */
-/*                                                                            */
-/* History:     Created - Sep 02 2008 - Paul Mackerras <paulus@samba.org>     */
-/*              Ported to LTP                                                 */
-/*                      - Sep 02 2008                                         */
-/*                      - Subrata Modak <subrata@linux.vnet.ibm.com>          */
-/*                                                                            */
-/******************************************************************************/
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <elf.h>
-#include <signal.h>
-#include <setjmp.h>
-#include "test.h"
-#include <errno.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/syscall.h>
-#include <fcntl.h>
-#include <sys/utsname.h>
-#include <unistd.h>
-#include "lapi/syscalls.h"
-
-#if defined (__powerpc64__) || (__powerpc__)
-static void setup();
-#endif
-
-static void cleanup();
-
-char *TCID = "endian_switch01";
-int TST_TOTAL = 1;
-
-#if defined (__powerpc64__) || (__powerpc__)
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-}
-
-extern int main4(int ac, char **av, char **envp, unsigned long *auxv)
-__asm("main");
-#endif
-
-void cleanup(void)
-{
-
-}
-
-#if defined (__powerpc64__) || (__powerpc__)
-#ifndef PPC_FEATURE_TRUE_LE
-#define PPC_FEATURE_TRUE_LE              0x00000002
-#endif
-
-#include <asm/cputable.h>
-
-volatile int got_sigill;
-sigjmp_buf jb;
-
-void sigill(int sig)
-{
-	got_sigill = 1;
-	siglongjmp(jb, 1);
-}
-
-void do_le_switch(void)
-{
-	register int r0 asm("r0");
-
-	r0 = 0x1ebe;
-	asm volatile ("sc; .long 0x02000044":"=&r" (r0):"0"(r0)
-		      :"cr0", "r9", "r10", "r11", "r12");
-}
-
-int main4(int ac, char **av, char **envp, unsigned long *auxv)
-{
-
-	if ((tst_kvercmp(2, 6, 26)) < 0) {
-		tst_brkm(TCONF,
-			 NULL,
-			 "This test can only run on kernels that are 2.6.26 and higher");
-	}
-	setup();
-	for (; *auxv != AT_NULL && *auxv != AT_HWCAP; auxv += 2) ;
-	if (!(auxv[0] == AT_HWCAP && (auxv[1] & PPC_FEATURE_TRUE_LE))) {
-		tst_brkm(TCONF, cleanup,
-			 "Processor does not support little-endian mode");
-	}
-	signal(SIGILL, sigill);
-	if (sigsetjmp(jb, 1) == 0)
-		do_le_switch();
-	if (got_sigill) {
-		tst_brkm(TFAIL, NULL, "Got SIGILL - test failed");
-	}
-	tst_resm(TPASS, "endian_switch() syscall tests passed");
-	tst_exit();
-}
-
-#else
-
-int main(void)
-{
-
-	tst_brkm(TCONF, cleanup,
-		 "This system does not support running of switch() syscall");
-}
-
-#endif
+/*
+ * Copyright (c) International Business Machines Corp., 2008
+ * Copyright (c) Paul Mackerras, IBM Corp., 2008
+ * Copyright (c) 2018 Linux Test Project
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test little-endian mode switch system call. Requires a 64-bit
+ * processor that supports little-endian mode,such as POWER6.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <elf.h>
+#include "tst_test.h"
+
+#if defined (__powerpc64__) || (__powerpc__)
+# ifndef PPC_FEATURE_TRUE_LE
+# define PPC_FEATURE_TRUE_LE              0x00000002
+# endif
+
+# define TST_NO_DEFAULT_MAIN
+
+/*
+ * Make minimal call to 0x1ebe. If we get ENOSYS then syscall is not
+ * available, likely because of:
+ *   commit 727f13616c45 ("powerpc: Disable the fast-endian switch syscall by default")
+ * If we get any other outcome, including crashes with various signals,
+ * then we assume syscall is available and carry on with the test.
+ */
+void check_le_switch_supported(void)
+{
+	int status;
+
+	if (SAFE_FORK() == 0) {
+		syscall(0x1ebe);
+		exit(errno);
+	}
+
+	SAFE_WAIT(&status);
+	if (WIFSIGNALED(status)) {
+		int sig = WTERMSIG(status);
+
+		tst_res(TINFO, "check exited with sig %d", sig);
+	} else if (WIFEXITED(status)) {
+		int rc = WEXITSTATUS(status);
+
+		tst_res(TINFO, "check exited with %d", rc);
+		if (rc == ENOSYS)
+			tst_brk(TCONF, "fast endian switch (0x1ebe) N/A");
+	}
+}
+
+void test_le_switch(void)
+{
+	int status;
+
+	if (SAFE_FORK() == 0) {
+		register int r0 asm("r0") = 0x1ebe;
+
+		asm volatile ("sc; .long 0x02000044"
+				: "=&r" (r0)
+				: "0"(r0)
+				: "cr0", "r9", "r10", "r11", "r12");
+		exit(0);
+	}
+
+	SAFE_WAIT(&status);
+	if (WIFSIGNALED(status)) {
+		int sig = WTERMSIG(status);
+
+		tst_res(TFAIL, "test exited with sig %d", sig);
+	} else if (WIFEXITED(status)) {
+		int rc = WEXITSTATUS(status);
+
+		if (rc != 0)
+			tst_res(TFAIL, "test exited with %d", rc);
+		else
+			tst_res(TPASS, "endian_switch() syscall tests passed");
+	}
+}
+
+static void endian_test(void)
+{
+	check_le_switch_supported();
+	test_le_switch();
+}
+
+static struct tst_test test = {
+	.test_all = endian_test,
+	.min_kver = "2.6.26",
+	.forks_child = 1,
+};
+
+int main4(int argc, char **argv, LTP_ATTRIBUTE_UNUSED char **envp,
+	unsigned long *auxv)
+{
+	for (; *auxv != AT_NULL && *auxv != AT_HWCAP; auxv += 2)
+		;
+
+	if (!(auxv[0] == AT_HWCAP && (auxv[1] & PPC_FEATURE_TRUE_LE)))
+		tst_brk(TCONF, "Processor does not support little-endian mode");
+
+	tst_run_tcases(argc, argv, &test);
+	return 0;
+}
+
+#else /* defined (__powerpc64__) || (__powerpc__) */
+TST_TEST_TCONF("This system does not support running of switch() syscall");
+#endif
-- 
1.8.3.1

