From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 13 Mar 2019 11:42:53 +0530
Subject: [LTP] [PATCH v2 3/3] syscalls/tgkill03: add new test
In-Reply-To: <1552457573-1354-1-git-send-email-sumit.garg@linaro.org>
References: <1552457573-1354-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1552457573-1354-4-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Greg Hackmann <ghackmann@google.com>

Test simple tgkill() error cases.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/tgkill/.gitignore |   1 +
 testcases/kernel/syscalls/tgkill/tgkill03.c | 122 ++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 testcases/kernel/syscalls/tgkill/tgkill03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1f4a2da..b92244d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1401,6 +1401,7 @@ syslog12 syslog12
 
 tgkill01 tgkill01
 tgkill02 tgkill02
+tgkill03 tgkill03
 
 time01 time01
 time02 time02
diff --git a/testcases/kernel/syscalls/tgkill/.gitignore b/testcases/kernel/syscalls/tgkill/.gitignore
index 42be2bb..a6d2299 100644
--- a/testcases/kernel/syscalls/tgkill/.gitignore
+++ b/testcases/kernel/syscalls/tgkill/.gitignore
@@ -1,2 +1,3 @@
 tgkill01
 tgkill02
+tgkill03
diff --git a/testcases/kernel/syscalls/tgkill/tgkill03.c b/testcases/kernel/syscalls/tgkill/tgkill03.c
new file mode 100644
index 0000000..3597d1b
--- /dev/null
+++ b/testcases/kernel/syscalls/tgkill/tgkill03.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Google, Inc.
+ *
+ * Test simple tgkill() error cases.
+ */
+
+#include <pthread.h>
+#include <pwd.h>
+#include <sys/types.h>
+
+#include "tst_safe_pthread.h"
+#include "tst_test.h"
+#include "tgkill.h"
+
+static pthread_t child_thread;
+
+static pid_t parent_tgid;
+static pid_t parent_tid;
+static pid_t child_tid;
+static pid_t defunct_tid;
+
+static const int invalid_pid = -1;
+
+static int test_running;
+static pthread_cond_t test_running_cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t test_running_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+static void *child_thread_func(void *arg)
+{
+	child_tid = sys_gettid();
+
+	TST_CHECKPOINT_WAKE(0);
+
+	pthread_mutex_lock(&test_running_mutex);
+	while (test_running)
+		pthread_cond_wait(&test_running_cond, &test_running_mutex);
+	pthread_mutex_unlock(&test_running_mutex);
+
+	return arg;
+}
+
+static void *defunct_thread_func(void *arg)
+{
+	defunct_tid = sys_gettid();
+
+	return arg;
+}
+
+static void setup(void)
+{
+	sigset_t sigusr1;
+	pthread_t defunct_thread;
+
+	sigemptyset(&sigusr1);
+	sigaddset(&sigusr1, SIGUSR1);
+	pthread_sigmask(SIG_BLOCK, &sigusr1, NULL);
+
+	parent_tgid = getpid();
+	parent_tid = sys_gettid();
+
+	test_running = 1;
+
+	SAFE_PTHREAD_CREATE(&child_thread, NULL, child_thread_func, NULL);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func, NULL);
+
+	SAFE_PTHREAD_JOIN(defunct_thread, NULL);
+}
+
+static void cleanup(void)
+{
+	test_running = 0;
+	pthread_cond_broadcast(&test_running_cond);
+
+	SAFE_PTHREAD_JOIN(child_thread, NULL);
+}
+
+static const struct testcase {
+	const char *desc;
+	const int *tgid;
+	const int *tid;
+	const int sig;
+	const int err;
+} testcases[] = {
+	{ "Invalid tgid", &invalid_pid, &parent_tid, SIGUSR1, EINVAL },
+	{ "Invalid tid", &parent_tgid, &invalid_pid, SIGUSR1, EINVAL },
+	{ "Invalid signal", &parent_tgid, &parent_tid, -1, EINVAL },
+	{ "Defunct thread ID", &parent_tgid, &defunct_tid, SIGUSR1, ESRCH },
+	{ "Valid tgkill call", &parent_tgid, &child_tid, SIGUSR1, 0 },
+};
+
+static void run(unsigned int i)
+{
+	const struct testcase *tc = &testcases[i];
+
+	TEST(sys_tgkill(*tc->tgid, *tc->tid, tc->sig));
+	if (tc->err) {
+		if (TST_RET < 0 && TST_ERR == tc->err)
+			tst_res(TPASS | TTERRNO, "%s failed as expected",
+				tc->desc);
+		else
+			tst_res(TFAIL | TTERRNO,
+				"%s should have failed with %s", tc->desc,
+				tst_strerrno(tc->err));
+	} else {
+		if (TST_RET == 0)
+			tst_res(TPASS, "%s succeeded", tc->desc);
+		else
+			tst_res(TFAIL | TTERRNO, "%s failed", tc->desc);
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(testcases),
+	.needs_checkpoints = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+};
-- 
2.7.4

