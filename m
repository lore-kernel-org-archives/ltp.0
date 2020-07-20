From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 15:30:27 +0800
Subject: [LTP] [PATCH v1 3/3] syscalls/msgrcv09: Add error test for MSG_COPY
 flag
In-Reply-To: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1595230227-21468-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The MSG_COPY flag was added in 3.8 for the implementation of the kernel
checkpoint-restore facility and is available only if the kernel was
built with the CONFIG_CHECKPOINT_RESTORE option.

On old kernel without this support, it only ignores this flag and doesn't
report ENOSYS/EINVAL error, so I add kconfig and min_kver check.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/msg.h                            | 15 +++
 runtest/syscalls                              |  1 +
 runtest/syscalls-ipc                          |  1 +
 .../kernel/syscalls/ipc/msgrcv/.gitignore     |  1 +
 .../kernel/syscalls/ipc/msgrcv/msgrcv09.c     | 93 +++++++++++++++++++
 5 files changed, 111 insertions(+)
 create mode 100644 include/lapi/msg.h
 create mode 100644 testcases/kernel/syscalls/ipc/msgrcv/msgrcv09.c

diff --git a/include/lapi/msg.h b/include/lapi/msg.h
new file mode 100644
index 000000000..d649f3318
--- /dev/null
+++ b/include/lapi/msg.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+#ifndef LAPI_MSG_H
+#define LAPI_MSG_H
+
+#include <sys/msg.h>
+
+#ifndef MSG_COPY
+# define MSG_COPY  040000  /* copy (not remove) all queue messages */
+#endif
+
+#endif
diff --git a/runtest/syscalls b/runtest/syscalls
index 9d3808d66..9d927935b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -815,6 +815,7 @@ msgrcv05 msgrcv05
 msgrcv06 msgrcv06
 msgrcv07 msgrcv07
 msgrcv08 msgrcv08
+msgrcv09 msgrcv09
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 61743be01..153e827cf 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -19,6 +19,7 @@ msgrcv05 msgrcv05
 msgrcv06 msgrcv06
 msgrcv07 msgrcv07
 msgrcv08 msgrcv08
+msgrcv09 msgrcv09
 
 msgsnd01 msgsnd01
 msgsnd02 msgsnd02
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/.gitignore b/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
index 0596ee00f..359f8adfa 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgrcv/.gitignore
@@ -4,3 +4,4 @@
 /msgrcv06
 /msgrcv07
 /msgrcv08
+/msgrcv09
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv09.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv09.c
new file mode 100644
index 000000000..99f9a851b
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv09.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
+ *
+ * This is a basic test about MSG_COPY flag.
+ *
+ * 1)msgrcv(2) fails and sets errno to EINVAL if IPC_NOWAIT was not specified
+ *   in msgflag.
+ * 2)msgrcv(2) fails and sets errno to EINVAL if IPC_EXCEPT was specified
+ *   in msgflag.
+ * 3)msgrcv(2) fails and set errno to ENOMSG if IPC_NOWAIT and MSG_COPY were
+ *  specified in msgflg and the queue contains less than msgtyp messages.
+ */
+#define  _GNU_SOURCE
+#include <string.h>
+#include <sys/wait.h>
+#include <sys/msg.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
+#include "lapi/msg.h"
+
+static key_t msgkey;
+static int queue_id = -1;
+static struct buf {
+	long type;
+	char mtext[MSGSIZE];
+} rcv_buf, snd_buf = {MSGTYPE, "hello"};
+
+static struct tcase {
+	int exp_err;
+	int msg_flag;
+	int msg_type;
+	char *message;
+} tcases[] = {
+	{EINVAL, 0, MSGTYPE,
+	"Test EINVAL error when msgflg specified MSG_COPY, but not IPC_NOWAIT"},
+
+	{EINVAL, MSG_EXCEPT, MSGTYPE,
+	"Test EINVAL error when msgflg specified both MSG_COPY and MSG_EXCEPT"},
+
+	{ENOMSG, IPC_NOWAIT, 2,
+	"Test ENOMSG error when using IPC_NOWAIT and MSG_COPY but not have"
+	" corresponding msgtype msg"},
+};
+
+static void verify_msgrcv(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->message);
+	TEST(msgrcv(queue_id, &rcv_buf, MSGSIZE, tc->msg_type, MSG_COPY | tc->msg_flag));
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "smgrcv() succeeded unexpectedly");
+		SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
+		return;
+	}
+
+	if (TST_ERR == tc->exp_err)
+		tst_res(TPASS | TTERRNO, "msgrcv() failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "msgrcv() failed unexpectedly,"
+			" expected %s but got", tst_strerrno(tc->exp_err));
+}
+
+static void setup(void)
+{
+	msgkey = GETIPCKEY();
+	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
+	SAFE_MSGSND(queue_id, &snd_buf, MSGSIZE, 0);
+}
+
+static void cleanup(void)
+{
+	if (queue_id != -1)
+		SAFE_MSGCTL(queue_id, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_CHECKPOINT_RESTORE",
+		NULL
+	},
+	.min_kver = "3.8.0",
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_msgrcv,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.23.0



