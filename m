From: Xiao Yang <ice_yangxiao@163.com>
Date: Fri, 21 Jun 2019 18:51:11 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/futex_cmp_requeue02.c: Add new test
In-Reply-To: <1561114271-8351-1-git-send-email-ice_yangxiao@163.com>
References: <1561114271-8351-1-git-send-email-ice_yangxiao@163.com>
Message-ID: <1561114271-8351-2-git-send-email-ice_yangxiao@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check various errnos for futex(FUTEX_CMP_REQUEUE).

It's also a regression test for CVE-2018-6927:
fbe0e839d1e2 ("futex: Prevent overflow by strengthen input validation")

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/futex/.gitignore         |  1 +
 testcases/kernel/syscalls/futex/Makefile           |  1 +
 .../kernel/syscalls/futex/futex_cmp_requeue02.c    | 76 ++++++++++++++++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index af5eda5..ff3e20e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1550,6 +1550,7 @@ perf_event_open01 perf_event_open01
 perf_event_open02 perf_event_open02
 
 futex_cmp_requeue01 futex_cmp_requeue01
+futex_cmp_requeue02 futex_cmp_requeue02
 futex_wait01 futex_wait01
 futex_wait02 futex_wait02
 futex_wait03 futex_wait03
diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
index 4666a2c..68bc202 100644
--- a/testcases/kernel/syscalls/futex/.gitignore
+++ b/testcases/kernel/syscalls/futex/.gitignore
@@ -1,4 +1,5 @@
 /futex_cmp_requeue01
+/futex_cmp_requeue02
 /futex_wait01
 /futex_wait02
 /futex_wait03
diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
index c4d5033..1a0c008 100644
--- a/testcases/kernel/syscalls/futex/Makefile
+++ b/testcases/kernel/syscalls/futex/Makefile
@@ -19,6 +19,7 @@
 top_srcdir		?= ../../../..
 
 futex_cmp_requeue01: LDLIBS+=-lrt
+futex_cmp_requeue02: LDLIBS+=-lrt
 futex_wait02: LDLIBS+=-lrt
 futex_wake03: LDLIBS+=-lrt
 futex_wait03: CFLAGS+=-pthread
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
new file mode 100644
index 0000000..3ea1942
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue02.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2019 Xiao Yang <ice_yangxiao@163.com>
+ *
+ * Description:
+ * Check various errnos for futex(FUTEX_CMP_REQUEUE).
+ * 1) futex(FUTEX_CMP_REQUEUE) with invalid val returns EINVAL.
+ * 2) futex(FUTEX_CMP_REQUEUE) with invalid val2 returns EINVAL.
+ * 3) futex(FUTEX_CMP_REQUEUE) with mismatched val3 returns EAGAIN.
+ *
+ * It's also a regression test for CVE-2018-6927:
+ * fbe0e839d1e2 ("futex: Prevent overflow by strengthen input validation")
+ */
+
+#include <errno.h>
+#include <linux/futex.h>
+#include <sys/time.h>
+
+#include "tst_test.h"
+#include "futextest.h"
+
+static futex_t *futexes;
+
+static struct tcase {
+	int set_wakes;
+	int set_requeues;
+	int exp_val;
+	int exp_errno;
+} tcases[] = {
+	{1, -1, FUTEX_INITIALIZER, EINVAL},
+	{-1, 1, FUTEX_INITIALIZER, EINVAL},
+	{1, 1, FUTEX_INITIALIZER + 1, EAGAIN},
+};
+
+static void verify_futex_cmp_requeue(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(futex_cmp_requeue(&futexes[0], tc->exp_val, &futexes[1],
+	     tc->set_wakes, tc->set_requeues, 0));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "futex_cmp_requeue() succeeded unexpectedly");
+		return;
+	}
+
+	if (TST_ERR != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"futex_cmp_requeue() failed unexpectedly, expected %s",
+			tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS | TTERRNO, "futex_cmp_requeue() failed as expected");
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
+	.test = verify_futex_cmp_requeue,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
1.8.3.1


