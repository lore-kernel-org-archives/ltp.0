From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 20 Oct 2015 12:59:59 +0000
Subject: [LTP] [PATCH] sched_getattr/sched_getattr02: Add new testcase for
	sched_getattr
Message-ID: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add new testcase for sched_getattr

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
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
index 0000000..a829e00
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -0,0 +1,152 @@
+#define _GNU_SOURCE
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
+char *TCID = "sched_getattr01";
+int TST_TOTAL = 1;
+
+#define SCHED_DEADLINE	6
+#define RUNTIME_VAL 10000000
+#define PERIOD_VAL 30000000
+#define DEADLINE_VAL 30000000
+
+void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)
+{
+	struct sched_attr attr, attr_copy;
+	int ret;
+	unsigned int flags = 0;
+	unsigned int size;
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
+	size = sizeof(attr_copy);
+
+	/*
+	 * TEST CASE 1
+	 * set invalid address (NULL) of attr
+	 */
+	TEST(sched_getattr(0, NULL, size, flags));
+
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL) {
+			tst_resm(TPASS, "sched_getattr() - set invalid address of attr failed as expected with errno %d : %s",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO));
+		} else {
+			tst_resm(TFAIL, "sched_getattr() - set invalid address of attr failed with errno %d : %s but expected %d (EINVAL)",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO), EINVAL);
+		}
+	} else {
+		tst_resm(TFAIL, "sched_getattr() - set invalid address of attr succeeded unexpectedly.");
+	}
+
+	/*
+	 * TEST CASE 2
+	 * set error value (999999) of pid
+	 */
+	TEST(sched_getattr(999999, &attr_copy, size, flags));
+
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == ESRCH) {
+			tst_resm(TPASS, "sched_getattr() - set error value of pid failed as expected with errno %d : %s",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO));
+		} else {
+			tst_resm(TFAIL, "sched_getattr() - set error value of pid failed with errno %d : %s but expected %d (ESRCH)",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO), ESRCH);
+		}
+	} else {
+		tst_resm(TFAIL, "sched_getattr() - set error value of pid succeeded unexpectedly.");
+	}
+
+	/*
+	 * TEST CASE 3
+	 * set error value of size
+	 */
+	TEST(sched_getattr(0, &attr_copy, size - 1, flags));
+
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL) {
+			tst_resm(TPASS, "sched_getattr() - set error value of size failed as expected with errno %d : %s",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO));
+		} else {
+			tst_resm(TFAIL, "sched_getattr() - set error value of size failed with errno %d : %s but expected %d (EINVAL)",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO), EINVAL);
+		}
+	} else {
+		tst_resm(TFAIL, "sched_getattr() - set error value of size succeeded unexpectedly.");
+	}
+
+	/*
+	 * TEST CASE 4
+	 * set error value (10000) of flags
+	 */
+	TEST(sched_getattr(0, &attr_copy, size, 10000));
+
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EINVAL) {
+			tst_resm(TPASS, "sched_getattr() - set error value of flags failed as expected with errno %d : %s",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO));
+		} else {
+			tst_resm(TFAIL, "sched_getattr() - set error value of flags failed with errno %d : %s but expected %d (EINVAL)",
+			TEST_ERRNO,
+			strerror(TEST_ERRNO), EINVAL);
+		}
+	} else {
+		tst_resm(TFAIL, "sched_getattr() - set error value of pid succeeded unexpectedly.");
+	}
+
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	pthread_t thread;
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	tst_require_root();
+
+	if ((tst_kvercmp(3, 14, 0)) < 0)
+		tst_brkm(TCONF, NULL, "EDF needs kernel 3.14 or higher");
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		pthread_create(&thread, NULL, run_deadline, NULL);
+		pthread_join(thread, NULL);
+	}
+
+	tst_exit();
+}
-- 
1.6.0.2

