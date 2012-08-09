Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SzQ1L-0001FC-Aj
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:31:15 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SzQ1G-0000Hs-9K
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:31:15 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q79AV4Yj017191
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 9 Aug 2012 03:31:04 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Thu, 9 Aug 2012 18:30:56 +0800
Message-ID: <1344508258-25054-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
References: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/3] pthread_cond_signal/1-1: use sched_yield to sync
	threads
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
To: ltp-list@lists.sourceforge.net
Cc: Zhenfeng.Zhao@windriver.com

This case fails on mips board routerstation randomly. The root cause is
that when main thread call usleep(100) after signal the child threads,
no child thread is scheduled to run.  So the case fails.

I update it to set main thread with a lower priority and child threads
with a higher one, then call sched_yield and usleep in main thread will
make sure that one of the child threads will be scheduled.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../interfaces/pthread_cond_signal/1-1.c           |   44 +++++++++++++++++++-
 1 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
index bf55b31..77374bf 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_signal/1-1.c
@@ -12,6 +12,7 @@
 
 #define _XOPEN_SOURCE 600
 
+#include <errno.h>
 #include <pthread.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -20,6 +21,7 @@
 #include "posixtest.h"
 
 #define THREAD_NUM  3
+#define SCHED_POLICY SCHED_FIFO
 
 struct testdata
 {
@@ -77,6 +79,10 @@ int main()
 {
 	int i, rc;
 	struct sigaction act;
+	int pid;
+	int policy;
+	struct sched_param param;
+	pthread_attr_t attr;
 
 	if (pthread_mutex_init(&td.mutex, NULL) != 0) {
 		fprintf(stderr,"Fail to initialize mutex\n");
@@ -87,8 +93,35 @@ int main()
 		return PTS_UNRESOLVED;
 	}
 
+	pid = getpid();
+	param.sched_priority = sched_get_priority_min(SCHED_POLICY);
+	if (sched_setscheduler(pid, SCHED_POLICY, &param) != 0) {
+		fprintf(stderr, "Fail to set main thread scheduler.\n");
+		if (errno == EPERM)
+			fprintf(stderr, "Failed with EPERM: are you root?\n");
+		return PTS_UNRESOLVED;
+	}
+
+	if (pthread_attr_init(&attr) != 0) {
+		fprintf(stderr, "Fail to init child thread attribute.\n");
+		return PTS_UNRESOLVED;
+	}
+	if (pthread_attr_setschedpolicy(&attr, SCHED_POLICY) != 0) {
+		fprintf(stderr, "Fail to set child thread schedule policy attribute.\n");
+		return PTS_UNRESOLVED;
+	}
+	param.sched_priority += 10;
+	if (pthread_attr_setschedparam(&attr, &param) != 0) {
+		fprintf(stderr, "Fail to set child thread schedule priority attribute.\n");
+		return PTS_UNRESOLVED;
+	}
+	if (pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED) != 0) {
+		fprintf(stderr, "Fail to set child thread inheritace attribute.\n");
+		return PTS_UNRESOLVED;
+	}
+
 	for (i=0; i<THREAD_NUM; i++) {	/* create THREAD_NUM threads */
-	    	if (pthread_create(&thread[i], NULL, thr_func, NULL) != 0) {
+		if (pthread_create(&thread[i], &attr, thr_func, NULL) != 0) {
 			fprintf(stderr,"Fail to create thread[%d]\n", i);
 			exit(PTS_UNRESOLVED);
 		}
@@ -96,6 +129,8 @@ int main()
 	while (start_num < THREAD_NUM)	/* waiting for all threads started */
 		usleep(100);
 
+	pthread_attr_destroy(&attr);
+
 	/* Acquire the mutex to make sure that all waiters are currently
 	   blocked on pthread_cond_wait */
 	if (pthread_mutex_lock(&td.mutex) != 0) {
@@ -142,6 +177,7 @@ int main()
 			fprintf(stderr,"Main failed to signal the condition\n");
 			exit(PTS_UNRESOLVED);
 		}
+		sched_yield();
 		usleep(100);
 	}
 
@@ -158,6 +194,10 @@ int main()
 			exit(PTS_UNRESOLVED);
 		}
 	}
+
+	pthread_mutex_destroy(&td.mutex);
+	pthread_cond_destroy(&td.cond);
+
 	printf("Test PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
