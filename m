Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OHUJq-0000TX-B1
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:03:42 +0000
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OHUJo-0003lO-8n
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 04:03:42 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4R43Vtw004477
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:33:31 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4R43VCI3354724
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 09:33:31 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4R43UJF031898
	for <ltp-list@lists.sourceforge.net>; Thu, 27 May 2010 14:03:30 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 09:33:23 +0530
Message-Id: <1274933006-4754-3-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
References: <Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 2/5] realtime: code cleanup on pi-test 1
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

This patch cleans up the test so as to follow C coding style standards.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: John Stultz <johnstul@us.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-1.c |  348 ++++++++++++++-------------
 1 files changed, 183 insertions(+), 165 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index dc6081b..b503c0c 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -30,6 +30,7 @@
  *
  *
  * HISTORY
+ *      2010-04-22 Code cleanup by Gowrishankar
  *
  *
  *****************************************************************************/
@@ -48,23 +49,22 @@ pthread_barrier_t barrier;
 
 void usage(void)
 {
-        rt_help();
-        printf("testpi-1 specific options:\n");
+	rt_help();
+	printf("testpi-1 specific options:\n");
 }
 
 int parse_args(int c, char *v)
 {
-
-        int handled = 1;
-        switch (c) {
-                case 'h':
-                        usage();
-                        exit(0);
-                default:
-                        handled = 0;
-                        break;
-        }
-        return handled;
+	int handled = 1;
+	switch (c) {
+	case 'h':
+		usage();
+		exit(0);
+	default:
+		handled = 0;
+		break;
+	}
+	return handled;
 }
 
 int gettid(void)
@@ -72,173 +72,191 @@ int gettid(void)
 	return syscall(__NR_gettid);
 }
 
-typedef void* (*entrypoint_t)(void*);
+typedef void *(*entrypoint_t)(void *);
 
 #define THREAD_STOP    1
 
 pthread_mutex_t glob_mutex;
 
-void* func_nonrt(void* arg)
+void *func_nonrt(void *arg)
 {
-  struct thread* pthr = (struct thread* )arg;
-  int rc, i, j, tid = gettid();
-  cpu_set_t mask;
-  CPU_ZERO(&mask);
-  CPU_SET(0, &mask);
-
-  rc = sched_setaffinity(0, sizeof(mask), &mask);
-  if (rc < 0) {
-     printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
-     exit(-1);
-  }
-
-  printf("Thread %d started running with priority %d\n", tid, pthr->priority);
-  pthread_mutex_lock(&glob_mutex);
-  printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
-  /* Wait for other RT threads to start up */
-  pthread_barrier_wait(&barrier);
-
-  for (i=0;i<10000;i++) {
-    if (i%100 == 0) {
-      printf("Thread %d loop %d pthread pol %d pri %d\n", tid, i,  pthr->policy, pthr->priority);
-      fflush(NULL);
-    }
-    pthr->id++;
-    for (j=0;j<5000;j++) {
-      pthread_mutex_lock(&(pthr->mutex));
-      pthread_mutex_unlock(&(pthr->mutex));
-    }
-  }
-  pthread_mutex_unlock(&glob_mutex);
-  return NULL;
+	struct thread *pthr = (struct thread *)arg;
+	int rc, i, j, tid = gettid();
+	cpu_set_t mask;
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+
+	rc = sched_setaffinity(0, sizeof(mask), &mask);
+	if (rc < 0) {
+		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,\
+			strerror(rc));
+		exit(-1);
+	}
+
+	printf("Thread %d started running with priority %d\n", tid,\
+		pthr->priority);
+	pthread_mutex_lock(&glob_mutex);
+	printf("Thread %d at start pthread pol %d pri %d - Got global lock\n",\
+		tid, pthr->policy, pthr->priority);
+	/* Wait for other RT threads to start up */
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < 10000; i++) {
+		if (i%100 == 0) {
+			printf("Thread %d loop %d pthread pol %d pri %d\n",\
+				tid, i,  pthr->policy, pthr->priority);
+			fflush(NULL);
+		}
+		pthr->id++;
+		for (j = 0; j < 5000; j++) {
+			pthread_mutex_lock(&(pthr->mutex));
+			pthread_mutex_unlock(&(pthr->mutex));
+		}
+	}
+	pthread_mutex_unlock(&glob_mutex);
+	return NULL;
 }
 
