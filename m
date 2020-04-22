From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 Apr 2020 18:45:28 +0800
Subject: [LTP] [PATCH v4 2/3] syscalls/pipe2_02: Add new test for pipe2
 O_CLOEXEC flag
In-Reply-To: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1587552329-21738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1587552329-21738-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/pipe2/.gitignore    |  1 +
 testcases/kernel/syscalls/pipe2/pipe2_02.c    | 67 +++++++++++++++++++
 .../kernel/syscalls/pipe2/pipe2_02_child.c    | 26 +++++++
 4 files changed, 95 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_02.c
 create mode 100644 testcases/kernel/syscalls/pipe2/pipe2_02_child.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6c240d375..9bb72beb2 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -915,6 +915,7 @@ pipe12 pipe12
 pipe13 pipe13
 
 pipe2_01 pipe2_01
+pipe2_02 pipe2_02
 pipe2_04 pipe2_04
 
 pivot_root01 pivot_root01
diff --git a/testcases/kernel/syscalls/pipe2/.gitignore b/testcases/kernel/syscalls/pipe2/.gitignore
index 14866e393..773450a48 100644
--- a/testcases/kernel/syscalls/pipe2/.gitignore
+++ b/testcases/kernel/syscalls/pipe2/.gitignore
@@ -1,2 +1,3 @@
 /pipe2_01
+/pipe2_02
 /pipe2_04
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02.c b/testcases/kernel/syscalls/pipe2/pipe2_02.c
new file mode 100644
index 000000000..e02857e38
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe2/pipe2_02.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * This case is designed to test the basic functionality about the
+ * O_CLOEXEC flag of pipe2.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "lapi/fcntl.h"
+#include "tst_test.h"
+
+#define TESTBIN "pipe2_02_child"
+static int fds[2];
+
+static void cleanup(void)
+{
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+}
+
+static void verify_pipe2(void)
+{
+	int pid, status;
+	char buf[20];
+
+	SAFE_PIPE2(fds, O_CLOEXEC);
+	sprintf(buf, "%d", fds[1]);
+	pid = SAFE_FORK();
+	if (pid == 0)
+		SAFE_EXECLP(TESTBIN, TESTBIN, buf, NULL);
+
+	SAFE_WAIT(&status);
+	if (WIFEXITED(status)) {
+		switch (WEXITSTATUS(status)) {
+		case 0:
+			tst_res(TPASS, "test O_CLOEXEC for pipe2 success");
+		break;
+		case 1:
+			tst_res(TFAIL, "test O_CLOEXEC for pipe2 failed");
+		break;
+		default:
+			tst_brk(TBROK, "execlp() failed");
+		}
+	} else {
+		tst_brk(TBROK, "%s exits with unexpected error", TESTBIN);
+	}
+	cleanup();
+}
+
+static const char *const resfile[] = {
+	TESTBIN,
+	NULL,
+};
+
+static struct tst_test test = {
+	.resource_files = resfile,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.needs_root = 1,
+	.test_all = verify_pipe2,
+};
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_02_child.c b/testcases/kernel/syscalls/pipe2/pipe2_02_child.c
new file mode 100644
index 000000000..fa0f881e9
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe2/pipe2_02_child.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+
+int main(int argc, char **argv)
+{
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "Only two arguments: %s <fd>\n", argv[0]);
+		exit(1);
+	}
+
+	fd = atoi(argv[1]);
+	if (fcntl(fd, F_GETFL) < 0 && errno == EBADF)
+		return 0;
+
+	return 1;
+}
-- 
2.23.0



