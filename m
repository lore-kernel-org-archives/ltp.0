Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1OUZh4-0004YV-AM
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:46 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUZh2-0002Pq-Lr
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:25:46 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id o626OAft014922
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:54:10 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o626PXsd4096134
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 11:55:33 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o626PXNC004684
	for <ltp-list@lists.sourceforge.net>; Fri, 2 Jul 2010 16:25:33 +1000
From: Gowrishankar <gomuthuk@linux.vnet.ibm.com>
Date: Fri,  2 Jul 2010 11:55:24 +0530
Message-Id: <1278051930-4070-2-git-send-email-gomuthuk@linux.vnet.ibm.com>
In-Reply-To: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
References: <1278051930-4070-1-git-send-email-gomuthuk@linux.vnet.ibm.com>
Subject: [LTP] [PATCH 1/7] realtime/testpi-4: code cleanup on pi-test 4
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

This patch cleans up the testpi-4 so as to follow the
C coding style standards.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Darren Hart <dvhltc@us.ibm.com>
---
 testcases/realtime/func/pi-tests/testpi-4.c |  356 ++++++++++++++-------------
 1 files changed, 186 insertions(+), 170 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index 1756588..bde3ded 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
@@ -49,201 +49,217 @@ pthread_barrier_t barrier;
 
 void usage(void)
 {
-        rt_help();
-        printf("testpi-4 specific options:\n");
+	rt_help();
+	printf("testpi-4 specific options:\n");
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
 {
-        return syscall(__NR_gettid);
+	return syscall(__NR_gettid);
 }
 
-typedef void* (*entrypoint_t)(void*);
+typedef void *(*entrypoint_t)(void *);
 
 #define THREAD_STOP    1
 
 pthread_mutex_t *glob_mutex;
 
-void* func_nonrt(void* arg)
+void *func_nonrt(void *arg)
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
-  printf("Thread %d started running with priority %d\n", tid, pthr->priority);
-  pthread_mutex_lock(glob_mutex);
-  printf("Thread %d at start pthread pol %d pri %d - Got global lock\n", tid, pthr->policy, pthr->priority);
-  pthread_barrier_wait(&barrier);
-
-  for (i=0;i<10000;i++) {
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
-  pthread_mutex_unlock(glob_mutex);
-  return NULL;
+	struct thread *pthr = (struct thread *)arg;
+	int rc, i, j, tid = gettid();
+	cpu_set_t mask;
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+
+	rc = sched_setaffinity(0, sizeof(mask), &mask);
+	if (rc < 0) {
+		printf("Thread %d: Can't set affinity: %d %s\n",
+			tid, rc, strerror(rc));
+		exit(-1);
+	}
+
+	printf("Thread %d started running with priority %d\n", tid,
+		pthr->priority);
+	pthread_mutex_lock(glob_mutex);
+	printf("Thread %d at start pthread pol %d pri %d - Got global lock\n",
+		tid, pthr->policy, pthr->priority);
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < 10000; i++) {
+		if (i%100 == 0) {
+			printf("Thread %d loop %d pthread pol %d pri %d\n",
+				tid, i, pthr->policy, pthr->priority);
+			fflush(NULL);
+		}
+		pthr->id++;
+		for (j = 0; j < 5000; j++) {
+			pthread_mutex_lock(&(pthr->mutex));
+			pthread_mutex_unlock(&(pthr->mutex));
+		}
+	}
+	pthread_mutex_unlock(glob_mutex);
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
-  pthread_mutex_lock(glob_mutex);
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
-  pthread_mutex_unlock(glob_mutex);
-  return NULL;
+	struct thread *pthr = (struct thread *)arg;
+	int rc, i, j, tid = gettid();
+	cpu_set_t mask;
+	CPU_ZERO(&mask);
+	CPU_SET(0, &mask);
+
+	rc = sched_setaffinity(0, sizeof(mask), &mask);
+	if (rc < 0) {
+		printf("Thread %d: Can't set affinity: %d %s\n",
+			tid, rc, strerror(rc));
+		exit(-1);
+	}
+
+	printf("Thread %d started running with prio %d\n", tid,
+		pthr->priority);
+	pthread_barrier_wait(&barrier);
+	pthread_mutex_lock(glob_mutex);
+	printf("Thread %d at start pthread pol %d pri %d - Got global lock\n",
+		tid, pthr->policy, pthr->priority);
+
+	/* we just use the mutex as something to slow things down,
+	 * say who we are and then do nothing for a while.  The aim
+	 * of this is to show that high priority threads make more
+	 * progress than lower priority threads..
+	 */
+	for (i = 0; i < 1000; i++) {
+		if (i%100 == 0) {
+			printf("Thread %d loop %d pthread pol %d pri %d\n",
+				tid, i, pthr->policy, pthr->priority);
+			fflush(NULL);
+		}
+		pthr->id++;
+		for (j = 0; j < 5000; j++) {
+			pthread_mutex_lock(&(pthr->mutex));
+			pthread_mutex_unlock(&(pthr->mutex));
+		}
+	}
+	pthread_mutex_unlock(glob_mutex);
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
-  printf("Noise Thread started running with prio %d\n", pthr->priority);
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
+		printf("Thread %d: Can't set affinity: %d %s\n", tid, rc,
+			strerror(rc));
+		exit(-1);
+	}
+
+	printf("Noise Thread started running with prio %d\n",
+		pthr->priority);
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < 10000; i++) {
+		if (i%100 == 0) {
+			printf("Noise Thread %d loop %d pthread pol %d "\
+				"pri %d\n", tid, i, pthr->policy,
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
-  printf("Start %s\n", argv[0]);
-
-  glob_mutex = malloc(sizeof(pthread_mutex_t));
-  if (glob_mutex == NULL) {
-     printf("Malloc failed\n");
-     exit(errno);
-  }
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
-    if ((retc = pthread_mutex_init(glob_mutex, &mutexattr)) != 0) {
-      printf("Failed to init mutex: %d\n", retc);
-    }
-  }
-
-  create_other_thread(func_nonrt, NULL);
-  create_rr_thread(func_rt, NULL, 20);
-  create_rr_thread(func_rt, NULL, 30);
-  create_rr_thread(func_rt, NULL, 40);
-  create_rr_thread(func_noise, NULL, 40);
-
-  printf("Joining threads\n");
-  join_threads();
-  printf("Done\n");
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
+		printf("Main Thread: Can't set affinity: %d %s\n", retc,
+			strerror(retc));
+		exit(-1);
+	}
+	for (i = 0; i < argc; i++) {
+		if (strcmp(argv[i], "nopi") == 0)
+			nopi = 1;
+	}
+
+	printf("Start %s\n", argv[0]);
+
+	glob_mutex = malloc(sizeof(pthread_mutex_t));
+	if (glob_mutex == NULL) {
+		printf("Malloc failed\n");
+		exit(errno);
+	}
+
+	if (!nopi) {
+		if (pthread_mutexattr_init(&mutexattr) != 0)
+			printf("Failed to init mutexattr\n");
+
+		if (pthread_mutexattr_setprotocol(&mutexattr,
+			 PTHREAD_PRIO_INHERIT) != 0)
+			printf("Can't set protocol prio inherit\n");
+
+		if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
+			printf("Can't get mutexattr protocol\n");
+		else
+			printf("protocol in mutexattr is %d\n", protocol);
+
+		retc = pthread_mutex_init(glob_mutex, &mutexattr);
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
+
+	return 0;
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
