From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue,  5 Mar 2019 19:52:23 +0530
Subject: [LTP] [PATCH v2] syscalls: add rt_tgsigqueueinfo() test-case
Message-ID: <1551795743-30614-1-git-send-email-sumit.garg@linaro.org>
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

Changes in v2:
1. Add following cases where the sender differs:
  - parent -> thread
  - thread1 -> thread2
2. Add verification of signal and data delivered by rt_tgsigqueueinfo().

 runtest/syscalls                                   |   1 +
 .../kernel/syscalls/rt_tgsigqueueinfo/.gitignore   |   1 +
 .../kernel/syscalls/rt_tgsigqueueinfo/Makefile     |  10 ++
 .../rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c        | 200 +++++++++++++++++++++
 4 files changed, 212 insertions(+)
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
index 0000000..132b31c
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
@@ -0,0 +1,200 @@
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
+#include <string.h>
+#include <pthread.h>
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static char sigval_send[] = "rt_tgsigqueueinfo data";
+static int signum_rcv;
+static char sigval_rcv[128];
+
+static pthread_cond_t sigusr1_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t sigusr1_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static pthread_cond_t tid_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t tid_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static void sigusr1_handler(int signum, siginfo_t *uinfo,
+			    void *p LTP_ATTRIBUTE_UNUSED)
+{
+	char *rcv = uinfo->_sifields._rt.si_sigval.sival_ptr;
+
+	if (rcv)
+		strcpy(sigval_rcv, rcv);
+	signum_rcv = signum;
+
+	pthread_cond_broadcast(&sigusr1_cond);
+}
+
+void *tfunc_self(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	siginfo_t uinfo;
+
+	signum_rcv = 0;
+	memset(sigval_rcv, 0, sizeof(sigval_rcv));
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
+	pthread_mutex_lock(&sigusr1_mutex);
+	while (!signum_rcv)
+		pthread_cond_wait(&sigusr1_cond, &sigusr1_mutex);
+	pthread_mutex_unlock(&sigusr1_mutex);
+
+	if ((signum_rcv == SIGUSR1) && !strcmp(sigval_send, sigval_rcv))
+		tst_res(TPASS, "Test signal to self succeeded");
+	else
+		tst_res(TFAIL, "Test failed");
+
+	return NULL;
+}
+
+static void verify_signal_self(void)
+{
+	pthread_t pt;
+
+	SAFE_PTHREAD_CREATE(&pt, NULL, tfunc_self, NULL);
+
+	SAFE_PTHREAD_JOIN(pt, NULL);
+}
+
+void *t1func(void *arg)
+{
+	pid_t *tid = arg;
+
+	*tid = syscall(__NR_gettid);
+
+	pthread_cond_broadcast(&tid_cond);
+
+	signum_rcv = 0;
+	memset(sigval_rcv, 0, sizeof(sigval_rcv));
+
+	pthread_mutex_lock(&sigusr1_mutex);
+	while (!signum_rcv)
+		pthread_cond_wait(&sigusr1_cond, &sigusr1_mutex);
+	pthread_mutex_unlock(&sigusr1_mutex);
+
+	if ((signum_rcv == SIGUSR1) && !strcmp(sigval_send, sigval_rcv))
+		tst_res(TPASS, "Test signal to different thread succeeded");
+	else
+		tst_res(TFAIL, "Test failed");
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
+	SAFE_PTHREAD_CREATE(&pt, NULL, t1func, &tid);
+
+	pthread_mutex_lock(&tid_mutex);
+	while (tid == -1)
+		pthread_cond_wait(&tid_cond, &tid_mutex);
+	pthread_mutex_unlock(&tid_mutex);
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
+void *t2func(void *arg)
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
+	SAFE_PTHREAD_CREATE(&pt1, NULL, t1func, &tid);
+
+	pthread_mutex_lock(&tid_mutex);
+	while (tid == -1)
+		pthread_cond_wait(&tid_cond, &tid_mutex);
+	pthread_mutex_unlock(&tid_mutex);
+
+	SAFE_PTHREAD_CREATE(&pt2, NULL, t2func, &tid);
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
+	.setup = setup,
+	.test = run,
+};
-- 
2.7.4

