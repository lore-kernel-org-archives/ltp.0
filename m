From: Christian Amann <camann@suse.com>
Date: Fri, 26 Jul 2019 10:37:01 +0200
Subject: [LTP] [PATCH v2] syscalls/timer_create: Add test for CVE-2017-18344
Message-ID: <20190726083701.9682-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In kernels prior to 4.14.8 (missing commit cef31d9af908)
the sigevent.sigev_notify field is not properly checked
when creating a timer using timer_create(2).
This can be used to read arbitrary kernel memory.

Signed-off-by: Christian Amann <camann@suse.com>
---

Notes:
    Patch aplicable after the timer tests got moved to syscalls
    (see patch on the mailing list).

 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/timer_create/.gitignore  |  1 +
 .../kernel/syscalls/timer_create/timer_create03.c  | 67 ++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/timer_create/timer_create03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 79a6a0bb6..e2499eed7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1441,6 +1441,7 @@ timerfd_settime01 timerfd_settime01
 
 timer_create01 timer_create01
 timer_create02 timer_create02
+timer_create03 timer_create03
 
 timer_delete01 timer_delete01
 timer_delete02 timer_delete02
diff --git a/testcases/kernel/syscalls/timer_create/.gitignore b/testcases/kernel/syscalls/timer_create/.gitignore
index 5fd2c303e..b70d6cb02 100644
--- a/testcases/kernel/syscalls/timer_create/.gitignore
+++ b/testcases/kernel/syscalls/timer_create/.gitignore
@@ -1,2 +1,3 @@
 /timer_create01
 /timer_create02
+/timer_create03
diff --git a/testcases/kernel/syscalls/timer_create/timer_create03.c b/testcases/kernel/syscalls/timer_create/timer_create03.c
new file mode 100644
index 000000000..c9cf51e3f
--- /dev/null
+++ b/testcases/kernel/syscalls/timer_create/timer_create03.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ *
+ * Author:	Christian Amann <camann@suse.com>
+ */
+/*
+ * Regression test for CVE-2017-18344:
+ *
+ *	In kernels prior to 4.14.8 sigevent.sigev_notify is not
+ *	properly verified when calling timer_create(2) with the
+ *	field being set to (SIGEV_SIGNAL | SIGEV_THREAD_ID).
+ *	This can be used to read arbitrary kernel memory.
+ *
+ *	For more info see: https://nvd.nist.gov/vuln/detail/CVE-2017-18344
+ *	or commit: cef31d9af908
+ *
+ *	This test uses an unused number instead of SIGEV_THREAD_ID to check
+ *	if this field gets verified correctly.
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <time.h>
+#include "tst_test.h"
+#include "lapi/common_timers.h"
+
+#define RANDOM_UNUSED_NUMBER (54321)
+
+static void run(void)
+{
+	struct sigevent evp;
+	clock_t clock = CLOCK_MONOTONIC;
+	kernel_timer_t created_timer_id;
+
+	memset(&evp, 0, sizeof(evp));
+
+	evp.sigev_signo  = SIGALRM;
+	evp.sigev_notify = SIGEV_SIGNAL | RANDOM_UNUSED_NUMBER;
+	evp._sigev_un._tid = getpid();
+
+	TEST(tst_syscall(__NR_timer_create, clock, &evp, &created_timer_id));
+
+	if (TST_RET != 0) {
+		if (TST_ERR == EINVAL) {
+			tst_res(TPASS | TTERRNO,
+					"timer_create() failed as expected");
+		} else {
+			tst_res(TFAIL | TTERRNO,
+					"timer_create() unexpectedly failed");
+		}
+		return;
+	}
+
+	tst_res(TFAIL,
+		"timer_create() succeeded for invalid notification type");
+
+	TEST(tst_syscall(__NR_timer_delete, created_timer_id));
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO, "Failed to delete timer %s",
+			get_clock_str(clock));
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.16.4

