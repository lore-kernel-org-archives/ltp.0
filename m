Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OUZh4-0007lW-Mu
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:46 +0000
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUZh3-00007c-7o
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:46 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id o626PZbu017448
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:35 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o626PYqE819378
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o626PXJq004727
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 16:25:34 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Fri,  2 Jul 2010 11:55:28 +0530
Message-Id: <1278051930-4070-6-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 5/7] realtime/testpi-4: use busy_work_ms from
	librttest to burn cpu cycles
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

Instead of lock/unlock of mutex to burn cpu cycles, we can use busy_work_ms
from librttest which is more explicit (burn cycles, not provide some
synchronization).

Also this patch removes the id increment since it is not used.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-4.c |   24 ++++++------------------
 1 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index 0960c91..5a39701 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
@@ -81,7 +81,7 @@ pthread_mutex_t *glob_mutex;
 void *func_nonrt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Thread %d started running with priority %d\n", tid,
 		pthr->priority);
@@ -96,11 +96,7 @@ void *func_nonrt(void *arg)
 				tid, i, pthr->policy, pthr->priority);
 			fflush(NULL);
 		}
-		pthr->id++;
-		for (j = 0; j < 5000; j++) {
-			pthread_mutex_lock(&(pthr->mutex));
-			pthread_mutex_unlock(&(pthr->mutex));
-		}
+		busy_work_ms(1);
 	}
 	pthread_mutex_unlock(glob_mutex);
 	return NULL;
@@ -109,7 +105,7 @@ void *func_nonrt(void *arg)
 void *func_rt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Thread %d started running with prio %d\n", tid,
 		pthr->priority);
@@ -129,11 +125,7 @@ void *func_rt(void *arg)
 				tid, i, pthr->policy, pthr->priority);
 			fflush(NULL);
 		}
-		pthr->id++;
-		for (j = 0; j < 5000; j++) {
-			pthread_mutex_lock(&(pthr->mutex));
-			pthread_mutex_unlock(&(pthr->mutex));
-		}
+		busy_work_ms(1);
 	}
 	pthread_mutex_unlock(glob_mutex);
 	return NULL;
@@ -142,7 +134,7 @@ void *func_rt(void *arg)
 void *func_noise(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Noise Thread started running with prio %d\n",
 		pthr->priority);
@@ -155,11 +147,7 @@ void *func_noise(void *arg)
 				pthr->priority);
 			fflush(NULL);
 		}
-		pthr->id++;
-		for (j = 0; j < 5000; j++) {
-			pthread_mutex_lock(&(pthr->mutex));
-			pthread_mutex_unlock(&(pthr->mutex));
-		}
+		busy_work_ms(1);
 	}
 	return NULL;
 }
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
