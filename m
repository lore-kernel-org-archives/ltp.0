From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 19 Oct 2020 17:07:44 +0530
Subject: [LTP] [PATCH V3 3/3] syscalls: select: Rename select04.c to
 select02.c
In-Reply-To: <20201014121509.GE31816@yuki.lan>
References: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
 <e9bcd007772ffadd6326dca29532bb4d3f8e7f0a.1599558175.git.viresh.kumar@linaro.org>
 <20201014121509.GE31816@yuki.lan>
Message-ID: <20201019113744.7zr55gnv2tt2iuyt@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14-10-20, 14:15, Cyril Hrubis wrote:
> Hi!
> We will have to implement a test for the errors as well, so I wouldn't
> rename the test like this yet.

Maybe just pick it up as is (so I don't need to resend it) and then
apply below patch:

-------------------------8<-------------------------

From b35b85ecaab98f3e3711a7f6fc2642c96657ee18 Mon Sep 17 00:00:00 2001
Message-Id: <b35b85ecaab98f3e3711a7f6fc2642c96657ee18.1603107392.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 19 Oct 2020 17:06:02 +0530
Subject: [PATCH] syscalls: select: Add failure tests

This adds a variety of failure tests to select() syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/select/.gitignore |  1 +
 testcases/kernel/syscalls/select/select03.c | 95 +++++++++++++++++++++
 3 files changed, 97 insertions(+)
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
index 000000000000..2de976cdd977
--- /dev/null
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -0,0 +1,95 @@
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
+	TEST(do_select(tc->nfds, *tc->readfds, *tc->writefds, *tc->exceptfds,
+		       *tc->timeout));
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
-- 
2.25.0.rc1.19.g042ed3e048af

