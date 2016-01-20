From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 20 Jan 2016 19:10:00 +0800
Subject: [LTP] [PATCH 2/2] epoll_pwait/epoll_pwait02.c: add new testcase
In-Reply-To: <1453288200-3990-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1453288200-3990-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1453288200-3990-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that:
 epoll_pwait(2) with NULL sigmask argument fails
 if interrupted by a signal handler.

Expected result:
 epoll_pwait(2) should return -1 and set errno to EINTR.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/stress.part3                               |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/epoll_pwait/epoll_pwait02.c    | 161 +++++++++++++++++++++
 5 files changed, 165 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index ac876a4..3daaac4 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -161,6 +161,7 @@ dup204 dup204
 dup205 dup205
 
 epoll_pwait01 epoll_pwait01
+epoll_pwait02 epoll_pwait02
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index c76e025..47809ea 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -102,6 +102,7 @@ dup204 dup204
 dup205 dup205
 
 epoll_pwait01 epoll_pwait01
+epoll_pwait02 epoll_pwait02
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/syscalls b/runtest/syscalls
index 26cb48f..e20884a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -124,6 +124,7 @@ dup3_02 dup3_02
 epoll_create1_01 epoll_create1_01
 epoll01 epoll-ltp
 epoll_pwait01 epoll_pwait01
+epoll_pwait02 epoll_pwait02
 
 eventfd01 eventfd01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index c9d8aaa..4dd1103 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -99,6 +99,7 @@
 /epoll/epoll-ltp
 /epoll_create1/epoll_create1_01
 /epoll_pwait/epoll_pwait01
+/epoll_pwait/epoll_pwait02
 /eventfd/eventfd01
 /eventfd2/eventfd2_01
 /eventfd2/eventfd2_02
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
new file mode 100644
index 0000000..315e9c8
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
@@ -0,0 +1,161 @@
+/*
+ * Copyright (c) 2016 Fujitsu Ltd.
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
+ *  epoll_pwait(2) with NULL sigmask argument fails
+ *  if interrupted by a signal handler.
+ *
+ * Expected Result:
+ *  epoll_pwait(2) should return -1 and set errno to EINTR.
+ */
+
+#include <sys/epoll.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test.h"
+#include "epoll_pwait.h"
+#include "safe_macros.h"
+
+char *TCID = "epoll_pwait02";
+int TST_TOTAL = 1;
+
+static int epfd, fds[2];
+static struct epoll_event epevs;
+static struct sigaction sa;
+
+static void setup(void);
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED);
+static void do_test(void);
+static void do_child(void);
+static void cleanup(void);
+
+int main(int ac, char **av)
+{
+	int lc;
+
+	tst_parse_opts(ac, av, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		do_test();
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	if ((tst_kvercmp(2, 6, 19)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			 "that are 2.6.19 or higher");
+	}
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	sa.sa_flags = 0;
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "sigemptyset() failed");
+
+	if (sigaction(SIGUSR1, &sa, NULL) == -1)
+		tst_brkm(TFAIL | TERRNO, NULL, "sigaction() failed");
+
+	SAFE_PIPE(NULL, fds);
+
+	epfd = epoll_create(1);
+	if (epfd == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to create epoll instance");
+	}
+
+	epevs.events = EPOLLIN;
+	epevs.data.fd = fds[0];
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[0], &epevs) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to register epoll target");
+	}
+}
+
+static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
+{
+
+}
+
+static void do_test(void)
+{
+	pid_t cpid;
+
+	cpid = tst_fork();
+	if (cpid < 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+
+	if (cpid == 0)
+		do_child();
+
+	TEST(epoll_wait(epfd, &epevs, 1, 1000));
+	if (TEST_RETURN != -1) {
+		tst_resm(TFAIL, "epoll_wait() succeed unexpectedly");
+	} else {
+		if (TEST_ERRNO == EINTR) {
+			tst_resm(TPASS | TTERRNO,
+				 "epoll_wait() fails as expected");
+		} else {
+			tst_resm(TFAIL | TTERRNO,
+				 "epoll_wait() fails unexpectedly, "
+				 "expected errno is EINTR");
+		}
+	}
+
+	tst_record_childstatus(cleanup, cpid);
+}
+
+static void do_child(void)
+{
+	if (tst_process_state_wait2(getppid(), 'S') != 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to wait for parent process's state");
+	}
+
+	SAFE_KILL(cleanup, getppid(), SIGUSR1);
+
+	cleanup();
+	tst_exit();
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



