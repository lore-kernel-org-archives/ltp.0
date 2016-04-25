From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Mon, 25 Apr 2016 15:41:46 +0800
Subject: [LTP] [PATCH] waitpid/waitpid10: break test if fork failed
In-Reply-To: <20160419130712.GA21282@rei.lan>
References: <20160413071111.GA26897@localhost.localdomain>
 <20160413123625.GD10941@rei.lan>
 <20160414053923.GH17476@localhost.localdomain>
 <20160419130712.GA21282@rei.lan>
Message-ID: <20160425074146.GK17476@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 19, 2016 at 03:07:12PM +0200, Cyril Hrubis wrote:
> Hi!
> > @@ -330,6 +331,8 @@ int main(int ac, char **av)
> >  				}
> >  			}
> >  
> > +			memset(fork_kid_pid, 0, sizeof(fork_kid_pid));
> 
> If you memset the array here the test will fail since it's used in the
> loop below to check the results.
> 
> And looking at the test code it's broken beyond repair. It would likely
> be easier to rewrite it from scratch than trying to fix all problems it
> has.
> 
Thanks. Please have a look at this new patch. Thanks in advance.


From cbb8532924543c7b4b885abe56beaa8f927af33f Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2016 11:25:20 +0800
Subject: [PATCH] waitpid/waitpid10: fix broken test case

Using standard -I option to set runtime and get rid of alarm().
Optimizing the code of children propagating. Change to using
SIGUSR1 for communication between children and parent. Break
test if fork() failed, or a lot of processes will be killed
when -1 passed as pid to kill().

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 runtest/syscalls                              |   2 +-
 testcases/kernel/syscalls/waitpid/waitpid10.c | 355 +++++++++-----------------
 2 files changed, 122 insertions(+), 235 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index ca922e6..106941a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1399,7 +1399,7 @@ waitpid06 waitpid06
 waitpid07 waitpid07
 waitpid08 waitpid08
 waitpid09 waitpid09
-waitpid10 waitpid10 5
+waitpid10 waitpid10 -I 5
 waitpid11 waitpid11
 waitpid12 waitpid12
 waitpid13 waitpid13
diff --git a/testcases/kernel/syscalls/waitpid/waitpid10.c b/testcases/kernel/syscalls/waitpid/waitpid10.c
index 6378ab9..238e9bd 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid10.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid10.c
@@ -33,8 +33,8 @@
  *	kids and remove the directory.
  *
  * USAGE:  <for command-line>
- *      waitpid10 [-c n] [-i n] [-I x] [-P x] [-t]
- *      where,  -c n : Run n copies concurrently.
+ *      waitpid10 [-i n] [-I x] [-P x] [-t]
+ *      where,
  *              -i n : Execute test n times.
  *              -I x : Execute test for x seconds.
  *              -P x : Pause for x seconds between iterations.
@@ -68,13 +68,11 @@
 char *TCID = "waitpid10";
 int TST_TOTAL = 1;
 
-static int alrmintr;
 volatile int intintr;
 
 static void setup(void);
 static void cleanup(void);
 static void inthandlr();
-static void alrmhandlr();
 static void wait_for_parent(void);
 static void do_exit(void);
 static void do_compute(void);
@@ -83,6 +81,7 @@ static void do_sleep(void);
 static void do_mkdir(void);
 
 static int fail;
+static int fork_kid_pid[MAXKIDS];
 
 #ifdef UCLINUX
 static char *argv0;
