Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sweekar.pinto@oracle.com>) id 1WGogm-0008S8-RH
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:54:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WGogm-00024b-1C
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:54:44 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1LBsbYb003523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:38 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1LBsaqp002744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1LBsamn002734
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:36 GMT
From: Sweekar Pinto <sweekar.pinto@oracle.com>
Date: Thu, 20 Feb 2014 19:05:51 -0500
Message-Id: <1392941153-8643-1-git-send-email-sweekar.pinto@oracle.com>
Subject: [LTP] [PATCH v2 1/3] Fix compilation errors in crasher.c
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

-Conditional inclusion of asm.h for kernel > 3.4
-The owner field of proc_dir_entry has been removed from
 kernel ver 2.6.30
-SPIN_LOCK_UNLOCKED is depricated. DEFINE_SPINLOCK is
 available all the way back to 2.6.12, so no need of
 conditional declaration.

Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
---
 testcases/kdump/lib/crasher/crasher.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kdump/lib/crasher/crasher.c b/testcases/kdump/lib/crasher/crasher.c
index bc192dc..fe72986 100644
--- a/testcases/kdump/lib/crasher/crasher.c
+++ b/testcases/kdump/lib/crasher/crasher.c
@@ -25,7 +25,10 @@
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
-#include <asm/system.h>
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
+# include <asm/system.h>
+#endif
 
 MODULE_LICENSE("GPL");
 
@@ -46,7 +49,7 @@ static int crasher_write(struct file *file, const char *buffer,
 			 unsigned long count, void *data)
 {
 	char value, *a;
-	spinlock_t mylock = SPIN_LOCK_UNLOCKED;
+	DEFINE_SPINLOCK(mylock);
 
 	/* grab the first byte the user gave us, ignore the rest */
 	if (copy_from_user(&value, buffer, 1))
@@ -91,10 +94,11 @@ int crasher_init(void)
 	if ((crasher_proc = create_proc_entry(CRASH, 0, NULL)) == NULL) {
 		return -ENOMEM;
 	}
-
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 30)
+	crasher_proc->owner = THIS_MODULE
+#endif
 	crasher_proc->read_proc = crasher_read;
 	crasher_proc->write_proc = crasher_write;
-	crasher_proc->owner = THIS_MODULE;
 	return 0;
 }
 
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
