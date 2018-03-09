From: Michael Moese <mmoese@suse.de>
Date: Fri,  9 Mar 2018 13:44:18 +0100
Subject: [LTP] [PATCH v6 3/3] Add regression test for CVE-2017-17053
In-Reply-To: <20180309124418.30271-1-mmoese@suse.de>
References: <20180309124418.30271-1-mmoese@suse.de>
Message-ID: <20180309124418.30271-4-mmoese@suse.de>
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
 testcases/cve/Makefile         |   2 +
 testcases/cve/cve-2017-17053.c | 166 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+)
 create mode 100644 testcases/cve/cve-2017-17053.c

diff --git a/runtest/cve b/runtest/cve
index 0c385c670..8c68ab496 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -30,3 +30,4 @@ cve-2017-17807 request_key04
 cve-2017-1000364 stack_clash
 cve-2017-5754 meltdown
 cve-2017-17052 cve-2017-17052
+cve-2017-17053 cve-2017-17053
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index c878069f1..c1ac83e3a 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -12,3 +12,4 @@ cve-2017-5669
 meltdown
 stack_clash
 cve-2017-17052
+cve-2017-17053
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 86100dbf2..3a05dd4fe 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -37,6 +37,8 @@ meltdown: CFLAGS += -msse2
 endif
 
 cve-2017-17052:	CFLAGS += -pthread
+cve-2017-17053:	CFLAGS += -pthread
+
 cve-2015-3290:	CFLAGS += -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2017-17053.c b/testcases/cve/cve-2017-17053.c
new file mode 100644
index 000000000..523ee53c3
--- /dev/null
+++ b/testcases/cve/cve-2017-17053.c
@@ -0,0 +1,166 @@
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
+#include <stdio.h>
+
+#include "tst_test.h"
+#include "tst_taint.h"
+#include "lapi/syscalls.h"
+
+#define EXEC_USEC   5000000
+
+/* this is basically identical to SAFE_PTHREAD_CREATE(), but is tolerating the
+ * call to fail whenn the error is EAGAIN or EWOULDBLOCK */
+static void try_pthread_create(pthread_t *thread_id, const pthread_attr_t *attr,
+			       void *(*thread_fn)(void *), void *arg)
+{
+	int rval;
+
+	rval = pthread_create(thread_id, attr, thread_fn, arg);
+
+	if (rval && rval != EAGAIN && rval != EWOULDBLOCK)
+		tst_brk(TBROK, "pthread_create(%p,%p,%p,%p) failed: %s",
+			thread_id, attr, thread_fn, arg, tst_strerrno(rval));
+}
+
+/* this is basically identical to SAFE_FORK(), but is tolerating the
+ * call to fail whenn the error is EAGAIN or EWOULDBLOCK */
+static int try_fork(void)
+{
+	pid_t pid;
+
+	tst_flush();
+
+	pid = fork();
+	if (pid < 0 && errno != EAGAIN && errno == EWOULDBLOCK)
+		tst_brk(TBROK | TERRNO, "fork() failed");
+
+	return pid;
+}
+
+
+
+struct shm_data {
+	volatile sig_atomic_t do_exit;
+	volatile sig_atomic_t segfaulted;
+};
+static struct shm_data *shm;
+
+static void handler(int sig)
+{
+	(void)sig;
+
+	shm->segfaulted = 1;
+	shm->do_exit = 1;
+}
+
+static void install_sighandler(void)
+{
+	struct sigaction sa;
+
+	sa.sa_flags = SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_handler = handler;
+
+	SAFE_SIGACTION(SIGSEGV, &sa, NULL);
+}
+
+static void setup(void)
+{
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
+	shm = SAFE_MMAP(NULL, sizeof(struct shm_data),
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(shm, sizeof(struct shm_data));
+}
+
+static void *fork_thread(void *arg)
+{
+	try_fork();
+	return arg;
+}
+
+void run_test(void)
+{
+	struct user_desc desc = { .entry_number = 8191 };
+
+	install_sighandler();
+	syscall(__NR_modify_ldt, 1, &desc, sizeof(desc));
+
+	for (;;) {
+		if (shm->do_exit)
+			exit(0);
+
+		if (try_fork() == 0) {
+			pthread_t t;
+
+			srand(getpid());
+			try_pthread_create(&t, NULL, fork_thread, NULL);
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
+	shm->do_exit = 0;
+	shm->segfaulted = 0;
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		run_test();
+	} else {
+		usleep(EXEC_USEC);
+		shm->do_exit = 1;
+	}
+
+	SAFE_WAIT(&status);
+
+	if (WIFEXITED(status) && shm->segfaulted == 0 && tst_taint_check() == 0)
+		tst_res(TPASS, "kernel survived");
+	else
+		tst_res(TFAIL, "kernel is vulnerable");
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

