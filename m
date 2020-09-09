From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:03 +0300
Subject: [LTP] [PATCH 06/10] syscalls/fcntl: New test for F_NOTIFY (dnotify)
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-7-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that signal is delivered for both watching parent and watching subdir
when subdir metadata changes.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 runtest/syscalls                          |  2 +
 testcases/kernel/syscalls/fcntl/fcntl38.c | 96 +++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl38.c

diff --git a/runtest/syscalls b/runtest/syscalls
index dc0ca5626..376a2bc6b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -316,6 +316,8 @@ fcntl36 fcntl36
 fcntl36_64 fcntl36_64
 fcntl37 fcntl37
 fcntl37_64 fcntl37_64
+fcntl38 fcntl38
+fcntl38_64 fcntl38_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/fcntl/fcntl38.c b/testcases/kernel/syscalls/fcntl/fcntl38.c
new file mode 100644
index 000000000..6185d3209
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl38.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 CTERA Networks. All Rights Reserved.
+ *
+ * Started by Amir Goldstein <amir73il@gmail.com>
+ *
+ * DESCRIPTION
+ *     Check that dnotify event is reported to both parent and subdir
+ */
+
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "lapi/fcntl.h"
+
+#define	TEST_DIR	"test_dir"
+
+#define TEST_SIG SIGRTMIN+1
+
+static int parent_fd, subdir_fd;
+static int got_parent_event, got_subdir_event;
+
+static void dnotify_handler(int sig, siginfo_t *si, void *data __attribute__((unused)))
+{
+	if (si->si_fd == parent_fd)
+		got_parent_event = 1;
+	else if (si->si_fd == subdir_fd)
+		got_subdir_event = 1;
+	else
+		tst_brk(TBROK, "Got unexpected signal %d with si_fd %d", sig, si->si_fd);
+}
+
+static void setup_dnotify(int fd)
+{
+	struct sigaction act;
+
+	act.sa_sigaction = dnotify_handler;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	sigaction(TEST_SIG, &act, NULL);
+
+	TEST(fcntl(fd, F_SETSIG, TEST_SIG));
+	if (TST_RET != 0) {
+		tst_brk(TBROK, "F_SETSIG failed errno = %d : %s",
+			TST_ERR, strerror(TST_ERR));
+	}
+	TEST(fcntl(fd, F_NOTIFY, DN_ATTRIB|DN_MULTISHOT));
+	if (TST_RET != 0) {
+		tst_brk(TBROK, "F_NOTIFY failed errno = %d : %s",
+			TST_ERR, strerror(TST_ERR));
+	}
+}
+
+static void verify_dnotify(void)
+{
+	parent_fd = SAFE_OPEN(".", O_RDONLY);
+	subdir_fd = SAFE_OPEN(TEST_DIR, O_RDONLY);
+	/* Watch "." and its children for changes */
+	setup_dnotify(parent_fd);
+	/* Also watch subdir itself for changes */
+	setup_dnotify(subdir_fd);
+	/* Generate DN_ATTRIB event on subdir that should send a signal on both fds */
+	SAFE_CHMOD(TEST_DIR, 0755);
+	if (got_parent_event)
+		tst_res(TPASS, "Got event on parent as expected");
+	else
+		tst_res(TFAIL, "Missing event on parent");
+	if (got_subdir_event)
+		tst_res(TPASS, "Got event on subdir as expected");
+	else
+		tst_res(TFAIL, "Missing event on subdir");
+	SAFE_CLOSE(parent_fd);
+	SAFE_CLOSE(subdir_fd);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TEST_DIR, 00700);
+}
+
+static void cleanup(void)
+{
+	if (parent_fd > 0)
+		SAFE_CLOSE(parent_fd);
+	if (subdir_fd > 0)
+		SAFE_CLOSE(subdir_fd);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_dnotify,
+};
-- 
2.17.1

