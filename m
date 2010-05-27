Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHURc-00070B-0G
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:44 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHURa-0006Cc-OF
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:43 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R4BZ8x010851
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:35 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R4BYRW3375158
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R4BYda021336
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:11:34 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:41:25 +0530
Message-Id: <1274933486-4876-6-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 5/6] realtime: remove thread_stop which is not used
	anywhere
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

Tests testpi-1 and testpi-2 defines THREAD_STOP which is not used anywhere in
the program.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-1.c |    3 ---
 testcases/realtime/func/pi-tests/testpi-2.c |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index 71b01ec..3e05e56 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -73,9 +73,6 @@ int gettid(void)
 }
 
 typedef void *(*entrypoint_t)(void *);
-
-#define THREAD_STOP    1
-
 pthread_mutex_t glob_mutex;
 
 void *func_nonrt(void *arg)
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index 68dde44..f0e86ea 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -75,9 +75,6 @@ int gettid(void)
 }
 
 typedef void *(*entrypoint_t)(void *);
-
-#define THREAD_STOP    1
-
 pthread_mutex_t glob_mutex;
 
 void *func_lowrt(void *arg)
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
