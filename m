Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1NaaCg-0000oO-B7
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 19:38:58 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NaaCf-0006cG-90
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 19:38:58 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SJWBHY030398
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jan 2010 14:32:11 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0SJcoYb125328
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jan 2010 14:38:50 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0SJcodw020086
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jan 2010 14:38:50 -0500
Message-ID: <4B61E7C8.9090602@us.ibm.com>
Date: Thu, 28 Jan 2010 11:38:48 -0800
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] prio-wake: enable using more than 95 threads
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
To: ltp-list <ltp-list@lists.sourceforge.net>, Dinakar Guniguntala <dino@in.ibm.com>, Vernon Mauery <vernux@us.ibm.com>, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

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
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
