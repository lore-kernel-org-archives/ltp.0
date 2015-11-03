From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 3 Nov 2015 19:29:15 +0800
Subject: [LTP] [PATCH v5] sched_getattr/sched_getattr02: Add new testcase
 for sched_getattr
In-Reply-To: <20151102172809.GD28478@rei>
References: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
 <20151026154705.GB6772@rei> <56302781.30701@huawei.com>
 <20151029160913.GE23990@rei> <563463CC.3090703@huawei.com>
 <20151102172809.GD28478@rei>
Message-ID: <56389A8B.6040600@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add new testcase for sched_getattr

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
V5:
    * Add sched_getattr02 to testcases/kernel/syscalls/.gitignore;

V4:
    * Initialize flags in array of structures 'test_cases';
    * Delete run_deadline() and TEST_LOOPING() loop;
    * Add loop in main to call sched_getattr_verify();

V3:
    * Delete sched_setattr() and related parameters;
    * Change ind to i as loop variable;
    * Change "returned the expected value" to "failed expectedly";
    * Delete unnecessary initialization in setup();
    * Delete cleanup function;

V2:
    * Add GPL header;
    * Define array of structures 'test_cases';
    * Use tst_get_unused_pid() to get unused pid;
    * Change some long message;
    * Add setup(),cleanup() and sched_getattr_verify();
    * Change TCID to 'sched_getattr02'

 runtest/sched                                      |    1 +
 runtest/syscalls                                   |    1 +
 testcases/kernel/syscalls/.gitignore               |    1 +
 .../syscalls/sched_getattr/sched_getattr02.c       |  103 ++++++++++++++++++++
 4 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/sched_getattr/sched_getattr02.c

diff --git a/runtest/sched b/runtest/sched
index 10a1648..4b8a1df 100644
--- a/runtest/sched
+++ b/runtest/sched
@@ -10,6 +10,7 @@ hackbench01 hackbench 50 process 1000
 hackbench02 hackbench 20 thread 1000

 sched_getattr01 sched_getattr01
+sched_getattr02 sched_getattr02

 sched_cli_serv run_sched_cliserv.sh
 # Run this stress test for 2 minutes
diff --git a/runtest/syscalls b/runtest/syscalls
index 958f66e..724ab66 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -923,6 +923,7 @@ sched_setaffinity01 sched_setaffinity01
 sched_getaffinity01 sched_getaffinity01

 sched_getattr01 sched_getattr01
+sched_getattr02 sched_getattr02

 select01 select01
 select02 select02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 6e4894a..aba112b 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -742,6 +742,7 @@
 /sched_get_priority_min/sched_get_priority_min02
 /sched_getaffinity/sched_getaffinity01
 /sched_getattr/sched_getattr01
+/sched_getattr/sched_getattr02
 /sched_getparam/sched_getparam01
 /sched_getparam/sched_getparam02
 /sched_getparam/sched_getparam03
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
new file mode 100644
index 0000000..198892b
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -0,0 +1,103 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd., 2015
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ */
+
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <linux/unistd.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <sys/syscall.h>
+#include <pthread.h>
+#include <sched.h>
+#include <errno.h>
+
+#include "test.h"
+#include "linux_syscall_numbers.h"
+#include "lapi/sched.h"
+
+char *TCID = "sched_getattr02";
+
+static pid_t pid;
+static pid_t unused_pid;
+struct sched_attr attr_copy;
+
+static struct test_case {
+	pid_t *pid;
+	struct sched_attr *a;
+	unsigned int size;
+	unsigned int flags;
+	int exp_errno;
+} test_cases[] = {
+	{&unused_pid, &attr_copy, sizeof(struct sched_attr), 0, ESRCH},
+	{&pid, NULL, sizeof(struct sched_attr), 0, EINVAL},
+	{&pid, &attr_copy, sizeof(struct sched_attr) - 1, 0, EINVAL},
+	{&pid, &attr_copy, sizeof(struct sched_attr), 1000, EINVAL}
+};
+
+static void setup(void);
+static void sched_getattr_verify(const struct test_case *test);
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static void sched_getattr_verify(const struct test_case *test)
+{
+	TEST(sched_getattr(*(test->pid), test->a, test->size,
+			test->flags));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "sched_getattr() succeeded unexpectedly.");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+			"sched_getattr() failed expectedly");
+		return;
+	}
+
+	tst_resm(TFAIL | TTERRNO, "sched_getattr() failed unexpectedly "
+		": expected: %d - %s",
+		test->exp_errno, tst_strerrno(test->exp_errno));
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (i = 0; i < TST_TOTAL; i++)
+		sched_getattr_verify(&test_cases[i]);
+
+	tst_exit();
+}
+
+void setup(void)
+{
+	unused_pid = tst_get_unused_pid(setup);
+
+	tst_require_root();
+
+	if ((tst_kvercmp(3, 14, 0)) < 0)
+		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
+
+	TEST_PAUSE;
+}
+
-- 
1.6.0.2 .


