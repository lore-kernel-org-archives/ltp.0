From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 09:40:17 +0800
Subject: [LTP] [PATCH v2] sched_getattr/sched_getattr02: Add new testcase
 for sched_getattr
In-Reply-To: <20151026154705.GB6772@rei>
References: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
 <20151026154705.GB6772@rei>
Message-ID: <56302781.30701@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add new testcase for sched_getattr

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
V2:
    * Add GPL header;
    * Define array of structures 'test_cases';
    * Use tst_get_unused_pid() to get unused pid;
    * Change some long message;
    * Add setup(),cleanup() and sched_getattr_verify();
    * Change TCID to 'sched_getattr02'

 runtest/sched                                      |    1 +
 runtest/syscalls                                   |    1 +
 .../syscalls/sched_getattr/sched_getattr02.c       |  152 ++++++++++++++++++++
 3 files changed, 154 insertions(+), 0 deletions(-)
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
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
new file mode 100644
index 0000000..edb8980
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -0,0 +1,152 @@
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
+#define SCHED_DEADLINE  6
+#define RUNTIME_VAL 10000000
+#define PERIOD_VAL 30000000
+#define DEADLINE_VAL 30000000
+
+static pid_t pid;
+static pid_t unused_pid;
+struct sched_attr attr_copy;
+static unsigned int size;
+static unsigned int inval_size;
+static unsigned int flags;
+static unsigned int inval_flags = 10000;
+
+static struct test_case {
+	pid_t *pid;
+	struct sched_attr *a;
+	unsigned int *size;
+	unsigned int *flags;
+	int exp_errno;
+} test_cases[] = {
+	{&unused_pid, &attr_copy, &size, &flags, ESRCH},
+	{&pid, NULL, &size, &flags, EINVAL},
+	{&pid, &attr_copy, &inval_size, &flags, EINVAL},
+	{&pid, &attr_copy, &size, &inval_flags, EINVAL}
+};
+
+static void cleanup(void);
+static void setup(void);
+static void sched_getattr_verify(const struct test_case *test);
+
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)
+{
+	struct sched_attr attr;
+	int ret;
+	unsigned int flags = 0;
+	int ind;
+
+	attr.size = sizeof(attr);
+	attr.sched_flags = 0;
+	attr.sched_nice = 0;
+	attr.sched_priority = 0;
+
+	/* This creates a 10ms/30ms reservation */
+	attr.sched_policy = SCHED_DEADLINE;
+	attr.sched_runtime = RUNTIME_VAL;
+	attr.sched_period = PERIOD_VAL;
+	attr.sched_deadline = DEADLINE_VAL;
+
+	ret = sched_setattr(0, &attr, flags);
+	if (ret < 0)
+		tst_brkm(TFAIL | TERRNO, NULL, "sched_setattr() failed");
+
+	for (ind = 0; ind < TST_TOTAL; ind++)
+		sched_getattr_verify(&test_cases[ind]);
+
+	return NULL;
+}
+
+static void sched_getattr_verify(const struct test_case *test)
+{
+	TEST(sched_getattr(*(test->pid), test->a, *(test->size),
+			*(test->flags)));
+
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "sched_getattr() succeeded unexpectedly.");
+		return;
+	}
+
+	if (TEST_ERRNO == test->exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+			"sched_getattr() returned the expected value");
+		return;
+	}
+
+	tst_resm(TFAIL | TTERRNO, "sched_getattr() got unexpected return "
+		"value: expected: %d - %s",
+		test->exp_errno, tst_strerrno(test->exp_errno));
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t thread;
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		pthread_create(&thread, NULL, run_deadline, NULL);
+		pthread_join(thread, NULL);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	pid = 0;
+	unused_pid = tst_get_unused_pid(cleanup);
+	size = sizeof(attr_copy);
+	inval_size = size - 1;
+	flags = 0;
+
+	tst_require_root();
+
+	if ((tst_kvercmp(3, 14, 0)) < 0)
+		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
+
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+}
-- 
1.6.0.2 .

