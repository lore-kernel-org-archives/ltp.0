From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 17 Aug 2021 14:49:18 +0800
Subject: [LTP] [PATCH 1/7] epoll_ctl: Add docparse formatting and cleanup
 for epoll_ctl01
In-Reply-To: <20210817064924.127970-1-xieziyao@huawei.com>
References: <20210817064924.127970-1-xieziyao@huawei.com>
Message-ID: <20210817064924.127970-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add docparse formatting and fix warnings from checkpatch.pl for
epoll_ctl01.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/epoll_ctl/epoll_ctl01.c   | 28 +++++++++----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
index e199ac6ac..099a0f8dd 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
@@ -4,25 +4,22 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */

-/*
- * Test Name: epoll_ctl01.c
+/*\
+ * [Description]
  *
- * Description:
- *    Testcase to check the basic functionality of the epoll_ctl(2).
- * 1) when epoll_ctl(2) succeeds to register fd on the epoll instance and
- *    associates event with fd, epoll_wait(2) will get registered fd and
- *    event correctly.
- * 2) when epoll_ctl(2) succeeds to chage event which is related to fd,
- *    epoll_wait(2) will get chaged event correctly.
- * 3) when epoll_ctl(2) succeeds to deregister fd from the epoll instance
- *    epoll_wait(2) won't get deregistered fd and event.
+ * Check the basic functionality of the epoll_ctl:
  *
+ * - When epoll_ctl succeeds to register fd on the epoll instance and associates
+ * event with fd, epoll_wait will get registered fd and event correctly.
+ * - When epoll_ctl succeeds to change event which is related to fd, epoll_wait
+ * will get changed event correctly.
+ * - When epoll_ctl succeeds to deregister fd from the epoll instance epoll_wait
+ * won't get deregistered fd and event.
  */

-#include <sys/epoll.h>
 #include <poll.h>
-#include <string.h>
-#include <errno.h>
+#include <sys/epoll.h>
+
 #include "tst_test.h"

 static int epfd;
@@ -88,9 +85,10 @@ static void check_epoll_ctl(int opt, int exp_num)

 	while (events) {
 		int events_matched = 0;
-		memset(res_evs, 0, sizeof(res_evs));

+		memset(res_evs, 0, sizeof(res_evs));
 		res = epoll_wait(epfd, res_evs, 2, -1);
+
 		if (res <= 0) {
 			tst_res(TFAIL | TERRNO, "epoll_wait() returned %i",
 				res);
--
2.17.1

