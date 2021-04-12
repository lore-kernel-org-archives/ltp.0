From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 12 Apr 2021 16:28:36 +0800
Subject: [LTP] [PATCH] controllers/memcg: Add testcase for
 kmem_limit_in_bytes of memory cgroup
Message-ID: <20210412082836.27415-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add memory cgroup testcase for checking that kmem overflow is controlled
by kmem.limit_in_bytes.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../functional/memcg_kmem_limit_in_bytes.c    | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c b/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c
new file mode 100644
index 000000000..d01403fdd
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/functional/memcg_kmem_limit_in_bytes.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 HUAWEI LIMITED
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ * Check that kmem overflow is controlled by kmem.limit_in_bytes.
+ *
+ * [Algorithm]
+ * 1) mount memory cgroup
+ * 2) set 0 to memory.kmem.limit_in_bytes
+ * 3) set test process group to cgroup.procs
+ * 4) fork in test process group to trig kmem overflow
+ */
+
+#include <sys/wait.h>
+#include "tst_test.h"
+
+#define MNT_POINT "memcg"
+#define TESTDIR "memcg/ltpmemcg"
+#define CGROUP_PROCS "memcg/ltpmemcg/cgroup.procs"
+#define KMEM_LIMIT_IN_BYTES "memcg/ltpmemcg/memory.kmem.limit_in_bytes"
+
+static void cleanup(void)
+{
+	SAFE_RMDIR(TESTDIR);
+	SAFE_UMOUNT(MNT_POINT);
+	SAFE_RMDIR(MNT_POINT);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(MNT_POINT, 0755);
+	SAFE_MOUNT("memcg", MNT_POINT, "cgroup", 0, "memory");
+	SAFE_MKDIR(TESTDIR, 0755);
+}
+
+static void run(void)
+{
+	pid_t pid;
+	int st;
+	int fd;
+	char buf[128] = {0};
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		SAFE_SETPGID(0, 0);
+
+		SAFE_FILE_PRINTF(KMEM_LIMIT_IN_BYTES, "%d", 0);
+
+		SAFE_FILE_PRINTF(CGROUP_PROCS, "%d", getpgid(getpid()));
+
+		TEST(fork());
+		if (TST_RET == -1) {
+			if (TST_ERR == ENOMEM)
+				tst_res(TPASS, "fork fail as expected");
+			else
+				tst_brk(TFAIL | TTERRNO,
+					"fork fail as unexpected");
+		} else if (TST_RET == 0) {
+			tst_brk(TFAIL, "fork success as unexpected");
+		} else {
+			SAFE_WAIT(NULL);
+			tst_brk(TFAIL, "fork success as unexpected");
+		}
+	} else {
+		SAFE_WAIT(&st);
+		if (WIFEXITED(st))
+			if (!WEXITSTATUS(st)) {
+				tst_res(TPASS, "kmem alloc is controled "
+					"by memory.kmem.limit_in_bytes");
+				return;
+			}
+
+		tst_res(TFAIL,"kmem alloc is not controled "
+			"by memory.kmem.limit_in_bytes");
+	}
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+};
--
2.17.1

