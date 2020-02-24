From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 24 Feb 2020 17:52:26 +0800
Subject: [LTP] [PATCH] syscalls/pipe13: Add regression test for pipe to wake
 up all readers
Message-ID: <1582537946-22098-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/pipe/.gitignore |  1 +
 testcases/kernel/syscalls/pipe/pipe13.c   | 64 +++++++++++++++++++++++
 3 files changed, 66 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pipe/pipe13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e42db9910..39d04a3a8 100644
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
index 000000000..c2a89ba02
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe/pipe13.c
@@ -0,0 +1,64 @@
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
+static void verify_pipe(void)
+{
+	int fds[2];
+	int status1, status2;
+	pid_t p1, p2;
+	int ret;
+
+	SAFE_PIPE(fds);
+
+	p1 = SAFE_FORK();
+	if (p1 == 0) {
+		SAFE_CLOSE(fds[1]);
+		SAFE_READ(0, fds[0], &status1, sizeof(status1));
+		exit(0);
+	}
+	p2 = SAFE_FORK();
+	if (p2 == 0) {
+		SAFE_CLOSE(fds[1]);
+		SAFE_READ(0, fds[0], &status2, sizeof(status2));
+		exit(0);
+	}
+
+	sleep(1);
+	SAFE_CLOSE(fds[1]);
+
+	SAFE_WAITPID(p1, &status1, 0);
+	ret = waitpid(p2, &status2, WNOHANG);
+	if (ret == p2) {
+		tst_res(TPASS, "pipe wakes up everybody when last write closes");
+	} else {
+		tst_res(TFAIL, "pipe doesn't wake up every body when last write closes");
+		SAFE_KILL(p2, SIGKILL);
+		SAFE_WAIT(&status2);
+	}
+}
+
+static struct tst_test test = {
+	.test_all = verify_pipe,
+	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6551d5c56eb"},
+		{}
+	}
+};
-- 
2.18.0



