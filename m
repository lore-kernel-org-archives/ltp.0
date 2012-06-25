Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Sizdv-0006Bb-ST
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 03:07:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sizdr-0004iu-RB
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 03:07:11 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q5P370BF019078
	for <ltp-list@lists.sourceforge.net>; Mon, 25 Jun 2012 11:07:00 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Mon, 25 Jun 2012 11:06:42 +0800
Message-Id: <1340593602-5462-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] dummy.c: fix a bug of TCONF fail
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

When HAVE_LIBCAP or HAVE_SYS_CAPABILITY_H is not defined, 
the case should not be fail.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/security/cap_bound/dummy.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/cap_bound/dummy.c b/testcases/kernel/security/cap_bound/dummy.c
index 3ee7c9b..d161efd 100644
--- a/testcases/kernel/security/cap_bound/dummy.c
+++ b/testcases/kernel/security/cap_bound/dummy.c
@@ -1,10 +1,14 @@
 #include <stdio.h>
 #include "config.h"
+#include "test.h"
 
 #if HAVE_SYS_CAPABILITY_H
 #include <sys/capability.h>
 #endif
 
+char *TCID = "dummy";
+int TST_TOTAL=1;
+
 int main(void)
 {
 #if HAVE_SYS_CAPABILITY_H
@@ -15,11 +19,9 @@ int main(void)
 	cap_free(cur);
 	return 0;
 #else /* libcap */
-	printf("System doesn't support POSIX capabilities.\n");
-	return 1;
+	tst_brkm(TCONF, NULL, "System doesn't support POSIX capabilities.");
 #endif
 #else /* capability_h */
-	printf("System doesn't support sys/capability.h\n");
-	return 1;
+	tst_brkm(TCONF, NULL, "System doesn't support sys/capability.h.");
 #endif
 }
-- 
1.7.10.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
