From: Jorik Cronenberg <jcronenberg@suse.de>
Date: Fri, 24 Jan 2020 10:48:19 +0100
Subject: [LTP] [PATCH 2/2] syscalls/vmsplice: Add NONBLOCK testcase
In-Reply-To: <20200124094819.11710-1-jcronenberg@suse.de>
References: <20200124094819.11710-1-jcronenberg@suse.de>
Message-ID: <20200124094819.11710-2-jcronenberg@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a testcase for vmsplice() with the flag SPLICE_F_NONBLOCK.
And also test that vmsplice() blocks when writing to a full pipe
without the flag specified.

---
v2:
Made changes pointed out by Yang Xu:

Add the test to runtest/syscalls
Add "lapi/fcntl.h"
Add additional info to the test's output messages
Use guarded buffer for write_buffer
---

Signed-off-by: Jorik Cronenberg <jcronenberg@suse.de>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/vmsplice/.gitignore |  1 +
 .../kernel/syscalls/vmsplice/vmsplice04.c     | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 testcases/kernel/syscalls/vmsplice/vmsplice04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index f58fefe17..ec94c554d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1550,6 +1550,7 @@ vhangup02 vhangup02
 vmsplice01 vmsplice01
 vmsplice02 vmsplice02
 vmsplice03 vmsplice03
+vmsplice04 vmsplice04
 
 wait01 wait01
 wait02 wait02
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
index 000000000..0952d7caf
--- /dev/null
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice04.c
@@ -0,0 +1,89 @@
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
+#include "lapi/fcntl.h"
+#include <stdlib.h>
+
+
+static int pipes[2];
+static ssize_t pipe_max_size;
+static char *write_buffer;
+static struct iovec iov;
+
+static void vmsplice_test(void)
+{
+	int status;
+	int pid;
+
+	TEST(vmsplice(pipes[1], &iov, 1, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO,
+		    "Initial vmsplice() to fill pipe failed");
+
+	TEST(vmsplice(pipes[1], &iov, 1, SPLICE_F_NONBLOCK));
+	if (TST_RET < 0 && TST_ERR == EAGAIN)
+		tst_res(TPASS | TTERRNO,
+		    "vmsplice(... , SPLICE_F_NONBLOCK) failed as expected");
+	else if (TST_RET < 0)
+		tst_res(TFAIL | TTERRNO,
+		    "vmsplice(... , SPLICE_F_NONBLOCK) "
+		    "failed with unexpected errno");
+	else
+		tst_res(TFAIL,
+		    "vmsplice(... , SPLICE_F_NONBLOCK) wrote to a full pipe");
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TEST(vmsplice(pipes[1], &iov, 1, 0));
+		if (TST_RET < 0)
+			tst_res(TFAIL | TTERRNO, "vmsplice(... , 0) failed");
+		else
+			tst_res(TFAIL,
+			    "vmsplice(... , 0) wrote to a full pipe");
+		exit(0);
+	} else {
+		if (TST_PROCESS_STATE_WAIT(pid, 'S', 1000) < 0)
+			return;
+		else
+			tst_res(TPASS, "vmsplice(... , 0) blocked");
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
+}
+static void setup(void)
+{
+	SAFE_PIPE(pipes);
+
+	pipe_max_size = SAFE_FCNTL(pipes[1], F_GETPIPE_SZ);
+	write_buffer = tst_alloc(pipe_max_size);
+
+	iov.iov_base = write_buffer;
+	iov.iov_len = pipe_max_size;
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
2.25.0