@@ -92,8 +91,7 @@ int main(int ac, char **av)
 {
 	int kid_count, ret_val, status, nkids;
 	int i, j, k, found;
-	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
-	int runtime;		/* time(sec) to run this process */
+	int wait_kid_pid[MAXKIDS];
 
 	int lc;
 
@@ -109,18 +107,6 @@ int main(int ac, char **av)
 	maybe_run_child(&do_mkdir, "n", 5);
 #endif
 
-	/*
-	 * process the arg -- If there is one arg, it is the
-	 * number of seconds to run.  If there is no arg the program
-	 * defaults to 60 sec runtime.
-	 */
-	if (ac == 2) {
-		if (sscanf(av[1], "%d", &runtime) != 1)
-			tst_resm(TFAIL, "%s is an invalid argument", av[1]);
-	} else {
-		runtime = 60;
-	}
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -128,257 +114,144 @@ int main(int ac, char **av)
 		tst_count = 0;
 		fail = 0;
 
-		if (signal(SIGALRM, alrmhandlr) == SIG_ERR) {
-			tst_resm(TFAIL, "signal SIGALRM failed.  errno = %d",
-				 errno);
-
-		}
-		alrmintr = 0;
-
 		/*
-		 * Set up to catch SIGINT. The kids will wait till a SIGINT
-		 * has been received before they proceed.
+		 * Fork 8 kids. There will be 4 sets of 2 processes
+		 * doing the same thing. Save all kid pid's in an
+		 * array for future use. The kids will first wait for
+		 * the parent to send SIGINT. Then will proceed to
+		 * their assigned tasks.
+		 */
+		kid_count = 0;
+		/*
+		 * Clearing the intinitr flag here for all the children.
+		 * So that we may not miss any signals !
 		 */
-		if (signal(SIGINT, inthandlr) == SIG_ERR) {
-			tst_resm(TFAIL, "signal SIGINT failed.  errno = %d",
-				 errno);
-
-		}
 		intintr = 0;
-
-		/* Turn on the real time interval timer. */
-		if ((alarm(runtime)) < 0)
-			tst_resm(TFAIL, "alarm failed.  errno = %d", errno);
-
-		/* Run the test over and over until the timer expires */
-		for (;;) {
-			if (alrmintr)
-				break;
-
-			/*
-			 * Fork 8 kids. There will be 4 sets of 2 processes
-			 * doing the same thing. Save all kid pid's in an
-			 * array for future use. The kids will first wait for
-			 * the parent to send SIGINT. Then will proceed to
-			 * their assigned tasks.
-			 */
-			kid_count = 0;
-			/*
-			 * Clearing the intinitr flag here for all the children.
-			 * So that we may not miss any signals !
-			 */
-			intintr = 0;
+		for (i = 0; i < MAXKIDS; i++) {
 			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 0 */
-#ifdef UCLINUX
-				if (self_exec(argv0, "n", 1) < 0)
-					tst_resm(TFAIL, "self_exec 0 failed");
-#else
-				do_exit();
-#endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 0 failed. errno = "
-					 "%d", errno);
-
-			}
-
-			/* parent */
-			fork_kid_pid[kid_count++] = ret_val;
+			if (ret_val < 0)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid %d failed.", i);
 
-			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 1 */
+			if (ret_val == 0) {	/* child */
+				if (i == 0 || i == 1) {
 #ifdef UCLINUX
-				if (self_exec(argv0, "n", 1) < 0)
-					tst_resm(TFAIL, "self_exec 1 failed");
+					if (self_exec(argv0, "n", 1) < 0)
+						tst_brkm(TBROK|TERRNO, cleanup,
+							 "self_exec %d failed",
+							 i);
 #else
-				do_exit();
+					do_exit();
 #endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 1 failed. errno = "
-					 "%d", errno);
-
-			}
-
-			/* parent */
-			fork_kid_pid[kid_count++] = ret_val;
+				}
 
-			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 2 */
+				if (i == 2 || i == 3) {
 #ifdef UCLINUX
-				if (self_exec(argv0, "n", 2) < 0)
-					tst_resm(TFAIL, "self_exec 2 failed");
+					if (self_exec(argv0, "n", 2) < 0)
+						tst_brkm(TBROK|TERRNO, cleanup,
+							 "self_exec %d failed",
+							 i);
 #else
-				do_compute();
+					do_compute();
 #endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 2 failed. errno = "
-					 "%d", errno);
-
-			}
-
-			/* parent */
-			fork_kid_pid[kid_count++] = ret_val;
+				}
 
