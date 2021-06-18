From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 17:42:09 +0800
Subject: [LTP] [PATCH 6/7] io_setup: Add docparse formatting and more
 detailed description
In-Reply-To: <20210618094210.183027-1-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
Message-ID: <20210618094210.183027-7-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add docparse formatting and more detailed description to distinguish
io_setup01 from io_setup02.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/io_setup/io_setup01.c     | 24 ++++++++++---------
 .../kernel/syscalls/io_setup/io_setup02.c     |  8 +++----
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index 28aee7831..0377ca193 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -1,19 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) Crackerjack Project., 2007
- *   Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
- *   Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
+ * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2017 Xiao Yang <yangx.jy@cn.fujitsu.com>
  */

-/* Porting from Crackerjack to LTP is done
- * by Masatake YAMATO <yamato@redhat.com>
+/*\
+ * [Description]
  *
- * Description:
- * 1) io_setup(2) succeeds if both nr_events and ctxp are valid.
- * 2) io_setup(2) fails and returns -EINVAL if ctxp is not initialized to 0.
- * 3) io_setup(2) fails and returns -EINVAL if nr_events is invalid.
- * 4) io_setup(2) fails and returns -EFAULT if ctxp is NULL.
- * 5) io_setup(2) fails and returns -EAGAIN if nr_events exceeds the limit
+ * Test io_setup invoked via libaio:
+ *
+ * 1. io_setup succeeds if both nr_events and ctxp are valid.
+ * 2. io_setup fails and returns -EINVAL if ctxp is not initialized to 0.
+ * 3. io_setup fails and returns -EINVAL if nr_events is invalid.
+ * 4. io_setup fails and returns -EFAULT if ctxp is NULL.
+ * 5. io_setup fails and returns -EAGAIN if nr_events exceeds the limit
  *    of available events.
  */

diff --git a/testcases/kernel/syscalls/io_setup/io_setup02.c b/testcases/kernel/syscalls/io_setup/io_setup02.c
index 292b7440d..4ef0ad1a7 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup02.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup02.c
@@ -12,10 +12,10 @@
  *
  * Test io_setup invoked via syscall(2):
  *
- * 1. io_setup fails and returns -EFAULT if ctxp is NULL.
- * 2. io_setup fails and returns -EINVAL if ctxp is not initialized to 0.
- * 3. io_setup fails and returns -EINVAL if nr_events is -1.
- * 4. io_setup fails and returns -EAGAIN if nr_events exceeds the limit
+ * 1. io_setup fails and returns EFAULT if ctxp is NULL.
+ * 2. io_setup fails and returns EINVAL if ctxp is not initialized to 0.
+ * 3. io_setup fails and returns EINVAL if nr_events is -1.
+ * 4. io_setup fails and returns EAGAIN if nr_events exceeds the limit
  *    of available events.
  * 5. io_setup succeeds if both nr_events and ctxp are valid.
  */
--
2.17.1

