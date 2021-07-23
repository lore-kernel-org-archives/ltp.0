From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 23 Jul 2021 17:42:00 +0800
Subject: [LTP] [PATCH v2 2/2] syscalls/shmget06: Add test when shm_next_id
 is already in use
In-Reply-To: <1627033320-1584-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YPlftOtF7QxjjDnX@yuki>
 <1627033320-1584-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <1627033320-1584-2-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the identifier of the System V shared memory segment that shm_next_id stored
is already in use, shmget() with different key will return the another shm id. But
kernel doesn't guarantee desired id, I just compare with the existed id, if not
equal, the test succeeds.

This case is similar to msgget05.c.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/shmget/.gitignore     |  1 +
 .../kernel/syscalls/ipc/shmget/shmget06.c     | 75 +++++++++++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmget/shmget06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b65b18c32..b379b2d90 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1413,6 +1413,7 @@ shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
 shmget05 shmget05
+shmget06 shmget06
 
 sigaction01 sigaction01
 sigaction02 sigaction02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index ff0364704..b758158c3 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -68,3 +68,4 @@ shmget02 shmget02
 shmget03 shmget03
 shmget04 shmget04
 shmget05 shmget05
+shmget06 shmget06
diff --git a/testcases/kernel/syscalls/ipc/shmget/.gitignore b/testcases/kernel/syscalls/ipc/shmget/.gitignore
index 6f08529f8..768d1c69d 100644
--- a/testcases/kernel/syscalls/ipc/shmget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmget/.gitignore
@@ -2,3 +2,4 @@
 /shmget03
 /shmget04
 /shmget05
+/shmget06
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget06.c b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
new file mode 100644
index 000000000..d91b7b635
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
@@ -0,0 +1,75 @@
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
+ * When the shared memory segment identifier that shm_next_id stored is already
+ * in use, call shmget with different key just use another unused value in range
+ * [0,INT_MAX]. Kernel doesn't guarantee the desired id.
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
+
+static int shm_id[2], pid;
+static key_t shmkey[2];
+
+static void verify_shmget(void)
+{
+	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", shm_id[0]);
+
+	shm_id[1] = SAFE_SHMGET(shmkey[1], SHM_SIZE, IPC_CREAT | SHM_RW);
+	if (shm_id[1] == shm_id[0])
+		tst_res(TFAIL, "shm id %d has existed, shmget() returns the"
+			" same shm id unexpectedly", shm_id[0]);
+	else
+		tst_res(TPASS, "shm id %d has existed, shmget() returns the"
+			" new shm id %d", shm_id[0], shm_id[1]);
+
+	SAFE_SHMCTL(shm_id[1], IPC_RMID, NULL);
+}
+
+static void setup(void)
+{
+	shmkey[0] = GETIPCKEY();
+	shmkey[1] = GETIPCKEY();
+	pid = getpid();
+	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
+	shm_id[0] = SAFE_SHMGET(shmkey[0], SHM_SIZE, IPC_CREAT | SHM_RW);
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (shm_id[i] != -1)
+			SAFE_SHMCTL(shm_id[i], IPC_RMID, NULL);
+	}
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

