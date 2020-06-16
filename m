From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 16 Jun 2020 15:50:22 +0530
Subject: [LTP] [PATCH V2 4/6] syscalls: shmctl: Add new test to verify the
 _time_high fields
In-Reply-To: <cover.1592302358.git.viresh.kumar@linaro.org>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
Message-ID: <7ed60e87527647505a71844b540a21db77ddae78.1592302358.git.viresh.kumar@linaro.org>
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
 .../kernel/syscalls/ipc/shmctl/.gitignore     |  1 +
 testcases/kernel/syscalls/ipc/shmctl/Makefile |  5 +-
 .../kernel/syscalls/ipc/shmctl/shmctl06.c     | 51 +++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index eedd727fb617..f8b2277e0eda 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1355,6 +1355,7 @@ shmctl02 shmctl02
 shmctl03 shmctl03
 shmctl04 shmctl04
 shmctl05 shmctl05
+shmctl06 shmctl06
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index f912cb067f74..5ba3b1449a6c 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -55,6 +55,7 @@ shmctl02 shmctl02
 shmctl03 shmctl03
 shmctl04 shmctl04
 shmctl05 shmctl05
+shmctl06 shmctl06
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/testcases/kernel/syscalls/ipc/shmctl/.gitignore b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
index d6777e3b8f1b..46b107344cf4 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
@@ -3,3 +3,4 @@
 /shmctl03
 /shmctl04
 /shmctl05
+/shmctl06
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index cfa5d6e76489..252c11058bc5 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -3,13 +3,16 @@
 
 top_srcdir              ?= ../../../../..
 
-LTPLIBS = ltpipc
+LTPLIBS = ltpipc ltpnewipc
 
 shmctl05: CFLAGS += -pthread
 shmctl05: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+shmctl01 shmctl02 shmctl03 shmctl04 shmctl05: LDLIBS += -lltpipc
+shmctl06: LDLIBS += -lltpnewipc
+
 LDLIBS  += -lltpipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
new file mode 100644
index 000000000000..368759980b74
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Description:
+ * Cross verify the _high fields being set to 0 by the kernel.
+ */
+#include <sys/shm.h>
+#include "lapi/shmbuf.h"
+#include "libnewipc.h"
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+#ifdef HAVE_SHMID64_DS_TIME_HIGH
+
+static void run(void)
+{
+	struct shmid64_ds buf_ds = {
+		.shm_atime_high = 0x0A0A,
+		.shm_dtime_high = 0x0A0A,
+		.shm_ctime_high = 0x0A0A,
+	};
+	int shmid;
+	key_t key;
+
+	/* get an IPC resource key */
+	key = GETIPCKEY();
+
+	shmid = shmget(key, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
+	if (shmid == -1)
+		tst_brk(TBROK | TERRNO, "couldn't create shared memory segment");
+
+	TEST(shmctl(shmid, IPC_STAT, (struct shmid_ds *)&buf_ds));
+	if (TST_RET == -1)
+		tst_brk(TFAIL | TTERRNO, "shmctl() failed");
+
+	if (buf_ds.shm_atime_high || buf_ds.shm_dtime_high || buf_ds.shm_ctime_high)
+		tst_res(TFAIL, "time_high fields aren't cleared by the kernel");
+	else
+		tst_res(TPASS, "time_high fields cleared by the kernel");
+
+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
+#else
+TST_TEST_TCONF("test requires struct shmid64_ds to have the time_high fields");
+#endif
-- 
2.25.0.rc1.19.g042ed3e048af