-void* func_rt(void* arg)
+void *func_rt(void *arg)
 {
-  struct thread*  pthr = (struct thread* )arg;
-  int rc, i, j, tid = gettid();
-  cpu_set_t mask;
-  CPU_ZERO(&mask);
-  CPU_SET(0, &mask);
-
-  rc = sched_setaffinity(0, sizeof(mask), &mask);
-  if (rc < 0) {
-     printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
-     exit(-1);
-  }
-
-  printf("Thread %d started running with prio %d\n", tid, pthr->priority);
-  pthread_barrier_wait(&barrier);
-  pthread_mutex_lock(&glob_mutex);
-  printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
-
-  /* we just use the mutex as something to slow things down */
-  /* say who we are and then do nothing for a while.  The aim
-   * of this is to show that high priority threads make more
-   * progress than lower priority threads..
-   */
-  for (i=0;i<1000;i++) {
-    if (i%100 == 0) {
-      printf("Thread %d loop %d pthread pol %d pri %d\n", tid, i, pthr->policy, pthr->priority);
-      fflush(NULL);
-    }
-    pthr->id++;
-    for (j=0;j<5000;j++) {
-      pthread_mutex_lock(&(pthr->mutex));
-      pthread_mutex_unlock(&(pthr->mutex));
-    }
-  }
-  pthread_mutex_unlock(&glob_mutex);
-  return NULL;
+	struct thread *pthr = (struct thread *)arg;
+	int rc, i, j, tid = gettid();
+	cpu_set_t mask;
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+
+	rc = sched_setaffinity(0, sizeof(mask), &mask);
+	if (rc < 0) {
+		printf("Thread %d: Can't set affinity: %d %s\n", tid,\
+			rc, strerror(rc));
+		exit(-1);
+	}
+
+	printf("Thread %d started running with prio %d\n", tid, pthr->priority);
+	pthread_barrier_wait(&barrier);
+	pthread_mutex_lock(&glob_mutex);
+	printf("Thread %d at start pthread pol %d pri %d - Got global lock\n",
+		tid, pthr->policy, pthr->priority);
+
+	/* We just use the mutex as something to slow things down,
+	 * say who we are and then do nothing for a while.  The aim
+	 * of this is to show that high priority threads make more
+	 * progress than lower priority threads..
+	 */
+	for (i = 0; i < 1000; i++) {
+		if (i%100 == 0) {
+			printf("Thread %d loop %d pthread pol %d pri %d\n",\
+				tid, i, pthr->policy, pthr->priority);
+			fflush(NULL);
+		}
+		pthr->id++;
+		for (j = 0; j < 5000; j++) {
+			pthread_mutex_lock(&(pthr->mutex));
+			pthread_mutex_unlock(&(pthr->mutex));
+		}
+	}
+	pthread_mutex_unlock(&glob_mutex);
+	return NULL;
 }
 
-void* func_noise(void* arg)
+void *func_noise(void *arg)
 {
-  struct thread*  pthr = (struct thread* )arg;
-  int rc, i, j, tid = gettid();
-  cpu_set_t mask;
-  CPU_ZERO(&mask);
-  CPU_SET(0, &mask);
-
-  rc = sched_setaffinity(0, sizeof(mask), &mask);
-  if (rc < 0) {
-     printf("Thread %d: Can't set affinity: %d %s\n", tid, rc, strerror(rc));
-     exit(-1);
-  }
-
-  printf("Noise Thread %d started running with prio %d\n", tid, pthr->priority);
-  pthread_barrier_wait(&barrier);
-
-  for (i=0;i<10000;i++) {
-    if (i%100 == 0) {
-      printf("Noise Thread %d loop %d pthread pol %d pri %d\n", tid, i, pthr->policy, pthr->priority);
-      fflush(NULL);
-    }
-    pthr->id++;
-    for (j=0;j<5000;j++) {
-      pthread_mutex_lock(&(pthr->mutex));
-      pthread_mutex_unlock(&(pthr->mutex));
-    }
-  }
-  return NULL;
+	struct thread *pthr = (struct thread *)arg;
+	int rc, i, j, tid = gettid();
+	cpu_set_t mask;
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+
+	rc = sched_setaffinity(0, sizeof(mask), &mask);
+	if (rc < 0) {
+		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,\
+			strerror(rc));
+		exit(-1);
+	}
+
+	printf("Noise Thread %d started running with prio %d\n", tid,
+		pthr->priority);
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < 10000; i++) {
+		if (i%100 == 0) {
+			printf("Noise Thread %d loop %d pthread pol %d "\
+				"pri %d\n", tid, i, pthr->policy,\
+				pthr->priority);
+			fflush(NULL);
+		}
+		pthr->id++;
+		for (j = 0; j < 5000; j++) {
+			pthread_mutex_lock(&(pthr->mutex));
+			pthread_mutex_unlock(&(pthr->mutex));
+		}
+	}
+	return NULL;
 }
 
 /*
  * Test pthread creation at different thread priorities.
  */
