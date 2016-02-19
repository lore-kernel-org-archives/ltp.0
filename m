From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 19 Feb 2016 11:03:37 +0100
Subject: [LTP] [PATCH 5/5] open_posix: condvar/schedule: mask SIGALRM in
	SCHED_OTHER threads
In-Reply-To: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
References: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
Message-ID: <8f6acea2f6a6b01ebe1749926cbcdbbfd635787a.1455875648.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Kernel can deliver signal to any thread (usually it's the main).
If these tests run on single CPU and signal gets delivered to main
thread with SCHED_OTHER scheduling class then signal handler won't
run until RT thread occupying CPU completes. Which happens after
5 seconds and test fails.

Mask SIGLARM from SCHED_OTHER (main) thread. Kernel will deliver
signal to any of RT threads that can handle it.

Before patch:
  # time taskset -c 0 ./condvar_pthread_cond_wait_1.run-test
  Test FAILED: high priority was not woken up

  real    0m5.003s
  user    0m4.046s
  sys     0m0.007s

After patch:
  # time taskset -c 0 ./condvar_pthread_cond_wait_1.run-test
  Test PASSED

  real    0m2.002s
  user    0m1.967s
  sys     0m0.004s

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../functional/threads/condvar/pthread_cond_wait_1.c         |  4 ++++
 .../functional/threads/condvar/pthread_cond_wait_2.c         |  4 ++++
 .../open_posix_testsuite/functional/threads/schedule/1-1.c   |  4 ++++
 testcases/open_posix_testsuite/include/safe_helpers.h        | 12 ++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
index a674efc406ef..9c92bf79eb7a 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
@@ -61,6 +61,7 @@ void *hi_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
+	safe_adjust_sigmask(SIGALRM, 0);
 
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != HIGH_PRIORITY)) {
@@ -97,6 +98,7 @@ void *low_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
+	safe_adjust_sigmask(SIGALRM, 0);
 
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != LOW_PRIORITY)) {
@@ -120,6 +122,8 @@ int main()
 	pthread_attr_t high_attr, low_attr;
 	struct sched_param param;
 
+	safe_adjust_sigmask(SIGALRM, 1);
+
 	/* Create the higher priority thread */
 	SAFE_PFUNC(pthread_attr_init(&high_attr));
 	SAFE_PFUNC(pthread_attr_setinheritsched(&high_attr, PTHREAD_EXPLICIT_SCHED));
diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
index 398b8db5448e..009e51eeb41b 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
@@ -61,6 +61,7 @@ void *hi_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
+	safe_adjust_sigmask(SIGALRM, 0);
 
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != HIGH_PRIORITY)) {
@@ -97,6 +98,7 @@ void *low_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
+	safe_adjust_sigmask(SIGALRM, 0);
 
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != LOW_PRIORITY)) {
@@ -120,6 +122,8 @@ int main()
 	pthread_attr_t high_attr, low_attr;
 	struct sched_param param;
 
+	safe_adjust_sigmask(SIGALRM, 1);
+
 	/* Create the higher priority thread */
 	SAFE_PFUNC(pthread_attr_init(&high_attr));
 	SAFE_PFUNC(pthread_attr_setinheritsched(&high_attr, PTHREAD_EXPLICIT_SCHED));
diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
index c65e127bdf5b..00ce577f5c16 100644
--- a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
@@ -70,6 +70,7 @@ void *hi_prio_thread(void *tmp)
 	void *previous_signal;
 
 	(void) tmp;
+	safe_adjust_sigmask(SIGALRM, 0);
 
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if (policy != SCHED_RR || param.sched_priority != HIGH_PRIORITY) {
@@ -103,6 +104,7 @@ void *low_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
+	safe_adjust_sigmask(SIGALRM, 0);
 
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if (policy != SCHED_RR || param.sched_priority != LOW_PRIORITY) {
@@ -127,6 +129,8 @@ int main()
 	pthread_attr_t low_attr, high_attr;
 	struct sched_param param;
 
+	safe_adjust_sigmask(SIGALRM, 1);
+
 	SAFE_PFUNC(pthread_barrier_init(&barrier, NULL, 2));
 
 	/* Create the higher priority */
diff --git a/testcases/open_posix_testsuite/include/safe_helpers.h b/testcases/open_posix_testsuite/include/safe_helpers.h
index 655e158f65d0..78ca208ad23e 100644
--- a/testcases/open_posix_testsuite/include/safe_helpers.h
+++ b/testcases/open_posix_testsuite/include/safe_helpers.h
@@ -14,4 +14,16 @@ do {\
 	} \
 } while (0)
 
+void safe_adjust_sigmask(int signal, int block)
+{
+	sigset_t set;
+
+	SAFE_PFUNC(pthread_sigmask(SIG_SETMASK, NULL, &set));
+	if (block)
+		sigaddset(&set, signal);
+	else
+		sigdelset(&set, signal);
+	SAFE_PFUNC(pthread_sigmask(SIG_SETMASK, &set, NULL));
+}
+
 #endif
-- 
1.8.3.1

