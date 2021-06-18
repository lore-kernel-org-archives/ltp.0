From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 17:42:10 +0800
Subject: [LTP] [PATCH 7/7] io_submit01: Add docparse formatting and more
 detailed description
In-Reply-To: <20210618094210.183027-1-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
Message-ID: <20210618094210.183027-8-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add docparse formatting and more detailed description to distinguish it
from io_submit{02, 03}.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/io_submit/io_submit01.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
index bbbbc9101..cfaf56f8e 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit01.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
@@ -1,11 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007
+ * Ported from Crackerjack to LTP by Masatake YAMATO <yamato@redhat.com>
  * Copyright (c) 2011-2017 Cyril Hrubis <chrubis@suse.cz>
  */

-/* Porting from Crackerjack to LTP is done
-   by Masatake YAMATO <yamato@redhat.com> */
+/*\
+ * [Description]
+ *
+ * Test io_submit invoked via libaio:
+ *
+ * 1. io_submit fails and returns -EINVAL if ctx is invalid.
+ * 2. io_submit fails and returns -EINVAL if nr is invalid.
+ * 3. io_submit fails and returns -EFAULT if iocbpp pointer is invalid.
+ * 4. io_submit fails and returns -EBADF if fd is invalid.
+ * 5. io_submit() succeeds and returns the number of iocbs submitted.
+ * 6. io_submit() succeeds and returns 0 if nr is zero.
+ */

 #include <errno.h>
 #include <string.h>
--
2.17.1

