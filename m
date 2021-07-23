From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 23 Jul 2021 17:41:59 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/shmget05: Add test for
 /proc/sys/kernel/shm_next_id
In-Reply-To: <YPlftOtF7QxjjDnX@yuki>
References: <YPlftOtF7QxjjDnX@yuki>
Message-ID: <1627033320-1584-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This case is similar to msgget04.c.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/shmget/.gitignore     |  1 +
 .../kernel/syscalls/ipc/shmget/shmget05.c     | 69 +++++++++++++++++++
 4 files changed, 72 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmget/shmget05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1deb6118f..b65b18c32 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1412,6 +1412,7 @@ shmdt02 shmdt02
 shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
+shmget05 shmget05
 
 sigaction01 sigaction01
 sigaction02 sigaction02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index b3bd37923..ff0364704 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -67,3 +67,4 @@ shmdt02 shmdt02
 shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
+shmget05 shmget05
diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/ipc/shmget/.gitignore
index c57df68f5..6f08529f8 100644
--- a/testcases/kernel/syscalls/ipc/shmget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmget/.gitignore
@@ -1,3 +1,4 @@
 /shmget02
 /shmget03
 /shmget04
+/shmget05
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
new file mode 100644
index 000000000..42a115474
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * It is a basic test for shm_next_id.
+ *
+ * shm_next_id specifies desired id for next allocated IPC shared memory. By
+ * default it's equal to -1, which means generic allocation logic.
+ * Possible values to set are in range {0..INT_MAX}.
+ * The value will be set back to -1 by kernel after successful IPC object
+ * allocation.
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+#define NEXT_ID_PATH "/proc/sys/kernel/shm_next_id"
+static int shm_id, pid;
+static key_t shmkey;
+
+static void verify_shmget(void)
+{
+	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
+
+	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, SHM_RW | IPC_CREAT);
+	if (shm_id == pid)
+		tst_res(TPASS, "shm_next_id succeeded, shm id %d", pid);
+	else
+		tst_res(TFAIL, "shm_next_id failed, expected id %d, but got %d", pid, shm_id);
+
+	TST_ASSERT_INT(NEXT_ID_PATH, -1);
+	SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
+	pid++;
+}
+
+static void setup(void)
+{
+	shmkey = GETIPCKEY();
+	pid = getpid();
+}
+
+static void cleanup(void)
+{
+	if (shm_id != -1)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_shmget,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_CHECKPOINT_RESTORE=y",
+		NULL
+	},
+	.needs_root = 1,
+};
-- 
2.23.0

