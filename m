Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1UG5o7-0002dZ-9A
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 10:54:47 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UG5o3-00059S-NL
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 10:54:47 +0000
From: Markos Chandras <markos.chandras@gmail.com>
Date: Thu, 14 Mar 2013 10:53:46 +0000
Message-ID: <1363258426-8638-1-git-send-email-markos.chandras@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases/include/linux_syscall_numbers.h: Include
	missing "test.h"
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

From: Markos Chandras <markos.chandras@imgtec.com>

Required for tst_brkm()

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/include/linux_syscall_numbers.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index 545b420..e43258e 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
@@ -16,6 +16,7 @@
 #include <errno.h>
 #include <sys/syscall.h>
 #include "cleanup.c"
+#include "test.h"
 
 #define ltp_syscall(NR, ...) ({ \
 	int __ret; \
-- 
1.7.1



------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
