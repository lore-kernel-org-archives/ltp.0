From: Michael Moese <mmoese@suse.de>
Date: Fri, 12 Jan 2018 12:59:52 +0100
Subject: [LTP] [PATCH v3] Add regression test for CVE-2017-17052
Message-ID: <20180112115952.9287-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

original reproducer can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b7e8665b4ff51c034c55df3cff76518d1a9ee3a

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/Makefile         |   2 +
 testcases/cve/cve-2017-17052.c | 129 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)
 create mode 100644 testcases/cve/cve-2017-17052.c

diff --git a/runtest/cve b/runtest/cve
index 5d124083e..529d832a9 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -27,3 +27,4 @@ cve-2017-15537 ptrace07
 cve-2017-15951 request_key03 -b cve-2017-15951
 cve-2017-1000364 stack_clash
 cve-2017-5754 meltdown
+cve-2017-17052 cve-2017-17052
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 2566dbd18..42f32e825 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -10,3 +10,4 @@ cve-2017-6951
 cve-2017-5669
 meltdown
 stack_clash
+cve-2017-17052
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index a7df1e43c..38ce27c93 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -36,4 +36,6 @@ ifneq (,$(filter $(HOST_CPU),x86 x86_64))
 meltdown: CFLAGS += -msse2
 endif
 
+cve-2017-17052:	CFLAGS += -pthread
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2017-17052.c b/testcases/cve/cve-2017-17052.c
new file mode 100644
index 000000000..f0406e0a9
--- /dev/null
+++ b/testcases/cve/cve-2017-17052.c
@@ -0,0 +1,129 @@
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
+/*
+ * Test for CVE-2017-17052, original reproducer can be found here:
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b7e8665b4ff51c034c55df3cff76518d1a9ee3a
+ *
+ * CAUTION!!
+ * This test will crash unpatched kernels!
+ * Use at your own risk!
+ *
+ */
+
+#include <unistd.h>
+#include <pthread.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/syscalls.h"
+
+#define RUNS	   4
+#define EXEC_USEC  400000
+
+struct my_shm_data {
+	int exit;
+};
+static struct my_shm_data *shm;
+
+static void setup(void)
+{
+	shm = SAFE_MMAP(NULL, sizeof(struct my_shm_data), PROT_READ|PROT_WRITE,
+		    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	shm->exit = 0;
+}
+
+static void cleanup(void)
+{
+	SAFE_MUNMAP(shm, sizeof(struct my_shm_data));
+}
+
+static void *mmap_thread(void *_arg)
+{
+	for (;;) {
+		SAFE_MMAP(NULL, 0x1000000, PROT_READ,
+				MAP_POPULATE|MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+		if (shm->exit)
+			exit(0);
+	}
+}
+
+static void *fork_thread(void *_arg)
+{
+	if (shm->exit)
+		exit(0);
+
+	usleep(rand() % 10000);
+	SAFE_FORK();
+}
+
+static void do_test_fork(void)
+{
+	int status;
+
+	SAFE_FORK();
+	SAFE_FORK();
+	SAFE_FORK();
+
+	for(;;) {
+		if (SAFE_FORK() == 0) {
+			pthread_t t;
+
+			SAFE_PTHREAD_CREATE(&t, NULL, mmap_thread, NULL);
+			SAFE_PTHREAD_CREATE(&t, NULL, fork_thread, NULL);
+			usleep(rand() % 10000);
+			syscall(__NR_exit_group, 0);
+		}
+		SAFE_WAIT(&status);
+		if (shm->exit)
+			exit(0);
+	}
+}
+
+static void run(void)
+{
+	pid_t pid;
+	volatile int run = 0;
+
+	while (run < RUNS) {
+		pid = SAFE_FORK();
+
+		if (pid == 0) {
+			do_test_fork();
+		} else {
+			usleep(EXEC_USEC);
+			shm->exit = 1;
+		}
+		tst_res(TINFO, "run %d passed\n", run);
+		run++;
+	}
+
+	if (run == RUNS)
+		tst_res(TPASS, "kernel survived %d runs", run);
+	else
+		tst_res(TBROK, "something strange happened");
+}
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.cleanup = cleanup,
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.13.6

