Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OUZh9-0004ZH-Gf
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:51 +0000
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUZh8-0003yU-89
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:51 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp05.in.ibm.com (8.14.4/8.13.1) with ESMTP id o626PcxT004469
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:38 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o626PYab1130622
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o626PXQB004703
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 16:25:33 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Fri,  2 Jul 2010 11:55:27 +0530
Message-Id: <1278051930-4070-5-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 4/7] realtime/testpi-4: threads need not set cpu
	affinity while main does
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
 testcases/realtime/func/pi-tests/testpi-4.c |   36 ++------------------------
 1 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index 6a90771..0960c91 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
@@ -81,17 +81,7 @@ pthread_mutex_t *glob_mutex;
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
-		printf("Thread %d: Can't set affinity: %d %s\n",
-			tid, rc, strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Thread %d started running with priority %d\n", tid,
 		pthr->priority);
@@ -119,17 +109,7 @@ void *func_nonrt(void *arg)
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
-		printf("Thread %d: Can't set affinity: %d %s\n",
-			tid, rc, strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Thread %d started running with prio %d\n", tid,
 		pthr->priority);
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
-		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,
-			strerror(rc));
-		exit(-1);
-	}
+	int i, j, tid = gettid();
 
 	printf("Noise Thread started running with prio %d\n",
 		pthr->priority);
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
