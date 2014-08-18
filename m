Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gary.robertson@linaro.org>) id 1XJSN9-0005lW-8u
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 19:13:39 +0000
Received: from mail-oa0-f44.google.com ([209.85.219.44])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XJSN7-0004Vf-68
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 19:13:39 +0000
Received: by mail-oa0-f44.google.com with SMTP id eb12so4439535oac.31
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Aug 2014 12:13:27 -0700 (PDT)
From: "Gary S. Robertson" <gary.robertson@linaro.org>
Date: Mon, 18 Aug 2014 14:12:56 -0500
Message-Id: <1408389176-20141-1-git-send-email-gary.robertson@linaro.org>
Subject: [LTP] [PATCH] Realtime tests: Ensure mutexes initialized statically
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

From: "Gary S. Robertson" <gary.robertson@linaro.org>

In a cross-development environment, build-time configuration may result in
the lib/librttest function 'init_pi_mutex' being built as an empty
function even though priority inheritence is supported on the test target
system upon which the test code will execute. (NOTE that several pi-tests
depending on 'init-pi-mutex' still build and execute even though this
function as compiled performs no inititalization.)

This leaves mutexes un-initialized if they rely on this function for
proper initialization... so they should be at least initialized to default
values when they are defined, in order to prevent possible program faults
resulting from attempts to use them in an un-initialized state.

With this patch, the pi-tests run to completion and return failure results
if the conditionally-compiled code is missing in 'init-pi-mutex'.

Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
---
 .../realtime/func/async_handler/async_handler.c    |    2 +-
 .../func/async_handler/async_handler_tsc.c         |    2 +-
 testcases/realtime/func/pi-tests/testpi-1.c        |    2 +-
 testcases/realtime/func/pi-tests/testpi-2.c        |    2 +-
 testcases/realtime/func/pi-tests/testpi-4.c        |   20 +++++++-------------
 testcases/realtime/func/pi-tests/testpi-7.c        |    4 ++--
 testcases/realtime/func/pi_perf/pi_perf.c          |    2 +-
 testcases/realtime/func/prio-wake/prio-wake.c      |    2 +-
 .../realtime/perf/latency/pthread_cond_many.c      |    2 +-
 .../realtime/stress/pi-tests/lookup_pi_state.c     |    6 +++---
 10 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/testcases/realtime/func/async_handler/async_handler.c b/testcases/realtime/func/async_handler/async_handler.c
index 3c1bfdd..e61fa71 100644
--- a/testcases/realtime/func/async_handler/async_handler.c
+++ b/testcases/realtime/func/async_handler/async_handler.c
@@ -60,7 +60,7 @@ static int iterations = 0;
 atomic_t step;
 
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
-pthread_mutex_t mutex;
+pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static int ret = 0;
 
diff --git a/testcases/realtime/func/async_handler/async_handler_tsc.c b/testcases/realtime/func/async_handler/async_handler_tsc.c
index c51a3b4..bb554b9 100644
--- a/testcases/realtime/func/async_handler/async_handler_tsc.c
+++ b/testcases/realtime/func/async_handler/async_handler_tsc.c
@@ -68,7 +68,7 @@ int over_30 = 0;
 atomic_t step;
 
 pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
-pthread_mutex_t mutex;
+pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 
 void usage(void)
 {
diff --git a/testcases/realtime/func/pi-tests/testpi-1.c b/testcases/realtime/func/pi-tests/testpi-1.c
index 3dbe292..4adcf5a 100644
--- a/testcases/realtime/func/pi-tests/testpi-1.c
+++ b/testcases/realtime/func/pi-tests/testpi-1.c
@@ -74,7 +74,7 @@ int gettid(void)
 }
 
 typedef void *(*entrypoint_t) (void *);
-pthread_mutex_t glob_mutex;
+pthread_mutex_t glob_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_cond_t cond_var = PTHREAD_COND_INITIALIZER;
 
diff --git a/testcases/realtime/func/pi-tests/testpi-2.c b/testcases/realtime/func/pi-tests/testpi-2.c
index 3f7185e..b22935f 100644
--- a/testcases/realtime/func/pi-tests/testpi-2.c
+++ b/testcases/realtime/func/pi-tests/testpi-2.c
@@ -76,7 +76,7 @@ int gettid(void)
 }
 
 typedef void *(*entrypoint_t) (void *);
-pthread_mutex_t glob_mutex;
+pthread_mutex_t glob_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_cond_t cond_var = PTHREAD_COND_INITIALIZER;
 
diff --git a/testcases/realtime/func/pi-tests/testpi-4.c b/testcases/realtime/func/pi-tests/testpi-4.c
index e9e0ed6..7c44111 100644
--- a/testcases/realtime/func/pi-tests/testpi-4.c
+++ b/testcases/realtime/func/pi-tests/testpi-4.c
@@ -75,7 +75,7 @@ int gettid(void)
 }
 
 typedef void *(*entrypoint_t) (void *);
-pthread_mutex_t *glob_mutex;
+pthread_mutex_t glob_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t cond_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_cond_t cond_var = PTHREAD_COND_INITIALIZER;
 
@@ -86,7 +86,7 @@ void *func_nonrt(void *arg)
 
 	printf("Thread %d started running with priority %d\n", tid,
 	       pthr->priority);
-	pthread_mutex_lock(glob_mutex);
+	pthread_mutex_lock(&glob_mutex);
 	printf("Thread %d at start pthread pol %d pri %d - Got global lock\n",
 	       tid, pthr->policy, pthr->priority);
 
