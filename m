From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jun 2020 15:50:20 +0530
Subject: [LTP] [PATCH V2 2/6] syscalls: semctl: Add new test to verify the
 _time_high fields
In-Reply-To: <cover.1592302358.git.viresh.kumar@linaro.org>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
Message-ID: <e8b57475b403a2936828305aee56fe03f285dfc8.1592302358.git.viresh.kumar@linaro.org>
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
 .../kernel/syscalls/ipc/semctl/.gitignore     |  1 +
 testcases/kernel/syscalls/ipc/semctl/Makefile |  5 +-
 .../kernel/syscalls/ipc/semctl/semctl08.c     | 52 +++++++++++++++++++
 5 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/semctl/semctl08.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bee03e93f765..eedd727fb617 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1157,6 +1157,7 @@ semctl04 semctl04
 semctl05 semctl05
 semctl06 semctl06
 semctl07 semctl07
+semctl08 semctl08
 
 semget01 semget01
 semget02 semget02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 54d8622d4223..f912cb067f74 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -33,6 +33,7 @@ semctl04 semctl04
 semctl05 semctl05
 semctl06 semctl06
 semctl07 semctl07
+semctl08 semctl08
 
 semget01 semget01
 semget02 semget02
diff --git a/testcases/kernel/syscalls/ipc/semctl/.gitignore b/testcases/kernel/syscalls/ipc/semctl/.gitignore
index b6899acf5da6..6189a04cc3c6 100644
--- a/testcases/kernel/syscalls/ipc/semctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/semctl/.gitignore
@@ -5,3 +5,4 @@
 /semctl05
 /semctl06
 /semctl07
+/semctl08
diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
index f62cd1f481d9..99971a7dbb32 100644
--- a/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -3,10 +3,11 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpipc ltpnewipc
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDLIBS  += -lltpipc
+semctl01 semctl02 semctl03 semctl04 semctl05 semctl06 semctl07: LDLIBS += -lltpipc
+semctl08: LDLIBS += -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
new file mode 100644
index 000000000000..40c2e1741d3a
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Cross verify the _high fields being set to 0 by the kernel.
+ */
+#include "lapi/sembuf.h"
+#include "lapi/semun.h"
+#include "tst_test.h"
+#include "libnewipc.h"
+
+#ifdef HAVE_SEMID64_DS_TIME_HIGH
+
+static void run(void)
+{
+	struct semid64_ds buf_ds = {
+		.sem_otime_high = 0x0A0A,
+		.sem_ctime_high = 0x0A0A,
+	};
+	int semid;
+	union semun arg;
+	key_t key;
+
+	/* get an IPC resource key */
+	key = GETIPCKEY();
+
+	semid = semget(key, 1, SEM_RA | IPC_CREAT);
+	if (semid == -1)
+		tst_brk(TBROK | TERRNO, "couldn't create semaphore");
+
+	arg.buf = (struct semid_ds *)&buf_ds;
+	TEST(semctl(semid, 0, IPC_STAT, arg));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "semctl() failed");
+
+	if (buf_ds.sem_otime_high || buf_ds.sem_ctime_high)
+		tst_res(TFAIL, "time_high fields aren't cleared by the kernel");
+	else
+		tst_res(TPASS, "time_high fields cleared by the kernel");
+
+	if (semctl(semid, 0, IPC_RMID, arg) == -1)
+		tst_res(TINFO, "WARNING: semaphore deletion failed.");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
+#else
+TST_TEST_TCONF("test requires struct semid64_ds to have the time_high fields");
+#endif
-- 
2.25.0.rc1.19.g042ed3e048af