-int main(int argc, char* argv[]) {
-  pthread_mutexattr_t mutexattr;
-  int i, retc, protocol, nopi = 0;
-  cpu_set_t mask;
-  CPU_ZERO(&mask);
-  CPU_SET(0, &mask);
-  setup();
-  
-  rt_init("h",parse_args,argc,argv);
-
-  if ((retc = pthread_barrier_init(&barrier, NULL, 5))) {
-    printf("pthread_barrier_init failed: %s\n", strerror(retc));
-    exit(retc);
-  }
-
-  retc = sched_setaffinity(0, sizeof(mask), &mask);
-  if (retc < 0) {
-     printf("Main Thread: Can't set affinity: %d %s\n", retc, strerror(retc));
-     exit(-1);
-  }
-  for (i=0;i<argc;i++) {
-    if (strcmp(argv[i],"nopi") == 0) nopi = 1;
-  }
-
-  printf("Start %s\n",argv[0]);
-
-  if (!nopi) {
-    if (pthread_mutexattr_init(&mutexattr) != 0) {
-      printf("Failed to init mutexattr\n");
-    }
-    if (pthread_mutexattr_setprotocol(&mutexattr, PTHREAD_PRIO_INHERIT) != 0) {
-      printf("Can't set protocol prio inherit\n");
-    }
-    if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0) {
-      printf("Can't get mutexattr protocol\n");
-    } else {
-      printf("protocol in mutexattr is %d\n", protocol);
-    }
-    if ((retc = pthread_mutex_init(&glob_mutex, &mutexattr)) != 0) {
-      printf("Failed to init mutex: %d\n", retc);
-    }
-  }
-
-  create_other_thread(func_nonrt,NULL); 
-  create_rr_thread(func_rt, NULL, 20); 
-  create_rr_thread(func_rt, NULL, 30); 
-  create_rr_thread(func_rt, NULL, 40); 
-  create_rr_thread(func_noise, NULL, 40); 
-
-  printf("Joining threads\n");
-  join_threads();
-  printf("Done\n");
-  printf("Criteria:Low Priority Thread should Preempt Higher Priority Noise Thread\n");
-
-  return 0;
+int main(int argc, char *argv[])
+{
+	pthread_mutexattr_t mutexattr;
+	int i, retc, protocol, nopi = 0;
+	cpu_set_t mask;
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+	setup();
+
+	rt_init("h", parse_args, argc, argv);
+
+	retc = pthread_barrier_init(&barrier, NULL, 5);
+	if (retc) {
+		printf("pthread_barrier_init failed: %s\n", strerror(retc));
+		exit(retc);
+	}
+
+	retc = sched_setaffinity(0, sizeof(mask), &mask);
+	if (retc < 0) {
+		printf("Main Thread: Can't set affinity: %d %s\n", retc,\
+			strerror(retc));
+		exit(-1);
+	}
+
+	for (i = 0; i < argc; i++) {
+		if (strcmp(argv[i], "nopi") == 0)
+			nopi = 1;
+	}
+
+	printf("Start %s\n", argv[0]);
+
+	if (!nopi) {
+		if (pthread_mutexattr_init(&mutexattr) != 0)
+			printf("Failed to init mutexattr\n");
+
+		if (pthread_mutexattr_setprotocol(&mutexattr,\
+			 PTHREAD_PRIO_INHERIT) != 0)
+			printf("Can't set protocol prio inherit\n");
+
+		if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
+			printf("Can't get mutexattr protocol\n");
+		else
+			printf("protocol in mutexattr is %d\n", protocol);
+
+		retc = pthread_mutex_init(&glob_mutex, &mutexattr);
+		if (retc != 0)
+			printf("Failed to init mutex: %d\n", retc);
+	}
+
+	create_other_thread(func_nonrt, NULL);
+	create_rr_thread(func_rt, NULL, 20);
+	create_rr_thread(func_rt, NULL, 30);
+	create_rr_thread(func_rt, NULL, 40);
+	create_rr_thread(func_noise, NULL, 40);
+
+	printf("Joining threads\n");
+	join_threads();
+	printf("Done\n");
+	printf("Criteria:Low Priority Thread should Preempt Higher Priority "\
+		"Noise Thread\n");
+
+	return 0;
 }
-- 
1.7.1


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
