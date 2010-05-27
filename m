Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHURb-0004Lp-E0
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:43 +0000
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHURa-0007Pr-64
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:43 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R4BXgl007125
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:33 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R4BXIx3006600
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R4BWjU021271
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:11:32 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:41:23 +0530
Message-Id: <1274933486-4876-4-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 3/6] realtime: threads need not set cpu affinity while
	main does
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

Since main() sets the cpu affinity, it is not necessary for the
spawned threads to do so, as the threads inherit the cpu affinity.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-1.c |   36 ++------------------------
 testcases/realtime/func/pi-tests/testpi-2.c |   36 ++------------------------
 2 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index 35df387..25541d7 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -81,17 +81,7 @@ pthread_mutex_t glob_mutex;
 void *func_nonrt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int rc, i, j, tid = gettid();
-	cpu_set_t mask;
-	CPU_ZERO(&mask);
-	CPU_SET(0, &mask);
-
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,\
-			strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Thread %d started running with priority %d\n", tid,\
 		pthr->priority);
@@ -120,17 +110,7 @@ void *func_nonrt(void *arg)
 void *func_rt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int rc, i, j, tid = gettid();
-	cpu_set_t mask;
-	CPU_ZERO(&mask);
-	CPU_SET(0, &mask);
-
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		printf("Thread %d: Can't set affinity: %d %s\n", tid,\
-			rc, strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Thread %d started running with prio %d\n", tid, pthr->priority);
 	pthread_barrier_wait(&barrier);
@@ -162,17 +142,7 @@ void *func_rt(void *arg)
 void *func_noise(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int rc, i, j, tid = gettid();
-	cpu_set_t mask;
-	CPU_ZERO(&mask);
-	CPU_SET(0, &mask);
-
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,\
-			strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Noise Thread %d started running with prio %d\n", tid,
 		pthr->priority);
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index 00f632b..eb00129 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -83,17 +83,7 @@ pthread_mutex_t glob_mutex;
 void *func_lowrt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int rc, i, j, tid = gettid();
-	cpu_set_t mask;
-	CPU_ZERO(&mask);
-	CPU_SET(0, &mask);
-
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,\
-			strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Thread %d started running with priority %d\n", tid,\
 		pthr->priority);
@@ -122,17 +112,7 @@ void *func_lowrt(void *arg)
 void *func_rt(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int rc, i, j, tid = gettid();
-	cpu_set_t mask;
-	CPU_ZERO(&mask);
-	CPU_SET(0, &mask);
-
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		printf("Thread %d: Can't set affinity: %d %s\n", tid,\
-			rc, strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Thread %d started running with prio %d\n", tid, pthr->priority);
 	pthread_barrier_wait(&barrier);
@@ -164,17 +144,7 @@ void *func_rt(void *arg)
 void *func_noise(void *arg)
 {
 	struct thread *pthr = (struct thread *)arg;
-	int rc, i, j, tid = gettid();
-	cpu_set_t mask;
-	CPU_ZERO(&mask);
-	CPU_SET(0, &mask);
-
-	rc = sched_setaffinity(0, sizeof(mask), &mask);
-	if (rc < 0) {
-		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,\
-			strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Noise Thread %d started running with prio %d\n", tid,\
 		pthr->priority);
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