-			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 3 */
+				if (i == 4 || i == 5) {
 #ifdef UCLINUX
-				if (self_exec(argv0, "n", 2) < 0)
-					tst_resm(TFAIL, "self_exec 3 failed");
+					if (self_exec(argv0, "n", 3) < 0)
+						tst_brkm(TBROK|TERRNO, cleanup,
+							 "self_exec %d failed",
+							 i);
 #else
-				do_compute();
+					do_fork();
 #endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 3 failed. errno = "
-					 "%d", errno);
-
-			}
-
-			/* parent */
-			fork_kid_pid[kid_count++] = ret_val;
+				}
 
-			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 4 */
+				if (i == 6 || i == 7) {
 #ifdef UCLINUX
-				if (self_exec(argv0, "n", 3) < 0)
-					tst_resm(TFAIL, "self_exec 4 failed");
+					if (self_exec(argv0, "n", 4) < 0)
+						tst_brkm(TBROK|TERRNO, cleanup,
+							 "self_exec %d failed",
+							 i);
 #else
-				do_fork();
+					do_sleep();
 #endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 4 failed. errno = "
-					 "%d", errno);
-
-			}
 
-			/* parent */
-			fork_kid_pid[kid_count++] = ret_val;
-
-			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 5 */
-#ifdef UCLINUX
-				if (self_exec(argv0, "n", 3) < 0)
-					tst_resm(TFAIL, "self_exec 5 failed");
-#else
-				do_fork();
-#endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 5 failed. errno = "
-					 "%d", errno);
+				}
 
 			}
 
 			/* parent */
 			fork_kid_pid[kid_count++] = ret_val;
+		}
 
-			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 6 */
-#ifdef UCLINUX
-				if (self_exec(argv0, "n", 4) < 0)
-					tst_resm(TFAIL, "self_exec 6 failed");
-#else
-				do_sleep();
-#endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 6 failed. errno = "
-					 "%d", errno);
-
-			}
-
-			/* parent */
-			fork_kid_pid[kid_count++] = ret_val;
+		nkids = kid_count;
 
-			ret_val = FORK_OR_VFORK();
-			if (ret_val == 0) {	/* child 7 */
-#ifdef UCLINUX
-				if (self_exec(argv0, "n", 4) < 0)
-					tst_resm(TFAIL, "self_exec 7 failed");
-#else
-				do_sleep();
-#endif
-			}
-			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 7 failed. errno = "
-					 "%d", errno);
+		/*
+		 * Now send all the kids a SIGUSR1 to tell them to
+		 * proceed. We sleep for a while first to allow the
+		 * children to initialize their "intintr" variables
+		 * and get set up.
+		 */
+		sleep(15);
 
+		for (i = 0; i < nkids; i++) {
+			if (kill(fork_kid_pid[i], SIGUSR1) < 0) {
+				tst_brkm(TBROK|TERRNO, cleanup, "Kill of child "
+						"%d failed", i);
 			}
+		}
 
