Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VRh8l-0006rk-Qz
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 11:32:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VRh8k-0002WI-0p
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 11:32:19 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r93BWC7G010404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Oct 2013 07:32:12 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r93BWAKK025510
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Oct 2013 07:32:11 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  3 Oct 2013 13:32:04 +0200
Message-Id: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 1/3] pthread_attr_setschedpolicy/2-1.c: simplify error
	handling
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
To: ltp-list@lists.sourceforge.net

Remove all gotos and if there's error in any of pthread
functions exit immediately.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../interfaces/pthread_attr_setschedpolicy/2-1.c   |  105 +++++++-------------
 1 files changed, 34 insertions(+), 71 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
index 6088466..6c471d6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
@@ -24,6 +24,7 @@
 #include <string.h>
 #include <pthread.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <posixtest.h>
 
@@ -40,8 +41,10 @@ static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 
 static int thread_started;
 
-#define ERR_MSG(f, rc)	printf("Failed: function: %s status: %s(%u)\n", \
-						f, strerror(rc), rc)
+#define FAIL_AND_EXIT(f, rc) { \
+	printf("Failed: function: %s status: %s(%u)\n", f, strerror(rc), rc); \
+	exit(PTS_UNRESOLVED); \
+}
 
 static void *thread_func(void *data)
 {
@@ -50,23 +53,17 @@ static void *thread_func(void *data)
 	int rc;
 
 	rc = pthread_getschedparam(pthread_self(), &policy, &sp);
-	if (rc) {
-		ERR_MSG("pthread_getschedparam()", rc);
-		goto done;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_getschedparam()", rc);
 
 	thread_started = 1;
 	rc = pthread_cond_signal(&cond);
-	if (rc) {
-		ERR_MSG("pthread_cond_signal()", rc);
-		goto done;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_cond_signal()", rc);
 
 	rc = pthread_mutex_lock(&mutex);
-	if (rc) {
-		ERR_MSG("pthread_mutex_lock()", rc);
-		goto done;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_mutex_lock()", rc);
 
 	/* Stuff the priority in execution order */
 	if (!priorities[0])
@@ -77,79 +74,58 @@ static void *thread_func(void *data)
 		priorities[2] = sp.sched_priority;
 
 	rc = pthread_mutex_unlock(&mutex);
-	if (rc) {
-		ERR_MSG("pthread_mutex_unlock()", rc);
-		goto done;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_mutex_unlock()", rc);
 
-done:
 	return (void *)(long)rc;
 }
 
 static int create_thread(int prio, pthread_t * tid)
 {
 	int rc;
-	char *func;
 	struct sched_param sp;
 	pthread_attr_t attr;
 
-	func = "pthread_attr_init()";
 	rc = pthread_attr_init(&attr);
 	if (rc != 0)
-		goto done;
+		FAIL_AND_EXIT("pthread_attr_init()", rc);
 
-	func = "pthread_attr_setschedpolicy()";
 	rc = pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
 	if (rc != 0)
-		goto error;
+		FAIL_AND_EXIT("pthread_attr_setschedpolicy()", rc);
 
-	func = "pthread_attr_setinheritsched()";
 	rc = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
 	if (rc != 0)
-		goto error;
+		FAIL_AND_EXIT("pthread_attr_setinheritsched()", rc);
 
-	func = "pthread_attr_setschedparam()";
 	sp.sched_priority = prio;
 	rc = pthread_attr_setschedparam(&attr, &sp);
 	if (rc != 0)
-		goto error;
+		FAIL_AND_EXIT("pthread_attr_setschedparam()", rc);
 
 	thread_started = 0;
 
 	rc = pthread_create(tid, &attr, thread_func, NULL);
-	if (rc) {
-		ERR_MSG("pthread_create()", rc);
-		goto error;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_create()", rc);
 
 	while (!thread_started) {
-		func = "pthread_mutex_lock()";
 		rc = pthread_mutex_lock(&c_mutex);
 		if (rc)
-			goto error;
+			FAIL_AND_EXIT("pthread_mutex_lock()", rc);
 
-		func = "pthread_cond_wait()";
 		rc = pthread_cond_wait(&cond, &c_mutex);
 		if (rc)
-			goto unlock;
+			FAIL_AND_EXIT("pthread_cond_wait()", rc);
 
-		func = "pthread_mutex_unlock()";
 		rc = pthread_mutex_unlock(&c_mutex);
 		if (rc)
-			goto error;
+			FAIL_AND_EXIT("pthread_mutex_unlock()", rc);
 	}
 
 	pthread_attr_destroy(&attr);
 
 	return 0;
-
-unlock:
-	(void)pthread_mutex_unlock(&c_mutex);
-error:
-	pthread_attr_destroy(&attr);
-done:
-	ERR_MSG(func, rc);
-	return -1;
 }
 
 int main(void)
@@ -166,48 +142,36 @@ int main(void)
 	status = PTS_UNRESOLVED;
 
 	rc = pthread_mutex_lock(&mutex);
-	if (rc) {
-		ERR_MSG("pthread_mutex_lock()", rc);
-		goto done;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_mutex_lock()", rc);
 
 	rc = create_thread(PRIO_LOW, &t3);
 	if (rc)
-		goto done;
+		FAIL_AND_EXIT("create_thread LOW", rc);
 
 	rc = create_thread(PRIO_MED, &t2);
 	if (rc)
-		goto done;
+		FAIL_AND_EXIT("create_thread MED", rc);
 
 	rc = create_thread(PRIO_HIGH, &t1);
 	if (rc)
-		goto done;
+		FAIL_AND_EXIT("create_thread HIGH", rc);
 
 	rc = pthread_mutex_unlock(&mutex);
 	if (rc)
-		ERR_MSG("pthread_mutex_unlock()", rc);
+		FAIL_AND_EXIT("pthread_mutex_unlock()", rc);
 
 	rc = pthread_join(t1, &r1);
-	if (rc) {
-		ERR_MSG("pthread_join(t1)", rc);
-		goto done;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_join(t1)", rc);
 
 	rc = pthread_join(t2, &r2);
-	if (rc) {
-		ERR_MSG("pthread_join(t2)", rc);
-		goto done;
-	}
+	if (rc)
+		FAIL_AND_EXIT("pthread_join(t2)", rc);
 
 	rc = pthread_join(t3, &r3);
-	if (rc) {
-		ERR_MSG("pthread_join(t3)", rc);
-		goto done;
-	}
-
-	/* Threads fail? */
-	if ((long)r1 || (long)r2 || (long)r2)
-		goto done;
+	if (rc)
+		FAIL_AND_EXIT("pthread_join(t3)", rc);
 
 	/* priorities must be high to low */
 	status = PTS_FAIL;
@@ -223,7 +187,6 @@ int main(void)
 	else
 		status = PTS_PASS;
 
-done:
 	if (status == PTS_PASS)
 		printf("Test PASSED\n");
 
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
