Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHURd-0002Yl-Tf
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:45 +0000
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHURc-0007Q5-Bs
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:11:45 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R4BZiK015180
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:35 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R4BZud3576056
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:41:35 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R4BZms021367
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:11:35 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:41:26 +0530
Message-Id: <1274933486-4876-7-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 6/6] realtime: synchronization fixes for high priority
	noise thread
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

In a scenario where high priority noise thread is not scheduled after the
barrier but some other real-time thread, the test intention gets broken by
the test code, as priority inversion will never happen. We need to tightly
synchronize the threads so the noise thread always begins the test so that
it gets preempted by low prio thread through PI logic and is done with
conditional variables.

This change is applied on both the tests testpi-1 and testpi-2.
Signed-off-by: Gowrishankar<gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar<gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-1.c |   23 +++++++++++++++++++++--
 testcases/realtime/func/pi-tests/testpi-2.c |   24 ++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index 3e05e56..5d18f29 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -30,8 +30,9 @@
  *
  *
  * HISTORY
- *      2010-04-22 Code cleanup by Gowrishankar
- *
+ *      2010-04-22 Code cleanup and thread synchronization changes by using
+ *                 conditional variables,
+ *                 by Gowrishankar(gowrishankar.m@in.ibm.com).
  *
  *****************************************************************************/
 
@@ -74,6 +75,8 @@ int gettid(void)
 
 typedef void *(*entrypoint_t)(void *);
 pthread_mutex_t glob_mutex;
+static pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t cond_var = PTHREAD_COND_INITIALIZER;
 
 void *func_nonrt(void *arg)
 {
@@ -88,6 +91,11 @@ void *func_nonrt(void *arg)
 	/* Wait for other RT threads to start up */
 	pthread_barrier_wait(&barrier);
 
+	/* Wait for the high priority noise thread to start and signal us */
+	pthread_mutex_lock(&cond_mutex);
+	pthread_cond_wait(&cond_var, &cond_mutex);
+	pthread_mutex_unlock(&cond_mutex);
+
 	for (i = 0; i < 10000; i++) {
 		if (i%100 == 0) {
 			printf("Thread %d loop %d pthread pol %d pri %d\n",\
@@ -137,6 +145,14 @@ void *func_noise(void *arg)
 		pthr->priority);
 	pthread_barrier_wait(&barrier);
 
+	/* Let others wait at conditional variable */
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
@@ -197,5 +213,8 @@ int main(int argc, char *argv[])
 	printf("Criteria:Low Priority Thread should Preempt Higher Priority "\
 		"Noise Thread\n");
 
+	pthread_mutex_destroy(&glob_mutex);
+	pthread_mutex_destroy(&cond_mutex);
+	pthread_cond_destroy(&cond_var);
 	return 0;
 }
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index f0e86ea..55b391b 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -31,8 +31,9 @@
  *
  *
  * HISTORY
- *      2010-04-22 Code cleanup by Gowrishankar
- *
+ *      2010-04-22 Code cleanup and thread synchronization changes by using
+ *                 conditional variables,
+ *                 by Gowrishankar(gowrishankar.m@in.ibm.com).
  *
  *****************************************************************************/
 
@@ -76,6 +77,8 @@ int gettid(void)
 
 typedef void *(*entrypoint_t)(void *);
 pthread_mutex_t glob_mutex;
+static pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t cond_var = PTHREAD_COND_INITIALIZER;
 
 void *func_lowrt(void *arg)
 {
@@ -90,6 +93,11 @@ void *func_lowrt(void *arg)
 	/* Wait for other RT threads to start up */
 	pthread_barrier_wait(&barrier);
 
+	/* Wait for the high priority noise thread to start and signal us */
+	pthread_mutex_lock(&cond_mutex);
+	pthread_cond_wait(&cond_var, &cond_mutex);
+	pthread_mutex_unlock(&cond_mutex);
+
 	for (i = 0; i < 10000; i++) {
 		if (i%100 == 0) {
 			printf("Thread %d loop %d pthread pol %d pri %d\n",\
@@ -139,6 +147,14 @@ void *func_noise(void *arg)
 		pthr->priority);
 	pthread_barrier_wait(&barrier);
 
+	/* Let others wait at conditional variable */
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
@@ -197,5 +213,9 @@ int main(int argc, char *argv[])
 	printf("Done\n");
 	printf("Criteria: Low Priority Thread and High Priority Thread "\
 		"should prempt each other multiple times\n");
+
+	pthread_mutex_destroy(&glob_mutex);
+	pthread_mutex_destroy(&cond_mutex);
+	pthread_cond_destroy(&cond_var);
 	return 0;
 }
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
