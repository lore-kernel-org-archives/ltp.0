Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fenggw-fnst@cn.fujitsu.com>) id 1ZCN1l-0007C7-6K
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 07:10:49 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZCN1j-0006sA-RU
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 07:10:49 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6778xlq002387
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2015 15:08:59 +0800
From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 7 Jul 2015 15:10:58 +0800
Message-ID: <1436253058-7639-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] futex/futex_wake04.c: add kernel version check
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Compilation failed on RHEL5U11GA because the flag MAP_HUGETLB of
mmap(2) are only available on kernels that are 2.6.32 or higher,
therefore add kernel version check, as well as add mmap.h to
define the flag in order to avoid compilation error.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 include/lapi/mmap.h                            | 26 ++++++++++++++++++++++++++
 testcases/kernel/syscalls/futex/futex_wake04.c |  7 +++++++
 2 files changed, 33 insertions(+)
 create mode 100644 include/lapi/mmap.h

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
new file mode 100644
index 0000000..e8e5917
--- /dev/null
+++ b/include/lapi/mmap.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ */
+
+#ifndef __LAPI_MMAP_H__
+#define __LAPI_MMAP_H__
+
+#ifndef MAP_HUGETLB
+#define MAP_HUGETLB 0x40000
+#endif
+
+#endif /* __LAPI_MMAP_H__ */
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 955b05e..fa98636 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -46,6 +46,7 @@
 #include "safe_macros.h"
 #include "futextest.h"
 #include "futex_utils.h"
+#include "lapi/mmap.h"
 
 #define PATH_MEMINFO "/proc/meminfo"
 #define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
@@ -62,6 +63,12 @@ static long orig_hugepages;
 static void setup(void)
 {
 	tst_require_root(NULL);
+
+	if ((tst_kvercmp(2, 6, 32)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can only run on kernels "
+			"that are 2.6.32 or higher");
+	}
+
 	tst_tmpdir();
 
 	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
-- 
1.8.4.2


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
