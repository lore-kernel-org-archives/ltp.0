From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:21 +0800
Subject: [LTP] [PATCH 4/7] epoll_create1: Add docparse formatting and
 cleanup for epoll_create1_01
In-Reply-To: <20210817064924.127970-1-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
Message-ID: <20210817064924.127970-5-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Add docparse formatting.
2. Make use of ARRAY_SIZE().

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../syscalls/epoll_create1/epoll_create1_01.c | 53 +++++++++----------
 .../syscalls/epoll_create1/epoll_create1_02.c |  0
 2 files changed, 25 insertions(+), 28 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c

diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index 41aa634e1..39e01eb8b 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -2,51 +2,48 @@
 /*
  * Copyright (c) Ulrich Drepper <drepper@redhat.com>
  * Copyright (c) International Business Machines Corp., 2009
+ */
+
+/*\
+ * [Description]
  *
- * Test system call introduced in 2.6.27.
- * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a0998b50c3f0b8fdd265c63e0032f86ebe377dbf
- *
- * This patch adds the new epoll_create1 syscall.  It extends the old
- * epoll_create syscall by one parameter which is meant to hold a flag value.
- * In this patch the only flag support is EPOLL_CLOEXEC which causes the
- * close-on-exec flag for the returned file descriptor to be set. A new name
- * EPOLL_CLOEXEC is introduced which in this implementation must have the same
- * value as O_CLOEXEC.
+ * Verify that epoll_create1 sets the close-on-exec flag for the returned
+ * file descriptor with the only flag support, EPOLL_CLOEXEC.
  */
-#include <errno.h>
+
 #include <sys/epoll.h>
+
 #include "tst_test.h"
 #include "lapi/epoll.h"
 #include "lapi/syscalls.h"

-static void verify_epoll_create1(void)
+static struct test_case_t {
+	int flags;
+	int exp_flag;
+	const char *desc;
+} tc[] = {
+	{0, 0, "flags=0 didn't set close-on-exec flag"},
+	{EPOLL_CLOEXEC, 1, "flags=EPOLL_CLOEXEC set close-on-exec"}
+};
+
+static void run(unsigned int n)
 {
 	int fd, coe;

-	fd = tst_syscall(__NR_epoll_create1, 0);
+	fd = tst_syscall(__NR_epoll_create1, tc[n].flags);
 	if (fd == -1)
-		tst_brk(TFAIL | TERRNO, "epoll_create1(0) failed");
+		tst_brk(TFAIL | TERRNO, "epoll_create1(...) failed");

 	coe = SAFE_FCNTL(fd, F_GETFD);
-	if (coe & FD_CLOEXEC)
-		tst_brk(TFAIL, "flags=0 set close-on-exec flag");
+	if ((coe & FD_CLOEXEC) != tc[n].exp_flag)
+		tst_brk(TFAIL, "epoll_create1(...) with %s", tc[n].desc);
+	tst_res(TPASS, "epoll_create1(...) with %s", tc[n].desc);

 	SAFE_CLOSE(fd);
-
-	fd = tst_syscall(__NR_epoll_create1, EPOLL_CLOEXEC);
-	if (fd == -1)
-		tst_brk(TFAIL | TERRNO, "epoll_create1(EPOLL_CLOEXEC) failed");
-
-	coe = SAFE_FCNTL(fd, F_GETFD);
-	if ((coe & FD_CLOEXEC) == 0)
-		tst_brk(TFAIL, "flags=EPOLL_CLOEXEC didn't set close-on-exec");
-
-	SAFE_CLOSE(fd);
-
-	tst_res(TPASS, "epoll_create1(EPOLL_CLOEXEC) PASSED");
 }

 static struct tst_test test = {
 	.min_kver = "2.6.27",
-	.test_all = verify_epoll_create1,
+	.tcnt = ARRAY_SIZE(tc),
+	.test = run,
 };
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_02.c
new file mode 100644
index 000000000..e69de29bb
--
2.17.1

