From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed,  6 Mar 2019 16:15:49 +0530
Subject: [LTP] [PATCH v3] syscalls: add rt_tgsigqueueinfo() test-case
Message-ID: <1551869149-7306-1-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This tests the rt_tgsigqueueinfo() syscall used to queue a signal and
data to the single thread specified by the combination of tgid, a thread
group ID, and tid, a thread in that thread group.

Also this test implement 3 cases differing on the basis of signal sender:
- Sender and receiver is the same thread.
- Sender is parent of the thread.
- Sender is different thread.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
1. Remove usage of non asyn-safe function in signal handler.
2. Use checkpoint library for synchronization.
3. Fix possible race condition.
4. Miscellaneous fixes.

Changes in v2:
1. Add following cases where the sender differs:
  - parent -> thread
  - thread1 -> thread2
2. Add verification of signal and data delivered by rt_tgsigqueueinfo().

 runtest/syscalls                                   |   1 +
 .../kernel/syscalls/rt_tgsigqueueinfo/.gitignore   |   1 +
 .../kernel/syscalls/rt_tgsigqueueinfo/Makefile     |  10 ++
 .../rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c        | 180 +++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore
 create mode 100644 testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile
 create mode 100644 testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 78a1f78..f6c2f1b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -999,6 +999,7 @@ rt_sigprocmask01 rt_sigprocmask01
 rt_sigprocmask02 rt_sigprocmask02
 rt_sigqueueinfo01 rt_sigqueueinfo01
 rt_sigsuspend01 rt_sigsuspend01
+rt_tgsigqueueinfo01 rt_tgsigqueueinfo01
 
 sbrk01 sbrk01
 sbrk02 sbrk02
diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore b/testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore
new file mode 100644
index 0000000..f9ffa58
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/.gitignore
@@ -0,0 +1 @@
+rt_tgsigqueueinfo01
diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile b/testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile
new file mode 100644
index 0000000..035ca64
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/Makefile
@@ -0,0 +1,10 @@
+# Copyright (c) 2019 - Linaro Limited. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir             ?= ../../../..
+
+rt_tgsigqueueinfo01: CFLAGS+=-pthread
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
new file mode 100644
index 0000000..4ae17c2
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+/*
+ * Test rt_tgsigqueueinfo
+ *
+ * This tests the rt_tgsigqueueinfo() syscall. It sends the signal and data
+ * to the single thread specified by the combination of tgid, a thread group
+ * ID, and tid, a thread in that thread group.
+ *
+ * Also this implement 3 tests differing on the basis of signal sender:
+ * - Sender and receiver is the same thread.
+ * - Sender is parent of the thread.
+ * - Sender is different thread.
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <pthread.h>
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static char sigval_send[] = "rt_tgsigqueueinfo data";
+static volatile int signum_rcv;
+static char *sigval_rcv;
+
+static void sigusr1_handler(int signum, siginfo_t *uinfo,
+			    void *p LTP_ATTRIBUTE_UNUSED)
+{
+	signum_rcv = signum;
+	sigval_rcv = uinfo->_sifields._rt.si_sigval.sival_ptr;
+}
+
+void *send_rcv_func(void *arg)
+{
+	siginfo_t uinfo;
+
+	signum_rcv = 0;
+	sigval_rcv = NULL;
+
+	uinfo.si_errno = 0;
+	uinfo.si_code = SI_QUEUE;
+	uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
+
+	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
+			 syscall(__NR_gettid), SIGUSR1, &uinfo));
+	if (TST_RET)
+		tst_brk(TFAIL | TTERRNO, "rt_tgsigqueueinfo failed");
+
+	while (!signum_rcv)
+		usleep(1000);
+
+	if ((signum_rcv == SIGUSR1) && (sigval_rcv == sigval_send))
+		tst_res(TPASS, "Test signal to self succeeded");
+	else
+		tst_res(TFAIL, "Failed to deliver signal/data to self thread");
+
+	return arg;
+}
+
+static void verify_signal_self(void)
+{
+	pthread_t pt;
+
+	SAFE_PTHREAD_CREATE(&pt, NULL, send_rcv_func, NULL);
+
+	SAFE_PTHREAD_JOIN(pt, NULL);
+}
+
+void *receiver_func(void *arg)
+{
+	pid_t *tid = arg;
+
+	*tid = syscall(__NR_gettid);
+
+	signum_rcv = 0;
+	sigval_rcv = NULL;
+
+	TST_CHECKPOINT_WAKE(0);
+
+	while (!signum_rcv)
+		usleep(1000);
+
+	if ((signum_rcv == SIGUSR1) && (sigval_rcv == sigval_send))
+		tst_res(TPASS, "Test signal to different thread succeeded");
+	else
+		tst_res(TFAIL,
+			"Failed to deliver signal/data to different thread");
+
+	return NULL;
+}
+
+static void verify_signal_parent_thread(void)
+{
+	pid_t tid = -1;
+	pthread_t pt;
+	siginfo_t uinfo;
+
+	SAFE_PTHREAD_CREATE(&pt, NULL, receiver_func, &tid);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	uinfo.si_errno = 0;
+	uinfo.si_code = SI_QUEUE;
+	uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
+
+	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
+			 tid, SIGUSR1, &uinfo));
+	if (TST_RET)
+		tst_brk(TFAIL | TTERRNO, "rt_tgsigqueueinfo failed");
+
+	SAFE_PTHREAD_JOIN(pt, NULL);
+}
+
+void *sender_func(void *arg)
+{
+	pid_t *tid = arg;
+	siginfo_t uinfo;
+
+	uinfo.si_errno = 0;
+	uinfo.si_code = SI_QUEUE;
+	uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
+
+	TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
+			 *tid, SIGUSR1, &uinfo));
+	if (TST_RET)
+		tst_brk(TFAIL | TTERRNO, "rt_tgsigqueueinfo failed");
+
+	return NULL;
+}
+
+static void verify_signal_inter_thread(void)
+{
+	pid_t tid = -1;
+	pthread_t pt1, pt2;
+
+	SAFE_PTHREAD_CREATE(&pt1, NULL, receiver_func, &tid);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	SAFE_PTHREAD_CREATE(&pt2, NULL, sender_func, &tid);
+
+	SAFE_PTHREAD_JOIN(pt2, NULL);
+
+	SAFE_PTHREAD_JOIN(pt1, NULL);
+}
+
+static struct tcase {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&verify_signal_self},
+	{&verify_signal_parent_thread},
+	{&verify_signal_inter_thread},
+};
+
+static void run(unsigned int i)
+{
+	tcases[i].tfunc();
+}
+
+static void setup(void)
+{
+	struct sigaction sigusr1 = {
+		.sa_flags = SA_SIGINFO,
+		.sa_sigaction = sigusr1_handler,
+	};
+
+	SAFE_SIGACTION(SIGUSR1, &sigusr1, NULL);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.test = run,
+};
-- 
2.7.4

