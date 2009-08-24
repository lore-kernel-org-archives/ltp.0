Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MfiDG-00034s-9L
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:40:30 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfiDA-0000oI-4j
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:40:30 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7OMGU2x014501
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:16:30 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7OMGm1t248180
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:16:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7OMDnaN020829
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:13:50 -0400
Message-ID: <4A93114B.4000809@us.ibm.com>
Date: Mon, 24 Aug 2009 15:16:43 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH][realtime] prio-wake: enable using more than 95 threads
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Gowrishankar <gowrishankar.m@in.ibm.com>, vernux@us.ibm.com


prio-wake: enable using more than 95 threads

prio-wake will currently spew pthread errors on systems with more
than 95 CPUS, or if an -n value > 95 is specified on the command line.
To avoid this, spread threads out equally over the priorities by
calculated the number of threads per priority.

Tested with all pathological numbers (i.e. mod=0 mod=1, etc) of threads.
Ran 10000 times in parallel.  Confirmed failure continues to exist without
requeue PI (as it should) and success is seen with requeue PI 
(as it should be).

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-By: Dinakar Guniguntala <dino@in.ibm.com>
Acked-by: Vernon Mauery <vernux@us.ibm.com>
Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>

---
 func/prio-wake/prio-wake.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

Index: realtime/func/prio-wake/prio-wake.c
===================================================================
--- realtime.orig/func/prio-wake/prio-wake.c
+++ realtime/func/prio-wake/prio-wake.c
@@ -54,6 +54,8 @@
 #include <errno.h>
 #include <sys/syscall.h>
 #include <librttest.h>
+#include <libstats.h>
+
 volatile int running_threads = 0;
 static int rt_threads = 0;
 static int locked_broadcast = 1;
@@ -164,8 +166,10 @@ void *worker_thread(void* arg)
 
 int main(int argc, char* argv[])
 {
-	int pri_boost;
+	int threads_per_prio;
         int numcpus;
+	int numprios;
+	int prio;
 	int i;
 	setup();
 
@@ -184,19 +188,29 @@ int main(int argc, char* argv[])
 	printf("Calling pthread_cond_broadcast() with mutex: %s\n\n",
 	       locked_broadcast ? "LOCKED" : "UNLOCKED");
 
-	pri_boost = 3;
-
 	beginrun = rt_gettime();
 
 	init_pi_mutex(&mutex);
 
+	/* calculate the number of threads per priority */
+	/* we get num numprios -1 for the workers, leaving one for the master */
+	numprios = sched_get_priority_max(SCHED_FIFO) -
+		   sched_get_priority_min(SCHED_FIFO);
+
+	threads_per_prio = rt_threads /	numprios;
+	if (rt_threads % numprios)
+		threads_per_prio++;
+
 	/* start the worker threads */
+	prio = sched_get_priority_min(SCHED_FIFO);
 	for (i = rt_threads; i > 0; i--) {
-		create_fifo_thread(worker_thread, (void*)(intptr_t)i, sched_get_priority_min(SCHED_FIFO) + pri_boost++);
+		if ((i != rt_threads && (i % threads_per_prio) == 0))
+			prio++;
+		create_fifo_thread(worker_thread, (void*)(intptr_t)i, prio);
 	}
 
 	/* start the master thread */
-	create_fifo_thread(master_thread, (void*)(intptr_t)i, sched_get_priority_min(SCHED_FIFO) + pri_boost);
+	create_fifo_thread(master_thread, (void*)(intptr_t)i, ++prio);
 
 	/* wait for threads to complete */
 	join_threads();
-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
