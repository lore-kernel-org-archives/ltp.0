From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 2 Nov 2020 19:43:29 +0800
Subject: [LTP] [PATCH 2/2] syscalls/ptrace02: Add another EPERM error test
Message-ID: <1604317409-22871-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/ptrace/.gitignore |  1 +
 testcases/kernel/syscalls/ptrace/ptrace02.c | 66 +++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 0dcd3d66d..a439267b2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -990,6 +990,7 @@ pselect03 pselect03
 pselect03_64 pselect03_64
 
 ptrace01 ptrace01
+ptrace02 ptrace02
 ptrace03 ptrace03
 ptrace04 ptrace04
 ptrace05 ptrace05
diff --git a/testcases/kernel/syscalls/ptrace/.gitignore b/testcases/kernel/syscalls/ptrace/.gitignore
index 7ee3b3c47..34be5148f 100644
--- a/testcases/kernel/syscalls/ptrace/.gitignore
+++ b/testcases/kernel/syscalls/ptrace/.gitignore
@@ -1,4 +1,5 @@
 /ptrace01
+/ptrace02
 /ptrace03
 /ptrace04
 /ptrace05
diff --git a/testcases/kernel/syscalls/ptrace/ptrace02.c b/testcases/kernel/syscalls/ptrace/ptrace02.c
new file mode 100644
index 000000000..b87529d90
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace02.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com
+ *
+ * ptrace() returns -1 and sets errno to EPERM if tracer doesn't have
+ * CAP_SYS_PTRACE capability for the process. Such as nobody user.
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <sys/wait.h>
+#include <pwd.h>
+#include <config.h>
+#include <stdlib.h>
+#include "ptrace.h"
+#include "tst_test.h"
+
+uid_t uid;
+
+static void verify_ptrace(void)
+{
+	int child_pid;
+
+	tst_res(TINFO, "Trace a process that don't have CAP_SYS_PTRACE capability(nobody user) for it");
+
+	child_pid = SAFE_FORK();
+	if (!child_pid)
+		pause();
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(uid);
+		TEST(ptrace(PTRACE_ATTACH, child_pid, NULL, NULL));
+		if (TST_RET == 0) {
+			tst_res(TFAIL, "ptrace() succeeded unexpectedly");
+			TST_CHECKPOINT_WAKE(0);
+			exit(0);
+		}
+		if (TST_ERR == EPERM)
+			tst_res(TPASS | TTERRNO, "ptrace() failed as expected");
+		else
+			tst_res(TFAIL | TTERRNO, "ptrace() expected EPERM, but got");
+		TST_CHECKPOINT_WAKE(0);
+		exit(0);
+	}
+	TST_CHECKPOINT_WAIT(0);
+	SAFE_KILL(child_pid, SIGKILL);
+	SAFE_WAITPID(child_pid, NULL, 0);
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	uid = pw->pw_uid;
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_ptrace,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.23.0



