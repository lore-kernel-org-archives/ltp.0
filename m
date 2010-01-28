Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1NaaDR-0000sX-4Z
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 19:39:45 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NaaDQ-0005yn-A5
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 19:39:45 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0SJWwno030986
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jan 2010 14:32:58 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0SJdbxd1659134
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jan 2010 14:39:37 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0SJdbli022528
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jan 2010 14:39:37 -0500
Message-ID: <4B61E7F7.3000502@us.ibm.com>
Date: Thu, 28 Jan 2010 11:39:35 -0800
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] prio-wake: avoid glibc to kernel sleep race
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

prio-wake: avoid glibc to kernel sleep race

In the unlocked broadcast scenario, there exists a race between when the
running_threads variable reaches rt_threads and when the last worker_thread
blocks in the kernel after a cond_wait(). It is possible for a thread to miss
the broadcast if it fails to sleep before the broadcast is issued.  

The previous code did not guarantee a small window of time to allow the threads
to get to sleep.  It also used an unreasonably large sleep time which
unnecessarily extended the length of the test run time.  This patch ensures some
time is given to the threads to get to sleep and at the same time uses a much
shorter (1000x) sleep period which results in a 50-100x reduction in test run
time. Lastly, two unecessary loops waiting for the threads to complete were
removed, relying on pthread_join() instead to wait for the threads to complete.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>

---
 func/prio-wake/prio-wake.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: realtime/func/prio-wake/prio-wake.c
===================================================================
--- realtime.orig/func/prio-wake/prio-wake.c
+++ realtime/func/prio-wake/prio-wake.c
@@ -108,7 +108,10 @@ void *master_thread(void* arg)
 
 	/* make sure children are started */
 	while (running_threads < rt_threads)
-		sleep(1);
+		usleep(1000);
+	/* give the worker threads a chance to get to sleep in the kernel
+	 * in the unlocked broadcast case. */
+	usleep(1000);
 
 	start = rt_gettime() - beginrun;
 
@@ -120,8 +123,6 @@ void *master_thread(void* arg)
 	if (locked_broadcast)
 		rc = pthread_mutex_unlock(&mutex);
 
-	while (running_threads > 0)
-		sleep(1);
 	return NULL;
 }
 
@@ -157,9 +158,6 @@ void *worker_thread(void* arg)
 
 	rc = pthread_mutex_unlock(&mutex);
 
-	/* wait for all threads to quit */
-	while (running_threads > 0)
-		sleep(1);
 	return NULL;
 }
 
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
