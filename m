From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 11 Jul 2018 09:55:47 -0700
Subject: [LTP] [PATCH v3] syscalls/shmctl05: new test for IPC file
	use-after-free bug
Message-ID: <20180711165547.175982-1-ebiggers3@gmail.com>
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

Changed since v2:
	- Add tst_timer_check(CLOCK_MONOTONIC).
	- Use 'CFLAGS += -pthread' instead of 'LDLIBS += -lpthread'.
	- Add 'LDLIBS += -lrt' (for timer functions).

Changed since v1:
	- Use "fuzzy sync" spinlocks instead of random sleeps.
	- Use threads with .timeout instead of processes.
	- Use SAFE_SHMAT() instead of shmat() directly.
	- Use tst_timer_expired_ms() instead of
	  tst_timer_stop() + tst_timer_elapsed_ms().

 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 .../kernel/syscalls/ipc/shmctl/.gitignore     |   1 +
 testcases/kernel/syscalls/ipc/shmctl/Makefile |   3 +
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     | 114 ++++++++++++++++++
 5 files changed, 120 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a9afecf57..9eafd75d6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1187,6 +1187,7 @@ shmctl01 shmctl01
 shmctl02 shmctl02
 shmctl03 shmctl03
 shmctl04 shmctl04
+shmctl05 shmctl05
 
 shmdt01 shmdt01
 shmdt02 shmdt02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 00d7eed3a..54d8622d4 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -53,6 +53,7 @@ shmctl01 shmctl01
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
diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index f467389b9..16da31b03 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -18,6 +18,9 @@
 
 top_srcdir              ?= ../../../../..
 
+shmctl05: CFLAGS += -pthread
+shmctl05: LDLIBS += -lrt
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
new file mode 100644
index 000000000..6fbc6b6c3
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -0,0 +1,114 @@
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
+#include "lapi/syscalls.h"
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+#include "tst_safe_pthread.h"
+#include "tst_safe_sysv_ipc.h"
+#include "tst_timer.h"
+
+static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
+
+static pthread_t thrd;
+
+/*
+ * Thread 2: repeatedly remove the shm ID and reallocate it again for a
+ * new shm segment.
+ */
+static void *thrproc(void *unused)
+{
+	int id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
+
+	for (;;) {
+		if (!tst_fzsync_wait_b(&fzsync_pair))
+			break;
+		SAFE_SHMCTL(id, IPC_RMID, NULL);
+		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
+		if (!tst_fzsync_wait_b(&fzsync_pair))
+			break;
+	}
+	return unused;
+}
+
+static void setup(void)
+{
+	tst_timer_check(CLOCK_MONOTONIC);
+
+	/* Skip test if either remap_file_pages() or SysV IPC is unavailable */
+	tst_syscall(__NR_remap_file_pages, NULL, 0, 0, 0, 0);
+	tst_syscall(__NR_shmctl, 0xF00F, IPC_RMID, NULL);
+
+	SAFE_PTHREAD_CREATE(&thrd, NULL, thrproc, NULL);
+}
+
+static void do_test(void)
+{
+	tst_timer_start(CLOCK_MONOTONIC);
+
+	/*
+	 * Thread 1: repeatedly attach a shm segment, then remap it until the ID
+	 * seems to have been removed by the other process.
+	 */
+	while (!tst_timer_expired_ms(5000)) {
+		int id;
+		void *addr;
+
+		id = SAFE_SHMGET(0xF00F, 4096, IPC_CREAT|0700);
+		addr = SAFE_SHMAT(id, NULL, 0);
+		tst_fzsync_wait_a(&fzsync_pair);
+		do {
+			/* This is the system call that crashed */
+			TEST(syscall(__NR_remap_file_pages, addr, 4096,
+				     0, 0, 0));
+		} while (TEST_RETURN == 0);
+
+		if (TEST_ERRNO != EIDRM && TEST_ERRNO != EINVAL) {
+			tst_brk(TBROK | TTERRNO,
+				"Unexpected remap_file_pages() error");
+		}
+		tst_fzsync_wait_a(&fzsync_pair);
+	}
+
+	tst_res(TPASS, "didn't crash");
+}
+
+static void cleanup(void)
+{
+	if (thrd) {
+		tst_fzsync_pair_exit(&fzsync_pair);
+		SAFE_PTHREAD_JOIN(thrd, NULL);
+	}
+	shmctl(0xF00F, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.timeout = 20,
+	.setup = setup,
+	.test_all = do_test,
+	.cleanup = cleanup,
+};
-- 
2.18.0.203.gfac676dfb9-goog

