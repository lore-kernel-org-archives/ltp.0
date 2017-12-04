From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:46 +0000
Subject: [LTP] [PATCH v3 03/12] hugeshmctl01: Convert to LTP synchronisation
	primitives
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-4-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hugeshmctl01 spawns child processes to perform shm operations and uses
signal (SIGUSR1) to communicate the completion of test 1, to the
children waiting at sigprocmask(). However, there is no guarantee that a
child has reached sigprocmask() before the parent issues a SIGUSR1 and
things go wrong.

Fix this by migrating hugeshmctl to LTP synchronisation primitives
TST_CHECKPOINT_{WAIT,WAKE,WAIT2} and removing the code that was used for
signals based synchronisation.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   | 72 ++++------------------
 1 file changed, 12 insertions(+), 60 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index 248065d2f..78a642973 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -55,9 +55,7 @@ static struct shmid_ds buf;
 static time_t save_time;
 static int stat_time;
 static void *set_shared;
-static pid_t pid_arr[N_ATTACH];
 
-static void sighandler(int sig);
 static void stat_setup(void);
 static void stat_cleanup(void);
 static void set_setup(void);
@@ -140,19 +138,10 @@ void *set_shmat(void)
  */
 static void stat_setup(void)
 {
-	int i, rval;
+	int i;
 	void *test;
 	pid_t pid;
-	sigset_t newmask, oldmask;
-	struct sigaction sa;
-
-	memset (&sa, '\0', sizeof(sa));
-	sa.sa_handler = sighandler;
-	sa.sa_flags = 0;
-	TEST(sigaction(SIGUSR1, &sa, NULL));
-	if (TEST_RETURN == -1)
-		tst_brk(TBROK | TRERRNO,
-				"SIGSEGV signal setup failed");
+
 	/*
 	 * The first time through, let the children attach the memory.
 	 * The second time through, attach the memory first and let
@@ -167,21 +156,6 @@ static void stat_setup(void)
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
@@ -190,39 +164,20 @@ static void stat_setup(void)
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
+			TST_CHECKPOINT_WAKE(0);
+
+			TST_CHECKPOINT_WAIT(1);
 
 			/* now we're back - detach the memory and exit */
 			if (shmdt(test) == -1)
 				tst_brk(TBROK | TERRNO,
 					 "shmdt in stat_setup()");
+
 			exit(0);
 		default:
-			/* save the child's pid for cleanup later */
-			pid_arr[i] = pid;
+			TST_CHECKPOINT_WAIT(0);
 		}
 	}
-
-	/* parent doesn't have to block SIGUSR1, recover the mask */
-	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-		tst_brk(TBROK, "parent sigprocmask");
-
-	usleep(250000);
 }
 
 /*
@@ -282,11 +237,13 @@ fail:
  */
 static void stat_cleanup(void)
 {
-	int i;
+	int i, status;
 
 	/* wake up the childern so they can detach the memory and exit */
+	TST_CHECKPOINT_WAKE2(1, N_ATTACH);
+
 	for (i = 0; i < N_ATTACH; i++)
-		SAFE_KILL(pid_arr[i], SIGUSR1);
+		SAFE_WAIT(&status);
 
 	/* remove the parent's shared memory the second time through */
 	if (stat_time == SECOND)
@@ -295,12 +252,6 @@ static void stat_cleanup(void)
 	stat_time++;
 }
 
-static void sighandler(int sig)
-{
-	if (sig != SIGUSR1)
-		tst_res(TFAIL, "received unexpected signal %d", sig);
-}
-
 /*
  * set_setup() - set up for the IPC_SET command with shmctl()
  */
@@ -385,4 +336,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_hugeshmctl,
+	.needs_checkpoints = 1,
 };
-- 
2.15.0

