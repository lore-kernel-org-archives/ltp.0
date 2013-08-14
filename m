Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V9VYo-00083M-21
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 07:32:02 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V9VYn-0000Lp-7b
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 07:32:02 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7E7Vsnj017253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 07:31:55 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7E7VrpI015706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 07:31:54 GMT
Received: from abhmt110.oracle.com (abhmt110.oracle.com [141.146.116.62])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7E7VqNu029792
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 07:31:52 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 14 Aug 2013 11:31:41 +0400
Message-Id: <1376465501-5916-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130813161122.GA29678@rei>
References: <20130813161122.GA29678@rei>
Subject: [LTP] [PATCH V2] rt_sigaction: headers are included in a uniform way
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
 include/ltp_signal.h                               |   17 +++++++++++++++++
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |   20 +-------------------
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    1 +
 3 files changed, 19 insertions(+), 19 deletions(-)

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
index 5beabef..b89324f 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -49,25 +49,7 @@
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
index 646c37d..279f342 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -49,6 +49,7 @@
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
