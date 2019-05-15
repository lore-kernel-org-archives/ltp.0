From: Christian Amann <camann@suse.com>
Date: Wed, 15 May 2019 14:01:15 +0200
Subject: [LTP] [PATCH v1 3/4] syscalls/pidfd_send_signal02
In-Reply-To: <20190515120116.11589-1-camann@suse.com>
References: <20190515120116.11589-1-camann@suse.com>
Message-ID: <20190515120116.11589-3-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add test to check basic error handling of the syscall.

Signed-off-by: Christian Amann <camann@suse.com>
---
 runtest/syscalls                                   |   1 +
 .../kernel/syscalls/pidfd_send_signal/.gitignore   |   1 +
 .../pidfd_send_signal/pidfd_send_signal02.c        | 104 +++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c719b77b2..fd57e2ee7 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -839,6 +839,7 @@ personality01 personality01
 personality02 personality02
 
 pidfd_send_signal01 pidfd_send_signal01
+pidfd_send_signal02 pidfd_send_signal02
 
 pipe01 pipe01
 pipe02 pipe02
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/.gitignore b/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
index 7ccbf2d80..6ea6401a8 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
+++ b/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
@@ -1 +1,2 @@
 /pidfd_send_signal01
+/pidfd_send_signal02
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
new file mode 100644
index 000000000..25e66a214
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+/*
+ * Tests basic error handling of the pidfd_send_signal
+ * system call.
+ *
+ * 1) Pass invalid flag value to syscall (value chosen
+ *    to be unlikely to collide with future extensions)
+ *    -> EINVAL
+ * 2) Pass a file descriptor that is corresponding to a
+ *    regular file instead of a pid directory
+ *    -> EBADF
+ * 3) Pass a signal that is different from the one used
+ *    to initialize the siginfo_t struct
+ *    -> EINVAL
+ * 4) Try to send signal to other process (init) with
+ *    missing privileges
+ *    -> EPERM
+ */
+
+#define _GNU_SOURCE
+
+#include <signal.h>
+#include "pwd.h"
+#include "tst_safe_pthread.h"
+#include "pidfd_send_signal.h"
+
+#define CORRECT_SIGNAL		SIGUSR1
+#define DIFFERENT_SIGNAL	SIGUSR2
+
+static siginfo_t info;
+static int pidfd;
+static int init_pidfd;
+static int dummyfd;
+
+static struct tcase {
+	int		*fd;
+	siginfo_t	*siginf;
+	int		signal;
+	int		flags;
+	int		exp_err;
+} tcases[] = {
+	{&pidfd, &info, CORRECT_SIGNAL, 99999, EINVAL},
+	{&dummyfd, &info, CORRECT_SIGNAL, 0, EBADF},
+	{&pidfd, &info, DIFFERENT_SIGNAL, 0, EINVAL},
+	{&init_pidfd, &info, CORRECT_SIGNAL, 0, EPERM},
+};
+
+static void verify_pidfd_send_signal(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TEST(tst_pidfd_send_signal(*tc->fd, tc->signal, tc->siginf, tc->flags));
+	if (tc->exp_err != TST_ERR) {
+		tst_res(TFAIL | TTERRNO,
+			"pidfd_send_signal() did not fail with %s but",
+			tst_strerrno(tc->exp_err));
+		return;
+	}
+
+	tst_res(TPASS,
+		"pidfd_send_signal() failed as expected!");
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pidfd = SAFE_OPEN("/proc/self", O_DIRECTORY | O_CLOEXEC);
+	init_pidfd = SAFE_OPEN("/proc/1", O_DIRECTORY | O_CLOEXEC);
+	dummyfd = SAFE_OPEN("dummy_file", O_RDWR | O_CREAT, 0664);
+
+	if (getuid() == 0) {
+		pw = SAFE_GETPWNAM("nobody");
+		SAFE_SETUID(pw->pw_uid);
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = CORRECT_SIGNAL;
+	info.si_code = SI_QUEUE;
+	info.si_pid = getpid();
+	info.si_uid = getuid();
+}
+
+static void cleanup(void)
+{
+	if (dummyfd > 0)
+		SAFE_CLOSE(dummyfd);
+	if (init_pidfd > 0)
+		SAFE_CLOSE(init_pidfd);
+	if (pidfd > 0)
+		SAFE_CLOSE(pidfd);
+}
+
+static struct tst_test test = {
+	.test = verify_pidfd_send_signal,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.16.4

