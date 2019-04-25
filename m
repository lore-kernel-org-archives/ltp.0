From: Christian Amann <camann@suse.com>
Date: Thu, 25 Apr 2019 10:52:04 +0200
Subject: [LTP] [PATCH v2] syscalls/rt_sigqueueinfo01: rewrote testcase
Message-ID: <20190425085204.11036-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The previous implementation only tested if the syscall can
be called at all. Now it also checks if the correct signal
and data is sent and received.

Signed-off-by: Christian Amann <camann@suse.com>
---
 testcases/kernel/syscalls/rt_sigqueueinfo/Makefile |   2 +
 .../syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h     |  22 +++
 .../syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c   | 188 +++++++++++----------
 3 files changed, 125 insertions(+), 87 deletions(-)
 create mode 100644 testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h

diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile b/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
index 2ef86f06f..498ba8e31 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
@@ -21,3 +21,5 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+rt_sigqueueinfo01: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h
new file mode 100644
index 000000000..927e4bf3b
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+
+#ifdef HAVE_STRUCT_SIGACTION_SA_SIGACTION
+
+#ifndef __RT_SIGQUEUEINFO_H__
+#define __RT_SIGQUEUEINFO_H__
+
+#define gettid() syscall(SYS_gettid)
+
+#include "lapi/syscalls.h"
+
+static int sys_rt_sigqueueinfo(pid_t tgid, int sig, siginfo_t *uinfo)
+{
+	return tst_syscall(__NR_rt_sigqueueinfo, tgid, sig, uinfo);
+}
+
+#endif /* __RT_SIGQUEUEINFO_H__ */
+#endif /* HAVE_STRUCT_SIGACTION_SA_SIGACTION */
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
index 9d0cff96d..afac9a034 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
@@ -1,102 +1,116 @@
-/******************************************************************************/
-/* Copyright (c) Crackerjack Project., 2007                                   */
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
-/* File:        rt_sigqueueinfo01.c                                           */
-/*                                                                            */
-/* Description: This tests the rt_sigqueueinfo() syscall.                     */
-/*		rt_sigqueueinfo() Send signal information to a signal	      */
-/*									      */
-/* Usage:  <for command-line>                                                 */
-/* rt_sigqueueinfo01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
-/*      where,  -c n : Run n copies concurrently.                             */
-/*              -e   : Turn on errno logging.                                 */
-/*              -i n : Execute test n times.                                  */
-/*              -I x : Execute test for x seconds.                            */
-/*              -P x : Pause for x seconds between iterations.                */
-/*              -t   : Turn on syscall timing.                                */
-/*                                                                            */
-/* Total Tests: 2                                                             */
-/*                                                                            */
-/* Test Name:   rt_sigqueueinfo01                                              */
-/* History:     Porting from Crackerjack to LTP is done by                    */
-/*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
-/******************************************************************************/
-#include <sys/wait.h>
-#include <stdio.h>
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+
+/*
+ * Description:
+ *
+ * This tests the rt_sigqueueinfo() syscall.
+ *
+ * It does so by creating a thread which registers the corresponding
+ * signal handler. After that the main thread sends a signal and data
+ * to the handler thread. If the correct signal and data is received,
+ * the test is successful.
+ *
+ */
+
 #include <signal.h>
-#include <err.h>
-#include <errno.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-#include <string.h>
+#include "config.h"
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "rt_sigqueueinfo.h"
+
+#ifdef HAVE_STRUCT_SIGACTION_SA_SIGACTION
+
+#define SIGNAL	SIGUSR1
+#define DATA	777
+
+static int thread_chckpnt, main_chckpnt;
+static struct sigaction *sig_action;
+static siginfo_t *uinfo;
+static pid_t tid;
+
+static void received_signal(int sig, siginfo_t *info, void *ucontext)
+{
+	if (!info || !ucontext)
+		tst_brk(TFAIL, "Signal handling went wrong!");
+	else if (sig == SIGNAL && info->si_value.sival_int == DATA)
+		tst_res(TPASS, "Received correct signal and data!");
+	else
+		tst_res(TFAIL, "Received wrong signal and/or data!");
+}
+
+static void *handle_thread(void *arg)
+{
+	int ret;
+
+	tid = gettid();
 
-#include "test.h"
-#include "lapi/syscalls.h"
+	ret = sigaction(SIGNAL, sig_action, NULL);
+	if (ret)
+		tst_brk(TBROK, "Failed to set sigaction for handler thread!");
 
-char *TCID = "rt_sigqueueinfo01";
-int testno;
-int TST_TOTAL = 2;
+	TST_CHECKPOINT_WAKE(main_chckpnt);
+	TST_CHECKPOINT_WAIT(thread_chckpnt);
+	return arg;
+}
 
-void cleanup(void)
+static void verify_sigqueueinfo(void)
 {
+	pthread_t thr;
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, handle_thread, NULL);
+
+	TST_CHECKPOINT_WAIT(main_chckpnt);
 
-	tst_rmdir();
+	TEST(sys_rt_sigqueueinfo(tid, SIGNAL, uinfo));
+	if (TST_RET != 0) {
+		tst_res(TFAIL, "rt_sigqueueinfo() failed with %s.",
+				tst_strerrno(TST_ERR));
+		return;
+	}
+
+	TST_CHECKPOINT_WAKE(thread_chckpnt);
+	SAFE_PTHREAD_JOIN(thr, NULL);
 
+	tst_res(TPASS, "rt_sigqueueinfo() was successful!");
 }
 
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;
-	tst_tmpdir();
+	sig_action = SAFE_MALLOC(sizeof(struct sigaction));
+
+	memset(sig_action, 0, sizeof(*sig_action));
+	sig_action->sa_sigaction = received_signal;
+	sig_action->sa_flags = SA_SIGINFO;
+
+	uinfo = SAFE_MALLOC(sizeof(siginfo_t));
+
+	memset(uinfo, 0, sizeof(*uinfo));
+	uinfo->si_code = SI_QUEUE;
+	uinfo->si_pid = getpid();
+	uinfo->si_uid = getuid();
+	uinfo->si_value.sival_int = DATA;
 }
 
-int main(void)
+static void cleanup(void)
 {
-	int status;
-	pid_t pid;
-	pid = getpid();
-	siginfo_t uinfo;
-
-	tst_count = 0;
-	for (testno = 0; testno < TST_TOTAL; ++testno) {
-		TEST(pid = fork());
-		setup();
-		if (TEST_RETURN < 0)
-			tst_brkm(TFAIL | TTERRNO, cleanup, "fork failed");
-		else if (TEST_RETURN == 0) {
-			uinfo.si_errno = 0;
-			uinfo.si_code = SI_QUEUE;
-			TEST(ltp_syscall(__NR_rt_sigqueueinfo, getpid(),
-				SIGCHLD, &uinfo));
-			if (TEST_RETURN != 0)
-				err(1, "rt_sigqueueinfo");
-			exit(0);
-		} else {
-			wait(&status);
-			if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
-				tst_resm(TPASS, "Test Succeeded");
-			else
-				tst_resm(TFAIL, "Test Failed");
-		}
-		cleanup();
-	}
-	tst_exit();
+	free(uinfo);
+	free(sig_action);
 }
+
+static struct tst_test test = {
+	.test_all = verify_sigqueueinfo,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_checkpoints = 1,
+	.timeout = 20,
+};
+
+#else
+	TST_TEST_TCONF(
+		"This system does not support rt_sigqueueinfo().");
+#endif /* HAVE_STRUCT_SIGACTION_SA_SIGACTION */
-- 
2.16.4