-			/* parent */
-			fork_kid_pid[kid_count++] = ret_val;
-
-			nkids = kid_count;
-
-			/*
-			 * Now send all the kids a SIGINT to tell them to
-			 * proceed. We sleep for a while first to allow the
-			 * children to initialize their "intintr" variables
-			 * and get set up.
-			 */
-			sleep(15);
-
-			for (i = 0; i < nkids; i++) {
-				if (kill(fork_kid_pid[i], SIGINT) < 0) {
-					tst_resm(TFAIL, "Kill of child %d "
-						 "failed, errno = %d", i,
-						 errno);
-				}
+		/* Wait till all kids have terminated. */
+		kid_count = 0;
+		errno = 0;
+		for (i = 0; i < nkids; i++) {
+			while (((ret_val = waitpid(fork_kid_pid[i],
+							&status, 0)) != -1)
+					|| (errno == EINTR)) {
+				if (ret_val == -1)
+					continue;
+
+				wait_kid_pid[kid_count++] = ret_val;
 			}
+		}
 
-			/* Wait till all kids have terminated. */
-			kid_count = 0;
-			errno = 0;
-			for (i = 0; i < nkids; i++) {
-				while (((ret_val = waitpid(fork_kid_pid[i],
-							   &status, 0)) != -1)
-				       || (errno == EINTR)) {
-					if (ret_val == -1)
-						continue;
-
-					wait_kid_pid[kid_count++] = ret_val;
+		/*
+		 * Check that for every entry in the fork_kid_pid
+		 * array, there is a matching pid in the
+		 * wait_kid_pid array.
+		 */
+		for (i = 0; i < MAXKIDS; i++) {
+			found = 0;
+			for (j = 0; j < MAXKIDS; j++) {
+				if (fork_kid_pid[i] == wait_kid_pid[j]) {
+					found = 1;
+					break;
 				}
 			}
-
-			/*
-			 * Check that for every entry in the fork_kid_pid
-			 * array, there is a matching pid in the
-			 * wait_kid_pid array.
-			 */
-			for (i = 0; i < MAXKIDS; i++) {
-				found = 0;
-				for (j = 0; j < MAXKIDS; j++) {
-					if (fork_kid_pid[i] == wait_kid_pid[j]) {
-						found = 1;
-						break;
-					}
+			if (!found) {
+				tst_resm(TFAIL, "Did not find a "
+						"wait_kid_pid for the "
+						"fork_kid_pid of %d",
+						fork_kid_pid[i]);
+				for (k = 0; k < nkids; k++) {
+					tst_resm(TFAIL,
+							"fork_kid_pid[%d] = "
+							"%d", k,
+							fork_kid_pid[k]);
 				}
-				if (!found) {
-					tst_resm(TFAIL, "Did not find a "
-						 "wait_kid_pid for the "
-						 "fork_kid_pid of %d",
-						 fork_kid_pid[i]);
-					for (k = 0; k < nkids; k++) {
-						tst_resm(TFAIL,
-							 "fork_kid_pid[%d] = "
-							 "%d", k,
-							 fork_kid_pid[k]);
-					}
-					for (k = 0; k < kid_count; k++) {
-						tst_resm(TFAIL,
-							 "wait_kid_pid[%d] = "
-							 "%d", k,
-							 wait_kid_pid[k]);
-					}
-					fail = 1;
+				for (k = 0; k < kid_count; k++) {
+					tst_resm(TFAIL,
+							"wait_kid_pid[%d] = "
+							"%d", k,
+							wait_kid_pid[k]);
 				}
+				fail = 1;
 			}
 		}
 
+		memset(fork_kid_pid, 0, sizeof(fork_kid_pid));
+
 		/* Kill kids and remove file from do_mkdir */
 		rmdir("waitpid14.ttt.ttt");
 
@@ -394,18 +267,32 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	struct sigaction act;
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
+
+	act.sa_handler = inthandlr;
+	act.sa_flags = SA_RESTART;
+	sigemptyset(&act.sa_mask);
+
+	if (sigaction(SIGUSR1, &act, NULL) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup,
+			 "sigaction(SIGUSR1, ...) failed");
+
+	intintr = 0;
+
 }
 
 static void cleanup(void)
 {
-}
+	int i;
 
-static void alrmhandlr(void)
-{
-	alrmintr++;
+	for (i = 0; i < MAXKIDS; i++) {
+		if (fork_kid_pid[i] > 0)
+			kill(fork_kid_pid[i], SIGKILL);
+	}
 }
 
 static void inthandlr(void)
@@ -462,7 +349,7 @@ static void do_fork(void)
 	for (i = 0; i < 50; i++) {
 		fork_pid = FORK_OR_VFORK();
 		if (fork_pid < 0) {
-			tst_brkm(TFAIL, NULL, "Fork failed");
+			tst_brkm(TBROK|TERRNO, NULL, "Fork failed");
 		}
 		if (fork_pid == 0) {
 #ifdef UCLINUX
-- 
1.9.3

