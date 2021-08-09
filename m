From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 9 Aug 2021 16:39:01 +0800
Subject: [LTP] [PATCH 2/4] epoll_wait: Add docparse formatting and fix
 warnings from checkpatch.pl
In-Reply-To: <20210809083903.161596-1-xieziyao@huawei.com>
References: <20210809083903.161596-1-xieziyao@huawei.com>
Message-ID: <20210809083903.161596-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add docparse formatting and fix warnings from checkpatch.pl for
epoll_wait02.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/epoll_wait/epoll_wait02.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
index c54a739f8..d2c0b6ef4 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait02.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Fujitsu Ltd.
- *  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  */

-/*
- *  Check that epoll_wait(2) timeouts correctly.
+/*\
+ * [Description]
+ *
+ * Check that epoll_wait(2) timeouts correctly.
  */

 #include <sys/epoll.h>
@@ -17,7 +19,7 @@

 static int epfd, fds[2];
 static struct epoll_event epevs[1] = {
-       {.events = EPOLLIN}
+	{.events = EPOLLIN}
 };

 int sample_fn(int clk_id, long long usec)
@@ -30,8 +32,7 @@ int sample_fn(int clk_id, long long usec)
 	tst_timer_sample();

 	if (TST_RET != 0) {
-		tst_res(TFAIL | TTERRNO,
-			"epoll_wait() returned %li", TST_RET);
+		tst_res(TFAIL | TTERRNO, "epoll_wait() returned %li", TST_RET);
 		return 1;
 	}

--
2.17.1

