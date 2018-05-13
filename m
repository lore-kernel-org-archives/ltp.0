From: Eric Biggers <ebiggers3@gmail.com>
Date: Sat, 12 May 2018 18:23:25 -0700
Subject: [LTP] [PATCH] syscalls/shmctl05: new test for IPC file
	use-after-free bug
Message-ID: <20180513012325.877-1-ebiggers3@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Eric Biggers <ebiggers@google.com>

Test for a bug in the System V IPC subsystem that resulted in a shared
memory file being used after it was freed (or being freed).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 .../kernel/syscalls/ipc/shmctl/.gitignore     |   1 +
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     | 113 ++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 97bda7e45..9d47a9336 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1188,6 +1188,7 @@ shmctl01 shmctl01
 shmctl02 shmctl02
 shmctl03 shmctl03
 shmctl04 shmctl04
+shmctl05 shmctl05
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index de32c6ba9..7c2c40beb 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -57,6 +57,7 @@ shmctl01 shmctl01
 shmctl02 shmctl02
 shmctl03 shmctl03
 shmctl04 shmctl04
+shmctl05 shmctl05
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/testcases/kernel/syscalls/ipc/shmctl/.gitignore b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
index 9f5ac37ff..d6777e3b8 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmctl/.gitignore
@@ -2,3 +2,4 @@
 /shmctl02
 /shmctl03
 /shmctl04
+/shmctl05
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
new file mode 100644
index 000000000..6771b1445
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright (c) 2018 Google, Inc.
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
+ * along with this program, if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Regression test for commit 3f05317d9889 ("ipc/shm: fix use-after-free of shm
+ * file via remap_file_pages()").  This bug allowed the remap_file_pages()
+ * syscall to use the file of a System V shared memory segment after its ID had
+ * been reallocated and the file freed.  This test reproduces the bug as a NULL
+ * pointer dereference in touch_atime(), although it's a race condition so it's
+ * not guaranteed to work.  This test is based on the reproducer provided in the
+ * fix's commit message.
+ */
+
+#include <stdbool.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_safe_sysv_ipc.h"
+#include "lapi/syscalls.h"
+
+static bool timed_out(void)
+{
+	tst_timer_stop();
+	return tst_timer_elapsed_ms() >= 5000;
+}
+
+static void do_test(void)
+{
+	pid_t pid;
+	int status;
+
+	/* Skip test if either remap_file_pages() or SysV IPC is unavailable */
+	tst_syscall(__NR_remap_file_pages, NULL, 0, 0, 0, 0);
+	tst_syscall(__NR_shmctl, 0xF00F, IPC_RMID, NULL);
+
+	tst_timer_start(CLOCK_MONOTONIC);
+
+	pid = SAFE_FORK();
+	srand(getpid());
+
+	if (pid == 0) {
+		/*
+		 * Child process: repeatedly attach a shm segment, then remap it
+		 * until the ID seems to have been removed by the other process.
+		 */
+		do {
+			int id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
+			void *addr = shmat(id, NULL, 0);
+
+			if (addr == (void *)-1L) {
+				if (errno == EIDRM || errno == EINVAL)
+					continue;
+				tst_brk(TBROK | TERRNO,
+					"Unexpected shmat() error");
+			}
+
+			usleep(rand() % 50);
+			do {
+				/* This is the system call that crashed */
+				TEST(syscall(__NR_remap_file_pages, addr, 4096,
+					     0, 0, 0));
+				if (TEST_RETURN == 0)
+					continue;
+				if (TEST_ERRNO == EIDRM || TEST_ERRNO == EINVAL)
+					break;
+				tst_brk(TBROK | TTERRNO,
+					"Unexpected remap_file_pages() error");
+			} while (!timed_out());
+		} while (!timed_out());
+		exit(0);
+	} else {
+		/*
+		 * Parent process: repeatedly remove the shm ID and reallocate
+		 * it again for a new shm segment.
+		 */
+		do {
+			int id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
+
+			usleep(rand() % 50);
+			SAFE_SHMCTL(id, IPC_RMID, NULL);
+		} while (!timed_out());
+	}
+
+	SAFE_WAIT(&status);
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		tst_res(TPASS, "no crash observed");
+	else if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
+		tst_res(TFAIL, "kernel oops observed");
+	else
+		tst_brk(TBROK, "Child %s", tst_strstatus(status));
+
+	shmctl(0xF00F, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.forks_child = 1,
+};
-- 
2.17.0

