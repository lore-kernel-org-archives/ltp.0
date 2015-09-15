From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 15 Sep 2015 17:07:50 +0800
Subject: [LTP] [PATCH v2] fcntl/fcntl33.c: add F_SETLEASE test
In-Reply-To: <1440145583-9317-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1440145583-9317-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1442308070-17325-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test for feature F_SETLEASE of fcntl(2).
F_SETLEASE is used to establish a lease which provides a mechanism:
When a process (the lease breaker) performs an open(2) or truncate(2)
that conflicts with the lease, the system call will be blocked by
kernel, meanwhile the kernel notifies the lease holder by sending
it a signal (SIGIO by default), after the lease holder successes
to downgrade or remove the lease, the kernel permits the system
call of the lease breaker to proceed.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                           |   1 +
 runtest/stress.part3                      |   1 +
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/Makefile  |   3 +
 testcases/kernel/syscalls/fcntl/fcntl33.c | 262 ++++++++++++++++++++++++++++++
 6 files changed, 271 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl33.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 63a1583..aaa5c73 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -226,6 +226,7 @@ fcntl29 fcntl29
 fcntl30 fcntl30
 fcntl31 fcntl31
 fcntl32 fcntl32
+fcntl33 fcntl33
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index ca8b70c..63505ec 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -165,6 +165,7 @@ fcntl29 fcntl29
 fcntl30 fcntl30
 fcntl31 fcntl31
 fcntl32 fcntl32
+fcntl33 fcntl33
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/syscalls b/runtest/syscalls
index 22f4e33..08475f1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -260,6 +260,8 @@ fcntl31 fcntl31
 fcntl31_64 fcntl31_64
 fcntl32 fcntl32
 fcntl32_64 fcntl32_64
+fcntl33 fcntl33
+fcntl33_64 fcntl33_64
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f7214af..66dcd75 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -223,6 +223,8 @@
 /fcntl/fcntl31_64
 /fcntl/fcntl32
 /fcntl/fcntl32_64
+/fcntl/fcntl33
+/fcntl/fcntl33_64
 /fdatasync/fdatasync01
 /fdatasync/fdatasync02
 /flock/flock01
diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
index ee876f1..214eeb8 100644
--- a/testcases/kernel/syscalls/fcntl/Makefile
+++ b/testcases/kernel/syscalls/fcntl/Makefile
@@ -18,6 +18,9 @@
 
 top_srcdir		?= ../../../..
 
