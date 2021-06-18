From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 18 Jun 2021 17:42:06 +0800
Subject: [LTP] [PATCH 3/7] io_destroy01: Add docparse formatting and more
 detailed description
In-Reply-To: <20210618094210.183027-1-xieziyao@huawei.com>
References: <20210618094210.183027-1-xieziyao@huawei.com>
Message-ID: <20210618094210.183027-4-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add docparse formatting and more detailed description to distinguish it
from io_destroy02.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../kernel/syscalls/io_destroy/io_destroy01.c     | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/io_destroy/io_destroy01.c b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
index bb89f61f5..79c685faa 100644
--- a/testcases/kernel/syscalls/io_destroy/io_destroy01.c
+++ b/testcases/kernel/syscalls/io_destroy/io_destroy01.c
@@ -1,15 +1,16 @@
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
- * io_destroy(2) fails and returns -EINVAL if ctx is invalid.
+ * Test io_destroy invoked via libaio with invalid ctx and expects it to
+ * return -EINVAL.
  */

 #include <errno.h>
--
2.17.1

