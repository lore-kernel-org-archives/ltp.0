From: Michael Moese <mmoese@suse.de>
Date: Mon, 12 Feb 2018 11:03:41 +0100
Subject: [LTP] [PATCH v4 3/3] Add regression test for CVE-2017-17053
In-Reply-To: <20180212100341.23841-1-mmoese@suse.de>
References: <20180212100341.23841-1-mmoese@suse.de>
Message-ID: <20180212100341.23841-4-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds a regression test for CVE-2017-17053, based on the
reproducer in the message of this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccd5b3235180eef3cfec337df1c8554ab151b5cc

Be warned, if the running kernel is vulnerable to this CVE, it will die in
most cases.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/Makefile         |   1 +
 testcases/cve/cve-2017-17053.c | 132 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 testcases/cve/cve-2017-17053.c

diff --git a/runtest/cve b/runtest/cve
index 6de2ed0ac..6efffc668 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -29,3 +29,4 @@ cve-2017-17807 request_key04
 cve-2017-1000364 stack_clash
 cve-2017-5754 meltdown
 cve-2017-17052 cve-2017-17052
+cve-2017-17053 cve-2017-17053
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 42f32e825..5ecaaeb76 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -11,3 +11,4 @@ cve-2017-5669
 meltdown
 stack_clash
 cve-2017-17052
+cve-2017-17053
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 38ce27c93..00fbc1050 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -37,5 +37,6 @@ meltdown: CFLAGS += -msse2
 endif
 
 cve-2017-17052:	CFLAGS += -pthread
+cve-2017-17053:	CFLAGS += -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
new file mode 100644
index 000000000..806246259
--- /dev/null
+++ b/testcases/cve/cve-2017-17053.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2018 Michael Moese <mmoese@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/* Regression test for CVE-2017-17053, original reproducer can be found
+ * here:
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccd5b3235180eef3cfec337df1c8554ab151b5cc
+ *
+ * Be careful! This test may crash your kernel!
+ */
+
+#include <asm/ldt.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "tst_safe_pthread.h"
+#include "lapi/syscalls.h"
+
+#define EXEC_USEC   5000000
+
+static volatile sig_atomic_t *do_exit;
+
+static void handler(int sig, siginfo_t *si, void *unused)
+{
+	(void)(sig);
+	(void)(si);
+	(void)(unused);
+
+	*do_exit = -1;
+}
+
+static void install_sighandler(void)
+{
+	struct sigaction sa;
+
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_sigaction = handler;
+
+	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
+}
+
+static void setup(void)
+{
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
+	do_exit = SAFE_MMAP(NULL, sizeof(*do_exit), PROT_READ | PROT_WRITE,
+			    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	*do_exit = 0;
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(do_exit, sizeof(*do_exit));
+}
+
+static void *fork_thread(void *arg)
+{
+	SAFE_FORK();
+	return arg;
+}
+
+
+void run_test(void)
+{
+	struct user_desc desc = { .entry_number = 8191 };
+	install_sighandler();
+
+	syscall(__NR_modify_ldt, 1, &desc, sizeof(desc));
+
+	for (;;) {
+		if (*do_exit)
+			exit(0);
+
+		if (SAFE_FORK() == 0) {
+			pthread_t t;
+
+			srand(getpid());
+			SAFE_PTHREAD_CREATE(&t, NULL, fork_thread, NULL);
+			usleep(rand() % 10000);
+			syscall(__NR_exit_group, 0);
+		}
+	}
+}
+
+void run(void)
+{
+	int status;
+	pid_t pid;
+
+	*do_exit = 0;
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		run_test();
+	} else {
+		usleep(EXEC_USEC);
+		*do_exit = 1;
+	}
+
+	SAFE_WAIT(&status);
+	if ((*do_exit == -1) || !WIFEXITED(status) || (tst_taint_check() != 0))
+		tst_res(TFAIL, "kernel is vulnerable");
+	else
+		tst_res(TPASS, "kernel survived");
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.13.6

