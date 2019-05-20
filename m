From: Sandeep Patil <sspatil@android.com>
Date: Mon, 20 May 2019 12:17:30 +0800
Subject: [LTP] [RFC PATCH 1/1] open_posix_testsuite/pthread_sigmask: fix
	return value checks
In-Reply-To: <20190520041730.28238-1-sspatil@android.com>
References: <20190520041730.28238-1-sspatil@android.com>
Message-ID: <20190520041730.28238-2-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Most posix_ functions return 0 on success and positive errno on failure.
For all incorrect error checks in pthread_sigmask/6-1 test to make sure
we only check against the 0 return value.

Consistently use error(3) and replace all occurences of perror()
at the same time.

Signed-off-by: Sandeep Patil <sspatil@android.com>
---
 .../interfaces/pthread_sigmask/6-1.c          | 69 +++++++++++--------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c
index d2eb1827a..c04069d5d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_sigmask/6-1.c
@@ -27,6 +27,8 @@
       unexpected function failure.
 */
 
+#include <errno.h>
+#include <error.h>
 #include <pthread.h>
 #include <signal.h>
 #include <stdio.h>
@@ -43,6 +45,7 @@ void *a_thread_func()
 {
 	struct sigaction act;
 	sigset_t set1, set2, pending_set;
+	int status;
 
 	sigemptyset(&set1);
 	sigaddset(&set1, SIGABRT);
@@ -55,46 +58,52 @@ void *a_thread_func()
 	act.sa_flags = 0;
 	sigemptyset(&act.sa_mask);
 
-	if (sigaction(SIGABRT, &act, 0) == -1) {
-		perror("Unexpected error while attempting to setup test "
+	status = sigaction(SIGABRT, &act, 0);
+	if (status < 0) {
+		error(0, errno, "Unexpected error while attempting to setup test "
 		       "pre-conditions");
 		pthread_exit((void *)1);
 	}
 
-	if (sigaction(SIGALRM, &act, 0) == -1) {
-		perror("Unexpected error while attempting to setup test "
+	status = sigaction(SIGALRM, &act, 0);
+	if (status < 0) {
+		error(0, errno, "Unexpected error while attempting to setup test "
 		       "pre-conditions");
 		pthread_exit((void *)1);
 	}
 
-	if (pthread_sigmask(SIG_SETMASK, &set1, NULL) == -1) {
-		perror
-		    ("Unexpected error while attempting to use pthread_sigmask.\n");
+	status = pthread_sigmask(SIG_SETMASK, &set1, NULL);
+	if (status != 0) {
+		error(0, status, "Unexpected error while attempting to use "
+			"pthread_sigmask.\n");
 		pthread_exit((void *)1);
 	}
 
-	if (pthread_sigmask(SIG_UNBLOCK, &set2, NULL) == -1) {
-		perror
-		    ("Unexpected error while attempting to use pthread_sigmask.\n");
+	status = pthread_sigmask(SIG_UNBLOCK, &set2, NULL);
+	if (status != 0) {
+		error(0, status, "Unexpected error while attempting to use "
+			"pthread_sigmask.\n");
 		pthread_exit((void *)1);
 	}
 
-	if (raise(SIGALRM) == -1) {
-		perror("Unexpected error while attempting to setup test "
-		       "pre-conditions");
+	status = raise(SIGALRM);
+	if (status != 0) {
+		error(0, errno, "Unexpected error while attempting to setup "
+			"test pre-conditions");
 		pthread_exit((void *)1);
 	}
 
 	if (!handler_called) {
-		printf
-		    ("FAIL: Handler was not called for even though signal was removed from the signal mask\n");
+		printf("FAIL: Handler was not called for even though signal "
+			"was removed from the signal mask\n");
 		pthread_exit((void *)-1);
 	}
 
 	handler_called = 0;
-	if (raise(SIGABRT) == -1) {
-		perror("Unexpected error while attempting to setup test "
-		       "pre-conditions");
+	status = raise(SIGABRT);
+	if (status != 0) {
+		error(0, errno, "Unexpected error while attempting to setup "
+			"test pre-conditions");
 		pthread_exit((void *)1);
 	}
 
@@ -104,18 +113,20 @@ void *a_thread_func()
 		pthread_exit((void *)-1);
 	}
 
-	if (sigpending(&pending_set) == -1) {
-		perror("Unexpected error while attempting to use sigpending\n");
+	status = sigpending(&pending_set);
+	if (status != 0) {
+		error(0, errno, "Unexpected error while attempting to use "
+			"sigpending\n");
 		pthread_exit((void *)1);
 	}
 
 	if (sigismember(&pending_set, SIGABRT) != 1) {
-		perror("FAIL: sigismember did not return 1\n");
+		error(0, errno, "FAIL: sigismember did not return 1\n");
 		pthread_exit((void *)-1);
 	}
 
 	if (sigismember(&pending_set, SIGALRM) != 0) {
-		perror("FAIL: sigismember did not return 0\n");
+		error(0, errno, "FAIL: sigismember did not return 0\n");
 		pthread_exit((void *)-1);
 	}
 
@@ -125,19 +136,19 @@ void *a_thread_func()
 
 int main(void)
 {
-
+	int status;
 	int *thread_return_value;
 
 	pthread_t new_thread;
 
-	if (pthread_create(&new_thread, NULL, a_thread_func, NULL) != 0) {
-		perror("Error creating new thread\n");
-		return PTS_UNRESOLVED;
+	status = pthread_create(&new_thread, NULL, a_thread_func, NULL);
+	if (status != 0) {
+		error(PTS_UNRESOLVED, status, "Error creating new thread\n");
 	}
 
-	if (pthread_join(new_thread, (void *)&thread_return_value) != 0) {
-		perror("Error in pthread_join()\n");
-		return PTS_UNRESOLVED;
+	status = pthread_join(new_thread, (void *)&thread_return_value);
+	if (status != 0) {
+		error(PTS_UNRESOLVED, status, "Error in pthread_join()\n");
 	}
 
 	if ((long)thread_return_value != 0) {
-- 
2.21.0.1020.gf2820cf01a-goog

