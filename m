From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 14 Jan 2020 16:40:57 +0800
Subject: [LTP] [PATCH v3] syscalls/pipe12: add new test for pipe when write
 bytes > pipe size
In-Reply-To: <20200110133746.GB14140@rei.lan>
References: <20200110133746.GB14140@rei.lan>
Message-ID: <1578991257-30810-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A pipe has a limited capacity. If the pipe with non block mode is full,
then a write(2) will fail and get EAGAIN error. Otherwise, from 1 to
PIPE_BUF bytes may be written.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

---------------
v2->v3:
1)check write return value for align page-size write
2)use ioctl(fd, FIONREAD, &nbytes)
3)use SAFE_PIPE
---------------
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/pipe/.gitignore |   1 +
 testcases/kernel/syscalls/pipe/pipe12.c   | 113 ++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pipe/pipe12.c

diff --git a/runtest/syscalls b/runtest/syscalls
index fa87ef63f..92a9ae636 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -861,6 +861,7 @@ pipe08 pipe08
 pipe09 pipe09
 pipe10 pipe10
 pipe11 pipe11
+pipe12 pipe12
 
 pipe2_01 pipe2_01
 pipe2_02 pipe2_02
diff --git a/testcases/kernel/syscalls/pipe/.gitignore b/testcases/kernel/syscalls/pipe/.gitignore
index ee2974ca8..90b502547 100644
--- a/testcases/kernel/syscalls/pipe/.gitignore
+++ b/testcases/kernel/syscalls/pipe/.gitignore
@@ -9,3 +9,4 @@
 /pipe09
 /pipe10
 /pipe11
+/pipe12
diff --git a/testcases/kernel/syscalls/pipe/pipe12.c b/testcases/kernel/syscalls/pipe/pipe12.c
new file mode 100644
index 000000000..ac17fb0a4
--- /dev/null
+++ b/testcases/kernel/syscalls/pipe/pipe12.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ *
+ * Test Description:
+ * A pipe has a limited capacity. If the pipe with non block mode is full,
+ * then a write(2) will fail and get EAGAIN error. Otherwise, from 1 to
+ * PIPE_BUF bytes may be written.
+ */
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+
+static int fds[2];
+static char *wrbuf;
+static char *rdbuf;
+static ssize_t max_size, invalid_size;
+
+static struct tcase {
+	int full_flag;
+	int offset;
+	char *message;
+	int check_flag;
+} tcases[] = {
+	{1, 0, "Write to full pipe", 1},
+	/*
+	 * For a non-empty(unaligned page size) pipe, the sequent large size
+	 * write(>page_size)will use new pages. So it may exist a hole in
+	 * page and we print this value instead of checking it.
+	 */
+	{0, 1, "Write to non-empty pipe", 0},
+	{0, 0, "Write to empty pipe", 1},
+};
+
+static void verify_pipe(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int nbytes;
+
+	memset(rdbuf, 0, max_size);
+
+	tst_res(TINFO, "%s", tc->message);
+	if (tc->full_flag) {
+		SAFE_WRITE(1, fds[1], wrbuf, max_size);
+		TEST(write(fds[1], "x", 1));
+		if (TST_RET != -1) {
+			tst_res(TFAIL, "write succeeded unexpectedly");
+			goto clean_pipe_buf;
+		}
+		if (TST_ERR == EAGAIN)
+			tst_res(TPASS | TTERRNO, "write failed as expected");
+		else
+			tst_res(TFAIL | TTERRNO, "write failed, expected EAGAIN but got");
+	} else {
+		SAFE_WRITE(1, fds[1], "x", tc->offset);
+		TEST(write(fds[1], wrbuf, invalid_size));
+		if (TST_RET == -1) {
+			tst_res(TFAIL, "write failed unexpectedly");
+			goto clean_pipe_buf;
+		}
+		tst_res(TPASS, "write succeeded as expectedly");
+	}
+	SAFE_IOCTL(fds[1], FIONREAD, &nbytes);
+	if (tc->check_flag) {
+		if (nbytes == max_size - tc->offset)
+			tst_res(TPASS, "write %d bytes", nbytes);
+		else
+			tst_res(TFAIL, "write expected %ld bytes, got %d bytes",
+					max_size, nbytes);
+	} else
+		tst_res(TPASS, "write %d bytes", nbytes);
+
+clean_pipe_buf:
+	SAFE_READ(0, fds[0], rdbuf, max_size);
+}
+
+
+static void cleanup(void)
+{
+	if (fds[0] > 0)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > 0)
+		SAFE_CLOSE(fds[1]);
+	if (wrbuf)
+		free(wrbuf);
+	if (rdbuf)
+		free(rdbuf);
+}
+
+static void setup(void)
+{
+	SAFE_PIPE(fds);
+
+	max_size = SAFE_FCNTL(fds[1], F_GETPIPE_SZ);
+	invalid_size = max_size + 4096;
+	wrbuf = SAFE_MALLOC(invalid_size);
+	rdbuf = SAFE_MALLOC(max_size);
+	memset(wrbuf, 'x', invalid_size);
+
+	SAFE_FCNTL(fds[1], F_SETFL, O_NONBLOCK);
+	SAFE_FCNTL(fds[0], F_SETFL, O_NONBLOCK);
+}
+
+static struct tst_test test = {
+	.test = verify_pipe,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.18.0



