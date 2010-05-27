Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHURg-00070Z-0w
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:48 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHURb-0006Cg-Mu
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:47 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R3D1vg026979
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 08:43:01 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R4BXWx3023042
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R4BXOE021301
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:11:33 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:41:24 +0530
Message-Id: <1274933486-4876-5-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 4/6] realtime: use busy_work_ms from librttest to burn
	cpu cycles
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
Acked-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-1.c |   24 ++++++------------------
 testcases/realtime/func/pi-tests/testpi-2.c |   24 ++++++------------------
 2 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index 25541d7..71b01ec 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -81,7 +81,7 @@ pthread_mutex_t glob_mutex;
 void *func_nonrt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Thread %d started running with priority %d\n", tid,\
 		pthr->priority);
@@ -97,11 +97,7 @@ void *func_nonrt(void *arg)
 				tid, i,  pthr->policy, pthr->priority);
 			fflush(NULL);
 		}
-		pthr->id++;
-		for (j = 0; j < 5000; j++) {
-			pthread_mutex_lock(&(pthr->mutex));
-			pthread_mutex_unlock(&(pthr->mutex));
-		}
+		busy_work_ms(1);
 	}
 	pthread_mutex_unlock(&glob_mutex);
 	return NULL;
@@ -110,7 +106,7 @@ void *func_nonrt(void *arg)
 void *func_rt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Thread %d started running with prio %d\n", tid, pthr->priority);
 	pthread_barrier_wait(&barrier);
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
 	pthread_mutex_unlock(&glob_mutex);
 	return NULL;
@@ -142,7 +134,7 @@ void *func_rt(void *arg)
 void *func_noise(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Noise Thread %d started running with prio %d\n", tid,
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
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index eb00129..68dde44 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -83,7 +83,7 @@ pthread_mutex_t glob_mutex;
 void *func_lowrt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Thread %d started running with priority %d\n", tid,\
 		pthr->priority);
@@ -99,11 +99,7 @@ void *func_lowrt(void *arg)
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
 	pthread_mutex_unlock(&glob_mutex);
 	return NULL;
@@ -112,7 +108,7 @@ void *func_lowrt(void *arg)
 void *func_rt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Thread %d started running with prio %d\n", tid, pthr->priority);
 	pthread_barrier_wait(&barrier);
@@ -131,11 +127,7 @@ void *func_rt(void *arg)
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
 	pthread_mutex_unlock(&glob_mutex);
 	return NULL;
@@ -144,7 +136,7 @@ void *func_rt(void *arg)
 void *func_noise(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int i, j, tid = gettid();
+	int i, tid = gettid();
 
 	printf("Noise Thread %d started running with prio %d\n", tid,\
 		pthr->priority);
@@ -157,11 +149,7 @@ void *func_noise(void *arg)
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

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