+fcntl33: LDLIBS+=-lrt
+fcntl33_64: LDLIBS+=-lrt
+
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
new file mode 100644
index 0000000..2c092ec
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -0,0 +1,262 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License
+ * alone with this program.
+ */
+
+/*
+ * DESCRIPTION
+ *  Test for feature F_SETLEASE of fcntl(2).
+ *  "F_SETLEASE is used to establish a lease which provides a mechanism:
+ *   When a process (the lease breaker) performs an open(2) or truncate(2)
+ *   that conflicts with the lease, the system call will be blocked by
+ *   kernel, meanwhile the kernel notifies the lease holder by sending
+ *   it a signal (SIGIO by default), after the lease holder successes
+ *   to downgrade or remove the lease, the kernel permits the system
+ *   call of the lease breaker to proceed."
+ */
+
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "tst_fs_type.h"
+
+/*
+ * MIN_TIME_LIMIT is defined to 5 senconds as a minimal acceptable
+ * amount of time for the lease breaker waitting for unblock via
+ * lease holder voluntarily downgrade or remove the lease, if the
+ * lease breaker is unblocked within MIN_TIME_LIMIT we may consider
+ * that the feature of the lease mechanism works well.
+ */
+#define MIN_TIME_LIMIT	5
+
+#define OP_OPEN_RDONLY	0
+#define OP_OPEN_WRONLY	1
+#define OP_OPEN_RDWR	2
+#define OP_TRUNCATE	3
+
+#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
+#define PATH_LS_BRK_T	"/proc/sys/fs/lease-break-time"
+
+static void setup(void);
+static void do_test(int);
+static int do_child(int);
+static void cleanup(void);
+
+static int fd;
+static int ls_brk_t;
+
+static sigset_t newset, oldset;
+static struct timespec timeout;
+static struct test_case_t {
+	int lease_type;
+	int op_type;
+	char *desc;
+} test_cases[] = {
+	{F_WRLCK, OP_OPEN_RDONLY,
+		"open(O_RDONLY) conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
+	{F_WRLCK, OP_OPEN_WRONLY,
+		"open(O_WRONLY) conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
+	{F_WRLCK, OP_OPEN_RDWR,
+		"open(O_RDWR) conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
+	{F_WRLCK, OP_TRUNCATE,
+		"truncate() conflicts with fcntl(F_SETLEASE, F_WRLCK)"},
+	{F_RDLCK, OP_OPEN_WRONLY,
+		"open(O_WRONLY) conflicts with fcntl(F_SETLEASE, F_RDLCK)"},
+	{F_RDLCK, OP_OPEN_RDWR,
+		"open(O_RDWR) conflicts with fcntl(F_SETLEASE, F_RDLCK)"},
+	{F_RDLCK, OP_TRUNCATE,
+		"truncate() conflicts with fcntl(F_SETLEASE, F_RDLCK)"},
+};
+
+char *TCID = "fcntl33";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+int main(int ac, char **av)
+{
+	int lc;
+	int tc;
+	long type;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	switch ((type = tst_fs_type(cleanup, "."))) {
+	case TST_NFS_MAGIC:
+	case TST_RAMFS_MAGIC:
+	case TST_TMPFS_MAGIC:
+		tst_brkm(TCONF, cleanup, "%s filesystem does not support "
+			 "fcntl()'s F_SETLEASE operation",
+			 tst_fs_type_name(type));
+	default:
+		break;
+	}
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (tc = 0; tc < TST_TOTAL; tc++)
+			do_test(tc);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	tst_timer_check(CLOCK_MONOTONIC);
+
+	/* Backup the lease-break-time. */
+	SAFE_FILE_SCANF(NULL, PATH_LS_BRK_T, "%d", &ls_brk_t);
+	SAFE_FILE_PRINTF(NULL, PATH_LS_BRK_T, "%d", 45);
+
+	tst_tmpdir();
+
+	SAFE_TOUCH(cleanup, "file", FILE_MODE, NULL);
+
+	sigemptyset(&newset);
+	sigaddset(&newset, SIGIO);
+
+	if (sigprocmask(SIG_SETMASK, &newset, &oldset) < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "sigprocmask() failed");
+
+	/* Time limit for lease holder to receive SIGIO. */
+	timeout.tv_sec = 5;
+	timeout.tv_nsec = 0;
+
+	TEST_PAUSE;
+}
+
+static void do_test(int i)
+{
+	pid_t cpid;
+
+	cpid = tst_fork();
+	if (cpid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+
+	if (cpid == 0)
+		do_child(i);
+
+	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
+
+	TEST(fcntl(fd, F_SETLEASE, test_cases[i].lease_type));
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "fcntl() failed to set lease");
+		SAFE_WAITPID(cleanup, cpid, NULL, 0);
+		SAFE_CLOSE(cleanup, fd);
+		fd = 0;
+		return;
+	}
+
+	/* Wait for SIGIO caused by lease breaker. */
+	TEST(sigtimedwait(&newset, NULL, &timeout));
+	if (TEST_RETURN == -1) {
+		if (TEST_ERRNO == EAGAIN) {
+			tst_resm(TFAIL | TTERRNO, "failed to receive SIGIO "
+				 "within %lis", timeout.tv_sec);
+			SAFE_WAITPID(cleanup, cpid, NULL, 0);
+			SAFE_CLOSE(cleanup, fd);
+			fd = 0;
+			return;
+		}
+		tst_brkm(TBROK | TTERRNO, cleanup, "sigtimedwait() failed");
+	} else if (TEST_RETURN != SIGIO) {
+		tst_brkm(TBROK, cleanup, "received wrong signal");
+	}
+
+	/* Try to downgrade or remove the lease. */
+	switch (test_cases[i].lease_type) {
+	case F_WRLCK:
+		TEST(fcntl(fd, F_SETLEASE, F_RDLCK));
+		if (TEST_RETURN == 0)
+			break;
+	case F_RDLCK:
+		TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO,
+				 "fcnt() failed to remove the lease");
+		}
+		break;
+	default:
+		break;
+	}
+
+	tst_record_childstatus(cleanup, cpid);
+
+	SAFE_CLOSE(cleanup, fd);
+	fd = 0;
+}
+
+static int do_child(int i)
+{
+	long long elapsed_ms;
+
+	if (tst_process_state_wait2(getppid(), 'S') != 0) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			 "failed to wait for parent process's state");
+	}
+
+	tst_timer_start(CLOCK_MONOTONIC);
+
+	switch (test_cases[i].op_type) {
+	case OP_OPEN_RDONLY:
+		SAFE_OPEN(NULL, "file", O_RDONLY);
+		break;
+	case OP_OPEN_WRONLY:
+		SAFE_OPEN(NULL, "file", O_WRONLY);
+		break;
+	case OP_OPEN_RDWR:
+		SAFE_OPEN(NULL, "file", O_RDWR);
+		break;
+	case OP_TRUNCATE:
+		SAFE_TRUNCATE(NULL, "file", 0);
+		break;
+	default:
+		break;
+	}
+
+	tst_timer_stop();
+
+	elapsed_ms = tst_timer_elapsed_ms();
+
+	if (elapsed_ms < MIN_TIME_LIMIT * 1000) {
+		tst_resm(TPASS, "%s, unblocked within %ds",
+			 test_cases[i].desc, MIN_TIME_LIMIT);
+	} else {
+		tst_resm(TFAIL, "%s, unblocked too long %llims, "
+			 "expected within %ds",
+			 test_cases[i].desc, elapsed_ms, MIN_TIME_LIMIT);
+	}
+
+	tst_exit();
+}
+
+static void cleanup(void)
+{
+	if (sigprocmask(SIG_SETMASK, &oldset, NULL) < 0)
+		tst_resm(TWARN | TERRNO, "sigprocmask restore oldset failed");
+
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TERRNO, "failed to close file");
+
+	tst_rmdir();
+
+	/* Restore the lease-break-time. */
+	FILE_PRINTF(PATH_LS_BRK_T, "%d", ls_brk_t);
+}
-- 
1.8.4.2

