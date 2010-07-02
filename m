Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OUZh3-0007lP-UL
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:45 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUZh2-0002Po-F3
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:45 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id o626PZib025898
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:35 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o626PYJ51310874
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:34 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o626PYj6004757
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 16:25:34 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Fri,  2 Jul 2010 11:55:30 +0530
Message-Id: <1278051930-4070-8-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 7/7] realtime/testpi-4: synchronization fixes for high
	priority noise thread
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

In a scenario where a thread other than high priority noise thread is
scheduled after the barrier, a priority inversion will not occur, defeating
the purpose of test. We need to tightly synchronize the threads so that the
noise thread always begins the test and gets preempted by the low prio thread
through the PI logic.

This change is applied on testpi-4.
Signed-off-by: Gowrishankar<gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar<gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-4.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index 3bd5d77..63f8430 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
@@ -30,7 +30,9 @@
  *
  *
  * HISTORY
- *
+ *      2010-06-29 Thread synchronization changes by using
+ *                 conditional variables by Gowrishankar.
+ *                 by Gowrishankar <gowrishankar.m@in.ibm.com>
  *
  *****************************************************************************/
 
@@ -74,6 +76,8 @@ int gettid(void)
 
 typedef void *(*entrypoint_t)(void *);
 pthread_mutex_t *glob_mutex;
+static pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t cond_var = PTHREAD_COND_INITIALIZER;
 
 void *func_nonrt(void *arg)
 {
@@ -85,8 +89,15 @@ void *func_nonrt(void *arg)
 	pthread_mutex_lock(glob_mutex);
 	printf("Thread %d at start pthread pol %d pri %d - Got global lock\n",
 		tid, pthr->policy, pthr->priority);
+
+	/* Wait for other RT threads to start up */
 	pthread_barrier_wait(&barrier);
 
+	/* Wait for the high priority noise thread to start and signal us */
+	pthread_mutex_lock(&cond_mutex);
+	pthread_cond_wait(&cond_var, &cond_mutex);
+	pthread_mutex_unlock(&cond_mutex);
+
 	for (i = 0; i < 10000; i++) {
 		if (i%100 == 0) {
 			printf("Thread %d loop %d pthread pol %d pri %d\n",
@@ -137,6 +148,14 @@ void *func_noise(void *arg)
 		pthr->priority);
 	pthread_barrier_wait(&barrier);
 
+	/* Give the other threads time to wait on the condition variable.*/
+	usleep(1000);
+
+	/* Noise thread begins the test */
+	pthread_mutex_lock(&cond_mutex);
+	pthread_cond_broadcast(&cond_var);
+	pthread_mutex_unlock(&cond_mutex);
+
 	for (i = 0; i < 10000; i++) {
 		if (i%100 == 0) {
 			printf("Noise Thread %d loop %d pthread pol %d "\
@@ -200,5 +219,8 @@ int main(int argc, char *argv[])
 	join_threads();
 	printf("Done\n");
 
+	pthread_mutex_destroy(glob_mutex);
+	pthread_mutex_destroy(&cond_mutex);
+	pthread_cond_destroy(&cond_var);
 	return 0;
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
