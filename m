Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZJdr1-0003hg-VM
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 08:33:47 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZJdqy-0005mj-Ig
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 08:33:47 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6R8Vlgb012098
	for <ltp-list@lists.sourceforge.net>; Mon, 27 Jul 2015 16:31:47 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 27 Jul 2015 16:33:38 +0800
Message-ID: <1437986018-8279-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] fcntl/fcntl33.c: add new test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

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
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/.gitignore      |   2 +
 testcases/kernel/syscalls/fcntl/fcntl33.c | 244 ++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fcntl/fcntl33.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 8ce0daa..89c3333 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -226,6 +226,7 @@ fcntl29 fcntl29
 fcntl30 fcntl30
 fcntl31 fcntl31
 fcntl32 fcntl32
+fcntl33 fcntl33
 
 fdatasync01 fdatasync01
 fdatasync02 fdatasync02
diff --git a/runtest/syscalls b/runtest/syscalls
index 0d14528..7727663 100644
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
index 13c7a79..0a30a28 100644
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
diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
new file mode 100644
index 0000000..6d33768
--- /dev/null
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -0,0 +1,244 @@
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
+ *  When a process (the lease breaker) performs an open(2) or truncate(2)
+ *  that conflicts with the lease, the system call will be blocked by
+ *  kernel, meanwhile the kernel notifies the lease holder by sending
+ *  it a signal (SIGIO by default), after the lease holder successes
+ *  to downgrade or remove the lease, the kernel permits the system
+ *  call of the lease breaker to proceed."
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
+ * amount of time for the lease breaker waitting for unblock, if the
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
+static void sighandler(int);
+static void cleanup(void);
+
+static int fd;
+static int ls_brk_t;
+static volatile int lease;
+
+static struct test_case_t {
+	int lease_type;
+	int op_type;
+	char *string;
+} test_cases[] = {
+	{F_WRLCK, OP_OPEN_RDONLY, "open() O_RDONLY conflicts with F_WRLCK"},
+	{F_WRLCK, OP_OPEN_WRONLY, "open() O_WRONLY conflicts with F_WRLCK"},
+	{F_WRLCK, OP_OPEN_RDWR, "open() O_RDWR conflicts with F_WRLCK"},
+	{F_WRLCK, OP_TRUNCATE, "truncate() conflicts with F_WRLCK"},
+	{F_RDLCK, OP_OPEN_WRONLY, "open() O_WRONLY conflicts with O_RDLCK"},
+	{F_RDLCK, OP_OPEN_RDWR, "open() O_RDWR conflicts with O_RDLCK"},
+	{F_RDLCK, OP_TRUNCATE, "truncate() conflicts with F_RDLCK"},
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
+		tst_brkm(TCONF, cleanup,
+			"Cannot do fcntl on a file on %s filesystem",
+			tst_fs_type_name(type));
+		break;
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
+	/* Backup the lease-break-time. */
+	SAFE_FILE_SCANF(NULL, PATH_LS_BRK_T, "%d", &ls_brk_t);
+	SAFE_FILE_PRINTF(NULL, PATH_LS_BRK_T, "%d", 45);
+
+	tst_tmpdir();
+
+	TST_CHECKPOINT_INIT(tst_rmdir);
+
+	SAFE_TOUCH(cleanup, "file", FILE_MODE, NULL);
+
+	TEST_PAUSE;
+}
+
+static void do_test(int i)
+{
+	pid_t cpid;
+
+	cpid = FORK_OR_VFORK();
+	if (cpid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork(2) failed");
+
+	if (cpid == 0)
+		do_child(i);
+
+	fd = SAFE_OPEN(cleanup, "file", O_RDONLY);
+
+	lease = test_cases[i].lease_type;
+	TEST(fcntl(fd, F_SETLEASE, lease));
+	if (TEST_RETURN == -1) {
+		tst_resm(TFAIL | TTERRNO, "fcntl(2) failed to set lease");
+		SAFE_WAITPID(cleanup, cpid, NULL, 0);
+		SAFE_CLOSE(cleanup, fd);
+		fd = 0;
+		return;
+	}
+
+	if (signal(SIGIO, sighandler) == SIG_ERR)
+		tst_brkm(TBROK | TERRNO, cleanup, "signal(2) failed");
+
+	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
+
+	tst_record_childstatus(cleanup, cpid);
+
+	SAFE_CLOSE(cleanup, fd);
+	fd = 0;
+}
+
+static int do_child(int i)
+{
+	time_t time_start, time_end;
+
+	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
+
+	if (time(&time_start) == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			"getting start time failed");
+	}
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
+	if (time(&time_end) == -1) {
+		tst_brkm(TBROK | TERRNO, NULL,
+			"getting end time failed");
+	}
+
+	if (difftime(time_end, time_start) < MIN_TIME_LIMIT) {
+		tst_resm(TPASS, "fcntl(2) lease passed, "
+			"test type: %s", test_cases[i].string);
+	} else {
+		tst_resm(TFAIL, "unblocking took too long time, "
+			"test type: %s", test_cases[i].string);
+	}
+
+	tst_exit();
+}
+
+static void sighandler(int sig)
+{
+	int ret;
+
+	if (sig != SIGIO) {
+		ret = write(STDOUT_FILENO, "get wrong signal\n",
+			sizeof("get wrong signal\n"));
+	} else {
+		switch (lease) {
+		case F_WRLCK:
+			TEST(fcntl(fd, F_SETLEASE, F_RDLCK));
+			if (TEST_RETURN == 0)
+				break;
+		case F_RDLCK:
+			TEST(fcntl(fd, F_SETLEASE, F_UNLCK));
+			if (TEST_RETURN == -1) {
+				ret = write(STDOUT_FILENO,
+					"fcntl(2) failed\n",
+					sizeof("fcntl(2) failed\n"));
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	(void)ret;
+}
+
+static void cleanup(void)
+{
+	if (fd > 0 && close(fd))
+		tst_resm(TWARN | TTERRNO, "failed to close file");
+
+	tst_rmdir();
+
+	/* Restore the lease-break-time. */
+	FILE_PRINTF(PATH_LS_BRK_T, "%d", ls_brk_t);
+}
-- 
1.8.4.2


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
