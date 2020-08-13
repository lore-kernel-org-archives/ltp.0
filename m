From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 13 Aug 2020 13:24:12 +0800
Subject: [LTP] [PATCH v3] syscalls/msgget04: Add test for
 /proc/sys/kernel/msg_next_id
Message-ID: <1597296252-4978-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v2->v3:
1.use SAFE_MSGGET Macro
2.add kconfig check
3.Remove resetting value in cleanup because only successful msgget can
reset value to -1, we only set value from[0,int_max]
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/msgget/.gitignore     |  1 +
 .../kernel/syscalls/ipc/msgget/msgget04.c     | 63 +++++++++++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/msgget/msgget04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 98d79271d..41cd8a159 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -810,6 +810,7 @@ msgctl12 msgctl12
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
+msgget04 msgget04
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 41d54d939..d4baaa262 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -12,6 +12,7 @@ msgctl12 msgctl12
 msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
+msgget04 msgget04
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/testcases/kernel/syscalls/ipc/msgget/.gitignore b/testcases/kernel/syscalls/ipc/msgget/.gitignore
index 3b2dfb518..7a9d5e340 100644
--- a/testcases/kernel/syscalls/ipc/msgget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgget/.gitignore
@@ -1,3 +1,4 @@
 /msgget01
 /msgget02
 /msgget03
+/msgget04
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
new file mode 100644
index 000000000..72cd4497b
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * It is a basic test about msg_next_id.
+ * msg_next_id specifies desired id for next allocated IPC message. By default
+ * they are equal to -1, which means generic allocation logic. Possible values
+ * to set are in range {0..INT_MAX}.
+ * Toggle with non-default value will be set back to -1 by kernel after
+ * successful IPC object allocation.
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+
+#define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
+static int queue_id, pid;
+static key_t msgkey;
+
+static void verify_msgget(void)
+{
+	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
+
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | MSG_RW);
+	if (queue_id == pid)
+		tst_res(TPASS, "msg_next_id succeeded, queue id %d", pid);
+	else
+		tst_res(TFAIL, "msg_next_id failed, expected id %d, but got %d", pid, queue_id);
+
+	TST_ASSERT_INT(NEXT_ID_PATH, -1);
+	SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+	pid++;
+}
+
+static void setup(void)
+{
+	msgkey = GETIPCKEY();
+	pid = getpid();
+}
+
+static void cleanup(void)
+{
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_msgget,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_CHECKPOINT_RESTORE=y",
+		NULL
+	},
+	.needs_root = 1,
+};
-- 
2.23.0