@@ -106,7 +106,7 @@ void *func_nonrt(void *arg)
 		}
 		busy_work_ms(1);
 	}
-	pthread_mutex_unlock(glob_mutex);
+	pthread_mutex_unlock(&glob_mutex);
 	return NULL;
 }
 
@@ -117,7 +117,7 @@ void *func_rt(void *arg)
 
 	printf("Thread %d started running with prio %d\n", tid, pthr->priority);
 	pthread_barrier_wait(&barrier);
-	pthread_mutex_lock(glob_mutex);
+	pthread_mutex_lock(&glob_mutex);
 	printf("Thread %d at start pthread pol %d pri %d - Got global lock\n",
 	       tid, pthr->policy, pthr->priority);
 
@@ -134,7 +134,7 @@ void *func_rt(void *arg)
 		}
 		busy_work_ms(1);
 	}
-	pthread_mutex_unlock(glob_mutex);
+	pthread_mutex_unlock(&glob_mutex);
 	return NULL;
 }
 
@@ -198,14 +198,8 @@ int main(int argc, char *argv[])
 
 	printf("Start %s\n", argv[0]);
 
-	glob_mutex = malloc(sizeof(pthread_mutex_t));
-	if (glob_mutex == NULL) {
-		printf("Malloc failed\n");
-		exit(errno);
-	}
-
 	if (!nopi)
-		init_pi_mutex(glob_mutex);
+		init_pi_mutex(&glob_mutex);
 
 	create_other_thread(func_nonrt, NULL);
 	create_rr_thread(func_rt, NULL, 20);
@@ -217,7 +211,7 @@ int main(int argc, char *argv[])
 	join_threads();
 	printf("Done\n");
 
-	pthread_mutex_destroy(glob_mutex);
+	pthread_mutex_destroy(&glob_mutex);
 	pthread_mutex_destroy(&cond_mutex);
 	pthread_cond_destroy(&cond_var);
 
diff --git a/testcases/realtime/func/pi-tests/testpi-7.c b/testcases/realtime/func/pi-tests/testpi-7.c
index e9e286d..ce222a3 100644
--- a/testcases/realtime/func/pi-tests/testpi-7.c
+++ b/testcases/realtime/func/pi-tests/testpi-7.c
@@ -55,7 +55,7 @@ static int use_flag_mutex;
 static int max_delay_us;
 static int max_drop2grab_us;
 
-static pthread_mutex_t pi_mutex;
+static pthread_mutex_t pi_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 // flagging details
 typedef enum {
@@ -69,7 +69,7 @@ typedef enum {
 
 static volatile phase_t phase_flag = END_OF_CYCLE;
 
-static pthread_mutex_t flag_mutex;
+static pthread_mutex_t flag_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 int med_threads = 0;
 long iterations = ITERATIONS;
diff --git a/testcases/realtime/func/pi_perf/pi_perf.c b/testcases/realtime/func/pi_perf/pi_perf.c
index daa7643..8f370b7 100644
--- a/testcases/realtime/func/pi_perf/pi_perf.c
+++ b/testcases/realtime/func/pi_perf/pi_perf.c
@@ -63,7 +63,7 @@
 #define THRESHOLD 200		/* microseconds */
 
 pthread_barrier_t bar1, bar2;
-pthread_mutex_t lock;
+pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
 
 static int end = 0;
 
diff --git a/testcases/realtime/func/prio-wake/prio-wake.c b/testcases/realtime/func/prio-wake/prio-wake.c
index 18c0405..f8c8de5 100644
--- a/testcases/realtime/func/prio-wake/prio-wake.c
+++ b/testcases/realtime/func/prio-wake/prio-wake.c
@@ -60,7 +60,7 @@ volatile int running_threads = 0;
 static int rt_threads = 0;
 static int locked_broadcast = 1;
 static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
-static pthread_mutex_t mutex;
+static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 static volatile nsec_t beginrun;
 
 static int ret = 0;
diff --git a/testcases/realtime/perf/latency/pthread_cond_many.c b/testcases/realtime/perf/latency/pthread_cond_many.c
index 1d39100..4146241 100644
--- a/testcases/realtime/perf/latency/pthread_cond_many.c
+++ b/testcases/realtime/perf/latency/pthread_cond_many.c
@@ -47,7 +47,7 @@
 #include <librttest.h>
 #include <libstats.h>
 #define PASS_US 100
-pthread_mutex_t child_mutex;
+pthread_mutex_t child_mutex = PTHREAD_MUTEX_INITIALIZER;
 volatile int *child_waiting = NULL;
 double endtime;
 pthread_cond_t *condlist = NULL;
diff --git a/testcases/realtime/stress/pi-tests/lookup_pi_state.c b/testcases/realtime/stress/pi-tests/lookup_pi_state.c
index d1575dc..5869c99 100644
--- a/testcases/realtime/stress/pi-tests/lookup_pi_state.c
+++ b/testcases/realtime/stress/pi-tests/lookup_pi_state.c
@@ -39,9 +39,9 @@
 #define NUM_SLAVES 20
 #define SLAVE_PRIO 89
 
-pthread_mutex_t MM;
-pthread_mutex_t MS;
-pthread_mutex_t MT;
+pthread_mutex_t MM = PTHREAD_MUTEX_INITIALIZER;
+pthread_mutex_t MS = PTHREAD_MUTEX_INITIALIZER;
+pthread_mutex_t MT = PTHREAD_MUTEX_INITIALIZER;
 pthread_cond_t CM;
 pthread_cond_t CS;
 pthread_cond_t CT;
-- 
1.7.9.5


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
