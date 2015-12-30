From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Dec 2015 18:44:16 +0800
Subject: [LTP] [PATCH 2/3] epoll_wait/epoll_wait02.c: add new testcase
In-Reply-To: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1451472257-29472-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that epoll_wait(2) timeouts correctly.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/stress.part3                               |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 testcases/kernel/syscalls/epoll_wait/Makefile      |   2 +
 .../kernel/syscalls/epoll_wait/epoll_wait02.c      | 144 +++++++++++++++++++++
 6 files changed, 150 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 59be3ba..08bca9a 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -161,6 +161,7 @@ dup204 dup204
 dup205 dup205
 
 epoll_wait01 epoll_wait01
+epoll_wait02 epoll_wait02
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 3ed10ca..fb6bc0e 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -102,6 +102,7 @@ dup204 dup204
 dup205 dup205
 
 epoll_wait01 epoll_wait01
+epoll_wait02 epoll_wait02
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/syscalls b/runtest/syscalls
index 5dbd00f..6c79584 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -124,6 +124,7 @@ dup3_02 dup3_02
 epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
 epoll_wait01 epoll_wait01
+epoll_wait02 epoll_wait02
 
 eventfd01 eventfd01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 7b83307..46258ba 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -99,6 +99,7 @@
 /epoll/epoll-ltp
 /epoll_create1/epoll_create1_01
 /epoll_wait/epoll_wait01
+/epoll_wait/epoll_wait02
 /eventfd/eventfd01
 /eventfd2/eventfd2_01
 /eventfd2/eventfd2_02
diff --git a/testcases/kernel/syscalls/epoll_wait/Makefile b/testcases/kernel/syscalls/epoll_wait/Makefile
index fa233c8..94ca683 100644
--- a/testcases/kernel/syscalls/epoll_wait/Makefile
+++ b/testcases/kernel/syscalls/epoll_wait/Makefile
@@ -18,6 +18,8 @@
 
 top_srcdir		?= ../../../..
 
+epoll_wait02: LDLIBS+=-lrt
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
new file mode 100644
index 0000000..3312902
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -0,0 +1,144 @@
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
+ *  Check that epoll_wait(2) timeouts correctly.
+ */
+
+#include <sys/epoll.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "epoll_wait02";
+int TST_TOTAL = 1;
+
+static int epfd, fds[2];
+static char *opt_sleep_ms;
+static struct epoll_event epevs[1];
+
+static option_t opts[] = {
+	{"s:", NULL, &opt_sleep_ms},
+	{NULL, NULL, NULL},
+};
+
+static void setup(void);
+static void cleanup(void);
+static void help(void);
+
+int main(int ac, char **av)
+{
+	int lc, threshold;
+	long long elapsed_ms, sleep_ms = 100;
+
+	tst_parse_opts(ac, av, opts, help);
+
+	if (opt_sleep_ms) {
+		sleep_ms = atoll(opt_sleep_ms);
+
+		if (sleep_ms == 0) {
+			tst_brkm(TBROK, NULL,
+				 "Invalid timeout '%s'", opt_sleep_ms);
+		}
+	}
+
+	threshold = sleep_ms / 100 + 10;
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		tst_timer_start(CLOCK_MONOTONIC);
+		TEST(epoll_wait(epfd, epevs, 1, sleep_ms));
+		tst_timer_stop();
+
+		if (TEST_RETURN == -1) {
+			tst_resm(TFAIL | TTERRNO, "epoll_wait() failed");
+			continue;
+		}
+
+		if (TEST_RETURN != 0) {
+			tst_resm(TFAIL, "epoll_wait() unexpectedly get %li, "
+				 "expected 0", TEST_RETURN);
+			continue;
+		}
+
+		elapsed_ms = tst_timer_elapsed_ms();
+
+		if (elapsed_ms < sleep_ms) {
+			tst_resm(TFAIL, "epoll_wait() woken up too early %llims, "
+				 "expected %llims", elapsed_ms, sleep_ms);
+			continue;
+		}
+
+		if (elapsed_ms - sleep_ms > threshold) {
+			tst_resm(TFAIL, "epoll_wait() slept too long %llims, "
+				 "expected %llims, threshold %i",
+				 elapsed_ms, sleep_ms, threshold);
+			continue;
+		}
+
+		tst_resm(TPASS, "epoll_wait() slept %llims, expected %llims, "
+			 "threshold %i", elapsed_ms, sleep_ms, threshold);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	tst_timer_check(CLOCK_MONOTONIC);
+
+	SAFE_PIPE(NULL, fds);
+
+	epfd = epoll_create(1);
+	if (epfd == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to create epoll instance");
+	}
+
+	epevs[0].events = EPOLLIN;
+	epevs[0].data.fd = fds[0];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs[0])) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to register epoll target");
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
+
+static void help(void)
+{
+	printf("  -s      epoll_wait() timeout length in ms\n");
+}
-- 
1.8.4.2



