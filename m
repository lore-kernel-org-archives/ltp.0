Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHURa-0004Lb-B7
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:42 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHURY-0006CS-W0
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:42 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R4BWbj006833
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:32 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R4BWH5716950
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:32 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R4BWT3021246
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:11:32 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:41:22 +0530
Message-Id: <1274933486-4876-3-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 2/6] realtime: add test descriptions
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
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

This patch adds the descriptions for the tests 1,2,5,6.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-1.c |    4 ++--
 testcases/realtime/func/pi-tests/testpi-2.c |    5 +++--
 testcases/realtime/func/pi-tests/testpi-5.c |    4 ++--
 testcases/realtime/func/pi-tests/testpi-6.c |    4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index dc3c30b..35df387 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -20,8 +20,8 @@
  *      testpi-1.c
  *
  * DESCRIPTION
- *
- *
+ *     This testcase verifies if the low priority SCHED_OTHER thread can preempt
+ *     the high priority SCHED_RR thread via priority inheritance.
  *
  * USAGE:
  *      Use run_auto.sh script in current directory to build and run test.
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index 4220aba..00f632b 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -20,8 +20,9 @@
  *      testpi-2.c
  *
  * DESCRIPTION
- *
- *
+ *      This testcase verifies if the low priority SCHED_RR thread can preempt
+ *      the high priority SCHED_RR thread multiple times via priority
+ *      inheritance.
  *
  * USAGE:
  *      Use run_auto.sh script in current directory to build and run test.
diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
index b3ea6ef..1330dfd 100644
--- a/testcases/realtime/func/pi-tests/testpi-5.c
+++ b/testcases/realtime/func/pi-tests/testpi-5.c
@@ -20,8 +20,8 @@
  *      testpi-5.c
  *
  * DESCRIPTION
- *
- *
+ *      This testcase verifies if a thread can lock the priority inheritance
+ *      mutex multiple times.
  *
  * USAGE:
  *      Use run_auto.sh script in current directory to build and run test.
diff --git a/testcases/realtime/func/pi-tests/testpi-6.c b/testcases/realtime/func/pi-tests/testpi-6.c
index 523ba13..19c06ea 100644
--- a/testcases/realtime/func/pi-tests/testpi-6.c
+++ b/testcases/realtime/func/pi-tests/testpi-6.c
@@ -20,8 +20,8 @@
  *      testpi-6.c
  *
  * DESCRIPTION
- *
- *
+ *      This testcase verifies if a thread can lock the robust mutex multiple
+ *      times.
  *
  * USAGE:
  *      Use run_auto.sh script in current directory to build and run test.
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
