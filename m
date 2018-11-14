From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Nov 2018 13:21:39 +0100
Subject: [LTP] [PATCH] [COMMITTED] containers/pidns13: Fix race between
	threads
Message-ID: <20181114122139.14690-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original code was not thread safe and relied on thread ordering to
run correctly. The problem is that the thread id was passed as a pointer
to a variable that has been changed afterwards, which is obviously not
safe.

So now the code simply casts integer to pointer and back so we pass the
actual value rather than pointer to it, which makes the code simpler and
is race free.

This has been originaly reported in:

https://github.com/linux-test-project/ltp/pull/167

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/containers/pidns/pidns13.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index e8ab7ce60..003bb61ea 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -75,7 +75,7 @@ int child_fn(void *arg)
 	siginfo_t info;
 	struct timespec timeout;
 	pid_t pid, ppid;
-	int cinit_no = *((int *)arg);
+	intptr_t cinit_no = (intptr_t)arg;
 
 	/* Set process id and parent pid */
 	pid = getpid();
@@ -176,7 +176,6 @@ static void setup(void)
 int main(int argc, char *argv[])
 {
 	int status;
-	int *cinit_no = malloc(sizeof(int));
 	pid_t cpid1, cpid2;
 
 	setup();
@@ -186,18 +185,11 @@ int main(int argc, char *argv[])
 		tst_resm(TBROK, "parent: pipe creation failed");
 	}
 
-	/* container creation on PID namespace */
-	if (!cinit_no) {
-		tst_resm(TBROK, "memory allocation failed.");
-	}
-
 	/* Create container 1 */
-	*cinit_no = 1;
-	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, cinit_no);
+	cpid1 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, (void*)(intptr_t)1);
 
 	/* Create container 2 */
-	*cinit_no = 2;
-	cpid2 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, cinit_no);
+	cpid2 = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, (void*)(intptr_t)2);
 	if (cpid1 < 0 || cpid2 < 0) {
 		tst_resm(TBROK, "parent: clone() failed.");
 	}
-- 
2.16.4

