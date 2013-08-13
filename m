Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V96Z4-000368-SJ
	for ltp-list@lists.sourceforge.net; Tue, 13 Aug 2013 04:50:38 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V96Z2-0004tb-VC
	for ltp-list@lists.sourceforge.net; Tue, 13 Aug 2013 04:50:38 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7D4oUbr005047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Aug 2013 04:50:31 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7D4oUGA028818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Aug 2013 04:50:30 GMT
Received: from abhmt120.oracle.com (abhmt120.oracle.com [141.146.116.72])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7D4oUB5011681
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Aug 2013 04:50:30 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 13 Aug 2013 08:50:17 +0400
Message-Id: <1376369417-13511-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] rt_sigaction: headers are included in a uniform way
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
 include/ltp_signal.h                               |   17 ++++++++++++++++
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |   21 +------------------
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    2 +
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/ltp_signal.h b/include/ltp_signal.h
index 95134e9..e6fb2e0 100644
--- a/include/ltp_signal.h
+++ b/include/ltp_signal.h
@@ -34,7 +34,24 @@
 #include <stdio.h>
 #include "config.h"
 
+/*
+ * For all but __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 2.
+ *
+ * For __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 4.
+ *
+ * See asm/compat.h under the kernel source for more details.
+ *
+ * Multiply that by a fudge factor of 4 and you have your SIGSETSIZE.
+ */
+#if defined __mips__
+#define SIGSETSIZE 16
+#else
 #define SIGSETSIZE (_NSIG / 8)
+#endif
 
 #ifdef LTP_RT_SIG_TEST
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index 5beabef..0e2915e 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -46,28 +46,11 @@
 #include <sys/syscall.h>
 #include <string.h>
 
+#define LTP_RT_SIG_TEST
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
-
-/*
- * For all but __mips__:
- *
- * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 2.
- *
- * For __mips__:
- *
- * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 4.
- *
- * See asm/compat.h under the kernel source for more details.
- *
- * Multiply that by a fudge factor of 4 and you have your SIGSETSIZE.
- */
-#if defined (__mips__)
-#define SIGSETSIZE 16
-#else
-#define SIGSETSIZE 8
-#endif
+#include "ltp_signal.h"
 
 #define INVAL_STRUCT -1
 
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 646c37d..b160f2b 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -46,9 +46,11 @@
 #include <sys/syscall.h>
 #include <string.h>
 
+#define LTP_RT_SIG_TEST
 #include "test.h"
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
+#include "ltp_signal.h"
 
 #define INVAL_SIGSETSIZE -1
 
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
