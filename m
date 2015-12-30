From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Dec 2015 18:44:17 +0800
Subject: [LTP] [PATCH 3/3] epoll_wait/epoll_wait03.c: add new testcase
In-Reply-To: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1451472257-29472-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that:
 1) epoll_wait(2) fails if epfd is not a valid file descriptor
 2) epoll_wait(2) fails if epfd is not an epoll file descriptor
 3) epoll_wait(2) fails if maxevents is less than zero
 4) epoll_wait(2) fails if maxevents is equal to zero

Expected result:
 1) epoll_wait(2) should return -1 and set errno to EBADF
 2) epoll_wait(2) should return -1 and set errno to EINVAL
 3) epoll_wait(2) should return -1 and set errno to EINVAL
 4) epoll_wait(2) should return -1 and set errno to EINVAL

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/stress.part3                               |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait03.c      | 146 +++++++++++++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait03.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 08bca9a..4686c08 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -162,6 +162,7 @@ dup205 dup205
 
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
+epoll_wait03 epoll_wait03
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index fb6bc0e..e198fb4 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -103,6 +103,7 @@ dup205 dup205
 
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
+epoll_wait03 epoll_wait03
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/syscalls b/runtest/syscalls
index 6c79584..88c748c 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -125,6 +125,7 @@ epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
+epoll_wait03 epoll_wait03
 
 eventfd01 eventfd01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 46258ba..f63077a 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -100,6 +100,7 @@
 /epoll_create1/epoll_create1_01
 /epoll_wait/epoll_wait01
 /epoll_wait/epoll_wait02
+/epoll_wait/epoll_wait03
 /eventfd/eventfd01
 /eventfd2/eventfd2_01
 /eventfd2/eventfd2_02
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
new file mode 100644
index 0000000..34009c5
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait03.c
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+/*
+ * Description:
+ *  1) epoll_wait(2) fails if epfd is not a valid file descriptor
+ *  2) epoll_wait(2) fails if epfd is not an epoll file descriptor
+ *  3) epoll_wait(2) fails if maxevents is less than zero
+ *  4) epoll_wait(2) fails if maxevents is equal to zero
+ *
+ * Expected Result:
+ *  1) epoll_wait(2) should return -1 and set errno to EBADF
+ *  2) epoll_wait(2) should return -1 and set errno to EINVAL
+ *  3) epoll_wait(2) should return -1 and set errno to EINVAL
+ *  4) epoll_wait(2) should return -1 and set errno to EINVAL
+ */
+
+#include <sys/epoll.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+static int epfd, fds[2];
+static struct epoll_event epevs[1];
+
+static struct test_case_t {
+	int epfd;
+	int maxevents;
+	int exp_errno;
+} test_cases[] = {
+	/* test1 */
+	{-1, 1, EBADF},
+	/* test2 */
+	{0, 1, EINVAL},
+	/*
+	 * test3
+	 * temporarily set epfd to 0
+	 * will be set to an epoll instance later
+	 */
+	{0, -1, EINVAL},
+	/*
+	 * test4
+	 * temporarily set epfd to 0
+	 * will be set to an epoll instance later
+	 */
+	{0, 0, EINVAL},
+};
+
+char *TCID = "epoll_wait03";
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+
+static void setup(void);
+static void verify_epoll_wait(struct test_case_t *test_cases);
+static void cleanup(void);
+
+int main(int ac, char **av)
+{
+	int lc, tc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		for (tc = 0; tc < TST_TOTAL; tc++)
+			verify_epoll_wait(&test_cases[tc]);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	SAFE_PIPE(NULL, fds);
+
+	epfd = epoll_create(1);
+	if (epfd == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to create epoll instance");
+	}
+
+	test_cases[2].epfd = epfd;
+	test_cases[3].epfd = epfd;
+
+	epevs[0].events = EPOLLOUT;
+	epevs[0].data.fd = fds[1];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], &epevs[0])) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to register epoll target");
+	}
+}
+
+static void verify_epoll_wait(struct test_case_t *test_cases)
+{
+	TEST(epoll_wait(test_cases->epfd, epevs, test_cases->maxevents, -1));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "epoll_wait() succeed unexpectedly");
+	} else {
+		if (TEST_ERRNO == test_cases->exp_errno) {
+			tst_resm(TPASS | TTERRNO,
+				 "epoll_wait() fails as expected");
+		} else {
+			tst_resm(TFAIL | TTERRNO,
+				 "epoll_wait() fails unexpectedly, "
+				 "expected %d: %s", test_cases->exp_errno,
+				 strerror(test_cases->exp_errno));
+		}
+	}
+}
+
+static void cleanup(void)
+{
+	if (epfd > 0 && close(epfd))
+		tst_resm(TWARN | TERRNO, "failed to close epfd");
+
+	if (close(fds[0]))
+		tst_resm(TWARN | TERRNO, "close(fds[0]) failed");
+
+	if (close(fds[1]))
+		tst_resm(TWARN | TERRNO, "close(fds[1]) failed");
+}
-- 
1.8.4.2



