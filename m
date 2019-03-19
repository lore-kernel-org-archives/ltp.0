From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2019 12:19:40 +0530
Subject: [LTP] [PATCH v3 2/3] syscalls/tgkill02: add new test
In-Reply-To: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
References: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1552978181-27748-3-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Greg Hackmann <ghackmann@google.com>

tgkill() should fail with EAGAIN when RLIMIT_SIGPENDING is reached with
a real-time signal.  Test this by starting a child thread with SIGRTMIN
blocked and a limit of 0 pending signals, then attempting to deliver
SIGRTMIN from the parent thread.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/tgkill/.gitignore |  1 +
 testcases/kernel/syscalls/tgkill/tgkill02.c | 68 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d6999f0..7af9136 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1401,6 +1401,7 @@ syslog11 syslog11
 syslog12 syslog12
 
 tgkill01 tgkill01
+tgkill02 tgkill02
 
 time01 time01
 time02 time02
diff --git a/testcases/kernel/syscalls/tgkill/.gitignore b/testcases/kernel/syscalls/tgkill/.gitignore
index f4566fd..42be2bb 100644
--- a/testcases/kernel/syscalls/tgkill/.gitignore
+++ b/testcases/kernel/syscalls/tgkill/.gitignore
@@ -1 +1,2 @@
 tgkill01
+tgkill02
diff --git a/testcases/kernel/syscalls/tgkill/tgkill02.c b/testcases/kernel/syscalls/tgkill/tgkill02.c
new file mode 100644
index 0000000..88f3842
--- /dev/null
+++ b/testcases/kernel/syscalls/tgkill/tgkill02.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Google, Inc.
+ *
+ * tgkill() should fail with EAGAIN when RLIMIT_SIGPENDING is reached with a
+ * real-time signal.  Test this by starting a child thread with SIGRTMIN
+ * blocked and a limit of 0 pending signals, then attempting to deliver
+ * SIGRTMIN from the parent thread.
+ */
+
+#include <pthread.h>
+#include <signal.h>
+
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+#include "tgkill.h"
+
+static void *thread_func(void *arg)
+{
+	const struct rlimit sigpending = {
+		.rlim_cur = 0,
+		.rlim_max = 0,
+	};
+	sigset_t sigrtmin;
+	int err;
+	pid_t *tid = arg;
+
+	sigemptyset(&sigrtmin);
+	sigaddset(&sigrtmin, SIGRTMIN);
+
+	err = pthread_sigmask(SIG_BLOCK, &sigrtmin, NULL);
+	if (err)
+		tst_brk(TBROK, "pthread_sigmask() failed: %s",
+			tst_strerrno(err));
+
+	SAFE_SETRLIMIT(RLIMIT_SIGPENDING, &sigpending);
+	*tid = sys_gettid();
+
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	return arg;
+}
+
+static void run(void)
+{
+	pthread_t thread;
+	pid_t tid = -1;
+
+	SAFE_PTHREAD_CREATE(&thread, NULL, thread_func, &tid);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	TEST(sys_tgkill(getpid(), tid, SIGRTMIN));
+	if (TST_RET && TST_ERR == EAGAIN)
+		tst_res(TPASS, "tgkill() failed with EAGAIN as expected");
+	else
+		tst_res(TFAIL | TTERRNO,
+			"tgkill() should have failed with EAGAIN");
+
+	TST_CHECKPOINT_WAKE(0);
+
+	SAFE_PTHREAD_JOIN(thread, NULL);
+}
+
+static struct tst_test test = {
+	.needs_checkpoints = 1,
+	.test_all = run,
+};
-- 
2.7.4

