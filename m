From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 21 Oct 2020 11:02:54 +0530
Subject: [LTP] [PATCH V2 4/4] syscalls: select: Add failure tests
In-Reply-To: <e9bcd007772ffadd6326dca29532bb4d3f8e7f0a.1599558175.git.viresh.kumar@linaro.org>
References: <e9bcd007772ffadd6326dca29532bb4d3f8e7f0a.1599558175.git.viresh.kumar@linaro.org>
Message-ID: <41c6693c6714fe6ca471831d71540cf8ad67881e.1603258262.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds a variety of failure tests to select() syscalls. Another
helper is added in select_var.h to make sure we don't access a bad
address while reading/writing the timeout value.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
I am resending the patch formally here and marking it as V2 as I fixed
an issue with it.

 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/select/.gitignore   |  1 +
 testcases/kernel/syscalls/select/select03.c   | 96 +++++++++++++++++++
 testcases/kernel/syscalls/select/select_var.h | 55 ++++++++---
 4 files changed, 138 insertions(+), 15 deletions(-)
 create mode 100644 testcases/kernel/syscalls/select/select03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 12ae10464d9f..0443f9f3d51b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1157,6 +1157,7 @@ sched_getattr02 sched_getattr02
 
 select01 select01
 select02 select02
+select03 select03
 
 semctl01 semctl01
 semctl02 semctl02
diff --git a/testcases/kernel/syscalls/select/.gitignore b/testcases/kernel/syscalls/select/.gitignore
index f5a43c23326a..b6bff2d4f961 100644
--- a/testcases/kernel/syscalls/select/.gitignore
+++ b/testcases/kernel/syscalls/select/.gitignore
@@ -1,2 +1,3 @@
 /select01
 /select02
+/select03
diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
new file mode 100644
index 000000000000..9a665b862dce
--- /dev/null
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Linaro Ltd.
+ *
+ * Failure tests.
+ */
+
+#include <unistd.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include "select_var.h"
+
+static fd_set readfds_reg, writefds_reg, fds_closed;
+static fd_set *preadfds_reg = &readfds_reg, *pwritefds_reg = &writefds_reg;
+static fd_set *pfds_closed = &fds_closed, *nullfds = NULL, *faulty_fds;
+static int fd_closed, fd[2];
+static struct timeval timeout;
+static struct timeval *valid_to = &timeout, *invalid_to;
+
+static struct tcases {
+	char *name;
+	int nfds;
+	fd_set **readfds;
+	fd_set **writefds;
+	fd_set **exceptfds;
+	struct timeval **timeout;
+	int exp_errno;
+} tests[] = {
+	{ "Negative nfds", -1, &preadfds_reg, &pwritefds_reg, &nullfds, &valid_to, EINVAL },
+	{ "Invalid readfds", 6, &pfds_closed, &pwritefds_reg, &nullfds, &valid_to, EBADF },
+	{ "Invalid writefds", 6, &preadfds_reg, &pfds_closed, &nullfds, &valid_to, EBADF },
+	{ "Invalid exceptfds", 6, &preadfds_reg, &pwritefds_reg, &pfds_closed, &valid_to, EBADF },
+	{ "Faulty readfds", 6, &faulty_fds, &pwritefds_reg, &nullfds, &valid_to, EFAULT },
+	{ "Faulty writefds", 6, &preadfds_reg, &faulty_fds, &nullfds, &valid_to, EFAULT },
+	{ "Faulty exceptfds", 6, &preadfds_reg, &pwritefds_reg, &faulty_fds, &valid_to, EFAULT },
+	{ "Faulty timeout", 6, &preadfds_reg, &pwritefds_reg, &nullfds, &invalid_to, EFAULT },
+};
+
+static void run(unsigned int n)
+{
+	struct tcases *tc = &tests[n];
+
+	TEST(do_select_faulty_to(tc->nfds, *tc->readfds, *tc->writefds,
+				 *tc->exceptfds, *tc->timeout,
+				 tc->timeout == &invalid_to));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "%s: select() passed unexpectedly", tc->name);
+		return;
+	}
+
+	if (tc->exp_errno != TST_ERR) {
+		tst_res(TFAIL | TTERRNO, "%s: select()() should fail with %s",
+			tc->name, tst_strerrno(tc->exp_errno));
+		return;
+	}
+
+	tst_res(TPASS, "%s: select() failed as expected", tc->name);
+}
+
+static void setup(void)
+{
+	void *faulty_address;
+
+	select_info();
+
+	timeout.tv_sec = 0;
+	timeout.tv_usec = 100000;
+
+	/* Regular file */
+	fd_closed = SAFE_OPEN("tmpfile1", O_CREAT | O_RDWR, 0777);
+	FD_ZERO(&fds_closed);
+	FD_SET(fd_closed, &fds_closed);
+
+	SAFE_PIPE(fd);
+	FD_ZERO(&readfds_reg);
+	FD_ZERO(&writefds_reg);
+	FD_SET(fd[0], &readfds_reg);
+	FD_SET(fd[1], &writefds_reg);
+
+	SAFE_CLOSE(fd_closed);
+
+	faulty_address = tst_get_bad_addr(NULL);
+	invalid_to = faulty_address;
+	faulty_fds = faulty_address;
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tests),
+	.test_variants = TEST_VARIANTS,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index 86f80eeb0dc1..c8a8eb64e06a 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -16,7 +16,8 @@ struct compat_sel_arg_struct {
 	long _tvp;
 };
 
