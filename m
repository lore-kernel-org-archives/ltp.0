From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 19 Apr 2021 16:16:47 +0800
Subject: [LTP] [PATCH] openposix: Add '\n' at the end of printf
Message-ID: <20210419081647.25941-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need to add '\n' at the end of printf, or the print string
may be orderless with error output.

For all of the files of dir testcases/open_posix_testsuite/*
which referenced.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../conformance/interfaces/fork/19-1.c                 |  6 +++---
 .../conformance/interfaces/localtime/1-1.c             |  2 +-
 .../pthread_attr_setschedparam/speculative/3-2.c       |  2 +-
 .../interfaces/pthread_barrier_destroy/2-1.c           |  2 +-
 .../conformance/interfaces/pthread_barrier_init/4-1.c  |  2 +-
 .../conformance/interfaces/pthread_barrier_wait/1-1.c  |  2 +-
 .../conformance/interfaces/pthread_barrier_wait/2-1.c  |  2 +-
 .../conformance/interfaces/pthread_barrier_wait/3-1.c  |  2 +-
 .../conformance/interfaces/pthread_barrier_wait/3-2.c  |  2 +-
 .../interfaces/pthread_barrierattr_getpshared/1-1.c    |  2 +-
 .../interfaces/pthread_barrierattr_getpshared/2-1.c    |  2 +-
 .../interfaces/pthread_barrierattr_init/1-1.c          |  2 +-
 .../interfaces/pthread_barrierattr_init/2-1.c          |  2 +-
 .../interfaces/pthread_mutex_getprioceiling/1-1.c      |  2 +-
 .../interfaces/pthread_mutex_getprioceiling/3-1.c      |  2 +-
 .../interfaces/pthread_mutex_getprioceiling/3-2.c      |  2 +-
 .../interfaces/pthread_mutex_getprioceiling/3-3.c      |  2 +-
 .../interfaces/pthread_mutex_setprioceiling/1-1.c      |  2 +-
 .../interfaces/pthread_mutexattr_setpshared/2-1.c      |  2 +-
 .../interfaces/pthread_mutexattr_setpshared/3-1.c      |  2 +-
 .../interfaces/pthread_mutexattr_setpshared/3-2.c      |  2 +-
 .../conformance/interfaces/pthread_rwlock_rdlock/1-1.c |  2 +-
 .../conformance/interfaces/pthread_rwlock_rdlock/2-1.c |  2 +-
 .../conformance/interfaces/pthread_rwlock_rdlock/2-2.c |  2 +-
 .../conformance/interfaces/pthread_rwlock_rdlock/2-3.c |  2 +-
 .../conformance/interfaces/pthread_rwlock_rdlock/5-1.c |  4 ++--
 .../interfaces/pthread_rwlock_timedrdlock/5-1.c        |  2 +-
 .../interfaces/pthread_rwlock_timedrdlock/6-2.c        | 10 +++++-----
 .../interfaces/pthread_rwlock_timedwrlock/5-1.c        |  2 +-
 .../interfaces/pthread_rwlock_timedwrlock/6-2.c        |  8 ++++----
 .../conformance/interfaces/pthread_rwlock_unlock/3-1.c |  2 +-
 .../interfaces/pthread_rwlockattr_setpshared/1-1.c     |  2 +-
 .../conformance/interfaces/pthread_spin_destroy/1-1.c  |  2 +-
 .../conformance/interfaces/pthread_spin_lock/1-2.c     |  2 +-
 .../conformance/interfaces/pthread_spin_unlock/1-1.c   |  2 +-
 .../conformance/interfaces/pthread_spin_unlock/1-2.c   |  2 +-
 .../conformance/interfaces/pthread_spin_unlock/3-1.c   |  2 +-
 .../conformance/interfaces/sched_setparam/1-1.c        |  2 +-
 .../conformance/interfaces/sched_setparam/20-1.c       |  8 ++++----
 .../conformance/interfaces/sched_setparam/21-1.c       |  8 ++++----
 .../conformance/interfaces/sched_setparam/21-2.c       |  8 ++++----
 .../conformance/interfaces/sched_setscheduler/15-1.c   |  8 ++++----
 .../conformance/interfaces/sched_setscheduler/15-2.c   |  8 ++++----
 .../conformance/interfaces/sched_setscheduler/22-1.c   |  8 ++++----
 .../conformance/interfaces/sched_setscheduler/22-2.c   |  8 ++++----
 .../conformance/interfaces/shm_unlink/11-1.c           |  2 +-
 .../conformance/interfaces/sigismember/4-1.c           |  2 +-
 .../conformance/interfaces/sigwait/4-1.c               |  4 ++--
 .../conformance/interfaces/testfrmw/testfrmw.c         |  4 ++--
 testcases/open_posix_testsuite/include/noatime.h       |  2 +-
 .../stress/threads/fork/testfrmw.c                     |  2 +-
 testcases/open_posix_testsuite/stress/threads/helper.c |  2 +-
 .../stress/threads/pthread_cancel/testfrmw.c           |  2 +-
 .../stress/threads/pthread_cond_wait/testfrmw.c        |  2 +-
 .../stress/threads/pthread_create/testfrmw.c           |  2 +-
 .../stress/threads/pthread_exit/testfrmw.c             |  2 +-
 .../stress/threads/pthread_getschedparam/testfrmw.c    |  2 +-
 .../stress/threads/pthread_kill/testfrmw.c             |  2 +-
 .../stress/threads/pthread_mutex_trylock/testfrmw.c    |  2 +-
 .../stress/threads/pthread_once/testfrmw.c             |  2 +-
 .../stress/threads/pthread_self/testfrmw.c             |  2 +-
 .../stress/threads/sem_getvalue/testfrmw.c             |  2 +-
 .../stress/threads/sem_init/testfrmw.c                 |  2 +-
 .../stress/threads/sem_open/testfrmw.c                 |  2 +-
 64 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/19-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/19-1.c
index f4c642813..071db60cd 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/19-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/19-1.c
@@ -95,7 +95,7 @@ int main(void)
 	if (mqa.mq_curmsgs != 1) {
 		mq_close(mq);
 		mq_unlink(queue_name);
-		printf("The queue information does not show the new message");
+		printf("The queue information does not show the new message\n");
 		return PTS_UNRESOLVED;
 	}

@@ -153,7 +153,7 @@ int main(void)
 	if (!WIFEXITED(status) || (WEXITSTATUS(status) != PTS_PASS)) {
 		mq_close(mq);
 		mq_unlink(queue_name);
-		printf("Child exited abnormally");
+		printf("Child exited abnormally\n");
 		return PTS_FAIL;
 	}

@@ -170,7 +170,7 @@ int main(void)
 	if (mqa.mq_curmsgs != 0) {
 		mq_close(mq);
 		mq_unlink(queue_name);
-		printf("The message received in child was not dequeued.");
+		printf("The message received in child was not dequeued.\n");
 		return PTS_FAIL;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/localtime/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/localtime/1-1.c
index 93a646024..96300dde1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/localtime/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/localtime/1-1.c
@@ -24,7 +24,7 @@ int main(void)
 	timeptr = localtime(&current_time);

 	if (timeptr != NULL) {
-		printf("date: %s", (asctime(localtime((&current_time)))));
+		printf("date: %s, ", (asctime(localtime((&current_time)))));
 		puts("Test PASSED");
 		return PTS_PASS;
 	} else {
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/3-2.c
index 189209117..c06c372fa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/speculative/3-2.c
@@ -19,7 +19,7 @@
 #include "posixtest.h"

 #define TEST "3-2"
-#define FUNCTION "pthread_attr_setschedpaarm"
+#define FUNCTION "pthread_attr_setschedparam"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "

 #define RRPOLICY SCHED_RR
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c
index 161cc4653..93e8c648f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_destroy/2-1.c
@@ -53,7 +53,7 @@ static void *fn_chld(void *arg)
 	else if (rc != 0)
 		perror("child: pthread_barrier_wait");
 	else
-		printf("child: pthread_barrier_wait returned success");
+		printf("child: pthread_barrier_wait returned success\n");

 	thread_state = EXITING_THREAD;
 	return arg;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c
index a0815e21f..301eb1053 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_init/4-1.c
@@ -114,7 +114,7 @@ int main(void)
 	rc = pthread_barrier_init(&barrier, NULL, 2);

 	if (rc == EBUSY) {
-		printf("main: pthread_barrier_init() correctly got EBUSY");
+		printf("main: pthread_barrier_init() correctly got EBUSY\n");
 		printf("Test PASSED\n");
 	} else {
 		printf("main: got return code: %d, %s\n", rc, strerror(rc));
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c
index bd169c53f..1951a0880 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/1-1.c
@@ -139,7 +139,7 @@ int main(void)
 	}

 	if (pthread_barrier_destroy(&barrier) != 0) {
-		printf("Error at pthread_barrier_destroy()");
+		printf("Error at pthread_barrier_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c
index 327ac1d9a..e279bcc82 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c
@@ -112,7 +112,7 @@ int main(void)
 	}

 	if (pthread_barrier_destroy(&barrier) != 0) {
-		printf("Error at pthread_barrier_destroy()");
+		printf("Error at pthread_barrier_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c
index 22674ed57..0460e8cca 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-1.c
@@ -169,7 +169,7 @@ int main(void)
 	}

 	if (pthread_barrier_destroy(&barrier) != 0) {
-		printf("Error at pthread_barrier_destroy()");
+		printf("Error at pthread_barrier_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c
index 1fc612585..5b99055d0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/3-2.c
@@ -161,7 +161,7 @@ int main(void)
 	}

 	if (pthread_barrier_destroy(&barrier) != 0) {
-		printf("Error at pthread_barrier_destroy()");
+		printf("Error at pthread_barrier_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/1-1.c
index bf8708aa6..b1a99a4c2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/1-1.c
@@ -49,7 +49,7 @@ int main(void)
 	rc = pthread_barrierattr_destroy(&ba);
 	if (rc != 0) {
 		printf("Error at pthread_barrierattr_destroy() "
-		       "return code: %d, %s", rc, strerror(rc));
+		       "return code: %d, %s\n", rc, strerror(rc));
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
index ac1f4835f..a21a5a507 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
@@ -198,7 +198,7 @@ int main(void)

 		/* Cleanup */
 		if (pthread_barrier_destroy(barrier) != 0) {
-			printf("Error at pthread_barrier_destroy()");
+			printf("Error at pthread_barrier_destroy()\n");
 			return PTS_UNRESOLVED;
 		}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/1-1.c
