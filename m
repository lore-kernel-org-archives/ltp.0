From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 19 Feb 2016 11:03:36 +0100
Subject: [LTP] [PATCH 4/5] open_posix: condvar/schedule: remove duplicit
	setsched calls
In-Reply-To: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
References: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
Message-ID: <e1c408557416233afd16fcc2c84fe01f458bacad.1455875648.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

pthread_attr_setschedparam's man page says:
In  order for the parameter setting made by pthread_attr_setschedparam()
to have effect when calling pthread_create(3), the caller must use
pthread_attr_setinheritsched(3) to set the inherit-scheduler attribute
of the attributes object attr to PTHREAD_EXPLICIT_SCHED.

So add PTHREAD_EXPLICIT_SCHED to attr used during pthread_create and
remove duplicit pthread_setsched calls in each thread.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../functional/threads/condvar/pthread_cond_wait_1.c             | 6 ++----
 .../functional/threads/condvar/pthread_cond_wait_2.c             | 6 ++----
 testcases/open_posix_testsuite/functional/threads/schedule/1-1.c | 8 ++++----
 testcases/open_posix_testsuite/functional/threads/schedule/1-2.c | 9 ++++-----
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
index dfbf44bdefd7..a674efc406ef 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
@@ -61,9 +61,7 @@ void *hi_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
-	param.sched_priority = HIGH_PRIORITY;
 
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), POLICY, &param));
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != HIGH_PRIORITY)) {
 		printf("Error: the policy or priority not correct\n");
@@ -99,9 +97,7 @@ void *low_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
-	param.sched_priority = LOW_PRIORITY;
 
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), POLICY, &param));
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != LOW_PRIORITY)) {
 		printf("Error: the policy or priority not correct\n");
@@ -126,6 +122,7 @@ int main()
 
 	/* Create the higher priority thread */
 	SAFE_PFUNC(pthread_attr_init(&high_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&high_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&high_attr, POLICY));
 	param.sched_priority = HIGH_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&high_attr, &param));
@@ -133,6 +130,7 @@ int main()
 
 	/* Create the low priority thread */
 	SAFE_PFUNC(pthread_attr_init(&low_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&low_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&low_attr, POLICY));
 	param.sched_priority = LOW_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&low_attr, &param));
diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
index c5670f8e26fd..398b8db5448e 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
@@ -61,9 +61,7 @@ void *hi_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
-	param.sched_priority = HIGH_PRIORITY;
 
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), POLICY, &param));
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != HIGH_PRIORITY)) {
 		printf("Error: the policy or priority not correct\n");
@@ -99,9 +97,7 @@ void *low_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
-	param.sched_priority = LOW_PRIORITY;
 
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), POLICY, &param));
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if ((policy != POLICY) || (param.sched_priority != LOW_PRIORITY)) {
 		printf("Error: the policy or priority not correct\n");
@@ -126,6 +122,7 @@ int main()
 
 	/* Create the higher priority thread */
 	SAFE_PFUNC(pthread_attr_init(&high_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&high_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&high_attr, POLICY));
 	param.sched_priority = HIGH_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&high_attr, &param));
@@ -133,6 +130,7 @@ int main()
 
 	/* Create the low priority thread */
 	SAFE_PFUNC(pthread_attr_init(&low_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&low_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&low_attr, POLICY));
 	param.sched_priority = LOW_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&low_attr, &param));
diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
index a6b634c7c59d..c65e127bdf5b 100644
--- a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
@@ -70,8 +70,7 @@ void *hi_prio_thread(void *tmp)
 	void *previous_signal;
 
 	(void) tmp;
-	param.sched_priority = HIGH_PRIORITY;
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), SCHED_RR, &param));
+
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if (policy != SCHED_RR || param.sched_priority != HIGH_PRIORITY) {
 		printf("Error: the policy or priority not correct\n");
@@ -104,8 +103,7 @@ void *low_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
-	param.sched_priority = LOW_PRIORITY;
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), SCHED_RR, &param));
+
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if (policy != SCHED_RR || param.sched_priority != LOW_PRIORITY) {
 		printf("Error: the policy or priority not correct\n");
@@ -133,6 +131,7 @@ int main()
 
 	/* Create the higher priority */
 	SAFE_PFUNC(pthread_attr_init(&high_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&high_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&high_attr, SCHED_RR));
 	param.sched_priority = HIGH_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&high_attr, &param));
@@ -140,6 +139,7 @@ int main()
 
 	/* Create the low priority thread */
 	SAFE_PFUNC(pthread_attr_init(&low_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&low_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&low_attr, SCHED_RR));
 	param.sched_priority = LOW_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&low_attr, &param));
diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c b/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
index f7b0bd89e081..c85460e7cf89 100644
--- a/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
@@ -61,8 +61,7 @@ void *hi_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
-	param.sched_priority = HIGH_PRIORITY;
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), SCHED_RR, &param));
+
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if (policy != SCHED_RR) {
 		printf(ERROR_PREFIX "The policy is not correct\n");
@@ -92,8 +91,7 @@ void *low_prio_thread(void *tmp)
 	int policy;
 
 	(void) tmp;
-	param.sched_priority = LOW_PRIORITY;
-	SAFE_PFUNC(pthread_setschedparam(pthread_self(), SCHED_RR, &param));
+
 	SAFE_PFUNC(pthread_getschedparam(pthread_self(), &policy, &param));
 	if (policy != SCHED_RR) {
 		printf(ERROR_PREFIX "Policy not correct\n");
@@ -137,6 +135,7 @@ int main()
 
 	/* create the higher priority */
 	SAFE_PFUNC(pthread_attr_init(&high_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&high_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&high_attr, SCHED_RR));
 	param.sched_priority = HIGH_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&high_attr, &param));
@@ -144,6 +143,7 @@ int main()
 
 	/* Create the low priority thread */
 	SAFE_PFUNC(pthread_attr_init(&low_attr));
+	SAFE_PFUNC(pthread_attr_setinheritsched(&low_attr, PTHREAD_EXPLICIT_SCHED));
 	SAFE_PFUNC(pthread_attr_setschedpolicy(&low_attr, SCHED_RR));
 	param.sched_priority = LOW_PRIORITY;
 	SAFE_PFUNC(pthread_attr_setschedparam(&low_attr, &param));
@@ -156,7 +156,6 @@ int main()
 	}
 
 	SAFE_PFUNC(pthread_mutex_lock(&cond_mutex));
-
 	alarm(2);
 	SAFE_PFUNC(pthread_cond_wait(&cond, &cond_mutex));
 	SAFE_PFUNC(pthread_mutex_unlock(&cond_mutex));
-- 
1.8.3.1

