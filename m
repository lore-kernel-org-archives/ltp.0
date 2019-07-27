From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Sat, 27 Jul 2019 15:52:36 +0800
Subject: [LTP] [PATCH] syscalls/prctl08: New test for prctl() with PR_{SET,
 GET}_TIMERSLACK
Message-ID: <1564213956-2409-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/prctl.h                       |   5 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/prctl/.gitignore |   1 +
 testcases/kernel/syscalls/prctl/Makefile   |   1 +
 testcases/kernel/syscalls/prctl/prctl08.c  | 116 +++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/syscalls/prctl/prctl08.c

diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 8ee492259..0b4e196c3 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -19,6 +19,11 @@
 # define PR_SET_SECCOMP  22
 #endif
 
+#ifndef PR_SET_TIMERSLACK
+# define PR_SET_TIMERSLACK 29
+# define PR_GET_TIMERSLACK 30
+#endif
+
 #ifndef PR_SET_CHILD_SUBREAPER
 # define PR_SET_CHILD_SUBREAPER	36
 # define PR_GET_CHILD_SUBREAPER	37
diff --git a/runtest/syscalls b/runtest/syscalls
index 0114b002b..48836f422 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -872,6 +872,7 @@ prctl04 prctl04
 prctl05 prctl05
 prctl06 prctl06
 prctl07 prctl07
+prctl08 prctl08
 
 pread01 pread01
 pread01_64 pread01_64
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
index 2178db366..fe36a8e0f 100644
--- a/testcases/kernel/syscalls/prctl/.gitignore
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -6,3 +6,4 @@
 /prctl06
 /prctl06_execve
 /prctl07
+/prctl08
diff --git a/testcases/kernel/syscalls/prctl/Makefile b/testcases/kernel/syscalls/prctl/Makefile
index cf19507c0..d3c41ff4e 100644
--- a/testcases/kernel/syscalls/prctl/Makefile
+++ b/testcases/kernel/syscalls/prctl/Makefile
@@ -21,5 +21,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 prctl07: LDLIBS += $(CAP_LIBS)
+prctl08: LDLIBS+=-lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/prctl/prctl08.c b/testcases/kernel/syscalls/prctl/prctl08.c
new file mode 100644
index 000000000..ed22571b4
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/prctl08.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Test PR_GET_TIMERSLACK and PR_SET_TIMERSLACK of prctl(2).
+ * 1)Each thread has two associated timer slack values: a "default"
+ *   value, and a "current" value. PR_SET_TIMERSLACK sets the "current"
+ *   timer slack value for the calling thread.
+ * 2)When a new thread is created, the two timer slack values are made
+ *   the same as the "current" value of the creating thread.
+ * 3)The maximum timer slack value is ULONG_MAX. On 32bit machines, it
+ *   is a valid value(about 4s). On 64bit machines, it is about 500 years
+ *   and no person will set this over 4s.  prctl return value is int, so
+ *   we test the maximum value is INT_MAX.
+ * 4)we also check /proc/[pid]/timerslack_ns if it is supported.
+ */
+
+#include <sys/prctl.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/limits.h>
+#include "lapi/syscalls.h"
+#include "lapi/prctl.h"
+#include "tst_timer.h"
+#include "tst_test.h"
+
+#define PROC_NS_PATH "/proc/self/timerslack_ns"
+
+static struct tcase {
+	unsigned long setvalue;
+	unsigned long expvalue;
+	int flag;
+} tcases[] = {
+	{1, 1, 0},
+	{70000, 70000, 0},
+	{INT_MAX, INT_MAX, 1},
+};
+
+static int proc_flag = 1;
+
+static void check_proc_ns(char *message, unsigned long value)
+{
+	unsigned long proc_value;
+
+	SAFE_FILE_SCANF(PROC_NS_PATH, "%lu", &proc_value);
+	if (proc_value == value)
+		tst_res(TPASS, "%s %s  got %lu expectedly",
+				message, PROC_NS_PATH, proc_value);
+	else
+		tst_res(TFAIL, "%s %s expected %lu got %lu",
+				message, PROC_NS_PATH, value, proc_value);
+}
+
+static void check_get_timerslack(char *message, unsigned long value)
+{
+	TEST(prctl(PR_GET_TIMERSLACK));
+	if ((unsigned long)TST_RET == value)
+		tst_res(TPASS, "%s prctl(PR_GET_TIMERSLACK) got %lu expectedly",
+				message, value);
+	else
+		tst_res(TFAIL, "%s prctl(PR_GET_TIMERSLACK) expected %lu got %lu",
+				message, value, TST_RET);
+
+	if (proc_flag)
+		check_proc_ns(message, value);
+}
+
+static void verify_prctl(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int pid;
+	struct timespec timereq = { .tv_sec = tc->flag ? 2 : 0, .tv_nsec = tc->flag ? 0 : 50000 };
+
+	TEST(prctl(PR_SET_TIMERSLACK, tc->setvalue));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_TIMERSLACK, %lu) failed",
+				tc->setvalue);
+		return;
+	}
+	tst_res(TPASS, "prctl(PR_SET_TIMERSLACK, %lu) success", tc->setvalue);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		check_get_timerslack("child process", tc->expvalue);
+		/* A value of 0 means using default */
+		prctl(PR_SET_TIMERSLACK, 0);
+		check_get_timerslack("After set 0, child process", tc->expvalue);
+
+		tst_timer_start(CLOCK_MONOTONIC);
+		TEST(nanosleep(&timereq, NULL));
+		tst_timer_stop();
+		if (tst_timespec_lt(tst_timer_elapsed(), timereq))
+			tst_brk(TFAIL, "nanosleep() slept less than timereq");
+
+		tst_res(TPASS, "nanosleep() slept more than timereq, %llius",
+				tst_timer_elapsed_us());
+		exit(0);
+	}
+}
+
+static void setup(void)
+{
+	if (access(PROC_NS_PATH, F_OK) == -1) {
+		tst_res(TCONF, "proc doesn't support timerslack_ns interface");
+		proc_flag = 0;
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_prctl,
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+};
-- 
2.18.1