index b031a15f3..e42496edb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/1-1.c
@@ -53,7 +53,7 @@ int main(void)
 	rc = pthread_barrierattr_destroy(&ba);
 	if (rc != 0) {
 		printf("Error at pthread_barrierattr_destroy() "
-		       "return code: %d, %s", rc, strerror(rc));
+		       "return code: %d, %s\n", rc, strerror(rc));
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/2-1.c
index 9342339a4..612759686 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_init/2-1.c
@@ -50,7 +50,7 @@ int main(void)
 	rc = pthread_barrierattr_destroy(&ba);
 	if (rc != 0) {
 		printf("Error at pthread_barrierattr_destroy() "
-		       "return code: %d, %s", rc, strerror(rc));
+		       "return code: %d, %s\n", rc, strerror(rc));
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
index 9b3a60654..017d1c00d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/1-1.c
@@ -71,7 +71,7 @@ int main(void)
 	printf("Prioceiling returned: %d\n", prioceiling);
 	return PTS_PASS;
 #else
-	printf("pthread_mutex_getprioceiling not supported");
+	printf("pthread_mutex_getprioceiling not supported\n");
 	return PTS_UNSUPPORTED;
 #endif

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c
index 1b8d7360e..ba92e5d7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-1.c
@@ -65,7 +65,7 @@ int main(void)

 	return (error == EINVAL ? PTS_PASS : PTS_FAIL);
 #else
