From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 13 Aug 2020 15:08:36 +0800
Subject: [LTP] [PATCH] syscalls/msgget05: Add test when the id of
 msg_next_id has existed
Message-ID: <1597302516-6495-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When message queue identifier that msg_next_id has existed, msgget() with
different key will return the another msg id. But kernel doesn't guarantee
desired id, I just compare with existed id, if not equal, the test succeeded.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/msgget/.gitignore     |  1 +
 .../kernel/syscalls/ipc/msgget/msgget05.c     | 68 +++++++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/msgget/msgget05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 41cd8a159..860c5c36d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -811,6 +811,7 @@ msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
 msgget04 msgget04
+msgget05 msgget05
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index d4baaa262..e6837414c 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -13,6 +13,7 @@ msgget01 msgget01
 msgget02 msgget02
 msgget03 msgget03
 msgget04 msgget04
+msgget05 msgget05
 
 msgrcv01 msgrcv01
 msgrcv02 msgrcv02
diff --git a/testcases/kernel/syscalls/ipc/msgget/.gitignore b/testcases/kernel/syscalls/ipc/msgget/.gitignore
index 7a9d5e340..3372016ea 100644
--- a/testcases/kernel/syscalls/ipc/msgget/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgget/.gitignore
@@ -2,3 +2,4 @@
 /msgget02
 /msgget03
 /msgget04
+/msgget05
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
new file mode 100644
index 000000000..e282d559c
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * It is a basic test about msg_next_id.
+ * When the message queue identifier that msg_next_id stored has existed,
+ * call msgget with different key just use another unused value in range
+ * [0,INT_MAX]. kernel doesn't guarantee the desired id.
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
+
+static int queue_id[2], pid;
+static key_t msgkey[2];
+
+static void verify_msgget(void)
+{
+	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", queue_id[0]);
+
+	queue_id[1] = SAFE_MSGGET(msgkey[1], IPC_CREAT | MSG_RW);
+	if (queue_id[1] == queue_id[0])
+		tst_res(TFAIL, "msg id %d has existed, msgget() returns the"
+			" same msg id unexpectedly", queue_id[0]);
+	else
+		tst_res(TPASS, "msg id %d has existed, msgget() returns the"
+			" new msgid %d", queue_id[0], queue_id[1]);
+
+	SAFE_MSGCTL(queue_id[1], IPC_RMID, NULL);
+}
+
+static void setup(void)
+{
+	msgkey[0] = GETIPCKEY();
+	msgkey[1] = GETIPCKEY();
+	pid = getpid();
+	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
+	queue_id[0] = SAFE_MSGGET(msgkey[0], IPC_CREAT | MSG_RW);
+	tst_res(TINFO, "Test msg_next_id effects on msgget(different key) "
+		"when this message queue identifier has existed");
+}
+
+static void cleanup(void)
+{
+	for (int i = 0; i < 2; i++)
+		if (queue_id[i] != -1)
+			SAFE_MSGCTL(queue_id[i], IPC_RMID, NULL);
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



