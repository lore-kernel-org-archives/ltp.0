From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 17 Aug 2020 18:05:03 +0200
Subject: [LTP] [PATCH 2/2] Add test for CVE 2018-12896
In-Reply-To: <20200817160503.11381-1-mdoucha@suse.cz>
References: <20200817160503.11381-1-mdoucha@suse.cz>
Message-ID: <20200817160503.11381-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #353

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/cve                                   |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/timer_settime/.gitignore  |   1 +
 .../syscalls/timer_settime/timer_settime03.c  | 120 ++++++++++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/timer_settime/timer_settime03.c

diff --git a/runtest/cve b/runtest/cve
index a2ca8d27c..07c69e8ff 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -52,6 +52,7 @@ cve-2018-9568 connect02
 cve-2018-1000001 realpath01
 cve-2018-1000199 ptrace08
 cve-2018-1000204 ioctl_sg01
+cve-2018-12896 timer_settime03
 cve-2018-18445 bpf_prog04
 cve-2018-18559 bind06
 cve-2018-19854 crypto_user01
diff --git a/runtest/syscalls b/runtest/syscalls
index 860c5c36d..a589a84dd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1545,6 +1545,7 @@ timer_gettime01 timer_gettime01
 
 timer_settime01 timer_settime01
 timer_settime02 timer_settime02
+timer_settime03 timer_settime03
 
 tkill01 tkill01
 tkill02 tkill02
diff --git a/testcases/kernel/syscalls/timer_settime/.gitignore b/testcases/kernel/syscalls/timer_settime/.gitignore
index e1ed3ef17..2541a5b57 100644
--- a/testcases/kernel/syscalls/timer_settime/.gitignore
+++ b/testcases/kernel/syscalls/timer_settime/.gitignore
@@ -1,2 +1,3 @@
 /timer_settime01
 /timer_settime02
+/timer_settime03
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime03.c b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
new file mode 100644
index 000000000..68eff853b
--- /dev/null
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime03.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE 2018-12896
+ *
+ * Check for possible overflow of posix timer overrun counter. Create
+ * a CLOCK_REALTIME timer, set extremely low timer interval and expiration
+ * value just right to cause overrun overflow into negative values, start
+ * the timer with TIMER_ABSTIME flag to cause overruns immediately. Then just
+ * check the overrun counter in the timer signal handler. On a patched system,
+ * the value returned by timer_getoverrun() should be capped at INT_MAX and
+ * not allowed to overflow into negative range. Bug fixed in:
+ *
+ *  commit 78c9c4dfbf8c04883941445a195276bb4bb92c76
+ *  Author: Thomas Gleixner <tglx@linutronix.de>
+ *  Date:   Tue Jun 26 15:21:32 2018 +0200
+ *
+ *  posix-timers: Sanitize overrun handling
+ */
+
+#include <unistd.h>
+#include <signal.h>
+#include <time.h>
+#include <limits.h>
+
+#include "tst_test.h"
+#include "tst_safe_clocks.h"
+
+static timer_t timer;
+static volatile int handler_called;
+
+static void sighandler(int sig)
+{
+	struct itimerspec spec;
+
+	/*
+	 * Signal handler will be called twice in total because kernel will
+	 * schedule another pending signal before the timer gets disabled.
+	 */
+	if (handler_called)
+		return;
+
+	TEST(timer_getoverrun(timer));
+
+	memset(&spec, 0, sizeof(struct itimerspec));
+	SAFE_TIMER_SETTIME(timer, 0, &spec, NULL);
+	handler_called = 1;
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "Error reading timer overrun count");
+
+	if (TST_RET == INT_MAX) {
+		tst_res(TPASS, "Timer overrun count is capped");
+		return;
+	}
+
+	if (TST_RET < 0) {
+		tst_res(TFAIL, "Timer overrun counter overflow");
+		return;
+	}
+
+	tst_res(TFAIL, "Timer overrun counter is wrong: %ld; expected %d or "
+		"negative number", TST_RET, INT_MAX);
+}
+
+static void setup(void)
+{
+	struct sigevent sev;
+
+	memset(&sev, 0, sizeof(struct sigevent));
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = SIGUSR1;
+
+	SAFE_SIGNAL(SIGUSR1, sighandler);
+	SAFE_TIMER_CREATE(CLOCK_REALTIME, &sev, &timer);
+}
+
+static void run(void)
+{
+	int handler_delay = INT_MAX / 7;
+	long nsec;
+	struct itimerspec spec;
+
+	memset(&spec, 0, sizeof(struct itimerspec));
+	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &spec.it_value);
+	nsec = (handler_delay % 100000000) * 10L;
+
+	if (nsec > spec.it_value.tv_nsec) {
+		spec.it_value.tv_sec -= 1;
+		spec.it_value.tv_nsec += 1000000000;
+	}
+
+	/* spec.it_value = now - 1.4 * max overrun value */
+	/* IOW, overflow will land right in the middle of negative range */
+	spec.it_value.tv_sec -= handler_delay / 100000000;
+	spec.it_value.tv_nsec -= nsec;
+	spec.it_interval.tv_nsec = 1;
+
+	SAFE_TIMER_SETTIME(timer, TIMER_ABSTIME, &spec, NULL);
+	while (!handler_called);
+}
+
+static void cleanup(void)
+{
+	SAFE_TIMER_DELETE(timer);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "78c9c4dfbf8c"},
+		{"CVE", "2018-12896"},
+		{}
+	}
+};
-- 
2.27.0

