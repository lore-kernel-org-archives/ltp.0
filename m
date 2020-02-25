From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 25 Feb 2020 17:57:26 +0800
Subject: [LTP] [PATCH v2] syscalls/pipe13: Add regression test for pipe to
 wake up all readers
In-Reply-To: <20200224125802.GA30073@rei.lan>
References: <20200224125802.GA30073@rei.lan>
Message-ID: <1582624646-9283-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v1->v2:
1.use ltp library wake and wait api
2.remove useless var

 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/pipe/.gitignore |  1 +
 testcases/kernel/syscalls/pipe/pipe13.c   | 73 +++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pipe/pipe13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d2551b2ec..f51456b8f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -874,6 +874,7 @@ pipe09 pipe09
 pipe10 pipe10
 pipe11 pipe11
 pipe12 pipe12
+pipe13 pipe13
 
 pipe2_01 pipe2_01
 pipe2_02 pipe2_02
diff --git a/testcases/kernel/syscalls/pipe/.gitignore b/testcases/kernel/syscalls/pipe/.gitignore
index 90b502547..23e7186a6 100644
--- a/testcases/kernel/syscalls/pipe/.gitignore
+++ b/testcases/kernel/syscalls/pipe/.gitignore
@@ -10,3 +10,4 @@
 /pipe10
 /pipe11
 /pipe12
+/pipe13
diff --git a/testcases/kernel/syscalls/pipe/pipe13.c b/testcases/kernel/syscalls/pipe/pipe13.c
new file mode 100644
index 000000000..cd0d166a5
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe/pipe13.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Test Description:
+ * This is a case to test whether pipe can wakeup all readers
+ * when last writer closes.
+ *
+ * This bug was introduced by commit 0ddad21d3e99 ("pipe: use exclusive
+ * waits when reading or writing").
+ * This bug has been fixed by commit 6551d5c56eb0 ("pipe: make sure to
+ * wake up everybody when the last reader/writer closes").
+ */
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+static int fds[2];
+static int pid[2];
+static char buf;
+
+static void do_child(int i)
+{
+	SAFE_CLOSE(fds[1]);
+	TST_CHECKPOINT_WAKE(i);
+	SAFE_READ(0, fds[0], &buf, 1);
+	exit(0);
+}
+
+static void verify_pipe(void)
+{
+	int status;
+	int i;
+
+	SAFE_PIPE(fds);
+
+	for (i = 0; i < 2; i++) {
+		pid[i] = SAFE_FORK();
+		if (pid[i] == 0)
+			do_child(i);
+		TST_CHECKPOINT_WAIT(i);
+		TST_PROCESS_STATE_WAIT(pid[i], 'S', 0);
+	}
+
+	SAFE_CLOSE(fds[1]);
+
+	SAFE_WAITPID(pid[0], &status, 0);
+	TEST(waitpid(pid[1], &status, WNOHANG));
+	if (TST_RET != pid[1]) {
+		tst_res(TFAIL, "pipe doesn't waked up everybody when last write closes, "
+				"child %d existed", pid[1]);
+		goto out_kill;
+	}
+	tst_res(TPASS, "pipe has waked up everybody when last write close");
+	return;
+
+out_kill:
+	SAFE_KILL(pid[1], SIGKILL);
+	SAFE_WAIT(&status);
+}
+
+static struct tst_test test = {
+	.test_all = verify_pipe,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6551d5c56eb"},
+		{}
+	}
+};
-- 
2.18.0



