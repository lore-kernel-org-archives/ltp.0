Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YxAyN-0006x1-2o
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 09:16:31 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YxAyM-0002Bo-4g
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2015 09:16:31 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4Q9GOlU007615
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 09:16:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4Q9GOnq027424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 09:16:24 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4Q9GNle023105
	for <ltp-list@lists.sourceforge.net>; Tue, 26 May 2015 09:16:23 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 26 May 2015 12:16:16 +0300
Message-Id: <1432631777-22549-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20150526084019.GA2940@rei.suse.de>
References: <20150526084019.GA2940@rei.suse.de>
Subject: [LTP] [PATCH 1/2] Move futex_t into a common header
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/lapi/futex.h                        |   24 ++++++++++++++++++++++++
 lib/tst_checkpoint.c                        |    3 +--
 testcases/kernel/syscalls/futex/futextest.h |    2 +-
 3 files changed, 26 insertions(+), 3 deletions(-)
 create mode 100644 include/lapi/futex.h

diff --git a/include/lapi/futex.h b/include/lapi/futex.h
new file mode 100644
index 0000000..ac4036b
--- /dev/null
+++ b/include/lapi/futex.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) 2015 Linux Test Project
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
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef LAPI_FUTEX_H__
+#define LAPI_FUTEX_H__
+
+typedef volatile uint32_t futex_t;
+
+#endif /* LAPI_FUTEX_H__ */
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 79e49ac..0e2c402 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -29,11 +29,10 @@
 
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/futex.h"
 
 #define DEFAULT_MSEC_TIMEOUT 10000
 
-typedef volatile uint32_t futex_t;
-
 static futex_t *futexes;
 static int page_size;
 
diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
index 1e9713d..5754d36 100644
--- a/testcases/kernel/syscalls/futex/futextest.h
+++ b/testcases/kernel/syscalls/futex/futextest.h
@@ -38,8 +38,8 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include "lapi/futex.h"
 
-typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
 
 #ifndef FUTEX_CMP_REQUEUE
-- 
1.7.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
