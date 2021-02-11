From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 11 Feb 2021 17:45:43 +0000
Subject: [LTP] [PATCH v2 5/5] close_range: Add test
In-Reply-To: <20210211174543.25003-1-rpalethorpe@suse.com>
References: <20210211174543.25003-1-rpalethorpe@suse.com>
Message-ID: <20210211174543.25003-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/syscalls/close_range/.gitignore    |   1 +
 .../kernel/syscalls/close_range/Makefile      |  10 +
 .../syscalls/close_range/close_range01.c      | 200 ++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 testcases/kernel/syscalls/close_range/.gitignore
 create mode 100644 testcases/kernel/syscalls/close_range/Makefile
 create mode 100644 testcases/kernel/syscalls/close_range/close_range01.c

diff --git a/testcases/kernel/syscalls/close_range/.gitignore b/testcases/kernel/syscalls/close_range/.gitignore
new file mode 100644
index 000000000..291a0379c
--- /dev/null
+++ b/testcases/kernel/syscalls/close_range/.gitignore
@@ -0,0 +1 @@
+close_range01
\ No newline at end of file
diff --git a/testcases/kernel/syscalls/close_range/Makefile b/testcases/kernel/syscalls/close_range/Makefile
new file mode 100644
index 000000000..dc6413b10
--- /dev/null
+++ b/testcases/kernel/syscalls/close_range/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019-2021 Linux Test Project
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
new file mode 100644
index 000000000..ed3f6b416
--- /dev/null
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Taken from the kernel self tests, which in turn were based on
+ * a Syzkaller reproducer.
+ *
+ * Self test author and close_range author:
+ * Christian Brauner <christian.brauner@ubuntu.com>
+ *
+ * LTP Author: Richard Palethorpe <rpalethorpe@suse.com>
+ * Copyright (c) 2021 SUSE LLC, other copyrights may apply.
+ *
+ * - First we test if close_range closes some FDs.
+ * - Then we test if it UNSHARES some FDs before closing them.
+ * - Then we test if it sets CLOEXEC (in both cloned process and parent).
+ * - Finally we test a combination of CLOEXEC and UNSHARE.
+ *
+ * The final test is the actual bug reproducer. Note that we call
+ * clone directly to share the file table.
+ */
+
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_clone.h"
+
+#include "lapi/clone.h"
+#include "lapi/close_range.h"
+
+static int fd[3];
+
+static inline void do_close_range(unsigned int fd, unsigned int max_fd,
+				  unsigned int flags)
+{
+	int ret = close_range(fd, max_fd, flags);
+
+	if (!ret)
+		return;
+
+	if (errno == EINVAL) {
+		if (flags & CLOSE_RANGE_UNSHARE)
+			tst_brk(TCONF | TERRNO, "No CLOSE_RANGE_UNSHARE");
+		if (flags & CLOSE_RANGE_CLOEXEC)
+			tst_brk(TCONF | TERRNO, "No CLOSE_RANGE_CLOEXEC");
+	}
+
+	tst_brk(TBROK | TERRNO, "close_range(%d, %d, %d)", fd, max_fd, flags);
+}
+
+static void setup(void)
+{
+	struct rlimit nfd;
+
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &nfd);
+
+	if (nfd.rlim_max < 1000) {
+		tst_brk(TCONF, "NOFILE limit max too low: %lu < 1000",
+			nfd.rlim_max);
+	}
+
+	nfd.rlim_cur = nfd.rlim_max;
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &nfd);
+}
+
+static void check_cloexec(int i, int expected)
+{
+	int present = SAFE_FCNTL(fd[i], F_GETFD) & FD_CLOEXEC;
+
+	if (expected && !present)
+		tst_res(TFAIL, "fd[%d] flags do not contain FD_CLOEXEC", i);
+
+	if (!expected && present)
+		tst_res(TFAIL, "fd[%d] flags contain FD_CLOEXEC", i);
+}
+
+static void check_closed(int min)
+{
+	int i;
+
+	for (i = min; i < 3; i++) {
+		if (fcntl(fd[i], F_GETFD) > -1)
+			tst_res(TFAIL, "fd[%d] is still open", i);
+	}
+}
+
+static void child(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		SAFE_DUP2(fd[1], fd[2]);
+		do_close_range(3, ~0U, 0);
+		check_closed(0);
+		break;
+	case 1:
+		SAFE_DUP2(fd[1], fd[2]);
+		do_close_range(3, ~0U, CLOSE_RANGE_UNSHARE);
+		check_closed(0);
+		break;
+	case 2:
+		do_close_range(3, ~0U, CLOSE_RANGE_CLOEXEC);
+		check_cloexec(0, 1);
+		check_cloexec(1, 1);
+
+		SAFE_DUP2(fd[1], fd[2]);
+		check_cloexec(2, 0);
+		break;
+	case 3:
+		do_close_range(3, ~0U,
+			       CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_UNSHARE);
+		check_cloexec(0, 1);
+		check_cloexec(1, 1);
+
+		SAFE_DUP2(fd[1], fd[2]);
+		check_cloexec(2, 0);
+		break;
+	}
+
+	exit(0);
+}
+
+static void run(unsigned int n)
+{
+	const struct tst_clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	switch (n) {
+	case 0:
+		tst_res(TINFO, "Plain close range");
+		do_close_range(3, ~0U, 0);
+		break;
+	case 1:
+		tst_res(TINFO, "Set UNSHARE and close range");
+		do_close_range(3, ~0U, CLOSE_RANGE_UNSHARE);
+		break;
+	case 2:
+		tst_res(TINFO, "Set CLOEXEC on range");
+		do_close_range(3, ~0U, CLOSE_RANGE_CLOEXEC);
+		break;
+	case 3:
+		tst_res(TINFO, "Set UNSHARE and CLOEXEC on range");
+		do_close_range(3, ~0U,
+			       CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_UNSHARE);
+		break;
+	}
+
+	fd[0] = SAFE_OPEN("mnt/tmpfile", O_RDWR | O_CREAT, 0644);
+	fd[1] = SAFE_DUP2(fd[0], 1000);
+	fd[2] = 42;
+
+	if (!SAFE_CLONE(&args))
+		child(n);
+
+	tst_reap_children();
+
+	switch (n) {
+	case 0:
+		check_closed(0);
+		break;
+	case 1:
+		check_cloexec(0, 0);
+		check_cloexec(1, 0);
+		check_cloexec(2, 0);
+		break;
+	case 2:
+		check_cloexec(0, 1);
+		check_cloexec(1, 1);
+		check_cloexec(2, 0);
+		break;
+	case 3:
+		check_cloexec(0, 0);
+		check_cloexec(1, 0);
+		check_closed(2);
+		break;
+	}
+
+	do_close_range(3, ~0U, 0);
+	check_closed(0);
+
+	if (tst_taint_check())
+		tst_res(TFAIL, "Kernel tainted");
+	else
+		tst_res(TPASS, "No kernel taints");
+}
+
+static struct tst_test test = {
+	.tcnt = 4,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.mount_device = 1,
+	.mntpoint = "mnt",
+	.all_filesystems = 1,
+	.test = run,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.setup = setup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "fec8a6a691033f2538cd46848f17f337f0739923"},
+		{},
+	},
+};
-- 
2.30.0

