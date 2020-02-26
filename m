From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 26 Feb 2020 11:06:23 +0800
Subject: [LTP] [PATCH v3] syscalls/pipe13: Add regression test for pipe to
 wake up all readers
In-Reply-To: <20200225102850.GA5077@rei.lan>
References: <20200225102850.GA5077@rei.lan>
Message-ID: <1582686383-23299-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
v2->v3:
1.use Cyril's waitpid way and add his signed-off-by
2. change child num to 10, IMO, it is more meaningful than 2
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/pipe/.gitignore |  1 +
 testcases/kernel/syscalls/pipe/pipe13.c   | 87 +++++++++++++++++++++++
 3 files changed, 89 insertions(+)
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
index 000000000..cc3f9f55f
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe/pipe13.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Test Description:
+ * This case is designed to test whether pipe can wakeup all readers
+ * when last writer closes.
+ *
+ * This is also a regression test for commit 6551d5c56eb0
+ * ("pipe: make sure to wake up everybody when the last reader/writer closes").
+ * This bug was introduced by commit 0ddad21d3e99 ("pipe: use exclusive
+ * waits when reading or writing").
+ */
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define CHILD_NUM 10
+
+static int pid[CHILD_NUM];
+static int fds[2];
+static char buf;
+
+static void do_child(unsigned int i)
+{
+	SAFE_CLOSE(fds[1]);
+	TST_CHECKPOINT_WAKE(i);
+	SAFE_READ(0, fds[0], &buf, 1);
+	exit(0);
+}
+
+static void verify_pipe(void)
+{
+	int ret;
+	unsigned int i, cnt = 0, sleep_us = 1, fail = 0;
+
+	SAFE_PIPE(fds);
+	tst_res(TINFO, "Creating %d child processes", CHILD_NUM);
+	for (i = 0; i < CHILD_NUM; i++) {
+		pid[i] = SAFE_FORK();
+		if (pid[i] == 0)
+			do_child(i);
+		TST_CHECKPOINT_WAIT(i);
+		TST_PROCESS_STATE_WAIT(pid[i], 'S', 0);
+	}
+	SAFE_CLOSE(fds[1]);
+	while (cnt < CHILD_NUM && sleep_us < 100000) {
+		ret = waitpid(-1, NULL, WNOHANG);
+		if (ret < 0)
+			tst_brk(TBROK | TERRNO, "waitpid()");
+		if (ret > 0) {
+			cnt++;
+			for (i = 0; i < CHILD_NUM; i++) {
+				if (pid[i] == ret)
+					pid[i] = 0;
+			}
+			continue;
+		}
+		usleep(sleep_us);
+		sleep_us *= 2;
+	}
+	for (i = 0; i < CHILD_NUM; i++) {
+		if (pid[i]) {
+			tst_res(TINFO, "pid %i still sleeps", pid[i]);
+			fail = 1;
+			SAFE_KILL(pid[i], SIGKILL);
+			SAFE_WAIT(NULL);
+		}
+	}
+	if (fail)
+		tst_res(TFAIL, "Closed pipe didn't wake up everyone");
+	else
+		tst_res(TPASS, "Closed pipe waked up everyone");
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



