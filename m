From: Michael Moese <mmoese@suse.de>
Date: Wed, 10 Jan 2018 16:55:05 +0100
Subject: [LTP] [PATCH v2] Add regression test for CVE-2017-17052
Message-ID: <20180110155505.28433-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

original reproducer can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b7e8665b4ff51c034c55df3cff76518d1a9ee3a
---
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/Makefile         |   2 +
 testcases/cve/cve-2017-17052.c | 156 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+)
 create mode 100644 testcases/cve/cve-2017-17052.c

diff --git a/runtest/cve b/runtest/cve
index 2873df906..2d93f3fe2 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -26,3 +26,4 @@ cve-2017-15299 request_key03 -b cve-2017-15299
 cve-2017-15537 ptrace07
 cve-2017-15951 request_key03 -b cve-2017-15951
 cve-2017-1000364 stack_clash
+cve-2017-17052 cve-2017-17052
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index f76c39826..b0439c4f2 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -9,3 +9,4 @@ cve-2017-2671
 cve-2017-6951
 cve-2017-5669
 stack_clash
+cve-2017-17052
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 0905fd95c..22dca3b3f 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -30,4 +30,6 @@ cve-2014-0196:  LDLIBS += -lrt -lutil
 cve-2017-2671:	CFLAGS += -pthread
 cve-2017-2671:	LDLIBS += -lrt
 
+cve-2017-17052:	CFLAGS += -pthread
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2017-17052.c b/testcases/cve/cve-2017-17052.c
new file mode 100644
index 000000000..a09c85727
--- /dev/null
+++ b/testcases/cve/cve-2017-17052.c
@@ -0,0 +1,156 @@
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
+ */
+
+#include <unistd.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/shm.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_safe_pthread.h"
+#include "tst_safe_sysv_ipc.h"
+#include "lapi/syscalls.h"
+
+#define RUNS	   4
+#define EXEC_USEC  400000
+
+static int shm_id;
+static key_t shm_key;
+
+struct my_shm_data {
+	int exit;
+};
+
+static struct my_shm_data *shm;
+
+static void setup(void)
+{
+	int length;
+	char fullpath[PATH_MAX];
+	int res;
+
+	length = SAFE_READLINK("/proc/self/exe", fullpath, sizeof(fullpath));
+	if (length < 0)
+		tst_brk(TBROK, "error resolving symlink /proc/self/exe.");
+
+	fullpath[length] = '\0';
+	shm_key = ftok(fullpath, 201717052);
+
+	shm_id = SAFE_SHMGET(shm_key,
+			sizeof(struct my_shm_data),
+			IPC_CREAT | 0666);
+	if (shm_id == -1)
+		tst_brk(TBROK, "shmget failed with errno %d", errno);
+
+
+	shm = SAFE_SHMAT(shm_id, 0,0);
+	if (shm == (void*)-1)
+		tst_brk(TBROK, "Unable to attach shared memory");
+
+	shm->exit = 0;
+}
+
+static void cleanup(void)
+{
+	SAFE_SHMCTL(shm_id, IPC_RMID, 0);
+	SAFE_SHMDT(shm);
+}
+
+static void *mmap_thread(void *_arg)
+{
+	for (;;) {
+		SAFE_MMAP(NULL, 0x1000000, PROT_READ,
+				MAP_POPULATE|MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	}
+}
+
+static void *fork_thread(void *_arg)
+{
+	if (shm->exit) {
+		SAFE_SHMDT(shm);
+		exit(0);
+	}
+
+	usleep(rand() % 10000);
+	SAFE_FORK();
+}
+
+static void do_test_fork(void)
+{
+	volatile int i;
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
+	int status;
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

