From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:32 +0100
Subject: [LTP] [PATCH 03/18] hugeshmctl01: Fix synchronisation with child
	processes
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-4-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

hugeshmctl01 spawns child processes to perform shm operations and uses
signal (SIGUSR1) to communicate the completion of test 1, to the
children waiting at sigprocmask(). However, there is no guarantee that a
child has reached sigprocmask() before the parent issues a SIGUSR1 and
things go wrong.

This patch fixes this issue by 'stopping' the children, waiting for all
of them and then issuing SIGCONT to communicate the completion.

While we are at it, also handle unknown signals as a hint to exit the
test with TBROK.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   | 56 +++++++---------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index ad7a80d70..37a8a0d6f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -141,6 +141,7 @@ void *set_shmat(void)
  */
 static void stat_setup(void)
 {
+	int status;
 	int i, rval;
 	void *test;
 	pid_t pid;
@@ -150,10 +151,10 @@ static void stat_setup(void)
 	memset (&sa, '\0', sizeof(sa));
 	sa.sa_handler = sighandler;
 	sa.sa_flags = 0;
-	TEST(sigaction(SIGUSR1, &sa, NULL));
+	TEST(sigaction(SIGCONT, &sa, NULL));
 	if (TEST_RETURN == -1)
 		tst_brk(TBROK | TRERRNO,
-				"SIGSEGV signal setup failed");
+				"SIGCONT signal setup failed");
 	/*
 	 * The first time through, let the children attach the memory.
 	 * The second time through, attach the memory first and let
@@ -168,21 +169,6 @@ static void stat_setup(void)
 		set_shared = set_shmat();
 	}
 
-	/*
-	 * Block SIGUSR1 before children pause for a signal
-	 * Doing so to avoid the risk that the parent cleans up
-	 * children by calling stat_cleanup() before children call
-	 * call pause() so that children sleep forever(this is a
-	 * side effect of the arbitrary usleep time below).
-	 * In FIRST, children call shmat. If children sleep forever,
-	 * those attached shm can't be released so some other shm
-	 * tests will fail a lot.
-	 */
-	sigemptyset(&newmask);
-	sigaddset(&newmask, SIGUSR1);
-	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0)
-		tst_brk(TBROK | TERRNO, "block SIGUSR1 error");
-
 	for (i = 0; i < N_ATTACH; i++) {
 		switch (pid = SAFE_FORK()) {
 		case 0:
@@ -191,22 +177,8 @@ static void stat_setup(void)
 			/* do an assignement for fun */
 			*(int *)test = i;
 
-			/*
-			 * sigsuspend until we get a signal from stat_cleanup()
-			 * use sigsuspend instead of pause to avoid children
-			 * infinite sleep without getting SIGUSR1 from parent
-			 */
-			rval = sigsuspend(&oldmask);
-			if (rval != -1)
-				tst_brk(TBROK | TERRNO, "sigsuspend");
-
-			/*
-			 * don't have to block SIGUSR1 any more,
-			 * recover the mask
-			 */
-			if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-				tst_brk(TBROK | TERRNO,
-					 "child sigprocmask");
+			/* Wait until the parent cleans up after the first test */
+			raise(SIGSTOP);
 
 			/* now we're back - detach the memory and exit */
 			if (shmdt(test) == -1)
@@ -219,11 +191,15 @@ static void stat_setup(void)
 		}
 	}
 
-	/* parent doesn't have to block SIGUSR1, recover the mask */
-	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-		tst_brk(TBROK, "parent sigprocmask");
-
-	usleep(250000);
+	/*
+	 * Wait for the children process to stop after they have touched
+	 * shm.
+	 */
+	for (i = 0; i < N_ATTACH; i++) {
+		SAFE_WAITPID(pid_arr[i], &status, WUNTRACED);
+		if (!WIFSTOPPED(status))
+			tst_brk(TBROK, "pid %d didn't stop", pid_arr[i]);
+	}
 }
 
 /*
@@ -287,7 +263,7 @@ static void stat_cleanup(void)
 
 	/* wake up the childern so they can detach the memory and exit */
 	for (i = 0; i < N_ATTACH; i++)
-		SAFE_KILL(pid_arr[i], SIGUSR1);
+		SAFE_KILL(pid_arr[i], SIGCONT);
 
 	/* remove the parent's shared memory the second time through */
 	if (stat_time == SECOND)
@@ -298,7 +274,7 @@ static void stat_cleanup(void)
 
 static void sighandler(int sig)
 {
-	if (sig != SIGUSR1)
+	if (sig != SIGCONT)
 		tst_res(TFAIL, "received unexpected signal %d", sig);
 }
 
-- 
2.14.2