-	printf("pthread_mutex_getprioceiling not supported");
+	printf("pthread_mutex_getprioceiling not supported\n");
 	return PTS_UNSUPPORTED;
 #endif

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c
index 98449bfe4..e75cbaa64 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-2.c
@@ -78,7 +78,7 @@ int main(void)

 	return (error == EINVAL ? PTS_PASS : PTS_FAIL);
 #else
-	printf("pthread_mutex_getprioceiling not supported");
+	printf("pthread_mutex_getprioceiling not supported\n");
 	return PTS_UNSUPPORTED;
 #endif

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
index bdfed508f..b1f459435 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
@@ -80,7 +80,7 @@ int main(void)

 	return (error == EINVAL ? PTS_PASS : PTS_UNRESOLVED);
 #else
-	printf("pthread_mutex_getprioceiling not supported");
+	printf("pthread_mutex_getprioceiling not supported\n");
 	return PTS_UNSUPPORTED;
 #endif

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/1-1.c
index 12b6cec03..5aa1113c4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_setprioceiling/1-1.c
@@ -71,7 +71,7 @@ int main(void)
 	printf("Prioceiling returned: %d\n", prioceiling);
 	return PTS_PASS;
 #else
-	printf("pthread_mutex_getprioceiling not supported");
+	printf("pthread_mutex_getprioceiling not supported\n");
 	return PTS_UNSUPPORTED;
 #endif

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/2-1.c
index d22c5db85..614471042 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/2-1.c
@@ -42,7 +42,7 @@ int main(void)
 	/* Set the attribute to PTHREAD_PROCESS_PRIVATE.  */
 	ret = pthread_mutexattr_setpshared(&mta, PTHREAD_PROCESS_PRIVATE);
 	if (ret != 0) {
-		printf("Test FAILED: Expected return code 0, got: %d", ret);
+		printf("Test FAILED: Expected return code 0, got: %d\n", ret);
 		return PTS_FAIL;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-1.c
index 49b16d0fd..0db84c4f2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-1.c
@@ -44,7 +44,7 @@ int main(void)
 			return PTS_PASS;
 		}

