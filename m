From: Jorik Cronenberg <jcronenberg@suse.de>
Date: Wed, 22 Jan 2020 14:42:39 +0100
Subject: [LTP] [PATCH 2/2] syscalls/vmsplice: Add NONBLOCK testcase
In-Reply-To: <20200122134239.28844-1-jcronenberg@suse.de>
References: <20200122134239.28844-1-jcronenberg@suse.de>
Message-ID: <20200122134239.28844-2-jcronenberg@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a testcase for vmsplice() with the flag SPLICE_F_NONBLOCK.
And also test that vmsplice() blocks when writing to a full pipe
without the flag specified.

Signed-off-by: Jorik Cronenberg <jcronenberg@suse.de>
---
 testcases/kernel/syscalls/vmsplice/.gitignore |  1 +
 .../kernel/syscalls/vmsplice/vmsplice04.c     | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/vmsplice/vmsplice04.c

diff --git a/testcases/kernel/syscalls/vmsplice/.gitignore b/testcases/kernel/syscalls/vmsplice/.gitignore
index 03922073c..042c32585 100644
--- a/testcases/kernel/syscalls/vmsplice/.gitignore
+++ b/testcases/kernel/syscalls/vmsplice/.gitignore
@@ -1,3 +1,4 @@
 /vmsplice01
 /vmsplice02
 /vmsplice03
+/vmsplice04
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice04.c b/testcases/kernel/syscalls/vmsplice/vmsplice04.c
new file mode 100644
index 000000000..c49657d84
--- /dev/null
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice04.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Jorik Cronenberg <jcronenberg@suse.de>
+ *
+ * Test vmsplice() to a full pipe with SPLICE_F_NONBLOCK and without
+ * With SPLICE_F_NONBLOCK vmsplice() should return with errno EAGAIN
+ * Without SPLICE_F_NONBLOCK it should block
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/vmsplice.h"
+#include <stdlib.h>
+
+
+static int pipes[2];
+static ssize_t pipe_max_size;
+static char *write_buffer;
+
+static void vmsplice_test(void)
+{
+	int status;
+	struct iovec iov;
+	int pid;
+
+	iov.iov_base = write_buffer;
+	iov.iov_len = pipe_max_size;
+
+
+	TEST(vmsplice(pipes[1], &iov, 1, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO,
+		    "Initial vmsplice() to fill pipe failed");
+
+	TEST(vmsplice(pipes[1], &iov, 1, SPLICE_F_NONBLOCK));
+	if (TST_RET < 0 && TST_ERR == EAGAIN)
+		tst_res(TPASS | TTERRNO, "vmsplice failed as expected");
+	else if (TST_RET < 0)
+		tst_res(TFAIL | TTERRNO,
+		    "vmsplice failed with unexpected errno");
+	else
+		tst_res(TFAIL, "vmsplice wrote to a full pipe");
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TEST(vmsplice(pipes[1], &iov, 1, 0));
+		if (TST_RET < 0)
+			tst_res(TFAIL | TTERRNO, "vmsplice() failed");
+		else
+			tst_res(TFAIL, "vmsplice() wrote to a full pipe");
+		exit(0);
+	} else {
+		if (TST_PROCESS_STATE_WAIT2(pid, 'S', 1000) < 0)
+			return;
+		else
+			tst_res(TPASS, "vmsplice() blocked");
+		SAFE_KILL(pid, SIGKILL);
+		SAFE_WAIT(&status);
+	}
+
+}
+static void cleanup(void)
+{
+	if (pipes[1] > 0)
+		SAFE_CLOSE(pipes[1]);
+	if (pipes[0] > 0)
+		SAFE_CLOSE(pipes[0]);
+	if (write_buffer)
+		free(write_buffer);
+}
+static void setup(void)
+{
+	SAFE_PIPE(pipes);
+
+	pipe_max_size = SAFE_FCNTL(pipes[1], F_GETPIPE_SZ);
+	write_buffer = SAFE_MALLOC(pipe_max_size);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = vmsplice_test,
+	.min_kver = "2.6.17",
+	.forks_child = 1,
+};
-- 
2.24.1

