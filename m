From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 9 Aug 2021 16:39:00 +0800
Subject: [LTP] [PATCH 1/4] epoll_wait: Add docparse formatting and cleanup
 for epoll_wait01
In-Reply-To: <20210809083903.161596-1-xieziyao@huawei.com>
References: <20210809083903.161596-1-xieziyao@huawei.com>
Message-ID: <20210809083903.161596-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Add docparse formatting.
2. Make use of ARRAY_SIZE().

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/epoll_wait/epoll_wait01.c | 29 ++++++++-----------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
index ad9126aaf..1807bec8a 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
@@ -4,11 +4,12 @@
  * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */

-/*
- * Description:
- *  Basic test for epoll_wait(2).
- *  Check that epoll_wait(2) works for EPOLLOUT and EPOLLIN events
- *  on a epoll instance and that struct epoll_event is set correctly.
+/*\
+ * [Description]
+ *
+ * Basic test for epoll_wait. Check that epoll_wait works for EPOLLOUT and
+ * EPOLLIN events on an epoll instance and that struct epoll_event is set
+ * correctly.
  */

 #include <sys/epoll.h>
@@ -226,24 +227,18 @@ static void cleanup(void)
 	}
 }

+static void (*testcase_list[])(void) = {
+	verify_epollout, verify_epollin, verify_epollio
+};
+
 static void do_test(unsigned int n)
 {
-	switch (n) {
-	case 0:
-		verify_epollout();
-	break;
-	case 1:
-		verify_epollin();
-	break;
-	case 2:
-		verify_epollio();
-	break;
-	}
+	testcase_list[n]();
 }

 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = do_test,
-	.tcnt = 3,
+	.tcnt = ARRAY_SIZE(testcase_list),
 };
--
2.17.1

