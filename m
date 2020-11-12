From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 12 Nov 2020 14:48:43 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/ptrace02: Add another EPERM error test
In-Reply-To: <20201111150926.GA21539@yuki.lan>
References: <20201111150926.GA21539@yuki.lan>
Message-ID: <1605163724-20306-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/ptrace/.gitignore |  1 +
 testcases/kernel/syscalls/ptrace/ptrace02.c | 61 +++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3ddf70c54..aeacb8bc8 100644
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
index 000000000..cacaeeb96
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace02.c
@@ -0,0 +1,61 @@
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
+	int child_pid[2];
+
+	child_pid[0] = SAFE_FORK();
+	if (!child_pid[0])
+		pause();
+
+	child_pid[1] = SAFE_FORK();
+	if (!child_pid[1]) {
+		SAFE_SETUID(uid);
+		TEST(ptrace(PTRACE_ATTACH, child_pid[0], NULL, NULL));
+		if (TST_RET == 0) {
+			tst_res(TFAIL, "ptrace() succeeded unexpectedly");
+			exit(0);
+		}
+		if (TST_ERR == EPERM)
+			tst_res(TPASS | TTERRNO, "ptrace() failed as expected");
+		else
+			tst_res(TFAIL | TTERRNO, "ptrace() expected EPERM, but got");
+		exit(0);
+	}
+	SAFE_WAITPID(child_pid[1], NULL, 0);
+	SAFE_KILL(child_pid[0], SIGKILL);
+	SAFE_WAITPID(child_pid[0], NULL, 0);
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
+};
-- 
2.23.0



