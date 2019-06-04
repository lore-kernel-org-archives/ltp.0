From: Christian Amann <camann@suse.com>
Date: Tue,  4 Jun 2019 13:47:00 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/pidfd_send_signal01
Message-ID: <20190604114702.28255-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add testcase to check if pidfd_send_signal() can provide
the same functionality as rt_sigqueueinfo().

Signed-off-by: Christian Amann <camann@suse.com>
---
 configure.ac                                       |   2 +
 runtest/syscalls                                   |   2 +
 .../kernel/syscalls/pidfd_send_signal/.gitignore   |   1 +
 .../kernel/syscalls/pidfd_send_signal/Makefile     |  14 +++
 .../syscalls/pidfd_send_signal/pidfd_send_signal.h |  27 ++++++
 .../pidfd_send_signal/pidfd_send_signal01.c        | 108 +++++++++++++++++++++
 6 files changed, 154 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_send_signal/.gitignore
 create mode 100644 testcases/kernel/syscalls/pidfd_send_signal/Makefile
 create mode 100644 testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
 create mode 100644 testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c

diff --git a/configure.ac b/configure.ac
index 5a3dc5b62..b3e108306 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,6 +71,7 @@ AC_CHECK_FUNCS([ \
     mkdirat \
     mknodat \
     openat \
+    pidfd_send_signal \
     preadv \
     preadv2 \
     profil \
@@ -237,6 +238,7 @@ else
 fi
 AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no NUMA support])
 
+
 LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
diff --git a/runtest/syscalls b/runtest/syscalls
index 762b15b1f..bd71a12f8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -836,6 +836,8 @@ pause03 pause03
 personality01 personality01
 personality02 personality02
 
+pidfd_send_signal01 pidfd_send_signal01
+
 pipe01 pipe01
 pipe02 pipe02
 pipe03 pipe03
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/.gitignore b/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
new file mode 100644
index 000000000..7ccbf2d80
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_send_signal/.gitignore
@@ -0,0 +1 @@
+/pidfd_send_signal01
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/Makefile b/testcases/kernel/syscalls/pidfd_send_signal/Makefile
new file mode 100644
index 000000000..23e4ec478
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_send_signal/Makefile
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright (c) 2019 SUSE LLC
+#
+#   Author: Christian Amann <camann@suse.com>
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+pidfd_send_signal01: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
new file mode 100644
index 000000000..aa883c932
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+
+#ifndef PIDFD_SEND_SIGNAL_H
+#define PIDFD_SEND_SIGNAL_H
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+static void check_syscall_support(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_pidfd_send_signal);
+}
+
+#ifndef HAVE_PIDFD_SEND_SIGNAL
+static int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+				 unsigned int flags)
+{
+	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
+#endif /* HAVE_PIDFD_SEND_SIGNAL */
+
+#endif /* PIDFD_SEND_SIGNAL_H */
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
new file mode 100644
index 000000000..f44fce013
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC
+ * Author: Christian Amann <camann@suse.com>
+ */
+/*
+ * Tests if the pidfd_send_signal syscall behaves
+ * like rt_sigqueueinfo when a pointer to a siginfo_t
+ * struct is passed.
+ */
+
+#define _GNU_SOURCE
+
+#include <signal.h>
+#include <stdlib.h>
+#include "tst_safe_pthread.h"
+#include "pidfd_send_signal.h"
+
+#define SIGNAL  SIGUSR1
+#define DATA	777
+
+static struct sigaction *sig_action;
+static int sig_rec;
+static siginfo_t *uinfo;
+static int pidfd;
+
+static void received_signal(int sig, siginfo_t *info, void *ucontext)
+{
+	if (info && ucontext) {
+		if (sig == SIGNAL && uinfo->si_value.sival_int == DATA) {
+			tst_res(TPASS, "Received correct signal and data!");
+			sig_rec = 1;
+		} else {
+			tst_res(TFAIL, "Received wrong signal and/or data!");
+		}
+	} else {
+		tst_res(TFAIL, "Signal handling went wrong!");
+	}
+}
+
+static void *handle_thread(void *arg)
+{
+	SAFE_SIGACTION(SIGNAL, sig_action, NULL);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+	return arg;
+}
+
+static void verify_pidfd_send_signal(void)
+{
+	pthread_t thr;
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, handle_thread, NULL);
+
+	TST_CHECKPOINT_WAIT(0);
+
+	TEST(pidfd_send_signal(pidfd, SIGNAL, uinfo, 0));
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO, "pidfd_send_signal() failed");
+		return;
+	}
+
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_PTHREAD_JOIN(thr, NULL);
+
+	if (sig_rec) {
+		tst_res(TPASS,
+			"pidfd_send_signal() behaved like rt_sigqueueinfo()");
+	}
+}
+
+static void setup(void)
+{
+	check_syscall_support();
+
+	pidfd = SAFE_OPEN("/proc/self", O_DIRECTORY | O_CLOEXEC);
+
+	sig_action = SAFE_MALLOC(sizeof(struct sigaction));
+
+	memset(sig_action, 0, sizeof(*sig_action));
+	sig_action->sa_sigaction = received_signal;
+	sig_action->sa_flags = SA_SIGINFO;
+
+	uinfo = SAFE_MALLOC(sizeof(siginfo_t));
+
+	memset(uinfo, 0, sizeof(*uinfo));
+	uinfo->si_signo = SIGNAL;
+	uinfo->si_code = SI_QUEUE;
+	uinfo->si_pid = getpid();
+	uinfo->si_uid = getuid();
+	uinfo->si_value.sival_int = DATA;
+
+	sig_rec = 0;
+}
+
+static void cleanup(void)
+{
+	free(uinfo);
+	free(sig_action);
+	if (pidfd > 0)
+		SAFE_CLOSE(pidfd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_pidfd_send_signal,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_checkpoints = 1,
+};
-- 
2.16.4