-		printf("Test FAILED: Expected return code 0 or EINVAL, got: %d",
+		printf("Test FAILED: Expected return code 0 or EINVAL, got: %d\n",
 		       ret);
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-2.c
index bdaccb571..27abbd00e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/3-2.c
@@ -47,7 +47,7 @@ int main(void)
 			return PTS_PASS;
 		}

-		printf("Test FAILED: Expected return code 0 or EINVAL, got: %d",
+		printf("Test FAILED: Expected return code 0 or EINVAL, got: %d\n",
 		       ret);
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c
index facdacd94..724ecc390 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/1-1.c
@@ -177,7 +177,7 @@ int main(void)
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_rwlockattr_destroy()");
+		printf("Error at pthread_rwlockattr_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c
index a2e8b8f4e..288eb3e35 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-1.c
@@ -260,7 +260,7 @@ int main(void)
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_rwlockattr_destroy()");
+		printf("Error at pthread_rwlockattr_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-2.c
index d51a0659f..3593e4c79 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-2.c
@@ -259,7 +259,7 @@ int main(void)
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_rwlockattr_destroy()");
+		printf("Error at pthread_rwlockattr_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-3.c
index 605ffd12a..40170dbb2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/2-3.c
@@ -245,7 +245,7 @@ int main(void)
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_rwlockattr_destroy()");
+		printf("Error at pthread_rwlockattr_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/5-1.c
index 70f06afc8..a37b06793 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock/5-1.c
@@ -46,14 +46,14 @@ int main(void)
 	for (i = 0; i < COUNT; i++) {
 		if (pthread_rwlock_unlock(&rwlock) != 0) {
 			printf
-			    ("Test FAILED: main cannot unlock rwlock number %d",
+			    ("Test FAILED: main cannot unlock rwlock number %d\n",
 			     i);
 			return PTS_FAIL;
 		}
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_rwlockattr_destroy()");
+		printf("Error at pthread_rwlockattr_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c
index ae541ffc3..da48575ef 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/5-1.c
@@ -74,7 +74,7 @@ static void *fn_rd_1(void *arg PTS_ATTRIBUTE_UNUSED)
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("thread1: Error at pthread_rwlockattr_destroy()");
+		printf("thread1: Error at pthread_rwlockattr_destroy()\n");
 		exit(PTS_UNRESOLVED);
 	}
 	thread_state = EXITING_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c
index 7ba2aa91f..d3f812b4f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedrdlock/6-2.c
@@ -106,10 +106,10 @@ static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 		printf("thread: correctly acquired read lock\n");
 		expired = 0;
 	} else if (rc == ETIMEDOUT) {
-		printf("thread: timer expired, did not acquire read lock");
+		printf("thread: timer expired, did not acquire read lock\n");
 		expired = 1;
 	} else {
-		printf("Error at pthread_rwlock_timedrdlock()");
+		printf("Error at pthread_rwlock_timedrdlock()\n");
 		exit(PTS_UNRESOLVED);
 	}

@@ -155,7 +155,7 @@ int main(void)

 	printf("main: fire SIGUSR1 to thread\n");
 	if (pthread_kill(sig_thread, SIGUSR1) != 0) {
-		printf("Error in pthread_kill()");
+		printf("Error in pthread_kill()\n");
 		exit(PTS_UNRESOLVED);
 	}

@@ -206,12 +206,12 @@ int main(void)
 	}

 	if (pthread_join(sig_thread, NULL) != 0) {
-		printf("Error at pthread_join()");
+		printf("Error at pthread_join()\n");
 		return PTS_UNRESOLVED;
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_destroy()");
+		printf("Error at pthread_destroy()\n");
 		exit(PTS_UNRESOLVED);
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c
index 3d9086a83..53a192fbb 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/5-1.c
@@ -81,7 +81,7 @@ static void *fn_wr_1(void *arg PTS_ATTRIBUTE_UNUSED)
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("thread1: Error at pthread_rwlockattr_destroy()");
+		printf("thread1: Error at pthread_rwlockattr_destroy()\n");
 		exit(PTS_UNRESOLVED);
 	}
 	thread_state = EXITING_THREAD;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c
index a976f48bd..e9949f855 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_timedwrlock/6-2.c
@@ -106,7 +106,7 @@ static void *th_fn(void *arg PTS_ATTRIBUTE_UNUSED)
 		printf("thread: correctly acquired write lock\n");
 		expired = 0;
 	} else if (rc == ETIMEDOUT) {
-		printf("thread: timer expired, did not acquire write lock");
+		printf("thread: timer expired, did not acquire write lock\n");
 		expired = 1;
 	} else {
 		printf("Error %d at pthread_rwlock_timedwrlock()\n", rc);
@@ -155,7 +155,7 @@ int main(void)

 	printf("main: fire SIGUSR1 to thread\n");
 	if (pthread_kill(sig_thread, SIGUSR1) != 0) {
-		printf("Error in pthread_kill()");
+		printf("Error in pthread_kill()\n");
 		exit(PTS_UNRESOLVED);
 	}

@@ -206,12 +206,12 @@ int main(void)
 	}

 	if (pthread_join(sig_thread, NULL) != 0) {
-		printf("Error at pthread_join()");
+		printf("Error at pthread_join()\n");
 		return PTS_UNRESOLVED;
	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_destroy()");
+		printf("Error at pthread_destroy()\n");
 		exit(PTS_UNRESOLVED);
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/3-1.c
index 2a7b6b477..81d9ec43f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_unlock/3-1.c
@@ -365,7 +365,7 @@ int main(void)
 	}

 	if (pthread_rwlock_destroy(&rwlock) != 0) {
-		printf("Error at pthread_rwlockattr_destroy()");
+		printf("Error at pthread_rwlockattr_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/1-1.c
index 63a0892e4..171accf95 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlockattr_setpshared/1-1.c
@@ -78,7 +78,7 @@ int main(void)
 	}

 	if (pthread_rwlockattr_destroy(&rwla) != 0) {
-		printf("Error at pthread_rwlockattr_destroy()");
+		printf("Error at pthread_rwlockattr_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/1-1.c
index f9e7b2230..1d7395b22 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_destroy/1-1.c
@@ -56,7 +56,7 @@ int main(void)
 	printf("main: destroy spin lock\n");
 	rc = pthread_spin_destroy(&spinlock);
 	if (rc != 0) {
-		printf("Test FAILED: Error at pthread_spin_destroy()"
+		printf("Test FAILED: Error at pthread_spin_destroy(), "
 		       "Return code : %d\n", rc);
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/1-2.c
index 6541051dd..10c7961f2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_lock/1-2.c
@@ -142,7 +142,7 @@ int main(void)

 	/* Destroy the spinlock */
 	if (pthread_spin_destroy(&spinlock) != 0) {
-		printf("Error at pthread_spin_destroy()");
+		printf("Error at pthread_spin_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c
index c20567840..44772d9a3 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-1.c
@@ -118,7 +118,7 @@ int main(void)
 	}

 	if (pthread_spin_destroy(&spinlock) != 0) {
-		printf("Error at pthread_spin_destroy()");
+		printf("Error at pthread_spin_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-2.c
index 5f714127a..43f75e45e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/1-2.c
@@ -137,7 +137,7 @@ int main(void)
 	}

 	if (pthread_spin_destroy(&spinlock) != 0) {
-		printf("Error at pthread_spin_destroy()");
+		printf("Error at pthread_spin_destroy()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/3-1.c
index 409da6368..0a52cd8f4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_spin_unlock/3-1.c
@@ -66,7 +66,7 @@ static void *fn_chld(void *arg)
 	pthread_spin_unlock(&spinlock);

 	if (pthread_spin_destroy(&spinlock) != 0) {
-		printf("Error at pthread_spin_destroy()");
+		printf("Error@pthread_spin_destroy()\n");
 		exit(PTS_UNRESOLVED);
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c
index 13292c2df..954179201 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/1-1.c
@@ -106,7 +106,7 @@ int main(void)
 		result = sched_setparam(child_pid, &param);

 		if (result == 0 && param.sched_priority == new_priority) {
-			printf("Test PASSED");
+			printf("Test PASSED\n");
 			kill(child_pid, SIGUSR1);
 			return PTS_PASS;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c
index f198b8052..d323c1ff9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/20-1.c
@@ -46,7 +46,7 @@ int main(void)
 	    sched_get_priority_min(policy) : max_priority;

 	if (pthread_attr_init(&attr) != 0) {
-		printf("An error occurs when calling pthread_attr_init()");
+		printf("An error occurs when calling pthread_attr_init()\n");
 		return PTS_UNRESOLVED;
 	}
 	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);
@@ -54,11 +54,11 @@ int main(void)
 		printf("Process contention scope threads are not supported.\n");
 		return PTS_UNSUPPORTED;
 	} else if (result != 0) {
-		printf("An error occurs when calling pthread_attr_setscope()");
+		printf("An error occurs when calling pthread_attr_setscope()\n");
 		return PTS_UNRESOLVED;
 	}
 	if (pthread_create(&tid, &attr, runner, NULL) != 0) {
-		printf("An error occurs when calling pthread_create()");
+		printf("An error occurs when calling pthread_create()\n");
 		return PTS_UNRESOLVED;
 	}

@@ -69,7 +69,7 @@ int main(void)
 	}

 	if (pthread_getschedparam(tid, &policy, &param) != 0) {
-		printf("An error occurs when calling pthread_getschedparam()");
+		printf("An error occurs when calling pthread_getschedparam()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c
index 6e8a7b3b1..b03526e50 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-1.c
@@ -50,7 +50,7 @@ int main(void)
 	}

 	if (pthread_attr_init(&attr) != 0) {
-		printf("An error occurs when calling pthread_attr_init()");
+		printf("An error occurs when calling pthread_attr_init()\n");
 		return PTS_UNRESOLVED;
 	}
 	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);
@@ -58,16 +58,16 @@ int main(void)
 		printf("Process contention scope threads are not supported.\n");
 		return PTS_UNSUPPORTED;
 	} else if (result != 0) {
-		printf("An error occurs when calling pthread_attr_setscope()");
+		printf("An error occurs when calling pthread_attr_setscope()\n");
 		return PTS_UNRESOLVED;
 	}
 	if (pthread_create(&tid, &attr, runner, NULL) != 0) {
-		printf("An error occurs when calling pthread_create()");
+		printf("An error occurs when calling pthread_create()\n");
 		return PTS_UNRESOLVED;
 	}

 	if (pthread_getschedparam(tid, &policy, &param) != 0) {
-		printf("An error occurs when calling pthread_getschedparam()");
+		printf("An error occurs when calling pthread_getschedparam()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c
index ae75f186a..afe03e9ae 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/21-2.c
@@ -50,7 +50,7 @@ int main(void)
 	}

 	if (pthread_attr_init(&attr) != 0) {
-		printf("An error occurs when calling pthread_attr_init()");
+		printf("An error occurs when calling pthread_attr_init()\n");
 		return PTS_UNRESOLVED;
 	}
 	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);
@@ -58,16 +58,16 @@ int main(void)
 		printf("Process contention scope threads are not supported.\n");
 		return PTS_UNSUPPORTED;
 	} else if (result != 0) {
-		printf("An error occurs when calling pthread_attr_setscope()");
+		printf("An error occurs when calling pthread_attr_setscope()\n");
 		return PTS_UNRESOLVED;
 	}
 	if (pthread_create(&tid, &attr, runner, NULL) != 0) {
-		printf("An error occurs when calling pthread_create()");
+		printf("An error occurs when calling pthread_create()\n");
 		return PTS_UNRESOLVED;
 	}

 	if (pthread_getschedparam(tid, &policy, &param) != 0) {
-		printf("An error occurs when calling pthread_getschedparam()");
+		printf("An error occurs when calling pthread_getschedparam()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-1.c
index 11035ad09..a7324e8db 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-1.c
@@ -40,7 +40,7 @@ int main(void)
 	    SCHED_RR : SCHED_FIFO;

 	if (pthread_attr_init(&attr) != 0) {
-		printf("An error occurs when calling pthread_attr_init()");
+		printf("An error occurs when calling pthread_attr_init()\n");
 		return PTS_UNRESOLVED;
 	}
 	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);
@@ -48,11 +48,11 @@ int main(void)
 		printf("Process contention scope threads are not supported.\n");
 		return PTS_UNSUPPORTED;
 	} else if (result != 0) {
-		printf("An error occurs when calling pthread_attr_setscope()");
+		printf("An error occurs when calling pthread_attr_setscope()\n");
 		return PTS_UNRESOLVED;
 	}
 	if (pthread_create(&tid, &attr, runner, NULL) != 0) {
-		printf("An error occurs when calling pthread_create()");
+		printf("An error occurs when calling pthread_create()\n");
 		return PTS_UNRESOLVED;
 	}

@@ -68,7 +68,7 @@ int main(void)
 	}

 	if (pthread_getschedparam(tid, &policy, &param) != 0) {
-		printf("An error occurs when calling pthread_getschedparam()");
+		printf("An error occurs when calling pthread_getschedparam()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-2.c
index 24421f556..5fa6f7099 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/15-2.c
@@ -46,7 +46,7 @@ int main(void)
 	    sched_get_priority_min(SCHED_FIFO) : max_priority;

 	if (pthread_attr_init(&attr) != 0) {
-		printf("An error occurs when calling pthread_attr_init()");
+		printf("An error occurs when calling pthread_attr_init()\n");
 		return PTS_UNRESOLVED;
 	}
 	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);
@@ -54,11 +54,11 @@ int main(void)
 		printf("Process contention scope threads are not supported.\n");
 		return PTS_UNSUPPORTED;
 	} else if (result != 0) {
-		printf("An error occurs when calling pthread_attr_setscope()");
+		printf("An error occurs when calling pthread_attr_setscope()\n");
 		return PTS_UNRESOLVED;
 	}
 	if (pthread_create(&tid, &attr, runner, NULL) != 0) {
-		printf("An error occurs when calling pthread_create()");
+		printf("An error occurs when calling pthread_create()\n");
 		return PTS_UNRESOLVED;
 	}

@@ -74,7 +74,7 @@ int main(void)
 	}

 	if (pthread_getschedparam(tid, &policy, &param) != 0) {
-		printf("An error occurs when calling pthread_getschedparam()");
+		printf("An error occurs when calling pthread_getschedparam()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-1.c
index e9103c19b..7eb3109d7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-1.c
@@ -56,7 +56,7 @@ int main(void)
 	}

 	if (pthread_attr_init(&attr) != 0) {
-		printf("An error occurs when calling pthread_attr_init()");
+		printf("An error occurs when calling pthread_attr_init()\n");
 		return PTS_UNRESOLVED;
 	}
 	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);
@@ -64,16 +64,16 @@ int main(void)
 		printf("Process contention scope threads are not supported.\n");
 		return PTS_UNSUPPORTED;
 	} else if (result != 0) {
-		printf("An error occurs when calling pthread_attr_setscope()");
+		printf("An error occurs when calling pthread_attr_setscope()\n");
 		return PTS_UNRESOLVED;
 	}
 	if (pthread_create(&tid, &attr, runner, NULL) != 0) {
-		printf("An error occurs when calling pthread_create()");
+		printf("An error occurs when calling pthread_create()\n");
 		return PTS_UNRESOLVED;
 	}

 	if (pthread_getschedparam(tid, &policy, &param) != 0) {
-		printf("An error occurs when calling pthread_getschedparam()");
+		printf("An error occurs when calling pthread_getschedparam()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-2.c
index 1d5fdf5d7..83c8c599c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/22-2.c
@@ -55,7 +55,7 @@ int main(void)
 	}

 	if (pthread_attr_init(&attr) != 0) {
-		printf("An error occurs when calling pthread_attr_init()");
+		printf("An error occurs when calling pthread_attr_init()\n");
 		return PTS_UNRESOLVED;
 	}
 	result = pthread_attr_setscope(&attr, PTHREAD_SCOPE_PROCESS);
@@ -63,16 +63,16 @@ int main(void)
 		printf("Process contention scope threads are not supported.\n");
 		return PTS_UNSUPPORTED;
 	} else if (result != 0) {
-		printf("An error occurs when calling pthread_attr_setscope()");
+		printf("An error occurs when calling pthread_attr_setscope()\n");
 		return PTS_UNRESOLVED;
 	}
 	if (pthread_create(&tid, &attr, runner, NULL) != 0) {
-		printf("An error occurs when calling pthread_create()");
+		printf("An error occurs when calling pthread_create()\n");
 		return PTS_UNRESOLVED;
 	}

 	if (pthread_getschedparam(tid, &policy, &param) != 0) {
-		printf("An error occurs when calling pthread_getschedparam()");
+		printf("An error occurs when calling pthread_getschedparam()\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/11-1.c
index 1d92e44f4..6d0ff515b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/11-1.c
@@ -35,7 +35,7 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}

-	printf("shm_unlink() success.");
+	printf("shm_unlink() success.\n");
 	return PTS_FAIL;

 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigismember/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigismember/4-1.c
index 5dfad8dce..51bcb5b4c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigismember/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigismember/4-1.c
@@ -24,7 +24,7 @@ int main(void)
 	}

 	if (sigismember(&signalset, SIGABRT) != 0) {
-		printf("sigismember dit not return 0");
+		printf("sigismember dit not return 0\n");
 		return PTS_FAIL;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/4-1.c
index 1c79b2829..461902040 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigwait/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigwait/4-1.c
@@ -49,7 +49,7 @@ int main(void)

 	/* Read clock */
 	if (gettimeofday(&tv_ref, NULL) != 0) {
-		printf("Failed to get time of day");
+		printf("Failed to get time of day\n");
 		return PTS_UNRESOLVED;
 	}

@@ -65,7 +65,7 @@ int main(void)

 	/* Re-read clock */
 	if (gettimeofday(&tv_cur, NULL) != 0) {
-		printf("Failed to get time of day");
+		printf("Failed to get time of day\n");
 		return PTS_UNRESOLVED;
 	}

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
index 5b3bc7fb8..433ed70a7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/testfrmw/testfrmw.c
@@ -51,9 +51,9 @@ static void output(char *string, ...)
 	nw = time(NULL);
 	now = localtime(&nw);
 	if (now == NULL)
-		printf("[??:??:??]");
+		printf("[??:??:??]\n");
 	else
-		printf("[%2.2d:%2.2d:%2.2d]",
+		printf("[%2.2d:%2.2d:%2.2d]\n",
 		       now->tm_hour, now->tm_min, now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/include/noatime.h b/testcases/open_posix_testsuite/include/noatime.h
index 43e8bcbe0..781267e4c 100644
--- a/testcases/open_posix_testsuite/include/noatime.h
+++ b/testcases/open_posix_testsuite/include/noatime.h
@@ -79,7 +79,7 @@ int mounted_noatime(const char *path)
 	struct statfs _statfs;

 	if (statfs(path, &_statfs) == -1) {
-		printf("statfs for %s failed: %s", path, strerror(errno));
+		printf("statfs for %s failed: %s\n", path, strerror(errno));
 		return -1;
 	}

diff --git a/testcases/open_posix_testsuite/stress/threads/fork/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/fork/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/fork/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/fork/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/helper.c b/testcases/open_posix_testsuite/stress/threads/helper.c
index 295c96753..a36d08f5e 100644
--- a/testcases/open_posix_testsuite/stress/threads/helper.c
+++ b/testcases/open_posix_testsuite/stress/threads/helper.c
@@ -165,7 +165,7 @@ int main(int argc, char *argv[])
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	if (!WIFEXITED(status)) {
 		printf("The stress sample did not exit\n");
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_cancel/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_cancel/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_cancel/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_cancel/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_cond_wait/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_cond_wait/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_cond_wait/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_cond_wait/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_create/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_create/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_create/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_create/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_exit/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_exit/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_exit/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_exit/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_kill/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_kill/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_kill/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_kill/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_once/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_once/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_once/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_once/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_self/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/pthread_self/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/pthread_self/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/pthread_self/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/sem_getvalue/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/sem_getvalue/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/sem_getvalue/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/sem_getvalue/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/sem_init/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/sem_init/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/sem_init/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/sem_init/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
diff --git a/testcases/open_posix_testsuite/stress/threads/sem_open/testfrmw.c b/testcases/open_posix_testsuite/stress/threads/sem_open/testfrmw.c
index 3bd4d5376..ce3cbb473 100644
--- a/testcases/open_posix_testsuite/stress/threads/sem_open/testfrmw.c
+++ b/testcases/open_posix_testsuite/stress/threads/sem_open/testfrmw.c
@@ -56,7 +56,7 @@ static void output(char *string, ...)
 	if (now == NULL)
 		printf(ts);
 	else
-		printf("[%2.2d:%2.2d:%2.2d]", now->tm_hour, now->tm_min,
+		printf("[%2.2d:%2.2d:%2.2d]\n", now->tm_hour, now->tm_min,
 		       now->tm_sec);
 	va_start(ap, string);
 	vprintf(string, ap);
--
2.17.1

