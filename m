Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MfiPC-0002Y3-H0
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:52:50 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfiP5-0003v4-8P
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 22:52:50 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7OMDDWp013573
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:13:13 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7OMEOn3181148
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:14:24 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7OMEOhs023094
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Aug 2009 18:14:24 -0400
Message-ID: <4A9310BE.8050109@us.ibm.com>
Date: Mon, 24 Aug 2009 15:14:22 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH][realtime] prio-wake: allow for optional locking prior
 to broadcast
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
Cc: Gowrishankar <gowrishankar.m@in.ibm.com>, Vernon Mauery <vernux@us.ibm.com>


prio-wake: allow for optional locking prior to broadcast

Allow the user to decide if the mutex should be held prior to
calling pthread_cond_broadcast().  Default remains the same.
Tested with and without the argument as well as with both 0 and 1
passed to the argument. Values other than 0 and 1 will result in locking
the mutex.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
Acked-By: Dinakar Guniguntala <dino@in.ibm.com>
Acked-by: Vernon Mauery <vernux@us.ibm.com>
Acked-by: Gowrishankar <gowrishankar.m@in.ibm.com>

---
 func/prio-wake/prio-wake.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Index: realtime/func/prio-wake/prio-wake.c
===================================================================
--- realtime.orig/func/prio-wake/prio-wake.c
+++ realtime/func/prio-wake/prio-wake.c
@@ -56,6 +56,7 @@
 #include <librttest.h>
 volatile int running_threads = 0;
 static int rt_threads = 0;
+static int locked_broadcast = 1;
 static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t mutex;
 static volatile nsec_t beginrun;
@@ -67,6 +68,8 @@ void usage(void)
         rt_help();
         printf("prio-wake specific options:\n");
         printf("  -n#           #: number of worker threads\n");
+        printf("  -l#           1:lock the mutex before broadcast, 0:don't\n");
+	printf("                defaults to 1\n");
 }
 
 int parse_args(int c, char *v)
@@ -80,6 +83,9 @@ int parse_args(int c, char *v)
                 case 'n':
                         rt_threads = atoi(v);
                         break;
+                case 'l':
+                        locked_broadcast = atoi(v);
+                        break;
                 default:
                         handled = 0;
                         break;
@@ -106,9 +112,11 @@ void *master_thread(void* arg)
 
 	printf("%08lld us: Master thread about to wake the workers\n", start/NS_PER_US);
 	/* start the children threads */
-	rc = pthread_mutex_lock(&mutex);
+	if (locked_broadcast)
+		rc = pthread_mutex_lock(&mutex);
 	rc = pthread_cond_broadcast(&cond);
-	rc = pthread_mutex_unlock(&mutex);
+	if (locked_broadcast)
+		rc = pthread_mutex_unlock(&mutex);
 
 	while (running_threads > 0)
 		sleep(1);
@@ -161,7 +169,7 @@ int main(int argc, char* argv[])
 	int i;
 	setup();
 
-        rt_init("hn:", parse_args, argc, argv);
+        rt_init("hn:l:", parse_args, argc, argv);
 
 	if (rt_threads == 0) {
 		numcpus = sysconf(_SC_NPROCESSORS_ONLN);
@@ -172,7 +180,9 @@ int main(int argc, char* argv[])
 	printf("\n-----------------------\n");
 	printf("Priority Ordered Wakeup\n");
 	printf("-----------------------\n");
-	printf("Worker Threads: %d\n\n", rt_threads);
+	printf("Worker Threads: %d\n", rt_threads);
+	printf("Calling pthread_cond_broadcast() with mutex: %s\n\n",
+	       locked_broadcast ? "LOCKED" : "UNLOCKED");
 
 	pri_boost = 3;
 
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
