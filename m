From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 6 Jan 2016 09:19:42 +0800
Subject: [LTP] [PATCH 4/4] epoll_wait/epoll_wait04.c: add new testcase
In-Reply-To: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1451472257-29472-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1452043182-19242-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify that:
 epoll_wait(2) fails if the memory area pointed to by events is not
 accessible with write permissions.

Expected result:
 epoll_wait(2) should return -1 and set errno to EFAULT

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 +
 runtest/stress.part3                               |   1 +
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/epoll_wait/epoll_wait04.c      | 119 +++++++++++++++++++++
 5 files changed, 123 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_wait/epoll_wait04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 4686c08..d30e596 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -163,6 +163,7 @@ dup205 dup205
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
+epoll_wait04 epoll_wait04
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index e198fb4..9d8b87a 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -104,6 +104,7 @@ dup205 dup205
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
+epoll_wait04 epoll_wait04
 
 execl01 execl01
 execle01 execle01
diff --git a/runtest/syscalls b/runtest/syscalls
index 88c748c..df1a267 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -126,6 +126,7 @@ epoll01 epoll-ltp
 epoll_wait01 epoll_wait01
 epoll_wait02 epoll_wait02
 epoll_wait03 epoll_wait03
+epoll_wait04 epoll_wait04
 
 eventfd01 eventfd01
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index f63077a..23bd9ac 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -101,6 +101,7 @@
 /epoll_wait/epoll_wait01
 /epoll_wait/epoll_wait02
 /epoll_wait/epoll_wait03
+/epoll_wait/epoll_wait04
 /eventfd/eventfd01
 /eventfd2/eventfd2_01
 /eventfd2/eventfd2_02
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
new file mode 100644
index 0000000..36110f3
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait04.c
@@ -0,0 +1,119 @@
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
+ *  epoll_wait(2) fails if the memory area pointed to by events is not
+ *  accessible with write permissions.
+ *
+ * Expected Result:
+ *  epoll_wait(2) should return -1 and set errno to EFAULT
+ */
+
+#include <sys/epoll.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "epoll_wait04";
+int TST_TOTAL = 1;
+
+static int page_size, epfd, fds[2];
+static struct epoll_event *epevs;
+
+static void setup(void);
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
+		TEST(epoll_wait(epfd, epevs, 1, -1));
+		if (TEST_RETURN != -1) {
+			tst_resm(TFAIL, "epoll_wait() succeed unexpectedly");
+		} else {
+			if (TEST_ERRNO == EFAULT) {
+			tst_resm(TPASS | TTERRNO,
+				 "epoll_wait() fails as expected");
+			} else {
+				tst_resm(TFAIL | TTERRNO,
+					 "epoll_wait() fails unexpectedly, "
+					 "expected errno is EFAULT");
+			}
+		}
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
+	page_size = getpagesize();
+
+	epevs = SAFE_MMAP(NULL, NULL, page_size, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	SAFE_PIPE(NULL, fds);
+
+	epfd = epoll_create(1);
+	if (epfd == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "failed to create epoll instance");
+	}
+
+	epevs->events = EPOLLOUT;
+	epevs->data.fd = fds[1];
+
+	if (mprotect(epevs, page_size, PROT_READ)) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			"failed to set memory area read-only");
+	}
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[1], epevs)) {
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
-- 
1.8.4.2



