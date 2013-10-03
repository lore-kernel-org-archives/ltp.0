Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VRh8n-0002MX-8z
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 11:32:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VRh8m-0007C6-Fj
	for ltp-list@lists.sourceforge.net; Thu, 03 Oct 2013 11:32:21 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r93BWERI014116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Oct 2013 07:32:14 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r93BWAKL025510
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Oct 2013 07:32:13 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  3 Oct 2013 13:32:05 +0200
Message-Id: <1f03930f721cfec46a30d523a0447672a1ba6049.1380794505.git.jstancek@redhat.com>
In-Reply-To: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
References: <8803687faf31650b5174df670f07014a7a2f7532.1380794505.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/3] pthread_attr_setschedpolicy/2-1.c: fix race at
	thread startup
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

Test can hang during startup in following scenario:

                    main                                       new thread
--------------------------------------------------+-------------------------------------
int create_thread(int prio, pthread_t * tid)      |
...                                               |
    pthread_create(tid, &attr, thread_func, NULL);|
        while (!thread_started) {                 |
                                                  |   void *thread_func(void *data)
                                                  |        thread_started = 1;
                                                  |        pthread_cond_signal(&cond);
            pthread_mutex_lock(&c_mutex);         |
132:        pthread_cond_wait(&cond, &c_mutex);   |
                                                  |65:     pthread_mutex_lock(&mutex);
                                                  |

(gdb) bt
 #0  0x00007fd588808f6d in __lll_lock_wait () from /lib64/libpthread.so.0
 #1  0x00007fd588804d31 in _L_lock_790 () from /lib64/libpthread.so.0
 #2  0x00007fd588804c37 in pthread_mutex_lock () from /lib64/libpthread.so.0
 #3  0x0000000000400bba in thread_func (data=0x0) at ../../../conformance/interfaces/pthread_attr_setschedpolicy/2-1.c:65
 #4  0x00007fd588802de3 in start_thread () from /lib64/libpthread.so.0
 #5  0x00007fd5885300dd in clone () from /lib64/libc.so.6
(gdb) t 2
(gdb) bt
 #0  0x00007fd5888066f5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
 #1  0x0000000000400d9b in create_thread (prio=5, tid=0x7fffdb562678) at ../../../conformance/interfaces/pthread_attr_setschedpolicy/2-1.c:132
 #2  0x0000000000400e82 in main () at ../../../conformance/interfaces/pthread_attr_setschedpolicy/2-1.c:174

Fix this by using same c_mutex in thread_func for updating
thread_started and signalling cond.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../interfaces/pthread_attr_setschedpolicy/2-1.c   |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
index 6c471d6..80ce906 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedpolicy/2-1.c
@@ -56,10 +56,16 @@ static void *thread_func(void *data)
 	if (rc)
 		FAIL_AND_EXIT("pthread_getschedparam()", rc);
 
+	rc = pthread_mutex_lock(&c_mutex);
+	if (rc)
+		FAIL_AND_EXIT("pthread_mutex_lock()", rc);
 	thread_started = 1;
 	rc = pthread_cond_signal(&cond);
 	if (rc)
 		FAIL_AND_EXIT("pthread_cond_signal()", rc);
+	rc = pthread_mutex_unlock(&c_mutex);
+	if (rc)
+		FAIL_AND_EXIT("pthread_mutex_unlock()", rc);
 
 	rc = pthread_mutex_lock(&mutex);
 	if (rc)
@@ -109,19 +115,17 @@ static int create_thread(int prio, pthread_t * tid)
 	if (rc)
 		FAIL_AND_EXIT("pthread_create()", rc);
 
+	rc = pthread_mutex_lock(&c_mutex);
+	if (rc)
+		FAIL_AND_EXIT("pthread_mutex_lock()", rc);
 	while (!thread_started) {
-		rc = pthread_mutex_lock(&c_mutex);
-		if (rc)
-			FAIL_AND_EXIT("pthread_mutex_lock()", rc);
-
 		rc = pthread_cond_wait(&cond, &c_mutex);
 		if (rc)
 			FAIL_AND_EXIT("pthread_cond_wait()", rc);
-
-		rc = pthread_mutex_unlock(&c_mutex);
-		if (rc)
-			FAIL_AND_EXIT("pthread_mutex_unlock()", rc);
 	}
+	rc = pthread_mutex_unlock(&c_mutex);
+	if (rc)
+		FAIL_AND_EXIT("pthread_mutex_unlock()", rc);
 
 	pthread_attr_destroy(&attr);
 
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