-static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout)
+static int do_select_faulty_to(int nfds, fd_set *readfds, fd_set *writefds,
+		fd_set *exceptfds, struct timeval *timeout, int faulty_to)
 {
 	switch (tst_variant) {
 	case 0:
@@ -39,25 +40,43 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
 	}
 	case 2: {
 		int ret;
-		struct __kernel_old_timespec ts = {
-			.tv_sec = timeout->tv_sec,
-			.tv_nsec = timeout->tv_usec * 1000,
-		};
-		ret = tst_syscall(__NR_pselect6, nfds, readfds, writefds, exceptfds, &ts, NULL);
-		timeout->tv_sec = ts.tv_sec;
-		timeout->tv_usec = ts.tv_nsec / 1000;
+		struct __kernel_old_timespec _ts;
+		void *ts;
+
+		if (faulty_to) {
+			ts = timeout;
+		} else {
+			ts = &_ts;
+			_ts.tv_sec = timeout->tv_sec;
+			_ts.tv_nsec = timeout->tv_usec * 1000;
+		}
+
+		ret = tst_syscall(__NR_pselect6, nfds, readfds, writefds, exceptfds, ts, NULL);
+		if (!faulty_to) {
+			timeout->tv_sec = _ts.tv_sec;
+			timeout->tv_usec = _ts.tv_nsec / 1000;
+		}
 		return ret;
 	}
 	case 3: {
 		int ret = 0;
 #if (__NR_pselect6_time64 != __LTP__NR_INVALID_SYSCALL)
-		struct __kernel_timespec ts = {
-			.tv_sec = timeout->tv_sec,
-			.tv_nsec = timeout->tv_usec * 1000,
-		};
-		ret = tst_syscall(__NR_pselect6_time64, nfds, readfds, writefds, exceptfds, &ts, NULL);
-		timeout->tv_sec = ts.tv_sec;
-		timeout->tv_usec = ts.tv_nsec / 1000;
+		struct __kernel_timespec _ts;
+		void *ts;
+
+		if (faulty_to) {
+			ts = timeout;
+		} else {
+			ts = &_ts;
+			_ts.tv_sec = timeout->tv_sec;
+			_ts.tv_nsec = timeout->tv_usec * 1000;
+		}
+
+		ret = tst_syscall(__NR_pselect6_time64, nfds, readfds, writefds, exceptfds, ts, NULL);
+		if (!faulty_to) {
+			timeout->tv_sec = _ts.tv_sec;
+			timeout->tv_usec = _ts.tv_nsec / 1000;
+		}
 #else
 		tst_brk(TCONF, "__NR_pselect6 time64 variant not supported");
 #endif
@@ -75,6 +94,12 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
 	return -1;
 }
 
+static inline int do_select(int nfds, fd_set *readfds, fd_set *writefds,
+			    fd_set *exceptfds, struct timeval *timeout)
+{
+	return do_select_faulty_to(nfds, readfds, writefds, exceptfds, timeout, 0);
+}
+
 static void select_info(void)
 {
 	switch (tst_variant) {
-- 
2.25.0.rc1.19.g042ed3e048af

