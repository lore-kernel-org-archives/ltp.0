From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jun 2020 15:50:24 +0530
Subject: [LTP] [PATCH V2 6/6] syscalls: msgctl: Add new test to verify the
 _time_high fields
In-Reply-To: <cover.1592302358.git.viresh.kumar@linaro.org>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
Message-ID: <64c024464dbc063afebdc76c8f691380067873b9.1592302358.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The _time_high fields must be reset by the kernel, add a test to verify
that.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/msgctl/.gitignore     |  1 +
 .../kernel/syscalls/ipc/msgctl/msgctl05.c     | 48 +++++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/msgctl/msgctl05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f8b2277e0eda..ee7e2a0d217d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -797,6 +797,7 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
+msgctl05 msgctl05
 msgstress01 msgstress01
 msgstress02 msgstress02
 msgstress03 msgstress03
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 5ba3b1449a6c..c3a35896c5a8 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -2,6 +2,7 @@ msgctl01 msgctl01
 msgctl02 msgctl02
 msgctl03 msgctl03
 msgctl04 msgctl04
+msgctl05 msgctl05
 msgstress01 msgstress01
 msgstress02 msgstress02
 msgstress03 msgstress03
diff --git a/testcases/kernel/syscalls/ipc/msgctl/.gitignore b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
index f179f2606a3e..0157f4611bdf 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
@@ -2,4 +2,5 @@
 /msgctl02
 /msgctl03
 /msgctl04
+/msgctl05
 /msgctl12
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
new file mode 100644
index 000000000000..cd2643bc1ead
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Cross verify the _high fields being set to 0 by the kernel.
+ */
+#include <sys/msg.h>
+#include "lapi/msgbuf.h"
+#include "libnewipc.h"
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+#ifdef HAVE_MSQID64_DS_TIME_HIGH
+
+static void run(void)
+{
+	struct msqid64_ds buf_ds = {
+		.msg_stime_high = 0x0A0A,
+		.msg_rtime_high = 0x0A0A,
+		.msg_ctime_high = 0x0A0A,
+	};
+	int msqid;
+	key_t key;
+
+	key = GETIPCKEY();
+
+	msqid = SAFE_MSGGET(key, IPC_CREAT | IPC_EXCL | MSG_RW | 0600);
+
+	TEST(msgctl(msqid, IPC_STAT, (struct msqid_ds *)&buf_ds));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "msqctl() failed");
+
+	if (buf_ds.msg_stime_high || buf_ds.msg_rtime_high || buf_ds.msg_ctime_high)
+		tst_res(TFAIL, "time_high fields aren't cleared by the kernel");
+	else
+		tst_res(TPASS, "time_high fields cleared by the kernel");
+
+	SAFE_MSGCTL(msqid, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
+#else
+TST_TEST_TCONF("test requires struct msqid64_ds to have the time_high fields");
+#endif
-- 
2.25.0.rc1.19.g042ed3e048af

