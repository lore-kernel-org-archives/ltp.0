Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Uz3Jr-0005MI-Mf
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 11:21:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uz3Jq-0006sJ-Qu
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 11:21:23 +0000
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 16 Jul 2013 13:20:57 +0200
Message-Id: <65bd50b9cbce20c71adb8a412ef1f95a527db102.1373973465.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] kernel/firmware: always build userspace bits
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

Because this testcase is listed in runtest files, we should
always build userspace bits, so that ltp has something to run.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/firmware/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/firmware/Makefile b/testcases/kernel/firmware/Makefile
index fbacf8d..dd2c62d 100644
--- a/testcases/kernel/firmware/Makefile
+++ b/testcases/kernel/firmware/Makefile
@@ -38,7 +38,7 @@ endif
 
 ifeq ($(SKIP),0)
 SUBDIRS			+= fw_load_kernel
-SUBDIRS			+= fw_load_user
 endif
+SUBDIRS			+= fw_load_user
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
1.7.1


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
