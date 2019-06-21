From: Xiao Yang <ice_yangxiao@163.com>
Date: Fri, 21 Jun 2019 18:51:10 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/futex_cmp_requeue01.c: Add new test
Message-ID: <1561114271-8351-1-git-send-email-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check the basic functionality of futex(FUTEX_CMP_REQUEUE).

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/futex/.gitignore         |   1 +
 testcases/kernel/syscalls/futex/Makefile           |   1 +
 .../kernel/syscalls/futex/futex_cmp_requeue01.c    | 132 +++++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c6a0644..af5eda5 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1549,6 +1549,7 @@ writev07 writev07
 perf_event_open01 perf_event_open01
 perf_event_open02 perf_event_open02
 
+futex_cmp_requeue01 futex_cmp_requeue01
 futex_wait01 futex_wait01
 futex_wait02 futex_wait02
 futex_wait03 futex_wait03
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index dbc2d52..4666a2c 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -1,3 +1,4 @@
+/futex_cmp_requeue01
 /futex_wait01
 /futex_wait02
 /futex_wait03
diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
index 6e72daf..c4d5033 100644
--- a/testcases/kernel/syscalls/futex/Makefile
+++ b/testcases/kernel/syscalls/futex/Makefile
@@ -18,6 +18,7 @@
 
 top_srcdir		?= ../../../..
 
+futex_cmp_requeue01: LDLIBS+=-lrt
 futex_wait02: LDLIBS+=-lrt
 futex_wake03: LDLIBS+=-lrt
 futex_wait03: CFLAGS+=-pthread
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
new file mode 100644
index 0000000..cdd59a1
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Xiao Yang <ice_yangxiao@163.com>
+ *
+ * Description:
+ * Testcase to check the basic functionality of futex(FUTEX_CMP_REQUEUE).
+ * futex(FUTEX_CMP_REQUEUE) can wake up the number of waiters specified
+ * by val argument and then requeue the number of waiters limited by val2
+ * argument(i.e. move some remaining waiters from uaddr to uaddr2 address).
+ */
+
+#include <errno.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <linux/futex.h>
+#include <sys/time.h>
+
+#include "tst_timer_test.h"
+#include "tst_test.h"
+#include "futextest.h"
+
+static futex_t *futexes;
+
+static struct tcase {
+	int num_waiters;
+	int set_wakes;
+	int set_requeues;
+	int exp_ret;
+	int exp_wakes;
+	int exp_requeues;
+} tcases[] = {
+	{10, 3, 7, 10, 3, 7},
+	{10, 0, 10, 10, 0, 10},
+	{10, 2, 6, 8, 2, 6},
+	{100, 50, 50, 100, 50, 50},
+	{100, 0, 70, 70, 0, 70},
+	{1000, 100, 900, 1000, 100, 900},
+	{1000, 300, 500, 800, 300, 500},
+};
+
+static void do_child(void)
+{
+	struct timespec usec = tst_ms_to_timespec(2000);
+	int pid = getpid();
+
+	if (!futex_wait(&futexes[0], futexes[0], &usec, 0))
+		exit(0);
+
+	tst_res(TINFO | TERRNO, "process %d wasn't woken up", pid);
+	exit(1);
+}
+
+static void verify_futex_cmp_requeue(unsigned int n)
+{
+	int num_requeues = 0, num_waits = 0, num_total = 0;
+	int i, status;
+	struct tcase *tc = &tcases[n];
+	int pid[tc->num_waiters];
+
+	for (i = 0; i < tc->num_waiters; i++) {
+		pid[i] = SAFE_FORK();
+		if (!pid[i])
+			do_child();
+	}
+
+	for (i = 0; i < tc->num_waiters; i++)
+		TST_PROCESS_STATE_WAIT(pid[i], 'S');
+
+	TEST(futex_cmp_requeue(&futexes[0], futexes[0], &futexes[1],
+	     tc->set_wakes, tc->set_requeues, 0));
+	if (TST_RET != tc->exp_ret) {
+		tst_res(TFAIL, "futex_cmp_requeue() returned %ld, expected %d",
+			TST_RET, tc->exp_ret);
+	}
+
+	num_requeues = futex_wake(&futexes[1], tc->num_waiters, 0);
+	num_waits = futex_wake(&futexes[0], tc->num_waiters, 0);
+
+	for (i = 0; i < tc->num_waiters; i++) {
+		SAFE_WAITPID(pid[i], &status, 0);
+		if (WIFEXITED(status) && !WEXITSTATUS(status))
+			num_total++;
+	}
+
+	if (num_total != tc->num_waiters) {
+		tst_res(TFAIL, "%d waiters were not woken up normally",
+			tc->num_waiters - num_total);
+		return;
+	}
+
+	if (num_requeues != tc->exp_requeues) {
+		tst_res(TFAIL,
+			"futex_cmp_requeue() requeues %d waiters, expected %d",
+			num_requeues, tc->exp_requeues);
+		return;
+	}
+
+	if (tc->num_waiters - num_requeues - num_waits != tc->exp_wakes) {
+		tst_res(TFAIL,
+			"futex_cmp_requeue() woke up %d waiters, expected %d",
+			tc->num_waiters - num_requeues - num_waits,
+			tc->exp_wakes);
+		return;
+	}
+
+	tst_res(TPASS,
+		"futex_cmp_requeue() woke up %d waiters and requeued %d waiters",
+		tc->exp_wakes, tc->exp_requeues);
+}
+
+static void setup(void)
+{
+	futexes = SAFE_MMAP(NULL, sizeof(futex_t) * 2, PROT_READ | PROT_WRITE,
+			    MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+
+	futexes[0] = FUTEX_INITIALIZER;
+	futexes[1] = FUTEX_INITIALIZER + 1;
+}
+
+static void cleanup(void)
+{
+	if (futexes)
+		SAFE_MUNMAP((void *)futexes, sizeof(futex_t) * 2);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_futex_cmp_requeue,
+	.forks_child = 1,
+};
-- 
1.8.3.1


