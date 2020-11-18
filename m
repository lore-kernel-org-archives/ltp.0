From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 18 Nov 2020 16:49:05 +0530
Subject: [LTP] [PATCH] syscalls: select: Add test to verify clearing of fd
 sets
Message-ID: <4b831a20278083623bce96f9c4171b6cff9c4e46.1605698312.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds a test to check if fd sets are cleared by select() or not in
the event of a timeout when the read descriptor is empty or the write
descriptor is full.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/select/.gitignore |  1 +
 testcases/kernel/syscalls/select/select04.c | 82 +++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/select/select04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index aeacb8bc8312..a5363277f478 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1159,6 +1159,7 @@ sched_getattr02 sched_getattr02
 select01 select01
 select02 select02
 select03 select03
+select04 select04
 
 semctl01 semctl01
 semctl02 semctl02
diff --git a/testcases/kernel/syscalls/select/.gitignore b/testcases/kernel/syscalls/select/.gitignore
index b6bff2d4f961..9d64cb8b8a1b 100644
--- a/testcases/kernel/syscalls/select/.gitignore
+++ b/testcases/kernel/syscalls/select/.gitignore
@@ -1,3 +1,4 @@
 /select01
 /select02
 /select03
+/select04
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
new file mode 100644
index 000000000000..8106dea8b3dc
--- /dev/null
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Limited. All rights reserved.
+ * Author: Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * Test to check if fd sets are cleared by select() or not.
+ */
+
+#include <unistd.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include "select_var.h"
+
+static fd_set readfds_pipe, writefds_pipe;
+static int fd_empty[2], fd_full[2];
+
+static struct tcases {
+	int *fd;
+	fd_set *readfds;
+	fd_set *writefds;
+	char *desc;
+} tests[] = {
+	{&fd_empty[0], &readfds_pipe, NULL, "No data to read"},
+	{&fd_full[1], NULL, &writefds_pipe, "No space to write"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcases *tc = &tests[n];
+	struct timeval timeout;
+
+	timeout.tv_sec = 0;
+	timeout.tv_usec = 100000;
+
+	TEST(do_select(*tc->fd + 1, tc->readfds, tc->writefds, 0, &timeout));
+
+	if (TST_RET) {
+		tst_res(TFAIL, "%s: select() should have timed out", tc->desc);
+		return;
+	}
+
+	if ((tc->readfds && FD_ISSET(*tc->fd, tc->readfds)) ||
+	    (tc->writefds && FD_ISSET(*tc->fd, tc->writefds))) {
+		tst_res(TFAIL, "%s: select() didn't clear the fd set", tc->desc);
+		return;
+	}
+
+	tst_res(TPASS, "%s: select() cleared the fd set", tc->desc);
+}
+
+static void setup(void)
+{
+	int buf = 0;
+
+	select_info();
+
+	SAFE_PIPE(fd_empty);
+	FD_ZERO(&readfds_pipe);
+	FD_SET(fd_empty[0], &readfds_pipe);
+
+	SAFE_PIPE2(fd_full, O_NONBLOCK);
+	FD_ZERO(&writefds_pipe);
+	FD_SET(fd_full[1], &writefds_pipe);
+
+	/* Make the write buffer full for fd_full */
+	do {
+		TEST(write(fd_full[1], &buf, sizeof(buf)));
+	} while (TST_RET != -1);
+
+	if (TST_ERR != EAGAIN)
+		tst_res(TFAIL | TTERRNO, "write() failed with unexpected error");
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tests),
+	.test_variants = TEST_VARIANTS,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
-- 
2.25.0.rc1.19.g042ed3e048af

